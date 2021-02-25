<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>	
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#del").click(function() {
		$("#f1").attr('action', '${ pageContext.request.contextPath }/pquestion/delpquestion');
		$("#f1").submit();
	});
});
</script>
</head>
<body>
<form id="f1" action="${ pageContext.request.contextPath }/pquestion/editpquestion" method="post">
   <table border="1" cellspacing="0">
      <thead>
         <tr>
            <th>번호</th>
            <td><input type="text" name="num" value="${pq.num}" readonly></td>
         </tr>
         <tr>
            <th>상품번호</th>
            <td><input type="text" name="pnum" value="${pq.pnum}" readonly></td>
         </tr>
         <tr>
            <th>작성자</th>
            <td>${pq.writer}</td>
         </tr>
         <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="${pq.title }"></td>
         </tr>
           
           <tr>
            <th>내용</th>
            <td><input type="text" name="content" value="${pq.content}"></td>
         </tr>
           <tr>
            <th>작성날짜</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${pq.p_date}" /></td>
         </tr>
         <tr>
         	<td colspan="2">
         		<input type="submit" value="수정">
         		<input type="button" value="삭제" id="del">
         	</td>
         </tr>
          
      </thead>
     
    
     
   </table>
   </form>
</body>
</html>