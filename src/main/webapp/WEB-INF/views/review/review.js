/**
 * reviewlist
 */

	function sort(){
		var what = document.getElementById("list");
		var xhttp = new XMLHttpRequest();
		console.log("선택된 기준에 따라 정렬");
		console.log("선택된 기준 : " + what.value);
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState === 4 && xhttp.status === 200){
				console.log("입력에 따른 반환 값 : " + xhttp.responseText);
				print(xhttp);
				
			}
		}
		
		xhttp.open("POST", "/review/list?p_num=${p.num}&what=" + what.value, true);
		xhttp.send();
	}
	
	function print(xhttp){
		console.log(xhttp.responseText);
		document.querySelector("#ntable").innerHTML = xhttp.responseText;
	}

/**
 * reviewDetail
 */

/**
 * reviewForm
 */

