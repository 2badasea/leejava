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
							<input type="text" id="m_nickname" class="searchInput m_nickname" placeholder="닉네임을 입려해주세요.">
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
					<tr data-email="${member.m_email }" data-status="${member.m_status }">
						<td>
							<input type="hidden" class="memberInfoHidden" data-email="${member.m_email }" data-status="${member.m_status }">
							${member.m_joindate }
						</td>
						<td>${member.m_email }</td>
						<td>${member.m_nickname }</td>
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
			</div>
		</div>
	</div>
</body>
<script>
	/*	문서가 로드되면 실행시킬 이벤트들 */
	const nowDate = new Date().toISOString().substring(0,10);
	let frontCal;
	let backCal;
	
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
		console.log("호출할 최종 URL 값: " + url);
// 		location.href = url; 
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
	})
</script>
</html>