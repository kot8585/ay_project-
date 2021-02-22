<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>	
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function change(type, num){
		console.log("선택한 기능 : " + type);
		var pwdCheck = prompt("비밀번호를 입력해주세요");
		console.log("입력된 값 : " + pwdCheck);
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState === 4 && xhttp.status === 200){
				console.log("입력에 따른 반환 값 : " + xhttp.responseText);
				if(xhttp.responseText === "비밀번호 확인 완료" && type==="del"){
					alert("비밀번호 확인 완료");	
					location.href="${pageContext.request.contextPath}/review/delReview?num="+num;
				}else if(xhttp.responseText === "비밀번호 확인 완료" && type==="edit"){
					alert("비밀번호 확인 완료");
					f.submit();
					
				}else{
					alert("비밀번호가 다릅니다.");
					location.href="${pageContext.request.contextPath}/member/main";
				}
				
			}			
		}
		xhttp.open("POST", "/review/pwdCheck?password=" + pwdCheck, true);
		xhttp.send();
	}
</script>
</head>
<body>
<form name="f" method="POST" action="${pageContext.request.contextPath }/review/editReview">
   <table border="1" cellspacing="0">
      <thead>
         <tr>
            <th>번호</th>
            <td><input type="text" name="num" value="${r.num}" readonly></td>
         </tr>
         <tr>
            <th>상품번호</th>
            <td><input type="text" name="pnum" value="${r.pnum}" readonly></td>
         </tr>
         <tr>
         	<th>별점</th>
			<td>${r.stars }</td>	
         </tr> 
         <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="${r.title }"></td>
         </tr>
           <tr>
            <th>작성자</th>
            <td>${r.writer}</td>
         </tr>
           <tr>
            <th>내용</th>
            <td><input type="text" name="content" value="${r.content}"></td>
         </tr>
           <tr>
            <th>작성날짜</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${r.pdate}" /></td>
         </tr>
         <tr>
         	<td colspan="2">
         		<input type="button" value="수정" id="edit" onclick="change('edit', ${r.num})">
         		<input type="button" value="삭제" id="delete" onclick="change('del', ${r.num})">
         	</td>
         </tr>
          
      </thead>
     
    
     
   </table>
   </form>
</body>
</html>