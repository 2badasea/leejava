<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<script src="resources/js/summernote/summernote-lite.js"></script>
<script src="resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/css/summernote/summernote-lite.css">
</head>
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

/* 첨부파일 리스트 관련 css */
.fileListInput{
	outline: none;
	min-height: 30px;
	padding-top: 5px;
	border-style: none;
} 
.addFileBtn{
	float: right;
	width: auto;
	height: auto;
}
.addFileBtn:hover {
	cursor: pointer;
}
.fileListDiv{
 	border-style: none;
}
</style>
<body>
<input type="hidden" class="sessionCheck" value="${session_nickname }">
<input type="hidden" class="boardUpdateHidden" data-boardno="${board.boardNo }" data-bfilecheck="${board.bfileCheck }"
											data-boardwriter="${board.boardWriter }">
<!-- 이 페이지의 바탕 -->
<div class="boardWritingForm_wrapper">
	<div class="mainFormWrapper">
		<div align="center">
			<h2>게시글 수정</h2>
		</div>
		<br>
		<!-- 테이블 형식으로 제목과 내용, 그리고 첨부파일 업로드 칸을 구현한다. -->
		<form id="frm" action="boardInsert.do" method="post" enctype="multipart/form-data">
			<table class="boardFormTable">
				<tr class="boardTableThTr">
					<th width="150">제목</th>
					<td width="800">
						<input type="text" class="boardTitle" maxlength="50" placeholder="제목은 최대 50자 까지 작성할 수 있습니다." value="${board.boardTitle }">
					</td>
				</tr>
				<tr class="boardTableThTr">
					<th>내용</th>
					<td>
						<textarea rows="" cols="" id="summernote" class="boardContents" >${board.boardContents }</textarea>
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
			<button class="boardUpdateEndBtn">수정완료</button>
		</div>
	</div>
</div>
	

</body>
<script type="text/javascript">	
	// 세션값 체크.
	const $sessionCheck = document.querySelector('.sessionCheck').value;
	
	const $boardNo = document.querySelector('.boardUpdateHidden').dataset.boardno;
	const $bfileCheck = document.querySelector('.boardUpdateHidden').dataset.bfilecheck;
	const $boardWriter = document.querySelector('.boardUpdateHidden').dataset.boardwriter;
	// 게시판 유형 1(자유게시판)
	const $fileBoard = 1;
	// 첨부파일 목록들을 붙일 div 
	const $attachDiv = document.querySelector('.uploadFileTd');
	
	
	const $boardUpdateEndBtn = document.querySelector('.boardUpdateEndBtn');
	const $boardContents = document.querySelector('.boardContents');
	
	$boardUpdateEndBtn.addEventListener('click', () => {
		const $boardUpdateCheck = confirm('수정한 내용을 저장하시겠습니까?');
		if(!$boardUpdateCheck || $sessionCheck == undefined ){
			console.log("등록 취소 원인:  $boardUpdateCheck:" + $boardUpdateCheck + ",   $sessionCheck : " + $sessionCheck );
			return false;
		}
		
		// 임시 수정 완료 버튼 구현
		// 추후에 페이징 정보를 모두 담아서 컨트롤러에 보낸다.
		// 제목과 내용에 대한 정규식도 보낸다.
		console.log("수정완료 ^^");
	})
	
	function Fnc_boardAttachedFileList(boardNo, fileboard){
		console.log("ajax 호출 준비");
		
		const xhr =  new XMLHttpRequest();
		xhr.open("GET", "ajaxAttachFileList.do?boardNo=" + boardNo + "&fileBoard=" + fileboard);
		xhr.setRequestHeader('Content-type', 'application/text; charset=utf-8');
		xhr.responseType = 'json';
		xhr.onload = function(){
			if(xhr.status == 200){
				const data = xhr.response;
				console.log(data);
				console.log("data의 길이: " + data.length);
				// map을 활용해서 해당 파일의 정보를 화면에 심는다. 
				for(const key in data){
					console.log("key: " + key); 
					console.log(data[key]);
					var $originName = data[key].fileOriginname;
					var $fileType  = data[key].fileType;
					var $fileUploadpath = data[key].fileUploadpath;
					var $fileUuid = data[key].fileUuid;
					
					var $tempDiv = document.createElement('div');
					$tempDiv.classList.add('fileListDiv');
					
					var str = "<input class='fileListInput' type='text' readonly data-originname='" + $originName; 
					str += "' data-filetype='" + $fileType + "' data-fileuploadpath='" + $fileUploadpath + "' ";
					str += " data-fileuuid='" + $fileUuid + "' value='" + $originName + "' >";
					str += " <button type='button' class='addFileBtn' >취소</button>";
					console.log(str); 
					$tempDiv.innerHTML = str;
					$attachDiv.prepend($tempDiv);
				}
				
			}else {
				console.log('Error occurred', xhr.status);
			}
		};
		xhr.send();
	}
	
	// 파일 리스트 목록 input   class = 'fileListInput'
	// 파일 리스트 버튼 button  class = 'addFileBtn'
	// 위 두 개를 감싸는 div    class = 'fileListDiv'
	// 위 전체를 감싸는 div class = uploadFileTd
	
	// 업로드 파일 추가 버튼 함수 정의
	function Fnc_addFile(){
		let $fileCount = document.querySelectorAll('.fileListInput').length;
		
		let $fileInputLength = document.querySelectorAll('.addFileInput').length;
		console.log("addInput의 개수: " + $fileInputLength );
		
		if( ($fileInputLength +  $fileCount ) >= 3){
			alert("파일 업로드는 최대 3개만 가능합니다.");
			return false;
		} else {
			var $tempDiv = document.createElement('div');
			$tempDiv.classList.add('fileListDiv');
			var $addInput = document.createElement('input');
			$addInput.classList.add('addFileInput');
			$addInput.setAttribute('type', 'file');
			$tempDiv.append($addInput);
			$attachDiv.prepend($tempDiv);
			// 추가될 때마다 개별 간격 css로 조정.
			// 코드가 길어지므로 => str태그를 통해서 구현하도록 하기 => 참고)memberBoardWritingForm.jsp 
		}
	}
	
	// 첨부파일 삭제 이벤트
	document.querySelector('.uploadFileTd').addEventListener('click', function(e){
		if( e.target.className == 'addFileBtn'){
			console.log("delete file click!");
			const $fileDeleteCheck = confirm("파일을 정말 삭제하시겠습니까?");
			if(!$fileDeleteCheck){
				return false;
			}
			// <button>의 형제요소 태그 <input> 
			var $liveAddedInput = e.target.previousElementSibling;
			
			var sendJson = new Object();
			sendJson.originname = $liveAddedInput.dataset.originname;
			sendJson.filetype = $liveAddedInput.dataset.filetype;
			sendJson.fileuploadpath = $liveAddedInput.dataset.fileuploadpath;
			sendJson.fileuuid = $liveAddedInput.dataset.fileuuid;
			sendJson.fileboard = $fileBoard; // 1
			sendJson.boardno = $boardNo; // 현재 게시글 번호
			const xhr = new XMLHttpRequest(); 
			xhr.open('POST', 'ajaxBoardAttachFileDelete.do');
			// json 형식으로 보낸다. 마지막 send()에서 JSON.stringify() 활용.
			xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
			xhr.responseType = 'text';
			xhr.onload = function(){
				if(xhr.status == 200){
					console.log("통신 성공ㅜㅜ");
					const data = xhr.response;
					console.log(data);
					// 부모 div태그를 삭제시키기.
					$liveAddedInput.parentElement.remove();
				}else{
					console.log("통신실패", xhr.status, xhr.response);
				}
			}
			xhr.send(JSON.stringify(sendJson));
			
		}
	});

	
</script>
<script>
	// summernote 에디터의 경우, bootstrap과 jQuery를 기반으로 만들어진 에디터 => 제이쿼리 문법이 불가피. 
	let newJquery = $.noConflict(true); 
	
	// DOM 객체 생성 이후 실행시킬 스크립트 by jQuery
	$(document).on('ready', function(){
		if(!$sessionCheck){
			alert("세션이 만료되었습니다. 다시 로그인 해주세요");
			location.href = "loginPage.do";
		} else if( $boardWriter != $sessionCheck ){
			alert("현재 로그인 계정과 작성자가 일치하지 않습니다.");
			location.href = "boardList.do";
		}
		
		// ajax 호출을 통해 첨부파일 목록을 노출
		if($bfileCheck != 0){
			console.log('게시판 번호: ' + $boardNo );
			console.log("게시판 유형 조회: " + $fileBoard );
			Fnc_boardAttachedFileList($boardNo ,$fileBoard );
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
	 	newJquery(".boardContents").summernote(setting);
	 	
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
	   	
		
	}); // end for 제이쿼리 $(document).on("ready") 
</script>
</html>