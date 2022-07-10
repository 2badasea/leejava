<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.questionForm {
	margin-top : 10%;
	margin-left: 10%;
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
				<button>스크랩</button>
			</div>
			<div class="questionBody">
				<!--문제/힌트/답안-->
				<div class="questionTitleForm">
					<h4 class="questionName"></h4>
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
</body>
<script>
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
				$("#questionOrderList").text("< " + (questionIndex+1) + " / " + questionCount + " > ");
			},
			error : function(data) {
				console.log("통신 실패");
				console.log(data);
			}
		})
		
		// 다음문제 버튼 클릭 
		$("#nextQuestionBtn").on("click", function(){
			// 입력한 값이랑 비교하고 결과를 알려주고 다음 문제를 ajax로 다시 호출해서 페이지에 로딩한다
			if( $("#nextQuestionBtn").val() ==  $("#answerArea").val() ){
				console.log("정답!!");	
			} else {
				console.log("오답");
			}
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
						$("#questionOrderList").text("< " + (questionIndex+1) + " / " + questionCount + " > ");
					},
					error : function(data) {
						console.log("통신 실패");
						console.log(data);
					}
				})
			} else {
				var check = confirm("결과창으로 이동하시겠어요?");
				if(check){
					questionResult();
				}
			}
		})
		
		// 퀴즈카드 풀이 결과 이벤트
		function questionResult(){
			alert("수고하셨습니다.");
			// 모달창 띄워주고 풀이 결과에 대한 내용 화면에 출력시킨다.
			var m_email = $("#session_user").val();
			location.href="quizcardBefore.do?set_no=" + setNo  + "&m_email=" + m_email;
		}
		
		
	})
	
	
</script>
</html>