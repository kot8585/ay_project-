<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Product Register</h1>
	<form action="${pageContext.request.contextPath }/admin/write" method="post"  enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>상품명</th><td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>제조사</th><td><input type="text" name="maker"></td>
			</tr>
			<tr>
				<th>가격</th><td><input type="text" name="price" ></td>
			</tr>
			<tr>
				<th>원산지</th><td><input type="text" name="origin" ></td>
			</tr>
			<tr>
				<th>원재료</th><td><input type="text" name="material" ></td>
			</tr>
			<tr>
				<th>재고</th><td><input type="text" name="quantity" ></td>
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
		<input type="hidden" name="imgPath" value="C:\\shopimg\\"> 
		<input type="hidden" name="event_num" value="0"> 
	</form>
</body>
</html>