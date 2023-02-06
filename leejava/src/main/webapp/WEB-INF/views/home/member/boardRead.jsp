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
	min-height: 450px;
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
	text-decoration: underline;
}

.fileListA:hover{
	color: coral;
	cursor: pointer;
	font-weight: bold;
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
	            	<div style="width: 90%;  border-left: 0.5px solid lightgrey; padding-left: 10px;">
	            		<c:if test="${not empty fileList }">
	            			<ul>
	            				<c:forEach items="${fileList}" var="file">
	            					<li class="fileListLi" style="list-style: none;">
	            						<a class="fileListA" data-uuid="${file.fileUuid }" data-path="${file.fileUploadpath }">${file.fileOriginname }</a>
	            					</li>
	            				</c:forEach>
	            			</ul>
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
</body>
<script>
	const boardWriter = $(".boardReadFormHidden").data('nickname');
	const boardNo = $('.boardReadFormHidden').data('no');
	const bfileCheck = $(".boardReadFormHidden").data('file');
	
	// 첨부파일 다운로드
	$('.fileListA').on('click', function(e){
		const fileUuid = $(e.target).data('uuid');
		const uploadPath = $(e.target).data('path');
		const originName = $(e.target).text();
		$.ajax({
			url: "boardFileDown.do",
			data: {
				fileUuid: fileUuid,
				fileUploadpath : uploadPath,
				fileOriginname : originName
			},
			type: "POST",
			success: function(res){
				console.log("성공"  );
			},
			error: function(res){
				console.log("실패");
			}
			
		})
	})
	
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
	
	// 추천수 -
	$('.boardLikeitDown').on("click", function(){
		console.log("추천수 하락");
	})	
	
	// 추천수 + 
	$('.boardLikeitUp').on("click", function(){
		console.log("추천수 상승");
	})
	
		
	// 목록으로 돌아가기
	$(".boardListBackBtn").on("click", function() {
		location.href = "boardList.do";
	});
</script>
</html>