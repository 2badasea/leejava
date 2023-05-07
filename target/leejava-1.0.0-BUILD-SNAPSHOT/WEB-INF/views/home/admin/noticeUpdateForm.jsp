<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
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
			<h3>공지사항 수정하기</h3>
			<!-- 공지사항 항목 구성( 카테고리, 제목, 내용, 첨부파일 -->
			<form action="noticeUpdate.do" id="frm" method="post" enctype="multipart/form-data">
			<table border="1">
				<tr>
					<th style="width: 150px;">제목</th>
					<td style="width: 500px;">
						<input type="text" name="n_title" id="n_title" value="${notice.n_title }">
					</td>
					<th style="width: 200px;">카테고리</th>
					<td style="width: 200px">
						<select name="n_category" id="n_category">
							<option value="all" id="categoryAll">전체</option>
							<option value="긴급" id="categoryEmergency">긴급</option>
							<option value="이벤트" id="categoryEvent">이벤트</option>
						</select>
						<input type="hidden" id="noticeCategory" value="${notice.n_category }">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="" cols="" name="n_content"
							id="summernote">${notice.n_content }</textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						${notice.n_file }
						<input type="hidden" id="fileCheck" value="${notice.n_file }">
						<button id="changeFileBtn">첨부파일 수정</button>
					</td>
				</tr>
			</table>
			<input type="hidden" id="n_no" name="n_no" value="${notice.n_no }">
			</form>
			<div class="noticeRegisterBtns">
				<button id="noticeRegisterBtn">수정완료</button>
				<button id="goBackBtn">돌아가기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 공지사항 수정완료 버튼 ( 제목 null인지 아닌지 체크, 내용은 무관 )
	$('#noticeRegisterBtn').on('click', function(){ 
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
	$("#changeFileBtn").on("click", function(){ 
		// DB에 저장되어 있는 첨부파일 원본명.
		var fileCheck = $("#fileCheck").val();
		alert("파일이름 확인: " + fileCheck);
		
		if( fileCheck == ''){ 
			// value값이 없는 경우 => 즉, 첨부파일이 없는 게시글의 경우  첨부파일을 업로드하여 게시글을 수정시키기 위함.
				// 동적으로 요소를 추가한다.
			$("#changeFileBtn").closest('td').html('<input type="file" name="filename" id="n_file">');
		} else { 
			// fileCheck가 null이 아니라는 건, 해당 게시글에 업로드한 첨부파일이 존재한다는 뜻. 
			 var check = confirm("기존에 업로드한 파일은 삭제하시겠어요?");
			 if(check){ 
				 // ajax로 기존의 해당 게시글 첨부파일 삭제해버리기
				 var n_no = $("#n_no").val();
				 $.ajax({
					 type: "POST",
					 url: 'ajaxNoticeFileDelete.do',
					 data: { 
						 n_no : n_no
					 },
					 success: function(message){ 
						 if( message === "YES"){ 
							 alert("삭제했습니다.");
						 } else { 
							 alert("삭제 실패. 시스템 에러");
						 }
					 }
				 }) // ajax끝.
				 
				 // ajax로 기존 파일 삭제 후, 첨부파일 업로드 버튼 생성.
				 $("#changeFileBtn").closest('td').html('<input type="file" name="filename" id="n_file">');
			 } else { 
				 return false;
			 }
		 
		} // else문
	})
	

	// 돌아가기 버튼 
	$("#goBackBtn").on("click", function(){ 
			history.back(); // 이전 페이지로 이동시키기
// 			location.href='adminNoticeList.do';
	});
	
	
	// 문서가 로드되면 서머노트 적용시키도록 
	$(document).ready(function() {
		
		// 컨트롤러에서 넘어온 카테고리 값으로 기본 selected 하기 // 얘도 문서가 로드되면 자동으로 실행되도록 하기 
		var categoryValue = $("#noticeCategory").val();
		console.log("컨트롤러에서 넘어온 카테고리 값: " + categoryValue);
		if( categoryValue == "전체"){ 
			$("#categoryAll").attr("selected", "selected");
		} else if(categoryValue == "긴급" ) { 
			$("#categoryEmergency").attr("selected", "selected");
		} else {
			$("#categoryEvent").attr("selected", "selected");
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
	});
</script>
</html>