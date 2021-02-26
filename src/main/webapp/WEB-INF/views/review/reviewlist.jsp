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
/**
 * @author Hyun Jin Kim
 * 2021.02.25
 * 기능 : 리뷰 리스트 출력
 */
 
 
/**
 * 기능 : 기준에 따라 리스트를 정렬 : 최신순 / 좋아요순 / 별점
 * @param criteria : 정렬의 기준을 받아오는 parameter
 * @return p_num
 * @return what
 */
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

function rating(hi, r_num){
	var type = null;
	var rnum = document.getElementById("rnum");
	var xhttp = new XMLHttpRequest();
	console.log("현재 리뷰 글 번호 : " + r_num);	
	
	if(hi === "like"){
		type = "like";
	}else{
		type = "hate";
	}
	console.log("선택된 기능 : " + type);

	xhttp.onreadystatechange = function(){
		if(xhttp.readyState === 4 && xhttp.status === 200){
			console.log("입력에 따른 반환 값 : " + xhttp.responseText);
			
			if(xhttp.responseText === "동준씨 로그인부터 하시죠.."){
				alert("동준씨 로그인부터 하시죠..");
			}else if(xhttp.responseText === "이미 좋아요를 누르셨습니다."){
				alert("${sessionScope.id}님 이미 좋아요를 누르셨습니다.");	
			}else{
				ratingPrint(xhttp, r_num);
			}
		}
	}
	xhttp.open("POST", "/review/reviewRating?num="+r_num+"&type="+type, true);
	xhttp.send();
}
function ratingPrint(go, r_num){
	
	document.querySelector("#rating"+r_num).innerHTML = go.responseText;	
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
	<select id="byStar" onchange="sort('byStar')">
		<option value="none">평점 별 정렬</option>
		<option value="1">★☆☆☆☆</option>
		<option value="2">★★☆☆☆</option>
		<option value="3">★★★☆☆</option>
		<option value="4">★★★★☆</option>
		<option value="5">★★★★★</option>
	</select>
	<hr>
	<nav id="ntable">
	<c:forEach var="r" items="${list}">
		<table border="1" cellspacing="0" width="500px">
			<thead>
				<tr>
					<th>번호</th>
					<td value="${r.num }" id="rnum">${r.num}</td>
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
						<button id="like" value="like" onclick="rating('like', ${r.num})">종아요</button>
						<button id="hate" value="hate" onclick="rating('hate', ${r.num})">싫어요</button>
						좋아요 : <div id="rating${r.num }">${r.likey }</div> 
					</td>
				</tr>
			</thead>
		</table>
	</c:forEach>
	</nav>
</body>
</html>