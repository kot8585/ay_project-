<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function go(i) {
	alert("click");
	location.href = "${pageContext.request.contextPath}/admin/boardDetail?num="+i;
}
</script>
</head>
<body>
<c:if test="${empty list }">
 작성된 글이 없습니다.
</c:if>
<c:if test="${not empty list }">
<a href="${ pageContext.request.contextPath }/admin/writeBoard">글쓰기</a>
<table border="1">
<tr><th>num</th><th>pwd</th><th>writer</th>
<th>title</th><th>content</th><th>b_date</th>
<th>답변하기</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td>${ p.pwd }</td>
	<td>${ p.writer }</td>
	<td>${ p.title }</td>
	<td>${ p.content }</td>
	<td>${ p.b_date }</td>
	<td><input type="button" value="답변하기" id="answerBtn" onclick="javascript:go(${p.num})"></td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>