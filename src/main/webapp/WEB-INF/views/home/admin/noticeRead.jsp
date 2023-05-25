<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
.noticeReadFormWrapper {
	margin-top: 7%;
	margin-left: 10%;
	margin-bottom: 10%;
}
/* 새로운 공지사항 폼 */
.noticeForm{
	border: 0.5px solid lightgray;	
	width: 950px;
}
.noticeFormHeaderLeft{
	float: left;
}
.noticeFormHeaderRight{
	float: right;	
}

hr{
	border: 0 none;
	height: 0.1px;
	background-color: lightgray;
	width: 100%;
	text-align: center;
}
.noticeFormHeaderHr{
	width: 100%;
}
.noticeReadFormWrapper span{
	font-weight: 900;
	
}
.noticeFormBody{
	padding: 10px;
	min-height: 300px;
	width: 98%; 
	height: auto;
}
.noticeFormHeader{
	min-height: 100px;
	height: auto;
	padding: 15px;
}
.noticeUserImage{
	width: 40px;
	height: 40px;
}
.noticeTitle{
	margin-top: 20px;
}
.noticeNo,
.noticeCategory,
.noticeWdate{
	color: lightgray;
}
.noticeWriter{
	color: #05AA6D;
	font-weight: 900;
	font-size: 17px;
}
.noticeFileName{
	font-size: 12px;
}
.noticeFormFooter table {
	border: 1px solid lightgray;
}
.noticeFormFooter td{
	padding: 10px;
}
.noticeFormFooter th{
	border-right: 1px solid lightgray;
	padding-left: 10px;
	padding-right: 10px;
}
img,
.noticeWriter:hover{
	cursor: pointer;
}
.noticeFormFooter{
	min-height: 30px;
	padding: 15px;
}
.attachedFileIcon{
	font-size: 30px;
}
/* *********************** */
.noticeReadFormBtns{
	padding-top: 30px;
	padding-bottom: 30px;
	padding-left: 52%;
}
.noticeReadFormBtns button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#313348;
	background-color: whitesmoke;
	font-weight: 900;	
	min-width: 100px;
	min-height: 40px;
}
.noticeReadFormBtns button:hover {
	cursor: pointer;
	background-color: #313348;
	color: whitesmoke;
	transition: 0.5s;
}
.attachedFileIcon:hover {
	cursor: pointer;
}

</style>
</head>
<body>
	 <div class="noticeRead_wrapper">
            <div class="noticeReadFormWrapper">
                <div class="noticeForm">
                	<input class="noticeInputData" type="hidden" data-file="${notice.n_file }" data-no="${notice.n_no }">
                    <div class="noticeFormHeader">
                   		<div class="noticeFormHeaderLeft" style="display: flex;">
                   			<div class="userImageBox">
	                   			<img alt="" src="resources/image/loopy.jpeg" class="noticeUserImage" onclick="fn_userInfo('${notice.n_writer}')">
                   			</div>
                   			<div class="userNameWdateBox" style="margin-left: 10px;">
                           		<a class="noticeWriter" onclick="fn_userInfo('${notice.n_writer}')">${notice.n_writer }</a>
                            	<br>
                            	<span class="noticeWdate">${notice.n_wdate }</span>
                            </div>
                       </div>
                       <div class="noticeFormHeaderRight">
                            <i class="fa-solid fa-eye"></i>
                            <span class="noticeHit">${notice.n_hit }</span>
                       </div>
                            <br>
                            <hr class="noticeFormHeaderHr">
                            <span class="noticeNo">#${notice.n_no }</span>
                            &nbsp;&nbsp;&nbsp;
                            <span class="noticeCategory">${notice.n_category }</span>
                            <h2 class="noticeTitle">${notice.n_title }</h2>
                    </div>
                    <hr>
                    <div class="noticeFormBody">
                        ${notice.n_content }
                    </div>
                    <hr>
                    <div class="noticeFormFooter">
                    	<table>
                    		<tr>
                    			<th>
                    				첨부파일
                    			</th>
                    			<td style="width: auto; text-align: center;">
                    				<h5 class="emptyFileMessage" style="display: none; margin-top: 15px;">첨부파일 없음</h5>
									<i class="fa-solid fa-file-arrow-down attachedFileIcon"></i>
                    				<br>
                    				<a class="noticeFileName" id="noticeFileName" href="noticeFileDownload.do?filename=${notice.n_file }&pfilename=${notice.n_pfile }">${notice.n_file }</a>
                    			</td>
                    		</tr>
                    	</table>
                    </div>
                </div>
	             <div class="noticeReadFormBtns">
					<button type="button" class="noticeReadFormUpdateBtn">수정하기</button>
					<button type="button" class="noticeReadFormBackBtn">목록보기</button>
				</div>
            </div>
        </div>
</body>
<script>
	// 첨부파일 아이콘 클릭 => 첨부파일 다운로드
	$(".attachedFileIcon").on("click", function(){
		// attr()메서드를 통해 해당 속성값을 가져와서 페이지 이동시킴 
		var url = $('.noticeFileName').attr("href");
		location.href = url;
	})

	// 작성자 정보 조회하는 이벤트 정의 => 공지사항의 경우 작성자는 운영자. 
	function fn_userInfo(userNickname){
		console.log("해당 유저의 이름: "  + userNickname);
		console.log("추후에 해당 유저의 정보를 호출하는 모달창 생성해서 구현");
		// 추후에 해당 유저의 정보를 호출하는 모달창 생성해서 구현
	}
	
	// 수정하기 버튼
	$(".noticeReadFormUpdateBtn").on("click", function() {
		var no = $(".noticeInputData").data('no');
		location.href = 'noticeFormUpdate.do?n_no='+ no;
	})

	// 돌아가기 버튼
	$(".noticeReadFormBackBtn").on("click", function() {
		history.back();
	})
</script>
<script>
	// 문서가 로드되면 자동으로 실행시킬 이벤트들 정의
	$(document).on("ready", function(){
		
		/*	카테고리 우리말로 변환	*/
		var category = $(".noticeCategory").text();
		// 경우의수는 all, emergency, event 3가지다. 
		var fixedCategory;
		if(category === "all"){
			fixedCategory = "전체";
		} else if(category === "emergency"){
			fixedCategory = "긴급";
		} else if(category === "event"){
			fixedCategory = "이벤트";
		} else {
			fixedCategory = "전체";
		}
		$(".noticeCategory").text(fixedCategory);
		
		/* 첨부파일 존재유무에 따른 아이콘 활성화 유무 */ 
		var fileName = $(".noticeInputData").data('file');
		if( fileName == ""){
			$(".attachedFileIcon").css("display", "none");
			$(".emptyFileMessage").css("display", "block");			
		}
	})
</script>
</html>