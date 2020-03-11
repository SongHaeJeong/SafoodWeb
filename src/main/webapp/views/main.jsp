<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"
	import="com.safood.vo.User, com.safood.vo.Allergy"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Safood: Safe Food info service</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src ="https://unpkg.com/vue"></script>
<script src ="https://unpkg.com/axios/dist/axios.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/main.css">
</head>

<body>
	<div class="whole_container with${ empty(user)? 'out' : '' }_user">
		<div class="row">
			<!-- hidden cards -->
			<jsp:include page="component/userRegister.jsp" />

			<!-- first row -->
			<div id="foodlog_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<h2 class="for_user main_cardtitle">섭취 식품 내역</h2>
			</div>
			<div id="login_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<img class="main_logo" src="/img/logo_safood.png"
					alt="Safood">

				<div class="for_user">
					<c:if test="${!empty sessionScope.user }">
						<h3>${ user.name}님 반갑습니다!!</h3>
						<a href="logout.safood" class="btn btn-primary">로그아웃</a>
					</c:if>
				</div>
				<div class="for_nouser">
					<h2 class="main_title">
						방대한 식품 정보,<br>나만의 영양 관리 서비스
					</h2>
					<form class="login" action="login.safood" method="post">
						<input type="text" placeholder="ID" name="id"> <input
							type="password" placeholder="PASSWORD" name="pass">
						<div class="row_buttons">
							<input type="submit" id="button_login" class="btn btn-primary"
								role="button" value="로그인" /> <a id="button_register"
								class="btn btn-default" role="button" href="#">회원가입</a>
						</div>
					</form>
				</div>
			</div>

			<c:if test="${!empty user }">
				<jsp:include page="component/userInfo.jsp">
					<jsp:param value="${ user.name }" name="username" />
					<jsp:param value="${ user.eatenFood }" name="eatenFood" />
				</jsp:include>
			</c:if>

			<div id="userinfo_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<h3 class="for_user main_cardtitle">회원 정보 보기</h3>
			</div>

			<!-- second row -->
			<div id="foodinfo_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<a href="list.safood">
					<h3 class="main_cardtitle">식품 정보</h3>
				</a>
			</div>
			<div id="search_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<h2>식품 검색</h2>
				<form id="search_form" class="food_search" action="mainSearch.safood"
					method="post">
					 <input id="search_keyword" type="text" name="keyword"
						placeholder="검색어를 입력해주세요">
					<fieldset class="allergies">
						<legend> 알레르기 </legend>
						<div id="search_allergy">
							<allergylist comp_name="search"></allergylist>
						</div>
					</fieldset>
					<fieldset class="calrories">
						<legend> 칼로리 </legend>
						<input type="number" id="cal_number" name="cal_number" step="5">
						<input type="range" id="cal_range" name="cal_range">
					</fieldset>
					<input type="submit" class="btn btn-primary" value="검색하기" />
					<!-- <a id="search_button" class="btn btn-primary">검색하기</a> -->
				</form>
			</div>
			<div id="notice_card"
				class="col cards align-self-center col-md-4 col-sm-6">
				<a href="board/notice.safood">
					<h3 class="main_cardtitle">공지사항</h3>
				</a><br>
				<a href="board/qna.safood">
					<h3 class="main_cardtitle">QnA</h3>
				</a><br>
				
			</div>
		</div>
	</div>
	
<template id="templeallergy">
	<div id="container_checkboxes_register" class="row">
		<div class="allergy_item" v-for="allergy in result">
			<input  type="checkbox" :id="'allergy_' + comp_name + allergy.aid" name="allergies" :value="allergy.aid">
			<label :for="'allergy_' + comp_name + allergy.aid">{{ allergy.name }}</label>
		</div>
	</div>

</template>
	
<script type="text/javascript">
	Vue.component('allergylist',{
		template : '#templeallergy',
		props: ['comp_name'],
		data(){
			return{
				result :[],
				aid :'',
				name :''
				
			}
		},
		
		mounted(){
			console.log('mounted');
			this.getAllergies();
		},
		
		methods :{
			getAllergies : function(){
				console.log('getiing axios');
				axios
				.get('http://localhost:12345/api/allergies')
				.then(response=>{this.result = response.data})
			}
		}
	});
	
	var vm = new Vue({
		el : "#search_allergy",
		mounted(){
			console.log('vm mounted');
		}
	});
	
	var vm2 = new Vue({
		el : "#reg_allergy"
	});
	var userId = '${user.id}';
</script>
<script src="/js/main.js"></script>	
</body>

</html>
