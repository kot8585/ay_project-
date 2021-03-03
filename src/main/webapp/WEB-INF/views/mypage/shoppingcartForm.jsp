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
</head>
<body>
<h3>장바구니 </h3>
<c:if test="${empty list }">
 등록된 상품이 없다. 
</c:if>
<c:if test="${not empty list }">
<table border="1">
<tr><th>주문자ID</th><th>이미지</th><th>상품명</th><th>가격</th><th>날짜</th><th>주문하러가기</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.m_id }</td>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td>${ p.p_name }</td>
	<td>${ p.cost }</td>
	<td>${ p.o_date }</td>
	<td><input type="button" value="즉시주문" onclick="go(${p.p_num})"></td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>