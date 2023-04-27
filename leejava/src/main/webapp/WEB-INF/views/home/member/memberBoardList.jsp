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
.boardList{
	width: 70%;
}
.boardListTitleTd:hover{
	cursor: pointer;
}
.boardListTr:hover {
	background-color: #F0FFF0;
}
.paginationBox{
	display: flex;
	justify-content: center;
	margin-left: 10%;
	margin-top: 3%;
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
	margin-right: 8%;
	float: right;
	margin-top: 1%;
}
.boardWritingBtn:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.boardSearchBtn{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 600;	
	min-width: 50px;
	min-height: 20px;
}
.boardSearchBtn:hover{
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.boardSearchWrapper{
	margin-left: 20%;
	margin-top: 1%;
}
.boardSearchWrapper select, option, input{
	height: 20px;
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
						<th style="width: 450px;" class="listTh">제목</th>
						<th style="width: 100px;" class="listTh">작성일</th>
						<th style="width: 100px;" class="listTh">작성자</th>
						<th style="width: auto;" class="listTh">조회수</th>
						<th style="width: auto;" class="listTh">추천수</th>
					</tr>
					<c:forEach items="${board }" var="board">
						<tr class="boardListTr">
							<td>${board.boardNo }</td>
							<td class="boardListTitleTd" onclick="Fn_boardRead(${board.boardNo},${board.boardHit })">${board.boardTitle }
									<c:if test="${board.replyCnt != 0 }">
										<span style="float: right; color: gray; padding-right: 5%;">[ ${board.replyCnt} ]</span>
									</c:if> 
							</td>
							<td style="font-size: small;">${board.boardWdate }</td>
							<td>${board.boardWriter }</td>
							<td>${board.boardHit }</td>
							<td>${board.boardLikeit }</td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${session_nickname ne null }">
					<button class="boardWritingBtn">글쓰기</button>
				</c:if>
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
							<a class="paginationLink specialA" onclick="fn_pagination('${boardNo}', '${pagination.range }',
																			'${pagination.rangeSize }', '${pagination.listSize }',
																			'${search.boardWriter }', '${search.boardTitle }',
																			'${search.boardContents }')">${boardNo }</a>
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
			<script>

			</script>
			<div class="boardSearchWrapper">
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
		
	</div>
</body>
<script>
	// 페이징 "이전" 출력
	function fn_prev(page, range, rangeSize, listSize, boardWriter, boardTitle, boardContents){
		var page = ( (range -2 ) * rangeSize) + 1;
		var range = range - 1;
		var url = "boardList.do";
		url += "?page=" + page;
		url += "&range=" + range;
		url += "&rangeSize=" + rangeSize;
		url += "&listSize=" + listSize;
		url += "&boardWriter=" + boardWriter;
		url += "&boardContents=" + boardContents;
		location.href = url;
	}
	
	// 페이징 "다음" 구현
	function fn_next(page, range, rangeSize, listSize, boardWriter, boardTitle, boardContents){
		var page = (range * rangeSize) + 1;
		var range = range++;
		var url = "boardList.do";
		url += "?page=" + page;
		url += "&range=" + range;
		url += "&listSize=" + listSize;
		url += "&boardWriter=" + boardWriter;
		url += "&boardTitle=" + boardTitle;
		url += "&boardContents=" + boardContents; 
		location.href = url;
	}
	
	// range내에서 페이지 이동
	function fn_pagination(boardNo, range, rangeSize, listSize, boardWriter, boardTitle, boardContents){
		var url = "boardList.do";
		url += "?page=" + boardNo;
		url += "&range=" + range;
		url += "&listSize=" + listSize;
		url += "&boardWriter=" + boardWriter;
		url += "&boardTitle=" + boardTitle;
		url += "&boardContents=" + boardContents;
		
		location.href = url;
	}
	
	// 페이징 출력 개수 변경 
	function page(Paging){
		let startPage = Paging;
		let listSize = $("#listSize option:selected").val();
		let url = "boardList.do?startPage=" + startPage + "&listSize=" + listSize;
		location.href = url;
	}

	// 다중 검색
	$('.boardSearchBtn').on('click', function(){
		console.log('검색 클릭');
		var title = '';
		var content = '';
		var writer = '';
		var titleAndContent = '';
		
		var select = $(".boardSearchSelect option:selected").val();
		var data = $('.searchInputBox').val();
		if(select == 'writer'){
			writer = data;
		}else if(select == 'title'){
			title = data;
		}else if(select == 'content'){
			content = data;
		}else if(select == 'titleAndContent'){
			title = data;
			content = data;
		}
		
		var url = "boardList.do";
		url += "?boardWriter=" + writer;
		url += "&boardTitle=" + title;
		url += "&boardContents=" + content;
		
		location.href = url;
	
	})
	

	// 자유게시판 게시글 조회
	function Fn_boardRead(boardNo, boardHit){
		console.log("번호:" + boardNo);
		console.log("조회수: " + boardHit);
		location.href = "boardRead.do?boardNo=" + boardNo + "&boardHit=" + boardHit;
	}

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