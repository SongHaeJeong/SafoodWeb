/* Vue */
// dailyservings = [cal, carbo, prot, fat, sugar, natr, choles, sat-fat, trans-fat]
// TODO check later
if (userId == "") {
    alert('로그인이 필요합니다.');
    location.href="main.safood";
}
var dailyservings = [2400, 324, 55, 54, 100, 2000, 300, 15, 50, 2]
var init_nutri = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var dummy_nutri = [1000, 200, 10, 20, 0, 200, 0, 10, 1, 3];

/* dashboard chart */
var calCtx;
var majorCtx;
var fattyCtx;

var calChart;
var majorChart;
var fattyChart;

var whole_labels = ['열량', '탄수화물', '단백질', '지방', '당류', '나트륨', '콜레스테롤', '포화지방산', '트랜스지방산'];
var whole_col_names = ['calory', 'carbo', 'protein', 'fat', 'sugar', 'natrium', 'chole', 'fattyacid', 'transfat'];
function createCharts() {
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
                    // stepSize: 20
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

// Dashboard body
var dashboard = new Vue({
    el: '#dashboard',
    data: {
        current: 0,
        summaryNum: 2,
        showingData: [init_nutri, init_nutri],
        userId: userId,

        board_titles: ['섭취 기록 영양소 통계', '식단 계획 영양소 통계'],

        frequentEaten: [],
        recommendFood: [],
        warningFood: []
    },
    mounted () {
        calCtx = document.getElementById('calChart').getContext('2d');
        majorCtx = document.getElementById('majorChart').getContext('2d');
        fattyCtx = document.getElementById('fattyChart').getContext('2d');
        
        createCharts();
        updateCharts(init_nutri);
        axios
            .get(`http://localhost:12345/api/eaten/${this.userId}`)
            .then(res => {
                console.log(res.data);
                var temp_sum = Array(10).fill(0, 0, 10);
                temp_sum.forEach((data, idx) => {
                    res.data.forEach(food => {
                        temp_sum[idx] += food[whole_col_names[idx]];
                    });
                    // temp_sum[idx] /= res.data.length;
                });
                this.showingData[0] = temp_sum;
                updateCharts(this.showingData[this.current]);
            });
        axios
            .get(`http://localhost:12345/api/wish/${this.userId}`)
            .then(res => {
                console.log(res.data);
                var temp_sum = Array(10).fill(0, 0, 10);
                temp_sum.forEach((data, idx) => {
                    res.data.forEach(food => {
                        temp_sum[idx] += food[whole_col_names[idx]];
                    });
                    // temp_sum[idx] /= res.data.length;
                });
                this.showingData[this.summaryNum - 1] = temp_sum;
            });
        axios
            .get(`http://localhost:12345/api/best/${this.userId}`)
            .then(res => {
                this.frequentEaten = res.data; 
            });
    },
    methods: {
        prevSummary: function() {
            console.log('prev Summary');
            if (this.current == 0)
                this.current = this.summaryNum;
            this.current -= 1;
            updateCharts(this.showingData[this.current]);
        },
        nextSummary: function() {
            console.log('next Summary');
            if (this.current == this.summaryNum - 1)
                this.current = -1;
            this.current += 1;
            updateCharts(this.showingData[this.current]);
        }
    }
});



