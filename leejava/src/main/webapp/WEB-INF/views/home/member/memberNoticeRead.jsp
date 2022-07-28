<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- summernote css/js-->
<script src="resources/js/summernote/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
<!-- 아래는 font-awesome의 아이콘을 적용시키기 위해 추가한 스크립트 부분 -->
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
.noticeTableWrapper {
	margin-top: 15%;
	margin-left: 20%;
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
	<div class="memberNoticeRead_Wrapper">
		<div class="noticeTableWrapper">
			<table border="1">
				<tr>
					<td width="150px;">
						${notice.n_no }
					</td>
					<td width="300px;">${notice.n_wdate }</td>
					<td width="250px;">${notice.n_writer }</td>
					<td width="120px;"><i class="fa-regular fa-eyes"></i>${notice.n_hit }</td>
				</tr>
				<tr>
					<td colspan="4" class="notice_title_section">
						<span class="notice_category">${notice.n_category }</span>
						<br> 
						<span class="notice_title" >${notice.n_title }</span>
					</td>
				</tr>
				<tr style="height: 300px;">	
					<td colspan="4" class="noticeContentTr">
						${notice.n_content }
					</td>
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
		// 뒤로 가기 메소드를 활용. 
		history.back(); 
	})
	
	// 첨부파일 아이콘 클릭해도 첨부파일 다운로드 되도록
	function noticeFileDownload(file, pfile){
		console.log("첨부파일명 확인: " + file + ", 물리파일명: " + pfile);
		location.href="noticeFileDownload.do?filename=" + file + "&pfilename=" + pfile;
	}
	
	// 툴바 환경설정
	var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];  
	
	var setting = {
	        height : 300,
	        width: 840,
	        minHeight : null,
	        maxHeight : null,
	        focus : true,
	        lang : 'ko-KR',
	        toolbar : toolbar,
	        callbacks : { //여기 부분이 이미지를 첨부하는 부분
	        onImageUpload : function(files, editor,
	        welEditable) {
	        for (var i = files.length - 1; i >= 0; i--) {
	        uploadSummernoteImageFile(files[i],
	        this);
	        		}
	        	}
	        }
	     };
    $('.summernote').summernote(setting);
</script>
<script>	
	$(function(){
		var attachFileName = $("#fileTag").text();
		console.log("첨부파일 명 확인: " + attachFileName);
		if( attachFileName !== ""){
			$("#attachFileIcon").css("display", "block");
		}
	})
</script>
</html>