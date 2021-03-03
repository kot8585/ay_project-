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
</head>
<body>
<h3>주문내역</h3>
<c:if test="${empty list }">
 주문 내역이 없다. 
</c:if>
<c:if test="${not empty list }">
<table border="1">
<tr><th>주문번호</th><th>상품이미지</th><th>상품명</th><th>상품번호</th><th>주문수량</th><th>주소</th><th>번호</th><th>주문날짜</th><th>주문액</th><th>주문상태</th><th>리뷰작성</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td><a href="${ pageContext.request.contextPath }/product/detail?num=${p.p_num}">${ p.p_name }</a></td>
	<td>${ p.p_num }</td>
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
</c:if>
</body>
</html>