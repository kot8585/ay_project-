<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	//아이디 정규식
	let idJ = /^[a-z0-9]{4,12}$/;
	// 비밀번호 정규식
	let pwdJ = /^[A-Za-z0-9]{4,12}$/;
	// 이름 정규식
	let nameJ = /^[가-힣]{2,6}$/;
	// 이메일 검사 정규식
	let emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	// 휴대폰 번호 정규식
	let telJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	$(document).ready(function() {
		$("#password1").keyup(function() {
			if (pwdJ.test($(this).val())) {
				$("#pwd1_check").text('사용가능');
				$('#pwd1_check').css('color', 'green');
			} else {
				$("#pwd1_check").text('불가능');
				$('#pwd1_check').css('color', 'red');
			}
		});
		$("#password2").keyup(function() {
			if ($("#password1").val() == $("#password2").val()) {
				$("#pwd2_check").text('사용가능');
				$('#pwd2_check').css('color', 'green');
			} else {
				$("#pwd2_check").text('불가능');
				$('#pwd2_check').css('color', 'red');
			}
		});
		$("#name").keyup(function() {
			if (nameJ.test($(this).val())) {
				$("#name_check").text('사용가능');
				$('#name_check').css('color', 'green');
			} else {
				$("#name_check").text('불가능');
				$('#name_check').css('color', 'red');
			}
		});
		$("#tel").keyup(function() {
			if (telJ.test($(this).val())) {
				$("#tel_check").text('사용가능');
				$('#tel_check').css('color', 'green');
			} else {
				$("#tel_check").text('불가능');
				$('#tel_check').css('color', 'red');
			}
		});
		$("#email").keyup(function() {
			if (emailJ.test($(this).val())) {
				$("#email_check").text('사용가능');
				$('#email_check').css('color', 'green');
			} else {
				$("#email_check").text('불가능');
				$('#email_check').css('color', 'red');
			}
		});

		$("#edit").click(function() {
			if ($("#password1").val() == "") {
				alert("비밀번호를 작성해주세요.");
				return

			}
			if (pwdJ.test($("#password1").val())) {
				//정규 표현식과 일치하면 다음으로 넘김
			} else {
				alert("비밀번호를 확인해주세요.");
				return

			}
			if ($("#password1").val() == $("#password2").val()) {
				//비밀번호 비교하고 일치하면 넘김
			} else {
				alert("비밀번호가 다릅니다.");
				return

			}
			if ($("#name").val() == "") {
				alert("이름을 작성해주세요.");
				return

			}
			if (nameJ.test($("#name").val())) {
				//정규 표현식과 일치하면 다음으로 넘김
			} else {
				alert("이름을 확인해주세요.");
				return

			}
			if ($("#tel").val() == "") {
				alert("전화번호를 작성해주세요.");
				return

			}
			if (telJ.test($("#tel").val())) {
				//정규 표현식과 일치하면 다음으로 넘김
			} else {
				alert("전화번호를 확인해주세요.");
				return

			}
			if ($("#email").val() == "") {
				alert("이메일을 작성해주세요.");
				return

			}
			if (emailJ.test($("#email").val())) {
				$("form").submit();
			} else {
				alert("이메일을 확인해주세요.");
				return

			}
		});
	});
</script>
<script>
	$(document).ready(function() {
		$('#showPassword').on('click', function() {
			let passwordField = $('#password1');
			let passwordFieldType = passwordField.attr('type');
			if (passwordFieldType == 'password') {
				passwordField.attr('type', 'text');
				$(this).val('숨기기');
			} else {
				passwordField.attr('type', 'password');
				$(this).val('보기');
			}
		});
	});
</script>
<script>
	$(document).ready(function() {
		$('#showPassword1').on('click', function() {
			let passwordField = $('#password2');
			let passwordFieldType = passwordField.attr('type');
			if (passwordFieldType == 'password') {
				passwordField.attr('type', 'text');
				$(this).val('숨기기');
			} else {
				passwordField.attr('type', 'password');
				$(this).val('보기');
			}
		});
	});
</script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script>
	$(function() {
		$("#birth").datepicker({});
	});
</script>
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

.table td {
	width: 30%
}
</style>
<style>
#edit {
	background-color: red;
	color: white;
}

#reset {
	background-color: blue;
	color: white;
}
</style>
</head>
<body>
	<header>
	<script type="text/javascript" src="/js/loginSessionExist.js"></script>
</header>
	<div class="container-fluid vertical-center justify-content-center">
		<form method="POST"
			action="${pageContext.request.contextPath }/member/edit">
			<table class="table table-bordered">
				<thead class="table-dark">
					<tr>
						<th colspan="2">회원정보수정</th>
					</tr>
				</thead>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" value="${m.id }" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="text" name="password" id="password1"
						placeholder="비밀번호"> <input type="button" value="show"
						id="showPassword"> <span class="check_font"
						id="pwd1_check"></span>
						<div>*4~16자의 영문 소문자, 숫자만 사용가능</div></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" id="password2"
						placeholder="비밀번호 확인"> <input type="button" value="show"
						id="showPassword1"> <span class="check_font"
						id="pwd2_check"></span></td>
				</tr>
				<tr>
					<td>이름</td>
					<td colspan="2"><input type="text" name="name" id="name"
						value="${m.name }"> <span class="check_font"
						id="name_check"></span>
						<div>*2~6자의 한글만 사용가능</div></td>
				</tr>
				<tr>
					<td>생일</td>
					<td><input type="date" name="birth" value="${m.birth }"></td>
				</tr>
				<tr>
					<td>성별</td>
					<c:if test="${ m.gender == 'm' }">
						<td colspan="2">
						<input type="radio" name="gender" id="gender" value="m" checked="checked">남자 
						<input type="radio" name="gender" id="gender" value="f">여자</td>
					</c:if>
					<c:if test="${ m.gender == 'f' }">
						<td colspan="2">
						<input type="radio" name="gender" id="gender" value="m">남자
						 <input type="radio" name="gender" id="gender" value="f" checked="checked">여자</td>
					</c:if>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" id="sample4_postcode" name="postalCode"
						placeholder="우편번호" value="${m.postalCode }"> <input
						type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample4_roadAddress" name="roadAddress"
						placeholder="도로명주소" value="${m.roadAddress }"> <input
						type="text" id="sample4_jibunAddress" name="address"
						placeholder="지번주소" value="${m.address }"> <span id="guide"
						style="color: #999"></span> <script
							src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
						<script>
							function sample4_execDaumPostcode() {
								new daum.Postcode(
										{
											oncomplete : function(data) {
												let fullRoadAddr = data.roadAddress;
												let extraRoadAddr = '';
												if (data.bname !== ''
														&& /[동|로|가]$/g
																.test(data.bname)) {
													extraRoadAddr += data.bname;
												}
												if (data.buildingName !== ''
														&& data.apartment === 'Y') {
													extraRoadAddr += (extraRoadAddr !== '' ? ', '
															+ data.buildingName
															: data.buildingName);
												}
												if (extraRoadAddr !== '') {
													extraRoadAddr = ' ('
															+ extraRoadAddr
															+ ')';
												}
												if (fullRoadAddr !== '') {
													fullRoadAddr += extraRoadAddr;
												}
												document
														.getElementById('sample4_postcode').value = data.zonecode;
												document
														.getElementById('sample4_roadAddress').value = fullRoadAddr;
												document
														.getElementById('sample4_jibunAddress').value = data.jibunAddress;
												if (data.autoRoadAddress) {
													let expRoadAddr = data.autoRoadAddress
															+ extraRoadAddr;
													document
															.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
															+ expRoadAddr + ')';
												} else if (data.autoJibunAddress) {
													var expJibunAddr = data.autoJibunAddress;
													document
															.getElementById('guide').innerHTML = '(예상 지번 주소 : '
															+ expJibunAddr
															+ ')';
												} else {
													document
															.getElementById('guide').innerHTML = '';
												}
											}
										}).open();
							}
						</script></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="tel" id="tel" value="${m.tel }">
						<span class="check_font" id="tel_check"></span></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" id="email"
						value="${m.email }"> <span class="check_font"
						id="email_check"></span></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="edit" value="수정"
						style="float: center;"> <input type="reset" value="재입력"
						id="reset"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>