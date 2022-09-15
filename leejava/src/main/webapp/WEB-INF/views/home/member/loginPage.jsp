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
	width: 90em;
}

.loginFrame {
	border: 1px solid gainsboro;
	border-radius: 30px;
	padding: 50px;
	width: 40%;
	display: block;
	margin-top: 3%;
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
	color: coral;
	text-decoration: none;
	font-weight: 800;
	font-size: large;
}

#email, #password {
	margin-top: 5px;
	width: 100%;
	height: 50px;
	font-size: 20px;
	font-weight: 600;
}
#email, #password:focus{
	outline-color: coral;
}
#email::placeholder{
	color: lightgray;
	font-style: italic;
} 
#password::placeholder{
	color: lightgray;
	font-style: italic;
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
#loginBtn:hover{
	background-color: whitesmoke;
	color: #05AA6D;
	transition: 0.3s;
	cursor: pointer;
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
.modal_container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.3);
    display: none; 
    z-index: 1;
}

.modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
}

.modal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #ffffff;
    box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

    /* 임시 지정 */
    width: 500px;
    height: 400px;
    z-index: 3;
}
.modal_header {
	display: flex;
	justify-content: space-between;
	padding: 20px;
}
.inputEmailBox {
	position: relative;
	top: 100px;
	left: 20px;
}
#modalCloseBtn {
	width: 20px;
	height: 20px;
}
#inputEmailLabel, 
#inputEmail{
	height: 25px;
}
#inputEmail{
	width: 200px;
}
#inputCheckNum,
#sendInputCheckNum {
	display: none;
	height: 25px;
}
#inputCheckNum {
	width: 100px;
}
.newPasswordBox {
	display: none;
	top: 100px;
	left: 30px;
}
#joinLabel, 
#showComment{
	color: #05AA6D;
	font-weight: bold;
}
#showComment:hover{
	cursor: pointer;
}
#forgotPasswordBtn{
	font-weight: 900;
	color: coral; 
		
}
#forgotPasswordBtn:hover {
	cursor: pointer;
}
</style>
</head>
<script>
	$(document).ready(function(){
		var message = $('#message').val();
		if( message != ""){
			console.log("가입완료 메시지 출력되나? " + message);
			alert(message);
		}
	})
</script>
<body>
<input type="hidden" id="message" value="${message }">
<!-- 로그인 창을 호출한 페이지의 url정보를 컨트롤러를 통해 받음. => 로그인 후 해당 url값으로 페이지가 리턴된다. -->
<input type="hidden" id="login_url" value="${url }">

<!-- 비밀번호 찾기 모달창 생성 -->
<div class="modal_container">
	<div class="modal">
		<div class="modal_header">
			<span style="text-align: center;">비밀번호 찾기</span>
			<button id="modalCloseBtn">X</button>
		</div>
		<hr>
		<div class="modal_body">
			<div class="inputEmailBox">
				<label for="inputEmail" id="inputEmailLabel">이메일 입력</label>
				<input type="text" id="inputEmail" name="inputEmail" placeholder="이메일을 입력해주세요">
				<button id="emailSendBtn">인증번호 전송</button>
				<input type="text" id="inputCheckNum" placeholder="인증코드 입력">
				<button id="sendInputCheckNum">확인</button>
			</div>
			<div class="newPasswordBox">
				<input type="password" id="newPassword" name="newPassword">
				<br>
				<span id="passwordRegMessage"></span>
				<input type="password" id="newPasswordCheck">
				<br>
				<span id="passwordCheckMessage"></span>
				<br>
				<button id="changeNewPasswordBtn">비밀번호 변경하기</button>
			</div>
		</div>
	</div>
	<div class="modal_layer"></div>
</div>  
<!-- 비밀번호 찾기 모달창 끝  -->
<script>
	/* 비밀번호 찾기 모달창 관련 스크립트 작성 => 다 작성 후 밑으로 보내기 */
	$("#emailSendBtn").on("click", function(){
		// 버튼 클릭하자마자 이메일 정규식이랑 null값인지 아닌지 먼저 확인 후에 진행하기
		// 이메일 정규식 체크 ( 혹시나 해서 올바르게 작성했느지 체크하기 위함)
		var inputEmail = $("#inputEmail").val();
		console.log("입력한 메일 확인: " + inputEmail);
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(inputEmail !== "" && regEmail.test(inputEmail) ){
				// ajax로 일단 해당 계정이 존재하는지 체크한다. => 따로 이벤트로 정의했다. 코드가 길어질까봐
				if( emailExistCheck(inputEmail) === "YES" ){
					alert("이메일을 전송했습니다.");
					$("#inputEmail").attr("readonly", "readonly");
					$("#emailSendBtn").css("display", "none");
					$("#inputCheckNum").css("display", "block");
					$("#sendInputCheckNum").css("display", "block");
					// ajax까지 포함하면 함수가 코드가 복잡해지니까 따로 function정의하기
					emailSend(inputEmail);
				} else {
					alert("가입된 이메일이 아닙니다. 이메일을 확인해주세용");
					$("#inputEmail").focus();	
					return false;
				}
			} else{ 
				alert("올바른 이메일 형식이 아닙니다.");
				$("#inputEmail").val('').focus();	
				return false;
			}
	})
	
	// 이메일 존재하는지 체크. 리턴값 받도록 해본다
	function emailExistCheck(inputEmail){
		console.log("이메일 존재유무 체크 콘솔창 확인: " + inputEmail);
		var message;
		$.ajax({
			url: 'ajaxEmailCheck.do',
			type: "POST",
			async: false,  // success문보다 밑에 console창이 먼저 실행되는 문제 해결 console창 추가
			data: {
				email : inputEmail
			},
			success: function(responseText){
				if(responseText === "NO"){
					console.log("여기는 왔니?");
					message = "YES";
				} 
			}
		})
		// 이 메시지를 리턴해서 체크한다. 존재하는 계정인 경우, YES
		console.log("존재유무 체크 콘솔창 확인: " + message );
		return message;
	}
	
	// 입력한 이메일을 통해 ajax로 인증코드를 받기 위한 함수
	function emailSend(inputEmail){
		console.log("여기까지 왔니?" + inputEmail);
		$.ajax({
			url: "ajaxEmailCheckForgotPassword.do",
			type: "POST",
			data : {
				inputEmail : inputEmail
			},
			success: function(responseCode){
				console.log("인증코드 확인: " + responseCode);
				// 입력한 이메일로 인증번호를 보내는 경우. 넘어온 인증코드 값을 통해 확인을 받는다.
				// 난 '확인'버튼에 코드값을 넣어서 일치여부를 비교하도록 했다. 
				$("#sendInputCheckNum").val(responseCode);
			}
		})
	}
	
	// 인증코드 일치여부 확인버튼 
	$("#sendInputCheckNum").on("click", function(){
		var storedCheckNum = $("#sendInputCheckNum").val();
		console.log("버튼에 담긴 인증코드 값: " + storedCheckNum);
		// 사용자가 입력한 값
		var inputCheckNum = $("#inputCheckNum").val(); 
		if( inputCheckNum === storedCheckNum){
			console.log("인증성공");
			alert("인증되었습니다. 새로운 비밀번호로 변경해주세요");
			// 새로운 비밀번호를 입력하는 공간을 활성화 시켜야 함.
			$(".inputEmailBox").css("display", "none");
			$(".newPasswordBox").css("display", "block");
		} else {
			console.log("인증실패");
			alert("인증번호가 일치하지 않습니다.");
		}
		
	})
	
	// 패스워드 입력칸 실시간 유효성 검증 영문/숫자/특수문자 합쳐서 최소 8자리 이상
	$("#newPassword").keyup(function(){
		var newPassword = $("#newPassword").val();
		var regPassword = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%^*#?&])[A-Za-z\d@$!%^*#?&]{8,15}$/;
		var message = "";
		if( regPassword.test(newPassword) ){
			message = "사용가능한 비밀번호 입니다."
			// 비밀번호 입력칸 밑의 <span>요소에 해당 message가 출력되도록 한다. keyup()이벤트가 발생할 때마다.
			$("#passwordRegMessage").text(message);
			$("#passwordRegMessage").css("color", "#05AA6D");
		} else {
			message = "영문, 숫자, 특수문자 최소 1개씩 포함한 8~15자리 이상이어야 합니다.";
			$("#passwordRegMessage").text(message);
			$("#passwordRegMessage").css("color", "tomato"); 
		}
	})
	
	// <span>의 id값 passwordCheckMessage 
	// 패스워드 확인칸 실시간 검증 by 바닐라자바스크립트
	document.getElementById('newPasswordCheck').onkeyup = function() {
		var newPassword = document.getElementById('newPassword').value;
		var newPasswordCheck = document.getElementById('newPasswordCheck').value;
		var message = "";
		if( newPassword != newPasswordCheck){
			message = "비밀번호가 일치하지 않습니다.";
			document.getElementById('passwordCheckMessage').innerHTML = message;
			document.getElementById('passwordCheckMessage').style.color = "tomato";
		} else {
			message = "비밀번호가 일치합니다!";
			document.getElementById('passwordCheckMessage').innerHTML = message;
			document.getElementById('passwordCheckMessage').style.color =  "#05AA6D";
		}
	}
	
	// 비밀번호 변경버튼 클릭
	$("#changeNewPasswordBtn").on("click", function(){
		// 입력했던 이메일 값도 정의해놓는다. => ajax때 같이 넘겨야 비밀번호 업데이트 가능.
		var inputEmail = $("#inputEmail").val();
		console.log("이메일 확인: " + inputEmail);
		if( $("#newPassword").val() !== $("#newPasswordCheck").val() ){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		} else {
			// ajax처리를 통해 새로운 비밀번호값으로 변경시켜야 한다. 컨트롤러에서 새로운 salt값도 업데이트 해야 함. 
			// 생각해보니깐 비밀번호만 넘기는 게 아니라, 이메일 주소도 필요하다. => "var inputEmail"을 위에 다시 정의
			var newPassword = $("#newPassword").val();
			$.ajax({
				type: "POST",
				async : false,
				url: "ajaxNewPasswordUpdate.do",
				data: {
					m_password : newPassword,
					m_email : inputEmail
				},
				success: function(responseText){
					if( responseText === "YES"){
						alert("비밀번호가 변경되었습니다. 로그인창으로 이동합니다.");
						location.href='loginPage.do';
					}else {
						alert("비밀번호 변경 실패");
					}
				}
			})
		}
	})
</script>
<!-- 부트스트랩 모달창 부분 끝 -->


 <div class="loginWrapper">
        <div class="loginFrame">
            <div class="loginTitle">
                <h1 style="font-weight:bolder;">Log In</h1>
            </div>
            <div class="inputEmail_upper">
                <span id="emailLabel">Email</span>
                <span id="joinLabel">Need an account? <a href="memberJoinTerms.do" class="joinLink specialA">Sign up</a></span>
            </div>
            <form id="frm" action="login.do">
            <input type="email" placeholder="Input your Eamil Address" id="email" name="email">
            <div class="inputPassword_upper">
                <span id="passwordLabel">Password</span>
                <div class="showLabel">
                    <span id="showComment">&lt;비밀번호 보이기&gt;</span>
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
                    <h4>
                    	<a class="forgotsPasswordLink specialA" id="forgotPasswordBtn">
                     	   Forgot password?
                    	</a>
                   	</h4>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	// 모달창 닫기 클릭
	$("#modalCloseBtn").on("click", function(){
		$(".modal_container").css("display", "none");
		$("#inputEmail").val('');
		location.reload();
		$("body").css("overflow", "unset"); // auto의 경우 => 넘치는 컨텐츠의 경우 자동으로 스크롤바가 생긴다.
	})

	// 비밀번호 분실 클릭
	$("#forgotPasswordBtn").on("click", function(){
		$(".modal_container").css("display", "block");
		$("body").css("overflow", "hidden"); // 있으면 넘치는 컨텐츠 영역에 대해서 숨기게 된다.
	});
	
	// 비밀번호 입력란 text타입으로 보이게 설정
	$("#showComment").on("click", function(e){
		e.preventDefault();
		if( $("#password").attr("type") === 'password' ) {
			$("#password").attr("type", "text");
	     	$("#showComment").text('<비밀번호 가리기>');
		} else {
			$("#password").attr("type", "password");
	     	$("#showComment").text('<비밀번호 보이기>');
		}
	})
	
	// enterkey로 로그인 기능 정의
	$('#password').on('keypress', function(e) {
		if (e.keyCode == '13') {
			$('#loginBtn').click();
		}
	});

	// 로그인 처리 시작
	$("#loginBtn").on("click", function() {
		var email = $("#email").val();
		var password = $("#password").val();
		var url = $("#login_url").val();
		// 로그인창에서 로그인창으로 가는 것 방지.
		if( url.includes('login') || url.includes('join') || url.includes('Login') || url.includes('Join') ) {
			url = "home.do";
		}
		console.log("url확인: " + url);
		if (email == "" || password == "") {
			alert("아이디 또는 비밀번호를 제대로 입력하세용");
			return false;
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
					$("#password").val('').focus();
				} else {
					if(responseText === "ADMIN"){
						alert("관리자님 반값습니다. 일좀 하세요.");
						location.href= "adminPage.do";
					} else {
						alert("로그인 성공");
						location.href = url; // request.getHeader()값으로 url명시. 
					}
				}
			}
		})
	})
</script>

</html>