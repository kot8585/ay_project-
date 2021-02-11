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
<h3>카테고리 TODO</h3>
<hr>
<h3>이벤트 TODO</h3>
<hr>
<h3>전체 구매 이력</h3>
<c:import url="${ pageContext.request.contextPath }/admin/orderList"></c:import>
<hr>
<h3>전체 상품 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/productList"></c:import>
<hr>
<h3>전체 문의 목록</h3>
<%-- <c:import url="${ pageContext.request.contextPath }/admin/boardList"></c:import> --%>
<hr>
<h3>전체 고객센터 목록</h3>
<c:import url="${ pageContext.request.contextPath }/board/faq/list"></c:import>

</body>
</html>