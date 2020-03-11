<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script src="https://unpkg.com/vue"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/board.css">
</head>
<body>
	<jsp:include page="component/header.jsp" />
	<div id="app" style="padding-top: 100px;">
		<!--template 정의 : 화면에 표시될 내용-->

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
					<label>내용: </label> <textarea class="form-control"
						id="content" v-model="content" rows="20"></textarea>
				</div>

				<input @click.prevent="addQuestion" value="등록하기" class="btn-primary">

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
			<a href="#" @click="loginCheck()" class="btn-primary">글쓰기</a>


			<table class="table text-center table-hover table-striped">
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
			<div class="text-center">
				<ul class="pagination">
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
				</ul>
			</div>
			
		</div>
	</div>
	</template>

	<template id="detailQuestion">
	<div>
		<div class="container">
			<table class="table text-center table-bordered">
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
				<textarea placeholder="답변을 등록해주세요" v-model="acontent" rows="5" cols="50"></textarea><br>
				<a @click.prevent="addAnswer" class="btn btn-primary">등록하기</a>
			</form>
			<table class="table text-center table-bordered">
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


	<script type="text/javascript">
	var listhrm = Vue.component('listhrm',{
	    template: '#board-template',
	    data(){
	    	return{
	    		result : [],
	    		qid : '',
	    		userid :'${user.id}',
				title : '',
				wdate : '',
				content : '',
				data : '',
				type : 'title'
	    	}
	    },
	    
	    mounted(){
	    	this.allBoardList()
	    },
	    
	    methods:{
	    	allBoardList: function(){
	    		axios
	    		 .get('http://localhost:12345/api/lists')
	    		 .then(response=>{this.result = response.data
	    		 })
	    	},
	    	
	    	deleteQuestion : function(val){
	    		axios
	    		.delete('http://localhost:12345/api/lists/'+(val))
	    		.then(response=>{
	    			 this.allBoardList();
	    			 
	    		})
	    	},
	    	
	    	search : function(){
	    		if(this.data ==''){
	    			this.allBoardList();
	    		}else if(this.data != ''){
	    			axios
	    			.get('http://localhost:12345/api/search/'+this.type+'/'+this.data)
	    			.then(response=>{
	    				this.result = response.data
	    			})
	    		}
	    		
	    	},
	    	
	    	
	    	
	    	loginCheck : function(){
	    		console.log(this.userid);
	    		if(this.userid ==''){
	    			alert("로그인 해주세요");
	    		}else{
	    			router.push('/addQuestion');
	    		}
	    		
	    		
	    	}
	    	
	    }
	    
	});
	
	var detailhrm = Vue.component('detailhrm',{	
		template : "#detailQuestion",
		data(){
			return{
				result :[],				
				qid :'',
				title : '',
				userid : '',
				wdate : '',
				content: '',
				aid :'',
				acontent : '',
				awdate :'',
				qaid : '',
				
			}
		},
		mounted(){
			this.qid =this.$route.params.qid;
			axios
			.get('http://localhost:12345/api/lists/' + this.qid)
			.then(response => {
				
				this.title = response.data.title;
    			this.userid = response.data.userid;
    			this.wdate = response.data.wdate;
    			this.content = response.data.content;
			})
			this.allAnswerList()
		},
		
		methods : {
			
			allAnswerList: function(){
	    		axios
	    		 .get('http://localhost:12345/api/answers/' +this.qid)
	    		 .then(response=>{this.result = response.data
	    		 })
	    	},
	    	
			addAnswer : function(){
				axios
				.post('http://localhost:12345/api/answers',{
					acontent : this.acontent , 
					qaid : this.qid
				})
				
				.then(response=>{
					this.acontent ="";
					this.allAnswerList()
				})
			},
			
			deleteAnswer : function(val){
				axios
				.delete('http://localhost:12345/api/answers/'+(val))
				.then(response=>{
					this.allAnswerList()
				})
			}
		}
	});
	

	var addhrm = Vue.component('addhrm',{
	    template: '#addQuestion',
	    data(){
	    	return{
	    		result : [],
	    		userid : '${user.id}',
	    		title : '',
	    		content : ''
	    	}
	    },
	    
	    methods : {
	    	addQuestion : function(){
	    		axios
	    		.post('http://localhost:12345/api/lists',{
	    			userid : this.userid , title : this.title, content : this.content
	    		})
	    		.then(response=>{
	    			 router.push('/');
	    			 
	    		})
	    	}
	    	
	    
	    }
	});
	
	
	var updatehrm = Vue.component('updatehrm',{
		template : '#updateQuestion',
		data(){
			return{
				result :[],
				qid : '',
				title : '',
				content : ''
			}
		},
		
		mounted(){
			this.qid = this.$route.params.qid;
			axios
			.get('http://localhost:12345/api/lists/' + this.qid)
			.then(response => {
				this.title = response.data.title;
				this.content = response.data.content;
			})
			
		},
		
		methods : {
			updateQuestion : function(){
				axios
				.put('http://localhost:12345/api/lists',{
					qid : this.qid , title:this.title, content : this.content
				})
				.then(response=>{
					router.push('/');
				})
			}
		}
	});
	
	
	
	
		
	/* var idhrm = Vue.component('idhrm',{
	    template: '#idhrmtemplate'
	});
	var detailhrm = Vue.component('detailhrm',{
	    template: '#detailtemplate'
	});
	var namehrm = Vue.component('namehrm',{
	    template: '#namehrmtemplate'
	});
	});		 */
	
	
	  const router = new VueRouter({
		  routes: [				
				   { path: '/', component:  listhrm },
				   { path: '/addQuestion', component : addhrm},
				   { path : '/updateQuestion/:qid', name :'updateQuestion' , component : updatehrm},
				   { path : '/detailQuestion/:qid', name : 'detailQuestion',  component : detailhrm}
 	]});  
	
	
	var vm  =new Vue({
		el : "#app",
		data: {
			mod_qid: '',
			mod_title: '',
			mod_content: ''
		},
		router
		
	});
	
</script>


</body>
</html>