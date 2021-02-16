
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
               alert(data);
               if(data == "등록되지 않은 이메일주소 또는 이름입니다."){
                  alert("등록되지 않은 이메일주소 또는 이름입니다.");
               }
               $("#findId").text(data);
               
            })
      }
      
      
   })
})
   
</script>
</head>
<body>
<header>
<a href="${pageContext.request.contextPath }/member/main">Main</a>
<a href="${pageContext.request.contextPath }/member/loginForm">Login</a>
</header>
<h3>ID/PWD 찾기</h3>
<p>회원가입 시 입력한 E-mail주소와 이름을 입력해주세요.
<form>
   <table border="1">
      <tr>
         <th>EMAIL</th>
         <td><input type="text" name="email" id="email"></td>
      </tr>
      <tr>
         <th>NAME</th>
         <td><input type="text" name="name"id="name"></td>
      </tr>
      <tr>
         <td colspan="2"><input type="button" id="find" value="find" onclick="checkEmpty()"></td>
      </tr>
   </table>
</form>
<div id="findId"></div>
</body>
</html>