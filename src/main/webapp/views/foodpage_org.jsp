<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Safood: 식품 정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script src ="https://unpkg.com/vue"></script>
<script src ="https://unpkg.com/axios/dist/axios.min.js"></script>

<link rel="stylesheet" href="/css/foodpage.css">
</head>

<body>
	<!-- HEADER -->
	<jsp:include page="component/header.jsp" />

	<section class="container">
		<form action="search.safood" method="post">
			<div class="search">
				<div class="row centering">
					<div class="col-md-offset-3"></div>
					<div class="col-md-5 searchtxt">

						<input type="text" class="form-control" name="keyword" placeholder="식품명을 입력해주세요">
					</div>
					<div class="col-md-1 searchbtn">
						<input type="submit" class="btn btn-primary btn-sm"
							style="height: 34px;" value="검색"/>
					</div>
					<div class="col-md-offset-3"></div>
				</div>
			</div>
		</form>

		<div id="foodlistMain">
			<div class="row">
				<c:forEach items="${ foodList }" var="foodItem" varStatus="count">
				<div class="col-md-6">
					<div class="food_card thumbnail scroll" data-toggle="modal" data-target="#myModal${ count.index }">
						<img class="foodImg" alt="Food Thumbnail" src="/${ foodItem.img }" />
						<div class="caption">
							<h2>${ foodItem.name }</h2>
							<h3>원재료</h3>
							<div class="pScroll">
								<p>${ foodItem.material }</p>
							</div>
							<a href ="eat.safood?food=${foodItem.code }" class="btn btn-primary">추가하기</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<div class="modals">
		<c:forEach items="${ foodList }" var="foodItem" varStatus="count">
		<div class="modal fade" id="myModal${ count.index }" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h3 class="modal-title" id="myModalLabel">${ foodItem.name }</h3>
					</div>
					<div class="modal-body">
						<div class="images">
							<img src="/${ foodItem.img }" id="myModalImg" alt="food thumbnail" class="productImg">
		                    <img src="/img/proto_nutrition_graph.png" alt="">
	                    </div>
						<h3> 원재료 </h3>
						<p id="myModalMaterial">${ foodItem.material }</p>
						<hr>
						<div id="chartContainer"></div>
					</div>
		
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>

	<!-- FOOTER -->
	<jsp:include page="component/footer.jsp" />
</body>
<template id="modal-template">

</template>
<script type="text/javascript" src="/js/foodpage.js" ></script>
</html>