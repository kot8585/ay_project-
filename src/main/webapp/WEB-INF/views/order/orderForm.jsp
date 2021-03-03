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

 <!-- 인터넷 익스플로러에서 랜더링되는 방식 중 ie edge는 최신의 표준 버젼으로 랜더링해달라. -->
 <meta http-equiv="X-UA-Compatible" content="ie=edge">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

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
<h3>주문정보</h3>
<table border="1" cellspacing="0">
	<tr>
		<th>제품명</th><th>주문수량</th><th>가격</th><th>결제금액</th>
	</tr>
	<tr>
		<td>${ order.p.name }</td><td>${ order.quantity }</td><td>${ order.p.price }</td><td>${ order.quantity * order.p.price }</td>
	</tr>
</table>
<form action="${ pageContext.request.contextPath }/order/order" method="post">
배송지 주소 : <input type="text" name="address" value="${ order.m.address }"><br>
받을 사람 전화번호 : <input type="text" name="tel" value="${ order.m.tel }"><br>
<input type="submit" value="결제">
<input type="hidden" name="m_id" value="${ sessionScope.id }">
<input type="hidden" name="p_num" value="${ order.p_num }">
<input type="hidden" name="quantity" value="${ order.quantity }">
<input type="hidden" name="cost" value="${ order.quantity * order.p.price  }">
<input type="hidden" name="state" value="0">
</form>
</body>
</html>