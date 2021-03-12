<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<style type="text/css">
.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: #fff;
    background-color: #dc3545;
    border-color: #6c757d;
}

.page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #dc3545;
    border-color: #dc3545;
}

a {
    color: black;
    text-decoration: none;
}

.page-link {
    position: relative;
    display: block;
    color: #6c757d;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ced4da;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

nav nav-pills nav-fill.nav-link {
  border: 1px solid #ced4da;
      font-size: 20px;
}

.nav-pills .nav-link {
    border: 1px solid #ced4da;
    
}
</style>

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
		   	
			//키워드 검색
		   	var searchForm = $("#searchForm");
		   	$("#searchForm button").on("click", function(){
		   		if(!searchForm.find("input[name='keyword']").val()){
		   			alert("키워드를 입력하세요");
		   			return false;
		   		}
		   		
		   		searchForm.submit();
		   	});
		   	
		   	//detail페이지로 이동할때 현재페이지번호와 amount를 전달해주기위해 실제 동작하는 부분을 따로 만듬
		   	$(".move").on("click", function(e){
		   		e.preventDefault();
		   		actionForm.append("<input name='num' type='hidden' value='"+$(this).attr('href')+"'>");
		   		actionForm.attr("action", "/board/detail");
		   		actionForm.submit();
		   	});
   	 
   });

</script>

</head>
<body>
<!-- header부분 -->
<header>
<c:if test="${empty sessionScope.id }">
	<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
</c:if>
<c:if test="${not empty sessionScope.id }">
	<script type="text/javascript" src="/js/loginSessionExist.js"></script>
</c:if>
</header>
<!-- header 부분 -->

<div class="container">  
<!-- visual 부분 -->
<nav class="navbar border navbar-light border-danger" >
  <div class="container-fluid">
    <h1 class="text-danger">고객센터</h1>
    
    <!-- 검색하기 -->
    <form class="d-flex" id="searchForm" action="/board/faq/list" method='get'>
      <input class="form-control me-2" name="keyword" type="search" placeholder="자주묻는 질문검색" aria-label="Search">
      <button class="btn btn-outline-danger">search</button>
    </form>

    <button type="button" id="qnaWrite" class="btn btn-lg btn-danger">1:1문의하기</button>
  </div>
</nav>


 <hr class='bg-danger'  size='5px'>

<nav class="nav nav-pills nav-fill ">

  <a class="nav-link ${type == 'faq'? 'active' : '' }" aria-current="page" href="${pageContext.request.contextPath }/board/faq/list">자주묻는 질문</a>
  <a class="nav-link ${type == 'notice'? 'active' : '' }" href="${pageContext.request.contextPath }/board/notice/list">공지사항</a>
</nav>

	

<br>
<!-- 글 목록 -->
<c:if test="${empty list }">
 작성된 글이 없습니다.
</c:if>

<c:if test="${not empty list }">
	<table class="table table-hover">

		<c:forEach var="b" items="${list}">
			<tr>

				<td><c:out value="${b.num}" /></td>
				<td><a class="move" href='<c:out value="${b.num }"/>'> <c:out value="${b.title}" /> </a></td>
				<td><c:out value="${b.writer}" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${b.updatedate}" /></td>
			</tr>
		</c:forEach>
	</table>
</c:if>


<!-- 페이지 버튼 -->
<div>
<nav aria-label="Page navigation example nav-outline-danger">
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
   </div>

    <c:if test="${sessionScope.id eq 'admin' }">
<div align="right" style=none; height: 100px;">
		<a class="btn btn-danger" href="${ pageContext.request.contextPath }/admin/writeBoard">글쓰기</a>
	</c:if>
</div>
</div>

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