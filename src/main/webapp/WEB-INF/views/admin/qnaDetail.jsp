<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

 <!-- Required meta tags -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

 <!-- Option 1: Bootstrap Bundle with Popper -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<script type="text/javascript" src="/js/reply.js"></script>
<script type="text/javascript" src="/js/header.js"></script>
<script>


	$(document).ready(function(){
		let qnum = ${q.num};
		let writer = "${sessionScope.id}"
		const exampleModal = $("#exampleModal");
		const repContent = exampleModal.find("textarea[name='content']");
		const repWriter = exampleModal.find("input[name='writer']");
		
		const modalEditBtn = $("#modalEditBtn"); //exampleModal. 으로도 찾아보기
		const modalDelBtn = $("#modalDelBtn");
		const modalWriteBtn = $("#modalWriteBtn");

		showList(qnum);
		
		//댓글 목록 보여주는 함수
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
		
		//모달창 보여주기
		$("#addReplyBtn").on("click", function(e){
			exampleModal.find("input").val("");
			repContent.val("");
			repWriter.val(writer);
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
			//confirm이 true일때만
			repWriter.val("");
			repContent.val("");
			exampleModal.modal("hide");
			showList(qnum);
		});
		
		
		
		//이미지에 마우스 올릴때
	      $(".img").mouseover(function() {
	          $("#bigImg").attr('src', this.src);
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

<style type ="text/css">


input:focus {outline:none;}
input{
border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.inputStyle{
border:1px;
}

	h2{
		text-align:center;
	}

	textarea {
		height: 200px;
	}
	h2{
		text-align:center;
	}
	div#side_left{
	width:200px;
	height:400px;
	float:left;
	margin:5px;
	}
	
</style>

</head>
<body>
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
				<td><input type="text" name="writer" value="${q.writer}"></td>
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
				<td><input type="text" name="updatedate" value="${q.updatedate}"></td>
			
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
	
			
			<!-- 관리자는 삭제버튼만 뜨게 하기 -->
			<c:if test="${sessionScope.id eq 'admin'}">
				<input type="button" value="삭제하기" id="del">
			</c:if>
	
	<hr>
     <div class="float-start"><h6>Reply List</h6></div>
    <div class="float-end"><button type="button" id="addReplyBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">답변하기</button></div><br><br>
    
	<!-- 댓글 작성되면 이 영역에 넣는다 -->
	<ul class="list-group" id="replyList">
  	</ul>
</body>
</html>