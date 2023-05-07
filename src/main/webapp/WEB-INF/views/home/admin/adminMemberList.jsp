<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
/*	검색영역, 리스트 영역 공통적으로 적용시킬 디자인 요소	*/
.memberListWrapper{
	margin-top: 10%;
}

.memberListWrapper button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: whitesmoke;
	background-color: #313348;
	font-weight: 900;
}
.memberListWrapper button:hover{
	cursor: pointer;
	background-color: whitesmoke;
	color: #313348;
	transition: 0.5s;
}
.memberSearch,
.memberListDiv{
	padding-right: 10%;
}

/*	************회원 검색 영역 디자인 **************/
.memberSearchTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}
.memberSearchTable tr{
	border-bottom: 1px solid #313348; 
}

.memberSearchTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}

.memberSearchTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 1px solid #313348;
	padding: 5px; 
}
.memberSearchTable input:not(.inputDate),
.memberSearchTable select{
	width: 100%;
	font-size: 100%;
	text-align: center;
	height: 100%;
	border-style: none;
	font-weight: 700;
	border-bottom: 0.5px solid #313348;
}
.memberSearchTable input:focus,
.memberSearchTable select:focus,
.memberSearchTable option:focus{
	outline-color: coral;
}
.inputDate{
	text-align: center;
	width: 42%;
	height: 100%;
	font-weight: 600;
	
}
.memberSearchBtns{
	margin-top: 20px;
}
.memberSearchBtns button{
	min-width: 100px;
	min-height: 40px;
} 

/***************	회원리스트 목록 관려 디자인 요소들 *************/
.memberInfoBtn{
	width: 100px;
	padding-left: 5px;
	padding-right: 5px;
}
.memberListTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}
.memberListTr:hover{
	background-color: lightgray;
}

.memberListTable select{
	text-align: center;
	width: 100%;
	height: 100%;
}
.memberListTableThTr{
	border-bottom: 1px solid #313348;
}
.memberListTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}
.memberListTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 1px solid #313348;
	padding: 5px;
}
/* 현재 활성화된 페이지에 대해서 페이지넘버에 효과주기*/
.active a{
	font-weight: bolder;
	color: tomato;
	font-size: large;
}

/*	페이징 박스 디자인 요소*/
.paginationUl > li{
	list-style-type: none;
	float: left;
	padding: 5px;
}
.paginationLink{
	color: #313348;
	font-size: 20px;
}
.paginationBox {
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
}
.active a {
	font-weight: bolder;
	font-size: large;
	color: tomato;
	
}

/* **************사용자 정보 호출하는 모달창 관련 스타일 정의************88*/
/* 사용자 정보 조회하는 모달창 */
.userInfo_modal_container {
	position: fixed;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100vh;
	display: none;
	z-index: 1;
}

.userInfo_modal_content {
	position: absolute;
	top: 10%;
	left: 15%;
	width: 700px;
	height: auto;
	z-index: 3;
	background-color: white;
	border: 1px solid #313348;
	border-radius: 20px;
	padding: 30px;
}

.userInfo_modal_layer {
	position: relative;
	width: 100%;
	height: 100%;
	z-index: 2;
	background-color: grey;
	opacity: 0.3;
	transition: 2s;
}
/* 헤더 div */
.userInfo_modal_header{
	border-bottom: 1px solid #313348;
}

.userInfoModalCloseBtn {
	margin-top: 50px;
	float: right;
	width: 80px;
	height: 40px;
	border-radius: 20px;
	background: #313348;
	color: whitesmoke;
	border-style: none;
	font-size: 20px;
	font-weight: bold;
}
.userInfo_imageDiv{
	margin-top: 20px;
}
.userInfo_imageDiv img{
	max-width: 150px;
	max-height: 150px;
}

.userInfoModalCloseBtn:hover {
	cursor: pointer;
	background-color: whitesmoke;
	color: #313348;
	transition: 1s;
}

#userInfo_joindate:focus, #userInfo_nickname:focus {
	outline-style: none;
}

.userInfo_modal_body {
	display: flex;
	justify-content: space-around;
}

.profileImg {
	width: 150px;
	height: 150px;
	border-style: none;
}

.userInfo_quizcardTb {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 10px;
}

.userInfo_quizcardTr {
	border-bottom: 0.5px dashed #313348;
}

.userInfo_quizcardTr:hover {
	cursor: pointer; 
	background-color: whitesmoke ; 
}

fieldset{
	border: 1px solid #313348;
	padding: 5px;
}

.userInfo_modal_footer {
	margin-bottom: 10%;
}

.userInfo_right {
	width: 60%;
}
#userInfoTitle{
	font-weight: 900;
	font-size: larger;
	color: #313348;
}

.userInfo_right textarea {
	width: 95%;
	height: 95%;
	border-radius: 20px;
	padding: 15px;
}
legend,
#userIntroLabel{
	color: #313348;
	font-weight: 900;
	font-size: large;
}
.userInfo_modal_content input {
	border-style: none;
	font-size: 18px;
	color: #313348;
	width: 100px;
	font-weight: bolder;
}

.userInfo_IntroForm{
	border-top: 10px;
}
#userIntroForm{
	color: #313348;
	font-weight: 800;
}

.msgBtn{
	width: auto;
	height: auto;
	border-radius: 20px;
	padding: 5px;
	background-color: #313348;
	color: white;
}
.msgBtn:hover {
	cursor: pointer;
}
/*	닉네임 클릭시 메뉴 활성화 구현 */
.memberNickname{
	
}

/*	***************************************************	*/
</style>
</head>
<body>
<input type="hidden" class="adminPageHiddenInput" data-status="${session_status }" data-user="${session_user }">
	<!-- 컨셉은 공지사항 리스트와 비슷하게 우선 wrppaer를 깔고 그 위에 얹어야 할 듯. -->
	<!-- 검색바는 일단 나중에 하고, 우선은 리스트만 출력시키기. => 뷰를 통해서 전달한다. -->
<body>
	<div class="adminMemberList_wrapper">
		<!-- 크게 div 2개를 구성한다. 회원검색용도, 다른 하나는 공지사항 리스트가 출력되는 용도 -->
		<div class="memberListWrapper">
			<!--아래 div는 검색창을 구현한다. 검색항목( 이메일, 닉네임, 가입경로(selectbox) , 가입일  -->
			<div class="memberSearch" align="center">
				<table class="memberSearchTable">
					<tr>
						<th>이메일</th>
						<td style="width: 300px;">
							<input type="text" id="m_email" class="searchInput m_email" placeholder="이메일을 입력해주세요">
						</td>
						<th>닉네임</th>
						<td style="width: 300px;">
							<input type="text" id="m_nickname" class="searchInput m_nickname" placeholder="닉네임을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<th>가입경로</th>
						<td>
							<select id="m_joinpath" class="searchInput m_joinpath">
								<option value="자바이야기">자바이야기</option>
								<option value="KAKAO">카카오</option>
								<option value="NAVER">네이버</option>
								<option value="GOOGLE">구글</option>
								<option value="ALL" selected="selected">전체</option>
							</select>
						</td>
						<th>가입일</th>
						<td>
							<input type="date" class="searchInput inputDate frontCalendar"> ~
							<input type="date" class="searchInput inputDate backCalendar">
						</td>
					</tr>
				</table>
				<div class="memberSearchBtns">
					<button type="button" class="clearBtn">초기화</button>
					<button type="button" class="memberSearchBtn">검색</button>
				</div>
			</div>
			<br>
			<br>
			<hr>
			<br>
			<!-- 아래 div는 회원목록을 보여주는 리스트 -->
			<div class="memberListDiv" align="center">
				<h2>회원 리스트</h2>
				<c:choose>
					<c:when test="${pagination.listCnt lt pagination.end }">
						<span>( 총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.listCnt }건 )</span>
					</c:when>
					<c:otherwise>
						<span>( 총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.end }건 )</span>
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;&nbsp;
				<select class="paging" name="searchType" id="listSize" onchange="page(1)">
					<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10명씩 보기</option>
					<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15명씩 보기</option>
					<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20명씩 보기</option>
				</select>				
				
				
				<table class="memberListTable">
				<!--들어갈 항목 => 이메일, 닉네임, 가입날짜, 가입경로, 상태, 개인정보, 프로로모션 정보-->
					<tr class="memberListTableThTr">
						<th width="120px;">가입일</th>
						<th width="200px;">이메일</th>
						<th width="150px;">닉네임</th>
						<th width="120px;">가입경로</th>
						<th width="120px;">권한</th>
						<th width="120px;">개인정보동의</th>
						<th width="120px;">프로모션동의</th>
						<th width="100px;">관리</th>
					</tr>
				<c:forEach items="${member }" var="member">
					<tr class="memberListTr" data-email="${member.m_email }" data-status="${member.m_status }">
						<td>
							<input type="hidden" class="memberInfoHidden" data-email="${member.m_email }" data-status="${member.m_status }">
							${member.m_joindate }
						</td>
						<td>${member.m_email }</td>
						<td class="memberNickname">${member.m_nickname }</td>
						<td>${member.m_joinpath }</td>
						<td>
							<c:if test="${session_user == 'bada' }">
								<select class="statusSelect">
									<option value="ADMIN" <c:if test="${member.m_status eq \"ADMIN\" }">selected="selected"</c:if>>ADMIN</option>
									<option value="USER" <c:if test="${member.m_status eq \"USER\" }">selected="selected"</c:if>>USER</option>
								</select>
							</c:if>
							<c:if test="${session_user != 'bada' }">
								${member.m_status }
							</c:if>
						</td>
						<td>${member.m_privacy }</td>
						<td>${member.m_promotion }</td>
						<td>
							<button type="button" class="memberInfoBtn" >회원정보</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			<br><br> 
			<!--  페이징 박스가 들어갈 곳  -->
			<div id="paginationBox" class="paginationBox">
				 <ul class="paginationUl">
				 	<c:if test="${pagination.prev }">
				 		<li class="paginationLi">
				 			<a class="paginationLink speicalA" onclick="fn_prev('${pagination.page}', '${pagination.range }'
							 													,'${pagination.rangeSize }', '${pagination.listSize }'
							 													,'${search.m_joinpath }', '${search.m_email }', '${search.m_nickname }'
							 													,'${search.frontCal }', '${search.backCal }')">이전</a>
				 		</li>
				 	</c:if>
				 	<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="memberNo">
				 		<li class="paginationLi <c:out value="${pagination.page == memberNo ? 'active' : '' }" />" >
				 			<a class="paginationLink specialA" onclick="fn_pagination('${memberNo }', '${pagination.range }', '${pagination.rangeSize }',
				 											'${pagination.listSize }', '${search.m_joinpath}', '${search.m_email }', '${search.m_nickname }',
				 											'${search.frontCal }', '${search.backCal }')">${memberNo }</a>
				 	</c:forEach>
				 	<c:if test="${pagination.next }">
				 		<li class="paginationLi">
				 				<a class="paginationLink speicalA" onclick="fn_prev('${pagination.page}', '${pagination.range }'
								 													,'${pagination.rangeSize }', '${pagination.listSize }'
								 													,'${search.m_joinpath }', '${search.m_email }', '${search.m_nickname }'
								 													,'${search.frontCal }', '${search.backCal }')">다음</a>
				 		</li>
				 	</c:if>
				 </ul>
			</div>
			</div>
		</div>
	</div>
<!--  회원정보 조회하는 모달창 (퀴즈카드 페이지에 있는 소스들 훔쳐옴 -->
	<!-- 사용자 정보 조회하는 모달창  -->
	<div class="userInfo_modal_container">
		<div class="userInfo_modal_content">
			<div class="userInfo_modal_header" align="center">
				<span id="userInfoTitle"></span>
				<button type="button" id="msgBtn" class="msgBtn" style="float: right;">쪽지 보내기</button>
			</div>
			<br>
			<div class="userInfo_modal_body">
				<div class="userInfo_left" align="center">
					<div class="userInfo_imageDiv">
						<!-- 사용자 프로필 이미지 또는 기본 이미지가 출력되는 공간  -->
					</div>
					<div class="userInfo_subInfo">
						<label for="userInfo_nickname">닉네임</label> 
						<input type="text" id="userInfo_nickname" value="" readonly="readonly">
						<br> 
						<label for="userInfo_joinDate">가입날짜</label> 
						<input type="text" id="userInfo_joindate" value="" readonly="readonly">
					</div>
				</div>
				<div class="userInfo_right" align="center">
					<label for="userIntroForm" id="userIntroLabel"></label>
					<div class="userInfo_IntroForm">
						<textarea id="userIntroForm" cols="30" rows="15" readonly="readonly"></textarea>
					</div>
				</div>
			</div>
			<br>
			<hr>
			<fieldset class="userInfoFieldset">
				<legend>작성한 퀴즈카드</legend>
				<div class="userInfo_quizcard" align="center"></div>
			</fieldset>
			<br>
			<div class="userInfo_modal_footer">
				<button class="userInfoModalCloseBtn">닫기</button>
			</div>
		</div>
		<div class="userInfo_modal_layer"></div>
	</div>
</body>
<script>
	// 닉네임 클릭 => 쪽지보내기 메뉴 구현
	$(".memberNickname").on("mouseover", function(){
		$(this).css("cursor", "pointer");
	})
	
	$(".memberNickname").on("click", function(){
		console.log("클릭 이벤트 발생");
	})
</script>
<script>
	// 사용자 정보 호출하는 모달창 관련 스크립트. 
		// 사용자 정보 조회하는 모달창 관련 스크립트 부분(공통영역)  ------------------------- 작업 끝나고 밑으로 내려보내기
		// 일단 class값은 memberInfoBtn 이고, 해당 버튼을 클릭했을 때, nickname 값을 가져와본다.
	
		
	// 임시 테스트 버튼. 클릭으로 닉네임 값 찾아보기
	$(".memberInfoBtn").on("click", function(e) {
			console.log("유저 닉네임 클릭");
			// 버튼을 클릭해서 이메일 값과 닉네임 값을 가져와야 한다. "email" 값의 경우, 첫 번째 모달창으로 리턴되는 값으로 대입한다. 바로 밑의 ajax구문에 존재
			let email;
			$("body").css("overflow", "hidden"); // 모달창 호출 => body영역 스크롤 방지
			$(".userInfo_modal_container").css("display", "block");
			var sendNickname =  $(e.target).closest('tr').find('td').eq(2).text();
			console.log("닉네임 값 조회: " + sendNickname);
			// 첫 번째 ajax로 프로필 정보(닉네임, 이메일, 가입날짜, intro + 프로필이미지 정보)		
			$.ajax({
				url : "ajaxUserInfo.do?m_nickname=" + sendNickname, // (QuizcardRestController)
				type : "GET",
				dataType : "json",
				async : false,
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					console.log("호출 성공");
					console.log(data);
					email = data.m_email;  
					$("#userInfo_nickname").val(data.m_nickname);
					$("#userInfo_joindate").val(data.m_joindate);
					$("#userIntroForm").val(data.m_intro);
					$("#userInfoTitle").html(data.m_nickname + " 님의 사용자 정보");
					$("#userIntroLabel")
							.text(data.m_nickname + " 님의 Intro");
				},
				error : function(responseText) {
					console.log("호출 실패");
					console.log(responseText);
				} 
			})
			// 두 번째 ajax => 작성한 퀴즈카드 정보 넣기. 
			var tb = $("<table class='userInfo_quizcardTb' />");
			var emptyMessage;
			$.ajax({
				url : "ajaxMyQuizcard.do",
				type : "GET",
				dataType : "json",
				data : {
					m_email : email
				},
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					console.log("호출 성공");
					console.log(data);
					if( data.length == 0){
						emptyMessage = "<p>작성한 퀴즈카드가 존재하지 않습니다.</p>";
						$(".userInfo_quizcard").append(emptyMessage);
					} else {
						// json 배열의 타입을 출력시켜야 한다   class="userInfo_quizcard" 여기 공간에 append 시킨다. 
						$.each(data, function(index, item) {
							var tr = $("<tr class='userInfo_quizcardTr' />")
									.append(
											$("<td />").text(
													item.quizcard_set_no),
											$("<td />").text(
													item.quizcard_set_name),
											$("<td />").text(
													item.quizcard_set_cdate),
											$("<td />").text(
													item.quizcard_category));
							tb.append(tr);
						})
						$(".userInfo_quizcard").append(tb);
					}
				},
				error : function(responseText) {
					console.log("호출 실패");
					console.log(responseText);
				}
			})
			
			// 첫 번째 ajax가 동기방식으로 닉네임을 통해 우선적으로 email값을 읽어옴. email. 이걸로 해당 회원의 이미지를 호출한다.
			var uploadResult = $(".userInfo_imageDiv");
			$.getJSON("getAttachList.do", { m_email : email}, function(arr){
				let obj = arr[0];
				if(obj.uploadPath == null || obj.uploadPath == ''){
					// 이미지가 없을 경우 => 기본이미지가 출력되도록 한다.
					console.log("이미지가 없음");
					let str = "";
					str += "<div id='basic_result_card'>";
					str += "<img src='resources/image/userimage.jpg'>";
					str += "</div>";
					uploadResult.html(str);
					return;
				}
				// 반대로 호출되는 이미지 정보가 있는 경우. 
				let str = "";
				console.log("obj.uploadPath 값: " + obj.uploadPath);
				let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				console.log("fileCallPath 값: " + fileCallPath);
				str += "<div id='basic_result_card'";
				str += " data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" +  obj.fileName + "'";
				str += ">";
				str += "<img src='display.do?fileName=" + fileCallPath + "'>";
				str += "</div>";
				uploadResult.html(str);
			}) // get.JSON 메서드 영역 끝  ( get.JSON으로 회원의 이미지 정보를 출력하여 display.do로 화면에 출력시킨다.)
		}) // 개볋 회원정보 호출하는 이벤트 정의 끝

	// 모달창 닫기버튼(X) 
	$(".userInfoModalCloseBtn").on('click', function() {
		console.log("사용자 정보 창 닫기");
		$(".userInfo_quizcard").empty(); // div안의 영역을 초기화 시켜준다. 
		$("body").css("overflow", "unset"); // 모달창 호출 => 스크롤 방지 해제
		$(".userInfo_modal_container").css('display', 'none');
	})

	// 외부영역 클릭 모달창 닫기
	$(document).on(
			"click",
			function(e) {
				if ($(e.target).closest('.userInfo_modal_content').length == 0
						&& !$(e.target).hasClass('memberInfoBtn')) {
					$(".userInfo_quizcard").empty();
					$("body").css("overflow", "unset");
					$(".userInfo_modal_container").css('display', 'none');
				}
			})

	// 동적으로 추가된 tr클릭 => 퀴즈카드 set이동 
	$(document).on(
			"click",
			".userInfo_quizcardTr",
			function(e) {
				var check = confirm("해당 퀴즈카드로 이동하시겠습니까?");
				if (check) {
					var set_no = $(e.target).parent().find('td').eq(0).text();
					var email = $("#session_user").val();
					location.href = 'quizcardBefore.do?set_no=' + set_no
							+ "&m_email=" + email;
				} else {
					return false;
				}
	})
</script>
<script>
	const nowDate = new Date().toISOString().substring(0,10);
	let frontCal;
	let backCal;
	
	/* 페이징 처리와 관려된 이벤ㅌ */ 
	function page(Paging){
		var startPage = Paging;
		var listSize = $("#listSize option:selected").val();
		// listSize는 10 or 15 or 20의 값이 올 것이다. 
		var url = "adminMemberList.do?startPage=" + startPage + "&listSize=" + listSize;
		alert("호출할 URL 확인: " + url);
		location.href= url;
	}
	
	/*	페이징 박스 내에서의 페이징 이벤트 처리. "이전", "다음", 그리고 페이지넘버값 '*/
		
	// 1. "이전" 버튼에 대한 이벤트 정으
	function fn_prev(page, range, rangeSize, listSize, m_joinpath, m_email, m_nickname, frontCal, backCal){
		var page = ( (range -2 ) * rangeSize) + 1;
		var range = range -1 ;
		var url = "adminMemberList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&m_joinpath=" + m_joinpath;
		url = url + "&m_email=" + m_email;
		url = url + "&m_nickname=" + m_nickname;
		url = url + "&frontCal=" + frontCal;
		url = url + "&backCal=" + backCal;
		alert("테스트 호출하는 URL 확인: " + url);
		location.href= url;
	}
	
	// 2. "페이지넘버" 값들에 대한 클릭이벤트 정의
	function fn_pagination(page, range, rangeSize, listSize, m_joinpath, m_email, m_nickname, frontCal, backCal){
		console.log("페이징 이벤트 발생");
		var url = "adminMemberList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&m_joinpath=" + m_joinpath;
		url = url + "&m_email=" + m_email;
		url = url + "&m_nickname=" + m_nickname;
		url = url + "&frontCal=" + frontCal;
		url = url + "&backCal=" + backCal;
		alert("테스트 호출하는 URL 확인: " + url);
		location.href= url;
	}
	
	// 3. "다음" 버튼에 대한 이벤트 정의
	function fn_next(page, range, rangeSize, listSize, m_joinpath, m_email, m_nickanme, frontCal, backCal){
		var page =  parseInt( (range * rangeSize) ) + 1;
		var range = parseInt( range) + 1;
		var url = "adminMemberList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&m_joinpath=" + m_joinpath;
		url = url + "&m_email=" + m_email;
		url = url + "&m_nickname=" + m_nickname;
		url = url + "&frontCal=" + frontCal;
		url = url + "&backCal=" + backCal;
		alert("테스트 호출하는 URL 확인: " + url);
		location.href= url;
	}
	
	// 회원검색 버튼 이벤트 
	$(".memberSearchBtn").on("click", function(){
		console.log("검색 이벤트 발생");
		// 각각의 값들을 변수에 담아서 url을 호출하는 방식으로 본내다. 
		var email = $(".m_email").val();
		var nickname = $(".m_nickname").val();
		var joinpath = $(".m_joinpath").val();
		var frontCal = $(".frontCalendar").val().substring(2,10);
		var backCal = $(".backCalendar").val().substring(2,10);
		var url = "adminMemberList.do";
		url = url + "?m_email=" + email;
		url = url + "&m_nickname=" + nickname;
		url = url + "&m_joinpath=" + joinpath;
		url = url + "&frontCal=" + frontCal;
		url = url + "&backCal=" + backCal; 
		location.href = url; 
	})
	
	// 앞뒤 달력에 대한 이벤트를 조정하자.  frontCalendar의 값은 backCalendar보다 높을 수가 없다.
	$(".frontCalendar").change(function(){
		console.log("이벤트 발생");
		frontCal = $(".frontCalendar").val();
		backCal = $(".backCalendar").val();
		console.log("프론트값: " + frontCal);
		console.log("현재 시간: " + nowDate);
		console.log("백 값: " + backCal);
		if( frontCal > nowDate || frontCal > backCal){
			alert("잘못된 날짜 형식입니다.");
			$(".frontCalendar").val('');
		} else {
			console.log("잘 선택했네유.");
		}
	})
	
	$('.backCalendar').on("change", function(){
		console.log("이벤트 발생");
		frontCal = $(".frontCalendar").val();
		backCal = $(".backCalendar").val();
		console.log("프론트값: " + frontCal);
		console.log("현재 시간: " + nowDate);
		console.log("백 값: " + backCal);
		if( backCal > nowDate || backCal < frontCal){
			alert("잘못된 날짜형식입니다.");
			$(".backCalendar").val(nowDate);
		} else {
			console.log("잘 선택하셧음 ^^");
		}
	})
	
	
	
	$(".statusSelect").change(function(e){
		console.log("이벤트 발생");
		// 세션값에 대해서 더 잘 다루기 => 주기적으로 세션값을 새로 측정해서 일정시간 간격으로 지속적으로 input태그에 값을 넣는 것도 하나의 방법일까?
		var nowUser = $(".adminPageHiddenInput").data('user');
		console.log("현재 로그인한 user의 값: " + nowUser);
		if(nowUser !== "bada"){
			return false;
		}
		var sendStatus = $(".statusSelect option:selected").val();
		var sendEmail = $(e.target).closest('tr').data('email');
		var data = {
				m_email : sendEmail,
				m_status : sendStatus
		};
		// restApi 방식으로 해본다
		$.ajax({
			url: "memberStatusUpdate.do",
			method : "PUT",
			contentType: "application/json; charset=utf-8",
			dataType: "text",
			data: JSON.stringify(data),
			success: function(message){
				console.log("호출 성공");
				alert("권한이 변경되었습니다.");
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
	
	// 검색창 초기화 버튼 구현
	$(".clearBtn ").on("click", function(){
		console.log("검색창 초기화 실행");
		$(".m_email, .m_nickname, .frontCalendar").val('');
		$(".m_joinpath option[value='ALL']").prop("selected", true);
		$(".backCalendar").val(nowDate);
	})
	
	
</script>
<script>
	$(function(){
		// 검색요소의 뒷달력의 기본값을 오늘날짜로 맞춘다. 
		$(".backCalendar").val(nowDate);
		$(".m_email").val('');
		$(".m_nickname").val('');
		$(".frontCalendar").val('');
		$(".m_joinpath option[value='ALL']").prop("selected", true);		
		// 페이지가 리로됭되면 입력값들을 초기화 시킨다. 
		
	})
</script>
</html>