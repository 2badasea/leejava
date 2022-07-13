<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style type="text/css">
.questionForm {
	margin-top : 8%;
	margin-left: 10%;
	margin-right: 10%;
	padding: 50px;
	border: 2px solid teal;
	border-radius: 20px; background-color : white;
	color: #05AA6D;
	background-color: white;
}

.questionBody {
	display: flex;
}

.questionHint {
	padding: 10px;
	margin-left: 20%;
	display: none; 
	z-index: 3;
	background-color: teal;
	color: white;
	position: absolute;
}

textarea {
	resize: none;
	width: 100%;
	height: 90%;
}

.openHint {
	width: 40px;
	height: 40px;
	margin-left: 10px;
	margin-right: 10px;
	margin-top: 40px;
}
.questionTitleForm,
.questionAnswer{
	border: 0.5px solid teal;
	border-radius: 15px;
	padding: 10px;
	width: 45%;
	height: 250px;
}
.timerView{
	color: tomato;
	font-weight: bolder;
	font-size: 20px;
	display: flex;
	justify-content: center;
}
/* 학습 결과 모달창*/
.result_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.result_modal_content {
    position: absolute;
    top: 25%;
    left: 25%;
    min-width: 700px;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.result_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: teal;
    opacity: 0.3;
    transition: 2s;
}
.wrongNumbers:hover{
	cursor: pointer;
}
.wrongNumbers{
	text-decoration: none;
   display: inline-block;
   color: tomato;
   -webkit-transition: 0.5s;
   -moz-transition: 0.5s;
   -o-transition: 0.5s;
   -ms-transition: 0.5s;
   transition: 0.5s;
}

.wrongNumbers:hover {
    -webkit-transform: scale(1.5,1.5);
    -moz-transform: scale(1.5,1.5);
    -o-transform: scale(1.5,1.5);
    -ms-transform: scale(1.5,1.5);
    transform: scale(1.5,1.5);
}
.wrongQuestionsBox{
	display: none;
	z-index: 10;
	position: relative;
	background-color: white;
	border: 0.5px solid #05AA6D;
    border-radius: 30px;
    width: 800px;
}
.wrongQuestionBody{
	padding: 10px;
}
.wrongQuestionHint{
	display: none;
}
.addScrapBtn{
	float: right;
	width: 100px;
	margin-top: 15px;
	margin-right: 20px;
}
.resultCloseBtn{
	width: 100px;
	margin-top: 15px;
	margin-right: 20px;
}
.quizcard_modal_footer{
	float: right;
}
#heart{
	font-size: 25px;
	color: tomato;
	margin-left: 5px;
}
</style>
</head>
<body>
	<input type="hidden" id="questionInfo" data-setno="${setNo }"
		data-studytype="${studyType }" data-count="${questionCount }">
	
	<div class="questionFormWrapper">
		<!-- 문제 폼 영역  -->
		<div class="questionForm">
			<div class="questionHeader">
				<h4>헤더 영억. 더 필요한 거 있으면 추가하도록</h4>
				<span class="timerView"></span>
			</div>
			<br>
			<div class="questionBody">
				<!--문제/힌트/답안-->
				<div class="questionTitleForm">
					<h4 class="questionName" data-quizcardno=""></h4>
					<textarea name="" id="questionArea" cols="50" rows="10" readonly="readonly"></textarea>
				</div>
				<button class="openHint">힌트보기</button>
				<div class="questionHint">
					<h4>힌트</h4>
					<textarea name="" id="hintArea" cols="50" rows="10" readonly="readonly"></textarea>
					<br>
					<button class="closeHintBtn">닫기</button>
				</div>
				<div class="questionAnswer">
					<h4>답안</h4>
					<textarea name="" id="answerArea" cols="50" rows="10"></textarea>
				</div>
			</div>
			<div class="questionFooter">
				<br>
				<h3 id="questionOrderList"></h3>
				<br>
				<button id="nextQuestionBtn">다음문제</button>
				<button id="studyEndBtn">학습종료</button>
				<!--진행중인문제번호/총문제수,  다음문제버튼, 종료버튼,-->
			</div>
		</div>
		
	</div>
	<!------------------- 학습결과 모달창------ ----------------->
	 <div class="result_modal_container">
        <div class="result_modal_content">
            <div class="quizcard_modal_header">
            	<span class="studyInfo"></span>
            	<br>
                <span class="studyScore"></span>&nbsp;&nbsp;&nbsp;
                &lt;<span class="studyTime"></span>&gt;
            </div>
            <div class="quizcard_modal_body">
            	<b>틀린 문제 리스트 (클릭하시면 해당 문제를 조회할 수 있습니다.)</b>
                <br>
                <span class="wrongQuestions"></span>
                <!-- 아래가 틀린문제 클릭했을 때 호출되는 창 -->
		        <div class="wrongQuestionsBox">
					<div class="wrongQuestionHeader">
						<button class="addScrapBtn">문제 스크랩</button>
					</div>
					<div class="wrongQuestionBody">
						<!--문제/힌트/답안-->
						<div class="wrondQuestionTitleForm">
							<h4 class="wrongQuestionName" data-quizcardno="" data-quizcardindex=""></h4>
							<textarea name="" id="wrongQuestionArea" cols="50" rows="10" readonly="readonly"></textarea>
						</div>
						<br>
						<button class="wrongOpenHint">힌트보기</button>
						<div class="wrongQuestionHint">
							<h4>힌트</h4>
							<textarea name="" id="wrongHintArea" cols="50" rows="10" readonly="readonly"></textarea>
							<br>
							<button class="wrongHintBtn">닫기</button>
						</div>
						<br>
						<div class="wrongQuestionAnswer">
							<h4>답안</h4>
							<textarea id="wrongAnswerArea" cols="50" rows="10" readonly="readonly"></textarea>
						</div>
					</div>
		        </div>
            </div>
            <br>
            <div class="quizcard_modal_footer">
            	<div class="likeDiv">
            		<a id="likeClickA" style="color: black;">
	            	<label for="heart">좋아요</label>
	            	<i id="heart" class="fa-solid fa-heart"></i>
	            	</a>
            	</div>
            	<div>
                	<button class="resultCloseBtn">학습종료</button>
                </div>
            </div>

        </div>
        <div class="result_modal_layer"></div>
    </div>
</body>
<script>
	// 좋아요 클릭
	$("#likeClickA").on("click", function(){
		var userEmail = $("#session_user").val();
		var setNo = $("#questionInfo").data("setno");
		console.log("이메일: " + userEmail + ", 세트번호: " + setNo);
		$.ajax({
			url: "ajaxLikeitAdd.do",
			method: "POST",
			data: {
				m_email : userEmail,
				quizcard_set_no : setNo
			},
			success: function(message){
				console.log("호출 성공");
				console.log(message);
				if(message === "YES"){
					alert("좋아요가 추가되었습니다.");
				} else if (message === "EXIST"){
					alert("이미 좋아요를 누른 세트입니다.");
				} else {
					alert("요청하신 처리가 실패하였습니다. 관리자에게 문의해주세요");
				}
			}, 
			error: function(message){
				console.log("호출 실패");
				console.log(message);
			}
		})
		
	})

	// 이벤트에 관한 이벤트들 정리 후 밑으로 보내기 
	$(".openHint").on("click", function(){
		console.log("힌트클릭");
		$(".questionHint").css("display", "block");
	})
	
	// 힌트 닫기
	$(".closeHintBtn").on("click", function(){
		$(".questionHint").css("display", "none");
	})
	
	// 외부영영 클릭 힌트 닫기
	$(document).on("click", function(e){
		if( $(e.target).closest(".questionHint").length === 0 && !$(e.target).hasClass("openHint")){
			$(".questionHint").css("display", "none");
		}
	})
	
	// timer 작동  (결과는 class="timerView")
	var min = 0;
	var sec = 0;
	startTimer(min,sec); 
	
	var timer;
	function startTimer(min,sec){
			timer = setInterval(function () {
            sec++;
            if (sec == 60) {
                min++;
                sec = 0;
            }
            resultView(min, sec);
        }, 1000)
	}
	
	function resultView(min,sec){
		sec = sec < 10 ? '0' + sec : sec;
        min = min < 10 ? '0' + min : min;
        var str = min + " : " + sec;
        $(".timerView").html(str);
	}
	
	
</script>
<script>
	$(document).on("ready", function() {
		const setNo = $("#questionInfo").data("setno");
		const studyType = $("#questionInfo").data("studytype");
		const questionCount = $("#questionInfo").data("count");
		console.log("컨트롤러에서 넘어온 세트번호: " + setNo);
		console.log("컨트롤러에서 넘어온 스터디타입: " + studyType);
		console.log("컨트롤러에서 넘어온 문제 갯수: " + questionCount);
		
		// 문제번호 순서 리스트 생성
		const questionList = [];
		if (studyType === "random") {
			// 선택한 것이 랜덤 배열인 경우.
			while (true) {
				var num = Math.floor(Math.random() * questionCount) + 1;
				if (questionList.indexOf(num) === -1) {
					questionList.push(num);
				}
				if (questionList.length === questionCount) {
					break;
				}
			}
		} else if (studyType === "order") {
			for (var i = 1; i <= questionCount; i++) {
				questionList.push(i);
			}
		}
		console.log("생성된 배열 조회: " + questionList);
		var questionIndex = 0;
		var quizcard_question_no = questionList[questionIndex];
		// ajax로 setNo와 문제번호 리스트의 첫 번째 값을 넘겨서 해당 데이터를 호출한다.

		$.ajax({
			url : "ajaxStudyStart.do",
			data : {
				quizcard_set_no : setNo,
				quizcard_question_no : quizcard_question_no
			},
			dataType : "JSON",
			method : "GET",
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				console.log("ajax 통신 성공");
				// json타입으로 데이터가 넘어옴.
				console.log(data);
				$("#questionArea").val(data.quizcard_question_name);
				$("#nextQuestionBtn").val(data.quizcard_question_answer);
				$("#hintArea").val(data.quizcard_question_hint);
				$(".questionName").text(questionIndex+1+ "번 문제   " + " (#" + data.quizcard_no + ")");
				$(".questionName").data("quizcardno", data.quizcard_no);
				$("#questionOrderList").text("< " + (questionIndex+1) + " / " + questionCount + " > ");
			},
			error : function(data) {
				console.log("통신 실패");
				console.log(data);
			}
		})
		
		// 맞힌 문제 카운팅
		let correctCount = 0;
		let wrongQuestionList= [];
		
		// 다음문제 버튼 클릭 
		$("#nextQuestionBtn").on("click", function(){
			// 입력한 값이랑 비교하고 결과를 알려주고 다음 문제를 ajax로 다시 호출해서 페이지에 로딩한다
			if( $("#nextQuestionBtn").val() ==  $("#answerArea").val() ){
				console.log("정답!!");	
				correctCount++;
			} else {
				console.log("오답");
				wrongQuestionList.push( $(".questionName").data("quizcardno"));
				// 오답인 문제번호는 별개로 결과창 modal에서 어떻게 구현할지? => 결과창 modal에서 display:none으로 숨겨놓기.
			}
			
			// 답안 작성 공간 초기화
			$("#answerArea").val('');
			
			console.log("문제 총 갯수: " + questionCount);
			console.log("현재 문제번호: " + (questionIndex+1));
			
			// 다음 문제 인덱스번호.
			if( questionCount > questionIndex+1){
				questionIndex = questionIndex + 1;
				console.log( questionList[questionIndex] );
				quizcard_question_no = questionList[questionIndex];
				
				$.ajax({
					url : "ajaxStudyStart.do",
					data : {
						quizcard_set_no : setNo,
						quizcard_question_no : quizcard_question_no
					},
					dataType : "JSON",
					method : "GET",
					contentType : "application/json; charset=utf-8",
					success : function(data) {
						console.log("ajax 통신 성공");
						// json타입으로 데이터가 넘어옴.
						console.log(data);
						$("#questionArea").val(data.quizcard_question_name);
						$("#nextQuestionBtn").val(data.quizcard_question_answer);
						$("#hintArea").val(data.quizcard_question_hint);
						$(".questionName").text(questionIndex+1+ "번 문제   " + " (#" + data.quizcard_no + ")");
						$(".questionName").data("quizcardno", data.quizcard_no);
						$("#questionOrderList").text("< " + (questionIndex+1) + " / " + questionCount + " > ");
					},
					error : function(data) {
						console.log("통신 실패");
						console.log(data);
					}
				})
			} else {
				clearTimeout(timer);
				var check = confirm("결과창으로 이동하시겠어요?");
				if(check){
					questionResult();
				}
			}
		})
		
		// 퀴즈카드 풀이 결과 이벤트
		function questionResult(){
			alert("수고하셨습니다.");
			console.log("총 맞힌 갯수: " + correctCount);
			console.log("틀린 문제 리스트: " + wrongQuestionList); 
			// 모달창 호출 이후 => 외부영역 스크롤 금지. (모달창 닫기 이벤트이후에도 추가해주어야 함)
			$("body").css("overflow", "hidden");
			$(".result_modal_container").css("display", "block");
			var str = "총 " + questionCount + " 문제 중 "+ correctCount + "개를 맞혔습니다.";
			$(".studyScore").text(str);
			var timerResult = "소요시간: " + $(".timerView").html();
			$(".studyTime").text(timerResult);
			var str2 = "[ ";
			for(var i = 0; i<wrongQuestionList.length; i++){
				str2 += " <a class='wrongNumbers' data-qno='" + wrongQuestionList[i] + "'>#" + wrongQuestionList[i] + "</a>  ";
			}
			str2 += " ]";
			$(".wrongQuestions").html(str2);
// 			var m_email = $("#session_user").val();
// 			location.href="quizcardBefore.do?set_no=" + setNo  + "&m_email=" + m_email;
		}
		
		// 틀린 문제 조회하기 
		$(document).on("click", ".wrongNumbers", function(e){
			console.log("클릭한 문제번호: " + $(e.target).data("qno"));
			var quizcard_no = $(e.target).data("qno");
			console.log("세트번호 조회: " + setNo);
			$(".wrongQuestionsBox").css("display", "block");
			// ajax호출 (quizcard_no로 문제 정보 호출)
			$.ajax({
				url: "ajaxWrongQuestion.do",
				type: "GET",
				data: {
					quizcard_set_no : setNo,
					quizcard_no : quizcard_no
				},
				dataType: "JSON",
				contentType: "application/json; charset=utf-8",
				success: function(data){
					console.log("호출 성공");
					console.log(data);
					$(".wrongQuestionName").text(data.quizcard_no + " 번 문제");
					$(".wrongQuestionName").data("quizcardno", data.quizcard_no);
					$(".wrongQuestionName").data("quizcardindex", data.quizcard_index);
					$("#wrongQuestionArea").val(data.quizcard_question_name);
					$("#wrongHintArea").val(data.quizcard_question_hint);
					$("#wrongAnswerArea").val(data.quizcard_question_answer);
				},
				error: function(data){
					console.log("호출 실패");
					console.log(data);
				}
			})
		})
		
		// 스크랩 기능
		$(".addScrapBtn").on("click", function(){
			console.log("스크랩 클릭");
			var quizcard_index = $(".wrongQuestionName").data("quizcardindex");
			console.log("인덱스값 조회: " + quizcard_index );
			var user = $("#session_user").val();
			console.log("사용자 아이디 조회: " + user);
			
			// ajax호출 업데이트. => 중복이면 중복이라고 alert창.
			$.ajax({
				url: "ajaxScrapAdd.do",
				type: "POST",
				data: {
					quizcard_index : quizcard_index,
					m_email : user
				},
				success: function(responseText){
					console.log("호출 성공");
					if(responseText === "NO"){
						alert("이미 스크랩한 문제입니다.");
						return false;
					} else if(responseText === "FAIL"){
						alert("진행 중 오류가 발생");
						return false;
					} else {
						alert(responseText);
					}
				},
				error: function(responseText){
					console.log("호출 실패");
					console.log(responseText);
				}
			})
		})
		
		
		// 결과 모달창 닫기 
		$(".resultCloseBtn").on("click", function(){
			$(".result_modal_container").css("display", "none");
			// 모달창 닫고 난 뒤 외부영역 스크롤 활성화
			$("body").css("overflow", "unset");
	 		alert("퀴즈세트 정보창으로 돌아갑니다.");
	 		var m_email = $("#session_user").val();
			location.href="quizcardBefore.do?set_no=" + setNo  + "&m_email=" + m_email;
		})
		
		// 틀린문제 조회 힌트창 열기
		$(".wrongOpenHint").on("click", function(){
			$(".wrongQuestionHint").css("display", "block");
		})
		
		// 틀린문제 조회 힌트창 닫기
		$(".wrongHintBtn").on("click", function(){
			$(".wrongQuestionHint").css("display", "none");
		})
		
		// 학습종료 버튼 구현. 
		$("#studyEndBtn").on("click", function(){
			console.log("학습 종료");
			var finishCheck = confirm("정말 종료하시겠어요?");
			if(finishCheck){
				var m_email = $("#session_user").val();
				location.href="quizcardBefore.do?set_no=" + setNo  + "&m_email=" + m_email;
			} else {
				return false;
			}
		})
		
		// 퀴즈카드 좋아요 버튼 클릭. 
		
	})
	
	
</script>
</html>