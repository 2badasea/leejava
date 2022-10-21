<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.mainWrapper {
	margin-left: 13%;
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
.paginationBox{
	display: flex;
	justify-content: center;
	margin-right: 500px;
	margin-top: 20px;
}
.paginationUl > li{
	list-style-type: none;
	float: left;
	padding: 5px;
}
.paginationLink {
	color: teal;
	font-size: 20px;
}
.active a{
	font-weight: bolder;
	color: tomato;
	font-size: large;
} 
.boardWritingBtn{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 900;	
	min-width: 100px;
	min-height: 40px;
	margin-right: 40px;
}
.boardWritingBtn:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
</style>
<script>
	// 화면에 문서가 모두 출력된 다음에 실행시킬 이벤트
	$(document).on("ready", function(){
		console.log("자유 게시판 출력");
	})
</script>

</head>
<body>
	<div class="memberBoardList_wrapper">
		<div class="mainWrapper">
			<div class="boardListWrapper">
				<div style="margin-left: 28%;">
					<h1>자유게시판</h1>
				</div>
				<br>
				<div style="margin-left: 55%;">
					<c:choose>
						<c:when test="${pagination.listCnt lt pagination.end }">
							<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~
								${pagination.listCnt }건)</span>
						</c:when>
						<c:otherwise>
							<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~
								${pagination.end }건)</span>
						</c:otherwise>
					</c:choose>
					<br> 
					<select class="paging" name="searchType" id="listSize" onchange="page(1)" style="margin-left: 10%;">
						<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10건 보기</option>
						<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15건 보기</option>
						<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20건 보기</option>
					</select>
				</div>
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
					<c:forEach items="${board }" var="board">
						<tr class="boardListTr">
							<td>${board.boardNo }</td>
							<td>${board.boardTitle }</td>
							<td>${board.boardWdate }</td>
							<td>${board.boarTitle }</td>
							<td>${board.boardHit }</td>
							<td>${board.boardLikeit }</td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${session_nickname ne null }">
					<button class="boardWritingBtn">글쓰기</button>
				</c:if>
			</div>
		</div>
		
		<!-- paging 박스가 들어갈 곳  -->
		<div id="paginationBox" class="paginationBox">
			<ul class="paginationUl">
				<c:if test="${pagination.prev }">
					<li class="paginationLi">
						<a class="paginationLink specialA" onclick="fn_prev('${pagination.page}', '${pagination.range }',
																	'${pagination.rangeSize }','${pagination.listSize }',
																	'${search.boardWriter }', '${search.boardTitle }',
																	'${search.boardContents }')">이전</a>
					</li>
				</c:if>
				<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="boardNo">
					<li class="paginationLi <c:out value="${pagination.page == boardNo ? 'active' : '' }" />" >
						<a class="paginationLink specialA" onclick="fn_pagination('${noticeNo}', '${pagination.range }',
																		'${pagination.rangeSize }', '${pagination.listSize }',
																		'${search.boardWriter }', '${search.boardTitle }',
																		'${search.boardContents }')">${noticeNo }</a>
					</li> 
				</c:forEach>
				<c:if test="${pagination.next }">
					<li class="paginationLi">
						<a class="paginationLink specialA" onclick="fn_next('${pagination.page}', '${pagination.range }',
																	'${pagination.rangeSize }', '${pagination.listSize }',
																	'${search.boardWriter }', '${search.boardTitle }',
																	'${search.boardContents }')">다음</a>
					</li>
				</c:if>
			</ul>
		</div>
		<div class="boardSearchWrapper"  >
			<select id="boardSearchSelect" class="boardSearchSelect" onchange="fn_selectBox()">
	            <option value="writer">작성자</option>
	            <option value="title">제목</option>
	            <option value="content">내용</option>
	            <option value="titleAndContent" selected>제목 + 내용</option>
	        </select>
   			<input type="text" class="searchInputBox">
   			<button class="boardSearchBtn">검색</button>
		</div>
	</div>
</body>
<script>
	// 자유게시판 작성폼으로 이동
	$(".boardWritingBtn").on("click", function(){
		let boardWritingCheck = confirm("게시글을 작성하시겠어요?");
		if(boardWritingCheck){
			location.href = "boardWritingForm.do";
		} else {
			return false;
		}
	})
</script>
</html>