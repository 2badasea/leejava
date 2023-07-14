<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 대기 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<!-- summernote를 위해 필요한 부분 -->
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
<style>
/* 퀴즈카드 학습모드 선택 모달창 */
.quizcardInfoWrapper {
	margin-top: 4%;
	margin-left: 5%;
}
textarea{
	resize: none;
}
.quizcardInfo {
    width: 35%;
}

.quizcardQuestion {
    margin-top: 5px;
}

.questionNameBox {
    width: 40%;
    height: 400px;
    background-color: #0A092D;
    color: white;
}

.questionName {
    font-size: x-large;
    font-weight: bolder;
}

.questionArrow {
    width: 35%;
    text-align: center;
    font-size: larger;
    font-weight: bolder;
}

.quizcardIntro {
    width: 40%;
}

.quizcardIntroArea {
    width: 95%;
    resize: none;
    border-radius: 20px;
    padding: 10px;
}

.beforeA{
	color: black;
}
        
.studyType_modal_container {
   position: fixed;
   top: 0px;
   bottom: 0px;
   width: 100%;
   height: 100vh;
   display: none;
   z-index: 1;
}

.studyType_modal_content {
    position: absolute;
    top: 30%;
    left: 35%;
    width: 400px;
    height: auto;
    z-index: 3;
    background-color: white;
    color: #2E3856 ;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.studyType_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
	background-color: #2E3856;
    opacity: 0.8;    
    transition: 2s;
}

fieldset {
    border: 1px solid white;
}
.questionBtns{
	width: 40%;
	display: flex;
	justify-content: flex-end;
}
.questionBtns button {
	margin-right: 10px;
	color: teal;
	background-color: whitesmoke;
	border-style: none;
	width: 120px;
    height: 40px;
    border-radius: 20px;
    font-size: 15px;
}
.questionBtns button:hover{
	 cursor: pointer;
     background-color: teal;
     color: white;
     transition: 1s;
}
.bookmark{
	color: tomato;
}
#addStar{
	font-size: 25px;
	display: none;
}
#emptyStar{
	font-size: 25px;
	display: none;
}
.quizcardIntro img {
	width: 20px;
	height: 20px;
}
.setCreaterClickA{
	margin-left : 10px;
	color: teal;
}
#modalHeader{
	font-size: 20px;
	font-weight: bold;
}
legend{
	font-size: 20px;
	font-weight: bold;
}
#quizcardDate{
	color: teal;
}
/* 사용자 정보 조회하는 모달창 */
.userInfo_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.userInfo_modal_content {
    position: absolute;
    top: 20%;
    left: 30%;
    width: 700px;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 30px;
}

.userInfo_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: grey;
    opacity: 0.3;
    transition: 2s;
}
.userInfoModalCloseBtn{
	margin-top: 50px;
    float: right;
    width: 100px;
    height: 50px;
    border-radius: 20px;
    background: whitesmoke;
    color: teal;
    border-style: none;
    font-size: 20px;
    font-weight: bold;
}
.userInfoModalCloseBtn:hover{
	cursor: pointer;
	background-color: teal;
	color: white;
	transition: 1s;
	
}
.userInfo_modal_body{
    display: flex;
}
.profileImg{
	width: 200px;
	height: 200px;
	border-style: none;
}
.userInfo_quizcardTb{
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 10px;
}
#basic_result_card{
	display: flex;
	justify-content: center;	
	border: 0.2px solid lightgray;
	width: 80%;
	height: 200px;
}
.userInfo_image img{
	text-align: center;
	min-width: 100px;
	min-height: 100px;
	width: auto;
	height: auto;
}
.userInfo_quizcardTr{
	border-bottom: 0.5px dashed teal;
	margin-top: 3px;
}
.userInfo_quizcardTr:hover{
	cursor: pointer;
}
.userInfoFieldset{
	border: 1px solid teal;
}
.userInfo_modal_footer{
	margin-bottom: 10%;
}
.userInfo_right{
	width: 60%;
}
.userInfo_right textarea {
	width: 95%;
	height: 95%;
	border-radius: 20px;
	padding: 8px;
}
.userInfo_modal_content input {
	border-style: none;
	font-size: 18px;
	color: teal;
	font-weight: bolder;
}
.reReplyInsertBtn,
.updateBtns button,
.replyBtns button,
.quizcardMainGoBtn,
.studyType_modal_container button {
	border-radius: 20px;
    width: auto;
    max-height: 40px;
    color: teal;
    background-color:  whitesmoke;
    border-style: none;
    padding: 10px;
}
.reReplyInsertBtn:hover,
.updateBtns button:hover,
.replyBtns button:hover,
.quizcardMainGoBtn:hover,
.studyType_modal_container button:hover {
	cursor: pointer;
    background-color: teal;
    color: whitesmoke;
    transition: 1s;
}
.quizcardMainGoBtn{
	height: auto;
	width: auto;
	margin-left: 50px;
}
/* 댓글 관련 스타일 */
.quizcardReplyWrapper{
    width: 40%;
}
.quizcardReplyWriting{
	display: flex;
	justify-content: space-around;
	padding: 15px;
}
.quizcardReplyInsertBtn{
	border-radius: 20px;
	border-style: none;
	padding: 10px; 	
	width: auto;
	height: auto;
	color: 	teal;
	background-color: whitesmoke;
	min-width: 70px;
	min-height: 30px;
	margin-right: 5%;
	width: 100px;
	height: 40px;
}
.quizcardReplyInsertBtn:hover{
	cursor: pointer;
	background-color: teal;
	color: whitesmoke;
	transition: 0.5s;
}
.quizcardReplyWriterBox{
	width: 10%;
	margin-left: 3%;
}
.quizcardReplyWritingForm {
	width: 85%;
}
/* 댓글리스트 footer <a>태그 스타일 */
.reReplyWriteBtn, .reReplyListShowBtn, .replyFormToggle{
	color: gray;
	font-size: smaller;
	text-decoration: none;
}
.replyListUserInfo{
	display: flex;
}
.replyListHeader{
	display: flex;
	justify-content: space-between;
}
.replyListBox{
	margin-bottom: 3%;
	border-bottom: 0.5px solid lightgray;
	padding: 2%;
}
.updateListBox{
	margin-bottom: 3%;
	border-bottom: 0.5px solid lightgray;
	padding: 2%;
}
.replyerImage{
	max-width: 40px;
	max-height: 40px;
	margin-top: 5%;
    border-radius: 50%;
}
.replyBtns {
	width: 20%;
    display: flex;
    justify-content: space-evenly;
}
.replyListContent{
	min-height: 50px;
    width: 80%;
    padding: 15px;
    font-size: small; 
}
.delReplyBox{
	max-height: 30px;
}
.updateListBox{
	display: flex;
	justify-content: space-evenly;
}
.updateBtns{
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
    align-items: inherit;
}
.replyUdate {
	font-size: small; 
	color : teal; 
	font-weight : 800;
}
.quizcardReplyWritingBox{
	border: solid 1px lightgray;
	border-radius: 20px;
}
/************대댓글 박스 디자인 ***************/
.reReplyListBox{
	width: 90%;
}
.reReplyWritingbox{
	margin-left: 5%;
	border-left: solid 1px gray;
	margin-top: 2%;
}
.reReplyWritingForm{
	padding-left: 5%;
	padding-top : 2%;
	display: flex;
}
.reReplyUserInfo{
	width: 10%;
}
</style>
</head>
<body>
<input type="hidden" id="quizcardBeforeSetNo" value="${qvo.quizcard_set_no }" data-category="${qvo.quizcard_category }" data-setname="${qvo.quizcard_set_name }">
<div class="quizcardInfoWrapper">
        <div class="quizcardInfo">
            <h1>${qvo.quizcard_set_name }</h1>
	            <p>
	                <span id="category"><b>카테고리</b> -  ${qvo.quizcard_category }</span>&nbsp;&nbsp;
	                <span><b>문제유형</b> - ${qvo.quizcard_type }</span>&nbsp;&nbsp;&nbsp;
	                <br>
	                <label for="bookmark"><b>즐겨찾기 여부</b></label>
	                <a id="starClick" class="beforeA bookmark">
	                	<i id="addStar" class="fa-solid fa-star add" ></i>
	                	<i id="emptyStar" class="fa-regular fa-star empty"></i>
	                </a>
	                <br>
	                <label for="quizcardDate" class="quizcardDate"><b>생성 날짜/마지막 업데이트</b></label>
	                <span id="quizcardDate"class="quizcardDate">${qvo.quizcard_set_cdate } / ${qvo.quizcard_set_udate }</span>
	           		<button type="button" class="quizcardMainGoBtn">돌아가기</button>
	            </p>
        </div>
        <div class="quizcardQuestion">
            <div class="questionNameBox">
                <p class="questionName"></p>
            </div>
            <br>
            <div class="questionArrow">
                <a class="prevQuestion beforeA"><i class="fa-solid fa-angle-left"></i></a>
                <span class="questionNo"></span> / <span>${quizcardQuestionCount }</span>
                <a class="nextQuestion beforeA"><i class="fa-solid fa-angle-right"></i></a>
            </div>
            <div class="questionBtns">
                <button class="quizcardStartBtn">학습하기</button>
                <input type="hidden" id="dataInput" data-setno="${qvo.quizcard_set_no }" data-questioncount="${quizcardQuestionCount }">
                <c:if test="${session_user eq qvo.m_email }">
					<button class="updateQuizcardBtn">수정 / 단어추가</button>
				</c:if>
            </div>
        </div>
        <br>
        <div class="quizcardIntro">
            <h3><b>퀴즈카드 만든이</b>  <a class="setCreaterClickA"><img src="resources/image/loopy.jpeg">${qvo.m_nickname }</a></h3>
            <textarea class="quizcardIntroArea" cols="30" rows="10" readonly="readonly">${qvo.quizcard_set_intro }</textarea>
        </div>
        <!-- 퀴즈카드 댓글 작업 공간 -->
        <br><br><br>
        <div class="quizcardReplyWrapper">
            <!-- 댓글 작성폼 : 로그인 유저만 노출 -->
            <c:if test="${not empty session_user }">
            	<div class="quizcardReplyWritingBox">
            		<div style="display: flex; padding: 15px;">
	            		<div class="quizcardReplyWriterBox">
			     			<img alt="" src="${pageContext.request.contextPath}/resources/img/undraw_profile.svg" style="width: 40px; height: 40px; margin-top: 30px;">
			     		</div>
				     	<div class="quizcardReplyWritingForm">
				     		<textarea class="summernote" class="quizcardReplyContents"></textarea>
				     	</div>
			     	</div>
	  	            <!-- 댓글 작성 버튼 공간 -->
	            	<div style="display: flex; justify-content: end; padding-bottom: 2%;">
	            		<button class="quizcardReplyInsertBtn" type="button">댓글등록</button>
	            	</div>
            	</div>
            	<br>
            	<br>
            </c:if>

            <!-- 댓글 리스트 폼 -->
            <div class="quizcardReplyListBox">
        		
        	</div>
        </div>
</div>
    <!-- 위에가 새로운 레이아웃 -->
	<!-- 퀴즈카드 학습모드 모달창 -->
      <div class="studyType_modal_container">
        <div class="studyType_modal_content">
            <div class="studyType_modal_header">
                <span id="modalHeader" data-setno="${qvo.quizcard_set_no }">선택한 세트번호: ${qvo.quizcard_set_no } </span>
            </div>
            <br>
            <hr>
            <br>
            <div class="studyType_modal_body">
                <fieldset>
                    <legend>학습방식</legend>
                    <input type="radio" id="order" name="studyType" value="order" checked>
                    <label for="order">순차형</label>
                    <input type="radio" id="random" name="studyType" value="random">
                    <label for="random">랜덤형</label>
                </fieldset>
            </div>
            <br>
            <div class="studyType_modal_footer">
                <button id="studyStartBtn" style="display: block; margin:auto;">학습시작!</button>
                <button id="studyTypeCloseBtn" style="float: right; min-width : 80px;">취소</button>
            </div>
        </div>
        <div class="studyType_modal_layer"></div>
    </div>
    <!-- ----------------------------------------------- -->
    <!-- 사용자 정보 조회하는 모달창  -->
    <div class="userInfo_modal_container">
        <div class="userInfo_modal_content">
            <div class="userInfo_modal_header">
                <span id="userInfoTitle">(사용자 닉네임)님의 정보</span>
            </div>
            <div class="userInfo_modal_body">
                <div class="userInfo_left">
                    <div class="userInfo_image">
<!--                     	<img class="profileImg"  alt="사진을 준비중입니다." src="resources/image/loopy.jpeg"> -->
                    </div>
                    <div class="userInfo_subInfo">
                        <label for="m_nickname">닉네임</label>
                        <input type="text" id="m_nickname" value="" readonly="readonly">
                        <br>
                        <label for="m_joinDate">가입날짜</label>
                        <input type="text" id="m_joindate" value="" readonly="readonly">
                    </div>
                </div>
                <div class="userInfo_right">
                    <label for="userIntroForm" id="userIntroLabel"></label>
                    <div class="userInfo_IntroForm">
                        <textarea id="userIntroForm" cols="30" rows="15" readonly="readonly"></textarea>
                    </div>
                </div>
            </div>
            <br>
            <hr>
            	<fieldset class="userInfoFieldset">
	            	<legend>작성한 퀴즈카드</legend>
	               	<div class="userInfo_quizcard">
	               		
	               	</div>
            	</fieldset>
            <br>
            <div class="userInfo_modal_footer">
                <button class="userInfoModalCloseBtn">닫기</button>
            </div>
        </div>
        <div class="userInfo_modal_layer"></div>
    </div>
    <!-- ----------------------------------------------- -->
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quizcardBefore.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/quizcardReply.js?v=<%=System.currentTimeMillis() %>"></script>
<script>

// 퀴즈카드 댓글 작업 스크립트 => 작업 후에 quizcardBefore.js 파일로 코드 이동
// 댓글 작성 폼 quizcardReplyWritingBox 
// 댓글 리스트 폼 quizcardReplyListBox
// 세트번호  const thisSetNo
// 세션 유저 const session_user

// 제이쿼리 충돌 방지
var newJquery = $.noConflict(true);
var $$ = newJquery; 
	
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
	    //['insert',['picture','link']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];
	console.log(toolbar);
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
 	console.log(setting);
    // 위 설정대로 summernote를 <textarea> 부분에 호출시킨다. 
 	$$('.summernote').summernote(setting);
 	
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
  	
  	// 퀴즈카드 댓글 전체 출력시킬 <div> 박스
  	var quizcardReplyListBox = $$('.quizcardReplyListBox');
  	
  	$$(document).on('mouseover mouseout', '.reReplyWriteBtn, .reReplyListShowBtn' , function(event){
  		if(event.type ==='mouseover'){
  			$$(this).css('color', 'blue');
  		}else if(event.type === 'mouseout'){
  			$$(this).css('color', '');  // 원래 색상으로 되돌리기. 
  		}
  	})
  	
  	// 대댓글 달기 => 기능 구현 후 아래쪽으로 소스코드 옮겨놓기 
  	$$(document).on('click', '.reReplyWriteBtn', function(e){
  		e.preventDefault();
  		if( $$(this).hasClass('reReplyCancel')){
  			$$(this).text('댓글 달기');
  			$$(this).closest('.replyListBox').find('.reReplyWritingbox').remove();
  			$$(this).removeClass('reReplyCancel');
  			return false;
  		}
  		
  		let reReplyFormCheck = $$('.reReplyWritingbox').length;
  		if(reReplyFormCheck != 0){
  			alert('이미 작성 중인 댓글이 존재합니다.');
  			return false;
  		}
  		$$(this).text('입력 취소');
  		let parentNo = $$(this).data('parentno'); // 대댓글 등록 시 넘길 모댓글번호값. 
  		
  		let reReplyBox = $$(this).closest('.replyListBox').children('.reReplyListBox');
  		console.log(reReplyBox);
  		
  		let reListHtml = "";
  		reListHtml += "<div class='reReplyWritingbox'>";
		reListHtml += 	"<div class='reReplyWritingForm'>";
		reListHtml += 		"<div class='reReplyUserInfo'>";
		reListHtml +=			"<img class='replyerImage' src='resources/image/userimage.jpg' >";
		reListHtml += 		"</div>";
		reListHtml += 		"<div>";
		reListHtml +=			"<textarea class='reReplyContent'></textarea>";
		reListHtml += 		"</div";
		reListHtml +=	"</div>";
		reListHtml += 	"<div style='float: right; margin-top:3%;'>";
		reListHtml +=		"<button type='button' class='reReplyInsertBtn' data-parentno='" + parentNo + "'>댓글 등록</button>";
		reListHtml +=	"</div>";
		reListHtml += "</div>"
		$$(this).addClass('reReplyCancel');
		reReplyBox.append(reListHtml);
		$$(".reReplyContent").summernote(setting).focus();
  	})
  	
  	// 대댓글 등록insert => ajax로 넘기는 url은 동일
  	$$(document).on('click', '.reReplyInsertBtn', function(){
  		console.log('대댓글 등록 클릭');
  		// 전송할 데이터 5가지(모댓글rno, 대댓글내용, 대댓글작성자, depth값2, 퀴즈카드세트번호)
  		let reReplyer = session_user;
  		let reContent = $$(this).closest('.reReplyWritingbox').find('.reReplyContent').val();
  		if(reReplyer == null){
  			alert('세션이 만료되었습니다.');
  			location.href = 'loginPage.do';
  		}
  		if(reContent.trim().length == 0 || reReplyer == null ){
  			alert('댓글을 작성해주세요');
  			return false;
  		}
  		let reParentNo = $$(this).data('parentno');
  		let reDepth = 2;
  		let quizcardSetNo = thisSetNo;
  		
  		
  		// 등록완료 콜백함수 때,  sumernote에디터를 초기화 시킨다  .summernote('reset');
  		let data = {
  			quizcard_Reply_Parent : reParentNo,
  			quizcard_Reply_Content : reContent,
  			quizcard_Reply_Depth : reDepth,
  			quizcard_Reply_Replyer : reReplyer,
  			quizcard_Reply_Bno : quizcardSetNo
  		};
  		
  		console.log(data);
  		
  	})
  	
  	// 해당 퀴즈카드 게시글에 해당하는 댓글 전체 출력
  	quizcardReplyService.replySelectList(thisSetNo, function(list){
  		console.log(list);
  		console.log('로그인 중인 세션 닉네임 : ' +  session_user);
  		
  		$$.each(list, function(index, item){
  			var listHtml = "";
  			let content = item.quizcard_Reply_Content; 
  			if(content == null){
  				// 내용이 공백인 경우 => 삭제된 댓글 => 최소한의 내용만 출력
  				listHtml += "<div class='replyListBox delReplyBox'>";
  				listHtml += 	"<div class='replyListBody'>";
  				listHtml += 		"<div class='replyListContent'>" + "( 삭제된 댓글입니다... )" + "</div>";
  				listHtml += 	"</div>";
  				listHtml += "</div>";
  				quizcardReplyListBox.append(listHtml);
  			}else { // 내용이 공백이 아닌 경우 => 일반 댓글
	  				listHtml += "<div class='replyListBox'>";
	  				listHtml += 	"<div class='replyListHeader'>";
	  				listHtml += 		"<div class='replyListUserInfo'>"; 
	  				listHtml += 			"<div class='userInfoImage'>";
	  				listHtml += 				"<img class='replyerImage' src='resources/image/userimage.jpg'>";
	  				listHtml += 			"</div>";
	  				listHtml += 			"<div style='margin-left: 5%;'>";
	  				listHtml += 				"<span class='replyerNickname'>" + item.quizcard_Reply_Replyer + "</span><br>";
	  				listHtml += 				"<span class='replyWdate' style='font-size: small;'>" + item.quizcard_Reply_Wdate + "</span>";
	  			if(item.quizcard_Reply_Udate != null){
	  				listHtml +=					"<br><span class='replyUdate'>" + '수정됨' + "</span>";						
	  			}
	  				listHtml += 			"</div>"; 
	  				listHtml += 		"</div>"; // userInfo 끝
	  			if(item.quizcard_Reply_Replyer == session_user){
	  				listHtml += 		"<div class='replyBtns'>";
	  				listHtml += 			"<button type='button' class='replyUpdateBtn'>댓글 수정</button>";
	  				listHtml += 			"<button type='button' class='replyDeleteBtn' data-rno='"  + item.quizcard_Reply_Rno + "'>삭제</button>";
	  				listHtml += 		"</div>";
	  				listHtml +=		"</div>"     // header부분 끝
	  			}else {
	  				listHtml += "	</div>";  // header 부분 끝
	  			}
	  				listHtml += 	"<div class='replyListBody'>";
	  				listHtml += 		"<div class='replyListContent'>" + item.quizcard_Reply_Content + "</div>";
	  				listHtml += 	"</div>"; // body 끝
	  				listHtml += 	"<div class='replyListFooter'>";
	  			if(session_user != '' && item.quizcard_Reply_Depth == 1){
	  				listHtml += 		"<a class='reReplyWriteBtn' href='#' data-parentno='" + item.quizcard_Reply_Rno +  "'>댓글 달기</a>&nbsp;&nbsp;&nbsp;";
	  			}
	  			if(item.quizcard_Reply_Group > 1){
	  				listHtml += 		"<a class='reReplyListShowBtn' href='#'>대댓글 보기</a>";
	  			}
	  				listHtml += 	"</div>";    // footer 끝 
	  				listHtml += 	"<div class='reReplyListBox'>"; // 대댓글 작성 && 대댓글리스트 출력시킬 폼 
	  				listHtml +=		"</div>";  
	  				listHtml +=	"</div>";  // 댓글리스트 개별 박스 닫기
	  			quizcardReplyListBox.append(listHtml);
  			} // End of  if문(삭제된 댓글인지 아닌지 판단)
  		}) // End of  $$.each
  		
  		
  	})
  	
  	// 퀴즈카드 댓글 등록
  	$$(".quizcardReplyInsertBtn").on('click', () => {
  		console.log('댓글 등록 버튼 클릭');
  		var replyContents = $$('.summernote').val();
  		if(replyContents.trim().length == 0){
  			alert("댓글 내용을 입력해주세요");
  			return false;
  		}
  		var replyInsertInfo = {
  				quizcard_Reply_Bno : thisSetNo,
  				quizcard_Reply_Depth : 1,
  				quizcard_Reply_Content : replyContents,
  				quizcard_Reply_Replyer : session_user
  		};
  		
	  	quizcardReplyService.replyInsert(replyInsertInfo, function(data){
	  		// 입력한 댓글 내용 초기화
	  		console.log('댓글 등록 성공');
	  		$$('.summernote').summernote('reset');
	  		console.log(data);
	  		// 입력한 댓글 내용을 아래 댓글리스트에 출력시키는 작업
	  		let rno = data.quizcard_Reply_Rno;
			let wdate = data.quizcard_Reply_Wdate;
			let content = data.quizcard_Reply_Content;
			let writer = data.quizcard_Reply_Replyer;
	  		
			let listHtml = "";
				listHtml += "<div class='replyListBox'>";
				listHtml +=		"<div class='replyListHeader'>";
		  		listHtml += 		"<div class='replyListUserInfo'>"; 
				listHtml += 			"<div class='userInfoImage'>";
				listHtml += 				"<img class='replyerImage' src='resources/image/userimage.jpg'>";
				listHtml += 			"</div>";
				listHtml += 			"<div style='margin-left: 5%;'>";
				listHtml += 				"<span class='replyerNickname'>" + writer + "<br>";
				listHtml += 				"<span class='replyWdate' style='font-size: small;'>" + wdate;
				listHtml += 			"</div>"; 
				listHtml += 		"</div>";
				listHtml += 		"<div class='replyBtns'>";
				listHtml += 			"<button type='button' class='replyUpdateBtn'>댓글 수정</button>";
				listHtml += 			"<button type='button' class='replyDeleteBtn' data-rno='" + rno + "'>삭제</button>";
				listHtml += 		"</div>";
				listHtml += 	"</div>";   // header끝
				listHtml += 	"<div class='replyListBody'>";
				listHtml += 		"<div class='replyListContent'>" + content + "</div>";
				listHtml += 	"</div>"; // body 끝
				listHtml += 	"<div class='replyListFooter'>";
				listHtml += 		"<a class='reReplyWriteBtn' href='#'>댓글 달기</a>&nbsp;&nbsp;&nbsp;";
// 				listHtml += 		"<a class='reReplyListShowBtn' href='#'>대댓글 보기</a>";
				listHtml += 	"</div>";  // footer끝
				listHtml += "</div>"; 
			quizcardReplyListBox.append(listHtml);
			alert("댓글 등록 성공~");
	  	})
  	})
  	
  	
  	// 퀴즈 카드 댓글 삭제
	$$(document).on('click', '.replyDeleteBtn', function(){
		console.log('댓글 삭제 클릭');
		let delNo = $$(this).data('rno');
		console.log('삭제할 댓글 번호 : ' + delNo);
		let replyBox = $$(this).closest('.replyListBox');
		console.log('삭제 후 공백을 붙일 박스 : ' + replyBox);		
		quizcardReplyService.replyDelete(delNo, function(response){
			console.log(response);
			if(response == 'success'){
				replyBox.empty();  // 해당 선택자 내부의 모든 태그 요소를 지움.
				let str = "";
				str += 	"<div class='replyListBody delReplyBox'>";
				str += 		"<div class='replyListContent'>" + "( 삭제된 댓글입니다... )" + "</div>";
				str += 	"</div>";
				replyBox.append(str);
				alert('댓글이 삭제되었습니다.');
			}else {
				alert('댓글 삭제가 실패했습니다.');
			}
		})
	})	
	function Fn_updateCancel(){
		console.log('수정 취소 클릭 이벤트 발생');
	}
	
  	
	// 퀴즈카드 댓글 수정 => 수정 폼 생성
	$$(document).on('click', ".replyUpdateBtn", function(){
		console.log('수정 버튼 클릭');
		let updateBoxCount = $$(".updateListBox").length; 
		if(updateBoxCount > 0){
			alert('이미 수정 중인 댓글이 존재합니다 \n작업을 마무리 해주세요');
			return false;
		}
		let updateCheck = confirm('댓글을 수정하시겠어요?');
		if(!updateCheck){
			return false;
		}
		
		let rno = $$(this).next().data('rno');
		let content = $$(this).closest('.replyListBox').find('.replyListContent').text();
		
		let hideBox = $$(this).closest('.replyListBox');

		let listHtml  = "";
			listHtml += "<div class='updateListBox'>";
			listHtml += 	"<div class='updateContentBox'>";
			listHtml += 		"<textarea class='updateContentForm" + rno + "'>" + content + "</textarea>";
			listHtml += 	"</div>";
			listHtml +=		"<div class='updateBtns'>";
			listHtml +=   		"<button type='button' class='updateEndBtn' data-rno='" + rno + "'>수정완료</button>";			
			listHtml +=			"<button type='button' class='updateCancelBtn'>취소</button>";	
			listHtml +=		"</div>";
			listHtml += "</div>";
		hideBox.after(listHtml);
		
		let selector = ".updateContentForm" + rno;
		$$(selector).summernote(setting);
		
		hideBox.css('display', 'none');
	})
	
	// 수정 취소 이벤트를 동적으로 부여하기
	$$(document).on('click', ".updateCancelBtn", function(){
		// none상태인 수정 전의 기존 댓글 내역 활성화
		$$('.quizcardReplyListBox').find('div[style*="display: none;"]').css('display', 'block');
		$$(this).closest('.updateListBox').remove();
	})
	
	// 수정 완료 이벤트도 동적으로 부여해보기
	$$(document).on('click', '.updateEndBtn', function(){
		let updateBox = $$(this).closest('.updateListBox');
		let rno = $$(this).data('rno');
		let updateContent = $$(this).closest('.updateListBox').find('textarea').val();
		console.log('수정 완료 댓글 번호 : ' + rno);
		console.log('수정 완료 댓글 글내용 : ' + updateContent);
		let data = {
				quizcard_Reply_Rno : rno,
				quizcard_Reply_Content : updateContent 
		};
		quizcardReplyService.replyUpdate(data, function(response){
			// 업데이트 성공 이후 실행시킬 콜백
			console.log('성공여부: ' + response);  // 'success' 출력 확인
			if(response == 'success'){
				$$(updateBox).remove();
				let updatedBox = $$('.quizcardReplyListBox').find('div[style*="display: none;"]');
				$$(updatedBox).find('.replyListContent').html(updateContent);
				$$(updatedBox).css('display', 'block');
			}
		})
		
	})
	
	
	
})  // End $$(document).on~~
</script>
</html>