<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
//아이디 정규식
let idJ = /^[a-z0-9]{4,16}$/;
// 비밀번호 정규식
let pwdJ = /^[A-Za-z0-9]{4,16}$/; 
// 이름 정규식
let nameJ = /^[가-힣]{2,6}$/;
// 이메일 검사 정규식
let emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 번호 정규식
let telJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
$(document).ready(function(){
	$("#id").keyup(function(){
		 
		 var str = document.getElementById("datepicker").value;
		 var strArr = str.split("/");
		 var date = new Date(strArr[0], strArr[1]-1, strArr[2]);
		 console.log(date);
		 console.log(typeof(date));
		 console.log(str);
	
		if($(this).val() == "admin"){
			$("#id_check").text('불가능');
			$('#id_check').css('color', 'red');
		}else if(idJ.test($(this).val())){
			$("#id_check").text('가능');
			$('#id_check').css('color', 'green');
		}else{
			$("#id_check").text('불가능');
			$('#id_check').css('color', 'red');
		}
	});	
	$("#password1").keyup(function(){
		if(pwdJ.test($(this).val())){
			$("#pwd1_check").text('가능');
			$('#pwd1_check').css('color', 'green');
		}else{
			$("#pwd1_check").text('불가능');
			$('#pwd1_check').css('color', 'red');
		}
		if($("#password1").val() == $("#password2").val()){
			$("#pwd2_check").text('가능');
			$('#pwd2_check').css('color', 'green');
		}else{
			$("#pwd2_check").text('불가능');
			$('#pwd2_check').css('color', 'red');
		};
	});
	
	$("#password2").keyup(function(){
		if($("#password1").val() == $("#password2").val()){
			$("#pwd2_check").text('비밀번호 일치');
			$('#pwd2_check').css('color', 'green');
		}else{
			$("#pwd2_check").text('비밀번호 다름');
			$('#pwd2_check').css('color', 'red');
		};
	});
	$("#name").keyup(function(){
		if(nameJ.test($(this).val())){
			$("#name_check").text('가능');
			$('#name_check').css('color', 'green');
		}else{
			$("#name_check").text('불가능');
			$('#name_check').css('color', 'red');
		}
	});
	$("#tel").keyup(function(){
		if(telJ.test($(this).val())){
			$("#tel_check").text('가능');
			$('#tel_check').css('color', 'green');
		}else{
			$("#tel_check").text('불가능');
			$('#tel_check').css('color', 'red');
		}
	});
	$("#email").keyup(function(){
		if(emailJ.test($(this).val())){
			$("#email_check").text('가능');
			$('#email_check').css('color', 'green');
		}else{
			$("#email_check").text('불가능');
			$('#email_check').css('color', 'red');
		}
	});
		$("#join").click(function() {			
			if ($("#id").val()=="" ){
				alert("아이디를 작성해주세요!");	
				return
			} 
			if ($("#id").val()=="admin" ){
				alert("사용이 불가능한 아이디입니다!");	
				return
			} 
			if (idJ.test($("#id").val())){
				//정규 표현식과 일치하면 다음으로 넘김
			} 
			else {
				alert("아이디를 확인해주세요");
				return
			} 
			if ($("#password1").val()==""){
				alert("비밀번호를 작성해주세요!");
				return
			} 
			if (pwdJ.test($("#password1").val())){
				//정규 표현식과 일치하면 다음으로 넘김
			} 
			else {
				alert("비밀번호를 확인해주세요");
				return
			} 
			if ($("#password1").val() == $("#password2").val()){
				//비밀번호 비교하고 일치하면 넘김
			} 
			else {
				alert("비밀번호가 다릅니다!");
				return
			}
			if ($("#name").val()==""){
				alert("이름을 작성해주세요!");
				return
			}
			if (nameJ.test($("#name").val())){
				//정규 표현식과 일치하면 다음으로 넘김
			} 
			else {
				alert("이름을 확인해주세요!");
				return
			} 
			if ($("#birth").val()==""){
				alert("생일을 확인해주세요!");
				return
			}
			if ($("#gender").val()==""){
				alert("성별을 체크해주세요!");
				return
			}
			if ($("#address").val()==""){
				alert("주소를 작성해주세요!");
				return
			}
			if ($("#tel").val()==""){
				alert("전화번호를 확인해주세요!");
				return
			}
			if (telJ.test($("#tel").val())){
				//정규 표현식과 일치하면 다음으로 넘김
			} 
			else {
				alert("전화번호를 확인해주세요!");
				return
			} 
			if ($("#email").val()==""){
				alert("이메일이 액션빔");
				return
			}
			if (emailJ.test($("#email").val())){
				//정규 표현식과 일치하면 다음으로 넘김
			} 
			else {
				alert("이메일을 확인해주세요!");
				return
			} 
			if ($("#idResult").text().trim() == "사용가능") {
				$("form").submit();
			}
			else {
				alert("id 중복체크 하세요!");
			}
		});
		$(document).ready(function() {
		$("#idCheck").click(function() {
			$.post("/member/idCheck", {
				id : $("#id").val()
			}).done(function(data) {
				$("#idResult").text(data);
			});
		});
	});
	});
</script>
<script>
$(document).ready(function(){
  $('#showPassword').on('click', function(){
    let passwordField = $('#password1');
    let passwordFieldType = passwordField.attr('type');
    if(passwordFieldType == 'password')
    {
    	passwordField.attr('type', 'text');
    	$(this).val('숨기기');
    } else {
    	passwordField.attr('type', 'password');
    	$(this).val('보기');
    }
  });
});
</script>
<script>
$(document).ready(function(){
	  $('#showPassword1').on('click', function(){
	    let passwordField = $('#password2');
	    let passwordFieldType = passwordField.attr('type');
	    if(passwordFieldType == 'password')
	    {
	    	passwordField.attr('type', 'text');
	    	$(this).val('숨기기');
	    } else {
	    	passwordField.attr('type', 'password');
	    	$(this).val('보기');
	    }
	  });
	});
</script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script type="text/javascript" src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script>
$(function(){
	 $("#datepicker").datepicker({dateFormat: "yy-mm-dd"});

	});
</script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 

<style type="text/css">
div{
width:500px;
height:-24px;

}
.vertical-center {
	min-height: 100%;
	min-height: 100vh;
	display: flex;
	align-items: center;
}
button{
width:123px;
}
span{}
h2{
text-align:center;
color:;
}

#layout{
	vertical-align: top;
}
</style> 

 <script type="text/javascript"> 
 function goPage() { location.href="${pageContext.request.contextPath}/member/joinForm"; } 
 </script>
</head>
<body>
<header>
	<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
</header>
		<h2 class="text-dark">회원가입</h2>
			<div id="layout" class="container-fluid vertical-center justify-content-center">
			
				<form name="f" method="POST" action="${pageContext.request.contextPath }/member/join">
			<div id="container" class="container border border-danger" >
		<h6>아이디</h6>
			<div class="input-group mb-3">
 				<input type="text" class="form-control" name="id" id="id" placeholder="4~16자의 영문 소문자, 숫자만 사용가능합니다." aria-label="4~16자의 영문 소문자, 숫자만 사용가능합니다." aria-describedby="button-addon2">
  				<button type="button" id="idCheck" class="btn-danger btn-primary btn">id중복확인</button>
			</div>
            <div>
				<span class="check_font" id="id_check"></span>
				<span id="idResult"></span>
      		</div>
		<h6>비밀번호</h6>
			<div class="input-group mb-3">
  				<input type="password" class="form-control" name="password" id="password1"
  				 placeholder="4~16자의 영문 대소문자, 숫자만 사용가능합니다." aria-label="4~16자의 영문 대소문자, 숫자만 사용가능합니다." 
  				 aria-describedby="button-addon2">
  				<button type="button" id="showPassword" 
  				class="btn-danger btn-primary btn">show</button>
			</div>
			<div>
				<span class="check_font" id="pwd1_check"></span>
		    </div>
		<h6>비밀번호확인</h6>
		    <div class="input-group mb-3">
 				<input type="password" class="form-control" id="password2" placeholder="비밀번호확인" 
 				aria-label="비밀번호확인" aria-describedby="button-addon2">
  				<button type="button" id="showPassword1" 
  				class="btn-danger btn-primary btn">show</button>
			</div>
			<div>
				<span class="check_font" id="pwd2_check"></span>
			</div>
		<h6>이름</h6>
			<div class="input-group mb-3">
  				<input type="text" class="form-control" name="name" id="name" placeholder="2~6자의 한글만 사용가능합니다" aria-label="2~6자의 한글만 사용가능합니다."> 
			</div>
			<div>
				<span class="check_font" id="name_check"></span>
			</div>	 
		<h6>생일</h6>
			<div class="input-group mb-3">
 	 			<input type="text" class="form-control" name="birth" id="datepicker" placeholder="이곳을 눌러 생일을 선택해주세요." aria-label="이곳을 눌러 생일을 선택해주세요." aria-describedby="button-addon2" autocomplete="off">
			</div>
		<h6>성별</h6>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
  				<input type="radio" class="btn-check" name="gender" value="m" id="btnradio1" autocomplete="off">
  				<label class="btn btn-outline-danger" for="btnradio1">남자</label>

  				<input type="radio" class="btn-check" name="gender"  value="f" id="btnradio2" autocomplete="off">
  				<label class="btn btn-outline-danger" for="btnradio2">여자</label>
  			</div>
		<h6>주소</h6>
			<div class="input-group mb-3">
 				<input type="text" class="form-control" id="sample4_postcode" name="postalCode" placeholder="우편번호" aria-label="우편번호" aria-describedby="button-addon2">
  				<button type="button" onclick="sample4_execDaumPostcode()" class="btn-danger btn-primary btn">우편번호찾기</button>
			</div>
			<div class="input-group mb-3">
 				<input type="text" class="form-control" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" aria-label="도로명주소" aria-describedby="button-addon2">
			</div>
			<div class="input-group mb-3">
  				<input type="text" class="form-control" id="sample4_jibunAddress" name="address" placeholder="지번주소" aria-label="지번주소" aria-describedby="button-addon2">
				<span id="guide" style="color: #999"></span>
			</div>
				<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
				<script>function sample4_execDaumPostcode() {
								new daum.Postcode({oncomplete : function(data) {
									let fullRoadAddr = data.roadAddress;
									let extraRoadAddr = '';
									if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
										extraRoadAddr += data.bname;
										}
									if (data.buildingName !== '' && data.apartment === 'Y') {
										extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										}
									if (extraRoadAddr !== '') {
										extraRoadAddr = ' (' + extraRoadAddr + ')';
										}
									if (fullRoadAddr !== '') {
										fullRoadAddr += extraRoadAddr;
										}
										document.getElementById('sample4_postcode').value = data.zonecode;
										document.getElementById('sample4_roadAddress').value = fullRoadAddr;
										document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
									if (data.autoRoadAddress) {
									let expRoadAddr = data.autoRoadAddress + extraRoadAddr;
										document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
										} else if (data.autoJibunAddress) {
											let expJibunAddr = data.autoJibunAddress;
											document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
											} else {
												document.getElementById('guide').innerHTML = '';
												}
									}
								}).open();
								}
						</script>
			
		<h6>전화번호</h6>
			<div class="input-group mb-3">
  				<input type="text" class="form-control"  name="tel" id="tel" placeholder="전화번호를 작성해주세요. -표시는 제외" aria-label="전화번호를 작성해주세요.">
			</div>
			<div>
				<span class="check_font" id="tel_check"></span>
			</div>
		<h6>이메일</h6>
		<div class="input-group mb-3">
  			<input type="text" class="form-control" name="email" id="email"placeholder="이메일을 작성해주세요." aria-label="이메일을 작성해주세요.">
		</div>
		<div>
			<span class="check_font" id="email_check"></span>
		</div>
		<div>
    	    <button type="button" id="join" class="btn-danger btn-primary btn">회원가입</button>
    	    <button type="reset" id="reset" class="btn-danger btn-primary btn">재입력</button>
		</div>
		</div>
	</form>

	</div>
</body>
