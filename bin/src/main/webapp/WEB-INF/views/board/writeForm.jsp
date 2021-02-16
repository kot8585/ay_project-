<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Board Register</h1>
	<form action="${pageContext.request.contextPath }/board/write" method="post"  enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>작성자</th><td><input type="text" name="writer" value="${sessionScope.id }"></td>
			</tr>
			<tr>
				<th>제목</th><td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>비밀번호</th><td><input type="password" name="pwd" ></td>
			</tr>
			
			<tr>
				<th>내용</th><td><textarea name="content" rows="10" cols="33" ></textarea></td>
			</tr>

			<tr>
				<th>파일첨부1</th><td><input type="file" name="file1"></td>
			</tr>
			<tr>
				<th>파일첨부2</th><td><input type="file" name="file2"></td>
			</tr>
			<tr>
				<th>파일첨부3</th><td><input type="file" name="file3"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="등록"><input type="reset" value="취소"></td>
			</tr>
		</table>
		<input type="hidden" name="path" value="123"> 
	</form>
</body>
</html>