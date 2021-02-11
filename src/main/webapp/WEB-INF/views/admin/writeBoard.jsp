<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h1>공지사항 등록</h1>
	<form action="${pageContext.request.contextPath }/board/write" method="post">
		
		<table border="1">
			<tr>
				<th>타입</th>
				<td><select>
						<option value="faq">자주묻는 질문</option>
						<option value="notice">공지사항</option>
					</select></td>
			</tr>
			<tr>
				<th>제목</th><td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th><td><textarea name="content" rows="10" cols="33" ></textarea></td>
			</tr>
		
			<tr><td><input type="reset" value="취소"></td>
			<td><input type="submit" value="등록"></td></tr>
		</table>
	</form>
</body>
</html>