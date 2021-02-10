

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<c:if test="${empty sessionScope.id}">
<a href="${ pageContext.request.contextPath }/member/loginForm">로그인</a>
</c:if>
<c:if test="${not empty sessionScope.id}">
  ${sessionScope.id } 어서오고
</c:if>
<a href="${ pageContext.request.contextPath }/member/joinForm">회원가입</a>
<a href="${ pageContext.request.contextPath }/mypage/mypage">마이페이지</a>
<a href="${ pageContext.request.contextPath }/board/list">고객센터</a><br>



<c:import url="${ pageContext.request.contextPath }/product/list"></c:import>
</body>
</html>