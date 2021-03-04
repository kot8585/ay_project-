<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
 
 <style type="text/css">
.table th {
    text-align: center;
}

.table {
    border-radius: 5px;
    width: 30%;
    margin: 0px auto;
    float: none;
}

.vertical-center {
  min-height: 100%;
  min-height: 100vh; 
  display: flex;
  align-items: center;
}

.table-bordered {
	border: 1px;
}
.table th{
width:40%
}


a:hover {
	text-decoration: underline;
	font-style: italic;
	font-size: 16pt;
}
</style>

<title>에러 페이지</title>
</head>
<body>
<header>
 <script type="text/javascript" src="/js/header.js"></script>
</header>
<div class="container-fluid vertical-center d-flex justify-content-center">
	<table class="table table-hover text-centered table-bordered" border="1">
		<!-- <thead class="table-dark"> -->
		<thead>
			<tr>
				<td align="center">
					<h1>Error Page</h1>
					<br>${code}&nbsp;${msg} 에러가 발생했습니다.
					<br><br>관리자 : 김평기 aorca603@gmail.com
					<br><a onclick="javascript:history.go(-1)">이전 화면으로 돌아가기</a>
				</td>
			</tr> 
		</thead>
	</table>
</div>
</body>
</html>