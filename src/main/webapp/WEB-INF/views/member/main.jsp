

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

 <!-- navbar -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light ms-2">
    <a class="navbar-brand" href="${ pageContext.request.contextPath }/member/main">프로젝트명</a>
    <button class="navbar-toggler" 
		    type="button" 
		    data-bs-toggle="collapse" 
		    data-bs-target="#navbarSupportedContent" 
		    aria-controls="navbarSupportedContent" 
		    aria-expanded="false" 
		    aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto">
        <c:if test="${ empty sessionScope.id }">
	        <li class="nav-item active">
	          	<a class="nav-link" href="${ pageContext.request.contextPath }/member/loginForm">로그인</a>
	        </li>
        </c:if>
        <c:if test="${not empty sessionScope.id }">
        	<li class="nav-item">
          		<a class="nav-link" href="${ pageContext.request.contextPath }/member/logout">로그아웃</a>
        	</li>
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/mypage/mypage">마이페이지</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/board/faq/list">고객센터</a>
        </li>
        <li>
          <button type="button" class="btn btn-outline-primary me-2" onclick="goPage()">회원가입</button>
        </li>
      </ul>
    </div>
  </nav>
  <hr>
<c:import url="${ pageContext.request.contextPath }/event/list"></c:import>    
<hr>    
  
<c:import url="${ pageContext.request.contextPath }/product/list"></c:import>    
</body>
</html>