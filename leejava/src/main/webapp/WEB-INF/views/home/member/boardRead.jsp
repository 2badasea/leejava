<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style type="text/css">
.mainFormWrapper{
	margin-left: 13%;
	margin-top: 1%;
	max-width: 1000px;
}
.boardFormTable{
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.boardFormTableThTr{
	border-bottom: 1px solid #05AA6D;
	background-color: lightgreen;
}
.boardFormTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
	border-bottom: 1px solid #05AA6D;
}
.boardFormTable td {
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D	;
	padding: 5px;
}
.boardTitle{
	border-style: none;
	width: 100%;
	height: 100%;
	font-size: 15px;
}
.boardTitle:focus {
	outline: none;
}
</style>
</head>
<body>
	<h2>1. 게시글을 조회할 때는 제목이나 내용과 같은 타이틀은 제외할 것.</h2> 
	<h2>2. 내용물만 조회하는 데 있어서 굳이 summernote cdn을 받아서 사용해야 하는지 알아볼 것.</h2>
	<h2>3. 현재 로그인한 세션값과 작성자가 동일하면 "수정하기" 버튼 활성화 시키기</h2>
	<h2>4. 첨부파일 목록 썸네일도 노출시킬지는 고민해보기</h2>
	<h2>5. 자유게시판 부터는 댓글기능이 활성화 되어야 한다 => restful 방식으로 RestControler를 통해서 관련된 기능 구현하기</h2>
	<h2>6. 추천수 올리기 버튼 구현해서 db상태 업데이트 하도록 구현하기. </h2>
<div class="boardWritingForm_wrapper">
		<div class="mainFormWrapper">
			<div align="center">
				<h2>게시글 작성</h2>
			</div>
			<br>
			<!-- 테이블 형식으로 제목과 내용, 그리고 첨부파일 업로드 칸을 구현한다. -->
			<form id="frm" action="boardInsert.do" method="post" enctype="multipart/form-data">
				<table class="boardFormTable">
					<tr class="boardTableThTr">
						<th width="150">제목</th>
						<td width="800">
							<input type="text" class="boardTitle" maxlength="50" placeholder="제목은 최대 50자 까지 작성할 수 있습니다.">
						</td>
					</tr>
					<tr class="boardTableThTr">
						<th>내용</th>
						<td>
							<textarea rows="" cols="" id="summernote" class="boardContents" ></textarea>
						</td>
					</tr>
					<tr class="boardTableThTr">
						<th>첨부파일</th>
						<td class="uploadFileTd">
							<!-- 다중 파일 업로드를 구현해야 한다.-->
						</td>
					</tr>
				</table>
			</form>
			<br>
			<div class="borarWritingBtns" style="float: right;">
				<button class="historyBackBtn">목록보기</button>
				<button class="boardWritingBtn">등록하기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 목록으로 돌아가기
	$(".historyBackBtn").on("click", function(){
		location.href = "boardList.do";
	})
</script>
</html>