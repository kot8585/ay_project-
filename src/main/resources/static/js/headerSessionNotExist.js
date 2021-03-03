/**
* Nav 자동 생성
*/

var htmls = "";
htmls += '<nav class="navbar navbar-expand-lg navbar-light bg-light ms-2">';
htmls += '<a class="navbar-brand" href="/member/main">';
htmls += '<img src="/logo" alt="logo" width="249" height="60" class="d-inline-block align-top"></a>';
htmls += '<button class="navbar-toggler" ';
htmls += 'type="button" ';
htmls += 'data-bs-toggle="collapse" ';
htmls += 'data-bs-target="#navbarSupportedContent" ';
htmls += 'aria-controls="navbarSupportedContent" ';
htmls += 'aria-expanded="false" ';
htmls += 'aria-label="Toggle navigation">';
htmls += '<span class="navbar-toggler-icon"></span>';
htmls += '</button>';
htmls += '<div class="collapse navbar-collapse" id="navbarSupportedContent">';
htmls += '<ul class="navbar-nav ms-auto">';
htmls += '<li class="nav-item active">';
htmls += '<a class="nav-link" href="/member/loginForm">로그인</a>';
htmls += '</li>';
htmls += '<li class="nav-item">';
htmls += '<a class="nav-link" href="/mypage/mypage">마이페이지</a>';
htmls += '</li>';
htmls += '<li class="nav-item">';
htmls += '<a class="nav-link" href="/board/faq/list">고객센터</a>';
htmls += '</li>';
htmls += '<li>';
htmls += '<button type="button" class="btn btn-outline-primary me-2" onclick="goPage()">회원가입</button>';
htmls += '</li>';
htmls += '</ul>';
htmls += '</div>';
htmls += '</nav>';
htmls += "<hr>";
document.write(htmls);

