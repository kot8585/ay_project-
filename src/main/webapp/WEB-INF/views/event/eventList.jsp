<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

</head>
<body>
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
  	<c:forEach var="length" items="${lengths}" varStatus="vs">
  		<c:if test="${ vs.first }">
  			 <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${ length }" class="active" aria-current="true" aria-label="Slide ${ length+1 }"></button>
  		</c:if>
  		<c:if test="${ not vs.first }">
  		 	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${ length }" aria-label="Slide ${ length+1 }"></button>
  		</c:if>
  	</c:forEach>
  
  </div>
  
  <div class="carousel-inner">
  <c:forEach var="e" items="${list}" varStatus="vs">
  	<c:if test="${vs.first }">
	  	<div class="carousel-item active">
	      <img src="${pageContext.request.contextPath }/event/img?fname=${e.imgPath }&num=${e.num}" class="d-block w-100" alt="e1" style="width:1000px;height:500px">
	    </div>
  	</c:if>
  	<c:if test="${not vs.first }">
	    <div class="carousel-item">
	      <img src="${pageContext.request.contextPath }/event/img?fname=${e.imgPath }&num=${e.num}" class="d-block w-100" alt="e2" style="width:1000px;height:500px">
	    </div>
	</c:if>    
  	</c:forEach>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</body>
</html>