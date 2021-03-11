<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#del").click(function() {
		$("#f1").attr('action', '${ pageContext.request.contextPath }/pquestion/delpquestion');
		$("#f1").submit();
	});
});
</script>
    
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
	
/* 	div.button */

/* { */

/*    margin: auto; */

/*    width: 10%; */

/* } */

/* div.button input */

/* { */

/*    padding: 15px; */

/*    width: 10%; */

/*    font-size: 15px; */

/* } */
	




</style>
<script src="/js/header.js"></script>

</head>
<body>
<form id="f1" action="${ pageContext.request.contextPath }/pquestion/editpquestion" method="post">
   <table border="1" cellspacing="0">
   <div class="container">
   <div class="card card-outline-secondary my-4">
   <div class="card-header">
   <label class="form-label">번호</label>
			<input class="form-control" type="text" name="num" value="${pq.num}" readonly></td>
		</div>
   

<div class="card-header">
			<label class="form-label">상품 번호</label>
			<input class="form-control" type="text" name="pnum" value="${pq.pnum}" readonly>
		</div>


<div class="card-header">
			<label class="form-label">작성자</label>
			<input class="form-control" type="text" name="writer" value="${pq.writer}"readonly>
		</div>
		

<!-- <div class="card-header"> -->
<!-- 			<label class="form-label">제목</label> -->
<%-- 			<input class="form-control" type="text" name="title" id="title" value="${pq.title }" onkeyup="countLetter('title')"> --%>
<!--         		<div class="form-text"> -->
<!-- 					50글자 이내로 입력해주세요. -->
<!-- 				</div> -->
<!--             	<div id="titleDiv"> -->
<!--             		<span id="titleSpan1">0</span>/50 -->
<!--             		<span id="titleSpan2"></span> -->
<!--             	</div> -->
<!-- 		</div> -->


           <div class="card-header">
			<label class="form-label">내용</label>
			<textarea class="form-control" name="content" id="content" cols="30" rows="10" onkeyup="countLetter('content')">${pq.content }</textarea>
            	<div id="contentDiv">
					<span id="contentSpan1">0</span>/50
					<span id="contentSpan2"></span>
				</div>	
		</div>
		

<div class="card-header">
			<label class="form-label">작성일</label>
			<input class="form-control" fmt:formatDate pattern="yyyy-MM-dd" value="${pq.p_date}" readonly>
           
           
  <div class="button "d-grid gap-2 d-md-block">
  	<input class="btn btn-danger" type="submit" value="수정">
  	<input class="btn btn-danger" type="button" value="삭제" id="del">
  
  
<!--          <tr> -->
<!--          	<td colspan="2"> -->
<!--          		<input type="submit" value="수정"> -->
<!--          		<input type="button" value="삭제" id="del"> -->
<!--          	</td> -->
<!--          </tr> -->
          
      </thead>
     
    
     
   </table>
   </form>
</body>
</html>