<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>	
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<style type ="text/css">
div#side_left{
width:200px;
height:400px;
/* background-color:yellow; */
float:left;
margin:5px;
}
#side_left_box{
width:95%;
height:45%;
/* background-color:blue; */
float:left;
margin:5px;
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
#side_rigth{
width:200px;
height:400px;
/* background-color:red; */
float:left;
margin:5px;
}
#side_rigth_box{
width:95%;
height:45%;
/* background-color:skyblue; */
margin:5px;
margin-top:95%;
}

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

</style>

<script src="/js/header.js"></script>
<script src="/js/review.js"></script>
<script>
	function change(type, num){
		console.log("선택한 기능(type) : " + type);
		console.log("type은 타입에 따라 수정, 삭제 중 하나를 선택하는 기능을 합니다.")
		var pwdCheck = prompt("비밀번호를 입력해주세요");
		console.log("1단계 : 수정,삭제 권한을 확인하기 위하여 비밀번호 입력")
		console.log("입력된 값 : " + pwdCheck);
		var xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState === 4 && xhttp.status === 200){
				console.log("입력에 따른 반환 값 : " + xhttp.responseText);
				if(xhttp.responseText === "로그인부터 해주세요."){
					alert("로그인부터 해주세요.");
				}else if(xhttp.responseText === "작성자가 아닙니다.."){
					alert("작성자가 아닙니다..");
				}else{
					if(xhttp.responseText === "비밀번호 확인 완료" && type==="del"){
						alert("비밀번호 확인 완료");	
						location.href="${pageContext.request.contextPath}/review/delReview?num="+num;
					}else if(xhttp.responseText === "비밀번호 확인 완료" && type==="edit"){
						alert("비밀번호 확인 완료");
						f.submit();
						
					}else{
						alert("비밀번호가 다릅니다.");
						location.href="${pageContext.request.contextPath}/member/main";
					}
				}
				
			}			
		}
		xhttp.open("POST", "/review/pwdCheck?password=" + pwdCheck + "&wid=${r.writer}", true);
		xhttp.send();
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
</script>
</head>
<body>
<h2>리뷰 수정</h2>
<div class="container">
	<div class="card card-outline-secondary my-4">
		<div class="card-header">
			<label class="form-label">글 번호</label>
			<input class="form-control" type="text" name="num" value="${r.num }" readonly>
		</div>
		<div class="card-header">
			<label class="form-label">상품 번호</label>
			<input class="form-control" type="text" name="pnum" value="${r.pnum }" readonly>
		</div>
		<div class="card-header">
			<label class="form-label">별점</label>
			<input class="form-control text-danger" value="${r.stars }" readonly>
		</div>
		<div class="card-header">
			<label class="form-label">작성자</label>
			<input class="form-control" type="text" name="writer" value="${r.writer}"readonly>
		</div>
		<div class="card-header">
			<label class="form-label">제목</label>
			<input class="form-control" type="text" name="title" id="title" value="${r.title }" onkeyup="countLetter('title')">
        		<div class="form-text">
					50글자 이내로 입력해주세요.
				</div>
            	<div id="titleDiv">
            		<span id="titleSpan1">0</span>/50
            		<span id="titleSpan2"></span>
            	</div>
		</div>
		<div class="card-header">
			<label class="form-label">내용</label>
			<textarea class="form-control" name="content" id="content" cols="30" rows="30" onkeyup="countLetter('content')">${r.content }</textarea>
            	<div id="contentDiv">
					<span id="contentSpan1">0</span>/50
					<span id="contentSpan2"></span>
				</div>	
		</div>
		<div class="card-header">
			<label class="form-label">작성일</label>
		</div>
		<button class="btn btn-danger" onclick="sub()">등록</button>
	<input type="hidden" name="pnum" value="${p.num }">
	<input type="hidden" name="path" value="123">
	</div>
</div>
<form name="f" method="POST" action="${pageContext.request.contextPath }/review/editReview">
   <table border="1" cellspacing="0">
      <thead>
         <tr>
            <th>번호</th>
            <td><input type="text" name="num" value="${r.num}" readonly></td>
         </tr>
         <tr>
            <th>상품번호</th>
            <td><input type="text" name="pnum" value="${r.pnum}" readonly></td>
         </tr>
         <tr>
         	<th>별점</th>
			<td>${r.stars }</td>	
         </tr> 
         <tr>
            <th>제목</th>
            <td>
            	<input type="text" name="title" id="title" value="${r.title }" onkeyup="countLetter('title')">
            	<div id="titleDiv">
            		<span id="titleSpan1">0</span>/50
            		<span id="titleSpan2"></span>
            	</div>
            </td>
         </tr>
           <tr>
            <th>작성자</th>
            <td>${r.writer}</td>
         </tr>
           <tr>
            <th>내용</th>
            <td>
            	<textarea name="content" id="content" cols="30" rows="30" onkeyup="countLetter('content')">${r.content }</textarea>
            	<div id="contentDiv">
					<span id="contentSpan1">0</span>/50
					<span id="contentSpan2"></span>
				</div>	
            </td>
         </tr>
           <tr>
            <th>작성날짜</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${r.pdate}" /></td>
         </tr>
         <tr>
         	<td colspan="2">
         		<input type="button" value="수정" id="edit" onclick="change('edit', ${r.num})">
         		<input type="button" value="삭제" id="delete" onclick="change('del', ${r.num})">
         	</td>
         </tr>
      </thead>
   </table>
</form>
</body>
</html>