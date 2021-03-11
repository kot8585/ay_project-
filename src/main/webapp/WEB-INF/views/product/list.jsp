<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Shop Homepage - Start Bootstrap Template</title>
  
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js">
</script>
<!-- 정규식을 활용하여 숫자 3번째 자리마다 ,를 추가하고 끝에 원을 붙이는 함수. -->
<script type="text/javascript">
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
     
    document.write(str + '원');
}
</script>
<style type="text/css">



</style>
</head>
<body>
 
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<h3>상품리스트</h3>	
   <div class="container-fluid justify-content-center">
   <table border="1" class="table table-bordedark">
      <thead class="table-warning" style="border: 0px solid white; text-align: center;">
<!--          <tr> -->
<!--             <th style="width:10%">이벤트순</th> -->
<!--             <th style="width:10%">신상품순</th> -->
<!--             <th style="width:10%">낮은가격순</th> -->
<!--             <th style="width:10%">높은가격순</th> -->
<!--             <td align="right" style="width:30%; background-color:white;" colspan="2"> -->
<!--             	<input type="search"><input type="button" value="검색" onclick="javascript:search()"> -->
<!--             </td> -->
<!--          </tr> -->
      </thead>
      
<!--        <div class="col-lg-9"> -->
      
      <c:forEach var="p" items="${list}" varStatus="vs">
            <td style="width:16.66%"  colspan="1" align="center">
           
            	<img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.num}" style="width:250px;height:250px">
            	<hr>
            	<a href="${pageContext.request.contextPath }/product/detail?num=${p.num}">${p.name}</a><br>
            	<script type="text/javascript">numberWithCommas(${p.price})</script>
            </td>
      </c:forEach>
	  
   </table>
</div>






















    
</body>
</html>

