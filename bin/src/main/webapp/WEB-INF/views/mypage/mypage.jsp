<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<a href="${ pageContext.request.contextPath }/member/main">메인으로</a>
<a href="${ pageContext.request.contextPath }/member/logout">로그아웃</a>
<a href="${ pageContext.request.contextPath }/member/out">회원탈퇴</a>
<a href="${ pageContext.request.contextPath }/member/editForm">내정보수정</a>
<br>
<hr>
<c:import url="${ pageContext.request.contextPath }/mypage/myOrderForm"></c:import>
<hr>
<br>
<c:import url="${ pageContext.request.contextPath }/mypage/myQuestionForm"></c:import>
<hr>
<br>
<c:import url="${ pageContext.request.contextPath }/mypage/shoppingcartForm"></c:import>
<hr>
<br>
</body>
</html>