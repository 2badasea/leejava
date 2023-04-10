<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style type="text/css">
.boardReadFormWrapper{
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
	min-height: 400px;
	height: auto;
}

.boardReadForm_file{
	display: flex;
	align-items: center;
	border-bottom: 0.5px solid lightgrey;
}
.boardReadFormWrapper button{
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

.boardReadFormWrapper button:hover{
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
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
            <br>
            <!--댓글공간 들어갈 폼-->
            <div class="boardReplyForm">

            </div>
        </div>
    </div>
</div>
<!-- 원본이미지를 화면에 출력시키기 위한 div --> 						
<div class='bigPictureWrapper'>
	<div class='bigPicture'>
			
	</div>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
<script>

	// 현재 로그인 중인 세션 닉네임
	var sessionNickname = $("#hiddenSessionInfo").data('nickname');
	
	// 이 페이지의 작성자, 글번호, 첨부파일 유무  
	const boardWriter = $(".boardReadFormHidden").data('nickname');
	const boardNo = $('.boardReadFormHidden').data('no');
	const bfileCheck = $(".boardReadFormHidden").data('file');
	
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
		// 삭제를 하면, 해당 게시글에 담긴 첨부파일도 모두 삭제되도록 한다. 첨부파일 존재 여부? 
		const deleteNumber = boardNo;
		let data = {
				boardWriter : boardWriter,
				boardNo : deleteNumber,
				bfileCheck : bfileCheck
		};
		console.log(data);
		if(bfileCheck !=0){
			console.log("첨부파일 존재");
			$.ajax({
				url:  "uploadfileDelete.do?boardNo=" + boardNo,
			    type: "GET",
			    async: "true",
			    contentType: "application/text; charset=utf-8",
			    dataType: "text",
			    success: function(res){
			    	console.log("res: " + res);
			    	// 첨부파일 삭제 이후 원 게시글 삭제 함수 호출.
			    	boardDelete(deleteNumber);
			    },
			    error: function(res){
			    	console.log("에러: " + res);
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
<script type="text/javascript">
	$(document).ready(function(){
		
		// 모듈(reply.js) 테스트
		console.log("=======================");
		console.log("JS TEST");
		
		var bnoValue = '<c:out value="${board.boardNo}" />';
		console.log("bnoValue 값 확인: "  + bnoValue);
		
		console.log(replyService);
		//댓글 전체 요청	
		replyService.replySelectList( {bno:bnoValue}, function(list){
			for(var i = 0, len = list.length || 0; i<len; i++){
				console.log(list[i]);
			} 
		})   // End of replySelectList
		
		// insert문. 실제 insert를 하기 위해선, 데이터를 필요한 데이터를 모두 담아야 한다. 
// 		replyService.replyInsert(
// 			{reply: "JS TEST", replyer : "tester", bno : bnoValue},
// 			function(result){
// 				alert("result: " + result);
// 			}
// 		)

		// delete문 (테스트를 위해 23)
// 		replyService.replyDelete(23, function(count){
// 			console.log(count);
			
// 			if(count === "success"){
// 				alert("REMOVED");
// 			}
// 		}, function(err){
// 			alert('Error~');
// 		})

		// update(댓글 수정)
// 		replyService.replyUpdate(updateData, function(result){
// 			alert("수정 완료...");
// 		})

		// getSelect(특정 1개 댓글 조회)
// 		replyService.replySelectOne(getData, function(data){
// 			console.log(data);
// 		})
		
		
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
</html>