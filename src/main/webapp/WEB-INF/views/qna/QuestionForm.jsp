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

<style type="text/css">


.vertical-center {

  display: flex;
  align-items: center;
}

.mb-3 {
    margin : 1rem!important;
   
}
</style> 

<script type="text/javascript" src="/js/header.js"></script>
<script type="text/javascript">
function countLetter(){
    document.getElementById("cnt").innerHTML = document.getElementById("title").value.length;
    
 }

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
<h1>1:1문의하기</h1>
	<div class="container-fluid vertical-center justify-content-center">
<span class="border border-dark">
	<form id="QnaForm" action="${pageContext.request.contextPath }/qna/write" method="post"  enctype="multipart/form-data">
		
		<!-- 주문 내역 o --> 
<!-- 		<select name="o_num" id="o_num"> -->
<!-- 			<option value="">--주문내역을 선택해주세요--</option> -->
<!-- 		</select> -->
		
		<!-- 문의 폼/date안 전해줫는데 괜찮겟지? -->

		<table class="table-dark">
		
		<thead class="table-dark">
					<lable colspan="2">1:1문의</label>
		</thead>
		<tbody>
		<div class="mb-3">
		<label class="form-label">문의 유형</label>
		<select name="q_cate" id="q_cate" class="form-select" aria-label="Default select example">
			<option value="" selected="selected">-- 문의유형을 선택해주세요 --</option>
			<option value="order">주문 상품 문의</option>
			<option value="p_delivery">배송 관련 문의</option>
			<option value="system">시스템 개선 의견</option>
		</select>
		</div>
		<!-- 질문 카테고리 -->
			 <div class="mb-3">
				<label class="form-label">제목</label>
				<input class="form-control" type="text" id="title" name="title" onkeyup="countLetter()">
				<span id="cnt">0</span>/50
			  </div>

			 <div class="mb-3">
				<label class="form-label">내용</label>
				<textarea class="form-control" name="content" rows="10" cols="33" ></textarea>
			  </div>
			 <div class="mb-3">
				<label class="form-label">첨부파일</label>
				<input class="form-control" type='file' id="uploadFile" name="uploadFile" multiple >
			  </div>
			
			 <div class="mb-3">
			 	<input type="reset" value="취소"class="btn btn-primary">
				<button type="submit" class="btn btn-primary">Submit</button>
			 </div>
			 </tbody>
		</table>
		
		<input type="hidden" name="path" value="123">
		<input type="hidden" name="writer" value="${sessionScope.id }" >
		<input type="hidden" name="state" value="답변대기"> 
	</form>
	</span>
	</div>
</body>
</html>
