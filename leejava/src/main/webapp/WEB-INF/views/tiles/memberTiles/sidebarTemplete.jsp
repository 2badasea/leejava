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
            border-top: 0.5px solid #05AA6D;
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
				<li><a href="quizlet.do">퀴즐렛 학습하기</a></li>
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
		
		<button id="modalOpen">todolist</button>
		<!-- ㅡ modaㅣ들어가는 공간 -->
		 <!--모달창 연습 공간-->
    <div class="todo_modal_container">
        <div class="todo_modal_content">
            <!-- modal header 영역-->
            <div class="todo_modal_header">
                <label for="totolist">To do List by BADA</label>
                <input type="hidden" id="m_email" value="${session_user}">
            </div>
            <!--modal body 영역 -->
            <div class="todo_todo_modal_body">
                <form id="frm" onsubmit="return false;">
                    <!--여기 안에 입력했던 요소들이 생성된다. -->
                    <div id="todolistBox">
                        <ul id="todoUl">

                        </ul>
                    </div>

                    <div class="todo_inputBox">
                        <input type="text" id="todoInput" placeholder="input your today goal">
                        <input type="button" id="todoBtn" value="+"
                            style="background-color: white; color:#05AA6D; border-radius: 30px;">
                    </div>
                </form>
            </div>
            <!--modal footer 영역 -->
            <div class="todo_modal_footer">
                <button id="allDeleteBtn">전체삭제</button>
                <button id="allCompleteBtn">전체완료</button>
                <button id="todoBoxCloseBtn">모달창닫기</button>
            </div>
        </div>
        <div class="todo_modal_layer"></div>
    </div>
		<!-- 모달창 끝나는 공간 -->
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
				console.log(data);
				// 넘어온 data를 배열의 형태로values만 모아놓는다.
				var valueAry = Object.values(data);
		        console.log(typeof valueAry); // 예상대로면 타입이 배열이여야 한다. 아마도 객체로 나올 것이다. js에선 배열이란 타입이 없음.
				console.log(valueAry);
		        var $no = valueAry[1];
		        var $content = valueAry[2];
		        var $status = valueAry[3];
				var str ="";
				str += "<li><input type='checkbox' class='inputCheck'>";
				str += "<input type='text' data-no='"+ $no +"' data-status='"+$status+"' value='"+$content+"' id='todoInputList'>";
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
    let $todoNum = $(".todoDeleteBtn").length;
    if ($todoNum === 5) {
        $(this).closest('li').remove();
        $(".todo_inputBox").css("display", "block");
    } else {
        $(this).closest('li').remove();
    }

    // $(this).closest('li').remove();
})

// 모달창 닫기 버튼
$("#todoBoxCloseBtn").on("click", function () {
    $("#frm")[0].reset();
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
    // ajax를 호출해보자 호출해서 db에 있는 데이터를 가져와야 한다. 
    	//방식은 일단 일반적인 ajaxㅎ방식으로 호출하낟. => 
    $.ajax({
        async: false,
        url: "",
        dataType: "json",
        type: "GET",
        success: function (data) {여
            var $data = data;
            $.each($data, function (index, item) {
                var $todovalue = item.leebada;
                console.log("값들이 호출되는지? : " + $todovalue);
                var str = ""
                str += "<li><input type='checkbox' class='inputCheck'>";
                str += "<span>";
                str += $todovalue + "</span>";
                str += "<button class='todoDeleteBtn'>X</button><br></li>";
                $("#todoUl").append(str);
            })
        }
    })
    // ajax로 데이터를 먼저 다 추출한 다음에 요소에 집어넣고 화면출력.
    $(".todo_modal_container").css("display", "block");
})

</script>
</html>