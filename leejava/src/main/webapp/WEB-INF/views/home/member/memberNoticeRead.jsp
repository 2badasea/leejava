<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회</title>
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
#fileTag{
	color: black;
	text-decoration: none;
	margin-left: 20px;
	margin-top: 5px;
}
.fileTr{
	height: 40px;
}
#attachFileIcon{
	display: none;
}
#attachFileIcon:hover{
	cursor: pointer;
}
</style>
</head>
<body>
<!-- 공지사항 조회하는 폼 디자인 해야 함. -->
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
				<tr class="fileTr">
					<td class="notice_file">첨부파일</td>
					<td class="notice_filename" colspan="3">
						<div style="display: flex;">
							<i id="attachFileIcon" class="fa-solid fa-2x fa-file-arrow-down" onclick="noticeFileDownload('${notice.n_file }','${notice.n_pfile }')"></i>
							<a id="fileTag" href="noticeFileDownload.do?filename=${notice.n_file }&pfilename=${notice.n_pfile }">${notice.n_file }</a>
						</div>
					</td>
				</tr>
			</table>
			<br>
			<div class="noticeReadFormBtn">
				<button id="noticeReadFormBackBtn">목록보기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 이전 페이지로 돌아가는 버튼
	$("#noticeReadFormBackBtn").on("click", function(){
		console.log('뒤로가기 버튼 클릭');
// 		history.back(); 반영이 잘 안 되는 것 같다.
		location.href="userNoticeList.do";
	})
	
	// 첨부파일 아이콘 클릭해도 첨부파일 다운로드 되도록
	function noticeFileDownload(file, pfile){
		console.log("첨부파일명 확인: " + file + ", 물리파일명: " + pfile);
		location.href="noticeFileDownload.do?filename=" + file + "&pfilename=" + pfile;
	}
	
</script>
<script>
	$(document).ready(function(){
		var attachFileName = $("#fileTag").text();
		console.log("첨부파일 명 확인: " + attachFileName);
		if( attachFileName !== ""){
			$("#attachFileIcon").css("display", "block");
		}
	})	
</script>


</html>