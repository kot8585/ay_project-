<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="POST" action="${pageContext.request.contextPath }/admin/login">
	<table border="1">
		<tr>
			<th>ID</th>
			<td><input type="text" name="id" id="id"></td>
		</tr>
		<tr>
			<th>PWD</th>
			<td><input type="password" name="password" id="password"></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="로그인" ></td>
		</tr>
	</table>
</form>
</body>
</html>