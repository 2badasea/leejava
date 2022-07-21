<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.memberListWrapper{
	margin-left: 10%;
	margin-top: 10%;
}
#memberInfo{
	width: 100%;
}
</style>
</head>
<body>
	<!-- 컨셉은 공지사항 리스트와 비슷하게 우선 wrppaer를 깔고 그 위에 얹어야 할 듯. -->
	<!-- 검색바는 일단 나중에 하고, 우선은 리스트만 출력시키기. => 뷰를 통해서 전달한다. -->
<body>
	<div class="wrapper">
		<div class="memberListWrapper">
			<table border="1">
				<!--들어갈 항목 => 이메일, 닉네임, 가입날짜, 가입경로, 상태, 개인정보, 프로로모션 정보-->
				<thead>
					<tr>
						<th width="200px;">이메일</th>
						<th width="150px;">닉네임</th>
						<th width="120px;">가입일</th>
						<th width="120px;">가입경로</th>
						<th width="120px;">권한</th>
						<th width="120px;">개인정보동의</th>
						<th width="120px;">프로모션동의</th>
						<th width="100px;">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${members }" var="member">
					<tr>
						<td>${member.m_email }</td>
						<td>${member.m_nickname }</td>
						<td>${member.m_joindate }</td>
						<td>${member.m_joinpath }</td>
						<td>${member.m_status }</td>
						<td>${member.m_privacy }</td>
						<td>${member.m_promotion }</td>
						<td>
							<input type="button" id="memberInfo" value="관리">
						</td>
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