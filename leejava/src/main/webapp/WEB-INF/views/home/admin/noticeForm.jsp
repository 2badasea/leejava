<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<!-- summernote 사용 -->
<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="resources/js/summernote/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
<style>
.mainFormWrapper {
	margin-left: 10%;
	margin-top: 5%;
}
/* 공지사항 작성하는 폼 테이블 디자인 꾸미기 */
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
.noticeRegisterBtn{
	margin-right: 20px;
}
</style>
</head>
<body>
	<div class="noticeForm_wrapper">
		<div class="mainFormWrapper">
			<h3>공지사항 등록</h3>
			<!-- 공지사항 항목 구성( 카테고리, 제목, 내용, 첨부파일 -->
			<form action="noticeRegister.do" id="frm" method="post" enctype="multipart/form-data">
			<table class="noticeFormTable">
				<tr>
					<th style="width: 150px;">제목</th>
					<td style="width: 500px;">
						<input type="text" class="inputNotice_title" name="n_title" id="n_title" placeholder="제목을 입력해주세요.">
					</td>
					<th style="width: 200px;">카테고리</th>
					<td style="width: 200px">
						<select name="n_category" id="n_category">
							<option value="all" selected="selected">전체</option>
							<option value="emergency">긴급</option>
							<option value="event">이벤트</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="" cols="" name="n_content" id="summernote"></textarea></td>
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
				<button type="button" class="noticeRegisterBtn">공지사항 등록</button>
				<button type="button" class="goBackBtn">돌아가기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 공지사항 등록 버튼 ( 제목 null인지 아닌지 체크, 내용은 무관 )
	$('.noticeRegisterBtn').on('click', function(){ 
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
	$(".goBackBtn").on("click", function(){ 
			location.href='adminNoticeList.do';
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
	// 화면에 문서가 모두 출력되면 아래 정의한 이벤트를 실행시킨다. 
	$(document).ready(function(){
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