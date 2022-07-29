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
	width: 85%; 
}
.memberTilesHeaderWrapper {
	height: 5%;
	background-color: #FFF0F0	;
}
.memberTilesBodyWrapper{
	min-height: 700px; 
}
.memberTilesFooterWrapper{
	background-color: #FFF0F0;
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