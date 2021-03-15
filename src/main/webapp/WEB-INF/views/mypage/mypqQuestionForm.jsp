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

<style type="text/css">
.table-layout {
	width: 80%;
	margin: 0 auto;
}

</style>
</head>
<body>
<h3 align="center">상품문의내역</h3>
<c:if test="${empty plist }">
<p align="center">등록된 문의가 없다.</p> 
</c:if>
<c:if test="${not empty plist }">
<div class="table-layout">
<table class="table table-bordered">
<!-- c:out 사용 이유 : https://2ham-s.tistory.com/274 -->
<thead class="table-danger">
<tr align="center"><th>글번호</th><th>작성자</th><th>글제목</th><th>글내용</th><th>답변상황</th><th>작성날짜</th></tr>
</thead>
<c:forEach var="pq" items="${plist }">
<tr align="center" valign="middle">
	<td><c:out value="${ pq.num }"/></td>
	<td><c:out value="${ pq.writer }"></c:out></td>
	<td><a href="${ pageContext.request.contextPath }/pquestion/detail?num=${ pq.num }"><c:out value="${ pq.title }" /></a></td>
	<td>${ pq.content }</td>
	<td>${ pq.state }</td>
	<td>${ pq.p_date }</td>
</tr>
<!-- 추후 아래에 td을 생성하여 문의답변을 바로 확인하도록 만듦 -->
</c:forEach>
</table>
</div>
</c:if>
</body>
</html>