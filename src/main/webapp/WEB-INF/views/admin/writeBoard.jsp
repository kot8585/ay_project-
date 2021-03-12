<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Red House</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style type ="text/css">
	h2{text-align:center;}
</style>

<script>
$(document).ready(function(){
	$("#del").click(function(){
		location.href="${pageContext.request.contextPath }/board/${b.type}/del?num=${b.num}";
	});
});
</script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

</head>
<body>
	<header>
	<c:if test="${empty sessionScope.id }">
		<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
	</c:if>
	<c:if test="${not empty sessionScope.id }">
		<script type="text/javascript" src="/js/loginSessionExist.js"></script>
	</c:if>
	</header>
	
	<h2>고객센터 공지사항 등록</h2>
	<div class="container">
		<form action="${pageContext.request.contextPath }/admin/writeBoard" method="post">
			<div class="card card-outline-secondary my-4">
				<div class="card-header">
					<label class="form-label">타입</label>
					<select class="form-control" name="type">
						<option value="" selected="selected">--타입을 선택해주세요--</option>
						<option value="faq">자주묻는 질문</option>
						<option value="notice">공지사항</option>
					</select>
				</div>
				<div class="card-header">
					<label class="form-label">제목</label>
					<input class="form-control" type="text" name="title">
				</div>
				<div class="card-header">
					<label class="form-label">내용</label>
					<textarea class="form-control" name="content" rows="10" cols="33" ></textarea>
				</div>
			</div>
			<div align="center" style="none;">
				<input class="btn btn-danger" type="reset" value="취소">
				<input class="btn btn-danger" type="submit" value="등록">
				<input type="hidden" name="writer" value="${sessionScope.id }" >
			</div>
		</form>
	</div>
</body>
</html>