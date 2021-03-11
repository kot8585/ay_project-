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

#mid_content{
width:400px;
height:400px;
/* background-color:green; */
float:left;
margin:5px;
}
#side_content_box{
display: inline;
/* background-color:white; */
margin:500px;
}
#table, #td{
border:1px solid red;
}

h2{ text-align:center; }


</style> 

<script type="text/javascript">
function countLetter(type){
	var typeLen = $('#'+type).val().length;
	console.log(typeLen);
	console.log(type);
	if(type === "title"){
		var length = 50;
	}else if(type === "content"){
		var length = 500;
	}
	console.log(length);
	
	$('#'+type+"Span1").html(typeLen);
	if(typeLen > length){
		$('#'+type+"Div").css("color","red");
		$('#'+type+"Span2").html("글자수가 초과되었습니다.");
		return false;
	}else{
		$('#'+type+"Div").css("color","black");
		$('#'+type+"Span2").html('');
	}	
	return true;
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

				//add filedata to formdata
				for(var i=0; i<files.length; i++){
					if(!checkExtension(files[i].name, files[i].size) ){
						inputFile.val('');
						return false;
					}
				}
		});
		
		$("#qnaForm").submit(function(){
			var titleVal = $("#title").val();
			var contentVal = $("#content").val();
			var qCateVal = $("#q_cate option:selected").val();
			var blank_pattern = /^\s+|\s+$/g;
			
			if(qCateVal == '' || qCateVal == null ){
			    alert( '문의유형을 선택해주세요');
			    $("#q_cate").focus();
			    return false;
			}
			
			//공백만 입력하는거 허용안하도록
			if(titleVal.replace(blank_pattern, '' ) == "" ){
				alert('공백만 입력할 수 없습니다.');
			    $("#title").focus();
			    return false;
			}
			
			if(contentVal.replace(blank_pattern, '' ) == "" ){
				alert('공백만 입력할 수 없습니다.');
				 $("#content").focus();
				 return false;
			}
			
			if(titleVal == '' || titleVal == null ){
			    alert( '제목을 입력해주세요');
			    $("#title").focus();
			    return false;
			}
			
			if(contentVal == '' || contentVal == null ){
			    alert( '내용을 입력해주세요');
			    $("#content").focus();
			    return false;
			}
			
			if(titleVal.length > 50){
				alert("제목의 글자수가 초과되었습니다.");
				$("#title").focus();
				return false;
			}
			
			if(contentVal.length > 500){
				alert("본문의 글자수가 초과되었습니다.");
				$("#content").focus();
				return false;
			}

		});
	});
</script>
</head>
<body>

<header>
<c:if test="${empty sessionScope.id }">
	<script type="text/javascript" src="/js/loginSessionNotExist.js"></script>
</c:if>
<c:if test="${not empty sessionScope.id }">
	<script type="text/javascript" src="/js/loginSessionExist.js"></script>
</c:if>
</header>

<h2>1:1문의하기</h2>
	<div class="container-fluid vertical-center justify-content-center">
<span class="border border-danger">
	<form id="qnaForm" action="${pageContext.request.contextPath }/qna/write" method="post"  enctype="multipart/form-data" style="width: 500px;">

		<div class="mb-3">
		<label class="form-label ">문의 유형</label>
		<select name="q_cate" id="q_cate" class="form-select aria-label="Default select example" >
			<option value="" selected="selected">-- 문의유형을 선택해주세요 --</option>
			<option value="order">주문 상품 문의</option>
			<option value="p_delivery">배송 관련 문의</option>
			<option value="system">시스템 개선 의견</option>
		</select>
		</div>
		<!-- 질문 카테고리 -->
			 <div class="mb-3">
				<label class="form-label">제목</label>
				<input class="form-control type="text" id="title" name="title" onkeyup="countLetter('title')">
				<div id="titleDiv">
					<span id="titleSpan1">0</span>/50 
					<span id="titleSpan2"></span>
				</div>
			  </div>

			 <div class="mb-3">
				<label class="form-label">내용</label>
				<textarea class="form-control" name="content" id="content" rows="10" cols="33" onkeyup="countLetter('content')" ></textarea>
			  	<div id="contentDiv">
					<span id="contentSpan1">0</span>/500
					<span id="contentSpan2"></span>
				</div>	
			  </div>
			 <div class="mb-3">
				<label class="form-label">첨부파일</label>
				<input class="form-control" type='file' id="uploadFile" name="uploadFile" multiple >
				
				<!-- 파일 여러개 넣으면 파일 이름 뽑기 -->
				<div id="fileName">
					
				</div>
			  </div>
			
			 <div class="mb-3">
			 	<input class="btn btn-danger" type="reset" value="취소">
			 	 <input class="btn btn-danger" type="submit" name="submit" id="submit" value="작성">
			 </div>
		</span>
		
		<input type="hidden" name="path" value="123">
		<input type="hidden" name="writer" value="${sessionScope.id }" >
		<input type="hidden" name="state" value="답변대기"> 
	</form>
	</span>
	</div>
</body>
</html>
