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
.mainPageTableTdTr{
	width: 100%;
	border-bottom: 0.1px solid lightgray;
}
.mainBoards {
	display: flex;
	margin-left: 5%;
	margin-top: 1%;
	width: 70%;
	height: auto;
	border-right: 1px solid lightgray;
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
	border-bottom: 0.1px solid gray;
	color: gray;
}
.tableContentTitle{
	margin-left: 10px;
}
.mainTipBorder{
}
</style>
</head>
<body>
<!-- flex박스를 활용해서 메인 페이지에 공지사항 게시글 5개 정도를 노출시킨다. more누르면 이동. -->
<div class="home_wrapper" style="background-color: #F8F8F8;">
	<!-- 각종 게시판의 내용들을 간략하게 출력해준다.  -->
	<div class="mainBoards">
		<!-- 첫 번째 공지사항 테이블ㄴ -->
		<div class="mainPageListBorder mainNoticeBorder">
			<table class="mainNoticeTable mainPageTable">
					<tr>
						<td class="mainPageTableThTr">
							<h3 style="float: left;"> 공지사항</h3>
							<a href='memberNoticeList.do'><span style="float: right; color: gray;">&lt;더 보기&gt;</span></a>
						</td>
					</tr>
					<c:forEach items="${notices }" var="notice">
						<tr>	
							<td class="mainPageTableTdTr">
								<h5 class="noticeTitleSpan tableContentTitle" onclick="userNoticeRead(${notice.n_no}, ${notice.n_hit })">${notice.n_title }</h5 >
								<div style="display:flex;float: right;">
									<h6 class="mainNoticeWriter">${notice.n_writer }</h6>
									&nbsp;&nbsp;
									<h6 class="mainNoticeWdate">${notice.n_wdate }</h6>
								</div>
							</td>
						</tr>
					</c:forEach>
			</table>
		</div>
		<!-- 두 번째 정보 게시판 테이블 -->
		<div class="mainPageListBorder mainTipBorder">
			<table class="mainTipTalbe mainPageTable">
				<tr>
					<td class="mainPageTableThTr">
						<h3 style="float: left;">정보 & 팁 게시판</h3>
						<a><span style="float: right; color: gray;">&lt;더 보기&gt;</span></a>
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
		<!-- 세 번째로 임의로 들어갈 게시판 정보 -->
		<div class="mainPageListBorder">
			<table class="mainQnaTable mainPageTable">
				<tr>
					<td class="mainPageTableThTr">
						<h3 style="float: left;">질문 게시판</h3>
						<a><span style="float: right; color: gray;">&lt;더 보기&gt;</span></a>
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
	</div>
</div>

</body>
<script>
	//글제목 클릭 시 공지사항 조회할 수 있도록 하기  // 공지사항 클릭 => 글번호 값만 adminNoticeRead.do로 넘기면 된다.
	function userNoticeRead(no, hit) {
		console.log("글번호 확인: " + no);
		console.log("조회수 확인: " + hit);
		//간단하게 쿼리스트링 방식으로 url을 매피한다. => 글번호를통해서 조회하고, 조회수는 1올라감. 
		location.href='memberNoticeRead.do?n_no=' + no + '&n_hit='+hit;
	}	
	
	// 로그인 한 뒤에 todolist볼 수 있도록 출력해야 함. => todolist를 사이드에 둘지, 화면상에 둘지 고민할 것.
	
	
</script>
<script>
</script>
</html>