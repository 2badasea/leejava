<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시글 작성하기</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="resources/js/summernote/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
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
.borarWritingBtns{
	margin-right: 40px;
}
.borarWritingBtns button{
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
.borarWritingBtns button:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.boardTableThTr{
	height: auto;
}
</style>
</head>
<script>

</script>
<body>	
	<input type="hidden" class="sessionCheck" value="${session_nickname }">
	<!-- 이 페이지의 바탕 -->
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
							<input class="fileAddBtn" type="button" style="display: flex; margin: auto;" onclick="Fnc_addFile()" value="업로드 파일 추가">
						</td>
					</tr>
				</table>
			</form>
			<br>
			<div class="borarWritingBtns" style="float: right;">
				<button class="historyBackBtn">목록가기</button>
				<button class="boardWritingBtn">등록하기</button>
			</div>
		</div>
	</div>
</body>
<script>
	// 업로드 파일을 대상으로 정규식을 활용하여 확장자나 크기의 사전 처리
	const fileRegExp = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	const fileMaxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= fileMaxSize){
			alert(fileName + " 파일 사이즈 초과");
			return false;
		}
		if(fileRegExp.test(fileName)){
			alert(fileName + " 해당 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}

	// 등록하기 버튼 구현
	$(".boardWritingBtn").on("click", function(){
		// 작성자 내용으로 들어갈 닉네임은 session값에서 불러오면 된다. session이 널이 됐으면 return 시키기
		const inputTitle = $(".boardTitle").val();
		const inputContents = $(".boardContents").val();
		const inputNickname = $(".sessionCheck").val();
		
		let inputFile = $("input[name='uploadFile']");
		let inputFileCnt = 0;
		let formData = new FormData();
		if(inputFile.length !== 0){
			for(var i = 0; i < inputFile.length; i++ ){
				if(inputFile[i].files.length !== 0){
					
					if(!checkExtension(inputFile[i].files[0].name, inputFile[i].files[0].size )){
						return false;
					}
					formData.append("uploadFile", inputFile[i].files[0]);
					inputFileCnt++;
				}
			}
		}
		console.log("FormData에 담긴 파일 숫자: " + inputFileCnt);

		// 제목이나 내용이 null or 0인 경우 return false;
		if(inputTitle.length === 0 || inputContents.length === 0){
			alert("제목과 내용을 입력해주세요.");
			return false;
		}
		
		// 작성 중에 세션이 만료된 경우, 다시 로그인 하도록. => 스프링시큐리티 공부하고 세션으로 제어할 수 있도록 수정하기		
		if(inputNickname  == undefined || inputNickname == null ){
			alert("세션이 만료되었습니다. 다시 로그인해주세요");
			location.href="loginPage.do";
		}
		
		
		// ajax에 실어서 보낼 데이터
		let data = {
				boardTitle : inputTitle,
				boardContents : inputContents,
				bfileCheck : inputFileCnt,
				boardWriter : inputNickname
		};
		
		$.ajax({
			url: $("#frm").attr("action"), // boardInsert.do
			data: JSON.stringify(data),
			type: "POST",
			contentType: "application/json; charset=utf-8",
			dataType: "text",
			success: function(message){
				if(message === "NOFILE"){
					// 첨부파일 없는 게시글의 경우.
					alert("정상적으로 등록되었습니다.");
					location.href = "boardList.do";
				} else {
					// 첨부파일이 존재하는 경우(문자열 타입의 숫자를 숫자형으로 형변환 후 리턴)
					message = message * 1; 
					Fnc_fileUpload(formData, message);
					location.href = "boardList.do";
				}
			},
			error: function(error){
				console.log(error);
			}
		})
	})
	
	// 파일 업로드 ajax 콜백함수 정의
	function Fnc_fileUpload(formData, fileBno){
		// 첨부파일 업로드 게시판 유형 구분 => 자유게시판 번호 1 
		const inputFilebno = $("#fileboardInput").data('board');
		console.log("게시판 유형: " + inputFilebno + ", 게시글 번호: " + fileBno);
		let url = "ajaxFileUpload.do?fileBoard=" + inputFilebno + "&fileBno=" + fileBno;
		
		// ajax를 반복문으로 호출하는 방법 => formData value값 루프 + 배열로 받아도 상관없음 1개만 날라가기에. 
		$.ajax({
			url : url,
			processData : false,
			contentType : false,
			data : formData,
			dataType : "json",
			type : "POST",
			success: function(result){
				console.log("ajax 파일 업로드 완료");
				console.log(result);
			}, 
			error: function(error){
				console.log("ajax 파일 업로드 완료, but 실패");
				console.log(error);
			}
		}) // End of Ajax
	}
	
	// 업로드 가능한 <input type="file"> 개수 추가 
	function Fnc_addFile(){
		var fileTagCnt = $("input[name='uploadFile']").length;
		console.log("첨부파일 갯수: " + fileTagCnt);
		if(fileTagCnt >= 3){
			alert("최대 3개만 업로드 할 수 있습니다.");
			return false;
		}
		// 아직 <input> 요소가 3개가 아니라면,
		var addFileTag = "<div style='display: flex; justify-content: space-between; margin-bottom: 8px;'>";
		addFileTag += "<input type='file' name='uploadFile'><input class='fileCancelBtn' type='button' value='취소'></div>";
		$(".uploadFileTd").prepend(addFileTag);
	}

	// 이전 화면(자유게시판 리스트) 페이지로 돌아가기
	$(".historyBackBtn").on("click", function(){
		let historyBackCheck = confirm("작성 중인 글을 멈추고 돌아가시겠어요?");
		if(historyBackCheck){
			location.href = "boardList.do";
		} else{
			return false;
		}
	})
	
	// 동적으로 추가된 <input file='file'> 삭제 이벤트
	$(document).on("click", ".fileCancelBtn", function(){
		console.log("클릭 확인");
		// <div>태그 통째로 삭제
		var selectDiv = $(this).parent();
		selectDiv.remove();
	})
	
</script>
<script>
var newJquery = $.noConflict(true);
//화면에 문서가 모두 출력되면 아래 정의한 이벤트를 실행시킨다. 
$(document).ready(function(){
		// 자유게시판 번호 조회(바닐라 JS)
		const fileboardNum = document.getElementById('fileboardInput').dataset.board;	
// 		const fileboardNum = $("#fileboardInput").data('board');  // 제이쿼리 방식의 data 어트리뷰트 값 조회
		console.log("자유게시판 번호: " + fileboardNum);
	
		// 새로고침 했을 때 세션값이 존재하지 않는다면, login창으로 옮기기. 
		const sessionCheck = $(".sessionCheck").val();
		if(!sessionCheck){
			alert("세션이 만료되었습니다. 다시 로그인해주세요");
			location.href="loginPage.do";
		}
		
	
  		/* summernote 구현 스크립트 */
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
    // 위 설정대로 summernote를 <textarea> 부분에 호출시킨다. 
  	newJquery('#summernote').summernote(setting);
  	
    // 이미지업로드 콜백함수 정의
  	function uploadSummernoteImageFile(file, el) {
		// 이때 파라미터로 되어있는 el의 값은 이미지 업로드가 발생한 <textarea>태그를 의미한다. 
    	console.log("file값: ");
		console.log(file);
    	data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "ajaxUploadSummernoteImageFile.do",  // 컨트롤러에서 처리해야 함
			contentType : false, // multipart/form-data 형식으로 보낼 때는 contentType:을 false로. 
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