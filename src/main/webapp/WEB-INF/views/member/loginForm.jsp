<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script type="text/javascript"> 
 function goPage() { location.href="${pageContext.request.contextPath}/member/joinForm"; } 
 </script>
 
<script type="text/javascript">
function go() {
	var id = document.getElementById("id");
	var password = document.getElementById("password");
	
	if(id.value == ""){
		alert("아이디 또는 비밀번호가0 액션빔")
		return
	}
	if(password.value == ""){
		alert("아이디 또는 비밀번호가 액션빔")
	}else{
		f.submit()
	}
}	
</script>
<script>
$(document).ready(function(){
  $('#showPassword').on('click', function(){
    var passwordField = $('#password');
    var passwordFieldType = passwordField.attr('type');
    if(passwordFieldType == 'password')
    {
    	passwordField.attr('type', 'text');
    	$(this).val('Hide');
    } else {
    	passwordField.attr('type', 'password');
    	$(this).val('Show');
    }
  });
});
</script>
<style type="text/css">
.table th {
    text-align: center;
}

.table {
    border-radius: 5px;
    width: 50%;
    margin: 0px auto;
    float: none;
}

.vertical-center {
  min-height: 100%;
  min-height: 100vh; 
  display: flex;
  align-items: center;
}

.table-bordered {
	border: 1px;
}
</style>
</head>
<body>
<!-- header부분 -->
<header>
<c:if test="${ empty id }">
	<script type="text/javascript" src="/js/headerSessionNotExist.js"></script>
</c:if>
<c:if test="${ not empty id }">
	<script type="text/javascript" src="/js/headerSessionExist.js"></script>
</c:if>
</header>
<!-- header 부분 -->

<div class="container-fluid vertical-center d-flex justify-content-center">
<form name="f" method="POST" action="${pageContext.request.contextPath }/member/login">
	<table class="table table-hover text-centered table-bordered" border="1">
		<thead class="table-dark">
			<tr>
				<th colspan="2">로그인</th>
			</tr>
		</thead>
		<tr>
			<th>ID</th>
			<td><input type="text" name="id" id="id"></td>
		</tr>
		<tr>
			<th>PWD</th>
			<td><input type="password" name="password" id="password">
			<input type="button" value="show" id="showPassword"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="로그인" onclick="go()" id="passwordCheck" >
				<a href="${pageContext.request.contextPath }/member/findForm">ID/PWD 찾기</a>
			</td>
		</tr>
	</table>
</form>

</div>
</body>
</html>