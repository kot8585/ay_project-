<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	if(id.value == ""){
		alert("아이디 액션빔")
		return 
	}
	if(password.value == ""){
		alert("비밀번호 액션빔")
		return 
	}
	if(name.value == ""){
		alert("이름 액션빔")
		return 
	}
	if(birth.value == ""){
		alert("생년월일 액션빔")
		return 
	}
	if(gender.value == ""){
		alert("성별 액션빔")
		return 
	}
	if(address.value == ""){
		alert("주소 액션빔")
		return 
	}
	if(tel.value == ""){
		alert("전화번호 액션빔")
		return 
	}
	if(email.value == ""){
		alert("이메일 액션빔")
		return 
	}else{
		f.submit()
	}
}	
</script>
</head>
<body>
<h3>액션빔</h3>
<form name="f" method="POST" action="${pageContext.request.contextPath }/member/join">
	<table border="1">
		<tr>
			<th>ID</th>
			<td colspan="2">
			<input type="text" name="id" id="id">
			
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
			<td><input type="text" name="address" id="address"></td>
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
			<td><input type="button" value="회원가입" onclick="go()"></td>
		</tr>
		
		
	</table>
</form>
</body>
</html>