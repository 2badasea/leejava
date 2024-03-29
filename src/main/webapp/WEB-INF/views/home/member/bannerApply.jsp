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
	min-height: 25px;
	height: auto;
	background: #05AA6D;
	display: flex;
	color: white;
	justify-content: space-between;
}
.bannerApplyList span, 
.bannerApplyList .bannerListIcons{
	padding: 8px;
}
.bannerListIcons{
}
.bannerListIcons:hover{
	cursor: pointer;
}
/* 동적으로 추가된 배너 신청 현황 리스트*/   
.bannerListTable {
	margin-left: 5%;
	width: 50%;
	text-align: center;
	border-collapse: collapse;
}
.bannerListTableTr{
	height: 40px;
}
.bannerapplytitleTd:hover{  /*	해당 배너 신청리스트의 제목에 마우스를 올리면 커서가 활성화되도록 한다. */
	cursor: pointer;
}
.bannerListTable th{
	border-bottom: 0.5px solid black;
	border-left: 0.5px solid black;
	border-right: 0.5px solid black;
	font-weight: 700;
}
.bannerListTable td{
	border-left: 0.5px solid #05AA6D;
	border-bottom: 0.5px solid #05AA6D;
	border-right: 0.5px solid #05AA6D;
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
.applyTypeUpdate{
	display: none;
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
.banapplySelectTable:not(".banfile"){
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
.applyTypeUpdate,
.banapplySelectTable input{
    border-style: none;       
    width: 95%;
    height: 100%;  
    padding:5px;   
}

.banapplycontent:focus,
.banapplySelectTable input:focus{
	outline: none;
}
.banapply_modal_content tr{
	
}
.uploadFileLink:hover {
	cursor: pointer;
}
.uploadFileLink {
}
.newBannerFile{
	display: none;
}
.newFileLabel{
	margin-top: 3px;
	font-size: small;
	border: 0.3px solid coral;
	background-color: coral;
	color: white;
	margin-bottom: 3px;
	
}
.banUpdateCallBtn:hover,
.newFileLabel:hover {
	cursor: pointer;
	color: #05AA6D;
	background-color: whitesmoke;
	border: white;
	transition: 0.5s;
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
                            <select class="applyTypeUpdate">
                            	<option value="7">7일</option>
                            	<option value="14">14일</option>
                            	<option value="30">30일</option>
                            	<option value="180">180일</option>
                            </select>
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
                            <a class="uploadFileLink">
                            	<span id="banfile" class="banfile"></span>
                            	<i class="fa-solid fa-file-arrow-down attachedFileIcon"></i>	
                            </a>
                            <br>
                            <label for="newBannerFile" class="newBannerFile newFileLabel">배너 이미지 변경</label>
                            <input type="file" id="newBannerFile" class="newBannerFile" style="width: auto;">
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

<!-- ------------------------------	 -->

	<div class="bannerApplyStatus">
		<div class="bannerApplyList">
			<span>나의 신청 현황</span>
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
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bannerApply.js" ></script> --%>
<script>
	/** Start 배너 신청 정보 수정 모달 */	
	$(document).on("click", ".banUpdateCallBtn", function() {
		var updateCheck = confirm("수정하시겠어요? 최종적으로 \"수정완료\" 버튼을 누르셔야 업데이트 됩니다.");
		if (!updateCheck) {
			return false;
		} else {
			$(".banapplytitle, .banapplycontent").prop("readonly", false);
			$(".banUpdateCallBtn").text('수정완료!!');
			$(".banUpdateCallBtn").css({ "backgroundColor": "coral", "color": "white" });
			$(".banUpdateCallBtn").addClass("banUpdateEndBtn");
			$(".banUpdateCallBtn").removeClass('banUpdateCallBtn');
			// 그리고 동적으로 applytype을 선택하는 select박스와 첨부파일 이미지 선택 <file>태그를 생성한다. 
			$(".banapplytype").css("display", "none");
			$('.applyTypeUpdate').css("display", "inline");
			$(".newBannerFile").css("display", "inline");
		}
	})
	
	// 모달창 닫기
	$(".banModalCloseBtn").on("click", function() {
		$(".banapply_modal_container").css("display", "none");
		$("#frm")[0].reset();
		$("body").css("overflow", "unset");
		$(".banapplytype").css("display", "inline");
		$('.applyTypeUpdate').css("display", "none");
		$(".banapplytitle, .banapplycontent").prop("readonly", true);
		// 그리고 WAITING인 신청글에 대해 동적으로 생성된 버튼의 경우 삭제시켜준다.
		$(".banUpdateCallBtn, .banUpdateEndBtn, .bannerCancelBtn").remove();
		$(".newBannerFile").css("display", "none");
		$('#newBannerFile').val('');
	})
	
	
	// "수정완료" 버튼 이벤트 정의 => 변경된 값들로 업데이트 시킨다. 변경사항이 일어났다면, 버튼을 닫을 때 새로고침. 
	$(document).on("click", ".banUpdateEndBtn", function() {
		var formData = new FormData();
	
		var banno = $(".uploadFileInfo").data('banno');
		var newType = $(".applyTypeUpdate").val();
		var newTitle = $(".banapplytitle").val();
		var newContent = $(".banapplycontent").val();
		var newFile = $("#newBannerFile")[0];
		var existingPfileName = $(".uploadFileInfo").data('pfilename');
		console.log("인코딩 전: " + existingPfileName);
		existingPfileName = encodeURIComponent(existingPfileName);
		console.log("인코딩 후 : " + existingPfileName);
		var regex = new RegExp("(.*?)\.(jpg|PNG|JPG|jpeg|png)$");
		if (newFile.files.length !== 0) {
			if (!regex.test(newFile.files[0].name)) {
				alert("올바르지 않은 파일 형식입니다.");
				$("#newBannerFile").val('');
				return false;
			} else {
				// 새로 선택한 이미지 파일이 존재하고, 유효성 체크를 통과 => 기존배너이미지의 물리명과 새로선택한 파일을 formData에 담는다.
				formData.append("existingPfilename", existingPfileName);
				formData.append("newBanfile", newFile.files[0]);
			}
		}
		formData.append("banno", banno);
		formData.append("banapplytype", newType);
		formData.append("banapplytitle", newTitle);
		formData.append("banapplycontent", newContent);
		$.ajax({
			url: "newBannerUpdate.do",
			data: formData,
			method: "PUT",
			contentType: false,
			processData: false,
			success: function(data) {
				console.log("호출 성공");
				console.log(data);
				if (data == "YES") {
					alert("성공적으로 수정되었습니다.");
					location.reload();
				}
				// 그리고 업데이트 되었다면 자동으로 화면 새로고침을 호출한다. 
			},
			error: function(err) {
				console.log("호출 실패");
				console.log(err);
				location.reload();
			}
		})
	})
	
	// 리스트 제목 클릭 => 글번호를 읽어들여 ajax로 데이터를 가져와서 모달창에 데이터를 넣는다. 
	$(document).on("click", ".bannerapplytitleTd", function() {
		var banno = $(this).prev().data('banno');
		console.log("글번호 확인: " + banno);
		// 해당 번호를 ajax로 넘겨서 데이터를 모두 가져온다. 
		var data = { banno: banno };
		$.ajax({
			url: "bannerApplySelect.do",
			type: "GET",
			data: data,
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(data) {
				console.log("호출 성공");
				$(".banapply_modal_container").css("display", "block");
				$(".banapplydate").val(data.banapplydate);
				$(".banapplytype").val(data.banapplytype);
				$(".applyTypeUpdate").val(data.banapplytype);
				$(".banpoststatus").val(data.banpoststatus);
				// 이미 게시된 것에 대해선 정보 수정 불가능
				if (data.banpoststatus === 'WAITING') {
					var str = "<button class='banUpdateCallBtn' style='float: right; margin-right:10px;'>수정하기</button>";
					var str2 = "<button class='bannerCancelBtn' style='float: right; margin-right:10px;'>신청취소</button>";
					$(".banapply_modal_footer").append(str).append(str2);
				}
				$('.banapplytitle').val(data.banapplytitle);
				$(".banapplycontent").val(data.banapplycontent);
				$(".banfile").text(data.banfile);
				$(".uploadFileInfo").data('banno', data.banno);
				$(".uploadFileInfo").data('filename', data.banfile);
				$(".uploadFileInfo").data('pfilename', data.banpfile);
				$("body").css("overflow", "hidden");
			},
			error: function() {
				console.log("호출 실패");
			}
		})
	})
	
	//배너 신청 취소
	$(document).on("click", ".bannerCancelBtn", function(){
		console.log("신청취소 클릭");
		var removeBanNo = $(".uploadFileInfo").data('banno');
		var removePfile = $(".uploadFileInfo").data('pfilename');
		removePfile =  encodeURIComponent(removePfile);
		var banCancelChk = confirm("신청을 취소하시겠어요?");
		if(banCancelChk){
			// 삭제 ajax요청
			$.ajax({
				url : "ajaxBannerApply/" + removeBanNo + "/" + removePfile,
				method: "DELETE",
				success: function(responseText){
					console.log(responseText);
					alert("신청이 성공적으로 취소되었습니다.");
					location.reload();
				},
				error: function(xhr, status, error){
					// 오류 응답 처리
					console.log('오류: ', error);
				}
			})
		}else {
			alert("신청이 취소되었습니다.");
			return false;
		}
		// DB상에서 지우고, 실제 local 디렉토리 상의 파일도 삭제 
	})
	
	// 첨부파일 다운로드
	$(document).on("click", ".uploadFileLink", function() {
		console.log("첨부파일 다운로드 시작");
		var filename = $(".uploadFileInfo").data('filename');
		var pfilename = $(".uploadFileInfo").data('pfilename');
		// ajax로 첨부파일 다운로드를 구현
		var url = "bannerDownload.do?filename=" + filename + "&pfilename=" + pfilename;
		console.log("filename 값:" + filename);
		console.log("pfilename 값: " + pfilename);
		console.log("호출할 url값: " + url);
		location.href = url;
	})
	
	/** End 배너 신청 정보 수정 모달  */
		
		
	const $email = $("#bannerApplyHiddenInput").val();
	$(".bannerApplyBtn").on("click", function() {
		var formData = new FormData();
		var $banapplytitle = $(".inputBanapplytitle").val();
		var $banapplycontent = $(".inputBanapplycontent").val();
		var $banfile = $(".inputBanfile")[0];
		var $banapplytype = $("input[name='banapplytype']:checked").val();
		// 제목이랑 내용 입력값 유무 체크 
		if ($banapplytitle.trim() == '' || $banapplycontent.trim() == '') {
			alert("제목과 내용을 입력해주세요");
			return false;
		}
		// 첨부파일의 확장자명 & 존재유무 유효성 체크
		let regex = new RegExp("(.*?)\.(jpg|PNG|JPG|jpeg|png)$");
		if ($banfile.files.length === 0) {
			alert("배너로 사용할 이미지를 선택해주세요");
			return false;
		} else if (!regex.test($banfile.files[0].name)) {
			alert("올바르지 않은 파일 형식입니다.");
			return false;
		}
		formData.append("m_email", $email);
		formData.append("banapplytitle", $banapplytitle);
		formData.append("banapplycontent", $banapplycontent);
		formData.append("banapplytype", $banapplytype);
		formData.append("banoriginfile", $banfile.files[0]);
	
		// formData에 들어있는 key값들 모두 확인
		for (var key of formData.keys()) {
			console.log(key);
		}
		// formData에 들어있는 value값들 모두 확인
		for (var value of formData.values()) {
			console.log(value);
		}
		// ajax로 데이터를 보낸다.
		$.ajax({
			url: "ajaxBannerApply.do",
			data: formData,
			type: "POST",
			processData: false,
			contentType: false, // contentType을 false로 첨부파일을 formData에 담아서 전송가능
			success: function(data) {
				console.log("호출 성공");
				alert(data);
				location.reload();
			},
			error: function() {
				console.log("호출 실패");
			}
		})
	}) 
	
	// minusicon,  plusicon 클릭 이벤트에 대한 이벤트 정의
	$(".minusicon").on("click", function() {
		$(".bannerListTable").hide();
		$(this).css("display", "none");
		$(".plusicon").css("display", "inline");
	})
	
	$(".plusicon").on("click", function() {
		$(".bannerListTable").show();
		$(this).css("display", "none");
		$(".minusicon").css("display", "inline");
	})
	
	
	/** HTML렌더링 이후에 실행 시킬 소스  */
	$(document).on("ready", function() {
		// 회원만 접근이 가능하도록 세션체크를 한다. 
		var sessionCheck = $("#bannerApplyHiddenInput").val();
		if (sessionCheck == '') {
			alert("회원만 접근가능한 메뉴입니다.");
			location.href = "loginPage.do";
		}
	
		// 회원이 접속했을 때 자기 이름으로 된 신청 내역이 있는지 조회. 있으면 화면에 뿌려준다. 
		var bannercheckEmail = $("#bannerApplyHiddenInput").val();
		$.ajax({
			url: "bannerimageSelect.do",
			method: "GET",
			data: {
				m_email: bannercheckEmail
			},
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(data) {
				if (data.length != 0) {
					// 원본파일명, 작성날짜, 제목, 게시유형(7일), 게시상태(banpoststatus)
					var tb = $("<table class='bannerListTable' />");
					var thtr = $("<tr class='bannerListTableTr' />").append(
						$("<th />").text('신청일'),
						$("<th />").text('제목'),
						$("<th />").text('신청 유형'),
						$("<th />").text('이미지 파일명'),
						$("<th />").text('배너 게시 상태')
					);
					tb.append(thtr);
					$.each(data, function(index, item) {
						var $banno = item.banno;
						var $banfile = item.banfile;
						var $banapplydate = item.banapplydate;
						var $banapplytitle = item.banapplytitle;
						var $banapplytype = item.banapplytype;
						var $banpoststatus = item.banpoststatus;
						var tr = $("<tr />").append(
							$("<td data-banno='" + $banno + "' />").text($banapplydate),
							$("<td class='bannerapplytitleTd' />").text($banapplytitle),
							$("<td />").text($banapplytype),
							$("<td />").text($banfile),
							$("<td />").text($banpoststatus)
						);
						tb.append(tr);
					})
					$(".bannerApplyStatus").append(tb);
				} else {
					console.log("신청내역없음");
				}
			},
			error: function(error) {
				console.log("호출 실패");
				console.log(error);
			}
		})
	})
	
</script>
</html>