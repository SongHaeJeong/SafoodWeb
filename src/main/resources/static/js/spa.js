var boardComp = Vue.component('boardcomp', {
    template: '#board_template',
    data() {
        return {

        }
    },

    mounted() {

    },

    methods: {

    }
});

var foodsComp = Vue.component('listhrm', {
    template: '#foods_template',
    data() {
        return {

        }
    },

    mounted() {
    },

    methods: {

    }
});

const routerMain = new VueRouter({
    routes: [
        { path: '/', component: foodsComp },
        { path: '/foods', component: foodsComp },
        { path: '/board/qna', name: 'qna', component: boardComp }
    ]
});

var vm = new Vue({
    el: "#content_router",
    data: {
        currentPage: 'foods'
    },
    watch: {
        currentPage: function() {

        }
    },
    router: routerMain
});
