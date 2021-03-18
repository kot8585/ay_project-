<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pquestionForm</title>

<!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/header.js"></script>
<script>

function countLetter(){
	var typeLen = $('#content').val().length;
	var length = 500;
	
	$('#contentSpan1').html(typeLen);
	if(typeLen > length){
		$('#contentDiv').css("color","red");
		$('#contentSpan2').html("글자수가 초과되었습니다.");
		return false;
	}else{
		$('#contentDiv').css("color","black");
		$('#contentSpan2').html('');
	}	
	return true;
}

	$(document).ready(function(){
		
		$("#f1").submit(function(){
			var contentVal = $("#content").val();
			var blank_pattern = /^\s+|\s+$/g;
			 var sessionId = '<%=session.getAttribute("id") %>'
			      
		    	  if(sessionId == '' || sessionId == 'null'){
		    	         alert("로그인을 먼저 해주세요");
		    	         location.href= "${pageContext.request.contextPath }/member/loginForm";
		      return false;
		    	  }
			 
			if(contentVal.replace(blank_pattern, '' ) == "" ){
				alert('공백만 입력할 수 없습니다.');
				 $("#content").focus();
				 return false;
			}
			
			if(contentVal == '' || contentVal == null ){
			    alert( '내용을 입력해주세요');
			    $("#content").focus();
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

<style type ="text/css">


input:focus {outline:none;}
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}


	h2{
		text-align:center;
	}

	textarea {
		height: 200px;
	}
	h2{
		text-align:center;
	}
	div#side_left{
	width:200px;
	height:400px;
	float:left;
	margin:5px;
	}
	
	
	
</style>



</head>
<body>
<h2>상품문의작성</h2>
	<div class="container">

<form id="f1" action="${pageContext.request.contextPath }/pquestion/write">
	<table border="1" cellspacing="0">
	
	<div class="card card-outline-secondary my-4">
	
		<div class="card-header">
			<label class="form-label">작성자</label>

		<input class="form-control" type="text" name="writer" value="${sessionScope.id }" readonly></td>
	</div>
			
			<div class="card-header">
		         <label class="form-label">내용</label>
		         <textarea class="form-control" name="content" id="content" cols="30" rows="10" onkeyup="countLetter()"></textarea>
	             <div class="form-text">
	               	500글자 이내로 입력해주세요.
	           	 </div>
	             <div id="contentDiv">
		             <span id="contentSpan1">0</span>/500
		             <span id="contentSpan2"></span>
		         </div>   
	      	</div>
	</table>  
	
	 
<div class="d-grid gap-2 d-md-block " >
<div align="center" "style=none; height: 100px;">
	<input class="btn btn-danger" type="submit" value="문의작성">
	<input class="btn btn-danger" type="reset" value="지우기">
	<input type="hidden" name="pnum" value="${pq.num }">
	<input type="hidden" name="state" value="답변대기"> 
	</div>
	</div>
	
  
	
</form>
</body>
</html>