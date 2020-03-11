<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Safood</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script src ="https://unpkg.com/vue"></script>
<script src ="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/foodpage.css">
<link rel="stylesheet" href="/css/board.css">
</head>

<body>
<jsp:include page="component/spa_header.jsp" />

<div id="content_router">
	<router-view></router-view>
</div>

<jsp:include page="component/footer.jsp" />

<template id="foods_template">
	<div>
		<%-- <jsp:include page="spa_foods.jsp" /> --%>
		<h2>spa_foods</h2>
		<section class="container">
			<form action="search.safood" method="post">
				<div class="search">
					<div class="row centering">
						<div class="col-md-offset-3"></div>
						<div class="col-md-5 searchtxt">
		
							<input type="text" class="form-control" name="keyword"
								placeholder="��ǰ���� �Է����ּ���">
						</div>
						<div class="col-md-1 searchbtn">
							<input type="submit" class="btn btn-primary btn-sm"
								style="height: 34px;" value="�˻�" />
						</div>
						<div class="col-md-offset-3"></div>
					</div>
				</div>
			</form>
		
			<div id="foodListMain">
				<div class="row">
					<c:forEach items="${ foodList }" var="food" varStatus="count">
						<foodcard :code="${food.code}" imgurl="${food.img}"
							name="${food.name}" material="${food.material}"
							:serving-unit="${food.supportpereat}"
							:nutrition="[${food.calory}, ${food.carbo}, ${food.protein}, ${food.fat}, ${food.sugar}, ${food.natrium}, ${food.chole}, ${food.fattyacid}, ${food.transfat}]"></foodcard>
					</c:forEach>
				</div>
			</div>
		
			<div id="detail-modal" v-cloak v-show="showing">
				<transition name="modal">
				<div class="modal-mask">
					<div class="modal-wrapper">
						<div class="modal-container">
							<div class="modal-header">
								<h3 class="modal-title" v-text="name"></h3>
							</div>
							<div class="modal-body">
								<div class="images">
									<img :src="'/' + imgurl" class="productImg" alt="food thumbnail">
								</div>
								<h3>�����</h3>
								<p v-text="material"></p>
								<hr>
								<h4>����� �׷���</h4>
								<div class="charts">
									<div class="chartContainer">
										<canvas id="calChart"></canvas>
									</div>
									<div class="chartContainer">
										<canvas id="majorChart"></canvas>
									</div>
									<div class="chartContainer">
										<canvas id="fattyChart"></canvas>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" @click="closeModal">�ݱ�</button>
							</div>
						</div>
					</div>
				</div>
				</transition>
			</div>
		</section>
		
		<template id="foodcard-template">
		<div class="col-md-6">
			<div class="food_card thumbnail scroll" @click="openModal">
				<img class="foodImg" alt="Food Thumbnail" :src="'/' + imgurl" />
				<div class="caption">
					<h2 v-text="name"></h2>
					<h3>�����</h3>
					<div class="pScroll">
						<p v-text="material"></p>
					</div>
					<a :href="'eat.safood?food=' + code" class="btn btn-primary">�߰��ϱ�</a>
				</div>
			</div>
		</div>
		</template>
	</div>
</template>

<%-- <template id="board_template">
	<jsp:include page="spa_board.jsp" />
</template>
 --%>
</body>
<script type="text/javascript" src="/js/foodpage.js"></script>
<!-- <script type="text/javascript" src="/js/board.js"></script> -->
<script type="text/javascript" src="/js/spa.js"></script>
</html>