<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 <title>Insert title here</title>
</head>
<body>
<!-- navbar -->
  <nav class="navbar fixed-top navbar-expand-lg fixed-top navbar-light bg-light mr-3"> 
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
      <ul class="navbar-nav md-auto">
	    <li class="nav-item active">
	        <a class="nav-link" href="#category">카테고리</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#event">이벤트</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#orderList">전체 구매 이력</a>
	    </li>
        <li class="nav-item active">
	        <a class="nav-link" href="#productList">전체 상품 목록</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#boardList">전체 문의 목록</a>
	    </li>
      </ul>
    </div>
</nav>


<h3 id="category">카테고리 TODO</h3>
<hr>
<h3 id="event">이벤트 TODO</h3>
<hr>
<h3 id="orderList">전체 구매 이력</h3>
<c:import url="${ pageContext.request.contextPath }/admin/orderList"></c:import>
<hr>
<h3 id="productList">전체 상품 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/productList"></c:import>
<hr>
<h3 id="boardList">전체 문의 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/boardList"></c:import>
</body>
</html>