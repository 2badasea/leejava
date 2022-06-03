<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js"
	crossorigin="anonymous"></script>
<style>
.loginWrapper {
	width: 80em;
}

.loginFrame {
	border: 1px solid gainsboro;
	border-radius: 30px;
	padding: 50px;
	width: 40%;
	display: block;
	margin-top: 10%;
	margin-left: 15%;
	margin-bottom: 10%;
	z-index: 1;
}

.inputEmail_upper {
	margin-top: 20px;
}

#emailLabel, #joinLabel {
	font-size: 15px;
}

#joinLabel {
	float: right;
}

#emailLabel, #passwordLabel {
	font-weight: bold;
}

.joinLink {
	color: #05AA6D;
	text-decoration: none;
}

#email, #password {
	margin-top: 5px;
	width: 100%;
	height: 50px;
}

.inputPassword_upper {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
}
.showLabel{
}

.socialIcon {
	float: right;
}

.socialIcon>i {
	width: 25px;
	margin-top: 10px;
}

.bottomBtn {
	margin-top: 50px;
}

#loginBtn {
	color: white;
	font-size: 20px;
	width: 100%;
	height: 60px;
	background-color: #05AA6D;
	border-style: none;
	border-radius: 30px;
}

.forgotPasswordLink {
	text-decoration: none;
	color: black;
}

#forgotDiv {
	margin-top: 20px;
}
#passwordEyeSlash{
	display: none;
}
.forgotPasswordLink:hover, 
#loginBtn:hover{
	cursor: pointer;
}
/* 비밀번호 찾기 모달창  */

</style>
</head>
<body>
<input type="hidden" id="message" value="${message }">

<!-- 비밀번호 찾기 모달창 생성 -->
<div class="modal_overlay">
		
</div>
<!-- 부트스트랩 모달창 부분 끝 -->


 <div class="loginWrapper">
        <div class="loginFrame">
            <div class="loginTitle">
                <h1 style="font-weight:bolder;">Log in</h1>
            </div>
            <div class="inputEmail_upper">
                <span id="emailLabel">Email</span>
                <span id="joinLabel">Need an account? <a href="memberJoinTerms.do" class="joinLink">Sign up</a></span>
            </div>
            <form id="frm" action="login.do">
            <input type="email" placeholder="Input your Eamil Address" id="email" name="email">
            <div class="inputPassword_upper">
                <span id="passwordLabel">Password</span>
                <div class="showLabel">
                    <i class="fa-solid fa-eye" id="passwordEye"></i>
                    <span id="showComment">비밀번호 보이기</span>
                </div>
            </div>
            <input type="password" placeholder="Input your Password" id="password" name="password" >
            </form>
            <div class="socialLogin">
                <div class="socialIcon">
                    <i class="fa-brands fa-facebook"></i>
                    <i class="fa-brands fa-twitter"></i>
                    <i class="fa-brands fa-google-plus-g"></i>
                    <i class="fa-solid fa-share"></i>
                </div>
            </div>
            <div class="bottomBtn">
                <button type="button" id="loginBtn">Log in</button>
                <div align="center" id="forgotDiv">
                    <a class="forgotPasswordLink" id="forgotPasswordBtn" data-toggle="modal" data-target="#myModal">
                        <h4>Forgot password?</h4>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	// 모달창 닫기 클릭
	$("#modal_close").on("click", function(){
		$(".modal_container").css("display", "none");
	})

	// 비밀번호 분실 클릭
	$("#forgotPasswordBtn").on("click", function(){
// 		$(".loginWrapper").css("display", "none");
		$(".modal_container").css("display", "block");
	});

	// 눈알 모양 클릭하면 비밀번호 그대로 보이도록 하기  id값: passwordEye / passwordEyeSlash
	$(".showLabel").on("click", function(){
		$("#password").prop("type", "text");
		$("#passwordEye").css("display", "none");
		$("#showComment").html('<i class="fa-solid fa-eye-slash" id="passwordEyeSlah"></i>');
	})
	
	// enterkey로 로그인 기능 정의
	$('#password').on('keypress', function(e) {
		if (e.keyCode == '13') {
			$('#loginBtn').click();
		}
	});

	// 로그인 처리 시작
	$("#loginBtn").on("click", function() {
		alert("로그인 처리 시작");

		var email = $("#email").val();
		var password = $("#password").val();

		if (email == "" || password == "") {
			alert("아이디 또는 비밀번호를 제대로 입력하세용");
		}

		$.ajax({
			type : "POST",
			url : "login.do",
			data : {
				email : email,
				password : password
			},
			success : function(responseText) {
				if (responseText == "NO") {
					alert("아이디 또는 비밀번호가 틀렸습니다.");

				} else {
					alert("로그인 성공");
					location.href = "home.do";
				}
			}
		})
	})
</script>
<script>
	$(document).ready(function(){
		var message = $('#message').val();
		if( message != ""){
			alert(message);
		}
	})
</script>
</html>