<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var sel1=0; //선택한 것 저장할 변수 대분류
	var sel2=0; //선택한 것 저장할 변수 소분류
	$(document).ready(
			function() {
				$.post("/event/getEvent", {}).done(
						function(data) {
							var c = eval("(" + data + ")");
							$("#s1").append("<option value='0'>이벤트 없음</option>");
							for (i = 0; i < c.length; i++) {
								$("#s1").append(
										"<option value='"+c[i].num+"'>"
												+ c[i].name + "</option>");
							}
			    });
				
				$.post("/category/getCategory", {
					type : 1,// 대분류 번호 
					c_id : 0 // 
				}).done(
						function(data) {
							var c = eval("(" + data + ")");
							$("#s2").append("<option value=''>---</option>"); 
							for (i = 0; i < c.length; i++) {
								$("#s2").append(
										"<option value='"+c[i].id+"'>"
												+ c[i].name + "</option>"); //대분류 값을 받아와서 추가하고 
							}
						});
				
				$("#s1").click(function() {
					var s = 0;
					s = this.options[this.options.selectedIndex].value;
					$("#event_num").val(s);
				});
				
				$("#s2").click(function() {
					var cat1 = 0;
					cat1 = this.options[this.options.selectedIndex].value
					sel1 = cat1;
					$.post("/category/getCategory", {
						type : 2,
						c_id : cat1 // 전단계 대분류 
					}).done(function(data) {
						var c = eval("(" + data + ")");
						$("#s3").empty();//초기화를 하려면 비우고 
						$("#s3").append("<option value=''>---</option>");
						for (i = 0; i < c.length; i++) {
							$("#s3").append("<option value='"+c[i].id+"'>"//추가하고 
									+ c[i].name + "</option>");
						}
					});
					
					$("#category1").val(cat1);
				});

				$("#s3").click(function() {
					var cat2 = 0;
					cat2 = this.options[this.options.selectedIndex].value;
					$("#category2").val(cat2);
				});
			});
</script>
</head>
<body>
<h1>Product Register</h1>
	<form action="${pageContext.request.contextPath }/admin/write" method="post" accept=".gif, .jpg, .png" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>상품명</th><td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>제조사</th><td><input type="text" name="maker"></td>
			</tr>
			<tr>
				<th>가격</th><td><input type="text" name="price" ></td>
			</tr>
			<tr>
				<th>원산지</th><td><input type="text" name="origin" ></td>
			</tr>
			<tr>
				<th>원재료</th><td><input type="text" name="material" ></td>
			</tr>
			<tr>
				<th>재고</th><td><input type="text" name="quantity" ></td>
			</tr>
			<tr>
				<th>파일첨부1</th><td><input type="file" name="file1"></td>
			</tr>
			<tr>
				<th>파일첨부2</th><td><input type="file" name="file2"></td>
			</tr>
			<tr>
				<th>파일첨부3</th><td><input type="file" name="file3"></td>
			</tr>
			<tr>
				<th>이벤트</th><td><select id="s1" name="s1"></select><input type="text" id="event_num" name="event_num" value="0"></td>
			</tr>
			<tr>
				<th>카테고리1</th><td><select id="s2" name="s2"></select><input type="text" id="category1" name="category1" value="0"></td>
			</tr>
			<tr>
				<th>카테고리2</th><td><select id="s3" name="s3"></select><input type="text" id="category2" name="category2" value="0"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="등록"><input type="reset" value="취소"></td>
			</tr>
		</table>
		<input type="hidden" name="imgPath" value="C:\\shopimg\\"> 
		
	</form>
</body>
</html>