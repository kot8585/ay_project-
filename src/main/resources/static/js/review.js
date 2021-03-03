function countLetter(type){
		console.log(type);
		if(type === "title"){
			var length = 50;
		}else if(type === "content"){
			var length = 500;
		}
		console.log(length);
		document.getElementById(type+"Span1").innerHTML = document.getElementById(type).value.length;
		if(document.getElementById(type).value.length > length){
			document.getElementById(type+"Div").style.color="red";
			document.getElementById(type+"Span2").innerHTML = "글자수 초과!!";
		}else{
			document.getElementById(type+"Div").style.color="black";
			document.getElementById(type+"Span2").innerHTML = "";
			
		}	
		
	}
	
	function sub(){
		var titleLength = 50;
		var contentLength = 500;
		if(document.getElementById("title").value.length > titleLength || document.getElementById("content").value.length > contentLength){
			alert("글자수가 초과되었습니다.");
		}else if(document.getElementById("title").value.length <= titleLength && document.getElementById("content").value.length <= contentLength){
			f.submit();
		}
	}
	

/**
 * reviewDetail
 */

/**
 * reviewForm
 */

