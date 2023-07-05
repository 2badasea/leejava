<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 배너 관리 페이지.</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
/*	전체 페이지 공통 적용 요소*/
.adminBannerManage_wrapper{
	height: 100%;
	width: 75%;
	margin-top: 5%;
}
/*	배너 이미지 관리창 디자인 */
.bannerManageForm{
	display: flex;
	min-height: 400px;
}


/*	배너신청 리스트 테이블 디자인 */
.bannerApplyListTable{
	border-collapse: collapse;
	border: 1px solid #313348;
	margin-top: 1%;
	margin-left: 5%;
	margin-bottom: 2%;
}
.bannerListThTr{
	border-bottom: 1px solid #313348;
	background-color: whitesmoke;
}
.bannerListTdTr{
	border-bottom: 1px solid lightgray;
}
.bannerApplyListTable th{
	border-left: 1px solid #313348;
	height: 30px;
}
.bannerApplyListTable td{
	border-left: 1px solid #313348;
	height: 25px;
	text-align: center;
	padding: 5px;
	font-weight: 600;
	font-size: medium;
}
.bannerListTdTr:not(.bannerListStatusTd):hover {
	background-color: #B8D7FF;
	cursor: pointer;
}
/*	배너 신청 리스트 개별 조회 모달창 */
.banner_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.banner_modal_content {
    position: absolute;
    top: 30%;
    left: 10%;
    width: auto;
    height: auto;
    z-index: 3;
    background-color: whitesmoke;
    border: 0.5px solid #313348;
    border-radius: 20px;
    padding: 20px;
}

.banner_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: gray;
    opacity: 0.5;
    transition: 2s;
}
/*  배너 신청내역 개별 조회 테이블*/
.bannerSelectTable{
    border-collapse: collapse;
    border: 2px solid #313348;
}
.bannerSelectTable td{
    border-left: 1px solid #313348;
    border-bottom: 1px solid #313348;  
    padding: 5px;
    font-weight: 600;      
}
.bannerContent{
    resize: none;
    padding: 10px;
    width: 97%;
    border-style: none;
    font-weight: 800;
    font-size: large;
    background-color: whitesmoke;
}
.bannerContent:focus{
    outline: none;
}
.statusSelect{
    width: 100%;
    text-align: center;
    height: 100%;
    padding: 5px;
}
.statusSelect:hover{
    outline-color: #2E3856;
}
.bannerSelectCloseBtn{
	border-radius: 20px;
	border-style: none;
	padding: 10px;
	min-width: 100px;
	width: auto;
	height: auto;
	color: whitesmoke;
	background-color: #313348;
	font-weight: 900;
}
.bannerSelectCloseBtn:hover {
	cursor: pointer;
	background-color: whitesmoke;
	color: #313348;
	transition: 0.5s;
}
.bannerImg:hover {
	cursor: pointer;
}
/*	페이지 상단 PUBLICING 리스트의 박스 디자인 */
.publicingListBox{
	margin-left: 10%;
	width: 40%;
}
.bannerimageBox{
	width: 60%;
	height: 100%;
	background-color: whitesmoke;
}
.banPublicingList{
	border: 1px solid #313348;
	text-align: center;
}
.banPublicingList th{
	border-bottom: 1px solid #313348;
}
.banPublicingList td {
	border-left: 0.3px dotted lightgray;
	font-size: large;
}
.imageFileName {
	border-style: none;
	text-align: center;
	color: teal;
	font-weight: 600;
	font-size: medium;
	background-color: transparent;
}
.endDateTd{
	color: tomato;
}
.imageFileName:hover{
	cursor: pointer;
}
.imageFileName:focus {
	outline: none;
}
#bannerImage{
	width: 500px;	
	height: 200px;
	margin-top: 5%;
}
.selectImageBox{
	height: 350px;
}
.publicingListThTr{
	font-size: large;
}
.publicingListThTr td{
	padding: 5px;
}
.publicingListThTr:hover {
	background-color: background-color: #B8D7FF;
}
.banPublicingList tr:not(.publicingListThTr):hover {
	background-color: #B8D7FF;
}
.clicked{
	background-color: #B8D7FF;
}
</style>
</head>
<body>
<input type="hidden" class="bannerManageHidden" value="${session_user }">

<div class="adminBannerManage_wrapper">
	 <!--아래는 배너신청 조회하는 모달창 공간-->
    <div class="banner_modal_container">
        <div class="banner_modal_content">
            <div class="banner_modal_body">
                <!--테이블 형식으로 배너신청 게시글의 정보를 뿌려준다. -->
                <form id="bannerSelectForm">
                <table class="bannerSelectTable">
                    <tr>
                        <td class="bannerNo" style="width:120px; text-align: center;"></td>
                        <td class="bannerApplyDate" style="width:150px; text-align: center;"></td>
                        <td class="bannerEmail" style="width:230px; text-align: center;"></td>
                        <td class="bannerType" style="width:120px; text-align: center;"></td>
                        <td class="bannerStatus" style="width:120px; text-align: center;">
                        	<span class="bannerStatusSpan"></span>
                        <!-- 만료처리된 게시글에 대해서는 selext박스를 노출시키지 않는다.  -->
                            <select id="statusSelect" class="statusSelect">	
                                <option value="PUBLICING">게재</option>
                                <option value="DECLINE">거절</option>
                                <option value="WAITING">대기</option>
                                <option value="EXPIRE">만료</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="bannerTitle" colspan="5" style="padding-left: 20px"></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <textarea class="bannerContent" cols="30" rows="5" readonly></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>첨부파일</td>
                        <td colspan="3">
                            <a class="specialA"><span class="bannerImg" data-pfilename=""  style="margin-left: 50px;"></span></a>
                        </td>
                    </tr>
                </table>
                </form>
            </div>
            <br>
            <div class="banner_modal_footer">
                  <button class="bannerSelectCloseBtn" style="float: right;" >닫기</button>
            </div>
        </div>
        <div class="banner_modal_layer"></div>
    </div>
    <script type="text/javascript">
    	const admin = $(".bannerManageHidden").val();
    	
    	// 게재상태값 변경에 따른 이벤트 호출
    	$(".statusSelect").on("change", function(){
    		console.log("변경 이벤트 발생");
    		var email = $(".bannerEmail").text();  // 신청자 이메일 => 거절사유 작성하는 폼을 호출하는 함수의 인수로 사용
    		var bno = $(".bannerNo").text();
    		var applytype = $(".bannerType").text();
    		var selectStatus = $(this).val(); // 선택한 상태값.
    		console.log("선택한 값 조회: " + selectStatus);
    		var data = { banno : bno, email : email };
    		if(selectStatus === "EXPIRE" ){
    			var expireCheck = confirm("해당 신청 항목을 임의로 완료처리를 하시겠습니까?");
    			if(expireCheck){
    				// 객체형태의 값을 가지는 변수 'data'에 키값쌍의 데이터를 추가한다. 
    				data.banpoststatus = "EXPIRE";
    			} else {
    				$(".statusSelect").val('WAITING');
    				return false;
    			}
    		} else if (selectStatus === 'DECLINE'){
    			var declineCheck = confirm("해당 신청 항목에 대해 거절 처리를 할까요? 사유를 작성해야 합니다.");
    			if(declineCheck){
    				data.banpoststatus = "DECLINE"
    			} else {
    				$(".statusSelect").val('WAITING');
    				return false;
    			}
    		} else if( selectStatus === 'PUBLICING' ){
    			var publicingCheck = confirm("게재 리스트에 해당 게시물의 배너이미지를 추가할까요?");
    			if(publicingCheck){
    				data.banpoststatus = "PUBLICING";	
    				data.banapplytype = applytype;
    			} else {
    				$(".statusSelect").val('WAITING');
    				return false;
    			}
    		} else {
    			var waitingCheck = confirm("해당 게시글에 대하여 다시 대기상태로 변경할까요?");
    			if(waitingCheck){
    				data.banpoststatus = "WAITING";
    			} else {
    				$(".statusSelect").val('WAITING');
    				return false;
    			}
    		}
    		console.log(data);
    		// data객체에 대한 값을 정의하고 => ajax를 통해 업데이트 시키는 함수를 호출시킨다.
    		Fnc_BannerStatusUpdate(data);
    	})
    	
    	// 게재상태(banpoststatus) 업데이트 이벤트 by modal
    	function Fnc_BannerStatusUpdate(data){
    		var email = data.email;
    		console.log("배너 게재상태 업데이트 이벤트 호출");
    		console.log("넘어온 글번호 값: " + data.banno);
    		console.log("변경 이후 게재상태 값: " + data.banpoststatus);
    		var statusValue = data.banpoststatus;  // DECLINE, WAITING, PUBLICING, EXPIRE
    		$.ajax({
    			url: "bannerUpdate.do",
    			data: JSON.stringify(data),
    			dataType: "TEXT",
    			contentType: "application/json; charset=utf-8",
    			method: "PUT",
    			success: function(message){
    				console.log("Ajax Call Success~");
    				if(message === "YES"){
    					alert("정상적으로 처리되었습니다.");
    					$('.bannerSelectCloseBtn').val('new');
    					if(statusValue === 'DECLINE'){
							// 거절사유 작성하는 팝업창을 출력시키는 함수 호출
							Fnc_BannerDeclinePopup(admin, email);
    					} 
    				}
    			},
    			error: function(err){
    				// 정상적으로 업데이트가 안 되었다면 sleectbox값을 다시 WAITING.
    				console.log("Ajax Call Fail~~");
					alert("요청 처리 중 문제가 발생했습니다.");
					$(".statusSelect").val('WAITING')
    			}
    		})
    	}
    	
    	// 거절 사유 작성하는 팝업창 호출.
    	function Fnc_BannerDeclinePopup(fromUser, toUser){
    		console.log("fromUser: " + fromUser + ",  toUser: " + toUser);
    		var popUrl = "bannerimageDeclinePop.do";
    		popUrl += "?fromUser=" + fromUser + "&toUser=" + toUser;
    		var popOption = "width = 450px, height=550px, top=250px, left=300px, scrollbars=no";
    		window.open(popUrl, "배너 거절 사유 작성", popOption);
    	}
    	
    	// 모달창 닫기 이벤트 ( 업데이트 내역이 있다면, 닫기를 눌렀을 경우 화면 새로고침 이벤트가 발생한다. );
	    $(".bannerSelectCloseBtn").on("click", function(){
	    	if( $(".bannerSelectCloseBtn").val() != ''){
	    		// 업데이트 변경내역이 있다면 새로고침 이벤트 호출
	    		console.log("모달창 닫기 이벤트 발생. 그리고 변경내역이 존재하지 않아서 새로고침이 일어나지 않음.");
	    		$("#bannerSelectForm")[0].reset(); 
		        $('.banner_modal_container').css("display", "none");
		        $("body").css("overflow", "usnet");
		        location.reload();
	    	} else {
	    		console.log("변경 내역이 존재하지 않음");
	    		// 모달창에서 업데이튼 내역이 없었던 경우 => 단순 모달창 닫기
	    		// 변경 내역이 존재하지 않은 경우=> mebmerNoticeList noticeSelectList.do
		    	$("#bannerSelectForm")[0].reset(); 
		        $('.banner_modal_container').css("display", "none");
		        $("body").css("overflow", "unset");
	    	}
	    })
	    
	    // 첨부파일 다운로드
	    $(".bannerImg").on("click", function(){
	    	console.log("원본명 클릭 확인");
	    	var fileName = $(this).text();
	    	var pfileName = $(this).data('pfilename');
	    	console.log("파일이름: " + fileName);
	    	console.log("물리 파일이름: " + pfileName);
	    	// 첨부파일 다운로드 url매핑 호출
	    	var url = "bannerDownload.do";
	    	url += "?filename=" + fileName;
	    	url += "&pfilename=" + pfileName;
	    	location.href = url;
	    })
    </script>
    <!-- 모달창 끝---------------------------------------------------- -->
    
	<!-- 크게 두 섹션으로 구성 => 실제 배너이미지 조정하는 부분과 배너신청 현황을 조회하는 곳 -->
	<div class="bannerManageForm" style="border-bottom: 1px solid navy;">
		<!-- 일단 테이블로 구현한다 => 출력시킬 데이터 항목: 글번호, 이미지파일원본명, 게시시작일, 게시만료일, 게재상태(select) -->
		<div class="publicingListBox">
			<h2>활성화된 배너이미지</h2>
			<br>
			<div class="resultBox">
				<!-- 여기에 banpoststatus 값이 publicing인 리스트들이 출력된다. -->
			</div>
		</div>
		<div class="bannerimageBox" align="center">	
			<h3>이미지 파일 이름: <span class="selectImageName"></span></h3>
			<!-- 이미지 파일명을 클릭하면 해당 이미지가 출력되는 공간이다.  -->
			<div class="selectImageBox">
				
			</div>
		</div>
	</div>
	<hr>
	<br>
	<div class="bannerApplyListForm">
		<!-- 검색창은 구현하지 않고, 페이징 처리만 해놓을 것. -->
		<table class="bannerApplyListTable">
			<tr class="bannerListThTr">
				<th class="tableThNo" >글번호</th>
				<th class="tableThEmail">신청자 아이디</th>
				<th class="tableThDate">신청일</th>
				<th class="tableThTitle">제목</th>
				<th class="tableThType">신청유형</th>
				<th class="tableThStatus">처리상태</th>
			</tr>
			<c:forEach items="${banner }" var="b">
				<tr class="bannerListTdTr">
					<td style="width: 50px;" >${b.banno }</td>
					<td style="width: 150px;">
						${b.m_email }
					</td>
					<td style="width: 100px;" >
						${b.banapplydate }
					</td>
					<td style="width: 400px; color: teal;" >
						${b.banapplytitle }
					</td>
					<td style="width: 80px;" >
						${b.banapplytype }
					</td>
					<td class="bannerListStatusTd" style="width: 100px;" >
						${b.banpoststatus } 
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

</body>
<script>
	// 배너신청 리스트 클릭 => 모달창 호출. 
	$(".bannerListTdTr").on("click", function(){
		console.log("배너신청 리스트 클릭");
		var banno = $(this).closest("tr").find('td').eq(0).text();
		console.log("해당 리스트의 글번호 확인: " + banno);
		// 모달창을 호출하여 해당 신청리스트의 정보를 출력해야 한다. 
		$.ajax({
			url: "bannerApplySelect.do",
			method: "GET",
			data: {
				banno : banno
			},
			dataType:"JSON",
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				$(".banner_modal_container").css("display", "block");
				$("body").css("overflow", "hidden");
				console.log(data);
				$(".bannerNo").text(data.banno);
				$(".bannerApplyDate").text(data.banapplydate);
				$(".bannerEmail").text(data.m_email);
				$(".bannerType").text(data.banapplytype);
				// 게재상태 값이 만료인 경우라면 => select박스 노출시키지 않기.
				if( data.banpoststatus == 'EXPIRE'){
					$(".statusSelect").css("display", "none");
					$(".bannerStatusSpan").text(data.banpoststatus);
				} else {
					$(".bannerStatusSpan").text('');
					$(".statusSelect").css("display", "block");
					$(".statusSelect").val(data.banpoststatus);
				}  // 배너 이미지 파일의 경우 => 현재 경우의 수 2가지.
				$('.bannerTitle').text(data.banapplytitle);
				$(".bannerContent").val(data.banapplycontent);
				$(".bannerImg").text(data.banfile);
				$(".bannerImg").data('pfilename', data.banpfile);
			},
			error: function(message){
				console.log("호출 실패");
				console.log(message);
			}
		})
	})
	
	// 배너관리 메인페이지 상단에 출력시킬 PUBLICING 리스트 출력 함수.
	function Fnc_bannerListShow(data){
		var tb = $("<table class='banPublicingList' />");
		var thTr = $("<tr class='publicingListThTr' />").append(
			$("<th />").text('No'),
			$("<th />").text('파일명'),
			$("<th />").text('시작일'),
			$("<th />").text('종료일'),
			$("<th />").text('게재상태')
		);
		tb.append(thTr); 
		$.each(data, function(index, item){
			// 화면에 출력시킬 요소 (글번호, 이미지파일명, 게시시작일, 게재만료일, 게시상태(select) )
			var $no = item.banno;
			var $file = item.banfile;
			var $pfile = item.banpfile;
			var $postdate = item.banpostdate;
			var $postenddate = item.banpostenddate;
			var $poststatus = item.banpoststatus;
			var tr = $("<tr class='publicingTr' />").append(
				$("<td />").text($no),
				$("<td />").html("<input type='text' class='imageFileName' value='"+$file+"' data-pfile='" + $pfile + "' readonly>"),
				$("<td />").text($postdate),
				$("<td class='endDateTd' />").text($postenddate),
				$("<td />").text($poststatus)
			);
			tb.append(tr);
		})
		$(".resultBox").append(tb);
		
		// 출력시키고 난 뒤, 오늘 날짜와 게재종료일을 비교하는 함수를 실행한다. 
		Fnc_postenddateCheck();
	}
	
	// 오늘날짜와 게재만료일을 비교하는 함수 정의.
	function Fnc_postenddateCheck(){
		var today = new Date().toISOString().substring(2,10);
		$(".publicingTr").each(function(){
			var endDate = $(this).find('td').eq(3).text();
			console.log("endDate 값: " + endDate);
			if( today > endDate){
				$(this).css("text-decoration", "line-through");
				$(this).css("color", "tomato");
			}
			
		})
		
	}
	
	// 이미지 출력함수 공간의 대상은  selectImageBox  resultBox
	$(".resultBox").on("click", ".imageFileName", function(){
		console.log("라이브 이벤트 실행 테스트");
		console.log( $(this).val());
		console.log( $(this).data('pfile'));
// 		console.log( $(this).closest('tr'));
		var banfileName = $(this).val();
		var banpfileName = $(this).data('pfile');
		var pfileCallPath = encodeURIComponent( banpfileName );
		console.log("인코딩 결괏값 확인: " + pfileCallPath);
		var str = "<img id='bannerImage' src='bannerDisplay.do?banpfileName=" + pfileCallPath + "'>";
		$(".selectImageBox").html(str);
		$(".selectImageName").text(banfileName);
		// 
		$(this).closest('table').find('.publicingTr').removeClass('clicked');
		$(this).closest('tr').addClass('clicked');
	})
	
</script>
<script>
	// 페이지가 로드되자마자 publigin 상태인 데이터들을 화면 상단에 따로 또 노출시킨다. 근데 화면을 새로고침하는 것과 새로 .do를 타는 것은 다른 건가. 
	$(document).on("ready", function(){
		// 모든 리스트들을 화면 상단에 뿌려준다. 출력시키셔 append시킬 div class  resultBox 
		const postStatus = "PUBLICING";
		$.ajax({
			url: "publicingBannerList.do?banpoststatus=" + postStatus,
			method: "GET",
			dataType: "JSON",
			success: function(data){
				console.log("ajax 호출 성공");
				console.log(data);
				Fnc_bannerListShow(data);
			},
			error: function(err){
				console.log("ajx 호출 실패");
				console.log(err);
			}
		})
		
		// 그리고 게재만료일과 오늘날짜를 비교하여, 그 값이 커지게 되면, 알아서 expire로 업데이트 시킨다. 
	})
</script>
</html>