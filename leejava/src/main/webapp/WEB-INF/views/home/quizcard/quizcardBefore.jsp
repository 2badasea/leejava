<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 대기 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
</body>
<script>
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