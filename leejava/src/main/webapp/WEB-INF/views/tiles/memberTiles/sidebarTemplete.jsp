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
.sidebar {
	background-color: #05AA6D;
	min-height: 100vh; 
}
.sideWrap {
	padding: 20px;
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
.sidebar_beforeLogin {
	margin-top: 20px;
}
.sidebar_menu {
	margin-top: 100px;
}
#sidebar_loginBtn, 
#sidebar_memberJoinBtn, 
#logoutBtn{
	height: 30px;
}
#mainMenu, 
#subMenu {
	list-style-type: none;
}
#subMenu > li {
	padding-left: 20px;
	display: none;
}
.sidebar_menu > li, ul {
	margin-top: 20px;
}
.sidebar_menu > a {
	text-decoration: none;
}
/* 모달창 관련 스타일 속성 들어가는 공간.  */
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
            z-index: 1;
        }

        .todo_modal_content {
            position: absolute;
            bottom: 10%;
            right: 10%;
            width: 500px;
            height: auto;
            z-index: 3;
            background-color: white;
            border: 0.5px solid #05AA6D;
            border-radius: 30px;
            padding: 20px;

        }

        .todo_modal_layer {
            position: relative;
            width: 100%;
            height: 100%;
            z-index: 2;
            background-color: transparent;
            transition: 2s;
        }


        .todo_modal_footer,
        .todo_modal_body {
            border-top: 0.2px solid #05AA6D;
        }

        .todo_modal_footer {
            display: flex;
            justify-content: end;
        }


        #todoInput {
            bottom: 5px;
        }

        .todo_inputBox {
            bottom: 10px;
        } 
        #todoInput,
        .todoInputList{
        	width: 400px;
        	height: 30px;
        	font-size: 15px;
        }
        #modalOpen{
        	width: 70px;
        	height: 70px;
        	background-color: #82F0F0;
        	color: black;
        }
        #modalOpen:hover{
        	cursor: pointer;
        }
        .todoDeleteBtn{
        	margin-left: 10px;
        	width: 20px;
        	height: 20px;
        }
        .inputCheck{
        	margin-right: 10px;
        	height: 20px;
        	width: 20px;
        }
        #todoBoxCloseBtn{
        	margin-top: 10px;
        	margin-right: 30px;
        	width: 60px;
        	height: 40px;
        	background-color: #05AA6D;
        	border-radius: 30px;
        	color: white;
        }
        #todoUl li{
        	margin-bottom: 7px;
        }  
</style>
</head>
<body>
<div class="sidebar">
	<div class="sideWrap">
		<div class="sidebar_logo" align="center">
				<a href="home.do">
				<img src="resources/image/loopy.jpeg" class="sidebar_logo_image">
				<div class="sidebarSiteName">
					<span style="font-size: 20px;">LEEJAVA</span>
				</a>
			</div>
		</div>
		<div class="sidebar_userInfo">
			<c:if test="${empty session_user}">
			<div class="sidebar_beforeLogin" >
				<button type="button" id="sidebar_loginBtn">Login</button>
				<button type="button" id="sidebar_memberJoinBtn">MemberJoin</button>
			</div>
			</c:if>
			<c:if test="${not empty session_user }">
				<div class="sidebar_afterLogin">
					<span>${session_user}님 오늘도 빡코딩!</span><br>
					<c:if test="${session_user != null and session_nickname != '관리자' }">
						<button type="button" id="myInfoBtn">My Info</button>
					</c:if>
					<button type="button" id="logoutBtn">로그아웃</button>
				</div>
			</c:if>
		</div>
		<br>
		
		<div class="sidebar_menu">
			<hr>
			<ul id="mainMenu">
				<c:if test="${session_user == \"bada\"}">
					<li><a href="adminPage.do" class="sideMenu">관리자 화면</a></li>
				</c:if>
				<li><a href="quizcard.do">퀴즐렛 학습하기</a></li>
				<ul id="subMenu">커뮤니티
					<li><a href="boardList.do" class="sideMenu">자유게시판</a></li>
					<li><a href="#" class="sideMenu">QNA</a></li>
					<li><a href="#" class="sideMenu">정보/팁</a></li>
					<li><a href="#" class="sideMenu">읽을거리</a></li>
					<li><a href="#" class="sideMenu">스터디/정기모임</a></li>
					<li><a href="#" class="sideMenu">책/인강 리뷰</a></li>
				</ul>
				<li><a href="memberNoticeList.do">공지사항</a></li>
			</ul>
		</div>
		<!-- 로그인해서 세션값이 존재하는 유저만 button이 보이도록 한다. -- -->
		<c:if test="${not empty session_user }">
			<button id="modalOpen">todolist</button>
		</c:if>
		
		<!-- ㅡ--------- modaㅣ들어가는 공간------------ -->
		 <!--모달창 연습 공간-->
    <div class="todo_modal_container">
        <div class="todo_modal_content">
            <!-- modal header 영역-->
            <div class="todo_modal_header">
                <label for="totolist">To do List by BADA</label>
                <input type="hidden" id="m_email" value="${session_user}">
            </div>
            <!--modal body 영역 -->
            <div class="todo_modal_body">
<!--                 <form id="frm" onsubmit="return false;"> -->
                    <!--여기 안에 입력했던 요소들이 생성된다. -->
                    <div id="todolistBox">
                        <ul id="todoUl">

                        </ul>
                    </div>

                    <div class="todo_inputBox">
                        <input type="text" id="todoInput" placeholder="input your today goal" maxlength="20">
                        <input type="button" id="todoBtn" value="+"
                            style="background-color: white; color:#05AA6D; border-radius: 30px;">
                    </div>
<!--                 </form> -->
            </div><br>
            <!--modal footer 영역 -->
            <div class="todo_modal_footer">
<!--                 <button id="allDeleteBtn">전체삭제</button> -->
<!--                 <button id="allCompleteBtn">전체완료</button> -->
                <button id="todoBoxCloseBtn">창닫기</button>
            </div>
        </div>
        <div class="todo_modal_layer"></div>
    </div>
		<!-- --------------모달창 끝나는 공간---------------- -->
	</div>
</div>
</body>
<script>
	// 커뮤니티 메뉴 드랍다운 방식으로 생성
	$("#subMenu").hover( function(){
		$("#subMenu > li").show(); 
	});
	
	// 로그인 페이지 띄우기
	$("#sidebar_loginBtn").on("click", function(){
		alert("Move to Login Page~");
		location.href="loginPage.do";
	})
	
	// 로그아웃 처리   click function 
	$("#logoutBtn").click(function(){
		alert("로그아웃 합니다.");
		location.href="logout.do";
	})
	
	// 회원가입 페이지 이동
	$("#sidebar_memberJoinBtn").on("click", function(){
		alert("회원가입 페이지로 이동하겠습니다.");
		location.href='memberJoinTerms.do';
	})
	
	// 개인정보 조회하는 공간으로 이동
	$("#myInfoBtn").on("click", function(){ 
		alert("개인정보 조호히하는 공간으로 이동"); 
		location.href='memberMyInfo.do';
	});
	
	/***************  Modal Script ***************/
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
	            alert("toodlist를 입력하세요");
	            return false;
	        }
	        ajaxInsert(m_email, $todoInput);
	        $(".todo_inputBox").css("display", "none");
	    }
	}) // todoInput의 갯수가 5개가 되면 자동으로 todo_inputBox가 비활되도록 함.
	
	// ajaxInsert(m_email, $todoInput) 함수 정의
	function ajaxInsert(m_email, todo_content){
		console.log("입력값 확인: " + m_email + ", " + todo_content);
		// ajax를 호출한다. => 콜백함수를 통해서 값을 받아와서 넣어야 할지 모르겠다. 
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
				str += "<input type='text' data-no='"+ $no +"' data-status='"+$status+"' value='"+$content+"' class='todoInputList' readonly='readonly'>";
				str += "<button class='todoDeleteBtn'>X</button><br></li>";				
				console.log("str값 확인: " + str);
				$("#todoUl").append(str);
				$("#todoInput").val('');
			},
			error: function(data){
				console.log("통신 중 에러 발생");
				console.log("에러났을 때 data값은 무엇? " + data);
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
	    $("#modalOpen").css("display", "block");
	})

	// todolist 입력 후 엔터키로 목록에 추가시키기
	$("#todoInput").keydown(function(e){
		if(e.keyCode == 13){
			// 마찬가지로 단순 엔터를 입력하면 submit()이벤트가 발생해 새로고침이 이루어진다. 
				// 해당 기본이벤트를지우고, (+)클릭이벤트를 발생시킨다.
			e.preventDefault();
			$("#todoBtn").click();
		}
	})
	
	
	// 모달창 열기  => 모달창을 열면서 ajax를 호출하여 데이터를 삽입해야 한다. 루핑 돌면서 반복적으로 <ul>태그 밑으로 요소들을 집어넣는다. 
	$("#modalOpen").on("click", function () {
    	$("#modalOpen").hide();
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
	        	console.log("return값인 data는 역시 배열속의 객체구조.");
	            console.log(data);
	            $.each(data, function(index, item){
	            	var $no = item.todo_no;
	            	var $content = item.todo_content;
	            	var $status = item.todo_status;
	            	console.log("확인: " + $no + " , " + $content + " , " + $status);
	            	var str = "";
					str += "<li><input type='checkbox' class='inputCheck'>";
					str += "<input type='text' data-no='"+ $no +"' data-status='"+$status+"' value='"+$content+"' class='todoInputList' readonly='readonly'>";
					str += "<button class='todoDeleteBtn'>X</button><br></li>";				
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
</html>