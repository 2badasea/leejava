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
                        			<h6>${list.quizcard_set_cdate }</h6>
                        			<h6>${list.quizcard_set_udate }</h6>
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

</script>
</html>