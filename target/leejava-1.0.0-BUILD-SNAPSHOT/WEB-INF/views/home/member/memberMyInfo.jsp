<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${member.m_nickname }님의개인정보</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.myInfoDetail{
	border: 1px solid gainsboro;
	border-radius: 30px;
	padding: 50px;
	width: 70%;
	margin-top: 10%;	
	margin-left: 15%;
}
.myInfoDetailTop {
	display: flex;
}
#myInfo_introText {
	border: none;
}
label {
	cursor: pointer;
}
#m_email{
	border: none;
}
<!-- 업로드한 이미지 공간을 위한 스타일 by kimvampa -->
#result_card img{
 	max-width: 100%; 
    height: auto;
    display: block;
    padding: 5px;
    margin-top: 10px;
    margin: auto;	
}
#result_card {
	position: relative;
}
.imgDeleteBtn{
    position: absolute;
    top: 0;
    right: 5%;
    background-color: #ef7d7d;
    color: wheat;
    font-weight: 900;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    line-height: 26px;
    text-align: center;
    border: none;
    display: block;
    cursor: pointer;	
}
.hiddenNickname {
	display: none;
} 
.myInfoDetail_right{
	margin-left: 100px;
}
#m_intro {
	width: 100%;
	border-radius: 30px;
	border : 0.5px solid #05AA6D;
	padding: 15px;
	margin-top: 5px;
	resize: none;
}
#m_intro:focus{ 
	outline: none;
}
.updateBtnAfter{
	margin-top: 5px;
	display: none;
	float: right;
}
#m_privacy,
#m_promotion{
	border: none;
	font-size: 15px;
	width: 250px;
}
#m_privacy,
#m_promotion:focus{
	outline: none;
}
<!-- 모달창 관련 style 부분 --> 
#container {
  position:relative;
  width:100%;
  height:100%;
  z-index:1;
  display: none;
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

/* 닉네임 변경창 스타일 부분*/
.nickname_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.nickname_modal_content {
    position: absolute;
    top: 30%;
    left: 35%;
    width: 450px;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.nickname_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: gray;
    opacity: 0.3;
    transition: 2s;
}
.nickname_modal_body{
    display: flex;
    justify-content: space-around;
}
.newNickname{
    width: 200px;
}
/****************************************/

/* 연락처 수정 관련 모달창 디자인 */
.phone_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.phone_modal_content {
    position: absolute;
    top: 30%;
    left: 35%;
    width: 400px;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.phone_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: gray;
    opacity: 0.5;
    transition: 2s;
}
.newPhoneInput{
    width: 80px;
}
.newPhoneCheckBtn{
    display: block; 
    margin: auto; 
    margin-top: 15px;
    border-radius: 20px;
    width: 100px;
    height: 30px;
    background-color: white;
    border-style: none;
    color: #05AA6D;
}
.newPhoneCheckBtn:hover{
    cursor: pointer;
    background-color: #05AA6D;
    color: white;
    transition: 1s;
}
.phoneCheckBox{
    display: block;
}
/***********************************************8*/
</style>
</head>
<body>
<!--회원탈퇴 관련 모달창. 추후  코드 위치 수정 -->
<!-- 인증번호 modal창 뿐 -->
 <div class="leave_modal_container">
        <div class="leave_modal_content">
            <form id="memberLeaveForm">
                <div class="leave_modal_header">
                    <h3 align="center">연락처 인증</h3>
                </div>
                 <div class="leave_modal_body">
                        <div class="codeCheckbox" style="display: none;">
                                <input type="text" id="inputCode">
                                <button type="button" id="codeCheckBtn" class="button">인증번호 확인</button>
                                <br>
                                <span style="color: red; size: 15px;" id="timer">00 : 05</span>
                        </div>
                        <div class="inputPhoneBox" style="display: block;">
                            <input type="text" id="inputPhone" placeholder="연락처를 입력하세요">
                            <br>
                            <input type="password" id="inputPassword" placeholder="비밀번호를 입력하세요">
                            <button type="button" id="inputPhoneCheckBtn" class="button">인증번호 받기!</button>
                            <br>
                        </div>
                </div>
                <br>
                <div class="leave__modal_footer">
                    <button type="button" class="memberLeaveCloseBtn">닫기</button>
                </div>
            </form>
        </div>
        <div class="leave_modal_layer"></div>
    </div>
<!--  모달창 끝 -->	
<script>
	// 회원탈퇴 모달창 호출
	$(".memberLeaveBtn").on("click", function(){
		console.log("모달창 열기");
        $(".leave_modal_container").css("display", "block");
        $("body").css("overflow", "hidden");
    })
	

    // 회원탈퇴 모달창 닫기
    $(".memberLeaveCloseBtn").on("click", function(){
    	console.log("모달창 닫기");
        $(".leave_modal_container").css("display", "none");
        $("#memberLeaveForm")[0].reset();
        $("body").css("overflow", "unset");
    })
	
	$("#inputPhoneCheckBtn").on("click", function(){
		var m_email = $("#m_email").val(); 
		var m_password = $("#inputPassword").val();
		var m_phone = $("#inputPhone").val(); 
		console.log("입력한 값 확인: " + m_email + ", " + m_phone + ", " + m_password);
		// ajax 호출 비밀번호를 다시 입력하게 해서 조회? 
		$.ajax({
			url: "ajaxPhoneSelect.do",
			data: {
				m_email : m_email,
				m_phone : m_phone,
				m_password: m_password
			},
			type: "POST",
			dataType: "text",
			success: function(result){
				if(result === "YES") {
					alert(result);
					console.log(result);
					// 이벤트를 호출하는 방식으로 진행해보자. 입력한 비밀번호값만 넘기고.
					phoneCodeCheck(m_phone);
					
				} else {
					console.log(result);
					alert("다시 입력해주세요");
					$("#inputPassword").val('');
					$("#inputPhone").val('').focus();
				}
				// 연락처 조회 성공 => 입력한 연락처를 통해서 coolsms클래스의 인증코드를 호출하고, 화면전환?
			}
		})
	})
	
	function phoneCodeCheck(m_phone){
		console.log("정의한 이벤트로 phone이 왔나? : " + m_phone); 
		$.ajax({
			type: "POST",
			url: "ajaxCoolSMS.do",
			data: {
				inputPhone : m_phone
			},
			success: function(result){
				console.log("인증번호: " + result);
				$(".inputPhoneBox").css("display", "none");
				$(".codeCheckbox").css("display", "block");
				$("#codeCheckBtn").val(result); 
				modalTimer();
			}
		})
	}
	
	// 타이머 구현. 
	var timer = null;
	
	function modalTimer(){
		var display = $("#timer");  // 남은시간 보여주는 <span> 영역
		var leftSec = 180; // 유효시간 설정. 180초. 
		startTimer(leftSec, display);
	}
	
	function startTimer(count, display){
		var minutes;
		var seconds;
		timer = setInterval(function(){
			minutes = parseInt(count/60, 10);
			seconds = parseInt(count%60, 10); 
			
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds; 
			
			display.html(minutes + " : " + seconds);
			
			// 타이머끝
			if(--count <0){
				clearInterval(timer);
				alert("인증시간이 초과되었습니다. 재인증해주세요");
				location.reload();
			}
		},1000)
	}
	
	// 입력값이랑 비교하는 이벤트.  
	$("#codeCheckBtn").on("click", function(){
		var inputCode = $("#inputCode").val(); 
		// 생성된 인증번호를 <button>의 value속성의 값으로 넣었었음.
		var realCode = $("#codeCheckBtn").val();
		if(inputCode === realCode){
			alert("인증완료되었습니다.");
			$("#container").css("display", "none"); // 인증이 완료되면 => 회원탈퇴 처리ㅇㅇ. 
			// ajax로 탈퇴대기상태로 m_status변경하고, 로그아웃 & 세션없애버리기 
			var m_email = $("#m_email").val();
			var m_status = "LEAVING";
			$.ajax({
				url: "ajaxMemberLeave.do",
				type: "POST",
				data:{
					m_email : m_email,
					m_status : m_status
				},
				success: function(result){
					if(result === "YES"){
						console.log("업데이트 성공");
						location.href='logout.do';
					} else {
						console.log("업데이트 실패");
						alert("탈퇴 처리에 실패하였습니다.");
						location.reload();
					}
				}
			})
		} else {
			alert("인증번호가 틀렸습니다.");
			$("#inputCode").val('').focus();
		}
	})
	
</script>
	<div class="wrapper">
		<!--개인정보 상세 조회 & 수정 영역-->
	  <div class="myInfoDetail">
			<div class="myInfoDetailTop">
			<!--세 영역으로 나눈다. 프로필사진영역, 개인정보 상세 -->
			<div class="myInfoDetail_left">
				<div class="form_section">
					<!-- 여기다가 이미지를 보여준다 -->
           			<div class="form_section_title">
            			<label>프로필 이미지</label>
                    </div>
                    <div class="form_section_content">
						<form id='frm' action="ajaxProfileImgUpdate.do" method="post" enctype="multipart/form-data">
							<!--form요소로 전달할, 프로필 변경에 필요한 파라미터 1. 사용자 이메일 2. 이미지 파일  -->
							<div id='uploadResult'>
	<!-- 								여기에 ajax success을 통해 추가될 동적 태그들이 추가된다. -->
	<!-- 							<div id="result_card"> -->
	<!-- 								<div class="imgDeleteBtn">x</div> -->
	<!-- 								<img src="resources/image/loopy.jpeg"> -->
	<!-- 							</div> -->
							</div>
							<br>
							<input type="file" name="m_profilefile" style="display:none;" id="m_profilefile"></input>
							<label for="m_profilefile">이미지 선택</label>
							<br>
							<input type="hidden" name="m_email" id="m_email" value="${member.m_email }">
							<br>
						</form>	
					</div>			
				</div>
				<div class="myInfo_intro">
					<!--이메일아이디, 자기소개(간단한 자신에 대한 소개글. 다른 사람들에게 보여짐)-->
					<!--  버튼으로선택할 수 있도로 해야 한다. => 체크해하면 안 보임 -->
					<label for="m_email">이메일</label>
					<input type="text" value="${member.m_email }"	 readonly="readonly">
					<br><br>
					<div>
						<h5>자기소개 말고 다른 거 생각해보기</h5>
					</div>
				</div>
			</div>
			<div class="myInfoDetail_right">
				<table border="1" id="table">
					<tr>
						<th id="nicknameTh">닉네임조회</th>
						<td>
							<input type="text" id="m_nickname" value="${member.m_nickname }" readonly="readonly">
							<button type="button" class="nicknameUpdateBtn">닉네임 변경</button>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>	
							<input type="text" id="m_phone" value="${member.m_phone }">
							<button type="button" class="phoneUpdateBtn">연락처 수정</button>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" id="m_address" value="${member.m_address }">
							<button type="button" id="addressUpdateBtn">주소 수정</button>
						</td>
					</tr>
				</table>
				<br>
				<div class="myInfoPrivate">
					<!-- 1.비밀번호 변경, 2. 회원탈퇴 3. 개인정보약관 4. 프로모션 동의여부 3번이랑 4번은 radioㅂ방식으로. -->
					<!-- 중요한 개인정보의 경우 ㅅ정할 수 잇도록 한다. -->
					<div>
				        <input type="text" value="개인정보 3년 제공 동의 여부" readonly="readonly" id="m_privacy" data-privacy="${member.m_privacy }">
				        <br>
				        <label for="m_privacy_yes">동의</label>
				        <input type="radio" name="m_privacy" id="m_privacy_yes" value="YES">
				        <label for="m_privacy_no">미동의</label>
				        <input type="radio" name="m_privacy" id="m_privacy_no" value="NO">
				    </div>
				    <br>
				    <div>
				        <input type="text" value="프로모션 동의 여부" readonly="readonly" id="m_promotion" data-promotion="${member.m_promotion }">
				        <br>
				        <label for="m_promotion_yes">동의</label>
				        <input type="radio" name="m_promotion" id="m_promotion_yes" value="YES" checked="checked">
				        <label for="m_promotion_no">미동의</label>
				        <input type="radio" name="m_promotion" id="m_promotion_no" value="NO">
				    </div>
					<button id="passwordUpdateBtn">비밀번호 변경</button>
					<button class="memberLeaveBtn">회원탈퇴</button>
				</div>			
			</div>  <!-- myInfo 오른쪽 영역 -->
		</div>  <!-- myinfoDedatil Wrapper 영역 -->
		<br> 
		<div class="myInfoDetail_bottom">
			<h3>My Info...</h3>
			<textarea rows="7" cols="" id="m_intro"  name="m_intro" readonly="readonly">${member.m_intro }</textarea>
			<button id="myIntroUpdateBtn" style="float: right">자기소개 수정</button>
			<button class="updateBtnAfter" id="myIntroUpdateEnd" value="${member.m_email }">수정 완료</button>
			<button class="updateBtnAfter" id="myIntroCancel" value="${member.m_intro }" style="margin-right: 15px;" >수정 취소</button>
				<!-- 수정취소를 클릭하면 원글이 횝고되도록, 새로고침 없이ㄴ-->
		</div>
	  </div> 
	  
	  <!-- 닉네임 변경 업데이트 모달 영역 -->
	  <div class="nickname_modal_container">
        <div class="nickname_modal_content">
            <div class="nickname_modal_header" align="center">
                <span style="font-size: 22px;"><b>닉네임 변경하기</b></span>
                <hr>
            </div>
            <div class="nickname_modal_body">
                 <form id="nicknameForm">
                    <label for="newNickname">새로운 닉네임</label>
					<input type="text" id="newNickname" class="newNickname">
					<button type="button" class="newNicknameUpdateBtn">변경하기</button>
                 </form>
            </div>
            <br>
            <div class="nickname_modal_footer">
                <button style="float: right;" class="nickModalCloseBtn">닫기</button>
            </div>
        </div>
        <div class="nickname_modal_layer"></div>
   	  </div>
	<!---------------연락처 수정 모달창---------------------- -->
	<div class="phone_modal_container">
        <div class="phone_modal_content">
            <div class="phone_modal_header" align="center">
                  <span style="font-size: 22px;"><b>연락처 수정하기</b></span>
                <hr>
            </div>
            <div class="phone_modal_body" align="center">
                <form id="newPhoneFrm">
                    <label for="frontPhone">연락처</label>
                    <select id="frontPhone" class="newPhoneInput">
                        <option value="" selected>선택</option>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="015">015</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    - <input type="text" class="newPhoneInput" id="middlePhone" >
                    - <input type="text" class="newPhoneInput" id="backPhone">
                    <button class="newPhoneCheckBtn">인증코드 전송</button>
                    <div class="phoneCheckBox" align="center">
                        <label for="">인증코드 입력</label>
                        <input type="text" id="phoneCodeInput" class="phoneCodeInput">
                        <button type="button" class="storedCodeBtn">인증하기</button>
                        <br>
                        <span class="checkTimerSpan" style="color: tomato;"><b></b></span>
                    </div>
                </form>
            </div>
            <br>
            <div class="phone_modal_footer">
                  <button style="float: right;" class="phoneModalCloseBtn">닫기</button>
            </div>
        </div>
        <div class="phone_modal_layer"></div>
    </div>
	<!-- -------------------------------------------------------------- -->

	</div>
</body>
<script>
	// 연락처 수정 관련 스크립트 
	// 새로운 연락처 입력. 
    $(".newPhoneCheckBtn").on("click", function(e){
	    let frontPhone = $("#frontPhone").val();
	    let checkFullNumber = frontPhone + $("#middlePhone").val() + $("#backPhone").val();
        // button이 <Form>태그 안에 있으면 기본적으로 submit이 default = > prenveDefault() 또는 type을 "button'으로 처음부터 명시해놓기 
        e.preventDefault();
        console.log("연락처 수정 버튼 클릭");
        
        if(frontPhone === ""){
            alert("올바르지 않은 연락처 형식입니다.");
            return false;
        } else {
        	console.log("전송한 연락처 번호: " + checkFullNumber);
            alert("인증번호를 확인해주세요");
            // 그리고 함수를 정의해서 호출할 것인지? 타이머 함수.
            $(".phoneCheckBox").css('display','block');
            $(".newPhoneCheckBtn").css("display", 'none');
            $("#middlePhone, #backPhone").attr("readonly", "readonly");
            timerSetting();
            // 그리고 ajax를 통해서 코드번호를 호출한다.
            $.ajax({
            	url: "ajaxCoolSMS.do",
            	data: {
            		inputPhone : checkFullNumber
            	},
				success: function(code){
					console.log("호출 성공");
					console.log("인증코드: " + code);
					$(".storedCodeBtn").val(code);
				},
				error: function(message){
					console.log("호출 실패");
					console.log(message);
				}
            })
            
        }
    })
    
    // 인증코드 인증 & 연락처 수정 업데이트
    $(".storedCodeBtn").on("click", function(){
    	var sendEmail = $("#m_email").val();
    	var sendPhone = $("#frontPhone").val() + $("#middlePhone").val() + $("#backPhone").val();
    	// 입력한 번호와 전달받은 번호가 일치하면 ajax로 업데이트 시켜버리기
    	if( $('.phoneCodeInput').val() === $(".storedCodeBtn").val() ){
    		$.ajax({
    			url: "ajaxMemberUpdate.do",
    			data: {
    				m_email : sendEmail,
    				m_phone : sendPhone
    			},
    			success: function(message){
    				console.log("호출 성공");
    				if(message === "YES"){ 
    					alert("연락처가 수정되었습니다.");
    					$("#m_phone").val(sendPhone);
    					$(".phoneModalCloseBtn").click();
    				}
    			},
    			error: function(message){
    				console.log("호출 실패");
    				console.log(message);
    			}
    			
    		})
    	} else {
    		alert("인증번호가 일치하지 않습니다.");
    		return false;
    	}
    })
    

    function timerSetting(){
        var time = 10;
        var minute = Math.floor(time/60);
        var seconds = time%60;
        minute = '0' + minute;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        console.log("minute값: " + minute);
        console.log("seconds값: " + seconds);
        phoneCheckTimer(time,minute, seconds);
    }

    var timer; 
    function phoneCheckTimer(time,minute, seconds){
            timer = setInterval(function(){
            minute = Math.floor(time/60);
            seconds = time%60;
            minute = '0' + minute;
            seconds = seconds < 10 ? '0' + seconds : seconds;
            console.log("minute값: " + minute);
            console.log("seconds값: " + seconds);
            var str = minute + " : " + seconds;
            $(".checkTimerSpan").text(str);
            time--;
            if(time < 0){
                clearInterval(timer);
                alert("인증시간이 만료되었습니다. 처음부터 진행해주세요");
                $(".phoneModalCloseBtn").click();
                str =  '';
                $(".checkTimerSpan").text(str);
            }
        },1000);
    }

    // 연락처 수정 모달창 열기
    $(".phoneUpdateBtn").on("click", function(){
        $('.phone_modal_container').css("display", "block");
        $("body").css("position", "fixed");
        $("body").css("overflow", "hidden");
    })

    // 연락처 수정 모달창 닫기 
    $(".phoneModalCloseBtn").on("click", function(){
        $("#newPhoneFrm")[0].reset();
        $('.phone_modal_container').css("display", "none");
        $("body").css("position", "unset");
        $("body").css("overflow", "unset");
        clearInterval(timer);
        $(".checkTimerSpan").text('');
        $(".phoneCheckBox").css('display','none');
        $(".newPhoneCheckBtn").css("display", 'block');
        $("#middlePhone, #backPhone").removeAttr("readonly");
    })

    // 외부 영역 클릭 모달창 닫기
    $(document).on("click", function(e){
        if( !$(e.target).hasClass("phoneUpdateBtn") && $(e.target).closest(".phone_modal_content").length === 0 ){
        	$("#newPhoneFrm")[0].reset();
	        $('.phone_modal_container').css("display", "none");
	        $("body").css("position", "unset");
	        $("body").css("overflow", "unset");
	        clearInterval(timer);
	        $(".checkTimerSpan").text('');
	        $(".phoneCheckBox").css('display','none');
	        $(".newPhoneCheckBtn").css("display", 'block');
	        $("#middlePhone, #backPhone").removeAttr("readonly");
        }
    })
</script>
<script>
	// 회원탈퇴 이벤트 memberLeave() 이벤트 정의
		// onclick이벤트로 정의한 이벤트들은 글로벌 전역 함수만 호출한다. onclick이벤트를 정의할 거면, 
		// $(document).on("ready") 바깥에 정의해야 한다. 내부에 있으면 해당 함수를 찾지 못 한다.
		// 그리고 이벤트 버블을 막기 위해서 해당 태그의 기본이벤트를 지정하여 preventDefault()로 비활시킨다.
		// 순서 1. 확인체크(confirm()메서드 호출) 2. 조건에 따른 실행 => , 3. yes면 모달창 띄워서 휴대폰 인증받기
		// 4. 휴대폰 인증되면 db상에서 m_status값을 ajax로 수정한다. 
		// 사용자 입장에서 회원탈퇴가 간단해야 함. 
	$(".memberLeaveBtn").on("click", function(){
		var memberLeaveCheck = confirm("정말 떠나시겠습니까");
		if(memberLeaveCheck){
			$(".leave_modal_container").css("display", "block");
		} else {
			return false;
		}
	})
		
	// 닉네임 모달창 닫기 
	$(".nickModalCloseBtn").on("click", function(){
	    console.log("모달창 닫기");
	    $("#nicknameForm")[0].reset();
	    $(".nickname_modal_container").css("display", "none");
	    $("body").css("overflow", "unset");  // overflow의 속성값은  hidden <--> unset
	})
	
	// 닉네임 모달창 호출
	$(".nicknameUpdateBtn").on("click", function(){
		$(".nickname_modal_container").css("display", "block");
		$("body").css("overflow", "hidden");
	})
	
	// 닉네임 모달창 외부영역 클릭으로 없애기
	$(document).on("click", function(e){
		if( $(e.target).closest('.nickname_modal_content').length == 0 && !$(e.target).hasClass("nicknameUpdateBtn") ){
		    $("#nicknameForm")[0].reset();
			$(".nickname_modal_container").css("display", "none");
			$("body").css("overflow", "unset");
		}
	})
	
	// 새로운 닉네임 변경
	$(".newNicknameUpdateBtn").on("click", function(e){
		e.preventDefault();
		var m_nickname = $("#newNickname").val();
		if(m_nickname.length < 3){
			alert("닉네임은 최소 2자 이상이어야 합니다.");
			return false;
		}
		var m_email = $("#m_email").val();
		console.log("입력한 닉네임 값: " + m_nickname);
		console.log("const로 전역으로 선언된 이메일 값: " + m_email); 
		
		// ajax시작. => 이메일이랑 닉네임 정보 보내고 업데이트 한다. 
		$.ajax({
			type: "POST",
			url: "ajaxNicknameUpdate.do",
			data: {
				m_nickname : m_nickname,
				m_email : m_email
			},
			success: function(message){
				console.log("호출 성공");
				if(message === "YES"){
					console.log("닉네임 변경 성공");
					alert("닉네임이 변경되었습니다.");
					$("#nicknameForm")[0].reset();
					$(".nickname_modal_container").css("display", "none");
					$("body").css("overflow", "unset");
					$('#m_nickname').val(m_nickname);
				} else if( message === "ALREADY"){
					console.log("닉네임 중복");
					alert("중복된 닉네임입니다.");
					$("#nicknameForm")[0].reset();
					$(".newNickname").focus();
				} else {
					console.log("업데이트 실패");
					alert("닉네임 변경이 실패했습니다. 관리자에게 문의하세요");
				}
			},
			error: function(message){
				console.log("통신에러");
				alert("명령을 수행하는 중 오류 발생");
			}
		})
	})
</script>
<script>
	$(document).ready(function(){
		console.log("페이지 로딩 확인");
		
		$("#container").css("display", "none");
		
	/*페이지 로딩되자마자 프로모션 동의 여부와 개인정보 제공여부 DB값에 따른 체크상태 출력*/
	// 아래는 개인정보 제공 여부 
	var privacy = $("#m_privacy").data("privacy");
	console.log("개인정보 제공 동의 여부 값: " + privacy); 
	if(privacy === "YES"){
		$("#m_privacy_yes").prop("checked", true);
	} else {
		$("#m_privacy_no").prop("checked", true);
	}
	// 아래는 프로모션 부분
	var promotion = $("#m_promotion").data("promotion");
	console.log("프로모션 동의 여부 값: " + promotion); 
	if(promotion === "YES"){
		$("#m_promotion_yes").prop("checked", true);
	} else {
		$("#m_promotion_no").prop("checked", true);
	}
		
	// 프로모션 동의 여부 체크값 변경에 따른 이벤트 발생 ajax로 업데이트하고 나서 새로고침 여부 판단. 실시간으로 바뀌는지 보고
	$("input[name='m_promotion']").on("change", function(){
		console.log("눌렸나>");
		var email = $("#m_email").val(); 
		var value = $(this).val(); 
		var promotionCheck = confirm("변경하시겠습니까?");
		if(promotionCheck){
			// ajax호출
			$.ajax({
				url: "ajaxJoinTermsUpdate.do",
				type: "POST",
				data: {
					m_email : email,
					m_promotion : value
				},
				success: function(result){
					alert(result);
					console.log(result);
				}
			})
		} else {
			location.reload();
		}
	})
	
	// 개인정보 동의 여부 체크값 변경에 따른 DB 업데이트 
	$("input[name='m_privacy']").on("change", function(){
		console.log("눌렸나>");
		var email = $("#m_email").val(); 
		var value = $(this).val(); 
		var privacyCheck = confirm("변경하시겠습니까?");
		if(privacyCheck){
			// ajax 호출
			$.ajax({
				url: "ajaxJoinTermsUpdate.do",
				type: "POST",
				data: {
					m_email : email,
					m_privacy : value
				},
				success: function(result){
					alert(result);
					console.log(result);
				}
			})
		} else { // 변경취소를 하는 경우 return false;
			location.reload();
		}
	})
	
	// 자기소개 수정 클릭
	$("#myIntroUpdateBtn").on("click", function(){
		$("#myIntroUpdateBtn").hide();
		$("#m_intro").removeAttr("readonly");
		$(".updateBtnAfter").css("display", "block");
	})
	
	// 자기소개 수정 취소 
	$("#myIntroCancel").on("click", function(){
		var originText = $("#myIntroCancel").val();
		console.log("Origin Text 확인: " + originText );
		$("#m_intro").attr("readonly", "readonly");
		$(".updateBtnAfter").css("display", "none");
		$("#myIntroUpdateBtn").show();
		$("#m_intro").val(originText);
	})
	
	// 자기소개 수정 완료
	$("#myIntroUpdateEnd").on("click", function(){
		// 이메일 확인
		var m_email = $("#myIntroUpdateEnd").val();
		var m_intro = $("#m_intro").val();
		console.log("이메일 확인:" + m_email);
		console.log("수정한 입력값 확인: " + m_intro);
		// ajax호출  => 쿼리스트링 방식으로 한번 연습해볼 것
		$.ajax({
			url: "ajaxMyIntroUpdate.do?m_email=" + m_email + "&m_intro=" + m_intro,
			type: "GEt",
			dataType: "text",
			success: function(result){
				alert(result);
				$("#m_intro").val(m_intro);
				$("#m_intro").attr("readonly", "readonly");
				$(".updateBtnAfter").css("display", "none");
				$("#myIntroUpdateBtn").show();
				console.log("수정 완료");
			}
		})
	})
		
	// 프로필 이미지 DB 등록 버튼 => <form>태그의기본 이벤트를 지우고 ajax를 통해서 한다. 
	var $frm = $("#frm");
	$frm.on("submit", function(e){
		// button 눌렀을 때 기본 이벤트인 submit() 차단. ajax로 처리하기 위함.
		e.preventDefault();
		// ajax로 전해줄 데이터 4개 (m_email, uuid, uploadPath, fileName) 정의
		// m_email을 제외하 나머지 3개는 프로필 이미지를 선택했을 때 동적으로 추가되는 태그요소들의 value 값.
		var m_email = $("#m_email").val();
		var uuid = $("input[name='imageList[0].uuid']").val();
		var fileName = $("input[name='imageList[0].fileName']").val();
		var uploadPath = $("input[name='imageList[0].uploadPath']").val();
		console.log("ajax로 전해줄 값: " + m_email + " : " + uuid + " : " + fileName + " : " +uploadPath);
		// ajax 호출 
		$.ajax({
			url: $frm.attr("action"),  // ajaxProfileImgUpdate.do
			type: "POST",
			data: {
				m_email : m_email,
				uuid : uuid,
				fileName : fileName,
				uploadPath : uploadPath
			},
			success: function(result){
				if( result === "Y"){
					console.log("ajax success!");
					alert("프로필 이미지 업데이트!");
					location.reload();
				} else {
					console.log("에러");
					
				}
				
			}
		})
	})

	// kimvampa // 첨부파일 이미지 업로드 다시 확인
	// 프로필 이미지 업로드를 위한 스크립트 작성문. => 나중에 테스트 하고 불필요한 console.log나 alert() 지우기
	$("input[type='file']").on('change', function(e){ 
		
		// 메모 108. 이미지가 등록될 때 파일이 이미 존재를 한다면 삭제를 처리한 후 서버에 이미지 업로드 요청을 수행하도록 한다. 
			// 기존 이미지 파일이 저장되었을 때 삭제 요청 => 업로드가 앞서 이루어졌는지 어떻게 판단? => 
			// 미리 보기 태그가 존재하는지를 통해서 판단가능. if문을 활용하여 이미지 태그의 존재 유무에 따라 deleteFile()
			// 메서드를 호출하도록 한다. 
		/* 이미지 존재시 삭제 */
		if( $(".imgDeleteBtn").length > 0){ 
			deleteFile();
		}
			
		// 화면의 이동없이 데이터를 서버로 전달하기 위하여 가상의 <form>태그 역할을 하는 FormData객체 생성.
			// 화면 전환 없이 FromData객체에 담아서 ajax로 보내는 방식.
		let formData = new FormData();
		let fileInput = $("input[name='m_profilefile']"); // label태그에서 선택한 요소를 가져온 것 
		// 사용자가 파일을 선택하면, 선택된 파일의 목록이 FileList객체 형태로 files속성에 저장된다. 
			// 즉, 선택된 파일 목록을 가져오려면 files속성을 참조(호출)하면 된다( .files 형태로 호출)
		let fileList = fileInput[0].files; 
		let fileObj = fileList[0];
		
		console.log('fileList : ' + fileList);
		// fileList가 배열형태의 객체이기 때문에 index를 통해 접근 => fileobj의 정체는 File객체다.
			// 그리고 내가 선택한 파일을 가리킨다.
		console.log('fileObj: ' +  fileObj);
		
		// File객체에 담긴 데이터가 정말 <input>태그를 통해 선택한 파일의 데이터가 맞는지 확인. 
		console.log("fileName : " + fileObj.name);
		console.log("fileSize : " + fileObj.size);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		// 기존의 key가 있는 상태에서 동일한 key로 데이터를 추가하면 기존 값을 덮어쓰지 않고 기존 값 집합의 끝에 
			// 새로운 값을 추가한다. (서버에서는 배열 타입으로 데이터를 전달받기 때문);
		formData.append("uploadFile", fileObj);
			// 데이터에 파일객체를 넣어주었다 => ajax를 통해서 여러 개일 경우 개별적으로 이미지 업로드 되도록.
			// 전송할 파일객체가 여러 개라면 밑에 처럼 처리해준다. 
			// 		for(let i = 0; i < fileList.length; i++){
			// 			formData.append("uploadFile", fileList[i]);
			// 		}
		// 첨부파일 서버전송 by ajax
		$.ajax({
			url: 'ajaxProfileUpdate.do',
	    	processData : false, // 서버로 전송할 데이터를 queryString 형태로 변환활지 여부
	    	contentType : false, // 서버로 전성되는 데이터의 content type
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',  // 서버로부터 반환받을 데이터타입
	    	success: function(result){
	    		// 여긴 profilePath, uuid, uploadFileName이 담겨져 있음. 
	    			// 서버단에서는 위 세 값과 "_"를 통해 물리파일명을 생성해놓음. 경로에. 
	    			// ajax로 넘겨받은 정보들을 통해 화면에 이미지를 호출한다.
	    		console.log("서버로부터 돌아온 ajax 통신 result값: " + result);
	    		console.log(result);
	    		showUploadImage(result);
	    	},
	    	error: function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});	
	})
	
	// 업로드할 이미지 파일의 형식과 용량이 알맞은지 체크. 만약 아니라면 경고창과 함께 onchage이벤트에서 벗어나도록
	let regex = new RegExp("(.*?)\.(jpg|PNG|JPG|jpeg)$");
	let maxSize = 1048576; //1MB
	
	function fileCheck(fileName, fileSize){ 
		if( fileSize > maxSize){
			alert("파일 용량 초과");
			return false; 
		}
		if( !regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	// 프로필 이미지 출력 메서드 => ajax success속성의 콜백함수에서 호출된다. 
	function showUploadImage(uploadResultArr){
		// success콜백함수가 실행됐다는 건 업로드 이미지 메서드가 정상적으로 수행됐다는 뜻. -> result데이터를 못 받았을 
			// 가능성이 낮지만 혹여나 데이터를 전달받지 못 했을 경우를 가정하여 데이터를 검증하는 코드를 추가
		/* 전달받은 데이터 검증*/ 
		if(!uploadResultArr || uploadResultArr.length == 0){ return }; 
		
		// 이미지가 들어갈 공간 div태그
		let uploadResult = $("#uploadResult");
		// 서버에서 뷰로 반환 => List타입의 데이터를 전송. 뷰에서는 해당 데이터를 배열객체 형태로 전달받는다.(dataType이 json이었음) 
			// 현재 한 개의 이미지 파일만 처리를 하기 때문에 데이터에쉽게 접근할 수 있도록 변수 obj를 선언하여 서버로부터
			// 전달받은 배열 데이터의 첫 번째 요소로 초기화
		let obj = uploadResultArr[0];
		let str = "";
		// str변수에 추가되어야 할 태그 코드들을 문자열 값 형태로 추가해주기 전 한 가지 변수를 하나 더 추가 => 
			// 이미지 출력을 요청하는 url매핑 메서드("/display.do")에 전달해줄 파일의 경로와 이름을 포함하는 값을 저장하기 위한 변수
			// 썸네일 이미지를 출력하기 위해 "s_" 를 붙인 이미지 파일 정보를 선언하다. 
// 		let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
		// 위에 코드처럼 설정하는 경우, browser에서  '\' 때문에 경로를 찾지 못한다. 이미치 출력 url을 
			// 테스트할 때 파라미터 값의 구분자로서 '/'를 사용해야 정상적으로 출력이 되었다. 그래서 \를 /로 변경!
// 		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g,'/') + "/s_" + obj.uuid + "_" + obj.fileName);
			// 대상 String 문자열 중 모든 '\'를 '/'로 변경해준다는 의미. 자바스크립트에서는 replaceAll과 
				// 같은 메서드가 없기 때문에 replace메서드의 인자 값으로 정규표현식을 사용하여 
				// 치환 대상 모든 문자를 지정할 수 있다. 
				// 그리고 UTF-8로 인코딩을 자동으로 해주지 않는 웹브라우저가 있기에 encodeURIComponent()메서드를 활용. 
				// 덧붙여서, encodeURIComponent() 메서든느 '/'와 '\'문자 또한 인코딩을 하기 때문에 replace()를 
				// 사용 안 해도 해당 URI로 동작이 된다. 
		let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
		console.log("display.do로 보내는 view창에서의 fileCallPath값 : " + fileCallPath);
		// str 변수에 추가되어야 할 태그 코드인 문자열 값들을 저장해준다. 한 번에 값들을 다 넣어도 상관은 없음. 
		str += "<div id='result_card'>";
		str += "<img src='display.do?fileName=" + fileCallPath + "'>";
		// 삭제할 파일의 경로에 대한 데이터가 담긴 'fileCallPath'를 data속성을 통해 심어둔다.  
		str += "<div class='imgDeleteBtn' data-file='"+ fileCallPath +"'>x</div>";
		// 메모110~119 참조. 프로필 이이지 등록 시점에 이미지 정보<input>태그가 추가되도록 작업. 
		str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
		// 추가적으로 등록하는 버튼도 동적으로 추가해준다. 
		str += "<br><button type='submit' id='profileUpdateBtn'>프로필 등록</button>";
		str += "</div>";
		// 마지막으로 태그 코드가 담긴 문자열(str)값을 uploadResult 태그에 append() 명령 혹은 
			// html() 메서드를 호출하여 추가해준다. 
		uploadResult.append(str); 
		// 선택한 이미지를 화면에 출력함과 동시에, 기본 이미지는 지운다. => 이건 내가 조작해놓은 것
		$("#basic_result_card").hide();
			
	}
	
	/* 이미지 삭제 버튼 동작 */ 
	// 스크립트에 의해 동적으로 추가된 .imgDeleteBtn 이기에 라이브이벤트 메소드 등록을 한다.  
		// 참고로 삭제를 버튼해서 클릭하는 경우와 기존에 이미 프로필을 선택하여 'x'표시가 있는 경우 새로운 프로필을 선택하면 기존 값은 지워진다.
	$("#uploadResult").on("click", ".imgDeleteBtn",function(e){
		deleteFile();
		$("#basic_result_card").show();
	})	
	
	/* 업로드 이미지 파일 삭제 메서드 */
	function deleteFile(){
		// 두 개의 변수 선언. 하나는 <div>태그에 심어둔 썸네일 파일 경로데이터('fileCallPath') 대입. 
			// 나머지 하나는 이미지 파일 업로드 시 출력되는 미리 보기 이미지를 감싸고 있는 result_card<div>태그
		let targetFile = $(".imgDeleteBtn").data("file"); // 해당 태그의 data-file속성의 값 fileCallPath 을 호출하여 대입. 썸네일이미지정보임.
		let targetDiv = $("#result_card");
		// 메모 105. 파일 삭제를 요청하는 ajax 코드를 작성한다.
		$.ajax({
			url: "deleteFile.do",
			data : {
				fileName : targetFile
			},
			dataType : "text",
			type: "POST",
			success : function(result){
				console.log(result);
				// 파일 삭제를 성공한 경우 미리 보기 이미지를 삭제해주고, 파일<input> 태그를 초기화 해준다. 
				targetDiv.remove();
				// <input type='file'> 태그의 value는 선택한 파일의 경로에 대한 Dom string정보를 가지고 잇음.
				$("input[type='file']").val("");
			},
			error: function(result){
				console.log(result); // "fail"이란 값이 날라왔을 것이다.
				alert("파일을 삭제하지 못 하였습니다.");
			}
		})
	
	}
		
	/* 이미지 정보 호출 */ 
	let m_email = '<c:out value="${member.m_email}"/>';
	let uploadResult = $("#uploadResult");
	// 서버로부터 이미지 정보 요청을 위해서 getJSON메서드를 작성. get방식으로 요청 및 응답하는
		// 서버로부터 JSON으로 인코딩 된 데이터를 전달받기 위해 사용되는 메서드. 
		// 사용방법은 get.JSON(url[,data][,success]) 
		// url: 서버에 요청할 get방식의 url, data: 서버에 요청을 할 때 전달할 데이터
		// success: 성공적으로 서버로부터 데이터를 전달받았을 때 실행할 콜백함수. 
	$.getJSON("getAttachList.do", { m_email : m_email }, function(arr){
		console.log("getJSON 성공?");
		// 서버로부터 이미지 정보를 요청하였지만 전달받은 이미지가 없는 경우 콜백함수를 실행할 필요가 없음. 
		console.log("데이터 길이: " + arr.length);
		if(arr.length === 0){
			// 이미지가 없을 경우 콜백함수를 빠져나가도록 한 부분에 기본이미지가 출력되도록 함. 
			console.log("이미지가 없음");
			let str = "";
			str += "<div id='basic_result_card'>";
			str += "<img src='resources/img/s_loopy.jpeg'>";
			str += "</div>";
			uploadResult.html(str); 
			return; 
		}
		// 반대로 이미지가 있을 경우. 
		// 메모 138. 콜백함수 구현부에 먼저 두 가지 변수를 추가  
		let str = "";
		// List자료구조의 객체배열 상태로 반환받으니깐 반환한 데이터 갯수와 무관하게 []형태의 인덱스로 참조한다. 
		let obj = arr[0]; 
		console.log("obj의 값: " + obj);
		console.log(obj)    // .replace(/\\/g,'/')  (/\//g, '\')
		console.log("obj.uploadPath의 값: " + obj.uploadPath);
// 		console.log("수정한 obj.uploadPath 의 값: " + obj.uploadPath.replace(/\//g,'\\') );
		// 현재 프로필을 선택해서 display.do로 보내는 정보와 프로필을 등록하고 db에서 get.JSOO으로 읽어들인 정보를 비교했을 때 전해지는
			// fileCallPath의 정보 형식이 차이가 나지 않음에도 이미지가 출력이 되지 않고 있음. 
		let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
		console.log("fildCallPath 값:" + fileCallPath);
// 		fileCallPath = decodeURIComponent(fileCallPath); // 확인용 추가 
// 		console.log("디코딩한 fileCAllPath 값: " + fileCallPath); // 확인용 추가 
// 		fileCallPath = fileCallPath.replace(/\\/g,'/');
// 		console.log("문자 수정 한 fileCallPath 값: " + fileCallPath);
		console.log("기존 이미지가 존재하는 경우, display.do로 보내는 fileCallPath값: " + fileCallPath);
		// 선언해준 str변수에 uploadResult 태그에 삽입될 코드를 값으로 부여한다.
		str += "<div id='basic_result_card'";
		str += " data-path='" + obj.uploadPath + "' data-uuid='"+ obj.uuid + "' data-filename'" + obj.fileName + "'";
		str += ">";
		str += "<img src='/display.do?fileName=" + fileCallPath  +"'>";
		str += "</div>";
		// html()메서드를 사용해서 str변수에 저장된 값들이 uploadResult태그 내부에 추가되도록 해준다. 
		uploadResult.html(str);
		
	}) // get.JSON 메서드 영역
	
	})
</script>

</html>