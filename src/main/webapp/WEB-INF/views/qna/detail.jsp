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
<style type="text/css">

}

input:focus {outline:none;}
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}


</style>


<script>

//댓글 목록 보여주는 함수
//qna의 게시판 번호를 받아 해당하는 댓글만 출력한다.
function showList(qnum){replyService.getList(qnum, function(list){
	let htmls = "";
	
	//댓글이 없을 경우
	if(list == null || list.length == 0){
		$("#replyList").html("작성된 답변이 없습니다.");
		return;
	}
	
	for(let i=0, len = list.length||0; i<len; i++){
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

	$(document).ready(function(){

		
		let qnum = ${q.num};
		let writer = "${sessionScope.id}"
		const exampleModal = $("#exampleModal");
		const repContent = exampleModal.find("textarea[name='content']");
		const repWriter = exampleModal.find("input[name='writer']");
		
		const modalEditBtn = $("#modalEditBtn"); //exampleModal. 으로도 찾아보기

		const modalDelBtn = $("#modalDelBtn");
		const modalWriteBtn = $("#modalWriteBtn");

		//문의 종류 select에 넣기
		let opt_vals = [];	
		$('select option').each(function(){	
			opt_vals.push($(this).val());	
			console.log($(this).val());
		});
		
		// 1.option의 value값이랑 db에서 가져온 값이랑 일치하는지 확인 	
		//2. 일치한다면 selected 값 넣어주기	
		$('#q_cate').find("option[value='${q.q_cate}']").attr('selected', 'selected');
			writer = "${sessionScope.id}"	
			
			showList(${q.num});
		

		
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
			let reply = {
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
			let num = $(this).data("num");
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
				let reply = {
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
			let num = exampleModal.data("num");
			let r = confirm(num +"번의 답변을 삭제하시겠습니까?");
			
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
				
			} //end if(r)
				repWriter.val("");
				repContent.val("");
				exampleModal.modal("hide");
				showList(qnum);
		});
		
		
		//게시판 삭제
		$("#del").click(function(){
			let result = confirm("글을 삭제하시겠습니까?");
			if(result){
				location.href = "${pageContext.request.contextPath}/qna/del?num=${q.num}";
			}
		});
		


	}); //end document.ready
</script>

</head>
<body>
<!-- header부분 -->
<header>
<c:if test="${ empty id }">
	<script type="text/javascript" src="/js/headerSessionNotExist.js"></script>
</c:if>
<c:if test="${ not empty id }">
	<script type="text/javascript" src="/js/headerSessionExist.js"></script>
</c:if>
</header>

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
		<div class="container">
	<form action="${pageContext.request.contextPath }/qna/edit" method="post">
	<div class="card card-outline-secondary my-4">
		
		
		<div class="card-header">
			<label class="form-label">작성자</label>
			<input class="form-control" type="text" name="writer" value="${q.writer}">
			</div>

			
			<div class="card-header">
			<label class="form-label">문의유형</label>
			<select  class="form-control" name="q_cate" id="q_cate">	
					<option value="order" >주문 상품 문의</option>	
					<option value="p_delivery">배송 관련 문의</option>	
					<option value="system">시스템 개선 의견</option>	
				</select>		
			</div>
			
			<div class="card-header">
			<label class="form-label">제목</label>
			<input class="form-control" type="text" name="title" value="${q.title}">		
			</div>

			<div class="card-header">
			<label class="form-label">내용</label>
			<textarea class="form-control" type="text" name="content" ${data}><c:out value="${q.content}" /></textarea>		
			</div>

			
			<div class="card-header">
			<label class="form-label">작성날짜</label>
			<input class="form-control" type="text" name="updatedate" value='<c:out value="${q.updatedate}" />' readonly>
			</div>

			
			<div class="card-header">
			<label class="form-label">이미지</label>		
			
			<c:if test="${empty file0 }">
               등록된 이미지가 없습니다.
               </c:if> 
               <c:if test="${not empty file0 }">
               	
                     <img src="${pageContext.request.contextPath }/qna/img?fname=${file0 }&num=${q.num }" class="img" width="50" height="50">
                     <img src="${pageContext.request.contextPath }/qna/img?fname=${file1 }&num=${q.num }" class="img" width="50" height="50">
                     <img src="${pageContext.request.contextPath }/qna/img?fname=${file2 }&num=${q.num }" class="img" width="50" height="50">
               
            </c:if>
            </div>


			<div align="center" style="none; height: 100px;">
			<input type="hidden" name="num" value="${q.num}">
			<c:if test="${sessionScope.id eq q.writer}">
			
	<input class="btn btn-danger" type="submit" value="수정" id="update">
				<input class="btn btn-danger" type="button" value="삭제" id="del">
				
			</c:if>
			
				<a class="btn btn-danger" href="/mypage/mypage" role="button">목록으로</a>

		</div>
	
	</form>
	</div>
	
	
	
	<hr>
     <div class="float-start"><h6>Reply List</h6></div>
     <c:if test="${sessionScope.id eq 'admin' }">
     <div class="float-end">
    	<button type="button" id="addReplyBtn" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">답변하기</button>
    </div>
    </c:if>
    <br><br>
    
	<!-- 댓글 작성되면 이 영역에 넣는다 -->
	<ul class="list-group" id="replyList">
  	</ul>
</body>
</html>