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
				$.post("/category/getsub", {
					type : 1,// 대분류 번호 
					p_id : 0 // 
				}).done(
						function(data) {
							var c = eval("(" + data + ")");
							for (i = 0; i < c.length; i++) {
								$("#s1").append(
										"<option value='"+c[i].id+"'>"
												+ c[i].name + "</option>"); //대분류 값을 받아와서 추가하고 
							}
						});
				
				$("#s1").click(function() {
					var x = 0;
					x = this.options[this.options.selectedIndex].value
					sel1 = x;
					$.post("/category/getsub", {
						type : 2,
						p_id : x // 전단계 대분류 
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
				});

				$("input[type=button]").click(function() {		
					if(this.form.elements[0].name=='s2'){//중뷴류 버튼을 눌렀을 때 sel1의 값을 
						this.form.p_id.value=sel1;
					}
					var o = this.form.elements[0].options;
					for(i=0;i<o.length;i++){						
						if(o[i].text==this.form.name.value){
							alert("이미 있는 카테고리입니다.");
							return;
						}
					}
					this.form.submit();
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
		<input type="button" id="b1" value="추가">
	</form>
	<br>	
	분류 2:	
	<form id="f2" action="${pageContext.request.contextPath }
	/category/addCategory" onsubmit="return false"  method="post">
		<select id="s2"  name="s2"></select> 
		<input type="text" id="n2" name="name">
		<input type="hidden" name="type" value="2">
		<input type="hidden" id="h1" name="p_id" value="">
		<input type="button" id="b2" value="추가">
	</form>
<hr>
<h3 id="event">&nbsp;</h3><br>
<h3>이벤트 TODO</h3>
<!-- TODO 여기는 이벤트 이미지 크기를 확정 후 작성하도록 한다. -->
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
<c:import url="${ pageContext.request.contextPath }/admin/boardList"></c:import>
</body>
</html>