<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css" integrity="sha384-6pzBo3FDv/PJ8r2KRkGHifhEocL+1X2rVCTTkUfGk7/0pbek5mMa1upzvWbrUbOZ" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var sessionId = '<%=session.getAttribute("id") %>'
   $(document).ready(function(){ //한글확인하기
      $("#write").click(function(){
         if(sessionId == '' || sessionId == 'null'){
         alert("로그인을 먼저 해주세요");
         location.href= "${pageContext.request.contextPath }/member/loginForm";
      } else {
         
         location.href="${pageContext.request.contextPath }/qna/QuestionForm";
      }});
   
   
var actionForm = $("#actionForm")
   //페이지 번호 누르면 동작
   	 $(".paginate_button a").on("click", function(e){
   		 e.preventDefault();
   		 console.log("click");
   		 
   		 actionForm.find("input[name='pageNum']").val($(this).attr("href"));
   		 actionForm.submit();
   	 });
   });

</script>
</head>
<body>
<c:if test="${sessionScope.id ne 'admin'}">
<a href="${pageContext.request.contextPath }/member/main">Main</a>
	<h3>고객센터</h3>
</c:if>

	<ul class="nav nav-tabs nav-justified">
		<li><a href="${pageContext.request.contextPath }/board/faq/list">자주묻는 질문</a></li>
		<li><a href="${pageContext.request.contextPath }/board/notice/list">공지사항</a></li>
	</ul>
	
<c:if test="${sessionScope.id eq 'admin' }">
	<a href="${ pageContext.request.contextPath }/admin/writeBoard">글쓰기</a>
</c:if>


<!-- 글 목록 -->
<c:if test="${empty list }">
 작성된 글이 없습니다.
</c:if>

<c:if test="${not empty list }">
	<table class="table table-hover">
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
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${b.updatedate}" /></td>
			</tr>
		</c:forEach>
	</table>
</c:if>


<!-- 페이지 버튼 -->
	<nav aria-label="Page navigation">
  <ul class="pagination">
  
  <c:if test="${pageMaker.prev }">
    <li class="paginate_button prev">
      <a href="${pageMaker.startPage-1 }" aria-label="Previous">
        <span aria-hidden="true">&lt;</span>
      </a>
    </li>
   </c:if>

  <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
    <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' } ">
    	<a href="${num}">${num }</a>
    </li>
  </c:forEach>    
  
  
  <c:if test="${pageMaker.next }">
    <li class="paginate_button next">
      <a href="${pageMaker.endPage+1 }" aria-label="Next">
        <span aria-hidden="true">&gt;</span>
      </a>
    </li>
   </c:if>
  </ul>
</nav>


	<c:if test="${sessionScope.id ne 'admin'}">
	<input type="button" id ="write" value="1:1문의">
	</c:if>
	
	<!-- 페이지 번호를 누르면 실제로 동작하는 부분 -->
	<form id="actionForm" action="board/${type}/list" method='get'>
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form> 
</body>
</html>