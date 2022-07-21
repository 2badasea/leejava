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
	.mainBoards {
		display: flex;
	}
	.mainNoticeList {
		border: 1px solid black;
	}
	td{
		border-bottom: 0.5px solid gray;
	}
	#noticeA{
		color: #a0a0a0;
	}
	thead > tr >td {
		width: 400px;
	}
	#noticeTd {
		display: flex;
		justify-content: space-between;
	}
	#noticeTitleSpan:hover{
		cursor: pointer;
	}
</style>
</head>
<body>
<h1>Hello ${session_nickname }!!</h1>
<!-- flex박스를 활용해서 메인 페이지에 공지사항 게시글 5개 정도를 노출시킨다. more누르면 이동. -->
<div class="wrapper">
	<div class="bannerBox">
	
	</div>
	<!-- 임시 구분용 선 -->
	<hr> 
	<div class="mainBoards">
		<div class="mainNoticeList">
			<table>
				<thead>
					<tr>
						<td>
							<span style="float: left;">공지사항</span>
							<a href='memberNoticeList.do' id="noticeA"><span style="float: right;">&lt;more&gt;</span></a>
						</td>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${notices }" var="notice">
					<tr>
						<td id="noticeTd">
							<span id="noticeTitleSpan" onclick="userNoticeRead(${notice.n_no}, ${notice.n_hit })">${notice.n_title }</span>
							<span>${notice.n_wdate }</span>
						</td>
					</tr>
				</c:forEach>
				</tbody>
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