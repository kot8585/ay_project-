<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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

<script>
$(document).ready(function() {
	$("#pwdcheck").click(function () {
		if(${sessionScope.id} === null){
			alert("로그인 먼저 해주세요");
		}else{
			if($("#password").val() == ""){
				alert("비밀번호를 입력해주세요");
				return
			}else{
				f.submit();
			}	
		}
		
		
	});
	$("")
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

.table td {
	width: 30%
}
</style>
<body>
<header>
<c:if test="${ empty id }">
	<script type="text/javascript" src="/js/headerSessionNotExist.js"></script>
</c:if>
<c:if test="${ not empty id }">
	<script type="text/javascript" src="/js/headerSessionExist.js"></script>
</c:if>
</header>
<form name="f" method="post" action="${pageContext.request.contextPath }/member/editpwdCheck">
<table class="table table-bordered">
				<thead class="table-dark">
<tr>
<td colspan="2">비밀번호확인</td>
</tr>
</thead>
<tr>
<td>비밀번호</td>
<td><input type="password" name="password" id="password"></td>
</tr>
<tr>
<td colspan="2"><input onclick="check()" type="button" value="확인" id="pwdcheck"></td>
</tr>
</table>
</form>
</body>
</html>