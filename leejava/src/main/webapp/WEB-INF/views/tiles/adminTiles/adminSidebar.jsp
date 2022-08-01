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
.adminSidebarMenu h5{
	color: whitesmoke;
}

</style>
<body>
<input value="${session_status }" type="hidden" class="adminPageHiddenInput" data-status="${session_status }" data-user="${session_user }">
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
		
		// 관리자페이지로 이동할 때 session_status값으로 ADMIN을 넘기는데, 이 값을 문서가 로딩되자마자 체크한다. 
		var checkSession = $(".adminPageHiddenInput").val();
		console.log("관리자 페이지에서 페이지 이동하자마자 생길 때 세션 체크하는 함수. 현재: " +checkSession);
		if(checkSession !== "ADMIN"){
			alert("관리자만 접근할 수 있는 페이지입니다.");
			location.href="home.do";
		}
		
		// 주기적으로 ajax요청을 통해 세션을 체크하는 함수를 구현해보자.
		const sessionTime = 1000 * 60 * 5; // 5분
// 		const sessionTime = 1000 * 5; // 테스트용 5초
		var session_statusCheck = setInterval(function(){
				console.log("세션 체크!");
				var now = new Date();
				$.ajax({
					url: "adminSessionCheck.do",
					method: "GET",
					dataType: "text",
					contentType: "application/text; charset=utf-8",
					success: function(sessionStatus){
						console.log("현재 세션 Status값: " + sessionStatus);
						if(sessionStatus !== "ADMIN"){
							alert("세션이 만료되었습니다. 만료시간: " + now);
							location.href="loginPage.do";
						} else {
							console.log("세션 체크 확인. 체크시간: " + now);
						}
					},
					error: function(){
						console.log("세션 체크 실패");
					}
				})
		},sessionTime )
	})
</script>

</html>