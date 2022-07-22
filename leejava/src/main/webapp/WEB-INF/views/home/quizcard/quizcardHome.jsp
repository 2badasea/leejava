<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈카드 메인페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
	.quizcardMain{
		border: 0.3px solid #FFCAD5;	
		height: 40vh;
	}
	.quizcardListWrapper{
		border: 0.3px solid #3BE0CB;
		height: 50vh;
	}
	.quizcardTable{
		margin-top: 5%;
	}
	 
	.quizcardTable td:nth-child(4):hover{
		cursor: pointer;
	}
	.quizcardTable td:nth-child(6):hover{
		cursor: pointer;
	}
	
	/* 퀴즈카드 학습모드 선택 모달창 */
	        .studyType_modal_container {
            position: fixed;
            top: 0px;
            bottom: 0px;
            width: 100%;
            height: 100vh;
            display: none;
            z-index: 1;
        }

        .studyType_modal_content {
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

        .studyType_modal_layer {
            position: relative;
            width: 100%;
            height: 100%;
            z-index: 2;
            background-color: transparent;
            transition: 2s;
        }

        fieldset {
            border: 1px solid white;
        }
        /* 퀴즈카드 학습모드 선택 모달창============================ */
        /* 사용자 정보 모달창 */
        /* 사용자 정보 조회하는 모달창 */
.userInfo_modal_container {
    position: fixed;
    top: 0px;
    bottom: 0px;
    width: 100%;
    height: 100vh;
    display: none;
    z-index: 1;
}

.userInfo_modal_content {
    position: absolute;
    top: 20%;
    left: 30%;
    width: 700px;
    height: auto;
    z-index: 3;
    background-color: white;
    border: 0.5px solid #05AA6D;
    border-radius: 30px;
    padding: 30px;
}

.userInfo_modal_layer {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: grey;
    opacity: 0.3;
    transition: 2s;
}
.userInfoModalCloseBtn{
	margin-top: 50px;
    float: right;
    width: 100px;
    height: 50px;
    border-radius: 20px;
    background: white;
    color: teal;
    border-style: none;
    font-size: 20px;
    font-weight: bold;
}
.userInfoModalCloseBtn:hover{
	cursor: pointer;
	background-color: teal;
	color: white;
	transition: 1s;
	
}
.userInfo_modal_body{
    display: flex;
}
.profileImg{
	width: 200px;
	height: 200px;
	border-style: none;
}
.userInfo_quizcardTb{
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 10px;
}
.userInfo_quizcardTr{
	border-bottom: 0.5px dashed teal;
	margin-top: 3px;
}
.userInfo_quizcardTr:hover{
	cursor: pointer;
	
}
.userInfoFieldset{
	border: 1px solid teal;
}
.userInfo_modal_footer{
	margin-bottom: 10%;
}
.userInfo_right{
	width: 60%;
}
.userInfo_right textarea {
	width: 95%;
	height: 95%;
	border-radius: 20px;
	padding: 8px;
}
.userInfo_modal_content input {
	border-style: none;
	font-size: 18px;
	color: teal;
	font-weight: bolder;
}
</style>
</head>
<body>

    <div class="quizcardWrapper">
        <!-- 우선 게시판부터 생성하자 -->
        <div class="quizcardMain">나중에 넣을 서치 공간</div>
        <hr>
        <div class="quizcardListWrapper" align="center">
            <!--  table 형태로 생성한다.-->
                <table border="1" class="quizcardTable">
                    <thead>
                        <tr>
                            <th>세트번호</th>
                            <th>카테고리</th>
                            <th>세트유형</th>
                            <th style="width: 300px;">세트이름</th>
                            <th>최근 업데이트</th>
                            <th style="width: 100px;">만든이</th>
                            <th>조회수</th>
                            <th>추천수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${quizcardList }" var="list">
                        	<tr>
                        		<td>${list.quizcard_set_no }</td>
                        		<td>${list.quizcard_category }</td>
                        		<td>${list.quizcard_type }</td>
                        		<td>${list.quizcard_set_name }</td>
                        		<td>${list.quizcard_set_udate }</td>
                        		<td class="userInfoTd">${list.m_nickname }</td>
                        		<td>${list.quizcard_set_hit }</td>
                        		<td>${list.quizcard_set_likeit }</td>
                        	</tr>
                        </c:forEach>
                    </tbody>
                </table>
        </div>
    </div>
    
     <!-- 사용자 정보 조회하는 모달창  -->
    <div class="userInfo_modal_container">
        <div class="userInfo_modal_content">
            <div class="userInfo_modal_header">
                <span id="userInfoTitle">(사용자 닉네임)님의 정보</span>
            </div>
            <div class="userInfo_modal_body">
                <div class="userInfo_left">
                    <div class="userInfo_image">
                    	<img class="profileImg"  alt="사진을 준비중입니다." src="resources/image/loopy.jpeg">
                    </div>
                    <div class="userInfo_subInfo">
                        <label for="m_nickname">닉네임</label>
                        <input type="text" id="m_nickname" value="" readonly="readonly">
                        <br>
                        <label for="m_joinDate">가입날짜</label>
                        <input type="text" id="m_joindate" value="" readonly="readonly">
                    </div>
                </div>
                <div class="userInfo_right">
                    <label for="userIntroForm" id="userIntroLabel"></label>
                    <div class="userInfo_IntroForm">
                        <textarea id="userIntroForm" cols="30" rows="15" readonly="readonly"></textarea>
                    </div>
                </div>
            </div>
            <br>
            <hr>
            	<fieldset class="userInfoFieldset">
	            	<legend>작성한 퀴즈카드</legend>
	               	<div class="userInfo_quizcard">
	               		
	               	</div>
            	</fieldset>
            <br>
            <div class="userInfo_modal_footer">
                <button class="userInfoModalCloseBtn">닫기</button>
            </div>
        </div>
        <div class="userInfo_modal_layer"></div>
    </div>
</body>
<script>
	//회원이메일 (현재 header영역에서 const식별자로 정의되어 있는 상태.)
	var m_email = $("#session_user").val();
	console.log("현재 로그인 계정 조회: " + m_email);
	
	// 퀴즈카드 before페에지로 이동	
	$(".quizcardTable td:nth-child(4)").on("click", function(){
		var setNo = $(this).parent().find("td").eq(0).text();
		location.href="quizcardBefore.do" + "?set_no=" + setNo + "&m_email=" + m_email;
	})

	// 리스트에 마우스 올라가면 배경색상이 변경되도록
	$("tbody > tr").on({
		mouseover: function(){
			$(this).css("backgroundColor", "#E8F5FF")
		},
		mouseout: function(){
			$(this).css("backgroundColor", "white");
		}
	})
	
	// 사용자 정보 조회하는 모달창 관련 스크립트 부분(공통영역)  ------------------------- 작업 끝나고 밑으로 내려보내기
	$(".quizcardTable td:nth-child(6)").on("click", function(e){
		console.log("유저 닉네임 클릭");
		let email;
		console.log( $(e.target).text()); 
		$("body").css("overflow", "hidden");	// 모달창 호출 => body영역 스크롤 방지
		$(".userInfo_modal_container").css("display", "block");
		var sendNickname = $(e.target).text();
		// 첫 번째 ajax로 프로필 정보(닉네임, 이메일, 가입날짜, intro + 프로필이미지 정보)		
		$.ajax({
			url: "ajaxUserInfo.do?m_nickname=" +  sendNickname,
			type: "GET",
			dataType: "json",
			async: false,
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				email = data.m_email;
				$("#m_nickname").val(data.m_nickname);
				$("#m_joindate").val(data.m_joindate);
				$("#userIntroForm").val(data.m_intro);
				$("#userInfoTitle").html(data.m_nickname + " 님의 사용자 정보");
				$("#userIntroLabel").text(data.m_nickname + " 님의 Intro");
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
		// 두 번째 ajax => 작성한 퀴즈카드 정보 넣기. 
		var tb = $("<table class='userInfo_quizcardTb' />");
		$.ajax({
			url: "ajaxMyQuizcard.do",
			type: "GET",
			dataType: "json",
			data: {
				m_email: email
			},
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				// json 배열의 타입을 출력시켜야 한다   class="userInfo_quizcard" 여기 공간에 append 시킨다. 
				$.each(data, function(index, item){
					var tr = $("<tr class='userInfo_quizcardTr' />").append(
							$("<td />").text(item.quizcard_set_no),
							$("<td />").text(item.quizcard_set_name),
							$("<td />").text(item.quizcard_set_cdate),
							$("<td />").text(item.quizcard_category));
					tb.append(tr);
				})
				$(".userInfo_quizcard").append(tb);
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
	})
	
	// 모달창 닫기버튼(X) 
	$(".userInfoModalCloseBtn").on('click', function(){
		console.log("사용자 정보 창 닫기");
		$(".userInfo_quizcard").empty();  // div안의 영역을 초기화 시켜준다. 
		$("body").css("overflow", "unset"); // 모달창 호출 => 스크롤 방지 해제
		$(".userInfo_modal_container").css('display', 'none');
	})
	
	// 외부영역 클릭 모달창 닫기
	$(document).on("click", function(e){
		if( $(e.target).closest('.userInfo_modal_content').length == 0 && !$(e.target).hasClass('userInfoTd') ){
			$(".userInfo_quizcard").empty(); 
			$("body").css("overflow", "unset");
			$(".userInfo_modal_container").css('display', 'none');
		}	
	})
	
	// 동적으로 추가된 tr클릭 => 퀴즈카드 set이동 
	$(document).on("click", ".userInfo_quizcardTr", function(e){
		var check = confirm("해당 퀴즈카드로 이동하시겠습니까?");
		if(check){
			var set_no = $(e.target).parent().find('td').eq(0).text();
			var email = $("#session_user").val();
			location.href='quizcardBefore.do?set_no=' + set_no +"&m_email=" + email;
		} else {
			return false;
		}
	})
</script>
</html>