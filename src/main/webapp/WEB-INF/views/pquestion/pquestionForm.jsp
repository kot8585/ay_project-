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

<script src="/js/header.js"></script>
<script>

	function getByte(s){
		var cnt = 0;
		console.log(s.charAt());
		console.log(s.charCodeAt());
	}
	
	// 글자 수를 체크하는 기능
	function countLetter(type){
		
		console.log(type);
		if(type === "title"){
			var length = 50;
		}else if(type === "content"){
			var length = 500;
		}
		console.log(length);
		var title = document.getElementById("title");
		var pattern = /\s/g;
		getByte(title.value);
		if(title.value.match(pattern) || title.value.length < 5){
			document.getElementById("titleReg").innerHTML = "빈칸 안되고, 5글자 이상 입력하세여해요..";
		}else{
			document.getElementById("titleReg").innerHTML = "";
			
		}
		document.getElementById(type+"Span1").innerHTML = document.getElementById(type).value.length;
		if(document.getElementById(type).value.length > length){
			document.getElementById(type+"Div").style.color="red";
			document.getElementById(type+"Span2").innerHTML = "글자수 초과!!";
		}else{
			document.getElementById(type+"Div").style.color="black";
			document.getElementById(type+"Span2").innerHTML = "";
		}	
	}
	
	// 글자수가 조건에 위배되었는지를 체크
	function sub(){
		var titleLength = 50;
		var contentLength = 500;
		var title = document.getElementById("title");
		var content = document.getElementById("content");
		if(title.value.length > titleLength || content.value.length > contentLength){
			alert("글자수가 초과되었습니다.");
		}else if(title.value.length <= titleLength && content.value.length <= contentLength){
			f.submit();
		}
	}
	
	function upload(){
		
	}
</script>

<style type ="text/css">


input:focus {outline:none;}
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.inputStyle{
border:1px;
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

<form action="${pageContext.request.contextPath }/pquestion/write">
	<table border="1" cellspacing="0">
	
	<div class="container">
	<div class="card card-outline-secondary my-4">
		<div class="card-header">
			<label class="form-label">작성자</label>
<!-- 	<tr>	 -->
<!-- 		<th>작성자</th>	 -->
<!-- 		<td> -->
		<input class="form-control" type="text" name="writer" value="${sessionScope.id }" readonly></td>
<!-- 	</tr> -->	
	</div>
	
	<div class="card-header">
			<label class="form-label">제목</label>
			<input class="form-control" type="text" name="title" id="title" onkeyup="countLetter('title')">
			<div class="form-text">
			
			</div>
			<div id="titleDiv">
					<span id="titleSpan1">0</span>/50 
					<span id="titleSpan2"></span>
					<span id="titleReg"></span>
		</div>
<!-- 	<tr> -->
<!-- 		<th>제목</th> -->
<!-- 		<td><input type="text" name="title"></td> -->
<!-- 	</tr> -->
	
	
	<div class="card-header">
			<label class="form-label">내용</label>
			<textarea class="form-control" name="content" id="content" cols="20" rows="70" onkeyup="countLetter('content')"></textarea>
				<div id="contentDiv">
					<span id="contentSpan1">0</span>/50
					<span id="contentSpan2"></span>
				</div>
			</div>
	
	  
<!-- 	<tr>	 -->
<!-- 		<th>내용</th> -->
<!-- 		<td><textarea name="content" cols="50" rows="50"></textarea></td> -->
<!-- 	</tr>	 -->
	
<!-- 	<tr> -->
<!-- 	<td> -->
<div class="d-grid gap-2 d-md-block " >
<div align="center" style=none; height: 100px;">
	<input class="btn btn-danger" type="submit" value="문의작성">
	<input class="btn btn-danger" type="reset" value="지우기">
	<input type="hidden" name="pnum" value="${pq.num }">
<!-- 	</td> -->
<!-- 	</tr> -->
	</div>
	</div>
  
	</table>
</form>
</body>
</html>