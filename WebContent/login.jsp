<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Login</title>
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
			<h2>Đăng nhập</h2>
			<form action="HandlingLogin" method="post">


				<p>${requestScope.cantfind }</p>
				<p>${requestScope.usererror }</p>

				<input type="text" name="name" class="form-control" placeholder="Tên đăng nhập">

				<p>${requestScope.passerror }</p>



				<input type="password" class="form-control" name="password"
					placeholder="Mật khẩu"> <label><a style="margin-top: 20px;"
					href="createanaccount.jsp">Tạo tài khoản</a></label> <br> <label><a
					href="forget.jsp">Quên mật khẩu?</a></label>
				<div class="clear"></div>
				<button class="btn btn-lg btn-primary btn-block" type="submit" >Đăng nhập</button>
			</form>
		</div>
		<div class="clear"></div>
	</div>
	<!-- #intro -->

	<!--==========================
    Footer
  ============================-->
	<footer id="footer">
		<div class="container">
			<div class="copyright">
				2018| <strong>Group 9</strong> learning web development
			</div>
			<div class="credits"></div>
		</div>
	</footer>
	<!-- #footer -->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<!-- JavaScript Libraries -->


	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/superfish/hoverIntent.js"></script>
	<script src="lib/superfish/superfish.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="lib/sticky/sticky.js"></script>

	<!-- Template Main Javascript File -->
	<script src="js/main.js"></script>
</body>
</html>