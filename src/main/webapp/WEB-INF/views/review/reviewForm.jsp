<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="${pageContext.request.contextPath }/review/write">
<table border="1">
<tr>
<td>제목<td>
<td><input type="text" name="title"><td>
</tr>
<tr>
<td>작성자<td>
<td><input type="text" name="writer" value="${sessionScope.id }" readonly><td>
</tr>
<tr>
<td>내용<td>
<td><textarea name="content" cols="50" rows="50"></textarea><td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="작성">
<input type="reset" value="지우기">
<input type="hidden" name="pnum" value="${p.num }">

</td>
</tr>
</table>
</form>
</body>
</html>