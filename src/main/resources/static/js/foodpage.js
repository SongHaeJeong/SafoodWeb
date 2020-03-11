/* Vue */
Vue.component('foodcard', {
    template: '#foodcard-template',
    props: {
        code: Number,
        name: String,
        material: String,
        imgurl: String,
        servingUnit: Number,
        nutrition: Array
    },
    data() {
        return {
            bounds: [
                {low: 30, high: 500, low_text: '저열량', high_text: '고열량'},
                {low: 8, high: 70, low_text: '저탄수화물', high_text: '고탄수화물'},
                {low: 1, high: 8, low_text: '저단백', high_text: '고단백'},
                {low: 1, high: 20, low_text: '저지방', high_text: '고지방'},
                {low: 5, high: 33, low_text: '저당도', high_text: '고당도'},
                {low: 100, high: 900, low_text: '저나트륨', high_text: '고나트륨'},
                {low: 3, high: 20, low_text: '저콜레스테롤', high_text: '고콜레스테롤'},
                {low: 1, high: 5, low_text: '저포화지방', high_text: '고포화지방'},
                {low: -1, high: 0.15, low_text: '저트랜스지방', high_text: '고트랜스지방'},
            ],
            tag_lows: [],
            tag_highs: []            
        }
    },
    mounted () {
        this.tag_lows = this.nutrition.map((nutri, idx) => {
            if (nutri <= this.bounds[idx].low)
                return true;
        });
        this.tag_highs = this.nutrition.map((nutri, idx) => {
            if (nutri >= this.bounds[idx].high)
                return true;
        })

    },
    methods: {
        checkEaten: function () {
            var userId = foodListMain.userId;
            if (userId == '') {
                alert('로그인이 필요합니다.');
                location.href="main.safood";
            }
            var data = {
                code: this.code
            };
            axios
                .post('http://localhost:12345/api/eaten/' + userId, data)
                .then(res => (alert('섭취 기록에 저장했습니다.')));
        },
        planEating: function () {
            var userId = foodListMain.userId;
            if (userId == '') {
                alert('login required');
                return;
            }
            var data = {
                code: this.code
            };
            axios
                .post(`http://localhost:12345/api/wish/${userId}`, data)
                .then(res => (alert('식단 계획에 추가했습니다.')));
                
        },
        openModal: function () {
            console.log('modal opening');
            detailModal.code = this.code;
            detailModal.name = this.name;
            detailModal.material = this.material;
            detailModal.imgurl = this.imgurl;
            detailModal.nutrition = this.nutrition;
            detailModal.servingUnit = this.servingUnit;
            detailModal.showModal();
        }
    }
});

var detailModal = new Vue({
    el: '#detail-modal',
    data: {
        showing: false,
        code: '',
        name: '',
        material: '',
        imgurl: '',
        sevingUnit: '',
        nutrition: []
    },
    methods: {
        showModal: function () {
            updateCharts(this.nutrition);
            this.showing = true;
        },
        closeModal: function () {
            this.showing = false;
        }
    }
});

// dailyservings = [cal, carbo, prot, fat, sugar, natr, choles, sat-fat, trans-fat]
// TODO check later 
var dailyservings = [2400, 324, 55, 54, 100, 2000, 300, 15, 2]
var dummy_nutri = [1000, 200, 10, 20, 0, 200, 0, 10, 3];

/* modal chart */
var calCtx = document.getElementById('calChart').getContext('2d');
var majorCtx = document.getElementById('majorChart').getContext('2d');
var fattyCtx = document.getElementById('fattyChart').getContext('2d');

var calChart;
var majorChart;
var fattyChart;


function createCharts() {
    var whole_labels = ['열량', '탄수화물', '단백질', '지방', '당류', '나트륨', '콜레스테롤', '포화지방산', '트랜스지방산'];

    var cal_data = {
        labels: whole_labels.slice(1, 4),
        datasets: [{
            backgroundColor: ['rgba(0, 200, 200, 0.8)', 'rgba(200, 0, 200, 0.8)', 'rgba(200, 200, 0, 0.8)'],
            data: []
        }]
    };

    var major_data = {
        labels: whole_labels.slice(0, 6),
        datasets: [{
            backgroundColor: 'rgba(200, 0, 0, 0.5)',
            data: []
        }]
    };

    var fatty_data = {
        labels: whole_labels.slice(6, 9),
        datasets: [{
            backgroundColor: 'rgba(0, 0, 200, 0.5)',
            data: []
        }]
    };

    calChart = new Chart(calCtx, {
        type: 'doughnut',
        data: cal_data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: '3대 영양소 열량 비율(%)'
            }
        }
    });

    majorChart = new Chart(majorCtx, {
        type: 'radar',
        data: major_data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scale: {
                ticks: {
                    beginAtZero: true,

                    stepSize: 20
                }
            },
            legend: {
                display: false
            },
            title: {
                display: true,
                text: '일일 권장량 기준 주영양소 비율(%)'
            }
        }
    });

    fattyChart = new Chart(fattyCtx, {
        type: 'bar',
        data: fatty_data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            legend: {
                display: false
            },
            title: {
                display: true,
                text: '일일 제한량 기준 지방 함량(%)'
            }
        }
    });
}

var updateChartData = function (chart, newData) {
    newData.forEach((newVal, idx) => {
        chart.data.datasets[0].data[idx] = newVal;
    });
    chart.update();
}

var updateCharts = function (nutrition) {
    var cal_data = nutrition.slice(1, 4);
    var major_data = nutrition.slice(0, 6).map((has, idx) => (has / dailyservings[idx]) * 100);
    var fatty_data = nutrition.slice(6, 9).map((has, idx) => (has / dailyservings[idx + 6]) * 100);

    updateChartData(calChart, cal_data);
    updateChartData(majorChart, major_data);
    updateChartData(fattyChart, fatty_data);
}

var foodListMain = new Vue({
    el: '#foodListMain',
    data: {
        userId: ''
    },
    mounted() {
        createCharts();
    }
});

/* =========== Search Log ========== */
Vue.component('searchlog', {
    template: '#searchlog-template',
    data() {
        return {
            result: [],
            keyword: ''
        }
    },

    mounted() {
        this.searchLog();
    },

    methods: {
        searchLog: function () {
            axios
                .get('http://localhost:12345/api/searchLog')
                .then(response => {
                    this.result = response.data
                });
        }
    }
});

var searchLog = new Vue({
    el: "#searchLog"
});

$(document).ready(function () {
    $('#myCarousel').carousel({
        interval: 4000
    })
});


/* ========== Allergy Condition ========== */
var searchForm = new Vue({
    el: '#search_form',
    data: {
    	check : false,
        conditions:        	
            [{ cond_ko: '열량', cond_en: 'calory', unit: 'kcal', limit: 2500, min: 0, max: 2500 },
            { cond_ko: '탄수화물', cond_en: 'carbo', unit: 'g', limit: 350, min: 0, max: 350 },
            { cond_ko: '단백질', cond_en: 'protein', unit: 'g', limit: 60, min: 0, max: 60 },
            { cond_ko: '지방', cond_en: 'fat', unit: 'g', limit: 60, min: 0, max: 60 },
            { cond_ko: '당류', cond_en: 'sugar', unit: 'g', limit: 100, min: 0, max: 100 },
            { cond_ko: '나트륨', cond_en: 'natrium', unit: 'mg', limit: 2000, min: 0, max: 2000 },
            { cond_ko: '콜레스테롤', cond_en: 'chole', unit: 'mg', limit: 300, min: 0, max: 300 },
            { cond_ko: '포화지방산', cond_en: 'fattyacid', unit: 'g', limit: 20, min: 0, max: 20 },
            { cond_ko: '트랜스지방', cond_en: 'transfat', unit: 'g', limit: 2, min: 0, max: 2 }]
    },
    mounted() {
    	this.check = false;
    },
    methods: {
    	opendetail : function(){
    		
    		this.check  = true;
    		console.log(this.check);
    	},
    	closedetail : function(){
    		this.check = false;
    		console.log(this.check);
    	},
    	
    	searchProcess: function () {
/*    		searchForm.conditions.forEach(cond => {
    		    min = cond.min;
    		    max = cond.max;
    		    console.log(min);
    		    console.log(max + "제발요");
    		    
    		})
*/    		this.$refs.form.submit();
    	}
    }
});


