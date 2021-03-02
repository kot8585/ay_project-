<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="shortcut icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<link rel="icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script>
var sessionId = '<%=session.getAttribute("id") %>'
   $(document).ready(function(){ //한글확인하기
      $("#qnaWrite").click(function(){
         if(sessionId == '' || sessionId == 'null'){
         alert("로그인을 먼저 해주세요");
         location.href= "${pageContext.request.contextPath }/member/loginForm";
      } else {
         
         location.href="${pageContext.request.contextPath }/qna/QuestionForm";
      }});
   
   
var actionForm = $("#actionForm")
   //페이지 번호 누르면 동작
   	 $(".page-item a").on("click", function(e){
   		 e.preventDefault();
   		 console.log("click");
   		 
   		 actionForm.find("input[name='pageNum']").val($(this).attr("href"));
   		 actionForm.submit();
   	 });
   	
   	var searchForm = $("#searchForm");
   	$("#searchForm button").on("click", function(){
   		if(!searchForm.find("input[name='keyword']").val()){
   			alert("키워드를 입력하세요");
   			return false;
   		}
   		
   		searchForm.submit();
   	});
   	 
   });

</script>
</head>
<body>
<!-- header부분 -->
<header>
<script type="text/javascript" src="/js/header.js"></script>
</header>
<!-- header 부분 -->
  
  
<!-- visual 부분 -->
<nav class="navbar navbar-light bg-light">
  <div class="container-fluid">
    <h1>고객센터</h1>
    
    <!-- 검색하기 -->
    <form class="d-flex" id="searchForm" action="/board/faq/list" method='get'>
      <input class="form-control me-2" name="keyword" type="search" placeholder="자주묻는 질문검색" aria-label="Search">
      <button class="btn btn-outline-success">search</button>
    </form>
    
    <button type="button" id="qnaWrite" class="btn btn-lg btn-primary">1:1문의하기</button>
  </div>
</nav>

<nav class="nav nav-pills nav-fill">
  <a class="nav-link ${type == 'faq'? 'active' : '' }" aria-current="page" href="${pageContext.request.contextPath }/board/faq/list">자주묻는 질문</a>
  <a class="nav-link ${type == 'notice'? 'active' : '' }" href="${pageContext.request.contextPath }/board/notice/list">공지사항</a>
</nav>

	
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
<nav aria-label="Page navigation example">
   <ul class="pagination justify-content-center">
  
  <c:if test="${pageMaker.prev }">
    <li class="page-item">
      <a class="page-link" href="${pageMaker.startPage-1 }" aria-label="Previous">
        <span aria-hidden="true">&lt;</span>
      </a>
    </li>
   </c:if>

  <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : '' } ">
    	<a class="page-link" href="${num}">${num }</a>
    </li>
  </c:forEach>    
  
  
  <c:if test="${pageMaker.next }">
    <li class="page-item">
      <a class="page-link" href="${pageMaker.endPage+1 }" aria-label="Next">
        <span aria-hidden="true">&gt;</span>
      </a>
    </li>
   </c:if>
  </ul>
</nav>

	
	<!-- 페이지 번호를 누르면 실제로 동작하는 부분 -->
	<form id="actionForm" action="/board/${type}/list" method='get'>
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form> 
</body>
</html>