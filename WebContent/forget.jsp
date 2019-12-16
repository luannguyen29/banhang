<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Forget Password</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800|Montserrat:300,400,700"
	rel="stylesheet">

<!-- Bootstrap CSS File -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Libraries CSS Files -->
<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/magnific-popup/magnific-popup.css" rel="stylesheet">
<link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">

<!-- Main Stylesheet File -->
<link href="css/style.css" rel="stylesheet">


<!-- Main Stylesheet File -->
<link href="css/style.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">

<!-- =======================================================
    Theme Name: Reveal
    Theme URL: https://bootstrapmade.com/reveal-bootstrap-corporate-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body id="body">



	<!--==========================
    Header
  ============================-->
	<%@include file="header2.jsp"%>

	<!-- #header -->

	<!--==========================
    Intro Section
  ============================-->
	<div class="w3layouts">
		<div class="signin-agile">
			<h2>Please type your username</h2>
			<form action="HandlingForgetPassword" method="post">
				<input type="text" name="name" class="name" placeholder="Username">

				<c:if test="${requestScope.errorforgetpass }">
					<p>${requestScope.errorforgetpass }</p>
				</c:if>

				<div class="clear"></div>
				<input type="submit" value="Submit">
			</form>
		</div>
		<div class="clear"></div>
	</div>
	<!-- #intro -->

	<!--==========================
    Footer
  ============================-->


	<%@include file="footer.jsp"%>
</body>
</html>
