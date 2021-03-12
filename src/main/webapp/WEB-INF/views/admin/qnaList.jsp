<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 <style type="text/css">
 .table-warning tr th {
 	text-align: center;
 }
 </style>
<script type="text/javascript">
function go(i) {
	alert("click");
	location.href = "${pageContext.request.contextPath}/qna/detail?num="+i;
}
</script>	
</head>
<body>
<c:if test="${empty list }">
 작성된 글이 없습니다.
</c:if>
<c:if test="${not empty list }">

<table class="table table-bordered">
<thead class="table-warning" >
<tr align="center"><th>글번호</th><th>작성자</th><th>글제목</th><th>글내용</th><th>답변상황</th><th>작성날짜</th><th>답변하기</th></tr>
</thead>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td>${ p.writer }</td>
	<td>${ p.title }</td>
	<td>${ p.content }</td>
	<td>${ p.updatedate }</td>
	<td>${ p.state }</td>
	<td><input type="button" value="답변하기" id="answerBtn" onclick="javascript:go(${p.num})"></td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>