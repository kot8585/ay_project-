<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>

<script>
	$(document)
			.ready(
					function() {
						$("#pwdcheck")
								.click(
										function() {
											if ($("#password").val() == "") {
												alert("비밀번호를 입력해주세요");
												return;
											} else {
												$
														.post(
																"/member/editpwdCheck",
																{
																	id : $(
																			"#id")
																			.val(),
																	password : $(
																			"#password")
																			.val()
																})
														.done(
																function(data) {
																	var result_data = eval("("
																			+ data
																			+ ")")
																	if (result_data.result == "1") {
																		alert("로그인을 해주세요!");
																	}
																	if (result_data.result == "2") {
																		$("#f")
																				.attr(
																						"action",
																						"${pageContext.request.contextPath }/member/editForm");
																		$("#f")
																				.submit();
																	}
																	if (result_data.result == "3") {
																		alert("비밀번호가 다릅니다!");
																	}
																})
											}
										});
					});
</script>
<style type="text/css">
.container{
width:575px;
}
.vertical-center {
	min-height: 100%;
	min-height: 100vh;
	display: flex;
	align-items: center;
}

input {
	border: 1px;
}

h2 {
	text-align: center;
	
}

#btn {
	width: 575px;
	height: 43px;
	fontsize: 30px;
}
{
width:500px;
}
</style>
<body>
	<header>
		<script type="text/javascript" src="/js/loginSessionExist.js"></script>
	</header>
	<div class="container-fluid vertical-center d-flex justify-content-center">
		<form name="f" id="f" method="post" action="${pageContext.request.contextPath }/member/editpwdCheck">
			<div id="container" class="container">
				<h2>비밀 번호 확인</h2>
				<div class="input-group mb-3 input-group-lg">
					<div class="input-group-prepend"></div>
					<input class="form-control" type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요.">
				</div>
				<div class="card card-outline-secondary my-4">
					<button class="btn btn-danger" id="pwdcheck" onclick="go()">확인</button>
				</div>
			</div>
		</form>
	</div>
</body>

</html>