<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.util.ArrayList, com.safood.vo.Food, com.safood.vo.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="for_user panel_wrapper col-md-8">
	<div id="userinfo_panel" class="userinfo_panel hidden">
		<div id="userinfo_close_button">
			X
		</div>
		<div class="userinfo_header row">
			<div class="userinfo_identity col-md-4">
				<img src="/img/woman_icon.png" alt="user_avatar" />
				<h3> ${ user.name } 님</h3>
			</div>
			<div class="userinfo_status col-md-8">
				<h4>식단 관리가 필요합니다</h4>
				<div class="userinfo_tabbar row">
					<div id="nutri_tab_idx" class="nutri_tab tab_selected col-md-6">
						<h4>영양 정보 확인</h4>
					</div>
					<div id="modify_tab_idx" class="modify_tab col-md-6">
						<h4>회원 정보 수정</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="userinfo_body">
			<div id="nutri_tab_content"
				class="tab_selected nutri_tab tab_content row">
				<div class="eaten_info col-md-6">
					<h3>섭취 식품 정보</h3>
					<div id="eaten_food_container">
					<c:if test="${ !empty user }">
						<p v-for="(freq, idx) in frequentEaten" v-text="(idx + 1) + ') ' + freq.first + ' (' + freq.second + '회)'"></p>
						<%--<c:if test="${ empty eatenFoodList }">
							<p> 섭취 정보가 없습니다. </p>
						</c:if> --%>
						<c:if test="${ !empty eatenFoodList }">
							<c:forEach items="${ eatenFoodList }" var="food">
								<h5> ${ food.name } </h5>
							</c:forEach>
						</c:if>
					</c:if>
						
					</div>
				</div>
				<div class="nutri_info col-md-6">
					<h3>섭취 식품 통계</h3>
					<div class="chartContainer">
						<canvas id="majorChart"></canvas>
					</div>
					<!-- <img src="/img/proto_nutrition_graph.png" /> -->				
				</div>
			</div>
			
			<div id="modify_tab_content" class="modify_tab tab_content">
				<form id="modify_form" action="modify.safood" method="post">
					<div class="row">
						<div class="col-md-6 col-sm-6">
							<div class="input_row">
								<label for="modify_password">새 암호</label><input
									id="modify_password" name="modify_password" type="password">
							</div>
							<div class="input_row">
								<label for="modify_confirm">확인</label><input id="modify_confirm"
									name="modify_confirm" type="password">
							</div>
							<div class="input_row">
								<label for="modify_name">이름</label><input id="modify_name"
									name="modify_name" type="text" value="${ user.name }">
							</div>
							<div class="input_row">
								<label for="modify_email">이메일</label><input id="modify_email"
									name="modify_email" type="email" value="${ user.email }">
							</div>
						</div>
						<div class="col-md-offset-1 col-md-5 col-sm-offset-1 col-sm-5">
							<fieldset class="allergies">
								<legend> 알레르기 정보 </legend>
								<div id="info_allergy">
									<allergylist comp_name="search"></allergylist>
								</div>
							</fieldset>
						</div>
					</div>
					<hr>
					<div class="buttons_container">
						<input type= "submit" id="modify_button"
							class="btn btn-primary"
							value="수정하기" /> 
						<a id="modify_button_delete"
							class="btn btn-danger"
							href="deleteUser.safood?id=${ user.id }">탈퇴하기</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>