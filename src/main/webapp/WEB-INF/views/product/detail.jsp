<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 


<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
   $(document).ready(function() { 
	   
      $(".img").mouseover(function() {
         $("#bigImg").attr('src', this.src);
      });
      
      $("#cart").click(function() {
    		var m_id = $("#m_id").val();
    		var p_num = $("#p_num").val();
    		var cost = $("#price").val();
    		var cf = confirm("정말로 장바구니에 추가하시겠습니까?");
    		if(cf == true) {
    			if (m_id != "") {
    	  			alert("장바구니에 추가되었습니다!");
    	  			$.post("/cart/addCart", { m_id: m_id, p_num: p_num, cost: cost })
    	  	  		.done(function(data) {
    	  	  			alert("장바구니에 추가되었습니다!");
    	  	  		});
    			} else {
    				alert("로그인 후 이용바랍니다.");
    			}
    		}
    	});
	});
   
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
	     
	    return str + '원';
	}


   
  
   function check() {
      var quantity = document.f.quantity;
      if (quantity.value == "") {
         alert("주문수량을 기재해주세요.");
         quantity.value = "";
         quantity.focus();
         return false;
      }
      if (quantity.value <= 0) {
			alert("주문수량은 음수이거나 0일 수 없습니다.");
			quantity.value = "";
			quantity.focus();
			return false;
		}
		
		if (quantity.value > inventory.value) {
			alert("재고가 부족합니다!");
			quantity.focus();
			return false;
		}
   }
   function go(i){
      location.href="${pageContext.request.contextPath}/pquestion/pquestionForm?pnum="+i;
   }
  
</script>

<style>

 body { margin:0; padding:0; font-family:'맑은 고딕', verdana; }
 a { color:#05f; text-decoration:none; }
 a:hover { text-decoration:underline; }
 
 h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }
 ul, lo, li { margin:0; padding:0; list-style:none; }

 /* ---------- */
 
 div#root { width:900px; margin:0 auto; }
 header#header { }
 nav#nav { }
 section#container { }
  section#content { float:right; width:700px; }
  aside#aside { float:left; width:180px; }
  section#container::after { content:""; display:block; clear:both; } 
 footer#footer { background:#eee; padding:20px; }
 
 /* ---------- */
 
 header#header div#header_box { text-align:center; padding:30px 0; }
 header#header div#header_box h1 { font-size:50px; }
 header#header div#header_box h1 a { color:#000; }
 
 nav#nav div#nav_box { font-size:14px; padding:10px; text-align:right; }
 nav#nav div#nav_box li { display:inline-block; margin:0 10px; }
 nav#nav div#nav_box li a { color:#333; }
 
 section#container { }
 
 aside#aside h3 { font-size:22px; margin-bottom:20px; text-align:center; }
 aside#aside li { font-size:16px; text-align:center; }
 aside#aside li a { color:#000; display:block; padding:10px 0; }
 aside#aside li a:hover { text-decoration:none; background:#eee; }
 
 
 
</style>

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
margin:5px;
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
</style>




</head>
<body>
<header>
<script type="text/javascript" src="/js/header.js"></script>
</header>


<h3>상품 상제 정보</h3>
<form name="f" action="${ pageContext.request.contextPath }/order/orderForm" method="post" onsubmit="return check()">
<table cellspacing="0">
<tr>
   
      <div id = "side_left">
      <aside id="aside">
            <%@ include file="include/aside.jsp" %>
         </aside>
         </div>
         
<!--     <div id = "side_left_box">사이드바 왼쪽 위</div> -->
<!--     <div id = "side_left_box">사이드바 왼쪽 아래</div> -->
<!-- </div> -->
<!-- <div id = "mid_content"> -->
<!--     <div id = "side_content_box">첫번째 공간</div> -->
    
<!--     <div id = "side_content_box">두번째 공간</div> -->
    
<!-- </div> -->
<!-- <div id = "side_rigth">사이드바 오른쪽 -->
<!--     <div id = "side_rigth_box">사이드바 오른쪽 아래</div> -->
<!-- </div> -->

<div id = "mid_content">
    <div id = "side_content_box"><img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }" 
     style="width:150px;height:150px"></div>
     </div>
     

    <div id = "side_content_box">
    <table cellspacing="0" width="500px">
<%--     <input type="text" name="p_num" id="p_num" value="${p.num }" readonly></div> --%>
<thead>
				<tr>
					<th>번호</th>
					<td><input type="text" name="p_num" id="p_num" value="${p.num }" readonly></td>
				</tr>
<!-- <div id = "side_content_box"> -->	
<tr>
<th>상품명</th>

<td><input type="text" name="name" value="${p.name }" readonly>
</td>
</tr>
<!-- </div> -->

<!-- <div id = "side_content_box"> -->
<tr>
<th>메이커</th>
<td><input type="text" name="maker" value="${p.maker }" readonly></td>
</tr>

<tr>
<th>가격</th>
<td><input type="text" id="cost" value="${p.price }" readonly>
<script>document.getElementById('cost').value = numberWithCommas(${p.price })</script>
</td>
</tr>

<tr>
<th>원산지</th>
<td><input type="text" name="origin" value="${p.origin }" readonly></td>
</tr>


<tr>
<th>재료</th>
<td><input type="text" name="material" value="${p.material }" readonly></td>
</tr>

<tr>
<th>남은수량</th>
<td><c:if test="${p.quantity == 0}">
<input type="text" value="품절되었습니다." name="inventory" readonly="readonly">
					</c:if> 
					<c:if test="${p.quantity != 0}">
						<input type="text" value="${p.quantity }" name="inventory" readonly="readonly">
					</c:if>
</td>
</tr>

<tr>
<th>주문수량</th>
<td><input type="text" name="quantity"></td>
</tr>

<tr>
<td colspan="2">
    <input type="hidden" name="m_id" id="m_id" value="${ sessionScope.id }">
    <input type="hidden" name="p_name" value="${p.name }">
    <c:if test="${p.quantity == 0}">
	 	<input type="button" value="품절">
    </c:if> 
    <c:if test="${p.quantity != 0}">
		<input type="submit" value="구매">
	</c:if>
   <input type="hidden" name="price" id="price" value="${p.price }">	 
   <input type="button" value="장바구니로" id="cart">
   <input type="button" value="상품문의" onclick="go(${p.num})">
</td>
</tr>

</thead></table></div></tr>

   

</table>
</form>


<c:import url="${ pageContext.request.contextPath }/review/reviewlist?p_num=${ p.num }&what=basic"></c:import>
<c:import url="${ pageContext.request.contextPath }/pquestion/plist?pnum=${ p.num }"></c:import>








</body>
</html>