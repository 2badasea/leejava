<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 양식 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.wrapper {
	width: 50%;
}

#title {
	text-align: center;
}

.joinform {
	border: 1px solid whitesmoke;
	border-radius: 30px;
	width: 100%;
}

.button {
	background-color: #05AA6D;
	border-radius: 30px;
	color: white;
	border-style: none;
	width: 20%;
}

.button:hover {
	cursor: pointer;
	transition: 0.3s;
	background-color: white;
	color: #05AA6D;
}
span {
	font-size: 15px;
}
#codeCheck{
	display: none;
}
</style>
</head>
<body>

	<div class="wrapper">
		<div>
			<h3 id="title">자바이야기 회원가입</h3>
			<hr>
		</div>
		<div class="joinform">
			<form id='frm' action="memberJoin.do">
				<table border="0.5">
					<tr>
						<th>이메일</th>
						<td><input type="email" id="email" name="email">
							<button type="button" id="emailCheckBtn" class="button">인증하기</button></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input type="text" id="nickname" name="nickname">
							<button type="button" id="nicknameCheckBtn" class="button">중복확인</button></td>
					</tr>
					<tr>
						<th>*비밀번호</th>
						<td>
							<input type="password" id="password" name="password">
							<br>
							<span id="passwordRegMessage"><span>
						</td>
					</tr>
					<tr>
						<th>*비밀번호 확인</th>
						<td><input type="password" id="passwordCheck">
						<br>
							<span id="passwordCheckMessage"><span>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<select class="frontPhone" id="frontPhone">
								<option value="010" selected="selected">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> 
							<input type="text" id="backPhone">
							<button type="button" id="phoneCheckBtn" class="button">휴대폰 인증</button>
							<div id="codeCheck">
								<input type="text" id="inputCode">
								<button type="button" id="codeCheckBtn" class="button">인증번호 확인</button>
								<br>
								<span style="color: red; size: 15px;" id="timer"></span>
							</div>
						</td>
					</tr>
					<script>
					
					// 카운트다운 타이머 function 
					function startTimer(duration, display) {
					    var timer = duration;
					    var minutes;
					    var seconds;
					    
					    var setTime = setInterval(function () {
					        minutes = parseInt(timer / 60, 10);
					        seconds = parseInt(timer % 60, 10);
					
					        minutes = minutes < 10 ? "0" + minutes : minutes;
					        seconds = seconds < 10 ? "0" + seconds : seconds;
					
					        display.innerHTML = "남은 시간: " + minutes + ":" + seconds;
					
					        if (--timer < 0) {
					        	clearInterval(setTime);
					        	$("#codeCheck").attr("disabled", true);
					            $("#codeCheck").css("display", "none");
					        	$("#backPhone").val('');
					        }
					    }, 1000);
					}
					
					window.onload = function () {
					    var fiveMinutes = 5;
					    var display = document.getElementById('timer');
					    startTimer(fiveMinutes, display);
					};
					
					// 휴대폰 coolsms인증하기 => 작성후 확인 후 밑으로 옮길 것.
					$("#phoneCheckBtn").on("click", function(){
						var frontPhone = $("#frontPhone").val();
						var backPhone = $("#backPhone").val();
						var inputPhone = frontPhone + backPhone;
						alert("입력한 폰 번호: " + inputPhone);
						
						$.ajax({
							type: "POST",
							url: "ajaxCoolSMS.do",
							data: {
								inputPhone : inputPhone
							},
							success: function(number){
								console.log("인증번호: " + number);
								$("#codeCheck").css("display", "block");
								startTimer();
							},
							error : function(text){
								console.log("에러: " + text);
							}
						})
					})
					</script>
					
					<tr>
						<th>주소</th>
						<td></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<select></select> 
							<select></select>
							<select></select>
						</td>
					</tr>
				</table>
			</form>
			<button type="button" id="joinBtn" class="button">가입 완료</button>
		</div>
	</div>


</body>
<script>
	// 이메일 중복체크 확인
	$("#emailCheckBtn").on("click", function(){
		var email = $("#email").val();
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email == ""){
			alert("이메일을 입력하세요");
			return false;
		} else if (regEmail.test(email)) {
			alert("이메일 정규식 통과");
		} else {
			alert("입력하신 이메일 양식이 올바르지 않습니다.");
			return false;
		}
		
		$.ajax({
			type:"POST",
			url: "ajaxEmailCheck.do",
			data: {
				email : email
			},
			success: function(responseText){
				if( responseText == "YES") {
					alert("가입할 수 있는 이메일 입니다.");
					$("#emailCheckBtn").val('Y'); // 버튼에 value값 추가 => 중복확인 거쳤는지 체크용
				} else if( responseText == "NO"){
					alert("중복된 이메일입니다.");
					$("#email").val('');
					$("#email").focus();
				} else {
					alert("이메일 인증 오류입니다. 관리자에게 문의하세요");
				}
			}
		})
	})
	
	// 닉네임 중복체크(닉네임은 영문, 숫자, 한글 조합으로 최소2~10자리)
	$("#nicknameCheckBtn").on("click", function(){
		var nickname = $("#nickname").val();
		var regNickname = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{2,10}$/;
		if( !regNickname.test(nickname)) {
			alert("닉네임은 영문, 한글, 숫자 조합으로 2~10자리 입니다.");
			$("#nickname").val('');
			$("#nickname").focus();
			return false;
		}
		$.ajax({
			url: "ajaxNicknameCheck.do",
			type: "POST",
			data: {
				nickname : nickname
			},
			success: function(responseText){
				if( responseText == "YES"){
					alert("사용 가능한 이메일 입니다.");
					$("#nicknameCheckBtn").val('Y'); // 중복체크 했는지 체크용
				} else {
					alert("중복된 이메일 입니다.");
					$("#nickname").val('');
					$("#nickname").focus();
				}
			}
		})
	})
	// <span>의 id값: passwordRegMessage
	// 패스워드 입력칸 실시간 유효성 검증 영문/숫자/특수문자 합쳐서 최소 8자리 이상
	// text('')과 html('')의 차이.  그리고 innerHTML('')과 innerText('')의 차이
	$("#password").keyup(function(){
		var password = $("#password").val();
		var regPassword = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%^*#?&])[A-Za-z\d@$!%^*#?&]{8,15}$/;
		var message = "";
		if( regPassword.test(password) ){
			message = "사용가능한 비밀번호 입니다."
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
	document.getElementById('passwordCheck').onkeyup = function() {
		var password = document.getElementById('password').value;
		var passwordCheck = document.getElementById('passwordCheck').value;
		var message = "";
		if( password != passwordCheck){
			message = "비밀번호가 일치하지 않습니다.";
			document.getElementById('passwordCheckMessage').innerHTML = message;
			document.getElementById('passwordCheckMessage').style.color = "tomato";
		} else {
			message = "비밀번호가 일치합니다!";
			document.getElementById('passwordCheckMessage').innerHTML = message;
			document.getElementById('passwordCheckMessage').style.color =  "#05AA6D";
		}
	}
	
	
</script>
</html>