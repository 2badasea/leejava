<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 대기 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
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
            background-color: 	#bebebe;
            opacity : 0.5;
            transition: 2s;
        }

        fieldset {
            border: 1px solid white;
        }
        /* 퀴즈카드 학습모드 선택 모달창============================ */
</style>
</head>
<body>
	<h2>${session_user }</h2>
	<div align="center" style="margin-top: 150px;">
		<table class="tempTable" border="1">
			<tr>
				<th>세트번호</th>
				<td>${qvo.quizcard_set_no }</td>
			</tr>
			<tr>
				<th>세트이름</th>
				<td>${qvo.quizcard_set_name }</td>
			</tr>
			<tr>
				<th>퀴즈카드 생성일</th>
				<td>${qvo.quizcard_set_cdate }</td>
			</tr>
			<tr>
				<th>마지막 업데이트</th>
				<td>${qvo.quizcard_set_udate }</td>
			</tr>
			<tr>
				<th>추천수</th>
				<td>${qvo.quizcard_set_likeit }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${qvo.quizcard_set_hit }</td>
			</tr>
			<tr>
				<th>소개글</th>
				<td>${qvo.quizcard_set_intro }</td>
			</tr>
			<tr>
				<th>접근권한</th>
				<td>${qvo.quizcard_set_status }</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>${qvo.quizcard_category }</td>
			</tr>
			<tr>
				<th>유형</th>
				<td>${qvo.quizcard_type }</td>
			</tr>
			<tr>
				<th>퀴즈카드생성자</th>
				<td>${qvo.m_email }</td>
			</tr>
			<tr>
				<th>생성자 닉네임</th>
				<td>${qvo.m_nickname }</td>
			</tr>
			<tr>
				<th>총 문제갯수</th>
				<td>${quizcardQuestionCount }</td>
			</tr>
			<tr>
				<th>총 댓글갯수</th>
				<td>${quizcardReplyCount }</td>
			</tr>
		</table><br>
		<div class="tempBtn">
			<button id="quizcardStartBtn">학습하기</button>
			<input type="hidden" id="dataInput" data-setno="${qvo.quizcard_set_no }" data-questioncount="${quizcardQuestionCount }">
			<c:if test="${session_user eq qvo.m_email }">
				<button id="updateQuizcardBtn">수정/단어추가하기</button>
			</c:if>
		</div>
	</div>
	
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
</script>
</html>