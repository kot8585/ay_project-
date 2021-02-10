<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
</head>
<body>
<h3>장바구니 </h3>
<c:if test="${empty list }">
 등록된 상품이 없다. 
</c:if>
<c:if test="${not empty list }">
<table border="1">
<tr><th>주문자ID</th><th>제품번호</th><th>가격</th><th>날짜</th><th>구매</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.m_id }</td>
	<td><a href="${ pageContext.request.contextPath }/product/detail?num=${ p.p_num}">${ p.p_num }</a></td>
	<td>${ p.cost }</td>
	<td>${ p.o_date }</td>

	<td>
	<!-- TODO : order/order에 p_num이 들어가게. -->
	<input type="hidden" id="p_num${ p.p_num }" value="${ p.p_num }">
	<input type="button" class="buy_btn" value="구매" onclick="javascript:num='${ p.p_num }'">
	</td>

</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>