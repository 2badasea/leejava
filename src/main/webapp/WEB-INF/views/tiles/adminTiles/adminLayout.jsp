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
.adminLayout_wrapper {
	width: 100%;
	height: 100%;
	display: flex;
}
.sideWrapper{
	width: 11%;
	position: fixed;
}
.mainWrapper {
	width: 89%;
	margin-left: 11%;
	
}
.headerWrapper {
	position: fixed;	
	width: 100%;
	height: 5%;
	background-color: whitesmoke;
	top: 0;
}
.bodyWrapper{
	width: 100%;
	overflow-y: scroll;
}
.footerWrapper{
	position: fixed;
	background-color: whitesmoke;
	width: 100%;
	height: 8%;
	bottom: 0;
}
</style>
</head>
<body>
	<div class="adminLayout_wrapper">
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