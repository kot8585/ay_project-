<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Red house</title>
<link rel="shortcut icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<link rel="icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script type="text/javascript" src="/js/reply.js"></script>
<script>
//댓글 목록 보여주는 함수
function showList(qnum){replyService.getList(qnum, function(list){
		var htmls = "";
		
		
		//댓글이 없을 경우
		if(list == null || list.length == 0){
			$("#replyList").html("작성된 답변이 없습니다.");
			return;
		}
		
		for(var i=0, len = list.length||0; i<len; i++){
			htmls+=  '<li class="list-group-item" data-num="'+list[i].num+'">'
			htmls+=    '<div class="d-flex w-100 justify-content-between">'
			htmls+=    '<strong class="mb-1">'+list[i].writer+'</strong>'
			htmls+=   '<small>'+list[i].r_date+'</small>'
			htmls+=   '</div>'
			htmls+=	   '<p class="repContent">'+list[i].content+'</p>'
			htmls+=  '</li>'
		}
		$("#replyList").html(htmls);
	});
}
	$(document).ready(function(){
		// 1.option의 value값이랑 db에서 가져온 값이랑 일치하는지 확인 
		//	2. 일치한다면 selected 값 넣어주기
		var opt_vals = [];
		$('select option').each(function(){
			opt_vals.push($(this).val());
			console.log($(this).val());
		});
		
		$('#q_cate').find("option[value='${q.q_cate}']").attr('selected', 'selected');
		
		var writer = "${sessionScope.id}"
		
		showList(${q.num});
		
		//이미지에 마우스 올릴때
	      $(".img").mouseover(function() {
	          $("#bigImg").attr('src', this.src);
	       });
		
		//게시판 삭제
		$("#del").click(function(){
			var result = confirm("글을 삭제하시겠습니까?");
			if(result){
				location.href = "${pageContext.request.contextPath}/qna/del?num=${q.num}";
			}
		});
		
	});
	

	
</script>
</head>
<body>
<!-- navbar -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light ms-2">
    <a class="navbar-brand" href="${ pageContext.request.contextPath }/member/main">
    	<!-- Controller로 로고 이미지를 받아오기. -->
    	<img src="${ pageContext.request.contextPath }/logo" alt="logo" width="249" height="60" class="d-inline-block align-top">
    </a>
    <button class="navbar-toggler" 
		    type="button" 
		    data-bs-toggle="collapse" 
		    data-bs-target="#navbarSupportedContent" 
		    aria-controls="navbarSupportedContent" 
		    aria-expanded="false" 
		    aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto">
        <c:if test="${ empty sessionScope.id }">
	        <li class="nav-item active">
	          	<a class="nav-link" href="${ pageContext.request.contextPath }/member/loginForm">로그인</a>
	        </li>
        </c:if>
        <c:if test="${not empty sessionScope.id }">
        	<li class="nav-item">
          		<a class="nav-link" href="${ pageContext.request.contextPath }/member/logout">로그아웃</a>
        	</li>
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/mypage/mypage">마이페이지</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/board/faq/list">고객센터</a>
        </li>
        <li>
          <button type="button" class="btn btn-outline-primary me-2" onclick="goPage()">회원가입</button>
        </li>
      </ul>
    </div>
</nav>
  <hr> <!-- /nabvar -->

	<c:if test="${sessionScope.id ne q.writer }">
		<c:set var="data" value="readonly" />
	</c:if>
	<form action="${pageContext.request.contextPath }/qna/edit" method="post">
		<table border="1" cellspacing="0">
		
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" value="${q.writer}"></td>
			</tr>
			<tr>
				<td>문의 유형</td>
				<td>	
				<select name="q_cate" id="q_cate">
					<option value="order" >주문 상품 문의</option>
					<option value="p_delivery">배송 관련 문의</option>
					<option value="system">시스템 개선 의견</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${q.title}" ${data}></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input type="text" name="content" value="${q.content}" ${data}></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><input type="text" name="updatedate" value="${q.updatedate}" readonly></td>
			
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
                     <img id="bigImg" src="${pageContext.request.contextPath }/qna/img?fname=${file0 }&num=${q.num }" 
                     style="width:150px;height:150px"></td>
                  </tr>
                  <tr>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file0 }&num=${q.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file1 }&num=${q.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file2 }&num=${q.num }" class="img" width="50" height="50"></td>
               </table>
            </c:if></td>
      </tr>
		
		</table>
			<input type="hidden" name="num" value="${q.num}">
			<input type="hidden" name="pwd" value="${q.pwd}">
			
			<!-- 작성자만 수정, 삭제 버튼 뜨게 하기 -->
			<c:if test="${sessionScope.id eq q.writer}">
				<input type="submit" value="수정하기">
				<input type="button" value="삭제하기" id="del">
			</c:if>

	</form>
<hr>
	 <h6>Reply List</h6>
	 
	<!-- 댓글 작성되면 이 영역에 넣는다 -->
		<ul class="list-group" id="replyList">
  	</ul>