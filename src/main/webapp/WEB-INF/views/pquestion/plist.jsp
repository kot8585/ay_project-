<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function go(i){
	location.href="${pageContext.request.contextPath}/pquestion/pquestionForm?pnum="+i;
}

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
	
	a {
    color: #0d6efd;
    text-decoration: none;
}

.my-box { border:1px solid; padding:1px; width: 35px; background-color: gray; font-size: 15px;}

</style>

</head>
<body>

	<h3>상품문의</h3>
	<table border="1" cellspacing="0">

	<nav id="ntable">
	
	<c:forEach var="pq" items="${plist}">
		<div>
			<hr class="bg-danger" size="5px">
			<div class="my-box text-light">질문</div>
			${pq.writer } 님 <fmt:formatDate pattern="yyyy-MM-dd" value="${pq.p_date}" /><br><br>
			</div>
			<div> 
			<a href="${pageContext.request.contextPath }/pquestion/pDetail?num=${pq.num }" class="text-secondary">${pq.content} 
			</a></div>
		
	</c:forEach>
	</nav>
	</table>
	
	

</body>
</html>