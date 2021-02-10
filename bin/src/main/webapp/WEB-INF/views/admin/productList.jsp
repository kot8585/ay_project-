<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${empty list }">
 등록된 상품이 없습니다.
<a href="${pageContext.request.contextPath }/admin/write">새 상품 등록</a>
</c:if>
<c:if test="${not empty list }">
<a href="${pageContext.request.contextPath }/admin/write">새 상품 등록</a>
<table border="1">
<tr><th>num</th><th>img</th><th>name</th><th>maker</th>
<th>price</th><th>origin</th><th>material</th>
<th>quantity</th><th>imgPath</th><th>event_num</th>
<th>상품관리</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
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
</c:if>
</body>
</html>
