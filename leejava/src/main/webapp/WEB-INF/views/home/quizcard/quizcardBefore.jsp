<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 대기 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
/* 퀴즈카드 학습모드 선택 모달창 */
.quizcardInfoWrapper {
	margin-top: 8%;
	margin-left: 3%;
}

.quizcardInfo {
    width: 35%;
}

.quizcardQuestion {
    margin-top: 5px;
}

.questionNameBox {
    width: 40%;
    height: 400px;
    background-color: #0A092D;
    color: white;
}

.questionName {
    font-size: x-large;
    font-weight: bolder;
}

.questionArrow {
    width: 35%;
    text-align: center;
    font-size: larger;
    font-weight: bolder;
}

.quizcardIntro {
    width: 40%;
}

.quizcardIntroArea {
    width: 95%;
    resize: none;
    border-radius: 20px;
    padding: 10px;
}

.quizcardReply {
    margin-top: 10px;
    border: 1px solid darkblue
}
.beforeA{
	color: black;
}
        
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
    background-color: 	#bebebe;
    opacity : 0.5;
    transition: 2s;
}

fieldset {
    border: 1px solid white;
}
.questionBtns{
	width: 40%;
	display: flex;
	justify-content: flex-end;
}
.questionBtns > button {
	margin-right: 10px;
	background-color: white;
	border-style: none;
	width: 120px;
    height: 40px;
    border-radius: 20px;
    font-size: 15px;
}
.questionBtns > button:hover{
	 cursor: pointer;
     background-color: teal;
     color: white;
     transition: 1s;
}
.bookmark{
	color: tomato;
}
#addStar{
	font-size: 25px;
	display: none;
}
#emptyStar{
	font-size: 25px;
	display: none;
}
.quizcardIntro img {
	width: 20px;
	height: 20px;
}
.setCreaterClickA{
	margin-left : 10px;
	color: teal;
}
</style>
</head>
<body>
<input type="hidden" id="quizcardBeforeSetNo" value="${qvo.quizcard_set_no }">
<div class="quizcardInfoWrapper">
        <div class="quizcardInfo">
            <h1>${qvo.quizcard_set_name }</h1>
            <p>
                <span id="category"><b>카테고리</b> -  ${qvo.quizcard_category }</span>&nbsp;&nbsp;
                <span><b>문제유형</b> - ${qvo.quizcard_type }</span>&nbsp;&nbsp;&nbsp;
                <br>
                <label for="bookmark"><b>즐겨찾기 여부</b></label>
                <a id="starClick" class="beforeA bookmark">
                	<i id="addStar" class="fa-solid fa-star add" ></i>
                	<i id="emptyStar" class="fa-regular fa-star empty"></i>
                </a>
                <br>
                <label for="quizcardDate" class="quizcardDate"><b>생성 날짜/마지막 업데이트</b></label>
                <span id="quizcardDate"class="quizcardDate">${qvo.quizcard_set_cdate } / ${qvo.quizcard_set_udate }</span>
            </p>
        </div>
        <div class="quizcardQuestion">
            <div class="questionNameBox">
                <p class="questionName"></p>
            </div>
            <br>
            <div class="questionArrow">
                <a class="prevQuestion beforeA"><i class="fa-solid fa-angle-left"></i></a>
                <span class="questionNo"></span> / <span>${quizcardQuestionCount }</span>
                <a class="nextQuestion beforeA"><i class="fa-solid fa-angle-right"></i></a>
            </div>
            <div class="questionBtns">
                <button id="quizcardStartBtn">학습하기</button>
                <input type="hidden" id="dataInput" data-setno="${qvo.quizcard_set_no }" data-questioncount="${quizcardQuestionCount }">
                <c:if test="${session_user eq qvo.m_email }">
				<button id="updateQuizcardBtn">수정 / 단어추가</button>
			</c:if>
            </div>
        </div>
        <br>
        <div class="quizcardIntro">
            <h3><b>퀴즈카드 만든이</b>  <a class="setCreaterClickA"><img src="resources/image/loopy.jpeg">${qvo.m_nickname }</a></h3>
            <textarea class="quizcardIntroArea" cols="30" rows="10" readonly="readonly">${qvo.quizcard_set_intro }</textarea>
        </div>
        <div class="quizcardReply">
            <p>댓글영역 추후 작업. 총 댓글 갯수:  ${quizcardReplyCount }</p>
        </div>
</div>
    <!-- 위에가 새로운 레이아웃 -->
	<!-- 퀴즈카드 학습모드 모달창 -->
      <div class="studyType_modal_container">
        <div class="studyType_modal_content">
            <div class="studyType_modal_header">
                <span id="modalHeader" data-setno="${qvo.quizcard_set_no }">선택한 세트번호: ${qvo.quizcard_set_no } </span>
                <button id="studyTypeCloseBtn" style="float: right; width: 20px; height: 20px;">X</button>
            </div>
            <br>
            <div class="studyType_modal_body">
                <fieldset>
                    <legend>학습방식</legend>
                    <input type="radio" id="order" name="studyType" value="order" checked>
                    <label for="order">순차형</label>
                    <input type="radio" id="random" name="studyType" value="random">
                    <label for="random">랜덤형</label>
                </fieldset>
            </div>
            <br>
            <div class="studyType_modal_footer">
                <button id="studyStartBtn">학습시작!</button>
            </div>
        </div>
        <div class="studyType_modal_layer"></div>
    </div>
</body>
<script>
	// 퀴즈카드 생성자 정보 호출 이벤트 => 다 정의하고 아래 script영역으로 옮기기
	$(".setCreaterClickA").on("click", function(e){
		console.log("유저 닉네임 클릭");
		console.log( $(e.target).text());
	})
</script>
<script>
	// 페이지가 로드되자마자 실행시킬 이벤트
	$(function(){
		var thisSetNo = $("#quizcardBeforeSetNo").val();
		var session_user = $("#session_user").val(); 
		
		console.log("세트번호: " + thisSetNo );
		// ajax로 호출 => 모든 문제를 배열에 담고 => 인덱스 생성 => prev, next 화살표 정의하기 
		$.ajax({
			url: "questionNameList.do",
			method: "GET",
			dataType: "JSON",
			contentType: "application/json; charset=utf-8",
			data: {
				quizcard_set_no : thisSetNo
			},
			success: function(data){
				console.log("호출 성공");
				questionNames(data);
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
		
		let questionNameList = [];
		var count = 0;
		
		function questionNames(data){
			console.log("함수questionNameList(data) 실행");
			console.log(data);
			$.each(data, function(index, item){
				questionNameList.push(item.quizcard_question_name);
			})
			console.log("배열조회: " + questionNameList);
			$(".questionNo").text(count + 1);
			$(".questionName").text( questionNameList[count] );
		}
		
		
		// 이전문제버튼, 다음문제 버튼  prevQuestion  nextQuestion
		$(".prevQuestion").on("click", function(){
			var number = $(".questionNo").text();
			console.log("현재 문제 번호: " + number);
			if(count === 0){
				return false;
			} else {
				count--;
				console.log("count값: " + count);
				$(".questionNo").text(count + 1);
				$(".questionName").text( questionNameList[count] );
			}
		})
		
		// 다음문제버튼 
		$(".nextQuestion").on("click", function(){
			console.log("문제 총 갯수: " + questionNameList.length);
			if( count === (questionNameList.length-1) ){
				return false;
			} else {
				count++;
				$(".questionNo").text(count+1);
				$(".questionName").text( questionNameList[count] );
			}
		})
		
		// 즐겨찾기 상태여부에 따른 별표 활성화 ajax로 조회. 
		$.ajax({
			url: "ajaxBookmarkStatus.do",
			method: "GET",
			data: {
				quizcard_set_no : thisSetNo,
				m_email : session_user
			},
			success: function(responseText){
				console.log("즐겨찾기 호출 성공");
				console.log(responseText);
				if(responseText === "NO"){
					$("#emptyStar").css("display", "block");
					$("#addStar").css("display", "none");
				} else if(responseText === "YES"){
					$("#emptyStar").css("display", "none");
					$("#addStar").css("display", "block");
				}
			},
			error: function(responseText){
				console.log("즐겨찾기 호출 실패");
				console.log(responseText);
			}
		})
		
	})
</script>
<script>
	// 학습모드 선택 모달창 활성화
	$("#quizcardStartBtn").on("click", function(){
		$(".studyType_modal_container").css("display", "block");
	})
	
	// 학습시작 버튼
	$("#studyStartBtn").on('click', function(){
		// 세트번호와 학습방식의 값을 날린다. 
		var setNo = $("#modalHeader").data("setno");
		var studyType = $("input[name='studyType']:checked").val();
		console.log("선택한 세트번호: " + setNo);
		console.log("선택한 학습모드: " + studyType);
		// 두 값을 컨트롤러를 통해 페이지에 넘긴다. 그리고 해당 페이지에서 restController를 통해 작업!
		location.href="studyStart.do?setNo=" + setNo + "&studyType=" + studyType;
	})
	
	
	// 학습모드 선택 창닫기
	$("#studyTypeCloseBtn").on("click", function(){
		$(".studyType_modal_container").css("display", "none");
	})
	
	// 모달창 외부영역 클릭 => 모달창 비활성화
	$(document).on("click", ".studyType_modal_layer", function(e){
		if( !$(e.target).hasClass("studyType_modal_content") ) {
			$(".studyType_modal_container").css("display", "none");
		}
	})
	
	// 퀴즈카드 수정페이지 이동 ( by 생성자)
	$("#updateQuizcardBtn").on("click", function(){
		// quizcard_set_no값과 해당 세트번호의 문제갯수를 날린다.
			// 문제갯수의 경우 컨트롤러에서 또 쿼리문을 조회하긴 번거롭기 때문. 
		// hidden타입의 input태그(id=dataInput)에 세트번호와 문제갯수를 부여함
		var setNo = $("#dataInput").data("setno");
		console.log("세트번호: " + setNo);
		var questionCount = $("#dataInput").data("questioncount");
		console.log("해당 세트의 문제 갯수: " + questionCount);
		
		var check = confirm("해당 퀴즈카드를 수정하시겠어요?");
		if(check){
			location.href="updateQuizcard.do?set_no="+setNo + "&questionCount=" + questionCount;
		} else {
			return false;
		}
		
	})
	
	// 즐겨찾기 추가/취소.
	$("#starClick").on("click",function(e){
		var userEmail = $("#session_user").val();
		var thisSetNo = $("#quizcardBeforeSetNo").val();
		// 클릭했을 때 별표의 class값에 따라 취소인지 아닌지 여부 판단 empty면 insert 아니면 delete // ajax두 번 호출? 
		var b = $(e.target).hasClass("empty");
		if(b){
			// trun인 경우, 즉 비어있는 경우 => insert시킨다. 
			$.ajax({
				url: "ajaxBookmarkAdd.do",
				type: "POST",
				data: {
					m_email : userEmail,
					quizcard_set_no : thisSetNo
				},
				success: function(responseText){
					console.log("호출 성공");
					alert("즐겨찾기에 추가되었습니다.");
					console.log(responseText);
					if(responseText === "OK"){
						$("#emptyStar").css("display", "none");
						$("#addStar").css("display", "block");
					}
				},
				error: function(responseText){
					console.log("호출 실패");
					console.log(responseText);
				}
			})
		} else {
			// empty속성이 없는 경우 => 이미 즐겨찾기 추가된 상태 => delete시키기.
			$.ajax({
				url: "ajaxBookmarkDelete.do",
				type: "POST",
				data : {
					m_email : userEmail,
					quizcard_set_no : thisSetNo
				},
				success: function(responseText){
					console.log("호출 성공");
					console.log(responseText);
					alert("즐겨찾기가 취소되었습니다.");
					if(responseText === "OK"){
						$("#emptyStar").css("display", "block");
						$("#addStar").css("display", "none");
					}
				},
				error: function(responseText){
					console.log("호출 실패");
					consoel.log(responseText);
				}
			})
		}	
		
		
	})
	
</script>
</html>