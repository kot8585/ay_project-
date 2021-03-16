
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
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



//페이지내 검색 함수 https://ckim0531.tistory.com/entry/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8-%EA%B2%80%EC%83%89-%EA%B5%AC%ED%98%84
$(document).ready(function() {

	// 키보드 키 눌렀을 때 이벤트 발생

	$("#search").keyup(function() {

		// keyup이 되었을 때 텍스트 필드에 입력한 문자열값을 읽어내 변수 k에 저장

		var k = $(this).val();

		// 텍스트 필드에 입력한 값을 읽어낸 후에 #p_table > tbody > tr와 같이 자식 선택자를

		// 연속으로 사용하여 tbody 태그 내의 tr에 대해 hide() 메서드 호출 후 모두 화면에 보이지않도록 함

		$("#p_table > tbody > tr").hide();

		

		// :contains() 필터 활용하여 검색어를 포함하는 tr만 화면에 나타나게 함

		// #p_table > tbody > tr > td:nth-child(7n+3):contains('두') 형태의 선택자

		// 문자열을 먼저 생성한 후에 $() 함수에 인자로 전달 // 선택자가 복잡하여 미리 문자열을 생성

		// #p_table 자식 중 tbody, tbody 자식 중 tr, tr 자식 중 td:nth-child(7n+3)를 찾아

		// :contains("두")로 "두"라는 문자열을 포함하는 td셀을 선택

		// 화면에 나타나도록 처리하는 요소는 td 부모인 tr이므로 parent() 메서드로 부모 요소를 선택하여 화면에 나타나도록 함

		var name = $("#p_table > tbody > tr > td:nth-child(7n+3):contains('" + k + "')");

		var price = $("#p_table > tbody > tr > td:nth-child(7n+5):contains('" + k + "')");

        $(name).parent().show();

        $(price).parent().show();

    })

});
</script>
<style type="text/css">
a {
	color: #6E6E6E;
	text-decoration: none;
}
</style>
</head>
<body>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<h3>상품리스트</h3>
	<div align="right" "style=""height: 100px;">
		<h3>
			검색<input type="text" id="search" placeholder="상품명, 가격">
		</h3>
	</div>
	<div class="container-fluid justify-content-center">
		<table border="1" class="table table-bordedark" id="p_table">
			<thead class="table-warning"
				style="border: 0px solid white; text-align: center;">
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

			<tbody>
				<c:forEach var="p" items="${list}" varStatus="vs">
					<tr class="tb_content">
						<td style="width: 16.66%" colspan="1" align="center">
						<td><a href="${pageContext.request.contextPath }/product/detail?num=${p.num}">
						<img id="bigImg"
							src="${pageContext.request.contextPath }/img?fname=${p.imgPath }&num=${p.num}"
							style="width: 250px; height: 250px"></td></a>

						<td>
							<h3>
								<a
									href="${pageContext.request.contextPath }/product/detail?num=${p.num}">${p.name}</a>
							</h3>
						</td>
						<td>
							<h3>
								<script type="text/javascript">numberWithCommas(${p.price})</script>
							</h3>
						</td>
						<td>
							<h5>
								<c:if test="${p.quantity == 0}">
									<input type="text" value="품절되었습니다." name="inventory"
										readonly="readonly">
								</c:if>
								<c:if test="${p.quantity != 0}">
									<input type="text" value="${p.quantity }" name="inventory"
										readonly="readonly">
								</c:if>
								개 남음
							</h5> <!-- 					선택수량 -->
						</td>
				</c:forEach>

			</tbody>
		</table>
	</div>
</body>
</html>

