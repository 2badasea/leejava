<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 공지사항 조회 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
.noticeReadFormWrapper {
	margin-top: 1%;
	margin-left: 15%;
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
span{
	font-weight: 900;
	
}
.noticeFormBody{
	padding: 10px;
	min-height: 400px;
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
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 900;	
	min-width: 100px;
	min-height: 40px;
}
.noticeReadFormBtns button:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.attachedFileIcon:hover {
	cursor: pointer;
}
</style>

</head>
<body>
<!-- 공지사항 조회하는 폼 디자인 해야 함. -->
	<div class="memberNoticeRead_wrapper">
            <div class="noticeReadFormWrapper">
                <div class="noticeForm">
                	<input class="noticeInputData" type="hidden" data-file="${notice.n_file }" data-no="${notice.n_no }">
                    <div class="noticeFormHeader">
                   		<div class="noticeFormHeaderLeft" style="display: flex;">
                   			<div class="userImageBox">
	                   			<img src="resources/image/loopy.jpeg" class="noticeUserImage" onclick="fn_userInfo('${notice.n_writer}')">
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
					<button type="button" class="noticeReadFormBackBtn">목록보기</button>
				</div>
            </div>
	</div>
</body>
<script>
	// 이전 페이지 이동
	$(".noticeReadFormBackBtn").on("click", function(){
		history.back(); 
	});
	
	// 첨부파일 아이콘 클릭 => 첨부파일 다운로드 
	$(".attachedFileIcon").on("click", function(){
		// attr()메서드를 통해 해당 속성값을 가져와서 페이지 이동시킴 
		var url = $('.noticeFileName').attr("href");
		location.href = url;
	})
	
	/**
	 * 작성자 정보 조회 이벤트 핸들러 => 아직 미구현(모달창 활용하여 사용자 정보를 출력시키기)
	 * @Param userNickname(사용자 닉네임)
	 */
	function fn_userInfo(userNickname){
		console.log("해당 유저의 이름: "  + userNickname);
	}
</script>
<script>	
	$(document).ready(function(){
		
		// 카테고리 우리말로 변환	
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
		
		// 첨부파일 존재유무에 따른 아이콘 활성화 유무 
		var fileName = $(".noticeInputData").data('file');
		if( fileName == ""){
			$(".attachedFileIcon").css("display", "none");
			$(".emptyFileMessage").css("display", "block");			
		}
	})
</script>
</html>