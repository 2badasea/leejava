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
<style>
/*	페이지 내의 공통적인 디자인 요소들 */	
.mainPageTableThTr{
	width: 100%;
	border-bottom: 1px solid black;
}
.mainPageTableThTr h3{
	color: #05AA6D;
}
.mainPageTableTdTr{
	width: 100%;
	border-bottom: 0.1px solid lightgray;
}
.mainBoards {
	margin-left: 10%;
	margin-top: 1%;
	width: 60%;
	height: auto;
}
.mainBoardsTop, .mainBoardsBottom {
	display: flex;
	justify-content: space-between;
}

.bannerBox{
	height: 150px;
	width: 100%;
	border-bottom: 1px soild coral;
	background-color: whitesmoke;
}

.mainPageListBorder {
	border: 0.1px solid lightgray;
	border-left: 1px solid #05AA6D;
	padding: 10px; 
	background-color: white;
}
.mainPageTable{
	width: 450px;
}
/*	******************************	*/
.tableContentTitle:hover{
	cursor: pointer;
	color: gray;
}
.tableContentTitle{
	margin-left: 10px;
}
.home_wrapper {
	height: 100%;
}
</style>
</head>
<body>
<!-- flex박스를 활용해서 메인 페이지에 공지사항 게시글 5개 정도를 노출시킨다. more누르면 이동. -->
<div class="home_wrapper">
	<!-- 각종 게시판의 내용들을 간략하게 출력해준다.  -->
	<div class="mainBoards">
		<div class="mainBoardsTop">
			<!-- 첫 번째 공지사항 테이블 -->
			<div class="mainPageListBorder mainNoticeBorder">
				<table class="mainNoticeTable mainPageTable">
						<tr>
							<td class="mainPageTableThTr">
								<h3 style="float: left;"> 공지사항</h3>
								<a href='memberNoticeList.do'><span style="float: right; color: gray; font-size: 12px;">&lt;더 보기&gt;</span></a>
							</td>
						</tr>
						<c:forEach items="${notices }" var="notice">
							<tr>	
								<td class="mainPageTableTdTr">
									<h5 class="noticeTitleSpan tableContentTitle" onclick="userNoticeRead(${notice.n_no}, ${notice.n_hit })">${notice.n_title }</h5 >
									<div style="display:flex; float: right;">
										<h6 class="mainNoticeWriter">${notice.n_writer }</h6>&nbsp;&nbsp;
										<h6 class="mainNoticeWdate">${notice.n_wdate }</h6>
									</div>
								</td>
							</tr>
						</c:forEach>
				</table>
			</div>
			<!-- 두 번째 "정보 게시판" 테이블 -->
			<div class="mainPageListBorder mainTipBorder">
				<table class="mainTipTalbe mainPageTable">
					<tr>
						<td class="mainPageTableThTr">
							<h3 style="float: left;">정보 & 팁 게시판</h3>
							<a><span style="float: right; color: gray; font-size: 12px;">&lt;더 보기&gt;</span></a>
						</td>
					</tr>
	<%-- db를 설계한 다음에, vo객체를 생성하고 컨트롤러를 통해 값을 전달해야 하는 부분 <c:forEach items="" var=""> --%>
						<tr>
							<td class="mainPageTableTdTr">
								<h5 class="tableContentTitle"></h5>
								<div style="display: flex; float: right;">
									<h6></h6>
									&nbsp;&nbsp;
									<h6></h6>
								</div>
							</td>
						</tr>
	<%-- 				</c:forEach> --%>
				</table>
			</div>
		</div>
		<br>
		<div class="mainBoardsBottom">
			<!-- 세 번째로 임의로 들어갈 게시판 정보 -->
			<div class="mainPageListBorder">
				<table class="mainQnaTable mainPageTable">
					<tr>
						<td class="mainPageTableThTr">
							<h3 style="float: left;">질문 게시판</h3>
							<a><span style="float: right; color: gray; font-size: 12px;">&lt;더 보기&gt;</span></a>
						</td>
					</tr>
	<%-- 				<c:forEach items="" var=""> --%>
						<tr>
							<td class="mainPageTableTdTr">
								<h5 class="tableContentTitle"></h5>
								<div style="display: flex; float: right;">
									<h6></h6>
									&nbsp;&nbsp;
									<h6></h6>
								</div>
							</td>
						</tr>
	<%-- 				</c:forEach> --%>
				</table>
			</div>
			<!-- 네 번째로 임의로 들어갈 자유게시판 정보 -->
			<div class="mainPageListBorder">
				<table class="mainBoardTable mainPageTable">
					<tr>
						<td class="mainPageTableThTr">
							<h3 style="float: left;">자유 게시판</h3>
							<a href="boardList.do"><span style="float: right; color: gray; font-size: 12px;">&lt;더 보기&gt;</span></a>
						</td>
					</tr>
					<c:forEach items="${boards }" var="board">
						<tr>	
							<td class="mainPageTableTdTr">
								<h5 class="boardsTitleSpan tableContentTitle" onclick="userBoardRead(${board.boardNo}, ${board.boardHit })">${board.boardTitle }</h5 >
								<div style="display:flex; float: right;">
									<h6 class="mainNoticeWriter">${board.boardWriter}</h6>&nbsp;&nbsp;
									<h6 class="mainNoticeWdate">${board.boardWdate}</h6>
								</div>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>

</body>
<script>
	// 공지사항 조회 이동
	function userNoticeRead(no, hit) {
		location.href='memberNoticeRead.do?n_no=' + no + '&n_hit='+hit;
	}	
	
	// 자유게시판 조회 이동
	function userBoardRead(boardNo, boardHit){
		location.href = 'boardRead.do?boardNo=' + boardNo + "&boardHit=" + boardHit;
	}
	 
	
</script>
</html>