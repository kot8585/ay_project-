<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<title>마이페이지</title>
</head>
<body>
<!-- nav bar -->
 <header>
 <script type="text/javascript" src="/js/mypage.js"></script>
 </header>


<c:if test="${ not empty sessionScope.id }">
<hr>
<c:import url="${ pageContext.request.contextPath }/mypage/shoppingcartForm"></c:import>
<hr>
<br>
<c:import url="${ pageContext.request.contextPath }/mypage/myOrderForm"></c:import>
<hr>
<br>
<c:import url="${ pageContext.request.contextPath }/mypage/myQuestionForm"></c:import>
<hr>
<br>

</c:if>
</body>
</html>