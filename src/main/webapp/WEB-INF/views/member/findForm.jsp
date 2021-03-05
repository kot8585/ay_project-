
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
</head>
<body>
<header>
<script src="/js/header.js"></script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</header>
<p align="center">회원가입 시 입력한 E-mail주소와 이름을 입력해주세요.</p>
<div class="container-fluid vertical-center d-flex justify-content-center">
<form>
   <table class="table table-hover text-centered table-bordered" border="1">
		<thead class="table-dark">
		<tr>
		<th colspan="2">ID/PWD 찾기</th>
		</tr>
		</thead>
      <tr>
         <th>이메일</th>
         <td><input type="text" name="email" id="email"></td>
      </tr>
      <tr>
         <th>이름</th>
         <td><input type="text" name="name"id="name"></td>
      </tr>
      <tr>
         <td colspan="2"><input type="button" id="find" value="찾기" onclick="checkEmpty()">
         <input type="button" id="btn" value="로그인" onclick="location.href='/member/loginForm'">
      </td>
      </tr>
      
   </table>
</form>

</div>
<div class="container-fluid vertical-center d-flex justify-content-center">
<span id="findId"></span>
</div>
</body>
</html>