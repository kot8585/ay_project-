<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath }/member/edit">
<table border="1">
<tr>
<td>ID</td>
<td><input type="text" name="id" value="${m.id }" readonly></td>
</tr>
<tr>
<td>PWD</td>
<td><input type="text" name="password" value="${m.password }"></td>
</tr>
<tr>
<td>NAME</td>
<td><input type="text" name="name" value="${m.name }"></td>
</tr>
<tr>
<td>BIRTH</td>
<td><input type="date" name="birth" value="${m.birth }"></td>
</tr>
<tr>
<td>GENDER</td>
<td colspan="2">
<input type="radio" name="gender" value="m">남자
<input type="radio" name="gender" value="f">여자</td>
</tr>
<tr>
<td>Address</td>
<td>
<input type="text" id="sample4_postcode" name="postalCode" placeholder="우편번호" value="${m.postalCode }">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" value="${m.roadAddress }"> 
<input type="text" id="sample4_jibunAddress" name="address" placeholder="지번주소" value="${m.address }"> 
<span id="guide" style="color: #999"></span> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>
function sample4_execDaumPostcode() {
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
	</script>
	</td>
	</tr>
<tr>
<td>TEL</td>
<td><input type="text" name="tel" value="${m.tel }"></td>
</tr>
<tr>
<td>EMAIL</td>
<td><input type="text" name="email" value="${m.email }"></td>
</tr>
<tr>
<td colspan=""><input type="submit" value="수정">
<input type="reset" type="재입력"></td>
</tr>
</table>
</form>
</body>
</html>