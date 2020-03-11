<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src ="https://unpkg.com/vue"></script>
<script src ="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="/js/main.js"></script>  
  
<div id="register_panel" class="register_panel col-md-8 hidden">
    <form id="register_form" action="register.safood" method="post">
        <img class="main_logo" src="/img/logo_safood.png" alt="Safood">
        <div class="row register_title_row">
            <h3 class="register_title col-md-6 col-sm-6">Safood 계정 만들기</h3>
            <div class="buttons_container col-md-6 col-sm-6 row">
                <input type="submit" id="register_button" class="btn btn-primary col-md-offset-1 col-md-5 col-sm-offset-1 col-sm-5" value="가입하기"/>
                <a id="register_button_cancel" class="btn btn-default col-md-offset-1 col-md-5 col-sm-offset-1 col-sm-5">취소</a>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-6 col-sm-6">
                <div class="input_row">
                    <label for="register_id">아이디</label><input id="register_id" name="register_id" type="text">
                </div>
                <div class="input_row">
                    <label for="register_password">패스워드</label><input id="register_password" name="register_password" type="password">
                </div>
                <div class="input_row">
                    <label for="register_confirm">확인</label><input id="register_confirm" name="register_confirm" type="password">
                </div>
                <div class="input_row">
                    <label for="register_name">이름</label><input id="register_name" name="register_name" type="text">
                </div>
                <div class="input_row">
                    <label for="register_email">이메일</label><input id="register_email" name="register_email" type="email">
                </div>
            </div>
            <div class="col-md-offset-1 col-md-5 col-sm-offset-1 col-sm-5">
                <fieldset class="allergies">
                    <legend> 알레르기 정보 </legend>
                	<div id="reg_allergy">
						<allergylist comp_name="reg"></allergylist>
					</div>
                </fieldset>
            </div>
        </div>
    </form>
</div>

<!-- <template id="templeAllergy">
	<div id="container_checkboxes_register" class="row">
	<div class="allergy_item" v-for="allergy in result">
		<input  type="checkbox" id="'allergy_reg' + allergy.aid" name="allergies" value="allergy.aid ">
		<label for="'allergy_reg' + allergy.aid">{{ allergy.name }}</label>
	</div>
</div>

</template>
	
<script type="text/javascript">
	Vue.component('allergylist',{
		template : '#templeAllergy',
		data(){
			return{
				result :[],
				aid :'',
				name :''
				
			}
		},
		
		mounted(){
			this.getAllergies()
		},
		
		methods :{
			getAllergies : function(){
				axios
				.get('http://localhost:12345/api/allergies')
				.then(response=>{this.result = response.data})
			}
		}
	});
	
	
	var vm = new Vue({
		el : "#reg_allergy"
	});

</script> -->



	