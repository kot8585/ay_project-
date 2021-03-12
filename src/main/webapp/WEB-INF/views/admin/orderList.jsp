<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   var number = 0;
   var state = 0;
   $(document).ready(function() {
	   // 카테고리 선택시 state 값을 저장하기 위함.
	   // TODO 추후 각 form 마다 input hidden을 두어 일괄 변경될 수 있도록 조치할 예정.
	   	$(".sel").click(function() {
			state = this.options[this.options.selectedIndex].value;
		});
	   
	   // 주문상태변경이 변경이 됨.
		$(".stateBtn").click(function() {
			$.post("/admin/changeState", {num: $("#num"+number).val(), state: state});
			setTimeout(() => {
				location.replace("${pageContext.request.contextPath}/admin/admin");
			}, 500);
		});
   });
   
   function setNum(num) {
		number = num;
   }
</script>

<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<style type="text/css">
 .table-warning tr th {
 	text-align: center;
 }
</style>
</head>
<body>
<c:if test="${empty list }">
 구매이력이 없습니다.
</c:if>
<c:if test="${not empty list }">
<table class="table table-bordered">
<thead class="table-danger">
	<tr>
		<th>구매번호</th><th>상품이미지</th><th>고객ID</th><th>상품번호</th>
		<th>주문수량</th><th>상세주소</th><th>전화번호</th>
		<th>주문날짜</th><th>주문액</th><th>주문상태</th>
		<th>주문상태변경</th>
	</tr>
</thead>
<c:forEach var="p" items="${list }">
<tr>
	<th>${ p.num }</th>
	<td><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.p_num}" style="width:60px;height:60px"></td>
	<td>${ p.m_id }</td>
	<td>${ p.p_num }</td>
	<td>${ p.quantity }</td>
	<td>${ p.address }</td>
	<td>${ p.tel }</td>
	<td>${ p.o_date }</td>
	<td>${ p.cost }</td>
	<td>
		<c:choose>
			<c:when test="${ p.state == 0 }">준비중</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${ p.state == 1 }">배송중</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${ p.state == 2 }">배송완료</c:when>
		</c:choose>
	</td>
	<td>
		<form method="post">
			<input type="hidden" id="num${ p.num }" value="${ p.num }">
			<input type="hidden" id="state${ p.num }" value="${ p.state }">
			
			<select class="sel" name ="sel">
				<option value="0">준비중</option>
				<option value="1">배송중</option>
				<option value="2">배송완료</option>
			</select>
			<Button class="stateBtn" onclick="javascript:setNum(${p.num})">주문상태변경</Button>
		</form>
	</td>
</tr>
</c:forEach>
</table>
</c:if>
</body>
</html>