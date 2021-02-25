<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
  		var cost = $("#cost").val();
  		if (m_id != "") {
  			alert("장바구니에 추가되었습니다!");
  			$.post("/cart/addCart", { m_id: m_id, p_num: p_num, cost: cost })
  	  		.done(function(data) {
  	  			alert("장바구니에 추가되었습니다!");
  	  		});
		} else {
			alert("로그인 후 이용바랍니다.");
		}
  	});
});
   
   function check() {
		var quantity = document.f.quantity;
		if (quantity.value == "") {
			alert("주문수량을 기재해주세요.");
			quantity.value = "";
			quantity.focus();
			return false;
		}
   }
   function go(i){
		location.href="${pageContext.request.contextPath}/pquestion/pquestionForm?pnum="+i;
	}
  
</script>
</head>
<body>
<a href="${pageContext.request.contextPath }/member/main">Main</a>
<h5>세션 id : ${ sessionScope.id }</h5>
<h3>상품 상제 정보</h3>
<form name="f" action="${ pageContext.request.contextPath }/order/orderForm" method="post" onsubmit="return check()">
<table border="1" cellspacing="0">
<tr>

<th>번호</th>
<td><input type="text" name="p_num" id="p_num" value="${p.num }" readonly></td>
</tr>


<tr>

<th>상품명</th>
<td><input type="text" name="name" value="${p.name }" readonly>

</td>
</tr>

<tr>
         <th>이미지</th>
         <td><c:if test="${empty file0 }">
               등록된 이미지가 없습니다.
               </c:if> 
               <c:if test="${not empty file0 }">
               <table>
                  <tr>
                     <td colspan="3">
                     <img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }" 
                     style="width:150px;height:150px"></td>
                  </tr>
                  <tr>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file1 }&num=${p.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file2 }&num=${p.num }" class="img" width="50" height="50"></td>
               </table>
            </c:if></td>
      </tr>
<tr>
<th>메이커</th>
<td><input type="text" name="maker" value="${p.maker }" readonly></td>
</tr>

<tr>
<th>가격</th>
<td><input type="text" name="price" id="cost"  value="${p.price }" readonly></td>
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
<th>남는수량</th>
<td><input type="text" value="${p.quantity }" readonly="readonly"></td>
</tr>

<tr>
<th>주문수량</th>
<td><input type="text" name="quantity"></td>
</tr>

<tr>
<td colspan="2">
	<input type="hidden" name="m_id" id="m_id" value="${ sessionScope.id }">
	<input type="submit" value="구매" >
	<input type="button" value="장바구니로" id="cart">
	<input type="button" value="상품문의" onclick="go(${p.num})">
</td>
</tr>
</table>
</form>


<c:import url="${ pageContext.request.contextPath }/review/reviewlist?p_num=${ p.num }&what=basic"></c:import>
<c:import url="${ pageContext.request.contextPath }/pquestion/plist?pnum=${ p.num }"></c:import>



</body>
</html>