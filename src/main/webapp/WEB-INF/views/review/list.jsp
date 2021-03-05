<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>


<c:forEach var="r" items="${list}">
<div>
<hr class="bg-danger" size="5px">
	${r.writer } 님<br>
	<div>
		<span class="text-danger">${r.stars }</span> <fmt:formatDate pattern="yyyy-MM-dd" value="${r.pdate}" /><br>
	</div><br>
	<a href="${pageContext.request.contextPath }/review/reviewDetail?num=${r.num}" class="text-secondary">${p.name }</a><br><br>
    <img src="${pageContext.request.contextPath }/review/img?fname=${r.path }&num=${r.num }" style="width:150px;height:150px" onclick="newImg()">
    <img src="${pageContext.request.contextPath }/review/img?fname=${r.path2 }&num=${r.num }" style="width:150px;height:150px">
    <br>
    ${r.content }
    <br>
    <br>
	<div class="btn-group" role="group" aria-label="Basic exmaple">
		<button class="btn btn-danger" id="like" value="like" onclick="rating('like', ${r.num})">종아요</button>
		<button class="btn btn-danger" id="hate" value="hate" onclick="rating('hate', ${r.num})">싫어요</button>
	</div>
	<span id="rating${r.num }">${r.likey }</span> 명이 좋아합니다. 
</div>
</c:forEach>