<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function ordergo(i){
		location.href="${pageContext.request.contextPath}/review/reviewForm?pnum="+i;
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
<h3 align="center">주문내역</h3>
<c:if test="${empty list }">
<p align="center">주문 내역이 없다.</p> 
</c:if>
<c:if test="${not empty list }">
<div class="table-layout">
<table class="table table-bordered" border="1">
<thead class="table-danger">
<tr align="center"><th>주문번호</th><th>상품이미지</th><th>상품명</th><th>주문수량</th><th>주소</th><th>전화번호</th><th>주문날짜</th><th>주문액</th><th>주문상태</th><th>리뷰작성</th></tr>
</thead>
<c:forEach var="p" items="${list }">
<tr align="center" valign="middle">
	<th>${ p.num }</th>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td><a href="${ pageContext.request.contextPath }/product/detail?num=${p.p_num}">${ p.p_name }</a></td>
	<td>${ p.quantity }</td>
	<td>${ p.address }</td>
	<td>${ p.tel }</td>
	<td>${ p.o_date }</td>
	<td>${ p.cost }</td>
	<td>${ p.state }</td>
	<td><input type="button" value="리뷰작성" onclick="ordergo(${p.p_num})"></td>
</tr>
</c:forEach>
</table>
</div>
</c:if>
</body>
</html>