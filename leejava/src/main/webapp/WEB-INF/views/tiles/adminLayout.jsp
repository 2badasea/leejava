<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> <tiles:insertAttribute name="atitle" /> </title>
<link
	href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="resources/css/sb-admin-2.min.css"
	rel="stylesheet">
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