<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Safood: 영양 정보</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script src="https://unpkg.com/vue"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/stats.css">
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="component/header.jsp" />
	
    <div class="dashboard_wrapper">
        <div class="dashboard" id="dashboard">
            <div class="board_header">
                
                <span class="prev_button" @click="prevSummary">&lt;</span> 
                <span class="board_title" v-text="board_titles[current]"></span>
                <span class="next_button" @click="nextSummary">&gt;</span> 
            </div>
            <div class="board_body" id="body_wrapper">
                <div class="panel panel_chart">
                    <canvas id="calChart"></canvas>
                </div>
                <div class="panel panel_chart">
                    <canvas id="majorChart"></canvas>
                </div>
                <div class="panel panel_chart">
                    <canvas id="fattyChart"></canvas>
                </div>
                <div class="panel panel_food">
                    <h2>자주 섭취한 식품</h2>
                    <p v-for="(freq, idx) in frequentEaten" v-text="(idx + 1) + ') ' + freq.first + ' (' + freq.second + '회)'"></p>
                </div>
                <div class="panel panel_food">
                    <h2>추천 식품</h2>
                </div>
                <div class="panel panel_food">
                    <h2>주의할 식품</h2>
                </div>                
            </div>
        </div>
    </div>
	
	<!-- FOOTER -->
    <jsp:include page="component/footer.jsp" />
</body>
<script type="text/javascript">
    var userId = '${user.id}';
</script>
<script type="text/javascript" src="/js/stats.js"></script>
</html>