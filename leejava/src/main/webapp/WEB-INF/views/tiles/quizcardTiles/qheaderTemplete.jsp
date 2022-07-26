<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
header{
	display: flex;
	justify-content: space-around;
}
.leftHeader a,
.centerHeader a,
.rightHeader a{
	margin-left: 30px;
}
a:hover{
	cursor: pointer;
}
a{
text-decoration: none;
   display: inline-block;
   color: white;
   -webkit-transition: 0.5s;
   -moz-transition: 0.5s;
   -o-transition: 0.5s;
   -ms-transition: 0.5s;
   transition: 0.5s;
}

a:hover {
    -webkit-transform: scale(1.5,1.5);
    -moz-transform: scale(1.5,1.5);
    -o-transform: scale(1.5,1.5);
    -ms-transform: scale(1.5,1.5);
    transform: scale(1.5,1.5);
}
/* **************새로운 퀴즈카드 세트 모달창*************/
.quizcard_modal_container {
         position: fixed;
         top: 0px;
         bottom: 0px;
         width: 100%;
         height: 100vh;
         display: none; 
         z-index: 1;
}

.quizcard_modal_content {
    position: absolute;
    top: 30%;
    left: 35%;
    width: 25%;
    height: auto;
    z-index: 3;
    background-color: white;
    color: teal;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.quizcard_modal_layer {
    position: relative;
    width: 100%;
	height: 100%; 
    z-index: 2;
    background-color: #2E3856;
    opacity: 0.8;
    transition: 2s;
}

#category_direct {
    width: 120px;
}
#quizcard_set_intro{
	resize: none;
}
.archiveBox{
	border: 1px solid black;
	min-width: 550px;
	width: auto;
	min-height: 300px;
	height: auto;
	background-color: ghostwhite;
	color: black;
 	display: none; 
	margin-top: 40px;
	position: absolute;
}
.archiveBox a{
	color: black;
	font-weight: bolder;
}
.archiveHeader{
	padding: 10px;
}
.archiveTable{
	border: 1px solid gray;
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}
.archiveNameTd:hover{
	cursor: pointer;
}
.archiveTr{
	border-bottom: 1px solid black;
	height: 30px;
}
.archiveTh td{
	font-weight: 900;
	font-size: 17px;
	color: teal;
	border-bottom: 1px dashed teal;
}
/* 아카이브 박스 즐겨찾기 별표 모양*/
.addStar{
	color: orange;
}
.fa-xmark, .fa-xmark-large{
	color: tomato;
}
.scrapTd:hover {
	cursor: pointer;
}
/* ************* 스크랩 모달창 스타일 ************* */
.scrap_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.scrap_modal_content {
    position: absolute;
    top: 20%;
    left: 30%;
    width: 45%;
    height: auto;
    z-index: 3;
    background-color:  white;
    border: 0.5px solid teal;
    border-radius: 30px;
    padding: 20px;
}

.scrap_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: #2E3856;
    opacity: 0.8;
    transition: 2s;
}
.questionBox{
	margin-top: 10px;
    width: 95%;
    border-radius: 20px;
    padding: 10px;
    border: 1px solid teal;
}
.hidden{
    display: none;
}
.show{
    display: block;
}
.scrap_modal_content textarea{
    resize: none;
    border-radius: 20px;
    padding: 15px;
    color: teal;
    font-size: large;
    font-weight: bold;
}
.answerCheckBtn{
    display: block;
    margin: auto;
    margin-top: 10px;
}
.scrap_modal_content button {
    border-radius: 20px;
    width: auto;
    height: auto;
    font-weight: 900;
    color: teal;
    background-color:  whitesmoke;
    border-style: none;
    padding: 10px;
}
.scrap_modal_content button:hover{
    cursor: pointer;
    background-color: teal;
    color: whitesmoke;
    transition: 1s;
}
.hintBtn{
    margin-left: 15px;
    margin-right: 15px;
}
.scrapCloseBtn{
	min-width: 100px;
}
.inputAnswerReset,
.scrapSetNoA {
	color: teal;
}
.inputAnswerReset{
	border-style: none;
	border-radius: 20px;
	width: auto;
	padding: 5px;
	color: teal;
	background-color: whitesmoke;
	float: right;
	margin-bottom: -5px;
	margin-right: 15px;
}
.inputAnswerReset:hover {
	cursor: pointer;
	background-color: teal;
	color: whitesmoke;
	transition: 1s;
}
.quizcard_modal_body textarea {
	border-radius: 20px;
	padding: 10px;
	border: 0.5px solid teal;
	width: 80%;
}
.quizcard_modal_footer{
	display: flex;
	justify-content: center;
}

.quizcard_modal_footer button{
	border-radius: 20px;
 	background-color: whitesmoke;
 	color: teal;
 	border-style: none;
 	padding: 10px;
 	width: auto;
    height: auto;
    font-weight: 900;
}
.quizcard_modal_footer button:hover {
	cursor: pointer;
	color: whitesmoke;
	background-color: teal;
	transition: 1s;
}
.statusLabel{
	color: black;
}
</style>
</head>
<body>
<header>
	<div class="leftHeader">
		<a href="home.do"><span>홈가기</span></a>
		<a href="quizcard.do"><span>퀴즈카드 메인</span></a>
		<input type="hidden" id="session_user" value="${session_user }">
	</div>
	<div class="centerHeader" style="display: flex;">
			<!-- 여기에 실질적인 메뉴들 삽입 -->
			<a class="archiveBtn">아카이브↓</a>
			<div class="archiveBox">
				<div class="archiveHeader">
					<!-- 각각의 메뉴들에 대해서 클릭하면 ajax로 데이터를 추출해서 밑의 archiveBody에 붙인다. -->
					<a onclick="ajaxStudyingCard('${session_user }')" id="archiveStudyingA" class="archiveHeaderA">학습중인 세트</a>
					<a onclick="ajaxBookmarkCard('${session_user }')" class="archiveHeaderA">즐겨찾기</a>
					<a onclick="ajaxMyQuizcard('${session_user }')" class="archiveHeaderA">내가 만든</a>
					<a onclick="ajaxMyScrap('${session_user }')" class="archiveHeaderA">스크랩 문제</a>
				</div>	
				<hr>
				<div class="archiveBody">
					<!-- ajax 결괏값들이 들어갈 공간 -->
				</div>
			</div>	
			<a onclick="createNewQuizcard('${session_user}');"><span>새로 만들기</span></a>
	</div>
	<div class="rightHeader">
		<nav>
			<c:if test="${not empty session_user }"> 
				<a href="memberMyInfo.do"><span>마이페이지</span></a>		
			</c:if>	
			<c:if test="${empty session_user }">
				<a href="loginPage.do"><span>로그인하기</span></a>
			</c:if>
			<c:if test="${not empty session_user }">
				<a href="logout.do"><span>로그아웃</span></a>
			</c:if>
		</nav>
	</div>
</header>


<!-------- 퀴즈카드 새로 만들기 모달창 생성하기 ---------------------->
    <div class="quizcard_modal_container">
        <div class="quizcard_modal_content">
            <div class="quizcard_modal_header">
                <h3>New Quizcard</h3>
            </div>
            <br>
            <div class="quizcard_modal_body">
            	<form id="frm" action="createQuizcardSet.do"> <!--------------- form------------- -->
	                <label for="quizcard_set_name">세트 이름</label>
	                <input type="text" id="quizcard_set_name" name="quizcard_set_name">
	                <input type="hidden" id="session_user" value="${session_user}" name="m_email">
	                <input type="hidden" id="session_nickname" value="${session_nickname}" name="m_nickname">
	                <!--카테고리 3개 생성-->
	                <br>
	                <!--   is(":selected") 요소만 선발하기-->
	                <span>카테고리 선택</span>
	                <select id="quizcard_category_first" name="quizcard_category_first">
	                    <option value="ALL">모두 선택</option>
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
	                    <input type="text" style="display: none;" id="category_direct" name="">
	                <br>
	                <span>문제 유형 선택</span>
	                <select id="quizcard_type" name="quizcard_type">
	                	<option value="BOX" selected="selected">박스형</option>
	                	<option value="SHORT">주관식</option>
	                	<option value="SELECT">객관식</option>
	                </select>
	                <br>
	                <span>퀴즈카드 소개(설명)</span>
	                <br>
	                <textarea rows="7" cols="50" id="quizcard_set_intro" name="quizcard_set_intro"></textarea>
	                <br>
	                <!--여기는 readio박스-->
	                <span>공개여부</span>
	                <br>
	                <label for="public" class="statusLabel">공개</label>
                   	 	<input type="radio" name="quizcard_set_status" value="PUBLIC" id="public">
                    <label for="private" class="statusLabel">비공개</label>
                    	<input type="radio" name="quizcard_set_status" value="PRIVATE" id="private">
            	</form> <!--------------- form------------- -->
            </div>
            <br>
            <div class="quizcard_modal_footer">
                <button onclick="createNew()">생성생성!!</button>&nbsp;&nbsp;&nbsp;
                  <button id="quizcardCloseBtn">취소</button>
            </div>
        </div>
        <div class="quizcard_modal_layer"></div>
    </div>
<!-------------- 스크랩 문제 모달창 -------------- -->

     <div class="scrap_modal_container">
        <div class="scrap_modal_content">
            <div class="scrap_modal_header" align="center">
                  <span style="font-size: 25px;" class="scarpQuizcardNo"><b></b></span>
                  <br>
                  <span style="float: right;" class="scrapQuizcardSetNo"></span>
                  <br>	
                  <button class="nameBtn remoteBtn">문제 보기</button>
                  <button class="hintBtn remoteBtn">힌트 보기</button>
                  <button class="answerBtn remoteBtn">답안 보기</button>
            </div>
            <br>
            <hr>
            <div class="scrap_modal_body">
                <div class="sname questionBox">
                    <div class="snameEvent" style="display: flex; justify-content: space-around;">
                        <div>
                            <span>문제</span>
                            <br>
                            <textarea id="questionArea" cols="38" rows="15" readonly="readonly"></textarea>
                        </div>
                        <div>
                            <span>답안 입력</span>
                            <input type="button" class="inputAnswerReset" value="답안 초기화">
                            <br>
                            <textarea id="answerInputArea" cols="38" rows="15"></textarea>
                        </div>
                    </div>
                    <button class="answerCheckBtn">답안 체크</button>
                </div>
                <div class="shint questionBox" align="center">
                    <span>힌트</span>
                    <br>
                    <textarea id="hintArea" cols="50" rows="15" readonly="readonly"></textarea>
                </div>
                <div class="sanswer questionBox" align="center">
                    <span>답안</span>
                    <br>
                    <textarea id="answerArea" cols="50" rows="15" readonly="readonly"></textarea>
                </div>
            </div>
            <br>
            <div class="scrap_modal_footer">
                  <button style="float: right;" class="scrapCloseBtn">닫기</button>
            </div>
        </div>
        <div class="scrap_modal_layer"></div>
    </div>
</body>
<script>
	// 회원이메일 (세션갑승로 읽어들임 => 로그인을 하지 않은 상태라면 null이다.)
	var m_email = $("#session_user").val();

	// archiveBox 리스트 클릭 quizardInfo.jsp로 이동
	$(document).on("click", ".archiveNameTd", function(){
		var set_no = $(this).prev().text();
		console.log("퀴즈카드 세트번호 확인: " + set_no);
		location.href="quizcardBefore.do" + "?set_no=" + set_no + "&m_email=" +m_email ;
	})
		
	// 아카이브 박스 헤더 메뉴 클릭 이벤트
	$(".archiveHeaderA").on("click", function(){		
		$(".archiveHeader a").css("color", "black");
		$(this).css("color" , "teal");
	})
	
	// arhiveeTr에 mouseover, mouseleave 이벤트 주기
	$(document).on("mouseover", ".archiveTr", function(){
		$(this).css("backgroundColor", "#E8F5FF");
	})
	$(document).on("mouseleave", ".archiveTr", function(){
		$(this).css("backgroundColor", "unset");
	})
	
	// 스크랩 목록을 조회해서 archiveBox에 출력시키기
	function ajaxMyScrap(m_email){
		var m_email = m_email;
		var data = {
				m_email : m_email 
		};
		$(".archiveBody").empty();
		var tb = $("<table class='archiveTable' />");
		var th = $("<tr class='archiveTh' />").append(
				$("<td />").text("세트번호"),
				$("<td />").text("#문제번호"),
				$("<td />").text("세트이름"),
				$("<td />").text("카테고리"),
				$("<td />").text("     ")
				);  
		tb.append(th);
		$.ajax({
			url: "ajaxArchiveScrapSelect.do", 
			data: JSON.stringify(data),
			method: "POST",
			dataType: "json",
			contentType : "application/json; charset=utf-8",
			success: function(data){
				console.log('호출성공');
				console.log("데이터 길이: " + data.length);
				if(data.length !== 0){
					$.each(data, function(index, item){
						var $index = item.quizcard_index;
						var $setno = item.quizcard_set_no;
						var $qno = item.quizcard_no;
						var $name = item.quizcard_set_name;
						var $category = item.quizcard_category;
						var tr = $("<tr class='archiveTr' />").append(
							$("<td class='scrapTd' />").text($setno),
							$("<td class='scrapTd' />").text($qno),
							$("<td class='scrapTd' />").text($name),
							$("<td class='scrapTd' />").text($category),
							$("<td data-index='" + $index + "'/>").html('<a><i class="fa-solid fa-xmark scarpDelete"></i></a>')
						);
						tb.append(tr);
					})
					$(".archiveBody").append(tb);
				} else if(data.length === 0){
					// return되는 값이 null이라면 생성한 퀴즈카드가 없다고 출력시키기. 리턴되는 값이 json형태다. length속성으로 함. 
					var noResultCount = $(".noResult").length;
					if(noResultCount >=1){
						alert("스크랩한 문제가 없습니다.");
						return false;
					}
					var str = "<div class='noResult' style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
					str += "<span>스크랩한 문제가 없습니다.</span></div>";
			        $(".archiveBody").append(str);
					console.log("스크랩한 문제가 없습니다.");
				}	
			},
			error: function(message){
				console.log("호출 실패");
				console.log(message);
			}
		})
	}
	
	// 스크랩 리스트 클릭 => 모달창 호출. 
	$(document).on("click", ".scrapTd", function(e){
		 $('.scrap_modal_container').css("display", "block");
         $(".questionBox").addClass('hidden');
         $('.sname').removeClass('hidden');
         $("body").css("position", "fixed");
         $("body").css("overflow", "hidden");
         var quizcard_no = $(e.target).closest('tr').children().eq(1).text();
		 // 문제를 뿌려주는 이벤트를 별도로 정의(코드가 길어지기에)
		 questionSelectFn(quizcard_no);
	})
	
	// 스크랩 문제 출력시키는 함수 정의
	function questionSelectFn(quizcard_no){
		console.log("퀴즈카드 번호 확인: " + quizcard_no);
		// ajax 호출 (getMapping 사용. json.stringify() 사용X )
		$.ajax({
			url: "scrapQuestionSelect.do",
			data: {
				quizcard_no : quizcard_no
			},
			method: "GET",
			dataType: "json",
			contentType: "application/text; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				$(".scarpQuizcardNo").text("스크랩 문제 번호  #" + data.quizcard_no);
				$("#questionArea").val(data.quizcard_question_name);
				$("#hintArea").val(data.quizcard_question_hint);
				$("#answerArea").val(data.quizcard_question_answer);
				$(".scrapQuizcardSetNo").html("세트번호: " + "<a class='scrapSetNoA'>" + data.quizcard_set_no + "</a>");			
			},
			error: function(){
				console.log("호출 실패");
			}
		})		
	}
	
	// 아카이브 스크랩 문제를 출력하는 모달창에서 해당 문제의 퀴즈카드 세트로 이동
	$(document).on("click", ".scrapQuizcardSetNo", function(){
		console.log("세트 번호 클릭");
		var setNo = $(this).children().text(); 
		console.log("세트번호 조회: " + setNo);
		var email = $("#session_user").val();
		location.href="quizcardBefore.do?m_email=" + email + "&set_no=" + setNo;
	})
	
	
	// 스크랩 문제 답안 비교
	$(".answerCheckBtn").on("click", function(){
		var myAnswer = $("#answerInputArea").val();
		var answer = $("#answerArea").val();
		if(myAnswer === answer){
			alert("정답입니다.!!");
		} else {
			alert("답이 일치하지 않습니다.");
			$("#answerInputArea").focus();
		}
	})
	
	// 스크랩 문제 답안 작성폼 리셋
	$(".inputAnswerReset").on("click", function(){
		$("#answerInputArea").val('').focus();
	})
	
	// 스크랩문제 모달창 닫기
    $(".scrapCloseBtn").on("click", function(){
          $('.scrap_modal_container').css("display", "none");
          // 답안 입력창 초기화 시키기
          $("#answerInputArea").val(''); 
          $("body").css("position", "unset");
          $("body").css("overflow", "unset");
    })
    
    // 스크랩 모달창 내부 (문제, 힌트, 답안 영역 전환)
    $(".remoteBtn").on("click", function(){
        $(".questionBox").removeClass('show').addClass('hidden');
        if ( $(this).hasClass('nameBtn') ) {
            $(".sname").addClass('show');
        } else if( $(this).hasClass('hintBtn')){
            $(".shint").addClass('show');
        } else {
            $('.sanswer').addClass('show');
        }
    })
	
	// 아카이브 스크랩 영역. 스크랩 취소 아이콘 이벤트 (동적태그 이벤트 적용해야 함)
	$(document).on("click", ".scarpDelete", function(){
		var memail = m_email;
		var quizcard_index = $(this).closest('td').data('index');
		console.log("이메일 : " + memail + ",   인덱스 확인: " + quizcard_index);
		var check = confirm("스크랩을 취소할까요?");
		if(check){
			var data = {
					m_email : memail,
					quizcard_index : quizcard_index
			};
			$.ajax({
				url: "ajaxScrapDelete.do",
				data: JSON.stringify(data),
				method: "DELETE",
				dataType: "text",
				contentType: "application/json; charset=utf-8",
				success: function(message){
					console.log("호출 성공");
					alert(message);
					ajaxMyScrap(memail);
				},
				error: function(){
					console.log("호출 실패");
				}
			})
		} else {
			return false;
		}
	})
	
	// 학습중인 세트 목록 조회해서 archiveBox에 출력시키기. 
	function ajaxStudyingCard(m_email){
		var m_email = m_email;
		var quizcard_history = "학습중";
		var data = {
				m_email : m_email,
				quizcard_history : quizcard_history
		};
		$(".archiveBody").empty();
		var tb = $("<table class='archiveTable' />");
		var th = $("<tr class='archiveTh' />").append(
				$("<td />").text("카드번호"),
				$("<td />").text("카드이름"),
				$("<td />").text("카테고리"),
				$("<td />").text("마지막학습일"),
				$("<td />").text("진행상황")
				);
		tb.append(th);
		$.ajax({
			url : "ajaxHistorySelect.do",
			dataType: "json",
			contentType : "application/json; charset=utf-8",
			method : "POST",
			data : JSON.stringify(data),
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				console.log("데이터 길이: " + data.length);
				if(data.length !== 0){
					$.each(data, function(index, item){
						var $no = item.quizcard_set_no;
						var $name = item.quizcard_set_name;
						var $category = item.quizcard_category;
						var $date = item.quizcard_history_date;
						var $history = item.quizcard_history;
						var tr = $("<tr class='archiveTr' />").append(
							$("<td />").text($no),
							$("<td class='archiveNameTd' />").text($name),
							$("<td />").text($category),
							$("<td />").text($date),
							$("<td />").text($history)
						);
						tb.append(tr);
					})
					$(".archiveBody").append(tb);
				} else if(data.length === 0){
					// return되는 값이 null이라면 생성한 퀴즈카드가 없다고 출력시키기. 리턴되는 값이 json형태다. length속성으로 함. 
					var noResultCount = $(".noResult").length;
					if(noResultCount >=1){
						alert("학습중인 퀴즈카드가 없습니다.");
						return false;
					}
					var str = "<div class='noResult' style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
					str += "<span>학습중인 퀴즈카드가 없습니다.</span></div>";
			        $(".archiveBody").append(str);
					console.log("학습중인 퀴즈카드가 없습니다.");
				}	
			},
			error : function(message){
				console.log("호출 실패");
				console.log(message);
			}
		})
	}
	
	// Bookmark(즐겨찾기) 세트 조회해서 archiveBox에 출력시키기
	function ajaxBookmarkCard(m_email){
		$(".archiveBody").empty(); // 폼 안의 영역을 초기화 하고 리스트를 출력시킨다.
		console.log("이메일 확인: " + m_email);
		var tb = $("<table class='archiveTable' />");
		var th = $("<tr class='archiveTh' />").append(
				$("<td />").text("카드번호"),
				$("<td />").text("카드이름"),
				$("<td />").text("카테고리"),
				$("<td />").text("     ")
				);
		tb.append(th);
		$.ajax({
			url: "ajaxBookmark.do?m_email=" + m_email,
			type: "GET",
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data); 
				console.log("데이터 길이: " + data.length);
				if(data.length !== 0){
					$.each(data, function(index, item){
						var $quizcard_set_no = item.quizcard_set_no;
						var $quizcard_set_name = item.quizcard_set_name;
						var $quizcard_category = item.quizcard_category;
						var tr = $("<tr class='archiveTr' />").append(
							$("<td />").text($quizcard_set_no),
							$("<td class='archiveNameTd' />").text($quizcard_set_name),
							$("<td />").text($quizcard_category),
							$("<td />").html('<a><i class="fa-solid fa-star addStar" ></i></a>')
						);
						tb.append(tr);
					})
					$(".archiveBody").append(tb);
				} else if(data.length === 0){
					// return되는 값이 null이라면 생성한 퀴즈카드가 없다고 출력시키기. 리턴되는 값이 json형태다. length속성으로 함. 
					var noResultCount = $(".noResult").length;
					if(noResultCount >=1){
						alert("생성한 퀴즈카드가 없습니다.");
						return false;
					}
					var str = "<div class='noResult' style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
					str += "<span>즐겨찾기에 등록된 카드가 없습니다.</span></div>";
			        $(".archiveBody").append(str);
					console.log("아직 추가한 즐겨찾기가 없습니다.");
				}  
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		}) // ajax 끝
	} // function 이벤트 끝. 
	
	// 아카이브 박스 즐겨찾기(별표모양) 클릭 => 즐겨찾기 해제하기 
	$(document).on("click", ".addStar", function(){
		var memail = $("#session_user").val();
		var setNo = $(this).closest('tr').children().eq(0).text();
		var check = confirm("즐겨찾기를 해제하시겠어요?");
		if(check){
			$.ajax({
				url: "ajaxBookmarkDelete.do",
				data: {
					m_email : memail,
					quizcard_set_no : setNo
				},
				dataType: "text",
				method : "POST",
				success: function(message){
					console.log("호출 성공");
					if(message === "OK"){
						alert("즐겨찾기 목록에서 지워졌습니다.");
						ajaxBookmarkCard(memail);
					} else {
						alert("명령 처리 중 오류 발생. 관리자에게 문의하세요");
						return false;
					}
				}
			})
		} else {
			return false;
		}
	})
	

	// 내가 만든 세트 조회하기 
	function ajaxMyQuizcard(m_email){
		$(".archiveBody").empty();
		var m_email = m_email;
		
		var tb = $("<table class='archiveTable' />");
		var th = $("<tr class='archiveTh' />").append(
				$("<td />").text("카드번호"),
				$("<td />").text("카드이름"),
				$("<td />").text("생성일/수정일"),
				$("<td />").text("카테고리")
				);
		tb.append(th);
		$.ajax({
			url: "ajaxMyQuizcard.do",
			type: "GET",
			data: {
				m_email : m_email
			},
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(data){
				console.log("ajax수신 성공");
				console.log(data);
				console.log("데이터 길이: " + data.length);
				if(data.length !== 0){
					$.each(data, function(index, item){
						var $quizcard_set_no = item.quizcard_set_no;
						var $quizcard_set_name = item.quizcard_set_name;
						var $quizcard_set_cdate = item.quizcard_set_cdate;
						var $quizcard_set_udate = item.quizcard_set_udate;
						var $quizcard_category = item.quizcard_category;
						var tr = $("<tr class='archiveTr' />").append(
							$("<td />").text($quizcard_set_no),
							$("<td class='archiveNameTd' />").text($quizcard_set_name),
							$("<td />").html($quizcard_set_cdate + "<br>" + $quizcard_set_udate),
							$("<td />").text($quizcard_category)
						);
						tb.append(tr);
					})
					$(".archiveBody").append(tb);
				} else if(data.length === 0){
					// return되는 값이 null이라면 생성한 퀴즈카드가 없다고 출력시키기. 리턴되는 값이 json형태다. length속성으로 함. 
					var noResultCount = $(".noResult").length;
					if(noResultCount >=1){
						alert("생성한 퀴즈카드가 없습니다.");
						return false;
					}
					var str = "<div class='noResult' style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
					str += "<span>아직 생성한 퀴즈카드가 없습니다. </span></div>";
			        $(".archiveBody").append(str);
					console.log("아직 생성한 퀴즈카드가 없습니다.");
				}
			},
			error: function(data){
				var str = "<div style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
				str += "<span>아직 생성한 퀴즈카드가 없습니다. </span></div>";
		        $(".archiveBody").append(str);
				console.log("아직 생성한 퀴즈카드가 없습니다.");
			}
		})
	}
	
	// 아카이브 메뉴 클릭 => div박스 보여주기
	$(".archiveBtn").on("click", function(){
		if(m_email === ""){
			var check = confirm("회원들만 이용하실 수 있는 서비스입니다. 회원가입 하시겠어요?");
			if(check){
				location.href="memberJoinTerms.do";
			} else {
				return false;
			}
		} else{
			$(".archiveBox").toggle(function(){
				$(".archiveBox").css("display", "block");
			},function(){
				ajaxStudyingCard(m_email);
				$("#archiveStudyingA").css("color", "teal");
			}); 
		}
	})
	
	// 아카이브 외부 영역 ( 스크랩 모달창을 눌러도 안 사라지도록 )
	$(document).on("click", function(e){
		if( $(e.target).closest(".archiveBox").length == 0  && !$(e.target).hasClass("archiveBtn") 
				&& $(e.target).closest('.scrap_modal_container').length == 0 ){
			$(".archiveBox").css("display","none");
		}
	})
	
	// 퀴즈 set 생성 이벤트 
		// 여기서 기본적인 form값들 유효성 체크하고, frm.submit() 이벤트 호출하기
	function createNew(){
		// 세트명, 카테고리, 공개여부, 
		// name속성 있는 값들 확인   id) session_user,  quizcard_set_name, quizcard_category_first , name) quizcard_set_status
		var m_email = $("#session_user").val();
		console.log("m_email 확인: " + m_email);
		console.log("세트이름 확인: " + $("#quizcard_set_name").val());
		if( $("#quizcard_category_first").val() === "DIRECT"  ){
			 $("#quizcard_category_first").removeAttr('name');
			 $("#category_direct").attr('name','quizcard_category_first');
		}
		console.log("radio값 확인: " + $("input[name='quizcard_set_status']").val() );
		var introValue = $("#quizcard_set_intro").val();
		console.log("intro값: " + introValue);
		
		$("#frm").submit();
	}
	
	// modal창 <input> 간헐적으로 포커싱이 안 되는 에러
	$("#quizcard_set_name").on("click", function(){
		console.log( $(this) );
		$(this).focus();
	})
    
    // 퀴즈카드 생성 취소 버튼
    $("#quizcardCloseBtn").on("click", function () {
        alert("퀴즈카드 생성을 취소합니다");
        $("#frm")[0].reset();
        $(".quizcard_modal_container").css("display", "none");
    })
	
	
	// 카테고리 selectbox 직접입력 이벤트
	$("#quizcard_category_first").on("change", function () {
	    if ($("#quizcard_category_first").val() === "DIRECT") {
	        console.log("직접 입력 선택");
	        $("#category_direct").css("display", "block").focus();
	    } else {
	    	$("#category_direct").val();
	        $("#category_direct").css("display", "none");
	    }
	})

	// 퀴즈카드 "새로 만들기" 버튼.
	function createNewQuizcard(session_user){
		console.log("user값 확인" + session_user);
		if( !session_user){
			// 로그인 유도. 로그인 또는 회원가입 유도
			alert("회원만 이용할 수 있습니다.");
			var loginCheck = confirm("로그인 후 서비스를 이용하시겠어요?");
			if(loginCheck){
				location.href= "loginPage.do";
			} else {
				return false;
			}
		} else {
		    $(".quizcard_modal_container").css("display", "block");
		    $("#quizcard_set_name").focus();
		}
		
		// 세션이 있는 경우엔, 퀴즈세트 생성을 위한 모달창 호출
		if( $(".quizcard_modal_container").is(":visible") ){
			$("#quizcard_set_name").focus();
		}
	}
	
	// 새로만들기 외부 영역 클릭해도 모달창 비활성화 되도록
	$(document).on("click", ".quizcard_modal_layer", function(e){
		if( !$(e.target).hasClass("quizcard_modal_content")){
			alert("퀴즈카드 생성을 취소합니다");
	        $("#frm")[0].reset();
			$(".quizcard_modal_container").css("display", "none");
		}
	})
</script>
</html>