<h2>spa_board</h2>
<div id="app" style="padding-top: 100px;">
	<router-view></router-view>
</div>
<template id="addQuestion">
<div>
	<div class="container">

		<form id="form1" action="" class="form-horizontal" method="post">
			<h2>게시판 등록</h2>
			<div class="form-group">
				<input type="hidden" class="form-control" id="userid"
					value="${sessionScope.user.id }" v-model="userid">
			</div>

			<div class="form-group">
				<label>제목:</label> <input type="text" class="form-control"
					id="title" v-model="title">
			</div>

			<div class="form-group">
				<label>내용: </label> <input type="text" class="form-control"
					id="content" v-model="content">
			</div>

			<input @click.prevent="addQuestion" value="등록하기">

		</form>

	</div>

</div>

</template>
<template id="updateQuestion">
<div>
	<div class="container">
		<form id="form1" class="form-horizontal" method="">
			<h2>게시판 수정</h2>
			<div class="form-group">
				<input type="text" class="form-control" v-model="qid">
			</div>
			<div class="form-group">
				<label>제목:</label> <input type="text" class="form-control"
					id="title" v-model="title">
			</div>

			<div class="form-group">
				<label>내용: </label> <input type="text" class="form-control"
					id="content" v-model="content">
			</div>
			<input @click.prevent="updateQuestion" value="수정하기">
	</div>
	</form>

</div>
</template>
<template id="board-template">
<div>

	<div class="container">
		<h2>글 목록</h2>
		<div>
			<select name="type" v-model="type">
				<option value="title">title</option>
				<option value="user">user</option>
			</select> <input type="text" name="search" v-model="data">
			<button @click="search">검색하기</button>
		</div>
		<a href="#" @click="loginCheck()">글쓰기</a>
		<table class="table text-center">
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">아이디</th>
					<th class="text-center">제목</th>
					<th class="text-center">날짜</th>
					<th class="text-center"></th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="bod in result">
					<td v-text="bod.qid"></td>
					<td v-text="bod.userid"></td>
					<td><router-link
							:to="{name	 : 'detailQuestion', params :{qid:bod.qid}}">{{bod.title}}</router-link></td>
					<td v-text="bod.wdate"></td>
					<!-- <td><a @click="modifyRoute(bod.qid)">글수정</a></td> -->
					<td><router-link
							:to="{name	 : 'updateQuestion', params :{qid:bod.qid}}">글수정</router-link>
						<a href="#" @click="deleteQuestion(bod.qid)">글삭제</a></td>

				</tr>
			</tbody>
		</table>
	</div>
</div>
</template>

<template id="detailQuestion">
<div>
	<div class="container">
		<table class="table text-center">
			<thead>
				<tr>
					<th class="text-center">제목</th>
					<th class="text-center">내용</th>
					<th class="text-center">작성자</th>
					<th class="text-center">날짜</th>

				</tr>
			</thead>
			<tbody>
				<tr>
					<td v-bind="title">{{title}}</td>
					<td v-bind="content">{{content}}</td>
					<td v-bind="userid">{{userid}}</td>
					<td v-bind="wdate">{{wdate}}</td>
				</tr>
			</tbody>
		</table>

		<h2>ANSWER</h2>
		<form action="" class="form-horizontal">
			<input type="text" placeholder="답변을 등록해주세요" v-model="acontent">
			<button @click.prevent="addAnswer">등록하기</button>
		</form>
		<table class="table text-center">
			<tr v-for="(answer, idx) in result">
				<td v-text="idx+1"></td>
				<td v-text="answer.acontent"></td>
				<td v-text="answer.awdate"></td>
				<td><a href="#" @click="deleteAnswer(answer.aid)">삭제</a></td>
			</tr>
		</table>


		<router-link to="/">목록으로가기</router-link>
	</div>
</div>
</template>