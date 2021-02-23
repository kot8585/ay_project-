/**
 * javascript 모듈 패턴 공부하기
 */
console.log("reply Module........");
var replyService = (function() {

	function write(reply, callback, error) {
		console.log("write reply....");

		$.ajax({
			type: 'post',
			url: "/rep/write",
			data: JSON.stringify(reply),
			contentType: "application/json;",
			success: function(result, status, xhr) {
				//호출이 성공하고, callback값으로 적절한 함수가 존재한다면 해당함수를 호출해서 결과를 반영하는 방식
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function getList(qnaNum, callback, error){
		console.log("getList..........");
		console.log("qnaNum: "+ qnaNum);
		$.getJSON('/rep/list/'+qnaNum,
			function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	function remove(num, callback, error){
		console.log("remove reply...");
		
		$.ajax({
			url: '/rep/del/'+num,
			type: 'delete',
			success: function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function update(reply, callback, error){
		console.log("reply update........");
		console.log("update num: "+reply.num);
		$.ajax({
			type: 'put',
			url: '/rep/edit/'+reply.num,
			data: JSON.stringify(reply),
			contentType: 'application/json;',
			success: function(result){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}


	function get(num, callback, error){
		console.log("reply get.....");
		$.getJSON('/rep/get/'+num,
		function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err){
				if(error){
					error();
				}
		});
	}
	return {
		write: write, //replyService.add로 add함수 호출 가능
		getList: getList,
		remove: remove,
		update: update,
		get: get
	};
})();