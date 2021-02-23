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

 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script>
function sort(criteria){
	var what = document.getElementById(criteria);
	var xhttp = new XMLHttpRequest();
	console.log("선택된 기준에 따라 정렬");
	console.log("선택된 기준 : " + what.value);
	
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState === 4 && xhttp.status === 200){
			console.log("입력에 따른 반환 값 : " + xhttp.responseText);
			print(xhttp);
			
		}
	}
	
	xhttp.open("POST", "/review/list?p_num=${p.num}&what=" + what.value, true);
	xhttp.send();
}

function print(xhttp){
	console.log(xhttp.responseText);
	document.querySelector("#ntable").innerHTML = xhttp.responseText;
}

function rating(hi){
	var like = document.getElementById("like");
	var hate = document.getElementById("hate");
	console.log(hi);
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(xhttp.readyState === 4 && xhttp.status === 200){
			console.log("입력에 따른 반환 값 : " + xhttp.responseText);
			document.querySelector("#rating").innerHTML = xhttp.responseText;
		}
		
	}
	xhttp.open("POST", "/review/reviewRating?num=${r.num}", true);
	xhttp.send();
}
</script>
</head>
<body>

	<h3>리뷰</h3>
    <hr>
    <button id="likesort" value="like" onclick="sort('likesort')">종아요순</button> | 
    <button id="latest" value="latest" onclick="sort('latest')">최신순</button>
    <select id="list" onchange="sort('list')">
    	<option value="none">선택</option>   		
   		<option value="latest">최신순</option>   		
	</select>
	<select>
		<option value="none">평점 별 정렬</option>
		<option value="none">★☆☆☆☆</option>
		<option value="none">★★☆☆☆</option>
		<option value="none">★★★☆☆</option>
		<option value="none">★★★★☆</option>
		<option value="none">★★★★★</option>
	</select>
	<hr>
	<nav id="ntable">
	<c:forEach var="r" items="${list}">
		<table border="1" cellspacing="0" width="500px">
			<thead>
				<tr>
					<th>번호</th>
					<td>${r.num}</td>
				</tr>
				<tr>
					<th>상품번호</th>
					<td>${r.pnum}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><a href="${pageContext.request.contextPath }/review/reviewDetail?num=${r.num}">${r.title}</a></td>
				</tr>
				<tr>
					<th>별점</th>
					<td>${r.stars }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${r.writer}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${r.content}</td>
				</tr>
				<tr>
					<th>작성날짜</th>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${r.pdate}" /></td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td>
						<button id="like" value="like" onclick="rating('like')">종아요</button>
						<button id="hate" value="hate" onclick="rating('hate')">싫어요</button>
						좋아요 : <div id="rating"></div> 
					</td>
				</tr>
			</thead>
		</table>
	</c:forEach>
	</nav>

</body>
</html>