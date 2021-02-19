<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
$(document).ready(function(){
  $('#showPassword').on('click', function(){
    var passwordField = $('#password');
    var passwordFieldType = passwordField.attr('type');
    if(passwordFieldType == 'password')
    {
    	passwordField.attr('type', 'text');
    	$(this).val('Hide');
    } else {
    	passwordField.attr('type', 'password');
    	$(this).val('Show');
    }
  });
});
</script>
<script>
$(document).ready(function(){
	  $('#showPassword1').on('click', function(){
	    var passwordField = $('#password1');
	    var passwordFieldType = passwordField.attr('type');
	    if(passwordFieldType == 'password')
	    {
	    	passwordField.attr('type', 'text');
	    	$(this).val('Hide');
	    } else {
	    	passwordField.attr('type', 'password');
	    	$(this).val('Show');
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
	function checkpwd(){
		var pwd = document.getElementById("password");
		var pwdcheck = document.getElementById("password1");
		if(pwd.value == null){
			return;
		} 
		if(pwd.value != pwdcheck.value){
			alert("입력된 비밀번호가 다름");
		}
	}
</script>
</head>
<body>
	<h3>액션빔</h3>
	<h3>
		<a href="${pageContext.request.contextPath }/member/main">Main</a>
	</h3>
	<form name="f" method="POST"
		action="${pageContext.request.contextPath }/member/join">
		<table border="1">
			<tr>
				<th>ID</th>
				<td colspan="2"><input type="text" name="id" id="id"> <input
					type="button" value="id중복확인" id="idCheck"placeholder="아이디를 쓰세여"> 
					<span id="idResult"></span></td>
			</tr>
			<tr>
				<th>PWD</th>
				<td><input type="password" name="password" id="password" placeholder="비밀번호를 쓰세여">
				<input type="button" value="show" id="showPassword"></td>
			</tr>
			<tr>
				<th>PWDCHK</th>
				<td><input type="password" name="password1" id="password1" onchange="checkpwd()"
				placeholder="비밀번호를 쓰세여">
				<input type="button" value="show" id="showPassword1"></td>
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
				<td><input type="button" value="회원가입" id="join" onclick="go()"></td>
			</tr>


		</table>
	</form>
</body>
</html>