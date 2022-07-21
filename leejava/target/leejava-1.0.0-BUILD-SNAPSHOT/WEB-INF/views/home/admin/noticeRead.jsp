<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
.noticeReadFormWrapper {
	margin-top: 15%;
	margin-left: 20%;
}
.noticeReadFormBtn {
	
}
.notice_content {
	height: 300px;
}

.notice_filename {
	
}
#noticeNo {
	width: 50px;
	border: none;
	text-align: center;
}

</style>
</head>
<body>
	<!-- 들어갈 목록: 작성자, 조회수, 글번호, 제목, 내용, 첨부, 작성일, 카테고리  -->
	<div class="Wrapper">
		<div class="noticeReadFormWrapper">
			<table border="1">
				<tr>
					<td width="150px;">
						<input id="noticeNo" value='<c:out value="${notice.n_no }" />' >
					</td>
					<td width="300px;">${notice.n_wdate }</td>
					<td width="250px;">${notice.n_writer }</td>
					<td width="120px;"><i class="fa-regular fa-eyes"></i>${notice.n_hit }</td>
				</tr>
				<tr>
					<td colspan="4" class="notice_title_section">
						<span class="notice_category">${notice.n_category }</span>
						<br> 
						<span class="notice_title">${notice.n_title }</span>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="notice_content">${notice.n_content }</td>
				</tr>
				<tr>
					<td class="notice_file">첨부파일</td>
					<td class="notice_filename" colspan="3">
						<a href="noticeFileDownload.do?filename=${notice.n_file }&pfilename=${notice.n_pfile }">${notice.n_file }</a>
					</td>
				</tr>
			</table>
			<br>
			<div class="noticeReadFormBtn">
				<button id="noticeReadFormUpdateBtn">수정하기</button>
				<button id="noticeReadFormBackBtn">목록보기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 첨부파일 
	
	// 수정하기 버튼
	$("#noticeReadFormUpdateBtn").on("click", function() {
		var no = $("#noticeNo").val();
		alert(no + " 번 글 수정하기 위해 이동");
		location.href = 'noticeFormUpdate.do?n_no='+ no;
	})

	// 돌아가기 버튼
	$("#noticeReadFormBackBtn").on("click", function() {
		history.back();
	})
	
</script>
</html>