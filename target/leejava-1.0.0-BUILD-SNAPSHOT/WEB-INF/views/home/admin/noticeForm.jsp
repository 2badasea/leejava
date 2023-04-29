<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- summernote 사용 -->
<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style>
tr>th {
	text-align: center;
}

.mainFormWrapper {
	margin-left: 10%;
	margin-top: 5%;
}

input {
	width: 100%;
}

select {
	width: 100%;
}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="mainFormWrapper">
			<h3>공지사항 등록</h3>
			<!-- 공지사항 항목 구성( 카테고리, 제목, 내용, 첨부파일 -->
			<form action="noticeRegister.do" id="frm" method="post" enctype="multipart/form-data">
			<table border="1">
				<tr>
					<th style="width: 150px;">제목</th>
					<td style="width: 500px;"><input type="text" name="n_title" id="n_title">
					</td>
					<th style="width: 200px;">카테고리</th>
					<td style="width: 200px"><select name="n_category" id="n_category">
							<option selected="selected" value="all">전체</option>
							<option value="emergency">긴급</option>
							<option value="event">이벤트</option>
					</select></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="" cols="" name="n_content"
							id="summernote"></textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<input type="file" name="filename" id="n_file">
					</td>
				</tr>
			</table>
			</form>
			<div class="noticeRegisterBtns">
				<button id="noticeRegisterBtn">공지사항 등록</button>
				<button id="goBackBtn">돌아가기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 공지사항 등록 버튼 ( 제목 null인지 아닌지 체크, 내용은 무관 )
	$('#noticeRegisterBtn').on('click', function(){ 
		// 제목만 체크
		var noticeTitle = $("#n_title").val();
		if( noticeTitle === null) {
			alert("제목을 입력하세요");
			$("#n_title").focus(); 
			return false;
		}
		// 글내용도 not null로 해줘야 한다. 원활한 페이징 처리를 위해서.
		var noticeContent = $("#summernote").val();
		if( noticeContent === ""){
			alert("빈 내용은 공지사항 등록이 불가능합니다.");
			$("#summernote").focus();
			return false;
		}
		
		$("#frm").submit();
		
	})

	// 돌아가기 버튼 
	$("#goBackBtn").on("click", function(){ 
			location.href='adminNoticeList.do';
	});
	
	
	// 문서가 로드되면 서머노트 적용시키도록 
	$(document).ready(function() {
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
		
	  	// 객체형식으로 설정을 구성.
		var setting = {
	            height : 300,
	            minHeight : null,
	            maxHeight : null,
	            focus : true,
	            lang : 'ko-KR',
	            toolbar : toolbar, // toolbar 설정은 위에서 해놓음. 
	            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            	// summernote에서 제공하는 콜백함수 중 하나. onImageUpload
	            	onImageUpload : function(files, editor, welEditable) {
	            			for (var i = files.length - 1; i >= 0; i--) {
	            					uploadSummernoteImageFile(files[i], this);
	            			}
	            	}
	            }
	         };

	    $('#summernote').summernote(setting);
	  	
	  	// 이미지업로드 콜백함수 정의
	  	function uploadSummernoteImageFile(file, el) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "ajaxUploadSummernoteImageFile.do",  // 컨트롤러에서 처리해야 함
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(responseData) {
					console.log("responseData 확인: " + responseData);
					console.log("responseDate.url 확인: " + responseData.url);
					$(el).summernote('insertImage', responseData.url);
				}
			});
		}
	});
</script>
</html>