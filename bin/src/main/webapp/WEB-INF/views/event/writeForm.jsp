<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>Write</p>
	<form action="${pageContext.request.contextPath }/event/write" method="post"  enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>이벤트명</th><td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>이미지(1000x500 건장)</th><td><input type="file" name="file"></td>
			</tr>
			<tr>
				<th>할인가</th><td><input type="text" name="sale" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="등록"><input type="reset" value="취소"></td>
			</tr>
		</table>
		<input type="hidden" name="imgPath" value="C:\\shopimg\\e"> 
	</form>
</body>
</html>