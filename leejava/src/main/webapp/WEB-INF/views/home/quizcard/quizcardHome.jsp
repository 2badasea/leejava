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
	tbody > tr:hover{
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
                            <th>세트이름</th>
                            <th>생성일/마지막수정</th>
                            <th>만든이</th>
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
                        		<td>
                        			<span>${list.quizcard_set_cdate }</span>
                        			<span>/ ${list.quizcard_set_udate }</span>
                        		</td>
                        		<td>${list.m_nickname }</td>
                        		<td>${list.quizcard_set_hit }</td>
                        		<td>${list.quizcard_set_likeit }</td>
                        	</tr>
                        </c:forEach>
                    </tbody>
                </table>
        </div>
    </div>
    
</body>
<script>
	//회원이메일 (현재 header영역에서 const식별자로 정의되어 있는 상태.)
	console.log("현재 로그인 계정 조회: " + m_email);
	
	// 퀴즈카드  리스트 클릭 quizardInfo.jsp로 이동
	$("tbody> tr").on("click", function(){
		var setNo = $(this).find("td").eq(0).text();
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
</script>
</html>