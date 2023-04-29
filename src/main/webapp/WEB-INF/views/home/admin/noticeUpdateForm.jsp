<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="resources/js/summernote/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
<style>
.mainFormWrapper {
	margin-left: 10%;
	margin-top: 5%;
}
.noticeFormTable {
	margin-top: 2%;
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.noticeFormTable tr{
	border-bottom: 1px solid #05AA6D;
}
.noticeFormTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
	text-align: center;
}
.noticeFormTable td{
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
}
#n_category,
#n_title{
	width: 98%;
	height: 100%;
	font-size: 100%;
	border-style: none;
}
#n_category,
#n_title{
	border-bottom: 1px dashed #05AA6D;
}
#n_category{
	text-align: center;
}
.noticeRegisterBtns{
	display: flex;
	justify-content: flex-end;
	margin-top: 3%;
	margin-right: 25%;
}
.noticeRegisterBtns button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 900;	
	min-width: 100px;
	min-height: 40px;
}
.noticeRegisterBtns button:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.changeFileBtn{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 900;	
	min-width: 70px;
	min-height: 30px;
	margin-left: 30px;
	margin-top: 3px;
}
.changeFileBtn:hover{
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}

.noticeRegisterBtn{
	margin-right: 20px;
}
.noticeFileName{
	font-size: 15px;
	color: blue;
	text-decoration: none;
	margin-top: 5px;
}
a:hover {
	cursor: pointer;
}
</style>
</head>

<body>
	<div class="noticeUpdateForm_wrapper">
		<div class="mainFormWrapper">
			<h3>공지사항 수정하기</h3>
			<!-- 공지사항 항목 구성( 카테고리, 제목, 내용, 첨부파일 -->
			<form action="noticeUpdate.do" id="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="n_no" class="hiddenNoticeInput" data-category="${notice.n_category }" data-no="${notice.n_no}"  data-file="${notice.n_file }" value="${notice.n_no }">
				<input type="hidden" name="n_message" value="" class="n_message">
				<table class="noticeFormTable">
					<tr>
						<th style="width: 150px;">제목</th>
						<td style="width: 500px;">
							<input type="text" class="inputNotice_title" name="n_title" id="n_title" value="${notice.n_title }" placeholder="제목을 입력해주세요.">
						</td>
						<th style="width: 200px;">카테고리</th>
						<td style="width: 200px">
							<select name="n_category" id="n_category">
								<option value="all" id="categoryAll">전체</option>
								<option value="emergency" id="categoryEmergency">긴급</option>
								<option value="event" id="categoryEvent">이벤트</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3"><textarea rows="" cols="" name="n_content"
								id="summernote">${notice.n_content }</textarea></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3" style="display: flex; border-left: 1px solid #05AA6D; height: 100%; border-bottom: 0px none;">
							<a class="noticeFileName" href="noticeFileDownload.do?filename=${notice.n_file }&pfilename=${notice.n_pfile }">${notice.n_file }</a>
							<input type="file" name="filename" id="n_file" class="n_file">
							<button type="button" class="changeFileBtn">첨부파일 수정</button>
						</td>
					</tr>
				</table>	
			</form>
			<div class="noticeRegisterBtns">
				<button type="button" class="noticeRegisterBtn">수정완료</button>
				<button type="button" class="goBackBtn">돌아가기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 공지사항 수정완료 버튼 ( 제목 null인지 아닌지 체크, 내용은 무관 )
	$('.noticeRegisterBtn').on('click', function(){ 
		// 제목만 체크
		var noticeTitle = $("#n_title").val();
		if( noticeTitle === null) {
			alert("제목을 입력하세요");
			$("#n_title").focus(); 
			return false;
		}
		// 글을 등록할 때와 마찬가지로 빈 내용은 등록이 불가능하게 한다.
		var noticeContent = $("#summernote").val();
		if( noticeContent === ""){ 
			alert("빈 내용은 공지사항 등록이 불가능합니다."); 
			$("#summernote").focus(); 
			return false;
		}
		$("#frm").submit();
	})
	
	// 첨부파일 변경 버튼
	$(".changeFileBtn").on("click", function(){ 
		// ok하면 input창 활성화 => name값이 "n_file"인 input태그에 value값으로 우선 
		var check = confirm("\"수정 완료\" 버튼을 누르면 기존에 업로드된 첨부파일이 삭제됩니다.")
		if(check){
			$(".n_message").val("YES");
			$(".noticeFileName").css("display", "none");  	// 첨부파일명
			$(".n_file").css("display", "block");			// <input type='file'> 
			$(".changeFileBtn").css("display", "none");		// 첨부파일 수정 버튼 
			console.log("n_message의 값: " + $(".n_message").val());
		} else {
			return false;
		}
	})

	// 돌아가기 버튼 
	$(".goBackBtn").on("click", function(){ 
			history.back(); 
	});
	
	// 제목을 입력하는 창에 포커스를 주거나 포커스에서 벗어나는 경우에 실행시킬 이벤트를 정의.
	$(".inputNotice_title").on({
		focus : function(e){
			$(e.target).css("outline-color", "tomato");
		}, 
		blur : function(e){
			$(e.target).css("outline-color", "whitesmoke")
		}
	})
	
</script>
<script>
	$(document).ready(function(){
		
		// 기존에 첨부파일이 존재했던 경우 "첨부파일 수정"버튼은 비활성화 시키고, 기본 <input type="file">을 활성화 시킨다. 
		const existingFileCheck = $(".hiddenNoticeInput").data('file');
		if(existingFileCheck){
			// 첨부파일이 존재하는 경우 => "첨부파일 수정"버튼을 숨긴다. 그리고 기본 <input type="file">을 활성화 시킴.
			$(".changeFileBtn").css("display", "block");
			$(".n_file").css("display", "none");
		} else {
			// 첨부파일이 존재하지 않는 경우 => 
			$(".changeFileBtn").css("display", "none");
			$(".n_file").css("display", "block");
		}
				
		// 컨트롤러에서 넘어온 카테고리 값으로 기본 selected 하기 // 얘도 문서가 로드되면 자동으로 실행되도록 하기 
		var categoryValue = $(".hiddenNoticeInput").data('category');
		console.log("컨트롤러에서 넘어온 카테고리 값: " + categoryValue);
		if( categoryValue == "all"){ 
			$("#categoryAll").attr("selected", "selected");
		} else if(categoryValue == "emergency" ) { 
			$("#categoryEmergency").attr("selected", "selected");
		} else if(categoryValue == "event" ){
			$("#categoryEvent").attr("selected", "selected");
		} else {
			$("#categoryAll").attr("selected", "selected");
		}
		
		// summernote 적용시키는 부분
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
		
		
	})
</script>
</html>