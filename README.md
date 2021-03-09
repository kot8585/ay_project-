# Spring Boot + JQuery + JSP + Oracle DB 를 이용한 쇼핑몰 웹 페이지 구현
이 웹페이지에서는 쇼핑몰 운영자 및 고객 분들을 위한 기능들을 제공합니다.    
대표적인 기능들로는
- 운영자는 사이트에 상품을 등록할 수 있으며 이를 수정, 삭제, 조회하는 일이 가능하다. 
- 고객은 사이트에서 물품을 장바구니에 담거나 구매, 문의할 수 있고 이후 구매한 상품에 대한 후기를 작성하는 일이 가능하다.
- 고객은 사이트에서 구매내역, 문의사항 등 활동한 기록을 확인할 수 있다.
- 운영자는 사이트에 자주묻는 질문 및 공지사항을 게재할 수 있고, 고객은 1:1문의를 게재할 수 있다. 
- 사이트는 AOP와 logback을 활용하여 구매 등 쇼핑몰 운영에 있어 중요한 데이터를 담은 엑셀화 가능한 로그 파일을 자동으로 생성해준다.
- (구현 예정) 운영자는 이벤트를 등록하고, 상품에 이벤트를 적용시켜 고객이 해당 이벤트의 상품들을 조회하고 할인된 가격에 상품을 이용할 수 있도록 한다.
- (구현 예정) 고객 및 운영자는 사이트의 일부 기능을 모바일 앱(Android 한정)에서도 활용할 수 있다.
 
<br>등 을 들 수 있습니다.


## 해당 프로젝트의 문서
**프로젝트 문서 made by JavaDoc**
<https://eful5678.github.io/ay_project-/>    
  

**소프트웨어 요구사항 명세서**(**SRS**, Software Requirement Specification)
<https://docs.google.com/spreadsheets/d/1Qxl0B_B6U70v58UVW5FOYVIS5LveC5RiDQt_JTG9ivo/edit#gid=0>     
  
  
**소프트웨어 설계 명세**(**SDD**, Software Design Description)
<https://docs.google.com/document/d/1p9yy0XjjMeEDrma2DaXRJbBw7V3_MmQsG6LFGy-Rwz8/edit#heading=h.z6ne0og04bp5>    

## 참여 개발자 프로필 
* 김현진 (팀장, 상품 리뷰 기능 구현 기여) : eful5678@gmail.com 
* 김평기 (팀원, 운영자 관련 기능 구현 기여, 문서 책임자) : aorca603@gmail.com
* 이동준 (팀원, 회원 관련 기능 구현 기여) : ljkljs0805@gmail.com
* 최준영 (팀원, 상품 관련 기능 구현 기여) : ansgywjd321@gmail.com
* 문효정 (팀원, 게시판 기능 구현 기여) : cjyoung012@gmail.com
 
## 제작 기간
2021-01-25 ~ 2021-04-12(예정)

## 웹사이트 제공 로그 파일
order.log
![캡처](https://user-images.githubusercontent.com/38680710/110200015-e3feef00-7e9e-11eb-95f0-7a2d6cb4fcc2.PNG)


order.log - Excel version
 ![캡처](https://user-images.githubusercontent.com/38680710/110199992-bf0a7c00-7e9e-11eb-8648-cb4095d1adbf.PNG)
