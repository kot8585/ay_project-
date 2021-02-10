<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>문의내역</h3>
<c:if test="${empty list }">
 등록된 문의가 없다. 
</c:if>
<c:if test="${not empty list }">
<table>
<tr><th>num</th><th>pwd</th><th>writer</th><th>title</th><th>content</th><th>path</th><th>답변보기</th>
<c:forEach var="p" items="${list }">
<tr>
	<td>${ p.num }</td>
	<td>${ p.pwd }</td>
	<td>${ p.writer }</td>
	<td><a href="${ pageContext.request.contextPath }/board/detail?num=${ p.num }">${ p.title }</a></td>
	<td>${ p.content }</td>
	<td>${ p.path }</td>
	<td><input type="button" value="답변보기"></td>
</tr>
<!-- 추후 아래에 td을 생성하여 문의답변을 바로 확인하도록 만듦 -->
</c:forEach>
</table>
</c:if>
</body>
</html>