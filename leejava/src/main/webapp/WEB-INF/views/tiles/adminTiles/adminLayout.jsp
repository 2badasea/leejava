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
}
.mainWrapper {
	width: 89%;
}
.headerWrapper {
	width: 100%;
	height: 3%;
	background-color: whitesmoke;
}
.bodyWrapper{
	width: 100%;
	height: 89%;
}
.footerWrapper{
	background-color: whitesmoke;
	width: 100%;
	height: 8%;
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