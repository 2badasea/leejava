<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
	header{
		display: flex;
		justify-content: space-around;
	}
	.leftHeader a,
	.centerHeader a,
	.rightHeader a{
		margin-left: 30px;
	}
	a:hover{
		cursor: pointer;
	}
	a{
	text-decoration: none;
    display: inline-block;
    color: white;
    -webkit-transition: 0.5s;
    -moz-transition: 0.5s;
    -o-transition: 0.5s;
    -ms-transition: 0.5s;
    transition: 0.5s;
	}

	a:hover {
	    -webkit-transform: scale(1.5,1.5);
	    -moz-transform: scale(1.5,1.5);
	    -o-transform: scale(1.5,1.5);
	    -ms-transform: scale(1.5,1.5);
	    transform: scale(1.5,1.5);
	}
	/* **************새로운 퀴즈카드 세트 모달창*************/
 	.quizcard_modal_container {
           position: fixed;
           top: 0px;
           bottom: 0px;
           width: 100%;
           height: 100vh;
           display: none; 
           z-index: 1;
     }

     .quizcard_modal_content {
         position: absolute;
         top: 30%;
         left: 35%;
         width: 400px;
         height: auto;
         z-index: 3;
         background-color: teal;
         color: white;
         border: 0.5px solid #05AA6D;
         border-radius: 30px;
         padding: 20px;
     }
	
     .quizcard_modal_layer {
         position: relative;
         width: 100%;
		 height: 100%; 
         z-index: 2;
         background-color: #bebebe;
         opacity : 0.5;
         transition: 2s;
     }

     #category_direct {
         width: 120px;
     }
     #quizcard_set_intro{
     	resize: none;
     	width: 300px;
     	height: 150px;
     }
     .archiveBox{
     	border: 1px solid black;
     	width: 500px;
     	height: 300px;
     	background-color: #E8F5FF;
     	color: black;
      	display: none; 
/*      	z-index: 2; */
     	margin-top: 40px;
     	position: absolute;
     }
     .archiveBox a{
     	color: black;
     }
     .archiveHeader{
     	padding: 10px;
     }
     .archiveTable{
     	border: 1px solid gray;
     	width: 100%;
     	border-collapse: collapse;
     }
     .archiveTr:hover{
     	cursor: pointer;
     }
     .archiveTr{
     	border-bottom: 1px solid black;
     }
</style>
</head>
<body>
<header>
	<div class="leftHeader">
		<a href="home.do"><span>홈가기</span></a>
		<a href="quizcard.do"><span>퀴즈카드 메인</span></a>
		<input type="hidden" id="session_user" value="${session_user }">
	</div>
	<div class="centerHeader" style="display: flex;">
			<!-- 여기에 실질적인 메뉴들 삽입 -->
			<a class="archiveBtn">아카이브↓</a>
			<div class="archiveBox">
				<div class="archiveHeader">
					<!-- 각각의 메뉴들에 대해서 클릭하면 ajax로 데이터를 추출해서 밑의 archiveBody에 붙인다. -->
					<a onclick="ajaxStudyingCard('${session_user }')" id="studyingMenu">학습중인 세트</a>
					<a onclick="ajaxBookmarkCard('${session_user }')" id="bookmarkMenu">즐겨찾기</a>
					<a onclick="ajaxMyQuizcard('${session_user }')" id="selfMenu">내가 만든</a>
					<a>스크랩 문제</a>
				</div>	
				<hr>
				<div class="archiveBody">
					<!-- ajax 결괏값들이 들어갈 공간 -->
				</div>
			</div>	
			<a onclick="createNewQuizcard('${session_user}');"><span>새로 만들기</span></a>
	</div>
	<div class="rightHeader">
		<nav>
			<c:if test="${not empty session_user }"> 
				<a href="memberMyInfo.do"><span>마이페이지</span></a>		
			</c:if>	
			<c:if test="${empty session_user }">
				<a href="loginPage.do"><span>로그인하기</span></a>
			</c:if>
			<c:if test="${not empty session_user }">
				<a href="logout.do"><span>로그아웃</span></a>
			</c:if>
		</nav>
	</div>
</header>
<!-- 퀴즈카드 새로 만들기 모달창 생성하기 -->
    <div class="quizcard_modal_container">
        <div class="quizcard_modal_content">
            <div class="quizcard_modal_header">
                <span>New Quizcard </span>
                <button id="quizcardCloseBtn" style="float: right; width: 20px; height: 20px;">X</button>
            </div>
            <br>
            <div class="quizcard_modal_body">
            	<form id="frm" action="createQuizcardSet.do"> <!--------------- form------------- -->
	                <label for="quizcard_set_name">세트 이름</label>
	                <input type="text" id="quizcard_set_name" name="quizcard_set_name">
	                <input type="hidden" id="session_user" value="${session_user}" name="m_email">
	                <input type="hidden" id="session_nickname" value="${session_nickname}" name="m_nickname">
	                <!--카테고리 3개 생성-->
	                <br>
	                <!--   is(":selected") 요소만 선발하기-->
	                <span>카테고리 선택</span>
	                <select id="quizcard_category_first" name="quizcard_category_first">
	                    <option value="All">모두 선택</option>
	                    <option value="Java">Java</option>
	                    <option value="Javascript">Javascript</option>
	                    <option value="HTML&CSS">HTML&CSS</option>
	                    <option value="CS">CS</option>
	                    <option value="Git">Git</option>
	                    <option value="React">React</option>
	                    <option value="Vue">Vue</option>
	                    <option value="DB">DB</option>
	                    <option value="direct">직접입력</option>
	                </select>
	                    <input type="text" style="display: none;" id="category_direct" name="">
	                <br>
	                <span>문제 유형 선택</span>
	                <select id="quizcard_type" name="quizcard_type">
	                	<option value="BOX" selected="selected">박스형</option>
	                	<option value="SHORT">주관식</option>
	                	<option value="SELECT">객관식</option>
	                </select>
	                <br>
	                <span>퀴즈카드 소개(설명)</span>
	                <br>
	                <textarea rows="" cols="" id="quizcard_set_intro" name="quizcard_set_intro"></textarea>
	                <br>
	                <!--여기는 readio박스-->
	                <span>공개여부</span>
	                <br>
	                <label for="public">공개</label>
                   	 	<input type="radio" name="quizcard_set_status" value="PUBLIC" id="public">
                    <label for="private">비공개</label>
                    	<input type="radio" name="quizcard_set_status" value="PRIVATE" id="private">
            	</form> <!--------------- form------------- -->
            </div>
            <br>
            <div class="quizcard_modal_footer">
                <button onclick="createNew()">생성생성!!</button>
            </div>
        </div>
        <div class="quizcard_modal_layer"></div>
    </div>
</body>
<script>
	// 회원이메일 (세션갑승로 읽어들임 => 로그인을 하지 않은 상태라면 null이다.)
	const m_email = $("#session_user").val();

	// archiveBox 리스트 클릭 quizardInfo.jsp로 이동
	$(document).on("click", ".archiveTr", function(){
		var set_no = $(this).children().eq(0).text();
		console.log("퀴즈카드 세트번호 확인: " + set_no);
		// 화면이 전환되는데 굳이 ajax릃 호출할 필요강 없다. ajax는 페이지 내에서. 
		location.href="quizcardBefore.do" + "?set_no=" + set_no + "&m_email=" +m_email ;
	})

	// 내가 만든 세트 조회하기 
	function ajaxMyQuizcard(m_email){
		var m_email = m_email;
		// ajax로 데이터를 요청해서 archiveBox의 body부분에 데이터를 노출시킨다. 
			// 쿼리문 날려서 노출시킬 정보는 세트번호, 세트이름, 그리고 카테고리. 생성일
			// 1. get요청으로 날려서. 2. json형태로 받아서 3. 해당 데이터를 반복문을 돌려 4. 화면에 노출시킨다.
		
		var tb = $("<table class='archiveTable' />");
		$.ajax({
			url: "ajaxMyQuizcard.do",
			type: "GET",
			data: {
				m_email : m_email
			},
// 			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(data){
				console.log("ajax수신 성공");
				console.log(data);
				console.log("데이터 길이: " + data.length);
				// 데이터가 성공적으로 json타입으로 온다면 반복분으로 출력
					// 반환타입이 배열객체형식이다. 서버단에서 list에 담아서 보냈으니깐. 
					// 반복문으로 인덱스로 돌아가며 출력시킨다.
					//console.log(data[0].quizcard_set_no);
				if(data.length !== 0){
					$.each(data, function(index, item){
						var $quizcard_set_no = item.quizcard_set_no;
						var $quizcard_set_name = item.quizcard_set_name;
						var $quizcard_set_cdate = item.quizcard_set_cdate;
						var $quizcard_set_udate = item.quizcard_set_udate;
						var $quizcard_category = item.quizcard_category;
						var tr = $("<tr class='archiveTr' />").append(
							$("<td />").text($quizcard_set_no),
							$("<td />").text($quizcard_set_name),
							$("<td />").html($quizcard_set_cdate + "<br>" + $quizcard_set_udate),
							$("<td />").text($quizcard_category)
						);
						tb.append(tr);
					})
					$(".archiveBody").append(tb);
				} else if(data.length === 0){
					// return되는 값이 null이라면 생성한 퀴즈카드가 없다고 출력시키기. 리턴되는 값이 json형태다. length속성으로 함. 
					var noResultCount = $(".noResult").length;
					if(noResultCount >=1){
						alert("생성한 퀴즈카드가 없습니다.");
						return false;
					}
					var str = "<div class='noResult' style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
					str += "<span>아직 생성한 퀴즈카드가 없습니다. </span></div>";
			        $(".archiveBody").append(str);
					console.log("아직 생성한 퀴즈카드가 없습니다.");
				}
			},
			error: function(data){
				var str = "<div style='display: flex; justify-content: center; margin-top: 50px; font-size: 20px;'>";
				str += "<span>아직 생성한 퀴즈카드가 없습니다. </span></div>";
		        $(".archiveBody").append(str);
				console.log("아직 생성한 퀴즈카드가 없습니다.");
			}
		})
	}
	
	// 아카이브 메뉴 클릭 => div박스 보여주기
	$(".archiveBtn").on("click", function(){
		if(m_email === ""){
			var check = confirm("회원들만 이용하실 수 있는 서비스입니다. 회원가입 하시겠어요?");
			if(check){
				location.href="memberJoinTerms.do";
			} else {
				return false;
			}
		} else{
			$(".archiveBox").toggle();
		}
	})
	
	// 아카이브 외부 영역
	$(document).on("click", function(e){
		if( $(e.target).closest(".archiveBox").length == 0  && !$(e.target).hasClass("archiveBtn")){
			$(".archiveBox").css("display","none");
		}
	})
	
	// 퀴즈 set 생성 이벤트 
		// 여기서 기본적인 form값들 유효성 체크하고, frm.submit() 이벤트 호출하기
	function createNew(){
		// 세트명, 카테고리, 공개여부, 
		// name속성 있는 값들 확인   id) session_user,  quizcard_set_name, quizcard_category_first , name) quizcard_set_status
		var m_email = $("#session_user").val();
		console.log("m_email 확인: " + m_email);
		console.log("세트이름 확인: " + $("#quizcard_set_name").val());
		if( $("#quizcard_category_first").val() === "direct"  ){
			 $("#quizcard_category_first").removeAttr('name');
			 $("#category_direct").attr('name','quizcard_category_first');
		}
		console.log("radio값 확인: " + $("input[name='quizcard_set_status']").val() );
		var introValue = $("#quizcard_set_intro").val();
		console.log("intro값: " + introValue);
		
		$("#frm").submit();
	}
	
	// modal창 <input> 간헐적으로 포커싱이 안 되는 에러
	$("#quizcard_set_name").on("click", function(){
		console.log( $(this) );
		$(this).focus();
	})
    
    // 퀴즈카드 생성 취소 버튼
    $("#quizcardCloseBtn").on("click", function () {
        alert("퀴즈카드 생성을 취소합니다");
        $("#frm")[0].reset();
        $(".quizcard_modal_container").css("display", "none");
    })
	
	
	// 카테고리 selectbox 직접입력 이벤트
	$("#quizcard_category_first").on("change", function () {
	    if ($("#quizcard_category_first").val() === "direct") {
	        console.log("직접 입력 선택");
	        $("#category_direct").css("display", "block").focus();
	    } else {
	    	$("#category_direct").val();
	        $("#category_direct").css("display", "none");
	    }
	})

	// 퀴즈카드 "새로 만들기" 버튼.
	function createNewQuizcard(session_user){
		console.log("user값 확인" + session_user);
		if( !session_user){
			// 로그인 유도. 로그인 또는 회원가입 유도
			alert("회원만 이용할 수 있습니다.");
			var loginCheck = confirm("로그인 후 서비스를 이용하시겠어요?");
			if(loginCheck){
				location.href= "loginPage.do";
			} else {
				return false;
			}
		} else {
		    $(".quizcard_modal_container").css("display", "block");
		    $("#quizcard_set_name").focus();
		}
		
		// 세션이 있는 경우엔, 퀴즈세트 생성을 위한 모달창 호출
		if( $(".quizcard_modal_container").is(":visible") ){
			$("#quizcard_set_name").focus();
		}
	}
	
	// 새로만들기 외부 영역 클릭해도 모달창 비활성화 되도록
	$(document).on("click", ".quizcard_modal_layer", function(e){
		if( !$(e.target).hasClass("quizcard_modal_content")){
			alert("퀴즈카드 생성을 취소합니다");
	        $("#frm")[0].reset();
			$(".quizcard_modal_container").css("display", "none");
		}
	})
</script>

</html>