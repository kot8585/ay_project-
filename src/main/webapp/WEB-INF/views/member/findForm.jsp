
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID/PWD 찾기 Page</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function checkEmpty(){
   
}   
$(document).ready(function(){
	$("#btn").hide();
   $("#find").click(function(){
      var email = document.getElementById("email");
      var name = document.getElementById("name");
      
      if(email.value == ""){
    	  alert("email주소를 입력해주세요.");
         return;
      }
      
      if(name.value == ""){
         alert("이름을 입력해주세요");
         return;
      }
      
      else{
          $.post("/member/find", {email: $("#email").val(), name: $("#name").val()})
             .done(function(data){
                if(data === "이메일 또는 이름이 등록되지 않았습니다."){
                   alert("등록되지 않은 이메일주소 또는 이름입니다.");
                   $("#findId").text(data);
                }else{
                	$("#findId").text(data);
                	$("#btn").show();
                }
             })
                
       }
   })
})
   
</script>
<style type="text/css">
div{
width:500px;
height:-24px;
margin:-5px;
}
.vertical-center {
	min-height: 100%;
	min-height: 100vh;
	display: flex;
	align-items: center;
}
button{
width:122px;
}

h2{
text-align:center;
color:;
}
#container{
	height: 200px;
}
</style> 

</head>
<body>
<header>
<script src="/js/loginSessionNotExist.js"></script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</header>
		<h2>ID/PWD 찾기</h2>
<p align="center">회원가입 시 입력한 E-mail주소와 이름을 입력해주세요.</p>
<div class="container-fluid vertical-top d-flex justify-content-center">

<form>
<div id="container" class="container border border-danger">
        <h6>이메일</h6>
		<div class="input-group mb-3">
  			<input type="text" class="form-control" name="email" id="email"placeholder="이메일을 작성해주세요." aria-label="이메일을 작성해주세요.">
		</div>
         <h6>이름</h6>
			<div class="input-group mb-3">
  				<input type="text" name="name" id="name" class="form-control" placeholder="2~6자의 한글만 사용가능합니다" aria-label="2~6자의 한글만 사용가능합니다."> 
			</div>
        	<div>
    	    	<button type="button" id="find" onclick="checkEmpty()" class="btn-danger btn-primary btn">찾기</button>
    	    	<button type="button" id="btn"  onclick="location.href='/member/loginForm'" class="btn-danger btn-primary btn">로그인</button>
    	   </div>
   </div>
<span id="findId"></span>
</form>
</div>
<div class="container-fluid vertical-center d-flex justify-content-center">
</div>
</body>
</html>