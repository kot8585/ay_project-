<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   var number = 0;
   $(document).ready(function() {
		$("#stateBtn").click(function() {
			var check = prompt("변경할 상태를 입력하시오. 0 준비중 1 배송중 2 배송완료");
			alert("check : " + check + ", number : " + number);
			$.post("/admin/changeState", {num: $("#num"+number).val(), state: check});
			setTimeout(() => {
				location.href='${pageContext.request.contextPath}/admin/admin';
			}, 500);
		});
   });
   
   function setNum(num) {
		number = num;
   }
</script>

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
</head>
<body>
<c:if test="${empty list }">
 구매이력이 없습니다.
</c:if>
<c:if test="${not empty list }">
<table class="table table-bordered">
<thead class="table-warning">
	<tr>
		<th>num</th><th>img</th><th>m_id</th><th>p_num</th>
		<th>quantity</th><th>address</th><th>tel</th>
		<th>o_date</th><th>cost</th><th>state</th>
		<th>주문상태변경</th>
	</tr>
</thead>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td>${ p.m_id }</td>
	<td>${ p.p_num }</td>
	<td>${ p.quantity }</td>
	<td>${ p.address }</td>
	<td>${ p.tel }</td>
	<td>${ p.o_date }</td>
	<td>${ p.cost }</td>
	<td>
		<c:choose>
			<c:when test="${ p.state == 0 }">준비중</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${ p.state == 1 }">배송중</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${ p.state == 2 }">배송완료</c:when>
		</c:choose>
	</td>
	<td>
		<form method="post">
			<input type="hidden" id="num${ p.num }" value="${ p.num }">
			<input type="hidden" id="state${ p.num }" value="${ p.state }">
			<input type="button" value="주문상태변경${p.num}" 
			id="stateBtn" onclick="javascript:setNum(${p.num})">
		</form>
	</td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>