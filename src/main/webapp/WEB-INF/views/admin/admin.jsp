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
	$(document).ready(
			function() {
				console.log("[시작] 카테고리1 리스트 가져오기");
				$.post("/category/getCategory", {
					type : 1,// 대분류 번호 
					c_id : 0 // 대분류에는 필요없으나 메소드 매개변수라 그냥 넣음.
				}).done(
						function(data) {
							var c = eval("(" + data + ")");
							$("#s1").append("<option value=''>   </option>");
							for (i = 0; i < c.length; i++) {
								$("#s1").append(
										"<option value='"+c[i].id+"'>"
												+ c[i].name + "</option>"); //대분류 값을 받아와서 추가하고 
							}
							console.log("[종료] 카테고리1 리스트 가져오기");
						});
				
				$("#s1").click(function() {
					console.log("[시작] 카테고리1 리스트 클릭 이벤트");
					var x = 0;
					x = this.options[this.options.selectedIndex].value;
					console.log("[1] 클릭한 카테고리1 value 저장..." + x);
					this.form.name.value = this.options[this.options.selectedIndex].text;
					console.log("[2] 클릭한 카테고리1 text, input text에 저장..."+this.form.name.value);
					sel1 = x;
					console.log("[3] 컨트롤러에 /category/getCategory 전송...");
					$.post("/category/getCategory", {
						type : 2,
						c_id : x // 전단계 대분류 
					}).done(function(data) {
						var c = eval("(" + data + ")");
						$("#s2").empty();//초기화를 하려면 비우고 
						$("#s2").append("<option value=''>"
								+ "---" + "</option>");
						for (i = 0; i < c.length; i++) {
							$("#s2").append("<option value='"+c[i].id+"'>"//추가하고 
									+ c[i].name + "</option>");
						}
					});
					console.log("[종료] 카테고리1 리스트 클릭 이벤트");
				});

				$(".add").click(function() {
					console.log("[시작] 카테고리1 추가 이벤트");
					if(this.form.elements[0].name=='s2'){//중분류 버튼을 눌렀을 때 sel1의 값을 
						this.form.c_id.value=sel1;
						console.log("[시작] 카테고리2 추가 이벤트로 변경");
					}

					console.log("[1] 셀렉터의 option을 모두 받아와 input text에 입력된 값과 같은 값이 있다면 이미 있다는 메시지를 띄움.");
					var o = this.form.elements[0].options;
					for(i=0;i<o.length;i++){						
						if(o[i].text==this.form.name.value){
							alert("이미 있는 카테고리입니다.");
							return;
						}
					}
					console.log("[종료] 카테고리1,2 추가 이벤트, 이후에는 컨트롤러(/category/addCategory)에서 해결");
					this.form.submit();
				});
				
				$("#s2").click(function() {
					console.log("[시작] 카테고리2 클릭 이벤트");
					var y = 0;
					y = this.options[this.options.selectedIndex].value;
					console.log("[1] 클릭한 카테고리2의 value를 저장..." + y);
					this.form.name.value = this.options[this.options.selectedIndex].text;
					console.log("[2] 클릭한 카테고리2 text, input text에 저장..."+this.form.name.value);
					sel2 = y;
					console.log("[종료] 카테고리2 클릭 이벤트");
				});
				
				$(".edit").click(function() {
					
					if(this.form.elements[0].name=='s2'){//중분류 버튼을 눌렀을 때 sel1의 값을 
						console.log("[시작] 카테고리2 수정 이벤트");
						$.post("/category/editCategory", {
							type : 2,// 대분류 번호
							id : sel2,
							name : this.form.name.value,
							c_id : sel1
						}).done(function(data) {
							console.log("[종료] 카테고리2 수정 이벤트");
							location.href = "${pageContext.request.contextPath }/admin/admin";
						});
					} else {
						console.log("[시작] 카테고리1 수정 이벤트");
						$.post("/category/editCategory", {
							type : 1,// 대분류 번호
							id : sel1,
							name : this.form.name.value
						}).done(function(data) {
							console.log("[종료] 카테고리1 수정 이벤트");
							location.href = "${pageContext.request.contextPath }/admin/admin";
						});
					}
				});
				
				$(".delete").click(function() {
					if(this.form.elements[0].name=='s2'){//중분류 버튼을 눌렀을 때 sel1의 값을 
						console.log("[시작] 카테고리2 삭제 이벤트");
						$.post("/category/deleteCategory", {
							type : 2,// 대분류 번호
							id : sel2
						}).done(function(data) {
							console.log("[종료] 카테고리2 삭제 이벤트");
							location.href = "${pageContext.request.contextPath }/admin/admin";
						});
					} else {
						console.log("[시작] 카테고리1 삭제 이벤트");
						$.post("/category/deleteCategory", {
							type : 1,// 대분류 번호
							id : sel1
						}).done(function(data) {
							console.log("[종료] 카테고리1 삭제 이벤트");
							location.href = "${pageContext.request.contextPath }/admin/admin";
						});
					}
				});
				
			});
</script>
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
	분류 1:
	<form id="f1"action="${pageContext.request.contextPath }/category/addCategory" onsubmit="return false" method="post">
		<select id="s1" name="s1"></select> 
		<input type="text" id="n1" name="name">
		<input type="hidden" name="type" value="1">
		<input type="button" id="b1" class="add" value="추가">
		<input type="button" id="e1" class="edit" value="수정">
		<input type="button" id="d1" class="delete" value="삭제">
	</form>
	<br>	
	분류 2:	
	<form id="f2" action="${pageContext.request.contextPath }
	/category/addCategory" onsubmit="return false"  method="post">
		<select id="s2"  name="s2"></select> 
		<input type="text" id="n2" name="name">
		<input type="hidden" name="type" value="2">
		<input type="hidden" id="h1" name="c_id" value="">
		<input type="button" id="b2" class="add" value="추가">
		<input type="button" id="e2" class="edit" value="수정">
		<input type="button" id="d2" class="delete" value="삭제">
	</form>
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