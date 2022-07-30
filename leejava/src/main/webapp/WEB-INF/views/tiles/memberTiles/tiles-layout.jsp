<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}
.memberTilesWrapper {
	width: 100%;
	height: 100%;
	display: flex;
}
.memberTilesSideWrapper {
	width: 12%;

}
.memberTilesMainWrapper {
 	width: 100%;  
}
.memberTilesHeaderWrapper {
	width: 100%; 	
	height: 2%;  /* 편집을 용이하게 하기 위해서 임시로 2%로 둠. 나중에 다시 영역을 늘려서 배너 광고를 삽입한다. */
	background-color: whitesmoke;
}
.memberTilesBodyWrapper{
	min-height: 700px; 
}
.memberTilesFooterWrapper{
	background-color: whitesmoke;
	height: 70px;
}
</style>
</head>
<body>
	<div class="memberTilesWrapper">
		<div class="memberTilesSideWrapper">
			<tiles:insertAttribute name="left" />
		</div>
		<div class="memberTilesMainWrapper">
			<div class="memberTilesHeaderWrapper">
				<tiles:insertAttribute name="header" />
			</div>
			<div class="memberTilesBodyWrapper">
				<tiles:insertAttribute name="body" />
			</div>
			<div class="memberTilesFooterWrapper">
				<tiles:insertAttribute name="foot" />
			</div>
		</div>
	</div>
</body>
</html>