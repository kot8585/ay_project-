<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Form</title>
</head>
<body>


<form action="${pageContext.request.contextPath }/review/write">
	<table border="1">
		<tr>
			<th>한 줄 요약</th>
			<td><input type="text" name="title"></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="writer" value="${sessionScope.id }" readonly></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" cols="50" rows="50"></textarea></td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<input type="radio" name="stars" value="★☆☆☆☆">★
				<input type="radio" name="stars" value="★★☆☆☆">★★
				<input type="radio" name="stars" value="★★★☆☆">★★★
				<input type="radio" name="stars" value="★★★★☆">★★★★
				<input type="radio" name="stars" value="★★★★★">★★★★★
			</td>
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