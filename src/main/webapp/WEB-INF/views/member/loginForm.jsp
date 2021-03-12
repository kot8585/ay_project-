<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function go() {
		var id = document.getElementById("id");
		var password = document.getElementById("password");
		if (id.value == "") {
			alert("아이디를 작성해주세요! ")
			return
		}
		if (password.value == "") {
			alert("비밀번호를 작성해주세요!")
			return
		} else {
			f.submit()
		}
	}
</script>
<style type ="text/css">
hr{
background-color:red;

}

input{
border:1px;
}

.vertical-center {
  min-height: 100%;
  min-height: 100vh; 
  display: flex;
  align-items: center;
}

h2{
text-align:center;
color;
}


 a:link { color: red; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}

#btn{
width:575px;
height:43px;
fontsize:30px;
}
</style>
</head>
<body>
	<header>
		<c:if test="${ empty id }">
			<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
		</c:if>
		<c:if test="${ not empty id }">
			<script type="text/javascript" src="/js/loginSessionExist.js"></script>
		</c:if>
	</header>
	<h2 class="text-danger">로그인</h2>
	<hr>
	<div class="container-fluid vertical-top d-flex justify-content-center">
	<form name="f" method="POST" action="${pageContext.request.contextPath }/member/login">
	<div id="container" class="container">
		<div class="input-group mb-3 input-group-lg">
      		<div class="input-group-prepend"></div>
      		<input class="form-control" type="text" name="id" id="id" placeholder="아이디를 입력해주세요.">
      	</div>
    	<div class="input-group mb-3 input-group-lg">
      		<div class="input-group-prepend"></div>
      		<input class="form-control" type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요.">
    	</div>
		
		<div class="card card-outline-secondary my-4">
			<button class="btn btn-danger" id="btn" onclick="go()">로그인</button>
		</div>
		<a id="link1" href="${pageContext.request.contextPath }/member/findForm">ID/PWD찾기</a> |
		<a id="link1" href="${pageContext.request.contextPath }/member/joinForm">회원가입</a>
		</div>
	</form>
	</div>
</body>
</html>
