<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function go(i){
		location.href="${pageContext.request.contextPath}/product/detail?num="+i;
	}
</script>
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<style type="text/css">
.table-layout {
	width: 80%;
	margin: 0 auto;
}
</style>
</head>
<body>
<h3 align="center">장바구니</h3>
<c:if test="${empty list }">
<p align="center">등록된 상품이 없다.</p> 
</c:if>
<c:if test="${not empty list }">
<div class="table-layout">
<table class="table table-bordered" border="1">
<thead class="table-danger">
<tr align="center" valign="middle"><th>주문자ID</th><th>이미지</th><th>상품명</th><th>가격</th><th>날짜</th><th>주문하러가기</th></tr>
</thead>
<c:forEach var="p" items="${list }">
<tr align="center" valign="middle">
	<td>${ p.m_id }</td>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td>${ p.p_name }</td>
	<td>${ p.cost }</td>
	<td>${ p.o_date }</td>
	<td><input type="button" value="즉시주문" onclick="go(${p.p_num})"></td>
</tr>
</c:forEach>
</table>
</div>
</c:if>
</body>
</html>