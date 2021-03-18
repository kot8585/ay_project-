<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function go(i) {
		location.href = "${pageContext.request.contextPath}/pquestion/pquestionForm?pnum="
				+ i;
	}
</script>

<style type="text/css">


a {
	color: #0d6efd;
	text-decoration: none;
}

.my-box1 {
	border: 1px solid;
	padding: 1px;
	width: 35px;
	background-color: gray;
	font-size: 15px;
}

.my-box2 {
	border: 1px solid;
	padding: 1px;
	width: 35px;
	background-color: blue;
	font-size: 15px;
}
</style>

</head>
<body>

	<h3>상품문의</h3>
	<table border="1" cellspacing="0">

		<nav id="ntable">

			<c:forEach var="pq" items="${plist}">
				<div>
					<hr class="bg-danger" size="5px">
					<div class="my-box1 text-light bg-gray;">질문</div>
					${pq.writer } 님
					<fmt:formatDate pattern="yyyy-MM-dd" value="${pq.p_date}" />
					<br>
					<br>
				</div>
				<div>
					<a 
<%-- 					href="${pageContext.request.contextPath }/pquestion/pDetail?num=${pq.num }" --%>
						class="text-secondary">${pq.content} </a>
				</div>

				<div>
					<hr class="bg-dark" size="5px">
					<c:if test="${not empty pq.pqreply}">
						<div class="my-box2 text-light">답변</div>
				${pq.pqreply.get(0).writer}  ${pq.pqreply.get(0).pqdate}<br>
						<br>
				</div>

				<div>${pq.pqreply.get(0).content}</div>
				</c:if>


			</c:forEach>
		</nav>
	</table>



</body>
</html>