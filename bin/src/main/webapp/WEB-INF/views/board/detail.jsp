<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
//댓글 전부 출력하는 함수 - 재사용성을 위해
function showReplyList(){ 
		$.ajax({
			url : "${pageContext.request.contextPath}/rep/list",
			  dataType: "json",
				    type: "POST",
				    data : {"board_num" : "${b.num}"},
				    success: function (result) {
						var htmls ="";
						if(result.length < 1){

							htmls+="답변대기상태입니다."

						} else{ //javascript:void(0) : 링크이동을 하지 않기위해
							$(result).each(function(){
								htmls+=this.content+"(작성자:"+this.writer+")<br>";

								htmls+="<hr>"
						});
						}
						$("#replyList").html(htmls);
				     }
		});
}

	$(document).ready(function(){
		
		showReplyList();
		
		//이미지에 마우스 올릴때
	      $(".img").mouseover(function() {
	          $("#bigImg").attr('src', this.src);
	       });
		
		//게시판 삭제
		$("#edit").click(function(){
			var result = confirm("글을 삭제하시겠습니까?");
			if(result){
				location.href = "${pageContext.request.contextPath}/board/del?num=${b.num}";
			}
		});
		

	});
</script>
</head>
<body>


	<c:if test="${sessionScope.id ne b.writer }">
		<c:set var="data" value="readonly" />
	</c:if>
	<form action="${pageContext.request.contextPath }/board/edit" method="post">
		<table border="1" cellspacing="0">
		
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" value="${b.writer}"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${b.title}" ${data}></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input type="text" name="content" value="${b.content}" ${data}></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><input type="text" name="b_date" value="${b.b_date}"></td>
			
			</tr>
		<tr>
         <th>이미지</th>
         <td><c:if test="${empty file0 }">
               등록된 이미지가 없습니다.
               </c:if> 
               <c:if test="${not empty file0 }">
               <table>
                  <tr>
                     <td colspan="3">
                     <img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${b.num }" 
                     style="width:150px;height:150px"></td>
                  </tr>
                  <tr>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${b.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file1 }&num=${b.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file2 }&num=${b.num }" class="img" width="50" height="50"></td>
               </table>
            </c:if></td>
      </tr>
		
		</table>
			<input type="hidden" name="num" value="${b.num}">
			<input type="hidden" name="pwd" value="${b.pwd}">
			
			<!-- 작성자만 수정, 삭제 버튼 뜨게 하기 -->
			<c:if test="${sessionScope.id eq b.writer}">
				<input type="submit" value="수정하기">
				<input type="button" value="삭제하기" id="edit">
			</c:if>

	</form>
<hr>
	
	<!-- 댓글 작성되면 이 영역에 넣는다 -->
	<h6>Reply List</h6>
	<div id="replyList"></div>

</body>
</html>