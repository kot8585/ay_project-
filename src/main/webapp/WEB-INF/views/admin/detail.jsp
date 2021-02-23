<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				 $(".img").mouseover(function() {
			         $("#bigImg").attr('src', this.src);
			      });
			
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
				
				$.post("/category/getsub", {
					type : 1,// 대분류 번호 
					p_id : 0 // 
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
					$.post("/category/getsub", {
						type : 2,
						p_id : cat1 // 전단계 대분류 
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
	$(document).ready(function() {
		
		$("#del").click(function() {
			$("#f1").attr('action', '/admin/delProduct');
			$("#f1").submit();
		});
	});
</script>
</head>
<body>
<h5>세션 id : ${ sessionScope.id }</h5>
<h3>상품 상세 정보</h3>
<form id="f1" action="${ pageContext.request.contextPath }/admin/edit" method="post">
<table border="1" cellspacing="0">
<tr>
	<th>번호</th>
	<td><input type="text" name="num" value="${p.num }" readonly></td>
</tr>
<tr>
	<th>상품명</th>
	<td><input type="text" name="name" value="${p.name }"></td>
</tr>
<tr>
     <th>이미지</th>
     <td>
	     <c:if test="${empty file0 }">
	         	등록된 이미지가 없습니다.
	     </c:if> 
         <c:if test="${not empty file0 }">
               <table>
                  <tr>
                     <td colspan="3">
                     <img id="bigImg" src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }" 
                     style="width:150px;height:150px"></td>
                  </tr>
                  <tr>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file0 }&num=${p.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file1 }&num=${p.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/img?fname=${file2 }&num=${p.num }" class="img" width="50" height="50"></td>
               </table>
         </c:if>
     </td>
</tr>
<tr>
	<th>메이커</th>
	<td><input type="text" name="maker" value="${p.maker }"></td>
</tr>

<tr>
	<th>가격</th>
	<td><input type="text" name="price" value="${p.price }"></td>
</tr>

<tr>
	<th>원산지</th>
	<td><input type="text" name="origin" value="${p.origin }"></td>
</tr>

<tr>
	<th>재료</th>
	<td><input type="text" name="material" value="${p.material }"></td>
</tr>

<tr>
	<th>재고</th>
	<td><input type="text" name="quantity" value="${p.quantity }"></td>
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
	<td colspan="2">
		<input type="hidden" name="imgPath" value="C:\\shopimg\\"> 
		<input type="hidden" name="event_num" value="0"> 
		<input type="submit" value="수정">
		<input type="button" value="삭제" id="del">
	</td>
</tr>
</table>
</form>
</body>
</html>