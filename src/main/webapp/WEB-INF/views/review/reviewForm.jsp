<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<script src="/js/header.js"></script>
<title>Review Form</title>

<script>

	function getByte(s){
		var cnt = 0;
		console.log(s.charAt());
		console.log(s.charCodeAt());
	}

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
	
	function sub(){
		var titleLength = 50;
		var contentLength = 500;
		if(document.getElementById("title").value.length > titleLength || document.getElementById("content").value.length > contentLength){
			alert("글자수가 초과되었습니다.");
		}else if(document.getElementById("title").value.length <= titleLength && document.getElementById("content").value.length <= contentLength){
			f.submit();
		}
	}
	
	function upload(){
		
	}
	
	
	
</script>
</head>
<body>
<nav></nav>
<form name="f" action="${pageContext.request.contextPath }/review/write" enctype="multipart/form-data" method="POST">
	<table border="1">
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" id="title" onkeyup="countLetter('title')">
				<div id="titleDiv">
					<span id="titleSpan1">0</span>/50 
					<span id="titleSpan2"></span>
					<span id="titleReg"></span>
				</div>

			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="writer" value="${sessionScope.id }" readonly></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="content" id="content" cols="50" rows="50" onkeyup="countLetter('content')"></textarea>
				<div id="contentDiv">
					<span id="contentSpan1">0</span>/50
					<span id="contentSpan2"></span>
				</div>	
			</td>
		</tr>
		<tr>
			<th>사진 업로드</th>
			<td><input class="form-control" type="file" name="uploadFile" multiple></td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<input type="radio" name="stars" value="★☆☆☆☆">★
				<input type="radio" name="stars" value="★★☆☆☆">★★
				<input type="radio" name="stars" value="★★★☆☆">★★★
				<input type="radio" name="stars" value="★★★★☆">★★★★
				<input type="radio" name="stars" value="★★★★★">★★★★★
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="작성" onclick="sub()">
				<input type="reset" value="지우기">
				
				<input type="hidden" name="pnum" value="${p.num }">
			</td>
		</tr>
	</table>
	<input type="hidden" name="path" value="123">
</form>
</body>
</html>