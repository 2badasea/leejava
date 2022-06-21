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
.joinFormWrapper {
	width: 62%;
	margin-left: 15%;
    margin-top: 5%;
}
#title {
	text-align: center;
}
.joinform {
	border: 2px solid whitesmoke;
	border-radius: 30px;
	padding: 15px;
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
/* 모달창 style부분 */
#container {
  display: none;
  position:relative;
  width:100%;
  height:100%;
  z-index:1;
}
#container h2 {
  margin:0;
}
#container button {
	width:100px;
	float: right;
}
#container .modal {
  width:350px;
  margin:100px auto;
  padding:20px 10px;
  background:#fff;
  border:2px solid #666;
  height: 150px;
}
#container .modal_layer {
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background:rgba(0, 0, 0, 0.5);
  z-index:-1;
} 
#inputCode {
	width: 60%;
	height: 25px;
}
tr > th {
	width: 120px;
}
tr {
	height: 35px;
}
/* 	특정 선택자 제외하기  */
td > input:not(#addressBtn)  {
	width: 40%;
}
.button {
	height: 30px;
	margin-left: 3%;
}
#joinBtn {
	margin: auto;
	display: block;
}
</style>
</head>
<body>

<!-- 인증번호 modal창 뿐 -->
<div id="container">
    <div class="modal">
        <h3 align="center">연락처 인증</h3>
        <br>
        <input type="text" id="inputCode">
		<button type="button" id="codeCheckBtn" class="button">인증번호 확인</button>
		<br>
		<span style="color: red; size: 15px;" id="timer">00 : 05</span>
		<br>
        <button type="button" id="modalCloseBtn">닫기</button>
    </div>
    <div class="modal_layer"></div>
</div>
<!--  모달창 끝 -->


	<div class="joinFormWrapper">
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
							<input type="hidden" id="phone" name="phone">
							<button type="button" id="phoneCheckBtn" class="button">휴대폰 인증</button>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" id="sample4_postcode" placeholder="우편번호">
							<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" id="addressBtn"><br>
							<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
							<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="sample4_detailAddress" placeholder="상세주소">
							<input type="text" id="sample4_extraAddress" placeholder="참고항목">
							<input type="hidden" id="address" name="address">
						</td>
					</tr> 
					<tr>
						<th>생년월일</th>
						<td>
							<select id="year"></select>년 
							<select id="month"></select>월
							<select id="day"></select>일
							<input type="hidden" id="birthdate" name="birthdate">
						</td>
					</tr>
				</table>
				<br>
				<!--  jointerms 뷰에 있던 값들이 컨트롤러를 경유하여 가입페이지로 넘어왔다. -->
				<input type="hidden" id="privacy" name="m_privacy" value="${privacy }">
				<input type="hidden" id="promotion" name="m_promotion" value="${promotion }">
			</form>
			<button type="button" id="joinBtn" class="button">가입 완료</button>
		</div>
	</div>


</body>
<script>
	/*  회원 가입 버튼 => 모든 입력요소의 유효성 체크여부를 점검한다.   */
	$('#joinBtn').on('click', function() {
		// 1. 이메일 중복체크 여부 검사
		if( $('#emailCheckBtn').val() != 'Y'){
			alert('이메일 중복체크를 해주세요');
			$('#emailCheckBtn').focus();
			return false;
		}
		
		// 2. 닉네임 중복 체크 여부 검사. 
		if( $('#nicknameCheckBtn').val() != 'Y'){
			alert('닉네임 중복체크를 해주세용');
			$('#nicknameCheckBtn').focus();
			return false;
		}
		
		// 3. 패스워드 일치여부 확인
		if( $('#password').val() == null){
			alert('사용하실 패스워드를 입력해주세요');
			return false;
		} else if( $('#password').val() != $('#passwordCheck').val() ){
			alert('패스워드가 일치하지 않습니다.');
			return false;
		}
		
		// 4. 연락처 정보 검증
		if( $('#phoneCheckBtn').val() != 'Y'){
			alert("사용자 연락처 정보는 필수입니다.");
			return false;
		}
		
		// 5. 주소값 생성 판단. 일단 도로명 주소와 상세 주소만 넘기자. name있는 곳 태그에 값 부여하기 
		var doroAddress = $('#sample4_roadAddress').val();
		var jibunAddress = $('#sample4_jibunAddress').val();
		var detailAddress = $('#sample4_detailAddress').val(); 
		
		var sendAddresss = doroAddress + '(' + jibunAddress + ') ' + detailAddress;
		$('#address').val(sendAddresss);  
		
		// 6. 생년 월일 넘기기
		//"birthdate"
		var sendBirthdate = $('#year').val() + $('#month').val() + $('#day').val();
		$('#birthdate').val(sendBirthdate);
		
		// 폼 요소의 유효성 검사들이 모두 끝나면 action속성의 속성값 url( memberJoin.do )로 전송하기
		$('#frm').submit();
	
	})
	
	
	 

	// 이메일 중복체크 확인
	$("#emailCheckBtn").on("click", function(){
		var email = $("#email").val();
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email == ""){
			alert("이메일을 입력하세요");
			$('#email').focus();
			return false;
		} else if (regEmail.test(email)) {
			alert("이메일 정규식 통과");
		} else {
			alert("입력하신 이메일 양식이 올바르지 않습니다.");
			$('#email').val('').focus();
			return false;
		}
		
		// 입력한 이메일이 정규식을 통과했다면 => 해당 이메일 데이터로 중복이 존재하는지 체크한다. 
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
					$("#email").val('').focus();
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
			$("#nickname").val('').focus();
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
					alert("사용 가능한 닉네임 입니다.");
					$("#nicknameCheckBtn").val('Y'); // 중복체크 했는지 체크용
				} else {
					alert("중복된 닉네임 입니다.");
					$("#nickname").val('').focus();
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
				$('#container').css('display', 'block');
				modalTimer();
				// 인증번호 입력값과 실제 인증번호를 비교하기 위해 해당 <button>태그의 value속성에 값을 담아둠
				$('#codeCheckBtn').val(number);
			},
			error : function(text){
				console.log("에러: " + text);
			}
		})
	}) 
	
	
	// 인증시간 타이머 구현
	var timer = null;
	
	function modalTimer(){
		var display = $('#timer'); // 남은시간 보여주는 곳
		var leftSec = 180; // 유효시간 설정. 테스트를 위해 일단 10으로 설정. => 나중에 180초로 설정하기
		startTimer(leftSec, display);
	}

	function startTimer(count, display){
		var minutes, seconds;
		timer = setInterval(function(){
			minutes = parseInt(count/ 60, 10); 
			seconds = parseInt(count %60, 10);
			
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;
			
			display.html(minutes + " : " + seconds);
			
			// 타이머 끝
			if( --count < 0){
				clearInterval(timer); // timer라는 식별자 이름을 가진 setInterval() 이벤트 종료시키기
				alert('인증시간이 초과되었습니다. 재인증해주세요');
				$('#container').css('display', 'none');
				$('#backPhone').val('');
			}
		}, 1000); // 1초 간격으로 시간경과 표시
	}
	
	// 입력값이랑 비교하는 이벤트
	$('#codeCheckBtn').on('click', function() {
		var inputCode = $('#inputCode').val();  
		var ajaxCode = $('#codeCheckBtn').val(); // 이전에 인증코드를 받아왔을 때, codeCheckBtn value값에 인증코드 부여.  
		
		if( inputCode === ajaxCode ) {
			alert('인증완료되었습니다.');
			$('#container').css('display', 'none');
			$('#phoneCheckBtn').val('Y');  // 회원가입 폼 유효성 체크 여부로 'Y'값 삽입
			$('#phoneCheckBtn').css('display', 'none');
			$('#backPhone').attr('readonly', true);
			var phone = $('#frontPhone').val() + $('#backPhone').val();
			console.log('phone의 name 속성에 들어갈 번호: ' + phone);
			$('#phone').val(phone);
		} else {
			alert('인증번호가 틀렸습니다.');
			$('#inputCode').val('').focus();
		}
	})
	
	// modal창 닫기 이벤트
    document.getElementById("modalCloseBtn").onclick = function() {
		alert('인증이 취소되었습니다.');
        document.getElementById("container").style.display="none";
        $('#backPhone').val('');
    }
	
	
</script>

<!-- 밑은 주소 API 스크립트 적용 부분 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }
				
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                    document.getElementById("sample4_jibunAddress").value = expJibunAddr;
                    
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>
	// 생년월일 코드 문서가 모두 출력되면 스크립트문이 실행되도록. 
	$(document).ready(function(){
		
		var now = new Date(); // new 연산자를 통해 Date() 생성자함수로 현재 날짜 정보를 가지고 있는 객체 생성
		var year = now.getFullYear();
		var month = ( now.getMonth() + 1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		var day = ( now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());
		
		// 년도(id=year) selectbox 만들기
		for(var i = 1900; i <= year; i++){
			$('#year').append('<option value="'+ i + '">' + i + '년</option>');
		}
		
		// 월별(id=month) selectbox 만들기
		for(var i = 1; i<=12; i++){
			var mon = i>9 ? ''+i : '0'+i;
			$('#month').append('<option value="'+ mon + '">' + i + '월</option>');
		}
		
		// 일별(id=day) selectbox 만들기 
		for(var i = 1; i<=31; i++){
			var dd = i>9 ? ''+i : '0'+i;
			$('#day').append('<option value="' + dd + '">' + i + '일</option>');
		}
		// default값으로 오늘 날짜 기준으로 selected 세팅.		
		$('#year > option[value=' + year +  ']').attr('selected', 'true');
		$('#month > option[value=' + month + ']').attr('selected', 'true');
		$('#day > option[value=' + day + ']').attr('selected', 'true');
	})
	
</script>
</html>