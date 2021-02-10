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
var sessionId = '<%=session.getAttribute("id") %>'

   $(document).ready(function(){ //한글확인하기
      $("#write").click(function(){
         if(sessionId == '' || sessionId == null){
         alert("로그인을 먼저 해주세요");
         location.href= "${pageContext.request.contextPath }/member/loginForm";
      } else {
         
         location.href="${pageContext.request.contextPath }/board/writeForm";
      }});
   });

</script>
</head>
<body>
<a href="${pageContext.request.contextPath }/member/main">Main</a>
	<h3>1:1 문의</h3>
	<table border="1" cellspacing="0">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
			</tr>
		</thead>
		<c:forEach var="b" items="${list}">
			<tr>

				<td><c:out value="${b.num}" /></td>
				<td><a href="${pageContext.request.contextPath }/board/detail?num=${b.num } ">${b.title} </a></td>
				<td><c:out value="${b.writer}" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${b.b_date}" /></td>
			</tr>
		</c:forEach>
	</table>

	세션 ID : <c:out value="${sessionScope.id}" />
	<input type="button" id ="write" value="글작성">

</body>
</html>