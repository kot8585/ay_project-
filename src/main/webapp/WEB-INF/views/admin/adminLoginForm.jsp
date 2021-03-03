<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 페이지입니다!</title>
 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 
 
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>

 
<script type="text/javascript">
function go() {
	var id = document.getElementById("id");
	var password = document.getElementById("password");
	
	if(id.value == ""){
		alert("아이디를 작성해주세요! ")
		return
	}
	if(password.value == ""){
		alert("비밀번호를 작성해주세요!")
		return
	}else{
		f.submit()
	}
}	
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
<style type="text/css">
.table th {
    text-align: center;
}

.table {
    border-radius: 5px;
    width: 60%;
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
.table th{
width:40%
}
</style>
</head>
<body>
<div class="container-fluid vertical-center d-flex justify-content-center">
<form name="f" method="POST" action="${pageContext.request.contextPath }/admin/login">
	<table class="table table-hover text-centered table-bordered" border="1">
		<thead class="table-dark">
			<tr>
				<th colspan="2">관리자 로그인</th>
			</tr> 
		</thead>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" id="id"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" id="password">
			<input type="button" value="show" id="showPassword"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="로그인" onclick="go()" id="passwordCheck" >
			</td>
		</tr>
	</table>
</form>

</div>
</body>
</html>