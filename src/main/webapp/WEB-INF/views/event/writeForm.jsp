<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 이벤트 작성 페이지</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
// https://dongyeopblog.wordpress.com/2017/09/02/javascript-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EB%AF%B8%EB%A6%AC%EB%B3%B4%EC%97%AC%EC%A3%BC%EA%B8%B0-preview-image-upload/ 
function readFile(input) {
	if (input.files && input.files[0]) {
		// FileReader 객체를 생성  
		var reader = new FileReader();
		
		// 읽기 동작이 성공적으로 완료되었을 경우, imgHere란 id를 가진 태그의 src에 result를 반환한다.
		reader.onload = function (e) {
		   $('#imgHere').attr('src', e.target.result);
		}
		// 컨텐츠를 특정 File에서 읽어 오는 역할  
	    reader.readAsDataURL(input.files[0]);
	}
}
</script>
<script type="text/javascript">
$(document).ready(function() {
	// 5% 간격으로 option을 생성하기 위해 for문을 돌림.
	for (var i = 0; i <= 100; i+=5) {
		$("#sel").append("<option value='"+(i/100)+"'>"+ i + "%" + "</option>");
	}
	
	// 카테고리 선택시 해당 값을 저장함.
	$("#sel").click(function() {
		this.form.sale.value = this.options[this.options.selectedIndex].value;
	});
	
	// 파일이 변경되었을시 file 아래에 새로운 <th><td>를 생성하고 거기에 이미지를 띄움. 
	$("#file").change(function() {
		console.log("파일 변경됨...");
		$("#img").html("<th>이미지 미리보기</th><td><img id='imgHere' src='#'></td>");
		readFile(this);
	});
	
});
</script>
</head>
<body>
<p>Write</p>
	<form action="${pageContext.request.contextPath }/event/write" method="post"  enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>이벤트명</th><td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>이미지(1000x500 건장)</th><td><input type="file" name="file" id="file"></td>
			</tr>
			<tr id="img"></tr>
			<tr>
				<th>할인가</th>
				<td>
					<select id="sel" name="sel"></select>
					<input type="hidden" name="sale" value="0">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="등록"><input type="reset" value="취소"></td>
			</tr>
		</table>
		<input type="hidden" name="imgPath" value="C:\\shopimg\\e"> 
	</form>
</body>
</html>