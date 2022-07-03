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
			<button>학습하기</button>
			<c:if test="${session_user eq qvo.m_email }">
				<button>수정/단어추가하기</button>
			</c:if>
		</div>
	</div>
</body>
</html>