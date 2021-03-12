

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
 <title>Insert title here</title>
 <script type="text/javascript"> 
 function goPage() { location.href="${pageContext.request.contextPath}/member/joinForm"; } 
 </script>
<link rel="shortcut icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<link rel="icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
</head>
<body>
<!-- header부분 -->
<header>
<c:if test="${ empty id }">
	<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
</c:if>
<c:if test="${ not empty id }">
	<script type="text/javascript" src="/js/loginSessionExist.js"></script>
</c:if>
</header>
<!-- header 부분 -->
<c:import url="${ pageContext.request.contextPath }/event/list"></c:import>    
  
         
<c:import url="${ pageContext.request.contextPath }/product/list"></c:import>

    
</body>
</html>