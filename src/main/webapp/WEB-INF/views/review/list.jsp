<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>


<c:forEach var="r" items="${list}">
	<table id="reviewTable" border="1" cellspacing="0">
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
					<button id="like" value="like" onclick="rating('like', ${r.num})">좋아요</button>
					<button id="hate" value="hate" onclick="rating('hate', ${r.num})">싫어요</button>
					<span id="rating${r.num }">${r.likey }</span> 명이 좋아합니다. 
				</td>
			</tr>
		</thead>
	</table>
</c:forEach>