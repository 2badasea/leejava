<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
#noticeNumber {
	width: 50px;
	border: none;
	text-align: center;
	
}
.mainSearchWrapper {
	margin-left: 15%;
	margin-top : 20%;
}
.noticeListTitleTd:hover{
	cursor: pointer;
}
.noticeListTr:hover {
	background-color: #F0FFF0;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="mainSearchWrapper">
			<div class="noticeListWrapper">
				<h4>공지사항 리스트</h4>
				<span>(총 4건 중 4건)</span> <br>
				<div class="noticeList">
					<!--체크박스 공간,  글번호, 작성날짜, 카테고리, 제목, 상단 고정, 관리( 수정, 삭제, 고정or고정취소)  -->
					<table border="1">
						<tr>
							<th style="width: 50px;" class="listTh">글번호</th>
							<th style="width: 150px;" class="listTh">카테고리</th>
							<th style="width: 400px;" class="listTh">제목</th>
							<th style="width: 100px;" class="listTh">작성일</th>
							<th style="width: 100px;" class="listTh">작성자</th>
							<th style="width: 50px;" class="listTh">조회수</th>
						</tr>
						<c:forEach items="${notices }" var="notice">
							<tr class="noticeListTr">
								<td>${notice.n_no }
									<input class="noticeFixedTd" type="hidden" value="${notice.n_fixed }">
								</td>
								<td>${notice.n_category }</td>
								<td class="noticeListTitleTd" onclick="userNoticeRead(${notice.n_no}, ${notice.n_hit })">${notice.n_title }</td>
								<td>${notice.n_wdate }</td>
								<td>${notice.n_writer }</td>
								<td>${notice.n_hit }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	// 글제목 클릭 시 공지사항 조회할 수 있도록 하기
	function userNoticeRead(no, hit) {
		console.log("글번호 확인: " + no);
		console.log("조회수 확인: " + hit);
		location.href='userNoticeRead.do?n_no=' + no + '&n_hit='+hit;
	}	
	
</script>
<script>
	$(document).ready(function(){
		// 고정값이 T인 것은 문서가 로드되자마자 해당 tr행이 색깔을 다르게 표기한다.
		if( $('.noticeFixedTd').val() === "T"){
			$("input[value='T']").parent().parent().css('background',
			'#FFE6EB');
		}
	
		
	})
</script>
</html>