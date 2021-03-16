<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 인터넷 익스플로러에서 랜더링되는 방식 중 ie edge는 최신의 표준 버젼으로 랜더링해달라. -->
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- 인터넷 익스플로러에서 랜더링되는 방식 중 ie edge는 최신의 표준 버젼으로 랜더링해달라. -->
 <meta http-equiv="X-UA-Compatible" content="ie=edge">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script type="text/javascript">
<!-- 정규식을 활용하여 숫자 3번째 자리마다 ,를 추가하고 끝에 원을 붙이는 함수. https://fruitdev.tistory.com/160 -->
	   function numberWithCommas(num) {
		   var len, point, str; 
	       
		    num = num + ""; 
		    point = num.length % 3 ;
		    len = num.length; 
		   
		    str = num.substring(0, point); 
		    while (point < len) { 
		        if (str != "") str += ","; 
		        str += num.substring(point, point + 3); 
		        point += 3; 
		    } 
		     
		    document.write(str + "원");
		}
</script>

</head>
<body>
	<!-- header부분 -->
	<header>
		<c:if test="${ empty id }">
			<script type="text/javascript" src="/js/headerSessionNotExist.js"></script>
		</c:if>
		<c:if test="${ not empty id }">
			<script type="text/javascript" src="/js/headerSessionExist.js"></script>
		</c:if>
	</header>
	
	<div class="container">
		<div class="row row-cols-2">
			
			<div class="col">
				<img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${order.p.imgPath }&num=${order.p.num }"style="width:100%;height:100%">
			</div>
			<div class="col">
				<h2>${ order.p.name }</h2>
				<hr class="bg-danger" size="5px">
				<h3>${ order.quantity }개 주문</h3>
				<hr class="bg-danger" size="5px">
				<h3>개당 가격 : <script type="text/javascript">numberWithCommas(${ order.p.price })</script></h3>
				<hr class="bg-danger" size="5px">
				<h3>주문총액 : <script type="text/javascript">numberWithCommas(${ order.quantity * order.p.price })</script></h3>
				<hr class="bg-danger" size="5px">
				<form action="${ pageContext.request.contextPath }/order/order" method="post">
					<h3>주소 <input type="text" name="address" value="${ order.m.address }" size="30"></h3>
					<hr class="bg-danger" size="5px">
					<h3>전화번호 <input type="text" name="tel" value="${ order.m.tel }"></h3>
					<hr class="bg-danger" size="5px">
					<input type="hidden" name="m_id" value="${ sessionScope.id }">
					<input type="hidden" name="p_num" value="${ order.p_num }">
					<input type="hidden" name="p_name" value="${ order.p.name }">
					<input type="hidden" name="quantity" value="${ order.quantity }">
					<input type="hidden" name="cost" value="${ order.quantity * order.p.price }"> 
					<input type="hidden" name="state" value="0">
					<input type="submit" class="btn btn-success" value="주문" style="width:100px; height:40px; ">
				</form>
				
			</div>
		</div>
	</div>
	<hr>
</body>
</html>