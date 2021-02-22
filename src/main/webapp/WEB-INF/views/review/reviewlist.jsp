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
	function list(){
		
	}
</script>
</head>
<body>
   <h3>리뷰</h3>
   <form>
	<select onchange="list">
   		<option value="none">선택</option>   		
   		<option value="none">최신순</option>   		
	</select>
	<select>
		<option value="none">평점 별 정렬</option>
		<option value="none">★☆☆☆☆</option>
		<option value="none">★★☆☆☆</option>
		<option value="none">★★★☆☆</option>
		<option value="none">★★★★☆</option>
		<option value="none">★★★★★</option>
	</select>
   </form>
   <c:forEach var="r" items="${list}"> 
   <table border="1" cellspacing="0">
      <thead>
         <tr>
            <th>번호</th>
            <td>${r.num}</td>
         </tr>
           <tr>
            <th>상품번호</th>
            <td>${r.pnum}</td>
         </tr>
           <tr>
            <th>제목</th>
            <td><a href="${pageContext.request.contextPath }/review/reviewDetail?num=${r.num}">${r.title}</a></td>
         </tr>
         <tr>
         	<th>별점</th>
         	<td>${r.stars }</td>
         </tr>
           <tr>
            <th>작성자</th>
            <td>${r.writer}</td>
         </tr>
           <tr>
            <th>내용</th>
            <td>${r.content}</td>
         </tr>
           <tr>
            <th>작성날짜</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${r.pdate}" /></td>
         </tr>
         <tr>
         
          
      </thead>
     
    
     
   </table>
    </c:forEach>

   

</body>
</html>