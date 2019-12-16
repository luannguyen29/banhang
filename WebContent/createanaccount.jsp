<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<div class="createanaccount">
			<h1>Tạo tài khoản</h1>
			<form action="HandlingAccount" method="post">

				<c:if test="${requestScope.fail!=null }">
					<br>
					<font color="red"> ${requestScope.fail} </font>
				</c:if>
				<input type="text" name="username" placeholder="Tên đăng nhập"
					class="form-control"><br> <input type="password"
					name="password" placeholder="Mật khẩu" class="form-control">
				<br> <input type="password" name="npassword"
					class="form-control" placeholder="Nhập lại mật khẩu">

				<h2 style="margin-top: 15px;">Thông tin cá nhân</h2>
				<input type="text" name="firstname" placeholder="Họ và tên lót"
					class="form-control"><br> <input type="text"
					name="lastname" placeholder="Tên" class="form-control"><br>
				<h2>Giới tính</h2>
				<div class="row">
					<label>Nam </label><input type="radio" name="sex" value="male">
					<label style="margin-left: 15px;">Nữ </label><input type="radio"
						name="sex" value="female">
				</div>
				<h2>Ngày sinh của bạn</h2>


				<select id="day" name="day" onchange="definedays()">

					<c:forEach begin="1" end="31" var="i">
						<option value="${i}">${i}</option>
					</c:forEach>

				</select> <select id="month" name="month" onchange="definedays()">
					<c:forEach begin="1" end="12" var="j">
						<option value="${j}">${j}</option>
					</c:forEach>

				</select> <select id="year" name="year" onchange="definedays()">
					<c:forEach begin="1990" end="2018" var="k">
						<option value="${k}">${k}</option>
					</c:forEach>

			</select>

				<h2>Địa chỉ</h2>

				<br> <input name="prov" class="form-control"
					placeholder="Nhập nơi ở của bạn"> <input
					class="btn btn-lg btn-primary btn-block" type="submit"
					value="Tạo tài khoản">
			</form>
		</div>
	</div>
	<!-- #intro -->

	<!--==========================
    Footer
  ============================-->
	<%@include file="footer.jsp"%>
	<script src="js/datepicker.js"></script>
</body>
</html>
