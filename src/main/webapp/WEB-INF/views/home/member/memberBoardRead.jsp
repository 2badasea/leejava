<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<!-- summernote를 위해 필요한 부분 -->
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
<style type="text/css">
.boardReadFormWrapper, .boardReplyWrapper{
    margin-top: 1%;
    margin-left: 15%;
    width: 55%;
}
.boardReadFrom_buttons{
	margin-bottom: 1%;
}
.boardReadFrom_buttons {
	display: flex;
	justify-content: flex-end;
}
.boardReadFrom_buttons button:not(:last-child){
	margin-right: 2%;	
}
.boardRead_header_right{
	border: 1px solid lightgray;
	border-radius: 10px;
	width: 15%;
	display: flex;
	align-items: center;
}
.boardRead_header_right div{
	width: 33%;
	height: 50%;
	text-align: center;
}
.boardLikeItCount{
	border-left: 0.5px solid lightgray;
	border-right: 0.5px solid lightgray;
}
.boardReadForm_title{
	padding-bottom: 5px;
	border-bottom: 0.5px solid lightgrey;
}
.boardReadForm_contents{
	padding: 5px;
	border-bottom: 0.5px solid lightgrey;
	min-height: 300px;
	height: auto;
}

.boardReadForm_file{
	display: flex;
	align-items: center;
	border-bottom: 0.5px solid lightgrey;
}
.boardReadFormWrapper button, .boardReplyInsertBtn, .ReplyUpdateBtn, .ReplyUpdateCancelBtn, .reReplyInsertBtn, .reReplyCancelBtn{
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
}

.boardReadFormWrapper button:hover, 
.boardReplyInsertBtn:hover, 
.ReplyUpdateBtn:hover, 
.ReplyUpdateCancelBtn:hover, 
.reReplyInsertBtn:hover, 
.reReplyCancelBtn:hover{
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.ReplyUpdateBtn, .ReplyUpdateCancelBtn{
	min-width: 80px;
	margin-top: 20px;
	min-height: 40px;
}

.fileListLi{
	padding-top: 5px;
	padding-bottom: 5px;
}

.fileListA:hover{
	color: coral;
	cursor: pointer;
	font-weight: bold;
}

.uploadFileDivs{
    width: 25%; 
    padding-top: 10px; 
    padding-bottom: 10px;
}
.thumbnailUploadResult{
	height: 100px; 
	display: flex; 
	align-items: center; 
	justify-content: center;
}
.uploadFileDivs:hover{
	border: 0.1px solid coral;
}
.thumbImg:hover{
	cursor: pointer;
}
/* -원본 이미지 노출 div 스타일 정의  */
.bigPictureWrapper{
	position: fixed;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	margin-left: -12%;	
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
	width: 600px;
}

.boardRead_header_right i:hover{
	cursor: pointer;
}
/* 댓글 관련 UI */
.boardReplyInsertBtn{
	float: right;
	margin-right: 10%;
	width: 100px;
	height: 40px;
}
.boardReplyWriting, .boardReplyUpdating, .reReplyWriting{
	display: flex;
	justify-content: space-around;
	padding: 15px;
}
.boardReplyList{
	margin-top: 100px;
}
.boardReplyListHeader{
	padding-left: 2%;
	width: 100%;
	display: flex;
	justify-content: space-between;
}
.boardReplyListFooter{
	padding-left: 2%;
}
.replyerBtns{
	padding-right: 5%;
	display: flex;
	justify-content: space-between;
}
.replyerBtns button{
	width: 70px;
	height: 30px;
	margin-right: 20px; 
	border-radius: 20px;
	border-style: none;
	color: 	#05AA6D;
	background-color: whitesmoke;
}
.replyerBtns button:hover{
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.boardReplyListContents, .replyUpdatingContent{
	min-height: 50px;
	width: 80%;
	padding : 15px;
	font-size: small;
}
.boardReReplyBtn, .boardReplyShow{
	font-size: smaller;
}
.boardReplyShow{
	margin-left: 2%;
}
/* 대댓글창 스타일*/
.addedReReplyBox{
	width: 90%;
	margin-left: 10%;
	background-color: ghostwhite;
}
.reReplyWriting button {
	margin-left: 10%;
}
.reReplyWriting .reReplyCancelBtn{
	margin-top: 10%;
}
</style>
</head>
<body>
<div class="boardReadForm_wrapper">
<input type="hidden" class="boardReadFormHidden" data-nickname="${board.boardWriter	}" data-no="${board.boardNo }" data-file="${board.bfileCheck }">
    <!--모든 내용들이 들어가는 공간.-->
    <div class="boardReadFormWrapper">
        <!-- 읽기 폼 메인 -->
        <div class="boardReadForm">
            <div class="boardReadFrom_buttons">
                <button type="button" class="boardListBackBtn">목록보기</button>
                <c:if test="${session_nickname eq board.boardWriter }">
	                <button type="button" class="boardUpdateBtn">수정</button>
	                <button type="button" class="boardDeleteBtn">삭제</button>
                </c:if>
            </div>
            <div class="boardReadForm_header">
                <div style="display: flex; justify-content: space-between;">
                	<div class="boardRead_header_left" style="display: flex;">
                		<img src="resources/image/userimage.jpg" style="width: 5%; height:100%; border-radius: 25%;">
                		<div style="margin-left: 5px;">
	                		<span><b>${board.boardWriter }</b></span>
	                		<br>
	                		<span>${board.boardWdate }</span>
	                		&nbsp;&nbsp;
	                		<i class="fa-solid fa-eye"></i>
	                		<span>${board.boardHit}</span>
                		</div>
               		</div>
                	<div class="boardRead_header_right">
                		<input type="hidden" class="hiddenLikeValue">
               			<div class="boardLikeitDown"><i class="fa-solid fa-arrow-down"></i></div>
               			<div class="boardLikeItCount">${board.boardLikeit }</div>
               			<div class="boardLikeitUp"><i class="fa-solid fa-arrow-up"></i></div>
                	</div>
                </div>
            </div>
            <!-- 내용 폼(제목, 내용)-->
            <div class="boardReadForm_body">
            	<br>
             	<div class="boardReadForm_title">
             		<h2>${board.boardTitle }</h2>
             	</div>
             	<br>
             	<div class="boardReadForm_contents">
             		${board.boardContents }
             	</div>
	            <div class="boardReadForm_file">
	            	<div style="width: 10%;"  align="center">
	            		첨부파일
	            	</div>
	            	<div style="display:flex; width: 90%;  padding-top:0.5px; padding-bottom:0.5px; border-left: 0.5px solid lightgrey; padding-left: 10px;">
	            		<c:if test="${not empty fileList }">
            				<c:forEach items="${fileList}" var="file">
            						<div class="uploadFileDivs" align="center">
            							<input type="hidden" data-uuid=${file.fileUuid } data-uploadpath=${file.fileUploadpath } data-originname=${file.fileOriginname } data-filetype=${file.fileType }>
            							<div class="thumbnailUploadResult">
            								<!-- DOM객체 생성 이후 script단으로 이미지를 호출 -->
            							</div>
	            						<a class="fileListA" onclick="boardFileDown(this)" >${file.fileOriginname }</a>
            						</div>
            				</c:forEach>
	            		</c:if>
	            	</div>
	            </div>
            </div>
            <!--첨부파일 폼-->
            <br><br>
        </div>
        <hr>
    </div>
    <!-- 댓글 관련 박스 -->
    <div class="boardReplyWrapper">
    	<input type="hidden" class="replyWriterInfo">
 		<c:if test="${not empty session_user }">
	    	<!-- 댓글 작성 폼 -->
	    	<div class="boardReplyWriting">
		     	<div class="boardReplyWriterBox">
		     		<img alt="" src="${pageContext.request.contextPath}/resources/img/undraw_profile.svg" style="width: 40px; height: 40px; margin-top: 30px;">
		     	</div>
		     	<div class="boardReplyWritingForm">
		     		<textarea id="summernote" class="boardReplyContents"></textarea>
		     	</div>
	    	</div>
	    	<div>
	   		 	<button class="boardReplyInsertBtn" type="button">등록하기</button>
	    	</div>
	    </c:if>
   		 <div class="boardReplyList">
	   		 <!-- 댓글 리스트 출력 by ajax -->
   		 </div>
    </div>
</div>
<!-- 원본이미지를 화면에 출력시키기 위한 div --> 						
<div class='bigPictureWrapper'>
	<div class='bigPicture'>
			
	</div>
</div>
</body>
<!-- 댓글 관련 script 파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reply.js?v=<%=System.currentTimeMillis() %>"></script>
<script>
	
	// 현재 로그인 중인 세션 닉네임
	var sessionNickname = $("#hiddenSessionInfo").data('nickname');
	
	// 이 페이지의 작성자, 글번호, 첨부파일 유무  
	const boardWriter = $(".boardReadFormHidden").data('nickname');
	const boardNo = $('.boardReadFormHidden').data('no');
	const bfileCheck = $(".boardReadFormHidden").data('file'); // 첨부 파일 개수
	
	// 추천수 클릭
	$('.boardLikeitDown, .boardLikeitUp').on("click", function(e){
		var hiddenLike = $(".hiddenLikeValue").val();
		console.log("hiddenLikeValue 값 조회: " + hiddenLike);
		var clickValue = $(this).attr('class') == 'boardLikeitDown' ? -1 : 1;
		
		var clickPointClass = $(e.target);
		console.log("clickValue 값: " + clickValue);
		// 로그인 세션이 만료된 경우 or  클릭한 값이 반대의 값과 같은 경우
		if(!sessionNickname || clickValue == (hiddenLike * -1) ) return false;
		$.ajax({
			url : "boardLikeitUpdate.do",
			data : {
				nickname : sessionNickname,
				boardNo : boardNo,
				clickValue :  clickValue,
				checkHiddenLike : hiddenLike
			},
			method : "GET",
			dataType : "json",
			success: function(res){
				console.log("성공: " + res);
				Fnc_afterBoardLikeit(res);
			},
			error: function(res){
				console.log("에러 : " + res);
			}
		})
		
		function Fnc_afterBoardLikeit(res){
			console.log("화면에 표기될 추천수 값: " + res.likeCount);
			$(".boardLikeItCount").text(res.likeCount);
			console.log("새롭게 hidden에 저장될 값: " + res.newHiddenValue);
			console.log("res.method 값: " +  res.method);
			if(res.method == 'insert'){
				// method = 'insert'
				$(".hiddenLikeValue").val(res.newHiddenValue);
				$(clickPointClass).css("color", "coral");
			} else {
				// method == 'delete'
				$(".hiddenLikeValue").val(res.newHiddenValue);
				$(clickPointClass).css("color", "black");
			}
		}
	})	
	
	// 수정하는 폼으로 이동. 
	$('.boardUpdateBtn').on("click", () => {
		console.log("수정하는 폼 글번호 확인: " + boardNo);
		const boardUpdateCheck = confirm("게시글을 수정하시겠습니까?");
		if(!boardUpdateCheck) {
			return false;
		}
		location.href = "boardUpdateForm.do?boardNo=" + boardNo;
	});
	
	
	// 첨부파일 다운로드.
	function boardFileDown(e){
		
		const hiddenInput = $(e).parent('div').children('input');
		
		// 아래 동적으로 생성한 <form>태그에 의해 post방식으로 전송되면서 알아서 encoding한 값이 서버로 넘어간다. 
		const fileUuid = hiddenInput.data('uuid');
		let fileUploadpath = hiddenInput.data('uploadpath');
		const fileOriginname = hiddenInput.data('originname');
		
 		// fileCallPath =  encodeURIComponent(fileCallPath); 에러의 원인. POST로 넘기면 알아서 인코딩을 해준다. 
		var fileCallPath = fileUuid + "_" + fileOriginname;
		
		// ajax로는 다운로드 불가 => form태그를 임의로 형성해서 submit()하는 방식으로 시도. 
		var newForm = $("<form></form>");
		
		newForm.attr("name", "newForm");
		newForm.attr("method", "post");
		newForm.attr("action", "boardFileDown.do");
		
		newForm.append($("<input/>", {type: 'hidden', name : 'fileName', value : fileCallPath }));
		newForm.append($("<input/>", {type: 'hidden', name : 'fileUploadpath', value : fileUploadpath}));
		
		newForm.appendTo("body");
		
		newForm.submit();
	}
	
	
	// 게시글 삭제하기
	$(".boardDeleteBtn").on("click", function(){
		let deleteCheck = confirm("게시글을 삭제하시겠어요?");
		if(!deleteCheck){
			return false;
		}
		// 삭제를 하면, 해당 게시글에 담긴 첨부파일도 모두 삭제되도록 한다. 첨부파일 존재 여부 
		const deleteNumber = boardNo;
		let data = {
				boardWriter : boardWriter,
				boardNo : deleteNumber,
				bfileCheck : bfileCheck
		};
		console.log(data);
		
		if(bfileCheck !=0){
			console.log("첨부파일 존재");
			// 첨부파일 목록들을 모두 가져옴
			var fileDatas = $('.uploadFileDivs').children('input');
			var fileAry = [];
			$.each(fileDatas, function(index, item){
				var fileCallPath = encodeURIComponent($(item).data('uploadpath') + "\\" + $(item).data('uuid') + "_" + $(item).data('originname'));
				fileAry.push(fileCallPath);
				if( $(item).data('filetype') == 1){
					fileCallPath = encodeURIComponent($(item).data('uploadpath') + "\\s_" + $(item).data('uuid') + "_" + $(item).data('originname'))
					fileAry.push(fileCallPath);
				}
			});
			const jsonFiles = {'fileName' : fileAry};
			
			$.ajax({
				url:  "uploadfileDelete.do?boardNo=" + boardNo,
			    type: "POST",
			    data : JSON.stringify(jsonFiles),
			    async: "true",
			    contentType: "application/json; charset=utf-8", // 생략하면 => x-www-form-urlencoded속성으로 전송됨
			    dataType: "text",
			    success: function(res){
			    	console.log("res: " + res);
			    	// 첨부파일 삭제 이후 원 게시글 삭제 함수 호출.
			    	if(res == "success"){
			    		boardDelete(deleteNumber);
			    	}else {
			    		alert("첨부파일을 삭제하는 데 문제가 생겼습니다.");
			    	}
			    },
			    error: function(res){
			    	console.log(res);
			    }
			})
		}else {
			console.log("첨부파일 미존재");
			boardDelete(deleteNumber);
		}
		
		// 원 게시글 삭제
		function boardDelete(no){
			$.ajax({
				url: "boardDelete.do",
				data: JSON.stringify(data),
				method: "POST",
				contentType: "application/json; charset=utf-8",
				dataType: "text",
				success: function(res){
					console.log(res);
					alert("성공적으로 삭제되었습니다.");
					location.href = "boardList.do";
				}, 
				error: function(res){
					console.log("error: " + res);
					alert("삭제가 실패했습니다.");
					location.reload();
				}
			})
		}
	})
		
	// 목록으로 돌아가기
	$(".boardListBackBtn").on("click", function() {
		location.href = "boardList.do";
	});
	
	// 원본 이미지 호출
	function showImage(originfileCallPath){
		console.log("originfileCallPath 확인 : " + originfileCallPath);
		$(".bigPictureWrapper").css("display", "flex").show();
		$("body").css('overflow', 'hidden');
		$(".bigPicture").html("<img src='thumbnailDisplay.do?thumbfilecallpath=" + originfileCallPath +"\'>").animate( { width : '100%', height : '100%'}, 1000);
	}
	
	// 원본 이미지 사라지도록 하기
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width : '0%', height: '0%'}, 300);
		$("body").css('overflow', 'unset');
		setTimeout( () => {
			$(this).hide();
		},300);
	})
	

</script>
<script>
	$(document).ready(function(){
		
		// DOM이 생성된 이후에 실행.
		if( $(".uploadFileDivs").length != 0 ){
			var $imageBox = $('.thumbnailUploadResult');
			var $inputs = $('.uploadFileDivs').children('input');
			
			$.each($inputs, function(index, item){
				var $box = $imageBox[index];
				var $filetype = $(item).data('filetype');
				var $uploadpath = $(item).data('uploadpath');
				var $uuid = $(item).data('uuid');
				var $originname = $(item).data('originname');
				
				// 썸네일 이미지 경로
				var $thumbfileCallPath = encodeURIComponent($uploadpath + "\\s_" + $uuid  + "_" + $originname); 
				// 원본 이미지 경로
				var $originfileCallPath = encodeURIComponent($uploadpath + "\\" + $uuid  + "_" + $originname); 
				 
				if($filetype == false){
					// 타입이 일반 파일인 경우 기본 이미지 호출
					var $basicImgStr = '<img src="resources/image/attachedFile.png" style="width: 100px;">';
					$($box).attr("onclick", "boardFileDown(this)");
					$box.innerHTML = $basicImgStr;
				} else{
					// 타입이 이미지인 경우, get방식으로 보내기 때문에 인코딩.(post방식은 필요없음)
					var $imgStr = '<img class="thumbImg" src="thumbnailDisplay.do?thumbfilecallpath=';
					$imgStr += $thumbfileCallPath + '" onclick="showImage(\'' + $originfileCallPath;
					$imgStr += '\''; 
					$imgStr += ')\" >';
					$box.innerHTML = $imgStr;
				}
			})
		}
		
		// DOM객체가 생성 이후 추천 여부 체크 => 결과값에 따른 css
		(function(){
			console.log("세션 닉네임 확인: " + sessionNickname);
			if(sessionNickname){
				$.ajax({
					url: "boardLikeitCheck.do",
					type: "GET",
					data: {
						boardLikeNick :  sessionNickname,
						boardNo : boardNo
					},
					contentType: "application/text; charset=utf-8",
					dataType : "text",
					success: function(res){
						$('.hiddenLikeValue').val(res);
						console.log("화면 로드 이후 res 값: " + res);
						if(res == 1){
							$(".fa-arrow-up").css("color", "lightblue");
						} else if(res == -1){
							$(".fa-arrow-down").css("color", "lightblue");	
						} 
					},
					error : function(res){
						console.log('res 실패 확인' + res);
					}
				})
			}
		}());
	})
</script>
<script>
//제이쿼리 충돌 방지 
var newJquery = $.noConflict(true);
var $$ = newJquery; 

// 새로운 jQeury 식별자를 사용해야 한다. 
$$(document).on("ready", function(){
	
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
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
// 	    ['insert',['picture','link']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];

 	// 객체형식으로 설정을 구성.
var setting = {
 			value : '',
           height : 150,
           minHeight : 100,
           maxHeight : 200,
           focus : true,
           placeholder : '무분별한 욕설과 비난은 자제해주세요',
           lang : 'ko-KR',
           toolbar : toolbar, // toolbar 설정은 위에서 해놓음. 
           callbacks : { 
           	// summernote에서 제공하는 콜백함수 중 하나. onImageUpload
           	onImageUpload : function(files, editor, welEditable) {
           			for (var i = files.length - 1; i >= 0; i--) {
           					uploadSummernoteImageFile(files[i], this);
           			}
           	}
           }
  	};
   // 위 설정대로 summernote를 <textarea> 부분에 호출시킨다. 
 	$$('#summernote').summernote(setting);
	
 	
   // 이미지업로드 콜백함수 정의
 	function uploadSummernoteImageFile(file, el) {
		// 이때 파라미터로 되어있는 el의 값은 이미지 업로드가 발생한 <textarea>태그를 의미한다. 
		console.log(file);
	   	var data = new FormData();
		data.append("file", file);
		$$.ajax({
			data : data,
			type : "POST",
			url : "ajaxUploadSummernoteImageFile.do",  // 컨트롤러에서 처리해야 함
			contentType : false, // multipart/form-data 형식으로 보낼 때는 contentType:을 false로. 
			enctype : 'multipart/form-data',
			processData : false,
			success : function(responseData) {
				console.log("responseData 확인: " + responseData);
				console.log("responseDate.url 확인: " + responseData.url);
				$$(el).summernote('insertImage', responseData.url);
			}
		});
	}
   
 	var bnoValue = '<c:out value="${board.boardNo}" />';
	console.log("bnoValue 값(글번호) 확인: "  + bnoValue);
	
	// 댓글 list가  append()될 박스
	const replyBox = $$(".boardReplyList");
	
	
	// 댓글 리스트 전체 브라우저에 출력
	replyService.replySelectList( {bno:bnoValue}, function(list){
		
		console.log(list); // pagination, list 두 배열 객체가 리턴된 상황
		var pagination = list.pagination;
		var replyList = list.list;
		
		// sessionNickname 
		// 댓글 출력되는 부분.  board_reply_depth의 값이 2인 경우에는 별도로 구분할 수 있는 속성을 하나 더 추가.			
		$$.each(replyList, function(index, item){
			var str = "";
			// depth의 값에 따라 class속성의 값을 다르게 해서 스타일을 구분
			if( item.board_Reply_Depth == 2){
				str += "<div class='addedReplyBox addedReReplyBox'><div>"			
			} else {
				str += "<div class='addedReplyBox'><div>";
			}
			str += "<br><div class='boardReplyListHeader'>";
			str += "<div class='replyerInfo'><span class='replyerNickname'>" + item.board_Reply_Replyer  + "</span><br>";
			str += "<span class='replyerWdate' style='font-size: small;'>" + item.board_Reply_Wdate  + "</span></div>";
			// 로그인한 유저의 닉네임과 작성자가 같으면 '삭제', '수정' 버튼 활성화
			if(sessionNickname == item.board_Reply_Replyer){
				str += "<div class='replyerBtns'><button type='button' class='replyUpdateBtn'>수정하기</button>"; 
				str += "<button type='button' class='replyDeleteBtn' " + "data-rno='" + item.board_Reply_Rno + "'>삭제하기</button></div>";
			}
			str += "</div></div>";
			str += "<div class='boardReplyListContents'>" + item.board_Reply_Content + "</div>";
			str += "<div class='boardReplyListFooter'>";
			// 로그인 상태면 대댓글 달기 가능
			if( sessionNickname != "" &&  item.board_Reply_Depth == 1){ 
				str += "<a class='boardReReplyBtn' href='#'>댓글 달기</a>";
			}
			if(item.board_Reply_Group > 1){
				str += "<a class='boardReplyShow' href='#'>대댓글 보기</a>";
			}
			str += "</div><br><hr></div>";
			str += "</div>"  // End of 'addedReplyBox'  
			replyBox.append(str);	
		})
	})   // End of replySelectList
	
	
	// 대댓글 보기 버튼(추후에 구현 여부 결정)
	$$(document).on("click", ".boardReplyShow", function(e){
		e.preventDefault();
		console.log("대댓글 보기 버튼 클릭");
	})
	
	// 대댓글 작성폼 호출 버튼
	$$(document).on("click", ".boardReReplyBtn", function(e){
		e.preventDefault();
		console.log("대댓글 버튼 클릭");
		
		// 이미 활성 중인 창이 있으면 다시 호출하지 못하도록
		if( $$(".reReplyWriting").length > 0){
			alert("이미 작성 중인 대댓글이 있습니다.");
			return false;
		}
		
		// 원댓글(부모댓글) 조회 => 대댓글의 컬럼값. (board_Reply_Parent) => 작성하는 폼에 숨겨둔다.  
		var parentReplyRno = $$(e.target).closest('.addedReplyBox').find(".replyDeleteBtn").data('rno');
		
		var str = "<div>";
		str += "<div class='reReplyWriting'>";
		str += "<div class='reReplyWriterBox'><img src='${pageContext.request.contextPath}/resources/img/undraw_profile.svg' style='width: 40px; height: 40px; margin-top: 30px;'>";
		str += "</div>";
		str += "<div class='boardReplyWritingForm'><textarea class='reReplySummernote reReplyContents'></textarea></div>";
		str += "<div><button class='reReplyInsertBtn' type='button' value='" + parentReplyRno +  "'>등록</button>";
		str += "<button class='reReplyCancelBtn' type='button'>닫기</button>"
		str += "</div></div><hr></div>";

		console.log(str);
		$$(e.target).closest(".addedReplyBox").append(str);	
		$$(".reReplySummernote").summernote(setting);
	})
	
	
	/*
	 * 대댓글 등록 완료 버튼 (원글의 댓글번호도 같이 받는다.)
	*/
	$$(document).on("click", ".reReplyInsertBtn", function(e){
		console.log("대댓글 등록 버튼 클릭");
		
		// 부모 댓글 번호(board_Reply_Parent값, 부모댓글의 group값에 사용)
		var parentRno = $$(e.target).val();
		// 대댓글 작성자 이름
		var reReplyer = sessionNickname;
		// 대댓글 작성 내용
		var reReplyContent = $$(e.target).closest('.reReplyWriting').find('.reReplyContents').val();
		
		// 대댓글을 작성하는 경우에도, reply.insert 부분에 data를 넘기는데, => 기본적인 로직은 비슷하지만, 
		// 대댓글은 기본적으로 depth의 값이 2인 경우. 
		var reReplyData = {
				board_Reply_Bno : bnoValue,  // 글번호
				board_Reply_Replyer : reReplyer,  // 대댓글 작성자 
				board_Reply_Content : reReplyContent,  // 대댓글 내용
				board_Reply_Parent : parentRno,  // 부모댓글 댓글번호
				board_Reply_Depth : 2   // 댓글의 깊이. 본래 기본값1, 대댓글의 경우 2가 기본값.
		};
		console.log("전달할 데이터 조회: ");
		console.log(reReplyData);
		
		// 대댓글이 성공적으로 등록되었을 때, 지울 remove
		var removeDiv = $$(e.target).closest('.reReplyWriting').parent(); 
		console.log($$(removeDiv).parent().nextAll('.addedReplyBox:not(.addedReReplyBox)').first() );
		
		// 콜백함수를 다르게 해야 한다. 칸은 똑같지만, class속성을 다르게 해서 부모댓글과 구분되도록 한다. 
		replyService.replyInsert(reReplyData, function(jsonData){
			
			// 컨트롤러에서 string형태로 리턴했기 때문에 json형으로 핸들링하기 위해 파싱을 해주어야 한다. 
			jsonData = JSON.parse(jsonData);
			alert("대댓글이 등록되었습니다.");
			var str = "<div class='addedReplyBox addedReReplyBox'><div><br>";
			str += "<div class='boardReplyListHeader'>";
			str += "<div class='replyerInfo'><span class='replyerNickname'>" + sessionNickname  + "</span><br>";
			str += "<span class='replyerWdate' style='font-size: small;'>" + jsonData.wdate + "</span></div>";
			str += "<div class='replyerBtns'><button type='button' class='replyUpdateBtn' >수정하기</button>"; 
			str += "<button type='button' class='replyDeleteBtn' " + "data-rno='" +  jsonData.rno + "' data-parentrno='" + jsonData.parentRno + "'>삭제하기</button></div>";
			str += "</div></div>";
			str += "<div class='boardReplyListContents'>" + reReplyContent + "</div><div class='boardReplyListFooter'>";
// 			str += "<a class='boardReReplyBtn' href='#'>댓글 달기</a>";  // 추후에 구현
			str += "</div><br><hr></div></div>";
			
			// 기존의 대댓글 입력하는 창은 삭제  
			if( $$(removeDiv).parent().nextAll('.addedReplyBox:not(.addedReReplyBox)').first().length != 0){
				$$(removeDiv).parent().nextAll('.addedReplyBox:not(.addedReReplyBox)').first().before(str);
			} else if( $$(removeDiv).parent().nextAll('.addedReplyBox').length == 0 ){
				$$(removeDiv).parent().append(str);	
			} else if( $$(removeDiv).parent().nextAll('.addedReplyBox').length != 0 ){
				$$(removeDiv).parent().nextAll('.addedReplyBox').last().after(str);
			}
			removeDiv.remove();
			// 아래 append()의 대상을 수정해야 한다. 부모댓글 바로 다음 공간으로.
			
			// 콜백함수로 부모댓글의 group값도 증가시킨다. 모듈(reply.js)에 있는 함수를 이용 parentRno.
			var updateData = {
					parentRno : parentRno,
					value : 1
			}
			replyService.replyUpdateGroup(updateData, function(result){
				if(result == "success"){
					console.log("부모댓글 group update 성공");
				}else {
					console.log("부모댓글 group update 실패~~~~~")
				}
			})
			
		})
		
	})
	
	// 대댓글 작성 취소 버튼 정의 => 해당 div remove() 시키기
	$$(document).on("click", ".reReplyCancelBtn", function(e){
		console.log("대댓글 작성 취소 클릭");
		console.log($$(e.target));
		
		var calcelDiv = $$(e.target).closest('.reReplyWriting').parent();
		// 창 지워버리기
		calcelDiv.remove(); 
	})
	
	/*
	 * 댓글 등록 요청 부분
	*/ 
	$$('.boardReplyInsertBtn').on('click', function(){
		console.log("reply insert click!!");
		
		var boardReplyContents = $$('.boardReplyContents').val();
		if(boardReplyContents == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		// data 담기
		var replyData = {
					board_Reply_Replyer : sessionNickname,
					board_Reply_Bno : bnoValue,
					board_Reply_Content : boardReplyContents,
					board_Reply_Depth : 1
			}
		// 댓글 작성 내용 초기화
		$$('.summernote').summernote('reset');
		
		// 댓글 등록 함수 호출(data, 성공 시  callback)
 		replyService.replyInsert(
 			replyData,
 			function(jsonData){
 				jsonData = JSON.parse(jsonData);
 				var str = "<div class='addedReplyBox'><div><br>";
				str += "<div class='boardReplyListHeader'>";
				str += "<div class='replyerInfo'><span class='replyerNickname'>" + sessionNickname  + "</span><br>";
				str += "<span class='replyerWdate' style='font-size: small;'>" + jsonData.wdate + "</span></div>";
				str += "<div class='replyerBtns'><button type='button' class='replyUpdateBtn' >수정하기</button>"; 
				str += "<button type='button' class='replyDeleteBtn' " + "data-rno='" +  jsonData.rno + "'>삭제하기</button></div>";
				str += "</div></div>";
				str += "<div class='boardReplyListContents'>" + boardReplyContents + "</div><div class='boardReplyListFooter'>";
				str += "<a class='boardReReplyBtn' href='#'>댓글 달기</a></div><br><hr></div></div>";
				replyBox.append(str);
				
 				alert("댓글이 등록되었습니다.");	
 			} // End of Callback
 		) // End of Immediately function 
	}) // End of Insert function

	
	/*
	 *	댓글 삭제. 이때, 대댓글이 존재하면 삭제가 안 되도록 하는 조건 추가
	*/  
	$$(document).on('click', ".replyDeleteBtn", function(e){
		
		// 삭제할 댓글이 대댓글인 경우, 부모댓글번호를 가지고 있음. 해당 값을 호출
		var parentRno = 0;
		if($$(e.target).closest('.addedReplyBox').hasClass('addedReReplyBox')){
			parentRno = $$(e.target).closest('.addedReplyBox').find(".replyDeleteBtn").data("parentrno");
			console.log("================================= 대댓글이 삭제될 때만 생성되는 값 참조하는 부모 댓글 번호: " + parentRno);
		}
		console.log("이값 뭐임? " + $$(e.target).closest(".addedReplyBox").find(".addedReReplyBox").length);
		
		// 대댓글이 다음에 존재한다면 삭제가 안 되도록 한다. 
		if($$(e.target).closest('.addedReplyBox').next().hasClass('addedReReplyBox')
				&& !$$(e.target).closest('.addedReplyBox').hasClass('addedReReplyBox')
				|| $$(e.target).closest(".addedReplyBox").find(".addedReReplyBox").length > 0   ){
			alert("대댓글이 존재하는 경우, 댓글을 삭제할 수 없습니다.");
			return false;
		}
		
		var replyDelCheck = confirm("정말 댓글을 삭제하시겠습니까?");
		if(!replyDelCheck){
			return false;
		}
		
		// 삭제할 댓글번호 
		var replyRno = $$(e.target).data('rno');
		// 삭제 이후 지워질 댓글창 div			
		var addedReplyBox = $$(e.target).closest(".addedReplyBox");
		
		var deleteData = {
				boardNo : boardNo,
				replyRno : replyRno
		}
		replyService.replyDelete(deleteData, function(result){
 			console.log(result);
			
 			if(result === "success"){
 				alert("삭제되었습니다.");
				addedReplyBox.remove();
				
				if( parentRno != 0){
					// 콜백함수로 부모댓글의 group값도 증가시킨다. 모듈(reply.js)에 있는 함수를 이용 parentRno.
					var updateData = {
							parentRno : parentRno,
							value : -1
					}
					console.log(updateData);
					replyService.replyUpdateGroup(updateData, function(result){
						if(result == "success"){
							console.log("부모댓글 group update 성공");
						}else {
							console.log("부모댓글 group update 실패")
						}
					})
				}
				
				
 			}
 		}, function(err){
 			alert('Error~');
 		})
	}) // End of Delete function
	
	var updateData = {};
	var updateBox;
	
	// 댓글 수정하기 버튼
	$$(document).on("click", ".replyUpdateBtn", function(e){
	
		if ($$('.replyUpdatingWrapper').length > 0){
			alert("이미 수정 중인 내역이 존재합니다.");
			return false;
		}
		
		// 수정 전 댓글내용
		var originContent = $$(e.target).closest('.addedReplyBox').find('.boardReplyListContents').text();
		// 수정 댓글번호
		var originRno = $$(e.target).closest('.addedReplyBox').find('.replyDeleteBtn').data('rno');
		
		$$(e.target).closest('.addedReplyBox').children('div').css('display', 'none');
		 
		console.log("기존에 작성된 내용: " + originContent);
		console.log("수정할 댓글 번호: " + originRno);
		updateData.board_Reply_Rno = originRno;
		updateBox = $$(e.target).closest('.addedReplyBox').children('div');
		var str = "<div class='replyUpdatingWrapper'>";
		str += '<div class="boardReplyUpdating">';
		str += ' <div class="boardReplyWriterBox">';
		str += ' <img alt="" src="/leejava/resources/img/undraw_profile.svg" style="width: 40px; height: 40px; margin-top: 30px;">';
		str += ' </div>';
		str += ' <div class="boardReplyUpdatingForm">';
		str += ' <textarea class="reSummernote replyUpdatingContent"></textarea>';
		str += ' </div>';
		str += '<div>';
		str += ' <button class="ReplyUpdateCancelBtn" type="button">닫기</button>';
		str += ' <button class="ReplyUpdateBtn" type="button">수정완료</button>';
		str += '</div>';
		str += '</div><hr></div>';
		
		$$(e.target).closest('.addedReplyBox').append(str);
		
		// 중요한 부분. 동적으로 callbacks 속성에 함수를 추가한다.
		setting.callbacks.onInit = function() { 
			$$('.reSummernote').summernote('code', originContent)
		};
		
		$$('.reSummernote').summernote(setting);
		
	})
	
	// 수정 취소 버튼
	$$(document).on("click", ".ReplyUpdateCancelBtn", function(e){
		console.log("수정 취소 클릭");
		$$(e.target).closest('.addedReplyBox').children('div').css('display', 'block');
		$$(e.target).closest('.replyUpdatingWrapper').remove();
	})
	
	
	/*
	 *	댓글 수정 완료
	*/
	$$(document).on("click", ".ReplyUpdateBtn", function(e){
		console.log("수정 완료 클릭");
		updateData.board_Reply_Content = $$(e.target).closest('.replyUpdatingWrapper').find(".replyUpdatingContent").val();
		console.log(updateData);
		// 넘기는 값은 댓글번호(rno), 글내용(content), 수정일(매퍼상에서 처리);
		
		replyService.replyUpdate(updateData, function(result){
			$$(e.target).closest('.replyUpdatingWrapper').remove();
			updateBox.css('display', 'block');
			console.log("수정완료");
			alert("수정 완료...");
		})
		
		console.log(updateBox);
		console.log(updateBox.length);
		console.log(updateBox[1]);
		$$(updateBox[1]).text(updateData.board_Reply_Content);
		
	})

	// getSelect(특정 1개 댓글 조회)
//		replyService.replySelectOne(getData, function(data){
//			console.log(data);
//		})
	
})
</script>
</html>