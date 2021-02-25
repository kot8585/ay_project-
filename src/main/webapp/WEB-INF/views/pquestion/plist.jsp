<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
// function go(i){
// 	location.href="${pageContext.request.contextPath}/pquestion/pquestionForm?pnum="+i;
// }

</script>
</head>
<body>

	<h3>상품문의</h3>
	
	<table border="1" cellspacing="0">
		<thead>
			<tr>
				<th>번호</th>
				<th>상품번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>내용</th>
				<th>작성날짜</th>		
			</tr>
		</thead>
		<c:forEach var="pq" items="${plist}">
			<tr>
				<td>${pq.num }</td>
				<td>${pq.pnum }</td>
				<td><a href="${pageContext.request.contextPath }/pquestion/pDetail?num=${pq.num } ">${pq.title} </a></td>
				<td>${pq.writer}</td>
				<td>${pq.content }</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${pq.p_date}" /></td>
<%-- 				<td><input type="button" value="상품문의작성" onclick="go(${pq.pnum})"></td> --%>
			</tr>
		</c:forEach> 
		<tr><td>
<%-- 		<input type="button" value="상품문의작성"  onclick="go(${plist.pnum})"> --%>
		</td></tr>

	
	</table>
	
	
	
	
	

</body>
</html>