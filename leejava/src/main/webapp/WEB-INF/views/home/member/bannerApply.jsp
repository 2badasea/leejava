<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style type="text/css">
.bannerApply_wrapper{
	margin-top: 2%;
}
.bannerApplyForm{
	margin-top: 2%;
	margin-left: 5%;
}
#banapplycontent{
	resize: none;
	width: 90%;
	padding: 15px;
	border-radius: 20px;
	border: 0.1px solid whitesmoke;
	font-size: medium;
	font-weight: 500;
	
}
#banapplycontent:focus {
	outline-color: coral;
}
/*	배너 신청 폼 테이블 디자인	*/
.bannerTable{
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #05AA6D;
}
.bannerTable input:focus{
	outline-color: coral;
}
.bannerTable input:not(input[type="radio"]){
	font-size: medium;
	font-weight: 500;
	width: 100%;
	height: 100%;
	border-style: none;
}
.bannerTable input[type="radio"]{
}
.bannerTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
	border-bottom: 1px solid #05AA6D; 
}
.bannerTable td{
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
}
/*	배너 신청현황 리스트 막대 디자인 */
.bannerApplyList{
	margin-left: 5%;
	width: 50%;
	height: auto;
	background: lightgray;
	display: flex;
	justify-content: space-between;
}
/* 동적으로 추가된 배너 신청 현황 리스트*/  
.bannerListTable{
	margin-left: 5%;
	width: 50%;
	text-align: center;
	border-collapse: collapse;
}
.bannerapplytitleTd:hover{  /*	해당 배너 신청리스트의 제목에 마우스를 올리면 커서가 활성화되도록 한다. */
	cursor: pointer;
}
.bannerListTable th{
	border-bottom: 0.5px solid black;
	border-left: 0.5px solid black;
	font-weight: 700;
}
.bannerListTable td{
	border-left: 0.5px solid #05AA6D;
	border-bottom: 0.5px solid #05AA6D;
}
.bannerListTable tr:not(:first-child):hover{
	background-color: #F4FFFF;	
}
.plusicon{
	display: none;
}
.bannerApplyBtn{
    margin-top: 15px;
    border-radius: 20px;
    width: 100px;
    height: 30px;
    background-color: #05AA6D;
    border-style: none;
    color: whitesmoke;
}
.bannerApplyBtn:hover {
	cursor: pointer;
	background-color: whitesmoke;
	color: #05AA6D;
	transition: 1s;
}
</style>
</head>
<body>
<!-- 간단하게 세션값이 없으면 로그인을 유도하도록 한다.  -->
<input type="hidden" id="bannerApplyHiddenInput" value="${session_user }">
<div class="bannerApply_wrapper">
	<div class="bannerApplyStatus">
		<div class="bannerApplyList">
			<span>신청 현황</span>
			<div class="bannerListIcons">
				<i class="fa-solid fa-circle-plus plusicon"></i>
				<i class="fa-solid fa-circle-minus minusicon"></i>
			</div>
		</div>
	</div>
	<!-- 한 계정당 1회 신청할 수 있음. 심사가 거절되어야 다시 신청 가능 -->
	<div class="bannerApplyForm">
		<!-- 제목, 내용, 그리고 첨부파일 신청유형,  -->
			<table class="bannerTable">
				<tr>
					<th>
						<label for="banapplytitle">제목</label>
					</th>
					<td>
						<input type="text" id="banapplytitle" name="banapplytitle" class="banapplytitle">
					</td>
				</tr>
				<tr>
					<th>
						<label>배너 게시 기간</label>
					</th>
					<td>
						<label for="first">7일</label>
						<input type="radio" id="first" value="7" name="banapplytype" checked="checked">
						<label for="second">14일</label>
						<input type="radio" id="second" value="14" name="banapplytype">
						<label for="third">30일</label>
						<input type="radio" id="third" value="30" name="banapplytype">
						<label for="fourth">180일</label>
						<input type="radio" id="fourth" value="180" name="banapplytype">
					</td>
				</tr>
				<tr>
					<th>
						<label for="banapplycontent">신청내용</label>
					</th>
					<td>
						<textarea rows="7" id="banapplycontent" name="banapplycontent" class="banapplycontent" cols="80"></textarea>
					</td>
				</tr>
				<tr>
					<th>
						<label for="imgfile">배너 이미지 첨부</label>
					</th>
					<td>
						<input type="file" name="banfile" id="banfile" class="banfile">
					</td>
				</tr>
			</table>
		<div style="display: block; margin: auto;">
			<button type="button" class="bannerApplyBtn">배너 신청</button>
		</div>
	</div>
</div>
</body>
<script>
	const $email = $("#bannerApplyHiddenInput").val();
	$(".bannerApplyBtn").on("click", function(){
		var formData = new FormData();
		var $banapplytitle = $(".banapplytitle").val();
		var $banapplycontent = $(".banapplycontent").val();
		var $banfile = $(".banfile")[0];
		var $banapplytype = $("input[name='banapplytype']").val();
		if($banfile.files.length === 0){
			alert("배너로 사용할 이미지를 선택해주세요");
			return false;
		}
		if($banapplytitle == '' || $banapplycontent == '' ){
			alert("제목과 내용을 입력해주세요");
			return false;
		}
		console.log("신청자 이메일: " + $email);
		console.log("제목: " + $banapplytitle );
		console.log("타입: " + $banapplytype );
		console.log("내용: " + $banapplycontent  );
		console.log("파일: " + $banfile );
		formData.append("m_email", $email);
		formData.append("banapplytitle", $banapplytitle );
		formData.append("banapplycontent", $banapplycontent);
		formData.append("banapplytype", $banapplytype);
		formData.append("banoriginfile", $banfile.files[0]);
		
		// formData에 들어있는 key값들 모두 확인
		for(var key of formData.keys()){
			console.log(key);
		}
		// formData에 들어있는 value값들 모두 확인
		for(var value of formData.values()){
			console.log(value);
		}
		// ajax로 데이터를 보낸다.
		$.ajax({
			url : "ajaxBannerApply.do",
			data: formData,
			type: "POST",
			processData : false,
			contentType: false, // contentType을 false로 첨부파일을 formData에 담아서 전송가능
			success: function(data){
				console.log("호출 성공");
				alert(data); 
				location.reload();
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
		
	$(document).on("click", ".bannerapplytitleTd", function(){
		console.log( $(this).text());
		var thisNo = $(this).prev().data('bno');
		console.log("해당 배너신청 게시글의 글번호: " + thisNo);
	})
	
	
	
</script>
<script>
	$(document).on("ready", function(){
		// 회원만 접근이 가능하도록 세션체크를 한다. 
		var sessionCheck = $("#bannerApplyHiddenInput").val();
		if(sessionCheck == ''){
			alert("회원만 접근가능한 메뉴입니다.");
			location.href = "loginPage.do";
		}
		
		// 이번에는 회원이 접속했을 때 자기 이름으로 된 신청 내역이 있는지 조회. 있으면 화면에 뿌려준다. 
		var bannercheckEmail = $("#bannerApplyHiddenInput").val();
		$.ajax({
			url: "bannerimageSelect.do",
			method: "GET",
			data: {
				m_email : bannercheckEmail
			},
			dataType: "json", 
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				// 원본파일명, 작성날짜, 제목, 게시유형(7일), 게시상태(banpoststatus)
				var tb = $("<table class='bannerListTable' />");
				var thtr = $("<tr />").append(
					$("<th />").text('신청일'),
					$("<th />").text('제목'),
					$("<th />").text('신청 유형'),
					$("<th />").text('이미지 파일명'),
					$("<th />").text('배너 게시 상태')
				);
				tb.append(thtr);
				$.each(data, function(index, item){
					var $banno = item.banno;
					var $banfile = item.banfile;
					var $banapplydate = item.banapplydate;
					var $banapplytitle = item.banapplytitle;
					var $banapplytype = item.banapplytype;
					var $banpoststatus = item.banpoststatus;
					var tr = $("<tr />").append(
						$("<td data-bno='" +  $banno + "' />").text($banapplydate),
						$("<td class='bannerapplytitleTd' />").text($banapplytitle),
						$("<td />").text($banapplytype),
						$("<td />").text($banfile),
						$("<td />").text($banpoststatus)
					);
					tb.append(tr);
				})
				$(".bannerApplyStatus").append(tb);
			},
			error: function(error){
				console.log("호출 실패");
				console.log(error);
			}	
		})
		
		
	})
</script>
</html>