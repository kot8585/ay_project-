<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Shop Item - Start Bootstrap Template</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/shop-item.css" rel="stylesheet">
  
  
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
		return true;
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

input:focus {outline:none;}
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.inputStyle{
border:1px;
}

</style>

<style type="text/css">

.button {

    width:100px;

    background-color: #f8585b;

    border: none;

    color:#fff;

    padding: 15px 0;

    text-align: center;

    text-decoration: none;

    display: inline-block;

    font-size: 15px;

    margin: 4px;

    cursor: pointer;

}
</style>

</head>
<body>
<header>
<script type="text/javascript" src="/js/header.js"></script>
</header>
<!-- Navigation -->
<!--   <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"> -->
    <div class="container">
<!--       <a class="navbar-brand" href="#">Start Bootstrap</a> -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Services</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container">

    <div class="row">

      <div class="col-lg-3">
        <h1 class="my-4">카테고리</h1>
        <div class="list-group">
          <a href="#" class="list-group-item active">Category 1</a>
          <a href="#" class="list-group-item">Category 2</a>
          <a href="#" class="list-group-item">Category 3</a>
        </div>
      </div>
      <!-- /.col-lg-3 -->
<%-- <form name="f" action="${ pageContext.request.contextPath }/order/orderForm" method="post" onsubmit="return check()"> --%>
      <div class="col-lg-9">

        <div class="card mt-4">
        
        <form name="f" action="${ pageContext.request.contextPath }/order/orderForm" method="post" onsubmit="return check()">
       
        
<!--         <div id = "mid_content"> -->
<!--         <div id = "side_content_box"> -->
          <img class="card-img-top img-fluid" img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }"style="width:300px;height:300px">
<!--        </div> -->
       
<!--        <div id = "side_content_box"> -->
          <div class="card-body">
<!--           상품명 -->
<%--             <h1 class="card-title">${p.name }</h1><hr> --%>
            <input type="text" name="name" value="${p.name }" readonly style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">

<!--             가격 -->
            <h3><script>document.getElementById('cost').value = numberWithCommas(${p.price })</script>원</h3><hr>
            <input type="hidden" id="cost" value="${p.price }" readonly style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
<!-- <script>document.getElementById('cost').value = numberWithCommas(${p.price })</script> -->
            
<!--             메이커 -->
            <h7>메이커: ${p.maker }</h7><br>
            
<!--             원산지 -->
            <h7>원산지: ${p.origin}</h7><br>
            
<!--             재료 -->
            <h7>재료: ${p.material}</h7><hr>
           
            
<!--             남은수량 -->
            <h5><c:if test="${p.quantity == 0}">
					<input type="text" value="품절되었습니다." name="inventory" readonly="readonly">
					</c:if> 
					<c:if test="${p.quantity != 0}">
						<input type="text" value="${p.quantity }" name="inventory" readonly="readonly">
					</c:if>
					개 남음</h5>
<!-- 					선택수량 -->
			<h5>
			<input type="text" name="quantity" class="inputStyle" placeholder="수량을 선택해주세요"> 개 선택
			</h5>
			<h5>
 <input type="hidden" name="m_id" id="m_id" value="${ sessionScope.id }">
    <input type="hidden" name="p_name" value="${p.name }">
    <c:if test="${p.quantity == 0}">
	 	<input type="button" value="품절">
    </c:if> 
    <c:if test="${p.quantity != 0}">
		<input type="submit" value="구매">
	</c:if>
   <input type="hidden" name="price" id="price" value="${p.price }">
   <input type="hidden" name="p_num" id="p_num" value="${p.num }">
   <input type="button" value="장바구니로" id="cart">
   
   <input type="button" value="상품문의" onclick="go(${p.num})">
</h5>
<!-- </div> -->
<!-- </div> -->
</form>
   



</p>
            <span class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
            4.0 stars
          </div>
        </div>
        <!-- /.card -->

        <div class="card card-outline-secondary my-4">
        <!-- 리뷰 -->  
          <div class="card-header">
            
			<c:import url="${ pageContext.request.contextPath }/review/reviewlist?p_num=${ p.num }&what=basic"></c:import>
        </div>
        <!-- /.card -->

      </div>
      <!-- /.col-lg-9 -->

    </div>

  </div>
  <!-- /.container -->

<!--   <!-- Footer --> -->
<!--   <footer class="py-5 bg-dark"> -->
<!--     <div class="container"> -->
<!--       <p class="m-0 text-center text-white">Copyright &copy; Your Website 2020</p> -->
<!--     </div> -->
<!--     /.container -->
<!--   </footer> -->

<!--   <!-- Bootstrap core JavaScript --> -->
<!--   <script src="vendor/jquery/jquery.min.js"></script> -->
<!--   <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->




<div id = "mid_content">





<c:import url="${ pageContext.request.contextPath }/pquestion/plist?pnum=${ p.num }"></c:import>

</div>








</body>
</html>