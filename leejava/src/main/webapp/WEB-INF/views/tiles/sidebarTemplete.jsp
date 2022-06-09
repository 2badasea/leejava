<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<style type="text/css">
.sidebar {
	background-color: #05AA6D;
	min-height: 100vh; 
}
.sideWrap {
	padding: 20px;
}
.sidebar_logo_image {
	width: 30px;
}
.sidebarSiteName {
	float: right;
	padding-top: 10px;
}
.sidebarSiteName span {
	padding-right: 25px;
}
.sidebar_beforeLogin {
	margin-top: 20px;
}
.sidebar_menu {
	margin-top: 100px;
}
#sidebar_loginBtn, 
#sidebar_memberJoinBtn, 
#logoutBtn{
	height: 30px;
}
#mainMenu, 
#subMenu {
	list-style-type: none;
}
#subMenu > li {
	padding-left: 20px;
	display: none;
}
.sidebar_menu > li, ul {
	margin-top: 20px;
}
.sidebar_menu > a {
	text-decoration: none;
}
</style>
</head>
<body>
<div class="sidebar">
	<div class="sideWrap">
		<div class="sidebar_logo" align="center">
				<a href="home.do">
				<img src="resources/image/루피.jpeg" class="sidebar_logo_image">
				<div class="sidebarSiteName">
					<span style="font-size: 20px;">LEEJAVA</span>
				</a>
			</div>
		</div>
		<div class="sidebar_userInfo">
			<c:if test="${empty session_user}">
			<div class="sidebar_beforeLogin" >
				<button type="button" id="sidebar_loginBtn">Login</button>
				<button type="button" id="sidebar_memberJoinBtn">MemberJoin</button>
			</div>
			</c:if>
			<c:if test="${not empty session_user }">
				<div class="sidebar_afterLogin">
					<span>${session_user}님 오늘도 빡코딩!</span><br>
					<c:if test="${session_user != null and session_nickname != '관리자' }">
						<button type="button" id="myInfoBtn">My Info</button>
					</c:if>
					<button type="button" id="logoutBtn">로그아웃</button>
				</div>
			</c:if>
		</div>
		<br>
		
		<div class="sidebar_menu">
			<hr>
			<ul id="mainMenu">
				<c:if test="${session_user == \"bada\"}">
					<li><a href="adminPage.do" class="sideMenu">관리자 화면</a></li>
				</c:if>
				<li><a href="quizlet.do">퀴즐렛 학습하기</a></li>
				<ul id="subMenu">커뮤니티
					<li><a href="boardList.do" class="sideMenu">자유게시판</a></li>
					<li><a href="#" class="sideMenu">QNA</a></li>
					<li><a href="#" class="sideMenu">정보/팁</a></li>
					<li><a href="#" class="sideMenu">읽을거리</a></li>
					<li><a href="#" class="sideMenu">스터디/정기모임</a></li>
					<li><a href="#" class="sideMenu">책/인강 리뷰</a></li>
				</ul>
				<li><a href="userNoticeList.do">공지사항</a></li>
			</ul>
		</div>
	</div>
</div>
</body>
<script>
	// 커뮤니티 메뉴 드랍다운 방식으로 생성
	$("#subMenu").hover( function(){
		$("#subMenu > li").show(); 
	});
	
	// 로그인 페이지 띄우기
	$("#sidebar_loginBtn").on("click", function(){
		alert("Move to Login Page~");
		location.href="loginPage.do";
	})
	
	// 로그아웃 처리   click function 
	$("#logoutBtn").click(function(){
		alert("로그아웃 합니다.");
		location.href="logout.do";
	})
	
	// 회원가입 페이지 이동
	$("#sidebar_memberJoinBtn").on("click", function(){
		alert("회원가입 페이지로 이동하겠습니다.");
		location.href='memberJoinTerms.do';
	})
	
	// 개인정보 변경하는 공간으로 이동
	$("#myInfoBtn").on("click", function(){ 
		alert("개인정보 조호히하는 공간으로 이동"); 
		location.href='userMyInfo.do';
	})
	
	
</script>
</html>