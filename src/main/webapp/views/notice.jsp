<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Safood Notice</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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
	<template id="addNotice">
	<div>
		<div class="container">

			<form id="form1" action="" class="form-horizontal" method="post">
				<h2>게시판 등록</h2>

				<div class="form-group">
					<label>제목:</label> <input type="text" class="form-control"
						id="title" v-model="title">
				</div>

				<div class="form-group">
					<label>내용: </label> <input type="text" class="form-control"
						id="content" v-model="content">
				</div>

				<input @click.prevent="addNotice" value="등록하기" class="btn-primary">

			</form>

		</div>

	</div>

	</template>

	<template id="updateNotice">
	<div>
		<div class="container">
			<form id="form1" class="form-horizontal" method="">
				<h2>공지사항 수정</h2>
				<div class="form-group">
					<label>제목:</label> <input type="text" class="form-control"
						id="title" v-model="title">
				</div>

				<div class="form-group">
					<label>내용: </label> <input type="text" class="form-control"
						id="content" v-model="content">
				</div>
				<input @click.prevent="updateNotice" value="수정하기">
		</div>
		</form>

	</div>
	</template>
	<template id="notice-template">
	<div>

		<div class="container">
			<h2>공지사항</h2>
			<div>
				<select name="type" v-model="type">
					<option value="title">title</option>
				</select> <input type="text" name="search" v-model="keyword">
				<button @click="search">검색하기</button>

			</div>


			<router-link v-if="check" :to="{name : 'addNotice'}" class="btn-primary">글쓰기</router-link>
			<table class="table text-center table-hover table-striped">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">제목</th>
						<th class="text-center">날짜</th>
						<th class="text-center"></th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(bod, idx) in result">
						<td v-text="idx+1"></td>
						<td><router-link
								:to="{name	 : 'detailNotice', params :{nid : bod.nid}}">{{bod.title}}</router-link></td>
						<td v-text="bod.ndate"></td>
						<td><router-link v-if="check"
								:to="{name : 'updateNotice', params :{nid:bod.nid}}">글수정</router-link>
							<a href="#" v-if="check" @click="deleteNotice(bod.nid)">글삭제</a></td>
						<!-- <td ><router-link :to="{name	 : 'detailNotice', params :{qid:bod.qid}}">{{bod.title}}</router-link></td>
						<td><a @click="modifyRoute(bod.qid)">글수정</a></td>
						<td><router-link :to="{name	 : 'updateNotice', params :{qid:bod.qid}}">글수정</router-link> -->
						<!-- <a href="#" @click="deleteNotice(bod.qid)">글삭제</a></td> -->

					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</template>

	<template id="detailNotice">
	<div>
		<div class="container">
			<table class="table text-center table-bordered">
				<thead>
					<tr>
						<th class="text-center">제목</th>
						<th class="text-center">내용</th>
						<th class="text-center">날짜</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td v-bind="title">{{title}}</td>
						<td v-bind="content">{{content}}</td>
						<td v-bind="ndate">{{ndate}}</td>
					</tr>
				</tbody>
			</table>



			<router-link to="/">목록으로가기</router-link>
		</div>
	</div>
	</template>


	<script type="text/javascript">
	var listhrm = Vue.component('listhrm',{
	    template: '#notice-template',
	    data(){
	    	return{
	    		result : [],
	    		nid : '',
	    		userid : '${user.id}',
	    		title :'',
				content : '',
				ndate : '',
				count : '',
				img : '',
				type : 'title',
				keyword: '',
				check : false
	    	}
	    },
	    
	    mounted(){
	    	this.allNoticeList();	    	
	    	this.admincheck();
	    	console.log(this.userid);
	    },
	    
	    methods:{
	    	allNoticeList: function(){
	    		axios
	    		 .get('http://localhost:12345/api/notice/lists')
	    		 .then(response=>{this.result = response.data
	    			 console.log(response.data);
	    		 })
	    	},
	    
	    	admincheck : function(){
    		if(this.userid=='admin'){
    		console.log(this.userid);
				this.check = true;
    		}
    		
    		
    		},
    		
    		deleteNotice : function(val){
	    		axios
	    		.delete('http://localhost:12345/api/notice/'+(val))
	    		.then(response=>{
	    			 this.allNoticeList();
	    			 
	    		})
	    	},
	    	
	    	search : function(){
	    		if(this.keyword ==''){
	    			this.allNoticeList();
	    		}else if(this.keyword != ''){
	    			axios
	    			.get('http://localhost:12345/api/noticeSearch/'+this.type+'/'+this.keyword)
	    			.then(response=>{
	    				this.result = response.data
	    			})
	    		}
	    	}
	    
	
	    }
	    
	});
	
	var updatehrm = Vue.component('updatehrm',{
		template : '#updateNotice',
		data(){
			return{
				result :[],
				nid : '',
				title : '',
				content : ''
			}
		},
		
		mounted(){
			this.nid = this.$route.params.nid;
			axios
			.get('http://localhost:12345/api/notice/' + this.nid)
			.then(response => {
				console.log(this.nid);
				this.title = response.data.title;
				this.content = response.data.content;
			})
			
		},
		
		methods : {
			updateNotice : function(){
				axios
				.put('http://localhost:12345/api/notice',{
					nid : this.nid , title:this.title, content : this.content
				})
				.then(response=>{
					router.push('/');
				})
			}
		}
	});
	
	 var detailhrm = Vue.component('detailhrm',{	
		template : "#detailNotice",
		data(){
			return{
				result :[],				
				nid : '',
	    		title :'',
				content : '',
				ndate : '',
				count : '',
				img : '',
				
			}
		},
		
		mounted(){
			this.noticeSelect()
		},
		
		methods :{
			noticeSelect : function(){
				this.nid = this.$route.params.nid;
				axios
				.get('http://localhost:12345/api/notice/lists/' + this.nid)
				.then(response => {
					this.title = response.data.title;
					console.log(this.nid);
	    			this.content = response.data.content;
	    			this.ndate = response.data.ndate;
	    			this.updateCount();
				})
			},
			
			updateCount : function(){
				this.nid = this.$route.params.nid;
				axios
				.put('http://localhost:12345/api/notice/count/'+this.nid)
				.then(response =>{
					
					console.log(this.count);
				})
			}
		}
		
	});
	 
	var addhrm = Vue.component('addhrm',{
		    template: '#addNotice',
		    data(){
		    	return{
		    		result : [],
		    		userid : '${user.id}',
		    		title : '',
		    		content : ''
		    	}
		    },
			
		    
		    methods : {
		    	addNotice : function(){
		    		axios
		    		.post('http://localhost:12345/api/notice',{
		    			 title : this.title, content : this.content
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
				   { path : '/detailNotice/:nid', name : 'detailNotice',  component : detailhrm},
				   { path: '/addNotice', name : 'addNotice',component : addhrm},
				   { path : '/updateNotice/:nid', name :'updateNotice' , component : updatehrm}
				    
 	]});  
	
	
	var vm  =new Vue({
		el : "#app",
		router
		
	});
	
</script>


</body>
</html>