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
						<input type="file" name="m_profileFile" style="display:none;" id="m_profileFile"></input>
						<label for="m_profileFile">이미지 선택</label>
						<br>
						<input type="hidden" name="m_email" id="m_email" value="${member.m_email }">
						<button type="submit" id="profileUpdateBtn">프로필 이미지 변경</button>
					</form>				
				</div>
				<div class="myInfo_intro">
					<!--이메일아이디, 자기소개(간단한 자신에 대한 소개글. 다른 사람들에게 보여짐)-->
					<label for="m_email">이메일</label>
					<input type="text" value="${member.m_email }" id="m_email">
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
							<input type="text" id="m_nickname" value="${member.m_email }">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="text" id="m_phone" value="${member.m_phone }">
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" id="m_address" value="${member.m_address }">
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
	
</script>
<script>
	$(function() {
	})
</script>
</html>