<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- summernote 구현을 위한 CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 
 <!-- summernote 파일 3개 import -->
 <script src="${pageContext.request.contextPath }/resources/summernote/summernote-ko-KR.js"></script>
 <script src="${pageContext.request.contextPath }/resources/summernote/summernote-lite.js"></script>
 <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/summernote/summernote-lite.css"></link>
</head>
<body>
	<h1>관리자 테스트 게시판</h1>
	<div class="summernoteBox">
		<textarea id="summernote" class="summernote"></textarea>
	</div>
</body>
<script type="text/javascript">

$(document).on("ready", function(){
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
	    minHeight : null,
	    maxHeight : null,
	    focus : true,
	    lang : 'ko-KR',
	    toolbar : toolbar,
	    callbacks : { 
	    	onImageUpload : function(files, editor, welEditable) {
	    		for (var i = files.length - 1; i >= 0; i--) {
	   				 uploadSummernoteImageFile(files[i], this);
	    		}
	    	}
	    }
	 };

	 $('#summernote').summernote(setting);
});

function uploadSummernoteImageFile(file, el) {
	data = new FormData();
	data.append("file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "uploadSummernoteImageFile",
		contentType : false,
		enctype : 'multipart/form-data',
		processData : false,
		success : function(data) {
			$(el).summernote('editor.insertImage', data.url);
		}
	});
}
</script>
</html>