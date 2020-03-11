var foodlistURL = 'foodlist.html';
var checkboxesName = 'allergies';

$(document).ready(function() {
    /*$.ajax({
        url: '/data/allergies.xml',
        success: function (data) {
            var cnt = 0;
            $(data).find('allergy').each(function() {
                var allergy = $(this).text();
                addCheckAllergy('container_checkboxes_allergies', allergy, cnt++);
                addCheckAllergy('container_checkboxes_register', allergy, cnt++);
            })
        }
    })*/

    addFeatureCalRangeNumber();

    var btn_search = $('#search_button');
    btn_search.on('click', function () {
        var query = "?" + queryFromJson(buildJsonFromForm('search_form'));
        if (query === "?")
            return;
        console.log(foodlistURL + query);
        window.location.assign(foodlistURL + query);
    });

    card_foodlog = $('#foodlog_card');
    card_login = $('#login_card');
    card_userinfo = $('#userinfo_card');
    card_foodinfo = $('#foodinfo_card');
    card_search = $('#search_card');
    card_notice = $('#notice_card');
    $(window).on('resize', windowResizeHandler);
    windowResizeHandler();

    var register_panel = $('#register_panel');
    $('#button_register').on('click', function() {
        card_userinfo.addClass('register_clicked');
        card_foodlog.hide();
        card_userinfo.hide();
        card_login.insertAfter(register_panel);
        register_panel.removeClass('hidden');
    });

    $('#register_button_cancel').on('click', function () {
        register_panel.addClass('hidden');
        card_userinfo.removeClass('register_clicked');
        card_foodlog.show();
        card_userinfo.show();
        card_login.insertBefore(card_userinfo);
    });
    
    var userinfo_panel$ = $('#userinfo_panel');
    $('.for_user.main_cardtitle').each(function (idx, item) {
    	$(item).on('click', function () {
    		card_foodlog.hide();
    		card_userinfo.hide();
    		userinfo_panel$.removeClass('hidden');
    	});
    });

    $('#userinfo_close_button').on('click', function () {
    	userinfo_panel$.addClass('hidden');
    	card_foodlog.show();
		card_userinfo.show();
    });
    
    addUserinfoTabEvent();
});

function queryFromJson(json) {
    var pairs = [];

    for (var key in json) {
        pairs.push(key + '=' + json[key]);
    }
    //console.log(pairs);
    return pairs.join('&');
}

function buildJsonFromForm(form_id) {
    var inputs = $('#'+form_id).find('input');
    var resJson = {};
    inputs.each(function (idx) {
        var input = inputs[idx];
        if (input.name === 'keyword' && input.value.trim() === "") {
        	alert("검색어를 입력해주세요");
        	return {};
        }
        if (input.name === checkboxesName) {
        	if (input.checked === true) {
	            if (!resJson[checkboxesName])
	                resJson[checkboxesName] = [];
	            resJson[checkboxesName].push(input.value);
        	}
        } else if (input.value != 0) {
            resJson[input.name] = input.value; 
        }
    });
    //console.log(resJson);
    return resJson;
}

function addFeatureCalRangeNumber() {
    var cal_range = $('#cal_range');
    var cal_number = $('#cal_number');
    var max_cal = 1500;
    var min_cal = 0;
    var cal_width = (max_cal - min_cal) / 100;

    cal_number.attr('min', min_cal);
    cal_number.attr('max', max_cal);

    cal_range.on('change', function () {
        cal_number.val($(this).val() * cal_width);
    });
    cal_number.on('change', function () {
        cal_range.val($(this).val() / cal_width);
    });
    cal_range.val(0);
    cal_number.val(0);
}

function addCheckAllergy(parentID, name, idx) {
    var div = $('<div class="allergy_item">');
    var checkbox = $('<input type="checkbox">');
    var label = $('<label>');
    checkbox.attr('value', name).attr('id', 'check'+idx).attr('name', checkboxesName);
    label.attr('for', 'check'+idx).text(name);
    div.append(checkbox).append(label);

    div.appendTo('#'+parentID);
}

var card_foodlog;
var card_login;
var card_userinfo;
var card_foodinfo;
var card_search;
var card_notice;

var isLargeWindow = window.inner_width >= 992;
function windowResizeHandler() {
    var win = $(window);
    if (win.width() >= 992 && !isLargeWindow) {       // 0 1 2 / 3 4 5
        card_login.insertBefore(card_userinfo);
        card_search.insertBefore(card_notice);
        isLargeWindow = true;
    } else if (win.width() < 992 && isLargeWindow) {    // 1 4 / 0 2 / 3 5
        card_login.insertBefore(card_foodlog);
        card_search.insertBefore(card_foodlog);
        isLargeWindow = false;
    }
}

function onNutriContent () {
	var nutri_tab_idx$ = $('#nutri_tab_idx');
	var nutri_tab_content$ = $('#nutri_tab_content');
	var modify_tab_idx$ = $('#modify_tab_idx');
	var modify_tab_content$ = $('#modify_tab_content');
	
	modify_tab_idx$.removeClass('tab_selected');
	modify_tab_content$.removeClass('tab_selected');
	nutri_tab_idx$.addClass('tab_selected');
	nutri_tab_content$.addClass('tab_selected');
}
function onModifyContent () {
	var nutri_tab_idx$ = $('#nutri_tab_idx');
	var nutri_tab_content$ = $('#nutri_tab_content');
	var modify_tab_idx$ = $('#modify_tab_idx');
	var modify_tab_content$ = $('#modify_tab_content');
	
	nutri_tab_idx$.removeClass('tab_selected');
	nutri_tab_content$.removeClass('tab_selected');
	modify_tab_idx$.addClass('tab_selected');
	modify_tab_content$.addClass('tab_selected');
}

function addUserinfoTabEvent () {
	$('#nutri_tab_idx').on('click', onNutriContent);
	$('#modify_tab_idx').on('click', onModifyContent);
}

var eatenFoodContainer = new Vue({
    el: '#eaten_food_container',
    data: {
        frequentEaten: []
    },
    mounted () {
        axios
            .get(`http://localhost:12345/api/best/${userId}`)
            .then(res => {
                this.frequentEaten = res.data; 
            });
    }
});











/* CHART */
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
    var major_data = {
        labels: whole_labels.slice(0, 6),
        datasets: [{
            backgroundColor: 'rgba(200, 0, 0, 0.5)',
            data: []
        }]
    };
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
}

var updateChartData = function (chart, newData) {
    newData.forEach((newVal, idx) => {
        chart.data.datasets[0].data[idx] = newVal;
    });
    chart.update();
}

var updateCharts = function (nutrition) {
    var major_data = nutrition.slice(0, 6).map((has, idx) => (has / dailyservings[idx]) * 100);

    updateChartData(majorChart, major_data);
}


var majorCtx = document.getElementById('majorChart').getContext('2d');
        
createCharts();
updateCharts(init_nutri);

axios
    .get(`http://localhost:12345/api/eaten/${userId}`)
    .then(res => {
        var temp_sum = Array(10).fill(0, 0, 10);
        temp_sum.forEach((data, idx) => {
            res.data.forEach(food => {
                temp_sum[idx] += food[whole_col_names[idx]];
            });
            // temp_sum[idx] /= res.data.length;
        });
        updateCharts(temp_sum);
    });

