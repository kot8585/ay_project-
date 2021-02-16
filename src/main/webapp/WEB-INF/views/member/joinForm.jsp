<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		$("#idCheck").click(function() {
			$.post("/member/idCheck", {
				id : $("#id").val()
			}).done(function(data) {
				$("#idResult").text(data);
			});
		});
		$("#join").click(function() {
			if ($("#idResult").text().trim() == "사용가능") {
				$("form").submit();
			} else {
				alert("id 중복체크 하셩");
			}
		});
	});
</script>
<script>
	function go() {
		var id = document.getElementById("id");
		var password = document.getElementById("password");
		var name = document.getElementById("name");
		var birth = document.getElementById("birth");
		var gender = document.getElementById("gender");
		var address = document.getElementById("address");
		var tel = document.getElementById("tel");
		var email = document.getElementById("email");
		if (id.value == "") {
			alert("아이디 액션빔")
			return 

		}
		if (password.value == "") {
			alert("비밀번호 액션빔")
			return 

		}
		if (name.value == "") {
			alert("이름 액션빔")
			return 

		}
		if (birth.value == "") {
			alert("생년월일 액션빔")
			return 

		}
		if (gender.value == "") {
			alert("성별 액션빔")
			return 

		}
		if (address.value == "") {
			alert("주소 액션빔")
			return 

		}
		if (tel.value == "") {
			alert("전화번호 액션빔")
			return 

		}
		if (email.value == "") {
			alert("이메일 액션빔")
			return 

		} else {
			f.submit()
		}
	}
</script>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 
<style type="text/css">
.table th {
    text-align: center;
}

.table {
    border-radius: 5px;
    width: 50%;
    margin: 0px auto;
    float: none;
}

.vertical-center {
  min-height: 100%;
  min-height: 100vh; 
  display: flex;
  align-items: center;
}

.table-bordered {
	border: 1px;
}
</style> 

 <script type="text/javascript"> 
 function goPage() { location.href="${pageContext.request.contextPath}/member/joinForm"; } 
 </script>
</head>
<body>
	<header>
<!-- navbar -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light ms-3">
    <a class="navbar-brand" href="${ pageContext.request.contextPath }/member/main">프로젝트명</a>
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
      <ul class="navbar-nav ms-auto">
        <c:if test="${ empty sessionScope.id }">
	        <li class="nav-item active">
	          	<a class="nav-link" href="${ pageContext.request.contextPath }/member/loginForm">로그인</a>
	        </li>
        </c:if>
        <c:if test="${not empty sessionScope.id }">
        	<li class="nav-item">
          		<a class="nav-link" href="${ pageContext.request.contextPath }/member/logout">로그아웃</a>
        	</li>
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/mypage/mypage">마이페이지</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ pageContext.request.contextPath }/board/faq/list">고객센터</a>
        </li>
        <li>
          <button type="button" class="btn btn-outline-primary me-2" onclick="goPage()">회원가입</button>
        </li>
      </ul>
    </div>
  </nav>
</header>
	<div class="container-fluid vertical-center justify-content-center">
	<form name="f" method="POST"
		action="${pageContext.request.contextPath }/member/join">
		<table class="table table-bordered">
			<thead class="table-dark">
				<tr>
					<th colspan="2">회원가입 창</th>
				</tr>
			</thead>
			<tr>
				<th>ID</th>
				<td colspan="2">
					<input type="text" name="id" id="id"><input type="button" value="id중복확인" id="idCheck"> 
					<span id="idResult"></span>
				</td>
			</tr>
			<tr>
				<th>PWD</th>
				<td><input type="password" name="password" id="password"></td>
			</tr>
			<tr>
				<th>Name</th>
				<td><input type="text" name="name" id="name"></td>
			</tr>
			<tr>
				<th>Birth</th>
				<td><input type="date" name="birth" id="birth"></td>
			</tr>
			<tr>
				<th>Gender</th>
				<td><input type="radio" name="gender" value="m" id="gender">남
					<input type="radio" name="gender" value="f" id="gender">여</td>
			</tr>
			<tr>
				<th>Address</th>
				<td><input type="text" id="sample4_postcode" name="postalCode" placeholder="우편번호">
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소"> 
					<input type="text" id="sample4_jibunAddress" name="address" placeholder="지번주소"> 
					<span id="guide" style="color: #999"></span> 
					<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
					<script>function sample4_execDaumPostcode() {
								new daum.Postcode({oncomplete : function(data) {
									var fullRoadAddr = data.roadAddress;
									var extraRoadAddr = '';
									if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
										extraRoadAddr += data.bname;
										}
									if (data.buildingName !== '' && data.apartment === 'Y') {
										extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										}
									if (extraRoadAddr !== '') {
										extraRoadAddr = ' (' + extraRoadAddr + ')';
										}
									if (fullRoadAddr !== '') {
										fullRoadAddr += extraRoadAddr;
										}
										document.getElementById('sample4_postcode').value = data.zonecode;
										document.getElementById('sample4_roadAddress').value = fullRoadAddr;
										document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
									if (data.autoRoadAddress) {
									var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
										document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
										} else if (data.autoJibunAddress) {
											var expJibunAddr = data.autoJibunAddress;
											document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
											} else {
												document.getElementById('guide').innerHTML = '';
												}
									}
								}).open();
								}
						</script></td>
			</tr>
			<tr>
				<th>Tel</th>
				<td><input type="text" name="tel" id="tel"></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><input type="text" name="email" id="email"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="회원가입" id="join" onclick="go()"></td>
			</tr>


		</table>
	</form>
	</div>
</body>
</html>