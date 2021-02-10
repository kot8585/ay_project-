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
		location.href="${pageContext.request.contextPath}/review/reviewForm?pnum="+i;
	}
</script>
</head>
<body>
<h3>주문내역</h3>
<c:if test="${empty list }">
 주문 내역이 없다. 
</c:if>
<c:if test="${not empty list }">
<table border="1">
<tr><th>num</th><th>m_idID</th><th>p_num</th><th>quantity</th><th>address</th><th>tel</th><th>o_date</th><th>cost</th><th>state</th><th>리뷰작성</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td><a href="${ pageContext.request.contextPath }/product/detail?num=${p.p_num}">${ p.m_id }</a></td>
	<td>${ p.p_num }</td>
	<td>${ p.quantity }</td>
	<td>${ p.address }</td>
	<td>${ p.tel }</td>
	<td>${ p.o_date }</td>
	<td>${ p.cost }</td>
	<td>${ p.state }</td>
	<td><input type="button" value="리뷰작성" onclick="go(${p.p_num})"></td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>