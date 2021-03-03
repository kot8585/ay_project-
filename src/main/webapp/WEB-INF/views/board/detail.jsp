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
<script type="text/javascript" src="/js/header.js"></script>
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

<c:if test="${sessionScope.id eq 'admin' }">
	<c:set var="authority" value="readonly" />
</c:if>


<header>
<c:if test="${ empty id }">
	<script type="text/javascript" src="/js/headerSessionNotExist.js"></script>
</c:if>
<c:if test="${ not empty id }">
	<script type="text/javascript" src="/js/headerSessionExist.js"></script>
</c:if>
</header>
<!-- header 부분 -->
<c:set var="authority" value="readonly" />

	<form action="${pageContext.request.contextPath }/board/edit" method="post">
		<table border="1" cellspacing="0">
				
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" value="${b.writer}" readonly></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${b.title}" ${data} ${authority}></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content"  rows="15" cols="40" ${authority}>${b.content}</textarea></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><input type="text" name="updatedate" value="${b.updatedate}" readonly></td>
			</tr>
			<tr>
				<td>		
					<input type="hidden" name="type" value="${b.type}">
					
					<!-- 관리자만 수정 삭제 버튼 볼수 있음 -->
					<c:if test="${sessionScope.id eq 'admin' }">
						<input class="btn btn-primary" type="submit" value="수정" id="edit">
						<input class="btn btn-primary" type="button" value="삭제" id="del"> 
					</c:if>
					
					<!-- '목록으로' 누르면 들어오기전 페이지가 반영되도록 -->
					<form action="/board/${b.type}/list" method="get">
						<input type="hidden" name="num" value="${b.num}">
						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input class="btn btn-primary" type="submit" value="목록으로">
					</form>
				
				</td>
			</tr>
		</table>
	</form>
<hr>
	

</body>
</html>