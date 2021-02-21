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
$(document).ready(function(){
   $("#delBtn").click(function(){
      alert("Clicked!");
      $.post("/event/del", 
    		  { num: $("#num").val() }
      ).done(function(data) {
			location.href = "${pageContext.request.contextPath}/admin/admin";
	  });
   });
});
</script>
</head>
<body>
<h3>이벤트 상세 정보</h3>
<form action="${ pageContext.request.contextPath }/event/edit" method="post" enctype="multipart/form-data">
<table border="1" cellspacing="0">
<tr>
	<th>번호</th>
	<td><input type="text" id="num" name="num" value="${e.num }" readonly></td>
</tr>
<tr>
	<th>이벤트명</th>
	<td><input type="text" name="name" value="${e.name }"></td>
</tr>
<tr>
     <th>기존 이미지</th>
     <td>
	     <c:if test="${empty e.imgPath }">
	         	등록된 이미지가 없습니다.
	     </c:if> 
         <c:if test="${not empty e.imgPath }">
               <table>
                  <tr>
                     <td colspan="3">
                     <img id="bigImg" src="${pageContext.request.contextPath }/event/img?fname=${e.imgPath}&num=${e.num }" 
                     style="width:300px;height:60px"></td>
                  </tr>
               </table>
         </c:if>
     </td>
</tr>
<tr>
     <th>새 이미지</th>
     <td>
	     <input type="file" name="file">
     </td>
</tr>
<tr>
	<th>할인률</th>
	<td><input type="text" name="sale" value="${e.sale }"></td>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="수정"> 
		<input type="button" value="삭제" id="delBtn">
	</td>
</tr>
</table>
</form>
</body>
</html>