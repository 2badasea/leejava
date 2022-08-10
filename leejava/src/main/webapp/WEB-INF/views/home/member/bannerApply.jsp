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
.banModalCloseBtn,
.bannerApply_wrapper button{
    margin-top: 15px;
    border-radius: 20px;
    width: 100px;
    height: 30px;
    background-color: #05AA6D;
    border-style: none;
    color: whitesmoke;
}
.banModalCloseBtn:hover,
.bannerApply_wrapper button:hover{
	cursor: pointer;
	background-color: whitesmoke;
	color: #05AA6D;
	transition: 0.5s;
}
.bannerApplyForm{
	margin-top: 2%;
	margin-left: 5%;
}
#inputBanapplycontent{
	resize: none;
	width: 90%;
	padding: 15px;
	border-radius: 20px;
	border: 0.1px solid whitesmoke;
	font-size: medium;
	font-weight: 500;
	
}
#inputBanapplycontent:focus {
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
/*	배너신청 현황 조회 모달창 디자인 **************************/
.banapply_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.banapply_modal_content {
    position: absolute;
    top: 30%;
    left: 15%;
    min-width: 600px;
    width: auto;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 20px;
}

.banapply_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: gray;
    opacity: 0.5;
    transition: 2s;
}
.banapplycontent{
    resize: none;
    width: 93%;
    padding: 10px;
    border-style: none;
    font-weight: 600;
    font-size: medium;
               
}
.banapplySelectTable{
	border-collapse: collapse;
    text-align: center;
}
.banapplySelectTable th{
	border: 1px solid #05AA6D;
	padding:5px;
}	
.banapplySelectTable td{
	border: 1px solid #05AA6D;
	padding:5px;
}
.banapplySelectTable label{
	padding:5px;
}
.banapplySelectTable input{
    border-style: none;       
    width: 95%;
    height: 100%;  
    padding:5px;   
}
.banapply_modal_content tr{
	
}
.uploadFileLink:hover {
	cursor: pointer;
}
.uploadFileLink {
}


/*	*************************************************/
</style>
</head>
<body>
<div class="bannerApply_wrapper">
	<!-- 간단하게 세션값이 없으면 로그인을 유도하도록 한다.  -->
	<input type="hidden" id="bannerApplyHiddenInput" value="${session_user }">
	<!-- 배너 신청 현황 모달창 -->
 	<div class="banapply_modal_container">
        <div class="banapply_modal_content">
            <div class="banapply_modal_header" align="center">
                  <span style="font-size: 22px;"><b>배너광고 신청 현황</b></span>
                <hr>
            </div>
            <div class="banapply_modal_body">
                <!--이미지 원본파일명, 그리고 제목, 내용, 신청날짜, 신청유형, 신청상태 -->
                <!--신청날짜, 신청상태, 신청유형/ 제목 /내용, /첨부파일-->
                <!-- 기능적인 것에 최대한 초점을 맞추자. -->
               	<form id="frm">
                <table class="banapplySelectTable">
                    <tr>
                        <th>
                            <label for="banapplydate">신청일</label>
                        </th>
                        <td>
                            <input type="text" id="banapplydate" class="banapplydate" readonly>
                        </td>
                        <th >
                            <label for="banapplytype">신청유형</label>
                        </th>
                        <td>
                            <input type="text" id="banapplytype" class="banapplytype" readonly>
                        </td>
                        <th><label for="banpoststatus">신청상태</label></th>
                        <td>
                            <input type="text" class="banpoststatus" id="banpoststatus" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <label for="banapplytitle">제목</label>
                        </th>
                        <td colspan="5">
                            <input type="text" id="banapplytitle" class="banapplytitle" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <label for="banapplycontent">내용</label>
                        </th>
                        <td colspan="5">
                            <textarea rows="6" id="banapplycontent" class="banapplycontent" readonly></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <label for="banfile">배너 이미지</label>
                        </th>
                        <td colspan="5">	
                        	<input type="hidden" id="uploadFileInfo" class="uploadFileInfo">
                        	<!--  클릭 이벤트로 정의할지. 아니면  -->
                            <a class="uploadFileLink specialA">
                            	<span id="banfile" class="banfile"></span>
                            	<i class="fa-solid fa-file-arrow-down attachedFileIcon"></i>	
                            </a>
                        </td>
                    </tr>
                </table>
				</form>

            </div>
            <br>
            <div class="banapply_modal_footer">
                  <button class="banModalCloseBtn" style="float: right;">닫기</button>
            </div>
        </div>
        <div class="banapply_modal_layer"></div>
    </div>
	<script>
		/*	모달창 관련 스크립트 정의 */
		// 리스트 제목 클릭 => 글번호를 읽어들여 ajax로 데이터를 가져와서 모달창에 데이터를 넣는다. 
		$(document).on("click", ".bannerapplytitleTd", function(){
			var banno = $(this).prev().data('banno');
			console.log("글번호 확인: " + banno);
			// 해당 번호를 ajax로 넘겨서 데이터를 모두 가져온다. 
			var data = { banno : banno};
			$.ajax({
				url: "bannerApplySelect.do",
				type: "GET",
				data: data,
				dataType: "json",
				contentType: "application/json; charset=utf-8",
				success: function(data){
					console.log("호출 성공");
					console.log("데이터 확인 : "); 
					console.log(data);
					$(".banapply_modal_container").css("display", "block");
					$(".banapplydate").val(data.banapplydate);
					$(".banapplytype").val(data.banapplytype);
					$(".banpoststatus").val(data.banpoststatus);
					$('.banapplytitle').val(data.banapplytitle);
					$(".banapplycontent").val(data.banapplycontent);
					$(".banfile").text(data.banfile);
					$(".uploadFileInfo").data('filename', data.banfile);
					$(".uploadFileInfo").data('pfilename', data.banpfile);
					$("body").css("overflow", "hidden");
				},
				error: function(){
					console.log("호출 실패");
				}
			})
			
		})
		
		// 첨부파일 다운로드
		$(document).on("click", ".uploadFileLink", function(){
			console.log("첨부파일 다운로드 시작");
			var filename = $(".uploadFileInfo").data('filename');
			var pfilename = $(".uploadFileInfo").data('pfilename');
			// ajax로 첨부파일 다운로드를 구현해보자
			var url = "bannerDownload.do?filename=" + filename + "&pfilename=" + pfilename;
			console.log("filename 값:" + filename);
			console.log("pfilename 값: " + pfilename);
			console.log("호출할 url값: " + url);
			location.href = url;
		})
		
		// 모달창 닫기
		$(".banModalCloseBtn").on("click", function(){
			$(".banapply_modal_container").css("display", "none");
			$("#frm")[0].reset();
			$("body").css("overflow", "unset");
		})
	</script>
	
<!-- ------------------------------	 -->

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
						<label for="inputBanapplytitle">제목</label>
					</th>
					<td>
						<input type="text" id="inputBanapplytitle" name="inputBanapplytitle" class="inputBanapplytitle">
					</td>
				</tr>
				<tr>
					<th>
						<label>배너 게시 기간</label>
					</th>
					<td>
						<label for="first">7일</label>
						<input type="radio" id="first" value="7days" name="banapplytype" checked="checked">
						<label for="second">14일</label>
						<input type="radio" id="second" value="14days" name="banapplytype">
						<label for="third">30일</label>
						<input type="radio" id="third" value="30days" name="banapplytype">
						<label for="fourth">180일</label>
						<input type="radio" id="fourth" value="180days" name="banapplytype">
					</td>
				</tr>
				<tr>
					<th>
						<label for="inputBanapplycontent">신청내용</label>
					</th>
					<td>
						<textarea rows="7" id="inputBanapplycontent" name="inputBanapplycontent" class="inputBanapplycontent" cols="80"></textarea>
					</td>
				</tr>
				<tr>
					<th>
						<label for="inputBanfile">배너 이미지 첨부</label>
					</th>
					<td>
						<input type="file" name="inputBanfile" id="inputBanfile" class="inputBanfile">
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
		var $banapplytitle = $(".inputBanapplytitle").val();
		var $banapplycontent = $(".inputBanapplycontent").val();
		var $banfile = $(".inputBanfile")[0];
		var $banapplytype = $("input[name='banapplytype']").val();
		// 제목이랑 내용 입력값 유무 체크 
		if($banapplytitle == '' || $banapplycontent == '' ){
			alert("제목과 내용을 입력해주세요");
			return false;
		}
		// 첨부파일의 확장자명 & 존재유무 유효성 체크
		let regex = new RegExp("(.*?)\.(jpg|PNG|JPG|jpeg)$");
		if($banfile.files.length === 0  ){
			alert("배너로 사용할 이미지를 선택해주세요");
			return false;
		} else if( !regex.test($banfile.files[0].name) ){
			alert("올바르지 않은 파일 형식입니다.");
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
	
		// minusicon,  plusicon 클릭 이벤트에 대한 이벤트 정의
		$(".minusicon").on("click", function(){
			$(".bannerListTable").hide();
			$(this).css("display", "none");
			$(".plusicon").css("display", "inline");
		})
		
		$(".plusicon").on("click", function(){
			$(".bannerListTable").show();
			$(this).css("display", "none");
			$(".minusicon").css("display", "inline");
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
						$("<td data-banno='" +  $banno + "' />").text($banapplydate),
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