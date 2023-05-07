<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.sidebarTemplete_wrapper {
	background-color: #05AA6D;
	min-height: 100vh; 
}
.sidebar_menu a{
	margin-top: 10px;
	text-decoration: none;
	font-size: large;
	font-weight: 600;
	color: whitesmoke;
}
.sidebar_menu a:not(.quizcard):hover{
	color: coral;
}
.quizcard:hover{
	color: #2E3856;
}
.sidebar_logo_image {
	width: 30px;
}
.sidebarSiteName {
	float: right;
	padding-top: 10px;
}
.sidebarSiteName span {
	padding-right: 25px;
}
.sidebar_menu {
}


#mainMenu {
	list-style-type: none;
}
.subMenuTitle{
	font-size: x-large;
	font-weight: 700;
	margin-top: 20px;
	color: coral;
}
/* todolist 모달창 관련 스타일 속성 들어가는 공간.  */
#todoUl {
    list-style: none;
    padding-left: 0px;
}
.todo_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none; 
    z-index: 20;
}

.todo_modal_content {
    position: absolute;
    bottom: 10%;
    right: 10%;
    width: 550px;
    height: auto;
    z-index:22;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 25px;
}

.todo_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 21;
    background-color: lightgray;
    opacity: 0.5;
    transition: 0.5s;
}

.todo_modal_body {
    border-top: 0.2px dotted #05AA6D;
}
.todo_modal_body{
	padding-top: 10px;
	padding-bottom: 10px;
}
.todo_modal_footer {
    display: flex;
    justify-content: end;
}
.todo_inputBox {
    bottom: 10px;
    margin-right: 15px;
} 
#todoInput,  /* todolist 입력하는 태그 */
.todoInputList{	/*	todolist 출력하는 태그 */
	width: 80%;
	height: 30px;
	font-size: 15px;
	font-weight: 600;
	margin-bottom: 5px;
	border-style: none;		
	border-bottom: 0.5px solid #05AA6D;
}

#todoInput {
	margin-top: 10px;
	border-bottom: 0.5px solid coral;
}

.todoInputList{
	font-size: 15px;
	font-weight: 700;
}
#todoInput:focus,
.todoInputList:focus{
	outline-color: coral;
}
#todoInput::placeholder{
	color: lightgray;
}

.modalOpen{
	border-radius: 30px;
	border-style: none;
	min-width: 100px;
	width: auto; 
	height: 80px;
	margin-top: 55%;
	background-color: white;
	color: #05AA6D;
	font-weight: 700;
	font-size: x-large;
	padding: 20px;
}
.modalOpen:hover{
	cursor: pointer;
	background-color: coral; /* coral, salmon, darkorange */
	color: white;
	transition: 0.3s;
}
.todoBtn,
.todoDeleteBtn{
	margin-left: 15px;
	width: auto;
	height: auto;
	border-style: none;
	border-radius: 20px; 
	background-color: white;
	color: #05AA6D;
	font-weight: 700;
}
.todoDeleteBtn{
}

.todoBtn:hover,
.todoDeleteBtn:hover{
	cursor: pointer;
	background-color: white;
	color: coral;
	transition: 0.3s;
}


.inputCheck{
	margin-right: 10px;
	margin-top: 10px;
	height: 20px;
	width: 20px;
}
.inputCheck:hover{
	cursor: pointer;
}
#todoBoxCloseBtn{
	margin-top: 10px;
	margin-right: 30px;
	min-width: 70px;
	min-height: 40px;
	width: auto;
	height: auto;
	border-style: none;
	font-weight: 600;
	font-size: medium;
	padding: 10px;
	background-color: whitesmoke;
	border-radius: 20px;
	color: #05AA6D;
}
#todoBoxCloseBtn:hover{
	cursor: pointer;
	background-color: coral;
	color: white;
	transition: 0.3s;
}
}
#todoUl li{
	margin-bottom: 7px;
}
/*	*************************************	*/

/* 특별히 강조효과를 주고 싶은 경우에 사용할 효과*/
.specialA:hover{
	cursor: pointer;
}
.specialA{
text-decoration: none;
   display: inline-block;
   -webkit-transition: 0.3s;
   -moz-transition: 0.3s;
   -o-transition: 0.3s;	
   -ms-transition: 0.3s;
   transition: 0.3s;
}

.specialA:hover {
    -webkit-transform: scale(1.5,1.5);
    -moz-transform: scale(1.5,1.5);
    -o-transform: scale(1.5,1.5);
    -ms-transform: scale(1.5,1.5);
    transform: scale(1.5,1.5);
}

.speicalTitle{
	color: #05AA6D;
	font-weight: 500;
}


.todolistTitleSpan{ 
	font-size: xx-large;
	font-weight: 900;
	color: coral;
	font-style: italic;
}
.todoInputSpan{
	font-style: italic;
	color: coral;
	font-weight: 700;
	font-size: large;
	padding: 5px;
}
#todolistBox{
	margin-bottom: 8px; 
}
.helpCommentSpan{
	/* 디자인 요소와 별개로 스크립트 단에서 이벤트를 많이 생성해야 함.*/
	font-size: 14px;
	color:	#05AA6D;
	font-style: oblique;
}
.helpCommentLabel{
	font-size: 14px;
	color: black;
	font-style: oblique;
}
/* 사이드바 영역 유저정보에 대한 레이아웃 스타일 */
.sidebar_userInfo{
	border-bottom: 0.3px dotted lightgray; 
	padding-bottom: 100px;
	padding-top: 20px;
}
.sidebar_logo_image{
	width: 50px;
	height: auto;
}
.sidebar_userInfo button{
	min-width: 100px;
	width: auto;
	padding-top: 5px;
	padding-bottom: 5px;
	min-height: 20px; 
	height: auto;
	border-style: none;
	background-color: white;
	color: #05AA6D;
	border-radius: 10px;
	margin-top: 8px;
	font-weight: 800;
	
}
.sidebar_userInfo button:hover {
	cursor: pointer;
	background-color: coral;
	color: white;
	transition: 0.3s;
}
/*	******************************	*/
.uploadResult:hover {
	cursor: pointer;
}
.uploadResult img{
	max-height: 100px;
	max-width: 100px;
}
</style>
</head>
<body>
<!-- 파일 업로드를 위한 게시판 유형 구분 hidden 태그. 자유게시판은 data-board 1 -->
<input type="hidden" id="hiddenSessionInfo" data-nickname=${session_nickname }>
<input type="hidden" id="fileboardInput" data-board="1">
<div class="sidebarTemplete_wrapper">
		<div class="sidebar_userInfo" align="center">
<!-- 			<a href="home.do"> -->
				<div class="uploadResult" onclick="location.href='home.do'">
								
				</div>
<!-- 			</a> -->
			<c:if test="${empty session_user}">
				<div class="sidebar_beforeLogin" >
					<span>안녕하세용</span>
					<br>
					<button type="button" class="sidebar_loginBtn">Login</button>
					<br>
					<button type="button" class="sidebar_memberJoinBtn">Join Us</button>
				</div>
			</c:if>
			<c:if test="${not empty session_user }">
				<div class="sidebar_afterLogin">
					<span>${session_nickname}님 안녕하세요.</span>
					<br>
					<button type="button" class="myInfoBtn">My Info</button>
					<br>
					<button type="button" class="logoutBtn">Logout</button>
				</div>
			</c:if>
		</div>
		<br>
		
		<div class="sidebar_menu" align="center">
			<ul id="mainMenu">
				<c:if test="${session_user == \"bada\" or session_status eq 'ADMIN'}">
					<li>
						<a href="adminPage.do" class="sideMenu adminMenu" style="font-size: large; color: #2E3856; margin-bottom: 10px;">
							관리자 화면
						</a>
					</li>
				</c:if>
				<li><a href="quizcard.do" class="quizcard" style="font-size: large; color:#2E3856;">퀴즈카드 학습</a></li>
				<li class="subMenuTitle">커뮤니티</li>
					<li><a href="memberNoticeList.do" class="sideMenu community">공지사항</a></li>
					<li><a href="boardList.do" class="sideMenu community">자유게시판</a></li>
					<li><a href="#" class="sideMenu community">QNA</a></li>
					<li><a href="#" class="sideMenu community">정보/팁</a></li>
					<li><a href="#" class="sideMenu community">스터디/정기모임</a></li>
			</ul>
		<!-- 로그인해서 세션값이 존재하는 유저만 button이 보이도록 한다. -- -->
		<c:if test="${not empty session_user }">
			<button type="button" class="modalOpen">todolist</button>
		</c:if>
		</div>
		
		<!-- ************ To do List 모달창 들어가는 공간 ************ -->
 	  	 <div class="todo_modal_container">
	        <div class="todo_modal_content">
	        	<!--  modal header 영역  -->
	            <div class="todo_modal_header" align="center">
	                <span class="todolistTitleSpan">To Do List For ${session_user }</span>
	                <input type="hidden" id="m_email" value="${session_user}">
	            </div>
	            <!--modal body 영역 -->
	            <div class="todo_modal_body">
	                    <!--여기 안에 입력했던 요소들이 생성된다. -->
	                    <div id="todolistBox" align="center">
	                        <ul id="todoUl">
	
	                        </ul>
	                    </div>
	                    <div class="todo_inputBox"  align="center">
	                    	<span class="todoInputSpan">New</span>
	                        <input type="text" id="todoInput" placeholder="input your today goal" maxlength="25">
	                        <button type="button" id="todoBtn" class="todoBtn specialA">추가</button>
	                   		<label for="helpCommentSpan" class="helpCommentLabel">*도움말</label>
	                   		<span class="helpCommentSpan" id="helpCommentSpan">투두리스트는 최대 5개까지 등록할 수 있습니다.</span>
	                    </div>
	            </div>
	            <!--modal footer 영역 -->
	            <div class="todo_modal_footer">
	                <button id="todoBoxCloseBtn" class="todoBoxCloseBtn">창닫기</button>
	            </div>
	        </div>
	        <div class="todo_modal_layer"></div>
   		 </div>
		<!-- --------------모달창 끝나는 공간---------------- -->
</div>  <!-- 가장 바깥 div끝 (sidebarTemplete_wrapper)  -->
</body>
<script>
	//email값을 이용하여 get.JSON url을 호출하여 db에 있는 프로필 이미지 정보를 가져와서 화면에 뿌려준다.
	var imageemail = $("#m_email").val();
	var uploadResult = $(".uploadResult");
	if(imageemail !== ''){
		$.getJSON("getAttachList.do", { m_email : imageemail}, function(arr){
			if(arr.fileName == null){
				// 이미지가 없을 경우 => 기본이미지가 출력되도록 한다.
				console.log("이미지가 없음");
				let str = "";
				str += "<div id='basic_result_card'>";
				str += "<img src='resources/image/userimage.jpg'>";
				str += "</div>";
				uploadResult.html(str);
				return;
			}
			let obj = arr[0];
			// 반대로 호출되는 이미지 정보가 있는 경우. 
			let str = "";
			console.log(obj);
			let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			console.log("fileCallPath 값: " + fileCallPath);
			str += "<div id='basic_result_card'";
			str += " data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" +  obj.fileName + "'";
			str += ">";
			str += "<img src='display.do?fileName=" + fileCallPath + "'>";
			str += "</div>";
			uploadResult.html(str);
		}) // get.JSON 메서드 영역 끝  ( get.JSON으로 회원의 이미지 정보를 출력하여 display.do로 화면에 출력시킨다.)
	} else {  
		// 일단은 임시로 로그인하지 않은 경우 => 기본 이미지를 출력시키도록 한다.
		let str = "";
		str += "<div id='basic_result_card'>";
		str += "<img src='resources/image/userimage.jpg'>";
		str += "</div>";
		uploadResult.html(str);
	}


	// 로그인 페이지 띄우기
	$(".sidebar_loginBtn").on("click", function(){
		location.href="loginPage.do";
	})
	 
	// 로그아웃 처리   click function 			
	$(".logoutBtn").click(function(){
		var logoutCheck = confirm("로그아웃 하시겠어요?");
		if(logoutCheck){
			location.href="logout.do";
		} else {
			return false;
		}
	})
	
	// 회원가입 페이지 이동 
	$(".sidebar_memberJoinBtn").on("click", function(){
		alert("회원가입 페이지로 이동하겠습니다.");
		location.href='memberJoinTerms.do';
	})
	
	// 개인정보 조회하는 공간으로 이동
	$(".myInfoBtn").on("click", function(){ 
		location.href='memberMyInfo.do'; 
	})
	
	/***************  <To Do List> Modal Script ***************/
	// todolist 입력창에 포커스를 주면, 테두리 색깔 coral로 변경시키기
	
	
	$("#todoBtn").on("click", function () {
		// m_eamil은 ajax로 todolist dB값 조회하기 위한 용도
		let m_email = $("#m_email").val();
    	let $todoNum = $(".todoDeleteBtn").length;
    	
	    if ($todoNum < 4) {
	        console.log("button num check : " + $todoNum);
	        var $todoInput = $("#todoInput").val();
	        console.log("입력한 값 확인: " + $todoInput);
	        if ($todoInput.length === 0) {
	            alert("toodlist를 입력하세요");
	            // 여기에 datainsert ajax문을 입력해야 한다. 
	           		// 코드가 길어질 것 같아서 함수를 정의한다. 
	            return false;
	        }
	        ajaxInsert(m_email, $todoInput);
	    } else if ($todoNum === 4) {
	        console.log("button num check : " + $todoNum);
	        var $todoInput = $("#todoInput").val();
	        console.log("입력한 값 확인: " + $todoInput);
	        if ($todoInput.length === 0) {
	            alert("To Do List를 입력하세요");
	            return false;
	        }
	        ajaxInsert(m_email, $todoInput);
	        $(".todo_inputBox").css("display", "none");
	    }
	}) // todoInput의 갯수가 5개가 되면 자동으로 todo_inputBox가 비활되도록 함.
	
	// ajaxInsert(m_email, $todoInput) 함수 정의
	function ajaxInsert(m_email, todo_content){
		console.log("입력값 확인: " + m_email + ", " + todo_content);
		// ajax를 호출한다.
		$.ajax({
			url: "ajaxInsert.do",
			data: {
				m_email : m_email,
				todo_content : todo_content
			},
			type: "POST",
			dataType: "json",
			success: function(data){
				console.log("성공. 날라온 data를 조회해보자")
				// 이제 알겠다 => 나의 경우 반환받는 json이 list자료구조다 => 인덱스로 접근해보자 
				console.log(data);
				console.log("넘어온 data에 대해 참조연산자를 통해 각각의 값을 조회해본다.");
				console.log(data[0].todo_no);
				console.log(data[0].todo_content);
				console.log(data[0].todo_status);
				console.log("조회 끝 ");
		        var $no = data[0].todo_no;
		        var $content = data[0].todo_content;
		        var $status = data[0].todo_status;
				var str ="";
				str += "<li><input type='checkbox' class='inputCheck'>";
				str += "<input type='text' data-no='"+ $no +"' data-status='"+$status+"' value='"+$content+"' class='todoInputList' maxlength='25' readonly='readonly' >";
				str += "<button class='todoDeleteBtn speicalA'>삭제</button><br></li>";				
				console.log("str값 확인: " + str);
				$("#todoUl").append(str);
				$("#todoInput").val('');
			},
			error: function(){
				console.log("통신 중 에러 발생");
			}
		})
	}

	// 이제 리스트중 하나를 삭제했을 때의 이벤트를 생각해야 한다. 
	$(document).on("click", '.todoDeleteBtn', function (e) {
	    // 기본이벤트 submit()을 비활성화시킨다. 
	    e.preventDefault();
	    // 지웠을 경우 => deletebtn의 갯수가 4개가 되면 다시 todo_inputBox요소를 생성한다.
	     // 먼저 ajax로 해당 요소의 no값을 구하여, m_email값과 함께 db로 날린다. 
	    var todo_no = $(this).prev().data('no'); // 예상대로면, <input>태그가 가지고 있는 value값이 반환되어야 한다. 
		var m_email = $("#m_email").val();
	    /// ajax로  todo_no값과  m_email값을 넘긴다. 
		$.ajax({
			async: false,
			url: "ajaxTodoDelete.do?m_email=" + m_email + "&todo_no=" + todo_no,
			type: "GET",
			success: function(result){
				console.log(result);
				if( result === "OK"){
					console.log("정상적으로 삭제 성공");
				}else {
					alert("System 오류. 관리자에게 문의바람");
				}
			}
		})
		$(this).closest('li').remove();
	    let $todoNum = $(".todoDeleteBtn").length;
	    if ($todoNum === 4) {
	        $(".todo_inputBox").css("display", "block");
	    }
	
	})

	// 모달창 닫기 버튼 => 어차피 다시 열어도 db값을 호출한 상태로 나열된다. 
	$("#todoBoxCloseBtn").on("click", function () {
		$("#todoInput").val('');
	    // json데이터를 제외한 단숞 입력요소들은 모두 지우도록 한다. 
	    $("#todoUl > li").remove();
	    $(".todo_modal_container").css("display", "none");
	    $(".modalOpen").css("display", "block");
	})
	
	// 외부입력으로 todolist모달창 닫을 수 있도록 구현하기
	$(document).on("click", function(e){
		if( $(e.target).closest('.todo_modal_content').length == 0  && !$(e.target).hasClass("todoBoxCloseBtn")
				&& !$(e.target).hasClass("modalOpen") && !$(e.target).hasClass("todoDeleteBtn") ){
			$('.todoBoxCloseBtn').click();
		}
	})

	// todolist 입력 후 엔터키로 목록에 추가시키기
	$("#todoInput").keydown(function(e){
		if(e.keyCode == 13){
			// 마찬가지로 단순 엔터를 입력하면 submit()이벤트가 발생해 새로고침이 이 루어진다. 
				// 해당 기본이벤트를지우고, (+)클릭이벤트를 발생시킨다.
			e.preventDefault();
			$("#todoBtn").click();
		}
	})
	
	
	// 모달창 열기  => 모달창을 열면서 ajax를 호출하여 데이터를 삽입해야 한다. 루핑 돌면서 반복적으로 <ul>태그 밑으로 요소들을 집어넣는다. 
	$(".modalOpen").on("click", function () {
    	$(".modalOpen").hide();
 	  	// sidebar에 있는 session값을 m_email에 담자.
  	 	var m_email = $("#m_email").val();
  	  	// ajax를 호출해보자 호출해서 db에 있는 데이터를 가져와야 한다. 
    	//방식은 일단 일반적인 ajaxㅎ방식으로 호출한다. =>
  	  	
	    $.ajax({
	    	async: false,
	        url: "ajaxTodolist.do",
	        dataType: "json",
	        type: "GET",
	        data: {
	        	m_email : m_email
	        },
	        success: function (data) {
	            console.log(data);
	            $.each(data, function(index, item){
	            	var $no = item.todo_no;
	            	var $content = item.todo_content;
	            	var $status = item.todo_status;
	            	console.log("확인: " + $no + " , " + $content + " , " + $status);
	            	var str = "";
					str += "<li><input type='checkbox' class='inputCheck'>";
					str += "<input type='text' data-no='"+ $no +"' data-status='"+$status+"' value='"+$content+"' class='todoInputList' maxlength='25' readonly='readonly'>";
					str += "<button class='todoDeleteBtn specialA'>삭제</button><br></li>";				
					console.log("str값 확인: " + str);
					$("#todoUl").append(str);
					// 그리고 요소가 5개가 되면 자동으로 inptubox 요소를 비활성화 시킨다. 일단 어떻게 되는지 테스트. 
					if( $(".todoDeleteBtn").length === 5){
						$(".todo_inputBox").css("display", "none");
					}
	            	
	            })
	        }
	    })  
	    // 그리고 출력했을 때, db상태의 값이 active인 경우엔  checkbox와 <input>태그의 text에 효과를 준다.
	    $("input[data-status='active']").css("text-decoration", "line-through");
	    $("input[data-status='active']").prev().prop("checked", true);
	   
	    // ajax로 데이터를 먼저 다 추출한 다음에 요소에 집어넣고 화면출력.
	    $(".todo_modal_container").css("display", "block");
	})
	
	
	// checkbox 클릭이벤트 생성 => data-status값 업데이트 시키고, 스타일 속성을 부여한다. 라이브 이벤트 적용 ㄱㄱ
	$(document).on("click", ".inputCheck", function(){
		var $todoInput = $(this).next();
		var todo_no = $todoInput.data('no');
		var todo_status;
		var m_email = $("#m_email").val(); 
		// no값이랑 메일값을 넘긴다. 
		if( $(this).is(":checked") ){
			todo_status = "active";			
		} else {
			todo_status = "non-active";
		}
		// ajax로 3값을 모두 넘긴다. => 결과에 따라? 
		$.ajax({
			async: false,
			url: "ajaxTodoUpdate.do",
			type: "POST",
			data: {
				m_email : m_email,
				todo_status : todo_status,
				todo_no : todo_no
			},
			success: function(result){
				console.log("result값 확인: " + result);
				if( result === "active"){
					$todoInput.data('status', 'active');
					$todoInput.css("text-decoration", "line-through");
				} else if(result === "non-active"){
					$todoInput.data('status', 'non-active');
					$todoInput.css("text-decoration", "none");
				}
			}
		})
	})
	
	// todolist 수정 이벤트 => 더블클릭 후 활성화. 그리고 엔터키를 입력하면 ajax업데이트 
	$(document).on("dblclick", ".todoInputList", function(){
		// 클릭을 하더라도 if문능로 구분해야 한다 => 클릭한 요소의 data-status값에 따라서. 
		if( $(this).data('status') === 'active') {
			$(this).prev().click();
			$(this).attr("readonly", false).focus();
		} else {
			$(this).attr("readonly", false).focus();
		}
	})
	
	// todoinputlist에 클릭을 주면 도움말의 메시지와 색상을 변경시킨다. 기본적으로 가려놓기   span의 class속성값 helpCommentSpan
	$(document).on("mouseover", ".todoInputList", function(){
		$('.helpCommentSpan').css("color", "coral");
		$(".helpCommentSpan").text('더블클릭하면 수정할 수 있습니다. (최대 25자)');
	})
	
	// #todoInput에 클릭을 하면 
	$(document).on("mouseover", "#todoInput", function(){
		$('.helpCommentSpan').css("color", "coral");	
		$(".helpCommentSpan").text("최대 25자까지 입력이 가능합니다.");
	})
	
	// 체크박스에 마우스를 올리면 또 하나 더 추가
	$(document).on("mouseover", ".inputCheck", function(){
		// 체크박스 위에 마우스를 올리는 경우에도 도움말 코멘트 추가. 
		$('.helpCommentSpan').css("color", "coral");	
		var str  = "체크박스를 클릭하면 완료표시가 됩니다.";
		$(".helpCommentSpan").text("체크박스를 클릭하면 완료표시가 됩니다.");
	})
	
	// 마우스가 위에 3개에 아무 곳에도 올라가 잇지 않은 경우에는 원래의 메시지를 출력시킨다
	$(document).on("mouseleave", ".todoInputList, #todoInput, .inputCheck", function(){
		$('.helpCommentSpan').css("color", "#05AA6D");	
		$(".helpCommentSpan").text("투두리스트는 최대 5개까지 등록할 수 있습니다.");
	})
		
	// 그리고 업데이트 발생시키기 엔터키 입력하면. 
	$(document).on("keyup", ".todoInputList", function(e){
		e.preventDefault();
		var $todoInput = $(this);
		var m_email = $("#m_email").val();
		var todo_no = $(this).data('no');
		var todo_content = $(this).val();
		if(e.keyCode ==13){
			// 엔터키가 입력되면 해당 이벤트가 발생한 곳의 no값과 contet값, 그리고 m_email값을 가져와서 ajax로 날린다.
			console.log("입력값들 확인: " + m_email + ", todo_no : " + todo_no + " , todo_content: " + todo_content);
			// ajax호출
			$.ajax({
				url: "ajaxTodoUpdate.do",
				type: "POST",
				data: {
					m_email : m_email,
					todo_no : todo_no,
					todo_content : todo_content
				},
				success: function(result){
					console.log("업데이트 결과 조회: " + result);
					if(result === "OK"){
						$todoInput.val(todo_content);
						$todoInput.attr("readonly", true);
					}
				}
			})
		}
	})
</script>
<script>
	// 문서가 모두 로드되면 실행시킬 이벤트 정의
	$(document).on("ready", function(){
		$(".sidebar_menu a").addClass("specialA");
	})
</script>
</html>