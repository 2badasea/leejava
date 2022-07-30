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
.tempHomeBtn{
	margin-top: 10px;
	padding: 10px;
	min-width: 100px;
	width: auto;
	min-height: 30px;
	border-style: none;
	border-radius: 20px;
	background-color: white;
	color: black;
	font-weight: 900;
	font-size: large; 
}
.tempHomeBtn:hover{
	cursor: pointer;
	color:	white;
	background-color: darkgray;
	transition: 0.2s;
}

.adminSidemenu {
	margin-top: 10px;
	text-decoration: none;
	font-size: large;
	font-weight: 600;
	color: gray;
}
.adminSidemenu:hover{
	color: lightgray;
	
}
.adminSidebar_wrapper{
	background-color: #343A40;
	min-height: 100vh; 
 }
.adminSidebar_wrapper li{
	margin-top: 20px;
}
/*	여기에  있는 specialA의 경우 -> 변형을 많이 한 상태*/
.specialA:hover{
	cursor: pointer;
}
.specialA{
text-decoration: none;
   display: inline-block;
   -webkit-transition: 0.2s;
   -moz-transition: 0.2s;
   -o-transition: 0.2s;
   -ms-transition: 0.2s;
   transition: 0.2s;
}

.specialA:hover {
    -webkit-transform: scale(1.2,1.2);
    -moz-transform: scale(1.2,1.2);
    -o-transform: scale(1.2,1.2);
    -ms-transform: scale(1.2,1.2);
    transform: scale(1.2,1.2);
} 
</style>
<body>
<input type="hidden" class="adminPageHiddenInput" data-status="${session_status }" data-user="${session_user }">
	<!-- 왼쪽 사이드바 -->
	<div class="adminSidebar_wrapper">
		<div class="adminSidebarMenu" align="center">
			<h5>현재 관리자 닉네임: ${session_nickname }</h5>
			<h5>현재 관리자 권한: ${session_status }</h5>
			<h5>현재 관리자 아이디: ${session_user }</h5>
			<button type="button" class="tempHomeBtn" onclick="location.href='home.do'">홈으로 가기</button>
			<button type="button" class="tempHomeBtn" onclick="location.href='adminPage.do'">관리자 홈</button>
		</div>
		<div class="adminSidebarLink" align="center">
			<ul>
				<li><a class="adminSidemenu specialA" href="adminMemberList.do">회원 관리</a></li>
				<li><a class="adminSidemenu specialA" href='adminNoticeList.do'>공지사항 관리</a></li>
				<li><a class="adminSidemenu specialA" href='adminRepair.do' id="repairGo">유지보수</a></li>
				<li><a class="adminSidemenu specialA" href="adminStudy.do" id="studyGo">테스트</a></li>
			</ul>
		</div>
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
<script>
	/*	문서가 로드되면 실행시킬 이벤트들 */
	$(function(){
		// 클릭을 했을 때마다 세션값을 체크한다. 세션값 기준에 admin이 아닌 경우 => alert창과 함께 메인페이지로 이동한다.
		$(document).on("click", function(){
			var status = $(".adminPageHiddenInput").data("status");
			console.log("status값 확인: " + status);
			if(status !== "ADMIN"){
				alert("세션이 만료되었습니다");
				location.href="logout.do";
			}
		})
	})
</script>
</html>