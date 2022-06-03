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
.sideWrap{
	background-color: #05AA6D;
	min-height: 100vh; 
 }

</style>
<body>
	<!-- 왼쪽 사이드바 -->
	<div class="sideWrap">
		<div onclick="location.href='home.do'">JAVA STORY</div>
		<br><br><br><br><br>
		<ul>
			<li>
				<a class="adminSidemenu" href="adminMemberList.do">회원 관리</a>
			</li>
			<li>
				<a class="adminSidemenu" href='adminNoticeList.do'>공지사항 관리</a>
			</li>
		</ul>
	</div>

	<!-- 왼쪽 사이드바 끝-->

</body>
</html>