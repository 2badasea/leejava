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
						<div id='uploadResult'>
<!-- 							<div id="result_card"> -->
<!-- 								<div class="imgDeleteBtn">x</div> -->
<!-- 								<img src="resources/image/loopy.jpeg"> -->
<!-- 							</div> -->
						</div>
						<br>
						<input type="hidden" name="m_email" id="m_email" value="${member.m_email }">
						<br>
						<button type="submit" id="profileUpdateBtn">프로필 이미지 변경</button>
					</form>				
				</div>
				<div class="myInfo_intro">
					<!--이메일아이디, 자기소개(간단한 자신에 대한 소개글. 다른 사람들에게 보여짐)-->
					<!--  버튼으로선택할 수 있도로 해야 한다. => 체크해하면 안 보임 -->
					<label for="m_email">이메일</label>
					<input type="text" value="${member.m_email }" id="m_email" readonly="readonly">
					<div>
						<h4>자기 소개</h4>
						<textarea rows="" cols="" readonly="readonly" id="myInfo_introText">머리가 안 돌아간다.</textarea>
					</div>
				</div>
			</div>
			<div class="myInfoDetail_right">
				<table border="1" id="table">
					<tr>
						<th id="nicknameTh">닉네임조회</th>
						<td>
							<input type="text" id="m_nickname" value="${member.m_nickname }" readonly="readonly">
							<button type="button" id="nicknameUpdateBtn">닉네임 변경</button>
							<div class="hiddenNickname">
								<input type="text" id="newNickname">
								<button type="button" id="newNicknameUpdateBtn">변경하기</button>
							</div>
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
					<!-- 중요한 개인정보의 경우 ㅅ정할 수 잇도록 한다. -->
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
	const m_email = $("#m_email").val();

	// kimvampa // 첨부파일 이미지 업로드 다시 확인
	// 프로필 이미지 업로드를 위한 스크립트 작성문. => 나중에 테스트 하고 불필요한 console.log나 alert() 지우기
	$("input[type='file']").on('change', function(e){ 
		
		// 화면의 이동없이 데이터를 서버로 전달하기 위하여 가상의 <form>태그 역할을 하는 FormData객체 생성.
		let formData = new FormData();
		let fileInput = $("input[name='m_profilefile']"); // label태그에서선택한 요소를 가져온 것 
		let fileList = fileInput[0].files; 
		let fileObj = fileList[0];
		
		console.log('fileList : ' + fileList);
		// fileList가 배열형태의 객체이기 때문에 index를 통해 접근 => fileobj의 정체는 File객체다.
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
	    		console.log(result);
	    	},
	    	error: function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
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

	// 다시 처음부터 생각을 해보자 -> 사소한 거 하나하나 모달창으로 하려면 코드가 복잡해진ㄷ. 
	$('#nicknameUpdateBtn').on("click", function(){
		// 닉네임의 경우, 해당 사이트에서 그렇게 중요한 정보는 아니다. => 간단하게 기존 input창 가리고 새로운 input창 활성화 시키자
		// 새로운 input창과, 새로운 button창 생성해서, 여기서 입력값 받고 ajax를 통해 날릴 수 있또록ㄱㄱ
		// nicknameUpdateBtn m_nickname
		var check = confirm("do you wanna update nickname? ");
		if(check) {
			$("#nicknameUpdateBtn").css("display", "none");
			$("#m_nickname").css("display", "none");
			// 그리고 숨겨진 창을 활성화 시킨다
			$(".hiddenNickname").css("display", "block");
			$("#nicknameTh").text('새로운 닉네임');
		} else {
			location.reload();
		}
	});
	
	// 새로운 닉네임 입력하고 ajax로 보낸다.
	// id 각각 input => newNickname  button =>  newNicknameBtn
	$("#newNicknameUpdateBtn").on("click", function(){
		console.log("nickname update start");
		var m_nickname = $("#newNickname").val();
		console.log("입력한 닉네임 값: " + m_nickname);
		console.log("const로 전역으로 선언된 이메일 값: " + m_email); 
		
		// ajax시작. => 이메일이랑 닉네임 정보 보내고 업데이트 한다. 
		$.ajax({
			url: "ajaxNicknameUpdate.do",
			data: {
				m_nickname : m_nickname,
				m_email : m_email
			},
			success: function(responseText){
				if( responseText === "YES"){
					alert("정상적으로 변경되었습니다.");
					console.log("변경 성공");
					location.reload();
				} else {
					alert("변경에 실패했습니다.");
					console.log("변경실패"	);
					location.reload();
				}
			},
			error: function(responseText){
				console.log("통신에러");
				alert("명령을 수행하는 중 오류 발생");
				location.reload();
			}
		})
	})
	
	
	
	
	
</script>
<script>
	$(function() {
		console.log("페이지 로딩됨 확인")	;
	})
</script>
</html>