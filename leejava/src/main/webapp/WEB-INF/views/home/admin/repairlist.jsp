<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 유지보수 리스트 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
/* ********** 공통 ***************/
.repairSearchWrapper{
	margin-top: 3%;
}
.repairListDiv,
.repairSearch{
	padding-right: 15%;
}
.repairSearchWrapper button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: whitesmoke;
	background-color: #313348;
	font-weight: 900;
}
.repairSearchWrapper button:hover {
	cursor: pointer;
	background-color: whitesmoke;
	color: #313348;
	transition: 0.5s;
}

/* ***	검색차 영역 디자인	***	 */
.repairSearchTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}

.repairSearchTable tr{
	border-bottom: 1px solid #313348; 
}

.repairSearchTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}

.repairSearchTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 1px solid #313348;
	padding: 5px; 
}

.repairSearchTable input,
.repairSearchTable select{
	width: 100%;
	font-size: 100%;
	text-align: center;
	height: 100%;
	border-style: none;
	font-weight: 700;
	border-bottom: 0.5px solid #313348;
}

.repairSearchTable input:focus,
.repairSearchTable select:focus,
.repairSearchTable option:focus{
	outline-color: coral;
}

.repairSearchBtns{
	margin-top: 20px;
}
.repairSearchBtns button{
	min-width: 100px;
	min-height: 40px;
} 

/*	***	 유지보수 리스트 디자인 	***	*/
.repairListTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}

.repairListTr:hover{
	background-color: lightgray;
}

.repairListTableThTr{
	border-bottom: 1px solid #313348;
}

.repairListTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}

.repairListTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 0.5px swolid whitesmoke;
	padding: 5px;
}

/*	유지보수 작성 폼 디자인 */
.repairForm{
	border: 0.5px solid #313348; 
	min-width: 50%;
	min-height: 300;
	display: none;
}
.repairSearchOpenBtn{
	display: none;
}
</style>
</head>
<body>
<div class="repairList_wrapper">
    <!-- 검색요소 중에 입력해야 할 요소가 있나>? 카테고리(selectbox), 제목 내용, 진행상태, 기간? -->
   <div class="repairSearchWrapper">	
   		<div class="repairForm&SearchBtns">
	   		<button class="repairFormOpoenBtn">유지보수 사항 추가</button>
	   		<button class="repairSearchOpenBtn">유지보수 리스트 검색</button>
   		</div>
   		<!-- 유지보수 입력창을 호출하는 폼을 호출한다. --> 
   		<div class="repairForm" align="center">
   			<!-- 그냥 테이블 형식으로 하고 나중에 별도로 레이아웃 수정하는 방식으로 하자  -->
   		</div>
   
   		<div class="repairSearch" align="center">
	       <table class="repairSearchTable">
	           <tr>
	               <th>제목</th>
	               <td style="width: 300px;">
	                   <input type="text" id="rTitle" class="searchInput rTitle" placeholder="제목을 입력해주세요." > 
	               </td>
	               <th>내용</th>
	               <td style="width: 300px;">
	                   <input type="text" id="rContent" class="searchInput rContent" placeholder="내용을 입력해주세요.">
	               </td>
	           </tr>
	           <tr>
	               <th>카테고리</th>
	               <td>
	                   <select id="rCategory" class="searchInput rCategory">
	                       <option value="ALL" selected="selected">전체</option>
	                       <option value="USER">사용자</option>
	                       <option value="QUIZCARD">퀴즈카드</option>
	                       <option value="ADMIN">관리자</option>
	                   </select>
	               </td>
	               <th>작성자</th>
	               <td>
	                   <input type="text" id="m_email" class="searchInput m_email" placeholder="작성자의 닉네임을 입력해주세요.">
	               </td>
	           </tr>
	       </table>
	       <div class="repairSearchBtns">
	           <button type="button" class="clearBtn">초기화</button>
	           <button type="button" class="repairSearchBtn">검색</button>
	       </div>
       </div>
		<br>
		<br>
		<hr>
		<br>
  		<!-- 유지보수 리스트 -->
	   <div class="repairListDiv" align="center">
	    <!--한 페이지에 몇 개의 rowdate를 출력시킬지에 대한 구성요소-->
	    
	    <!--버튼이 들어가는  공간-->
	        <table class="repairListTable">
	            <tr class="repairListTableThTr">
	                <th class="listTh">
	                    <input type="checkbox" class="allCheckBtn">
	                </th>
	                <th class="listTh">No.</th>
	                <th class="listTh">중요도</th>
	                <th class="listTh">카테고리</th>
	                <th class="listTh">제목</th>
	                <th class="listTh">진행상황</th>
	                <th class="listTh">작성일/완료일</th>
	            </tr> 
<%-- 	            <c:forEach items="" var=""> --%>
	            	<tr class="repairListTr">
		                <td><input type="checkbox" class="subCheckBtn" data-value="${repair.rno}"></td>
		                <td>${repair.rno}</td>
		                <td>${repair.rGrade}</td>
		                <td>${repair.rCategory}</td>
		                <td>${repair.rTitle}</td>
		                <td>${repair.rStatus}</td>
		                <td>${repair.rWdate} // ${repair.rFdate}</td>
		            </tr>
<%-- 		        </c:forEach> --%>
	        </table>
		
		</div>
   </div>
</div>
</body>
<script>
	// 유지보수 작성 폼 호출
	$('.repairFormOpoenBtn').on("click", function(){
		console.log("유지보수 작성폼 호출");
		$(".repairForm").css('display', 'block');
		$('.repairFormOpoenBtn').css("display", "none");
		$('.repairSearchOpenBtn').css("display", "block");
		$(".repairSearch").css("display", "none");
	})
	
	// 유지보수 검색 폼 호출
	$(".repairSearchOpenBtn").on("click", function(){
		console.log("검색 창 호출");
		$(".repairSearchOpenBtn").css("display", "none");
		$('.repairFormOpoenBtn').css("display", "block");
		$(".repairSearch").css("display", "block");
	})
</script>
<script>
	$(document).on("ready", function(){
		console.log("현재 시간: " + new Date());		
	})
</script>
</html>