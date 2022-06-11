<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
.myInfoDetail {
	display: flex;
}
#myInfo_introText {
	border: none;
}
.myInfo_profile_image > img {
	border: 30px;
}
label {
	cursor: pointer;
}
#m_email{
	border: none;
}
#nicknameUpdate{
	display: none;
	float: right;
}
</style>
</head>
<body>
	<div class="wrapper">
		<!--개인정보 상세 조회 & 수정 영역-->
		<div class="myInfoDetail">
			<!--세 영역으로 나눈다. 프로필사진영역, 개인정보 상세 -->
			<div class="myInfoDetail_left">
				<div class="myInfo_profile_image">
					<img src="#" style="width: 200px;  height:200px;">
					<br>
					<form action="ajaxProfileImgUpdate.do" method="post" enctype="multipart/form-data">
						<!--form요소로 전달할, 프로필 변경에 필요한 파라미터 1. 사용자 이메일 2. 이미지 파일  -->
						<input type="file" name="m_profilefile" style="display:none;" id="m_profilefile"></input>
						<label for="m_profilefile">이미지 선택</label>
						<br>
						<input type="hidden" name="m_email" id="m_email" value="${member.m_email }">
						<br>
						<button type="submit" id="profileUpdateBtn">프로필 이미지 변경</button>
					</form>				
				</div>
				<div class="myInfo_intro">
					<!--이메일아이디, 자기소개(간단한 자신에 대한 소개글. 다른 사람들에게 보여짐)-->
					<label for="m_email">이메일</label>
					<input type="text" value="${member.m_email }" id="m_email" readonly="readonly">
					<div>
						<h4>자기 소개</h4>
						<textarea rows="" cols="" readonly="readonly" id="myInfo_introText">머리가 안 돌아간다.</textarea>
					</div>
				</div>
			</div>
			<div class="myInfoDetail_right">
				<table border="1">
					<tr>
						<th>닉네임</th>
						<td>
							<input type="text" id="m_nickname" value="${member.m_email }" readonly="readonly">
							<button type="button" id="nicknameUpdateBtn">닉네임 변경</button>
							<button type="button" id="nicknameUpdate">변경하기</button>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="text" id="m_phone" value="${member.m_phone }">
							<button type="button" id="phoneUpdateBtn">연락처 수정</button>
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
					<div>
				        <span>개인정보 3년 제공 동의 여부</span>
				        <br>
				        <label for="m_privacy_yes">동의</label>
				        <input type="radio" id="m_privacy_yes" value="YES">
				        <label for="m_privacy_yes">미동의</label>
				        <input type="radio" id="m_privacy_no" value="NO">
				    </div>
				    <div>
				        <span>프로모션 동의 여부</span>
				        <br>
				        <label for="m_promotion_yes">동의</label>
				        <input type="radio" id="m_promotion_yes" value="YES">
				        <label for="m_promotion_yes">미동의</label>
				        <input type="radio" id="m_promotion_no" value="NO">
				    </div>
					<button>비밀번호 변경</button>
					<button>회원탈퇴</button>
				</div>			
			</div>
				

		</div>
		<!--자신이 작성한 게시글 또는 활동내역 등등 다른 개인정보 들어갈 공간-->

	</div>

</body>
<script>
	// 프로필 이미지 업로드를 위한 스크립트 작성문. => 나중에 테스트 하고 불필요한 console.log나 alert() 지우기
	$("input[type='file']").on('change', function(e){ 
		
		// 화면의 이동없이 데이터를 서버로 전달하기 위하여 가상의 <form>태그 역할을 하는 FormData객체 생성.
		let formData = new FormData();
		let fileInput = $("input[name='m_profilefile']"); 
		let fileList = fileInput[0].files; 
		let fileObj = fileList[0];
		
		console.log('fileList : ' + fileList);
		// fileList가 배열형태의 객체이기 때문에 index를 통해 접근 => fileobj의 정체는 File객체다.
		console.log('fileObj: ' +  fileObj);
		
		// File객체에 담긴 데이터가 정말 <input>태그르 통해 선택한 파일의 데이터가 맞는지 확인. 
		console.log("fileName : " + fileObj.name);
		console.log("fileSize : " + fileObj.size);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
// 		alert("통과");
		// 기존의 key가 있는 상태에서 동일한 key로 데이터를 추가하면 기존 값을 덮어쓰지 않고 기존 값 집합의 끝에 
		// 새로운 값을 추가한다. (서버에서는 배열 타입으로 데이터를 전달받기 때문);
		formData.append("uploadFile", fileObj);
		
		// 첨부파일 서버전송 by ajax
		$.ajax({
			url: 'ajaxProfileUpdate.do',
	    	processData : false, // 서버로 전송할 데이터를 queryString 형태로 변환활지 여부
	    	contentType : false, // 서버로 전성되는 데이터의 content type
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json'  // 서버로부터 반환받을 데이터타입
		});	
		
		console.log("우선은 파일을 선태갛자마자 일단 pc에 저장");
		console.log("그리고 최종 등록을 누르면 => db에 저장되는 방식으로 할 것.");
	})
	
	// 업로드할 이미지 파일의 형식과 용량이 알맞은지 체크. 만약 아니라면 경고창과 함께 onchage이벤트에서 벗어나도록
	let regex = new RegExp("(.*?)\.(jpg|png|jpeg)$");
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
	
// 	// 닉네임 변경 버튼
// 	// 닉네임을 변경하는 데는 두 방식이 존재한다. 클릭하자마자 이벤트 형태로 매개값을 던지는 형태
// 	// 간단하게 변경하는 게 좋음 => 새로운 input태그를 하나 생성해서 입력하도록 하면 된다. 
// 	// 결국은 입력하는 공간을 만들어야 함. => 팝업창 방식 or 모달창 방식 or 단순히 input태그 공간만 생성하기
// 	// 간단하게 변경이 가능한 경우엔 새로운 칸만 생성하는 게 나은 듯. 
// 	// 해당  input칸의 상태를 변경하는 게 좋은 듯. readonly 해제시키고 안에 값을 초기화 시키기
// 	// button의 value를 수정하고, 이벤트를 부여해야 할 듯.아니면 새로운 버튼으로 교체. 
// 	$("#nicknameUpdateBtn").on("click", function(){ 
// 		console.log("닉네임 변경 클릭");
// 		$("#m_nickname").attr("readonly", false); 
// 		$("#m_nickname").val('').attr("placeholder", "Input your New Nickname").focus();
// 		$("#nicknameUpdateBtn").css("display", "none");
// 		$("#nicknameUpdate").css("display", "block");
// 	})
// 	// ^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$
// 	// 변경신청버튼  => 그리고 닉네임 조건에 대한 정규식을 생성해야 함 => 최소 2자 이상 10자 미만. 숫자 ㄴㄴ
// 	$("#nicknameUpdate").on("click", function(){
// 		console.log("변경 신청 클릭 완료");
// 		// 닉네임 정규식 생성
// 		var nickregExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
// 		// 닉네임을 업데이트 하기 위해서 사용자 이메일도 날려야 한다.
// 		var m_email = $("#m_email").val(); 
		
// 		var newNickname = $("#m_nickname").val(); 
// 		if( newNickname === ''){
// 			alert("변경할 닉네임을 입력해주세요"	);
// 			return false; 
// 		}
// 		if ( !nickregExp.test(newNickname) ){
// 			alert("닉네임이 한글/영문/숫자로 시작하며 2~10자여야 합니다.");
// 			return false; 
// 		}
// 		// 요건을 모두 만족하면 ajax로 보낸다.
// 		$.ajax({
// 			url: "ajaxNicknameUpdate.do",
// 			type: "POST",
// 			data: {
// 				m_nickname : newNickname
// 				m_email : m_email
// 			},
// 			success: function(responseText){
// 				alert("단순 테스트: " + responseText);
// 			}
// 		})
		
// 	})
	
	
</script>
<script>
	$(function() {
		alert("오늘 하루종일 고생할 view페이지 환영  ^^");
	})
</script>
</html>