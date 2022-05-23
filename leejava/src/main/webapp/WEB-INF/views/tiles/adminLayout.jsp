<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> <tiles:insertAttribute name="atitle" /> </title>
<!-- Custom styles for this template-->
<style type="text/css">
	.side {
		float: left;
	}
	.main {
		
	}
	
</style>
</head>
<body>

<div class="wrapper">
		<div class="side">
			<tiles:insertAttribute name="asidebar"/>
		</div>
		<div>
			<tiles:insertAttribute name="aheader" />
			<tiles:insertAttribute name="abody" />
			<tiles:insertAttribute name="afooter" />
		</div>
</div>

</body>
</html>