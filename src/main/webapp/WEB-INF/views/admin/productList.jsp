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
 등록된 상품이 없습니다.
 <a href="${pageContext.request.contextPath }/admin/write">새 상품 등록</a>
</c:if>
<c:if test="${not empty list }">

<table class="table table-bordered">
<thead class="table-warning" >
	<tr>
		<th>num</th><th>img</th><th>name</th><th>maker</th>
		<th>price</th><th>origin</th><th>material</th>
		<th>quantity</th><th>imgPath</th><th>event_num</th>
		<th>상품관리</th>
	</tr>
</thead>

<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<!-- 김평기 : 이미지 추가함. -->
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.num}" style="width:60px;height:60px"></td>
	<td>${ p.name }</td>
	<td>${ p.maker }</td>
	<td>${ p.price }</td>
	<td>${ p.origin }</td>
	<td>${ p.material }</td>
	<td>${ p.quantity }</td>
	<td>${ p.imgPath }</td>
	<td>${ p.event_num }</td>
	<td><a href="${pageContext.request.contextPath }/admin/detail?num=${p.num}">상품관리</a></td>
</tr>
</c:forEach>
</table>
<div align="right"><a href="${pageContext.request.contextPath }/admin/write">새 상품 등록</a></div>
</c:if>
</body>
</html>
