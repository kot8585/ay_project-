<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script type="text/javascript">
var maxSize = 5242880 //5MB
function checkExtension(fileName, fileSize){
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
	
var ext = fileName.split('.').pop().toLowerCase();
	console.log(ext);
	
	if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'bmp']) == -1){
		alert("이미지 파일만 가능합니다.");
		return false;
	}
	return true;
}

	$(document).ready(function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/rep/list",
			  dataType: "json",
				    type: "POST",
				    data : {"writer" : "${sessionScope.id}"},
				    success: function (result) {
						var htmls ="";
						if(result.length < 1){

							htmls="등록된 댓글이 없습니다.";

						} else{ //주문한 상품 이름을 알고싶은데... 클래스를 하나 만들어야할것같다.
							$(result).each(function(){
								htmls+=this.content+"(작성자:"+this.writer+")<br>";
								htmls+='<option value="order"></option>';

								htmls+='<a href="javascript:void(0)" onclick="fn_delReply(' + this.num + ')" >삭제</a>';

								htmls+="<hr>"
						});
						}
						$("#replyList").html(htmls);
				     }
		});

		$("#uploadFile").on("change", function(e){
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log(files);

				//add filedata to dormdata
				for(var i=0; i<files.length; i++){
					if(!checkExtension(files[i].name, files[i].size) ){
						inputFile.val('');
						return false;
					}
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
<h1>1:1문의하기</h1>
	<form id="QnaForm" action="${pageContext.request.contextPath }/qna/write" method="post"  enctype="multipart/form-data">
		
		<!-- 질문 카테고리 -->
		<select name="q_cate" id="q_cate">
			<option value="" selected="selected">-- 문의유형을 선택해주세요 --</option>
			<option value="order">주문 상품 문의</option>
			<option value="p_delivery">배송 관련 문의</option>
			<option value="system">시스템 개선 의견</option>
		</select>
		
		<!-- 주문 내역 o --> 
<!-- 		<select name="o_num" id="o_num"> -->
<!-- 			<option value="">--주문내역을 선택해주세요--</option> -->
<!-- 		</select> -->
		
		<!-- 문의 폼/date안 전해줫는데 괜찮겟지? -->
		<table border="1">
			<tr>
				<th>제목</th><td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>비밀번호</th><td><input type="password" name="pwd" ></td>
			</tr>
			
			<tr>
				<th>내용</th><td><textarea name="content" rows="10" cols="33" ></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th><td><input type='file' id="uploadFile" name="uploadFile" multiple ></td>
			</tr>
			
			<tr><td><input type="reset" value="취소"></td>
			<td><input type="submit" value="등록"></td></tr>
		</table>
		
		<input type="hidden" name="path" value="123">
		<input type="hidden" name="writer" value="${sessionScope.id }" >
		<input type="hidden" name="state" value="답변대기"> 
	</form>
		
</body>
</html>
