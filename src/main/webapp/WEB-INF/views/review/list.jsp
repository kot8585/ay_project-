<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/review.css">

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
					<button id="like" value="like" onclick="rating('like', ${r.num})">종아요</button>
					<button id="hate" value="hate" onclick="rating('hate', ${r.num})">싫어요</button>
					좋아요 : <div id="rating${r.num }">${r.likey }</div> 
				</td>
			</tr>
		</thead>
	</table>
</c:forEach>