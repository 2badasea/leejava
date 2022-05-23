<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.adminSidemenu {
		font-size: 15px;
	}
</style>
<body>
	<!-- 왼쪽 사이드바 -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<!-- 프로젝트 로고 & 관리자 시스템 메뉴 -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="home.do">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					JAVA STORY 	
				</div>
			</a>
			<li class="adminSidemenu" onclick="location.href='adminNoticeList.do'">공지사항 관리</li>
			
			
		</ul>
		<!-- 왼쪽 사이드바 끝-->
		
</body>
</html>