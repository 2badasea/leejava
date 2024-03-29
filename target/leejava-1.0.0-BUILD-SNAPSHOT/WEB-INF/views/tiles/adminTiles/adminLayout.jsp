<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="atitle" /></title>
<!-- Custom styles for this template-->
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}	
.wrapper {
	width: 100%;
	height: 100%;
	display: flex;
}
.sideWrapper {
	width: 12%;
}
.mainWrapper {
	width: 85%;
}
.headerWrapper {
	height: 5%;
	background-color: #FFF0F0	;
}
.bodyWrapper{
	min-height: 700px; 
}
.footerWrapper{
	background-color: #FFF0F0;
	height: 70px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="sideWrapper">
			<tiles:insertAttribute name="asidebar" />
		</div>
		<div class="mainWrapper">
			<div class="headerWrapper">
				<tiles:insertAttribute name="aheader" />
			</div>
			<div class="bodyWrapper">
				<tiles:insertAttribute name="abody" />
			</div>
			<div class="footerWrapper">
				<tiles:insertAttribute name="afooter" />
			</div>
		</div>
	</div>

</body>
</html>