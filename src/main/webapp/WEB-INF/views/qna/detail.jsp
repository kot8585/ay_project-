<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Red house</title>	
<link rel="shortcut icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">	
<link rel="icon" href="/favicon.ico" sizes="16x16" type="image/x-icon">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script type="text/javascript" src="/js/reply.js"></script>

<script>


	$(document).ready(function(){

		
		var qnum = ${q.num};
		var writer = "${sessionScope.id}"
		var exampleModal = $("#exampleModal");
		var repContent = exampleModal.find("textarea[name='content']");
		var repWriter = exampleModal.find("input[name='writer']");
		
		var modalEditBtn = $("#modalEditBtn"); //exampleModal. 으로도 찾아보기
		var modalDelBtn = $("#modalDelBtn");
		var modalWriteBtn = $("#modalWriteBtn");

		// 1.option의 value값이랑 db에서 가져온 값이랑 일치하는지 확인 	
		//	2. 일치한다면 selected 값 넣어주기	
		var opt_vals = [];	
		$('select option').each(function(){	
			opt_vals.push($(this).val());	
			console.log($(this).val());
		});
		
		$('#q_cate').find("option[value='${q.q_cate}']").attr('selected', 'selected');
		var writer = "${sessionScope.id}"	
			
			showList(${q.num});
		
		//댓글 목록 보여주는 함수
		function showList(qnum){replyService.getList(qnum, function(list){
				var htmls = "";
				
				//댓글이 없을 경우
				if(list == null || list.length == 0){
					$("#replyList").html("작성된 답변이 없습니다.");
					return;
				}
				
				for(var i=0, len = list.length||0; i<len; i++){
					htmls+=  '<li class="list-group-item" data-num="'+list[i].num+'">'
					htmls+=    '<div class="d-flex w-100 justify-content-between">'
					htmls+=    '<strong class="mb-1">'+list[i].writer+'</strong>'
					htmls+=   '<small>'+list[i].r_date+'</small>'
					htmls+=   '</div>'
					htmls+=	   '<p class="repContent">'+list[i].content+'</p>'
					htmls+=  '</li>'
				}
				$("#replyList").html(htmls);
			});
		} //end showList
		
		//모달창 보여주기
		$("#addReplyBtn").on("click", function(e){
			exampleModal.find("input").val("");
			exampleModal.find("textarea").val("");
			exampleModal.find("input[name='writer']").val(writer);
			exampleModal.find("button[id !='modalCloseBtn']").hide();
			modalWriteBtn.show();

			$('#exampleModal').modal('show');
		}); //end addReplyBtn

		//모달창에서 등록버튼 클릭 - 답변 작성하기
		modalWriteBtn.on("click", function(e){
			var reply = {
				content: repContent.val(),
				qna_num: qnum,
				writer: repWriter.val()
			}
		replyService.write(
				reply,
				function(result){
					alert("답변 등록 완료");
					repContent.val("");
					exampleModal.modal("hide");
					
					//답변 등록 완료하면 답변 리스트 갱신
					showList(qnum);
				});
		});
		
		
		//해당 댓글 클릭하면 댓글 수정과 삭제할수 있는 모달창 띄우기
		//이벤트 위임을 해서 ul태그를 선택하지만 $(this) = li 태그이다.
		$("#replyList").on("click", "li", function(e){
			var num = $(this).data("num");
			console.log("click num : " + num);
			exampleModal.find("button").show(); 
			modalWriteBtn.hide();
			
			//replyService.get(서버에 넘겨줄 번호, 성공했을시 호출할 함수)
			replyService.get(num, function(reply){
				repWriter.val(reply.writer);
				repContent.val(reply.content);
				exampleModal.data("num", reply.num); //수정과 삭제할때 필요
				
				exampleModal.modal("show");			
			});
		});
			
		//수정버튼 누를떄
		modalEditBtn.on("click", function(e){
			console.log("edit click");
			//컨트롤러에 전달할 데이터 세팅
			var reply = {
					"num": exampleModal.data("num"),
					"content": repContent.val()
			};
			
			//컨트롤러에게 데이터를 보내고 결과 상태를 가져온다.
			replyService.update(reply,
					function(result){
					alert("UPDATED");
					exampleModal.modal("hide");
					showList(qnum);
				}, function(error){ //error써도 되나 학인학.
				alert("UPDATE ERR");
			});
		});
		
		//답변 삭제버튼 눌렀을시 confirm하고 
		//remove호출
		modalDelBtn.on("click", function(e){
			console.log("modalDelBtn clicked............")
			var num = exampleModal.data("num");
			var r = confirm(num +"번의 답변을 삭제하시겠습니까?");
			
			if(!r){
				return;
			}
			
			if (r) {
				//reply.js의 remove함수 호출
				//replyService.remove(서버에 넘겨줄 번호, 성공했을시 호출할 함수, 실패했을시 호출할 함수)
				replyService.remove(num, function(result){
					if(result === "success"){
						alert(num +"번의 답변이 삭제되었습니다.");
					}
				}, function(error){
					alert("DELETE ERROR");
				});
				
				//confirm이 true일때만
				repWriter.val("");
				repContent.val("");
				exampleModal.modal("hide");
				showList(qnum);
			} //end if(r)
		});
		
		

		
		//이미지에 마우스 올릴때
	      $(".img").mouseover(function() {
	          $("#bigImg").attr('src', this.src);
	       });
		
		//게시판 삭제
		$("#del").click(function(){
			var result = confirm("글을 삭제하시겠습니까?");
			if(result){
				location.href = "${pageContext.request.contextPath}/qna/del?num=${q.num}";
			}
		});
		


	}); //end document.ready
</script>

</head>
<body>
<!-- navbar -->	
  <nav class="navbar navbar-expand-lg navbar-light bg-light ms-2">	
    <a class="navbar-brand" href="${ pageContext.request.contextPath }/member/main">	
    	<!-- Controller로 로고 이미지를 받아오기. -->	
    	<img src="${ pageContext.request.contextPath }/logo" alt="logo" width="249" height="60" class="d-inline-block align-top">	
    </a>	
    <button class="navbar-toggler" 	
		    type="button" 	
		    data-bs-toggle="collapse" 	
		    data-bs-target="#navbarSupportedContent" 	
		    aria-controls="navbarSupportedContent" 	
		    aria-expanded="false" 	
		    aria-label="Toggle navigation">	
      <span class="navbar-toggler-icon"></span>	
    </button>	
    	
    <div class="collapse navbar-collapse" id="navbarSupportedContent">	
      <ul class="navbar-nav ms-auto">	
        <c:if test="${ empty sessionScope.id }">	
	        <li class="nav-item active">	
	          	<a class="nav-link" href="${ pageContext.request.contextPath }/member/loginForm">로그인</a>	
	        </li>	
        </c:if>	
        <c:if test="${not empty sessionScope.id }">	
        	<li class="nav-item">	
          		<a class="nav-link" href="${ pageContext.request.contextPath }/member/logout">로그아웃</a>	
        	</li>	
        </c:if>	
        <li class="nav-item">	
          <a class="nav-link" href="${ pageContext.request.contextPath }/mypage/mypage">마이페이지</a>	
        </li>	
        <li class="nav-item">	
          <a class="nav-link" href="${ pageContext.request.contextPath }/board/faq/list">고객센터</a>	
        </li>	
        <li>	
          <button type="button" class="btn btn-outline-primary me-2" onclick="goPage()">회원가입</button>	
        </li>	
      </ul>	
    </div>	
</nav>	
  <hr> <!-- /nabvar -->

	<!-- modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label>작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="admin" readonly>
          </div>
          <div class="form-group">
            <label>답변내용</label>
            <textarea class="form-control" id="content" name="content"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
      <button type="button" id="modalEditBtn" class="btn btn-danger">수정</button>
      <button type="button" id="modalDelBtn" class="btn btn-danger">삭제</button>
        <button type="button" id="modalWriteBtn" class="btn btn-primary">등록</button>
        <button type="button" id="modalCloseBtn" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- /.modal -->


	<c:if test="${sessionScope.id ne q.writer }">
		<c:set var="data" value="readonly" />
	</c:if>
	<form action="${pageContext.request.contextPath }/qna/edit" method="post">
		<table border="1" cellspacing="0">
		
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" value="${q.writer}" readonly></td>
			</tr>
			<tr>	
				<td>문의 유형</td>	
				<td>		
				<select name="q_cate" id="q_cate">	
					<option value="order" >주문 상품 문의</option>	
					<option value="p_delivery">배송 관련 문의</option>	
					<option value="system">시스템 개선 의견</option>	
				</select>	
				</td>	
			</tr>
			
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${q.title}" ${data}></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea type="text" name="content" ${data}>${q.content}</textarea></td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><input type="text" name="updatedate" value="${q.updatedate}" readonly></td>
			
			</tr>
		<tr>
         <th>이미지</th>
         <td><c:if test="${empty file0 }">
               등록된 이미지가 없습니다.
               </c:if> 
               <c:if test="${not empty file0 }">
               <table>
                  <tr>
                     <td colspan="3">
                     <img id="bigImg" src="${pageContext.request.contextPath }/qna/img?fname=${file0 }&num=${q.num }" 
                     style="width:150px;height:150px"></td>
                  </tr>
                  <tr>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file0 }&num=${q.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file1 }&num=${q.num }" class="img" width="50" height="50"></td>
                     <td><img src="${pageContext.request.contextPath }/qna/img?fname=${file2 }&num=${q.num }" class="img" width="50" height="50"></td>
               </table>
            </c:if></td>
      </tr>
		</table>
			<input type="hidden" name="num" value="${q.num}">
			<input type="hidden" name="pwd" value="${q.pwd}">
	
			
			<c:if test="${sessionScope.id eq q.writer}">
			<input type="submit" value="수정하기" id="update">
				<input type="button" value="삭제하기" id="del">
				<a href="">목록으로</a>
			</c:if>
	
	<hr>
     <div class="float-start"><h6>Reply List</h6></div>
    <div class="float-end"><button type="button" id="addReplyBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">답변하기</button></div><br><br>
    
	<!-- 댓글 작성되면 이 영역에 넣는다 -->
	<ul class="list-group" id="replyList">
  	</ul>
</body>
</html>