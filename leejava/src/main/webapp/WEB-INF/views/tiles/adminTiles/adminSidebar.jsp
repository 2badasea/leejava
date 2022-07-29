<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<style>
.adminSidemenu {
	font-size: 15px;
}
.adminSidebar_wrapper{
	background-color: #05AA6D;
	min-height: 100vh; 
 }
.adminSidebar_wrapper li{
	margin-top: 20px;
}
.specialA:hover{
	cursor: pointer;
}
.specialA{
text-decoration: none;
   display: inline-block;
   -webkit-transition: 0.3s;
   -moz-transition: 0.3s;
   -o-transition: 0.3s;
   -ms-transition: 0.3s;
   transition: 0.3s;
}

.specialA:hover {
    -webkit-transform: scale(1.5,1.5);
    -moz-transform: scale(1.5,1.5);
    -o-transform: scale(1.5,1.5);
    -ms-transform: scale(1.5,1.5);
    transform: scale(1.5,1.5);
} 
</style>
<body>
	<!-- 왼쪽 사이드바 -->
	<div class="adminSidebar_wrapper">
		<div onclick="location.href='home.do'">
			JAVA STORY
		</div>
		<br><br><br><br><br>
		<ul>
			<li>
				<a class="adminSidemenu" href="adminMemberList.do">회원 관리</a>
			</li>
			<li>
				<a class="adminSidemenu" href='adminNoticeList.do'>공지사항 관리</a>
			</li>
			<li>
				<a class="adminSidemenu" href='adminRepair.do' id="repairGo">사이트 유지보수 관리</a>
			</li>
			<li>
				<a class="adminSidemenu" href="adminStudy.do" id="studyGo">테스트</a>
			</li>
		</ul>
	</div>
	<!-- 왼쪽 사이드바 끝-->
</body>
<script>
	// 페이지 이동.
	$("#repairGo").on("click", function(e){
		e.preventDefault();
		location.href="adminRepair.do";
	})
	
	$("#studyGo").on("click", function(e){
		e.preventDefault();
		location.href="adminStudy.do";
	})
</script>
</html>