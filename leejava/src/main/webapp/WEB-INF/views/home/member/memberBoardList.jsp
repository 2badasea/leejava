<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<style type="text/css">
.mainWrapper {
	margin-left: 15%;
	margin-top: 1%;
}
.boardTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.boardTableThTr{
	border-bottom: 1px solid #05AA6D;
	background-color: lightgreen;
}
.boardTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}
.boardTable td {
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D	;
	padding: 5px;
}
.boardTable a {
	color: #05AA6D;
	font-weight: bold;
}

/*	********************	*/
.boardListTitleTd:hover{
	cursor: pointer;
}
.boardListTr:hover {
	background-color: #F0FFF0;
}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div class="memberBoardList_wrapper">
		<div class="mainWrapper">
			<div class="boardListWrapper">
				<div style="margin-left: 30%;">
					<h1>자유게시판</h1>
				</div>
				<br>
<!-- 				<div style="margin-left: 55%;"> -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${pagination.listCnt lt pagination.end }"> --%>
<%-- 							<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ --%>
<%-- 								${pagination.listCnt }건)</span> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ --%>
<%-- 								${pagination.end }건)</span> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<!-- 					<br>  -->
<!-- 					<select class="paging" name="searchType" id="listSize" onchange="page(1)" style="margin-left: 10%;"> -->
<%-- 						<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10건 보기</option> --%>
<%-- 						<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15건 보기</option> --%>
<%-- 						<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20건 보기</option> --%>
<!-- 					</select> -->
<!-- 				</div> -->
			</div>
			<div class="boardList">
				<table class="boardTable">
					<tr class="boardTableThTr">
						<th style="width: auto;" class="listTh">글번호</th>
						<th style="width: 400px;" class="listTh">제목</th>
						<th style="width: 100px;" class="listTh">작성일</th>
						<th style="width: 100px;" class="listTh">작성자</th>
						<th style="width: auto;" class="listTh">조회수</th>
						<th style="width: auto;" class="listTh">추천수</th>
					</tr>
					<tr class="boardListTr">
						<td>no</td>
						<td>title</td>
						<td>wdate</td>
						<td>writer</td>
						<td>hit</td>
						<td>likeit</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<script>
	// 스크립트 작성하는 곳.
	console.log("테스트 용도의 자유게시판");
</script>
</html>