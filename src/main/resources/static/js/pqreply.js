/**
 * javascript 모듈 패턴 공부하기
 */
console.log("pqreply Module........");
var pqreplyService = (function() {

	function write(pqreply, callback, error) {
		console.log("write pqreply....");

		$.ajax({
			type: 'post',
			url: "/pqrep/write",
			data: JSON.stringify(pqreply),
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
	
	function getplist(pqNum, callback, error){
		console.log("getplist..........");
		console.log("pqNum: "+ pqNum);
		$.getJSON('/pqrep/plist/'+pqNum,
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
		console.log("remove pqreply...");
		
		$.ajax({
			url: '/pqrep/del/'+num,
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
	
	function update(pqreply, callback, error){
		console.log("pqreply update........");
		console.log("update num: "+pqreply.num);
		$.ajax({
			type: 'put',
			url: '/pqrep/edit/'+pqreply.num,
			data: JSON.stringify(pqreply),
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
		console.log("pqreply get.....");
		$.getJSON('/pqrep/get/'+num,
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
		write: write, //pqreplyService.add로 add함수 호출 가능
		getplist: getplist,
		remove: remove,
		update: update,
		get: get
	};
})();