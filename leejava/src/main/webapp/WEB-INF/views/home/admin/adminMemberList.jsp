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
.memberInfoBtn{
	width: 100%;
}
.statusSelect{
	width: 100%;
}
</style>
</head>
<body>
<input type="hidden" class="adminPageHiddenInput" data-status="${session_status }" data-user="${session_user }">
	<!-- 컨셉은 공지사항 리스트와 비슷하게 우선 wrppaer를 깔고 그 위에 얹어야 할 듯. -->
	<!-- 검색바는 일단 나중에 하고, 우선은 리스트만 출력시키기. => 뷰를 통해서 전달한다. -->
<body>
	<div class="wrapper">
		<div class="memberListWrapper">
			<table border="1">
				<!--들어갈 항목 => 이메일, 닉네임, 가입날짜, 가입경로, 상태, 개인정보, 프로로모션 정보-->
				<thead>
					<tr>
						<th width="120px;">가입일</th>
						<th width="200px;">이메일</th>
						<th width="150px;">닉네임</th>
						<th width="120px;">가입경로</th>
						<th width="120px;">권한</th>
						<th width="120px;">개인정보동의</th>
						<th width="120px;">프로모션동의</th>
						<th width="100px;">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${member }" var="member">
					<tr data-email="${member.m_email }" data-status="${member.m_status }">
						<td>
							<input type="hidden" class="memberInfoHidden" data-email="${member.m_email }" data-status="${member.m_status }">
							${member.m_joindate }
						</td>
						<td>${member.m_email }</td>
						<td>${member.m_nickname }</td>
						<td>${member.m_joinpath }</td>
						<td>
							<c:if test="${session_user == 'bada' }">
								<select class="statusSelect">
									<option value="ADMIN" <c:if test="${member.m_status eq \"ADMIN\" }">selected="selected"</c:if>>ADMIN</option>
									<option value="USER" <c:if test="${member.m_status eq \"USER\" }">selected="selected"</c:if>>USER</option>
								</select>
							</c:if>
							<c:if test="${session_user != 'bada' }">
								${member.m_status }
							</c:if>
						</td>
						<td>${member.m_privacy }</td>
						<td>${member.m_promotion }</td>
						<td>
							<button type="button" class="memberInfoBtn" >회원정보</button>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script>
	$(".statusSelect").change(function(e){
		console.log("이벤트 발생");
		// 세션값에 대해서 더 잘 다루기 => 주기적으로 세션값을 새로 측정해서 일정시간 간격으로 지속적으로 inpput태그에 값을 넣는 것도 하나의 방법일까?
		var user = $(".adminPageHiddenInput").data('user');
		console.log("현재 user의 값: " + user);
		if(user !== "bada"){
			return false;
		}
		var sendStatus = $(".statusSelect option:selected").val();
		var sendEmail = $(e.target).closest('tr').data('email');
		var data = {
				m_email : sendEmail,
				m_status : sendStatus
		};
		// restApi 방식으로 해본다
		$.ajax({
			url: "memberStatusUpdate.do",
			method : "PUT",
			contentType: "application/json; charset=utf-8",
			dataType: "text",
			data: JSON.stringify(data),
			success: function(message){
				console.log("호출 성공");
				console.log(message);
			},
			error: function(){
				console.log("호출 실패");
			}
		})
		
	})
</script>
<script>
	/*	문서가 로드되면 실행시킬 이벤트들 */
	$(function(){
			
		
		
	})
</script>
</html>