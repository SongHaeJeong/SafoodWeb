var listhrm = Vue.component('listhrm', {
    template: '#board-template',
    data() {
        return {
            result: [],
            qid: '',
            userid: '${user.id}',
            title: '',
            wdate: '',
            content: '',
            data: '',
            type: 'title'
        }
    },

    mounted() {
        this.allBoardList()
    },

    methods: {
        allBoardList: function () {
            axios
                .get('http://localhost:12345/api/lists')
                .then(response => {
                this.result = response.data
                })
        },

        deleteQuestion: function (val) {
            axios
                .delete('http://localhost:12345/api/lists/' + (val))
                .then(response => {
                    this.allBoardList();

                })
        },

        search: function () {
            if (this.data == '') {
                this.allBoardList();
            } else if (this.data != '') {
                axios
                    .get('http://localhost:12345/api/search/' + this.type + '/' + this.data)
                    .then(response => {
                        this.result = response.data
                    })
            }

        },

        loginCheck: function () {
            console.log(this.userid);
            if (this.userid == '') {
                alert("로그인 해주세요");
            } else {
                router.push('/addQuestion');
            }


        }

    }

});

var detailhrm = Vue.component('detailhrm', {
    template: "#detailQuestion",
    data() {
        return {
            result: [],
            qid: '',
            title: '',
            userid: '',
            wdate: '',
            content: '',
            aid: '',
            acontent: '',
            awdate: '',
            qaid: '',

        }
    },
    mounted() {
        this.qid = this.$route.params.qid;
        axios
            .get('http://localhost:12345/api/lists/' + this.qid)
            .then(response => {

                this.title = response.data.title;
                this.userid = response.data.userid;
                this.wdate = response.data.wdate;
                this.content = response.data.content;
            })
        this.allAnswerList()
    },

    methods: {

        allAnswerList: function () {
            axios
                .get('http://localhost:12345/api/answers/' + this.qid)
                .then(response => {
                this.result = response.data
                })
        },

        addAnswer: function () {
            axios
                .post('http://localhost:12345/api/answers', {
                    acontent: this.acontent,
                    qaid: this.qid
                })

                .then(response => {
                    this.acontent = "";
                    this.allAnswerList()
                })
        },

        deleteAnswer: function (val) {
            axios
                .delete('http://localhost:12345/api/answers/' + (val))
                .then(response => {
                    this.allAnswerList()
                })
        }
    }
});


var addhrm = Vue.component('addhrm', {
    template: '#addQuestion',
    data() {
        return {
            result: [],
            userid: '${user.id}',
            title: '',
            content: ''
        }
    },

    methods: {
        addQuestion: function () {
            axios
                .post('http://localhost:12345/api/lists', {
                    userid: this.userid, title: this.title, content: this.content
                })
                .then(response => {
                    router.push('/');

                })
        }


    }
});


var updatehrm = Vue.component('updatehrm', {
    template: '#updateQuestion',
    data() {
        return {
            result: [],
            qid: '',
            title: '',
            content: ''
        }
    },

    mounted() {
        this.qid = this.$route.params.qid;
        axios
            .get('http://localhost:12345/api/lists/' + this.qid)
            .then(response => {
                this.title = response.data.title;
                this.content = response.data.content;
            })

    },

    methods: {
        updateQuestion: function () {
            axios
                .put('http://localhost:12345/api/lists', {
                    qid: this.qid, title: this.title, content: this.content
                })
                .then(response => {
                    router.push('/');
                })
        }
    }
});

/* var idhrm = Vue.component('idhrm',{
    template: '#idhrmtemplate'
});
var detailhrm = Vue.component('detailhrm',{
    template: '#detailtemplate'
});
var namehrm = Vue.component('namehrm',{
    template: '#namehrmtemplate'
});
});		 */


const router = new VueRouter({
    routes: [
        { path: '/', component: listhrm },
        { path: '/addQuestion', component: addhrm },
        { path: '/updateQuestion/:qid', name: 'updateQuestion', component: updatehrm },
        { path: '/detailQuestion/:qid', name: 'detailQuestion', component: detailhrm }
    ]
});


var vm = new Vue({
    el: "#app",
    data: {
        mod_qid: '',
        mod_title: '',
        mod_content: ''
    },
    router

});
