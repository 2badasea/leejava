<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 메인페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.quizcardMain {
	
}

.quizcardListWrapper {
	height: auto;
}

.quizcardTable td:nth-child(4):hover {
	cursor: pointer;
}

.quizcardTable td:nth-child(6):hover {
	cursor: pointer;
}

/* 퀴즈카드 학습모드 선택 모달창 */
.studyType_modal_container {
	position: fixed;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100vh;
	display: none;
	z-index: 1;
}

.studyType_modal_content {
	position: absolute;
	top: 30%;
	left: 35%;
	width: 400px;
	height: auto;
	z-index: 3;
	background-color: teal;
	color: white;
	border: 0.5px solid #05AA6D;
	border-radius: 30px;
	padding: 20px;
}

.studyType_modal_layer {
	position: relative;
	width: 100%;
	height: 100%;
	z-index: 2;
	background-color: transparent;
	transition: 2s;
}

fieldset {
	border: 1px solid white;
}
/* ******************************************** */
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
	top: 20%;
	left: 30%;
	width: 700px;
	height: auto;
	z-index: 3;
	background-color: white;
	border: 0.5px solid #05AA6D;
	border-radius: 30px;
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

.userInfoModalCloseBtn {
	margin-top: 50px;
	float: right;
	width: 100px;
	height: 50px;
	border-radius: 20px;
	background: white;
	color: teal;
	border-style: none;
	font-size: 20px;
	font-weight: bold;
}

.userInfoModalCloseBtn:hover {
	cursor: pointer;
	background-color: teal;
	color: white;
	transition: 1s;
}

.userInfo_modal_body {
	display: flex;
}

.profileImg {
	width: 200px;
	height: 200px;
	border-style: none;
}

.userInfo_quizcardTb {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 10px;
}

.userInfo_quizcardTr {
	border-bottom: 0.5px dashed teal;
	margin-top: 3px;
}
#basic_result_card{
	display: flex;
	justify-content: center;	
	border: 0.2px solid lightgray;
	width: 80%;
	height: 200px;
}
.userInfo_image img{
	text-align: center;
	min-width: 100px;
	min-height: 100px;
	width: auto;
	height: auto;
}
.userInfo_quizcardTr:hover {
	cursor: pointer;
}

.userInfoFieldset {
	border: 1px solid teal;
}

.userInfo_modal_footer {
	margin-bottom: 10%;
}

.userInfo_right {
	width: 60%;
}

.userInfo_right textarea {
	width: 95%;
	height: 95%;
	border-radius: 20px;
	padding: 8px;
}

.userInfo_modal_content input {
	border-style: none;
	font-size: 18px;
	color: teal;
	font-weight: bolder;
}

.quizcardTable {
	margin-top: 5%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid teal;
}

.quizcardTableThTr th {
	font-size: 15px;
}

.quizcardTableThTr {
	border-bottom: 1px solid teal;
}

.quizcardTableTr {
	
}

.quizcardTable th {
	font-size: 18px;
	height: 30px;
	border-left: 1px solid teal;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
}

.quizcardTable td {
	border-bottom: 1px solid teal;
	height: 20px;
	border-left: 1px solid teal;
	padding: 5px;
}

.quizcardTable a {
	color: teal;
	font-weight: bold;
}
/* 퀴즈카드 검색영역 디자인 */
.quizcardSearchTb {
	margin-top: 5%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid teal;
}

.quizcardSearchTb th {
	font-size: 15px;
}

.quizcardSearchTb th {
	font-size: 18px;
	height: 30px;
	border-left: 1px solid teal;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
}

.quizcardSearchTb td {
	border-bottom: 1px solid teal;
	height: 20px;
	border-left: 1px solid teal;
	padding: 5px;
}

.quizcardSearchTb tr {
	border-bottom: 1px solid teal;
}

.searchCategoryInput {
	width: 80%;
	height: 80%;
}

.categoryDirectInput {
	height: 40%;
	width: 75px;
	display: none;
}

.quizcardSearchTb input {
	height: 80%;
}

.quizcardMain button {
	border-radius: 20px;
	width: auto;
	height: auto;
	font-weight: 900;
	color: teal;
	background-color: whitesmoke;
	border-style: none;
	padding: 10px;
}

.quizcardMain button:hover {
	cursor: pointer;
	background-color: teal;
	color: whitesmoke;
	transition: 1s;
}
/* ***************************************** */
.paginationUl > li{
	list-style-type: none;
	float: left;
	padding: 5px;
}

.paginationLink {
	color: teal;
	font-size: 20px;
}
.paginationBox{
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
}
.active a{
	font-weight: bolder;
	color: tomato;
	font-size: large;
}
</style>
</head>
<script>
	// 페이지 넘어오면 알아서 검색항목 초기화 시켜놓기
	$(document).on("ready", function(){
		console.log("문서 로드 확인");
		// 검색항목 초기화시키는 버튼 이벤트 발생시키기
		$(".searchResetBtn").click();  
	})
</script>
<body>
	<div class="quizcardWrapper" align="center">
		<div class="quizcardMain">
			<form id="searchFrm">
				<table class="quizcardSearchTb">
					<tr>
						<th>카테고리</th>
						<td>
							<select name="searchCategoryInput" id="searchCategoryInput" class="searchCategoryInput">
								<option value="ALL" selected>모두 선택</option>
								<option value="Java">Java</option>
								<option value="Javascript">Javascript</option>
								<option value="HTML&CSS">HTML&CSS</option>
								<option value="CS">CS</option>
								<option value="Git">Git</option>
								<option value="React">React</option>
								<option value="Vue">Vue</option>
								<option value="DB">DB</option>
								<option value="DIRECT">직접입력</option>
							</select> 
							<input type="text" class="categoryDirectInput">
						</td>
						<th>세트이름</th>
						<td><input type="text" name="searchSetnamInput"
							class="searchSetnamInput" placeholder="세트이름을 입력하세요."></td>
					</tr>
					<tr>
						<th>만든이(닉네임)</th>
						<td><input type="text" name="searchNicknameInput"
							class="searchNicknameInput" placeholder="닉네임을 입력하세요."></td>
						<th>비고</th>
						<td>-</td>
					</tr>
				</table>
			</form>
			<br>
			<button class="searchBtn">검색</button>
			<button class="searchResetBtn">항목 초기화</button>
		</div>
		<!-- 검색항목 영역과 퀴즈카드 리스트 구분선. 메인은 리스트니깐, 검색항목 영역은 상대적으로 작게 구현할 것. -->
		<br><br><hr><br><br>
		<div class="quizcardListWrapper">
			<!--  table 형태로 생성한다.-->
			<div class="quizcardListPagingInfo">
				<h3>퀴즈카드 리스트</h3>
				<c:choose>
					<c:when test="${pagination.listCnt lt pagination.end}">
						<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.listCnt }건)</span>
					</c:when>
					<c:otherwise>
						<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.end }건)</span>
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;&nbsp;
				<select class="paging" name="searchType" id="listSize" onchange="page(1)">
					<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10건 보기</option>
					<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15건 보기</option>
					<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20건 보기</option>
				</select>
			</div>  <!--  	<div class="quizcardListPagingInfo"> 영역 끝  -->
				<table class="quizcardTable">
					<thead>
						<tr class="quizcardTableThTr">
							<th>세트번호</th>
							<th>카테고리</th>
							<th>세트유형</th>
							<th style="width: 300px;">세트이름</th>
							<th>최근 업데이트</th>
							<th style="width: 100px;">만든이</th>
							<th>조회수</th>
							<th>추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${quizcardList }" var="list">
							<tr class="quizcardTableTr">
								<td>${list.quizcard_set_no }</td>
								<td>${list.quizcard_category }</td>
								<td>${list.quizcard_type }</td>
								<td><a>${list.quizcard_set_name }</a></td>
								<td>${list.quizcard_set_udate }</td>
								<td class="userInfoTd"><a class="userInfoTd">${list.m_nickname }</a></td>
								<td>${list.quizcard_set_hit }</td>
								<td>${list.quizcard_set_likeit }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br><br>
				<!-- 페이징 박스. class값으로 이벤트 정의. id속성값으로 꾸미기 -->
				<div class="paginationBox" id="paginationBox">
					<ul class="paginationUl">
						<c:if test="${pagination.prev }">
								<li class="paginationLi">
									<a class="paginationLink" onclick="fn_prev('${pagination.page}', '${pagination.range }'
																						, '${pagination.rangeSize}', '${pagination.listSize }'
																						, '${search.quizcard_category}', '${search.quizcard_set_name }'
																						, '${search.m_nickname }' )">
									이전
									</a>
								</li>
						</c:if>
						<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="quizcardNo">
							<!-- 해당 페이지를 클릭한 상태라면('active') 그 페이지 번호의 class속성에 'active'를 준다. => 꾸미기 위함  -->
							<li class="paginationLi <c:out value="${pagination.page == quizcardNo ? 'active' : ''}"/> ">
								<a class="paginationLink" onclick="fn_pagination('${quizcardNo}', '${pagination.range }'
																						 , '${pagination.rangeSize }', '${pagination.listSize }'
																						 , '${search.quizcard_category }', '${search.quizcard_set_name }'
																						 , '${search.m_nickname }' )">
								${quizcardNo }
								</a>
							</li>
						</c:forEach>
						<c:if test="${pagination.next }">
							<li class="paginationLi">
								<a class="paginationLink"  onclick="fn_next('${pagination.page}', '${pagination.range }'
																				, '${pagination_rangeSize }', '${pagination_listSize }'
																				, '${search.quizcard_category }', '${search.quizcard_set_name }'
																				, '${search.m_nickname }')">
								다음
								</a>
							</li>			
						</c:if>
					</ul>
				</div> <!--  	<div class="paginationBox"> 끝.  -->
		</div> <!--  <div class="quizcardListWrapper"> 끝 -->
		
	</div>  <!--  <div class="quizcardWrapper"> 끝  -->

	<!-- 사용자 정보 조회하는 모달창  -->
	<div class="userInfo_modal_container">
		<div class="userInfo_modal_content">
			<div class="userInfo_modal_header">
				<span id="userInfoTitle">(사용자 닉네임)님의 정보</span>
			</div>
			<div class="userInfo_modal_body">
				<div class="userInfo_left">
					<div class="userInfo_image">
<!-- 						<img class="profileImg" alt="사진을 준비중입니다." src="resources/image/loopy.jpeg"> -->
					</div>
					<div class="userInfo_subInfo">
						<label for="m_nickname">닉네임</label> 
						<input type="text" id="m_nickname" value="" readonly="readonly">
						<br> 
						<label for="m_joinDate">가입날짜</label> 
						<input type="text" id="m_joindate" value="" readonly="readonly">
					</div>
				</div>
				<div class="userInfo_right">
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
				<div class="userInfo_quizcard"></div>
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
	// 검색기능 + 페이징 기능 스크립트 구현. ( 모두 정의 후 기능점검에 이상 없으면 아래 스크립트랑 합치기) 
	$(".searchBtn").on("click", function(){
		var quizcard_category; 
		if ( $(".searchCategoryInput").val() === "DIRECT"){
			quizcard_category = $('.categoryDirectInput').val();
		} else {
			quizcard_category = $(".searchCategoryInput").val();
		}
		if( quizcard_category === ''){
			quizcard_category = "ALL";
		}
		var quizcard_set_name = $(".searchSetnamInput").val();
		var m_nickname = $(".searchNicknameInput").val();
		console.log("카테고리: " + quizcard_category + "세트이름: " + quizcard_set_name + "만든이 닉네임: " + m_nickname);
		var url = "quizcard.do";
		url = url + "?quizcard_category=" + quizcard_category;
		url = url + "&quizcard_set_name=" + quizcard_set_name;
		url = url + "&m_nickname=" + m_nickname;
		location.href = url; 
	})
	
	// "~몇 건씩 보기(selexbox) 이벤트 정의"
	function page(Paging){
		// selectBox이기 때문에 클릭해서 옵션을 변경할 때마다 이벤트가 일어나도록 onChange()이벤트를 명시함. 기본값은 1이다.
		var startPage = Paging; 
		var listSize = $("#listSize option:selected").val();
		if(listSize == 10){
			var url = "quizcard.do?startPage="  + startPage + "&listSize=" + listSize;
		} else if(listSize == 15){
			var url = "quizcard.do?startPage="  + startPage + "&listSize=" + listSize;
		} else if(listSize == 20){
			var url = "quizcard.do?startPage="  + startPage + "&listSize=" + listSize;
		}
		location.href= url;
	}
	
	// 페이징 박스 fn 이벤트 정의. 페이징정보4개 파라미터와 search타입의 필드 3개(category, set_name, nickname)
	function fn_prev(page, range, rangeSize, listSize, quizcard_category, quizcard_set_name, m_nickname){
		var page = ((range - 2) * rangeSize) + 1; 
		var rnage = range - 1;
		var url = "quizcard.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize="  + listSize;
		url = url + "&quizcard_category=" + quizcard_category;
		url = url + "&quizcard_set_name=" + quizcard_set_name;
		url = url + "&m_nickname=" + m_nickname;
		location.href= url;
	}
	
	function fn_pagination(page, range, rangeSize, listSize, quizcard_category, quizcard_set_name, m_nickname){
		var url = "quizcard.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&quizcard_category=" + quizcard_category;
		url = url + "&quizcard_set_name=" + quizcard_set_name;
		url = url + "&m_nickname=" + m_nickname;
		location.href = url;
	} 
	
	function fn_next(page, range, rangeSize, listSize, quizcard_category, quizcard_set_name, m_nickname){
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "quizcard.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&quizcard_category=" + quizcard_category;
		url = url + "&quizcard_set_name=" + quizcard_set_name;
		url = url + "&m_nickname=" + m_nickname;
		location.href = url;
	}
	
	
	// 검색 항목 초기화 버튼
    $(".searchResetBtn").on("click", function(){
        $("#searchFrm")[0].reset();
        $('.categoryDirectInput').css('display', 'none');
        $('.searchCategoryInput').css("width","80%").css("height", "80%");
    })

    // selextbox 직접입력칸 구현 이벤트
    $(".searchCategoryInput").on("change", function(){
        if( $(".searchCategoryInput").val() === "DIRECT" ){
            $('.categoryDirectInput').css('display', 'block').css("display", "inline-block");
            $('.searchCategoryInput').css("width","80px").css("height", "100%");
        } else {
            $('.categoryDirectInput').css('display', 'none');
             $('.searchCategoryInput').css("width","80%").css("height", "80%");
        }
    })
</script>
<script>
	//회원이메일 (현재 header영역에서 const식별자로 정의되어 있는 상태.)
	var m_email = $("#session_user").val();
	console.log("현재 로그인 계정 조회: " + m_email);

	// 퀴즈카드 before페에지로 이동	
	$(".quizcardTable td:nth-child(4)").on(
			"click",
			function() {
				var setNo = $(this).parent().find("td").eq(0).text();
				location.href = "quizcardBefore.do" + "?set_no=" + setNo
						+ "&m_email=" + m_email;
			})

	// 리스트에 마우스 올라가면 배경색상이 변경되도록
	$(".quizcardTable > tbody > tr").on({
		mouseover : function() {
			$(this).css("backgroundColor", "#E8F5FF")
		},
		mouseout : function() {
			$(this).css("backgroundColor", "white");
		}
	})

	// 사용자 정보 조회하는 모달창 관련 스크립트 부분(공통영역)  ------------------------- 작업 끝나고 밑으로 내려보내기
	$(".quizcardTable td:nth-child(6)").on("click", function(e) {
				console.log("유저 닉네임 클릭");
				let email;
				console.log($(e.target).text());
				$("body").css("overflow", "hidden"); // 모달창 호출 => body영역 스크롤 방지
				$(".userInfo_modal_container").css("display", "block");
				var sendNickname = $(e.target).text();
				// 첫 번째 ajax로 프로필 정보(닉네임, 이메일, 가입날짜, intro + 프로필이미지 정보)		
				$.ajax({
					url : "ajaxUserInfo.do?m_nickname=" + sendNickname,
					type : "GET",
					dataType : "json",
					async : false,
					contentType : "application/json; charset=utf-8",
					success : function(data) {
						console.log("호출 성공");
						console.log(data);
						email = data.m_email;
						$("#m_nickname").val(data.m_nickname);
						$("#m_joindate").val(data.m_joindate);
						$("#userIntroForm").val(data.m_intro);
						$("#userInfoTitle")
								.html(data.m_nickname + " 님의 사용자 정보");
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
					},
					error : function(responseText) {
						console.log("호출 실패");
						console.log(responseText);
					}
				})
				
			// email값을 이용하여 get.JSON url을 호출하여 db에 있는 프로필 이미지 정보를 가져와서 화면에 뿌려준다.
			var uploadResult = $(".userInfo_image");
			$.getJSON("getAttachList.do", { m_email : email}, function(arr){
				let obj = arr[0];
				if(obj.uploadPath == null || obj.uploadPath == ''){
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
	})

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
						&& !$(e.target).hasClass('userInfoTd')) {
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
</html>