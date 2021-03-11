<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var sel1=0; //선택한 것 저장할 변수 대분류
	var sel2=0; //선택한 것 저장할 변수 소분류
	
	// 카테고리 1 안의 버튼 클릭시 해당 td의 id 저장 
	function setCategoty1(id) {
		sel1 = id;
	}
	
	// 카테고리 2 안의 버튼 클릭시 해당 td의 id 저장
	function setCategoty2(id) {
		sel2 = id;
	}
	
	
	$(document).ready(
			function() {
				console.log("[시작] 카테고리1 리스트 가져오기");
				$.post("/category/getCategory", {
					type : 1,// 대분류 번호 
					c_id : 0 // 대분류에는 필요없으나 메소드 매개변수라 그냥 넣음.
				}).done(
						function(data) {
							var c = eval("(" + data + ")");
							
							// 카테고리1 테이블에 카테고리 값들 저장.
							for (i = 0; i < c.length; i++) {
								$("#categoryTable_1").append("<tr><td align='center' class='clickTd'><form>"
										+ "<input type='hidden' value='"+c[i].id+"' name='c_id' readonly>"
										+ "<input type='text' name='clickIp' value='"+c[i].name+"' onclick='javascript:setCategoty1("+c[i].id+")' disabled>"
										+ " <input type='button' name='edit1' value='선택' onclick='javascript:setCategoty1("+c[i].id+")' class='edit1'>"
										+ " <input type='button' name='del1' value='삭제' onclick='javascript:setCategoty1("+c[i].id+")' class='del1'>"
										+ "</form></td></tr>");
							}
				});
				
				
				$("#addCategory1").click(function () {
					// 버튼 클릭시 addCategory 실행
					this.form.submit();
				});
				
				// id 가 addcategory2 인 input(type=button)을 클릭하였을 경우 실행
				$(document).on("click", "input[id='addCategory2']", function () {
					// 버튼 클릭시 addCategory 실행
					this.form.submit();
				});
				
				// https://stackoverflow.com/questions/25628080/jquery-click-inputtype-doesnt-work
				$(document).on("click", "input[class='edit1']", function() {
					if (this.form.edit1.value == '선택') { // 해당 카테고리를 선택하는 기능.
						this.form.clickIp.disabled = false; // clickIp라는 name을 가진 tag를 활성화.
						var x = sel1;
						$.post("/category/getCategory", { // 해당 카테고리의 서브카테고리를 불러옴.
							type : 2,
							c_id : x // 전단계 대분류 
						}).done(function(data) {
							var c = eval("(" + data + ")");
							$("#categoryTable_2").empty();//초기화를 하려면 비우고
							$("#categoryTable_2").append("<tr class='table-danger'><td align='center'>카테고리 2</td></tr>");
							var html = "<tr>";
							html += "<td align='center'>";
							html += "<input type='text' name='name'> ";
							html += "<input type='button' id='addCategory2' value='새 카테고리 추가'>";
							html += "<input type='hidden' name='id' value='0'>";
							html += "<input type='hidden' name='type' value='2'>";
							html += "<input type='hidden' name='c_id' value='"+ x +"'>";
							html += "</td>";
							html += "</tr>";
							$("#categoryTable_2").append(html);
							for (i = 0; i < c.length; i++) {
									$("#categoryTable_2").append("<tr><td align='center' class='clickTd'><form>"
											+ "<input type='hidden' value='"+c[i].id+"' name='c_id' readonly>"
											+ "<input type='text' name='clickIp' value='"+c[i].name+"' onclick='javascript:setCategoty2("+c[i].id+")' disabled>"
											+ " <input type='button' name='edit2' class='edit2' value='선택' onclick='setCategoty2("+ c[i].id +")'>"
											+ " <input type='button' name='del2' class='del2' value='삭제' onclick='javascript:setCategoty2("+c[i].id+")'>"
											+ "</form></td></tr>");
								}
						});
						this.form.edit1.value = '수정';
					} else {
						this.form.clickIp.disabled = true;
						$.post("/category/editCategory", {
							type : 1,// 대분류 번호
							id : sel1,
							name : this.form.clickIp.value,
						}).done(function(data) {
						});
						this.form.edit1.value = '선택';
					}
					
				});
				
				
				
				$(document).on("click", "input[class='edit2']", function() {
					if (this.form.edit2.value == '선택') {
						this.form.clickIp.disabled = false;
						var x = sel2;
						this.form.edit2.value = '수정';
					} else {
						this.form.clickIp.disabled = true;
						$.post("/category/editCategory", {
							type : 2,// 대분류 번호
							c_id: sel1,
							id : sel2,
							name : this.form.clickIp.value,
						}).done(function(data) {
							console.log("[종료] 카테고리2 수정 이벤트");
						});
						this.form.edit2.value = '선택';
					}
					
				});
				
				$(document).on("click", "input[class='del1']", function() {
					$.post("/category/deleteCategory", {
						type : 1,// 대분류 번호
						id : sel1
					}).done(function(data) {
					});
				});
				
				$(document).on("click", "input[class='del2']", function() {
					$.post("/category/deleteCategory", {
						type : 2,// 대분류 번호
						id : sel2,
						c_id: sel1
					}).done(function(data) {
					});
				});
				
				
			});
	

	
</script>
<style type="text/css">
.clickTd:hover {
	background-color: blue;
}
</style>
 <title>Insert title here</title>
</head>
<body>
<!-- navbar -->
  <nav class="navbar fixed-top navbar-expand-lg fixed-top navbar-light bg-light mr-3"> 
	<a class="navbar-brand" href="${ pageContext.request.contextPath }/admin/admin">프로젝트명</a>
    <button class="navbar-toggler" 
		    type="button" 
		    data-bs-toggle="collapse" 
		    data-bs-target="#navbarSupportedContent" 
		    aria-controls="navbarSupportedContent" 
		    aria-expanded="false" 
		    aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav md-auto">
	    <li class="nav-item active">
	        <a class="nav-link" href="#category">카테고리</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#event">이벤트</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#orderList">전체 구매 이력</a>
	    </li>
        <li class="nav-item active">
	        <a class="nav-link" href="#productList">전체 상품 목록</a>
	    </li>
	    <li class="nav-item active">
	        <a class="nav-link" href="#boardList">전체 문의 목록</a>
	    </li>
      </ul>
    </div>
</nav>

<br><br><br>
<h3 id="category">&nbsp;</h3><br>
<h3>카테고리</h3>
	<br><br>
	<div class="d-flex justify-content-center">
		<form action="${pageContext.request.contextPath }/category/addCategory" method="post" onsubmit="return false">
			<table border="1" class="table table-bordered" id="categoryTable_1" style="caption-side: top;">
				<tr class="table-danger">
					<td align="center">카테고리 1</td>
				</tr>
				<tr>
					<td align="center">
						<input type="hidden" name="type" value="1">
						<input type="text" name="name">
						<input type="button" id="addCategory1" value="새 카테고리 추가">
						<input type="hidden" name="id" value="0">
					</td>
				</tr>
			</table>
		</form>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<form action="${pageContext.request.contextPath }/category/addCategory" method="post" onsubmit="return false">
			<table border="1" class="table table-bordered" id="categoryTable_2" style="caption-side: top;">
				
			</table>
		</form>
	</div>
	
	


<hr>
<h3 id="event">&nbsp;</h3><br>
<h3>이벤트</h3>
<c:import url="${ pageContext.request.contextPath }/admin/eventList"></c:import>
<hr>
<h3 id="orderList">&nbsp;</h3><br>
<h3>전체 구매 이력</h3>
<c:import url="${ pageContext.request.contextPath }/admin/orderList"></c:import>
<hr>
<h3 id="productList">&nbsp;</h3><br>
<h3>전체 상품 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/productList"></c:import>
<hr>
<h3 id="boardList">&nbsp;</h3><br>
<h3>전체 문의 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/qnaList"></c:import>

<h3 id="pList">&nbsp;</h3><br>
<h3>전체 상품 문의 목록</h3>
<c:import url="${ pageContext.request.contextPath }/admin/pList"></c:import>


</body>
</html>