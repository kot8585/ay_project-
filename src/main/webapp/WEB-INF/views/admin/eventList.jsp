<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 <style type="text/css">
 .table-warning tr th {
 	text-align: center;
 }
 </style>
<title>Insert title here</title>
</head>
<body>
<c:if test="${empty list }">
 등록된 이벤트가 없습니다.
 <a href="${pageContext.request.contextPath }/event/write">새 이벤트 등록</a>
</c:if>
<c:if test="${not empty list }">

<table class="table table-bordered">
<thead class="table-warning" >
	<tr>
		<th>이벤트번호</th><th>이벤트이미지</th><th>이벤트명</th><th>할인률</th><th>수정</th>
	</tr>
</thead>

<c:forEach var="e" items="${list }">
<tr>
	<td>${ e.num }</td>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/event/img?fname=${e.imgPath }&num=${e.num}" style="width:60px;height:60px"></td>
	<td>${ e.name }</td>
	<td>${ e.sale }</td>
	<td><a href="${pageContext.request.contextPath }/event/edit?num=${e.num}&file=${e.imgPath}">이벤트수정</a></td>
</tr>
</c:forEach>
</table>
<!-- TODO -->
<div align="right"><a href="${pageContext.request.contextPath }/event/write">새 이벤트 등록</a></div>
</c:if>
</body>
</html>