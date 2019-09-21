const HeaderMenu = {
    template: '<div class="header-nav"><a href="" class="header-nav__logo"></a><nav class="menu">'
        + '<a v-for="item in menu" href="" class="menu__item">{{item.name}}</a>'
        + '</nav></div>',
    props: ['menu'],
};
const HeaderUser = {
    template: '<div class="user mr-20">' +
                  '<span class="user-login" v-if="!authorized" @click="toggleForm">Войти</span>'+
                  '<div v-if="authorized" class="user__text">' +
                        'Привет, {{user.name}} (<span @click="logout" class="user__logout color-highlight">выйти</span>)' +
                  '</div>' +
                  '<div v-if="!authorized" v-show="visible" class="auth-menu">' +
                     '<input class="auth-menu__input" type="text" v-model="name" placeholder="Логин">' +
                     '<input class="auth-menu__input" type="password" v-model="pass" placeholder="Пароль">' +
                     '<button class="auth-menu__button" @click="authorize">Отправить</button>' +
                  '</div>' +
              '</div>',
    props: ['text', 'authorized', 'user', 'visible'],
    data() {
        return {
            name: '',
            pass: '',
        };
    },
    methods: {
        toggleForm: function() {
            this.$emit('toggle');
        },
        authorize: function() {
            this.$emit('authsend', this.name, this.pass);
        },
        logout: function() {
            this.$emit('logout');
        }
    }
};
const HeaderBasket = {
    template: '<div class="basket"><div class="basket__text">Корзина({{count}})</div></div>',
    props: ['count'],
};
const FilterSelect = {
    template: '<div class="selector-category"><ul class="category-drop" v-bind:class="{active:unfold}">'
        +'<li v-for="option in options" @click="selectOpt(option.id)">{{option.name}}</li>'
    +'</ul>'
    +'<p class="selector-value" @click="unfold=!unfold">{{title}}</p>'
    +'<div class="category-triangle" @click="unfold=!unfold" v-bind:class="{rotate:unfold}"></div></div>',
    props: ['options', 'title', 'selected'],
    data() {
        return {
            unfold: false,
        };
    },
    methods: {
        selectOpt: function(id) {
            this.unfold = false;
            this.$emit('select', id);
        },
    }
};
const CatalogItems = {
    template: '<div v-if="items.length">'
          +'<div class="goods__wrapper">'
            +'<div v-for="item in items" class="goods__item">'
                +'<div class="goods__border">'
                    +'<img class="goods__photo" v-bind:src="\'http://nordic.local/catalog\'+item.image" alt="">'
                +'</div>'
                +'<p class="goods__name">{{item.name}}</p>'
                +'<p class="goods__cost">{{item.price}} руб.</p>'
            +'</div>'
          +'</div>'
        +'</div>'
        +'<div v-else>'
          +'<h2 class="no-items">Товары не найдены</h2>'
        +'</div>',
    props: ['items'],
};
const FooterMenu = {
    template: '<div class="footer__block">' +
                  '<h2 class="footer__title">КОЛЛЕКЦИИ</h2>' +
                  '<a v-for="item in menu" class="footer__link" href="">{{item.name}}</a>' +
              '</div>',
    props: ['menu'],
};

let menuApiUrl       = '/catalog/api/menu.php';

let userApiUrl       = '/catalog/api/user.php';
let authApiUrl       = '/catalog/api/auth.php';
let logoutApiUrl     = '/catalog/api/logout.php';

let categoriesApiUrl = '/catalog/api/category.php';
let sizeApiUrl       = '/catalog/api/size.php';
let priceApiUrl      = '/catalog/api/price.php';
let catalogApiUrl    = '/catalog/api/catalog.php';

const app = new Vue({
    el: '#app',
    components: {
        'header-menu': HeaderMenu,
        'footer-menu': FooterMenu,

        'header-user': HeaderUser,
        'header-basket': HeaderBasket,

        'filter-category': FilterSelect,
        'filter-size': FilterSelect,
        'filter-cost': FilterSelect,

        'catalog-items': CatalogItems,
    },
    data() {
        return {
            headerMenuData: [],
            footerMenuData: [],

            userAuthorized: false,
            userObj: {name:''},
            authFormVisible: false,

            catOptions: [],
            catTitle: 'Категория',
            catSelected: 0,

            sizeOptions: [],
            sizeTitle: 'Размер',
            sizeSelected: 0,

            costOptions: [],
            costTitle: 'Стоимость',
            costSelected: 0,

            catalogItems: [],
            basketCount: 0,
        };
    },
    methods: {
        categorySelect(id) {
            this.catSelected = id;
            axios.get(sizeApiUrl+'?category='+id).then(response => this.sizeOptions = response.data);
            this.sizeSelected = 0;
            this.updateCatalog();
        },
        sizeSelect(id) {
            this.sizeSelected = id;
            this.updateCatalog();
        },
        costSelect(id) {
            this.costSelected = id;
            this.updateCatalog();
        },
        updateCatalog() {
            let apiUrl = catalogApiUrl
                + '?category=' + this.catSelected
                + '&size=' + this.sizeSelected
                + '&cost=' + this.costSelected;

            axios.get(apiUrl).then(response => this.catalogItems = response.data);
        },
        authorizeUser(login, password) {
            let that = this;
            axios.get(authApiUrl + '?login=' + login + '&password=' + password).then(function(response){
                if (response.data) {
                    that.authFormVisible = false;
                    that.userObj = response.data;
                    that.userAuthorized = true;
                }
            });
        },
        logoutUser() {
            let that = this;
            axios.get(logoutApiUrl).then(function(response) {
                if (response.data) {
                    that.userObj = {name: ''};
                    that.userAuthorized = false;
                }
            });
        },
        toggleAuthForm() {
            this.authFormVisible = !this.authFormVisible;
        }
    },
    mounted: function() {
        let that = this;
        axios.get(menuApiUrl).then(function(response){
            that.headerMenuData = response.data.header;
            that.footerMenuData = response.data.footer;
        });
        axios.get(userApiUrl).then(function(response){
            if (response.data) {
                that.userObj = response.data;
                that.userAuthorized = true;
            }
        });
        axios.get(categoriesApiUrl).then(response => this.catOptions = response.data);
        axios.get(sizeApiUrl).then(response => this.sizeOptions = response.data);
        axios.get(priceApiUrl).then(response => this.costOptions = response.data);

        this.updateCatalog();
    }
});
