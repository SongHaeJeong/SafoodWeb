<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Safood: ��ǰ ����</title>
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
<link rel="stylesheet" href="/css/foodpage.css">
<link rel="stylesheet" href="/css/board.css">
</head>

<body>
	<!-- HEADER -->
	<jsp:include page="component/header.jsp" />

	<section class="container">
		<div id="search_form">
			<form ref="form" action="search.safood" method="post">
				<div class="search">
					<div class=""></div>
					<div class="searchtxt">
						<input type="text" class="form-control" name="keyword" placeholder="��ǰ���� �Է����ּ���">
					</div>
					<div class="searchbtn">
						<input type="submit" @click.prevent="searchProcess" class="btn btn-primary btn-sm" value="�˻�"/>
					</div>
					<div class=""></div>
				</div>
				<input type = "button" value="�󼼰˻�" @click ="opendetail">
				<div class="conditions_container" v-if="check">
					<template v-for="cond in conditions">
					<fieldset class="conditions">
			            <legend v-text="cond.cond_ko + '(' + cond.unit +')'"></legend>
			            <input type="hidden" name="en_name" :value="cond.cond_en">
			            <input type="number" :id="cond.cond_en + '_min'" :name="cond.cond_en+'_min'" min="0" :max="cond.limit" :step="cond.limit/10" v-model:value="cond.min">
			            <label :for="cond.cond_en + '_min'">�̻�</label>
			            <input type="number" :id="cond.cond_en + '_max'" :name="cond.cond_en + '_max'" min="0" :max="cond.limit" :step="cond.limit/10" v-model:value="cond.max">
			            <label :for="cond.cond_en + '_max'">����</label>
			        </fieldset>
					</template>
			        <input type = "button" value="�ݱ�" @click ="closedetail">
				</div>
					<input type="hidden" name ="checkvalue" :value="check">
			</form>
		</div>
		<div id="searchLog">
			<searchlog></searchlog>
		</div>

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
								<!-- <img src="/img/proto_nutrition_graph.png" alt="dummy graph"> -->
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

    <!-- FOOTER -->
    <jsp:include page="component/footer.jsp" />
    
    <!-- Templates for vue -->
	<!-- �˻��� ����  -->
	<template id="searchlog-template">
	<div class="container">
		<div class="row">
			<div style="float: left;">�ǽð� �α� ��ǰ �˻��� >> &nbsp; &nbsp;</div>
			<div style="float: left;" id="myCarousel"
				class="carousel slide vertical">
				<div class="carousel-inner">
					<template v-for="(value, index) in result">
					<div v-if="index==0" class="active item">{{index+1}}.
						{{value}}</div>
					<div class="item" v-else>{{index+1}}. {{value}}</div>
					</template>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
	</div>
	</template>

    <template id="foodcard-template">
	<div class="col-md-6">
		<div class="food_card">
			<div class="info_row">
				<img class="food_thumbnail" alt="Food Thumbnail" :src="'/' + imgurl" />
				<div class="infos">
					<h2 v-text="name"></h2>
					<div class="nutri_summary">
						<span v-text="nutrition[0] + ' kcal / ' + servingUnit + ' g'"></span>
					</div>
					<div class="tags">
						<template v-for="(nutri, idx) in nutrition">
							<span class="tag high" v-if="tag_highs[idx]" v-text="bounds[idx].high_text"></span>						
							<span class="tag low" v-if="tag_lows[idx]" v-text="bounds[idx].low_text"></span>						
						</template>
						<!-- <span class="tag">����</span>
						<span class="tag">��Ʈ��</span>
						<span class="tag">Ʈ��������</span> -->
					</div>
				</div>
			</div>
			<hr>
			<div class="buttons_row">
				<a @click="checkEaten" class="btn btn-info">���� ���</a>
				<a @click="planEating" class="btn btn-info">�Ĵ� ��ȹ</a>
				<a @click="openModal" class="btn btn-info">���� ����</a>
			</div>
		</div>
	</div>
	</template>
</body>
<script type="text/javascript" src="/js/foodpage.js"></script>
<script type="text/javascript">
    foodListMain.$data.userId = '${user.id}';
</script>
</html>