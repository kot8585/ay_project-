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
	location.href = "${pageContext.request.contextPath}/admin/pqDetail?num="+i;
}
</script>
</head>
<body>
<c:if test="${empty plist }">
 작성된 글이 없습니다.
</c:if>
<c:if test="${not empty plist }">

<table class="table table-bordered">
<thead class="table-warning" >
<tr><th>번호</th><th>작성자</th>
<th>제목</th><th>내용</th>
<th>답변상태</th><th>답변하기</th>
	</tr>
</thead>
<c:forEach var="pq" items="${plist }">
<tr>
	<td>${ pq.num }</td>
<%-- 	<td>${ pq.pwd }</td> --%>
	<td>${ pq.writer }</td>
	<td>${ pq.title }</td>
	<td>${ pq.content }</td>
<%-- 	<td>${ pq.updatedate }</td> --%>
<%-- 	<td>${ pq.state }</td> --%>
	<td><input type="button" value="답변하기" id="answerBtn" onclick="javascript:go(${pq.num})"></td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>