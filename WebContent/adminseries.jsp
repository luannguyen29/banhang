<%@page import="model.Genres"%>
<%@page import="model.DAOGenres"%>
<%@page import="model.DAOSeries"%>
<%@page import="model.Series"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Quản lí</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Google Fonts
		============================================ -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900"
	rel="stylesheet">
<!-- Bootstrap CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/bootstrap.min.css">
<!-- Bootstrap CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/font-awesome.min.css">
<!-- owl.carousel CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/owl.carousel.css">
<link rel="stylesheet" href="adminpage/css/owl.theme.css">
<link rel="stylesheet" href="adminpage/css/owl.transitions.css">
<!-- animate CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/animate.css">
<!-- normalize CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/normalize.css">
<!-- meanmenu icon CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/meanmenu.min.css">
<!-- main CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/main.css">
<!-- educate icon CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/educate-custon-icon.css">
<!-- morrisjs CSS
		============================================ -->
<link rel="stylesheet"
	href="adminpage/css/morrisadminpage/js/morris.css">
<!-- mCustomScrollbar CSS
		============================================ -->
<link rel="stylesheet"
	href="adminpage/css/scrollbar/jquery.mCustomScrollbar.min.css">
<!-- metisMenu CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/metisMenu/metisMenu.min.css">
<link rel="stylesheet"
	href="adminpage/css/metisMenu/metisMenu-vertical.css">
<!-- calendar CSS
		============================================ -->
<link rel="stylesheet"
	href="adminpage/css/calendar/fullcalendar.min.css">
<link rel="stylesheet"
	href="adminpage/css/calendar/fullcalendar.print.min.css">
<!-- style CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/style.css">
<!-- responsive CSS
		============================================ -->
<link rel="stylesheet" href="adminpage/css/responsive.css">
<!-- modernizr JS
		============================================ -->
<script src="adminpage/js/vendor/modernizr-2.8.3.min.js"></script>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>

<body>
	<c:choose>
		<c:when test="${requestScope.seriesList!=null}">
			<c:set var="listSeries" value="${requestScope.seriesList}" />
		</c:when>
		<c:otherwise>
			<c:set var="listSeries" value="${DAOSeries().getlist()}" />
		</c:otherwise>
	</c:choose>

	<c:set var="listGenres" value="${DAOGenres().getlist()}" />


	<!-- Start Left menu area -->
	<div class="left-sidebar-pro">
		<nav id="sidebar" class="">
			<div class="sidebar-header">
				<a href="index.html"><img class="main-logo"
					src="img/logo/logo.png" alt="" /></a> <strong><a
					href="index.html"><img src="img/logo/logosn.png" alt="" /></a></strong>
			</div>
			<div class="left-custom-menu-adp-wrap comment-scrollbar">
				<nav class="sidebar-nav left-sidebar-menu-pro">
					<ul class="metismenu" id="menu1">
						<li><a class="has-arrow" href="#"> <span
								class="educate-icon educate-home icon-wrap"></span> <span
								class="mini-click-non">Quản lí</span>
						</a>
							<ul class="submenu-angle" aria-expanded="true">
								<li><a title="Quản lí mặt hàng" href="admin.jsp"><span
										class="mini-sub-pro">Quản lí mặt hàng</span></a></li>
								<li><a title="Quản lí Series" href="adminseries.jsp"><span
										class="mini-sub-pro">Quản lí Series</span></a></li>

							</ul></li>
						<li><a title="Quản lí đơn hàng" href="adminpayment.jsp"
							aria-expanded="false"><span
								class="educate-icon educate-event icon-wrap sub-icon-mg"
								aria-hidden="true"></span> <span class="mini-click-non">Quản
									lí đơn hàng</span></a></li>
						<li><a title="Quản lí khách hàng" href="adminuser.jsp"
							aria-expanded="false"><span
								class="educate-icon educate-professor icon-wrap"></span> <span
								class="mini-click-non">Quản lí khách hàng</span></a></li>

					</ul>
				</nav>
			</div>
		</nav>
	</div>
	<!-- End Left menu area -->
	<!-- Start Welcome area -->
	<div class="modal fade" id="errorModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">Lỗi</h3>
					<button type="button" class="close" data-dismiss="modal">&times;</button>

				</div>
				<div class="modal-body">${requestScope.error }</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>
	<div class="all-content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="logo-pro">
						<a href="index.html"><img class="main-logo"
							src="img/logo/logo.png" alt="" /></a>
					</div>
				</div>
			</div>
		</div>
		<div class="header-advance-area">
			<div class="header-top-area">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="header-top-wraper">
								<div class="row">
									<div class="col-lg-1 col-md-0 col-sm-1 col-xs-12">
										<div class="menu-switcher-pro">
											<button type="button" id="sidebarCollapse"
												class="btn bar-button-pro header-drl-controller-btn btn-info navbar-btn">
												<i class="educate-icon educate-nav"></i>
											</button>
										</div>
									</div>
									<div class="col-lg-6 col-md-7 col-sm-6 col-xs-12">
										<div class="header-top-menu tabl-d-n">
											<ul class="nav navbar-nav mai-top-nav">
												<li class="nav-item"><a href="#" class="nav-link">Home</a>
												</li>

											</ul>
										</div>
									</div>
									<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
										<div class="header-right-info">
											<ul class="nav navbar-nav mai-top-nav header-right-menu">


												<li class="nav-item"><a href="#" data-toggle="dropdown"
													role="button" aria-expanded="false"
													class="nav-link dropdown-toggle"> <img
														src="img/product/pro4.jpg" alt="" /> <span
														class="admin-name">Admin</span> <i
														class="fa fa-angle-down edu-icon edu-down-arrow"></i>

												</a>
													<ul role="menu"
														class="dropdown-header-top author-log dropdown-menu animated zoomIn">
														<li><a href="user.jsp"><span
																class="edu-icon edu-locked author-log-ic"></span>Log Out</a>
														</li>
													</ul>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="breadcome-area" style="padding-top: 40px;">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="breadcome-list single-page-breadcome">
								<div class="row">

									<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
										<div class="breadcome-heading">
											<div class="row  text-center" style="margin-bottom: 20px;">
												<button data-toggle="modal" data-target="#addSeriesModal"
													class="btn btn-info ">Thêm Series</button>
											</div>
											<div class="row">
												<div class="col-lg-4">
													<div class="form-group">
														<form
															action="ProductController?actionManage=searchIDSeries"
															method="post">
															<div class="input-bar-item">
																<div class="input-group">
																	<input name="idSearch" class="form-control"
																		placeholder="Tìm theo ID Series..."> <span
																		class="input-group-btn">
																		<button type="submit" class="btn btn-info">Tìm
																			ID</button>
																	</span>
																</div>
															</div>

														</form>
													</div>
												</div>

												<div class="col-lg-4">
													<div class="form-group">
														<form
															action="ProductController?actionManage=searchNameSeries"
															method="post">
															<div class="input-bar-item">

																<div class="input-group">
																	<input name="searchNameSeriestext" class="form-control"
																		placeholder="Tìm theo tên Series..."> <span
																		class="input-group-btn"><button type="submit"
																			class="btn btn-info">Tìm tên</button></span>
																</div>

															</div>
														</form>
													</div>
												</div>

												<div class="col-lg-4">
													<form
														action="ProductController?actionManage=searchGenreSeries"
														method="post">
														<div class="input-group">

															<select name="searchGenreSeriestext" class="form-control">
																<option>Tìm kiếm theo thể loại</option>

																<c:forEach items="${listGenres}" var="g">

																	<option value="${g.getId()}">${g.getName()}</option>

																</c:forEach>

															</select> <span class="input-group-btn">
																<button type="submit" class="btn btn-info">Tìm</button>
															</span>
														</div>

													</form>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
										<ul class="breadcome-menu">

											<li><span class="bread-blod">Quản lí Series</span></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="addSeriesModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<form action="ProductController?actionManage=addSeries"
						method="post">
						<div class="modal-header">
							<h3 class="modal-title">Add Series</h3>
							<button type="button" class="close" data-dismiss="modal">&times;</button>

						</div>
						<div class="modal-body">
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Name:</label>
								<div class="col-sm-9">
									<input class="form-control" name="nameOfSeries">
								</div>
							</div>


							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Author:</label>
								<div class="col-sm-9">
									<input class="form-control" name="authorOfSeries">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Genre(s):</label>
								<div class="col-sm-9">
									<c:forEach items="${listGenres }" var="lig">
										<label class="checkbox-inline"><input
											name="listCheckBox" type="checkbox" value="${lig.getId() }">${lig.getName() }</label>
									</c:forEach>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Summary:</label>
								<div class="col-sm-9">
									<textarea class="form-control" rows="5" name="summaryOfSeries"></textarea>
								</div>
							</div>
						</div>


						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">Add Series</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Static Table Start -->
		<div class="static-table-area" style="margin-bottom: 20px;">
			<div class="container">
				<div class="row">

					<table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Author</th>
								<th>Genre(s)</th>
								<th>Summary</th>
								<th>Action</th>
							</tr>
						</thead>

						<tbody>


							<c:forEach items="${listSeries }" var="s">
								<tr>
									<td>${s.getiDSeries()}</td>
									<td>${s.getNameSeries()}</td>
									<td>${s.getAuthor()}</td>
									<td>${ DAOSeries().generateGenresIntoString(s.getiDSeries())}</td>
									<td style="width: 600px">${s.getSummary()}</td>
									<td>

										<button style="margin: auto;" type="button"
											class="btn btn-info" data-toggle="modal"
											data-target="#alterSeriesModal${s.getiDSeries()}">
											<i class="fa fa-pencil"></i><span>Sửa</span>
										</button> <br> <a
										href="ProductController?actionManage=deleteSeries&idOfDeleteSeries=${s.getiDSeries()}"><button
												style="margin: auto;" type="button" class="btn btn-danger">
												<i class="fa fa-trash-o"></i><span>Xóa</span>
											</button></a>

									</td>
								</tr>


								<div class="modal fade" id="alterSeriesModal${s.getiDSeries()}"
									role="dialog">
									<form
										action="ProductController?actionManage=alterSeries&idOfSeries=${s.getiDSeries()}"
										method="post">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">

												<div class="modal-header">
													<h3 class="modal-title">Alter Series</h3>
													<button type="button" class="close" data-dismiss="modal">&times;</button>

												</div>
												<div class="modal-body">

													<div class="form-group row">
														<label class="col-sm-3 col-form-label">ID:</label>
														<div class="col-sm-9">
															<input class="form-control" value="${s.getiDSeries()}"
																disabled="disabled">
														</div>
													</div>

													<div class="form-group row">
														<label class="col-sm-3 col-form-label">Name:</label>
														<div class="col-sm-9">
															<input class="form-control" name="nameOfSeries"
																value="${s.getNameSeries()}">
														</div>
													</div>


													<div class="form-group row">
														<label class="col-sm-3 col-form-label">Author:</label>
														<div class="col-sm-9">
															<input class="form-control" name="authorOfSeries"
																value="${s.getAuthor()}">
														</div>
													</div>

													<div class="form-group row">
														<label class="col-sm-3 col-form-label">Genre(s):</label>
														<div class="col-sm-9">


															<c:forEach items="${listGenres}" var="li">
																<label class="checkbox-inline"><input
																	type="checkbox" name="listCheckBox"
																	value="${li.getId()}"
																	<c:if test="${s.getGenres().contains(li.getId())}"></c:if>
																	checked="checked"> ${li.getName()}</label>
															</c:forEach>

														</div>
													</div>

													<div class="form-group row">
														<label class="col-sm-3 col-form-label">Summary:</label>
														<div class="col-sm-9">
															<textarea class="form-control" rows="5"
																name="summaryOfSeries">${s.getSummary()}</textarea>
														</div>
													</div>
												</div>


												<div class="modal-footer">
													<button type="submit" class="btn btn-primary">Alter
														Series</button>
													<button type="button" class="btn btn-default"
														data-dismiss="modal">Close</button>
												</div>

											</div>
										</div>
									</form>
								</div>


							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>



	<!-- Static Table End -->
	<div class="footer-copyright-area">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="footer-copy-right">
						<p>
							Copyright 2018. All rights reserved. Template by <a
								href="https://colorlib.com/wp/templates/">Colorlib</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jquery
		============================================ -->
	<script src="adminpage/js/vendor/jquery-1.12.4.min.js"></script>
	<!-- bootstrap JS
		============================================ -->
	<script src="adminpage/js/bootstrap.min.js"></script>
	<!-- wow JS
		============================================ -->
	<script src="adminpage/js/wow.min.js"></script>
	<!-- price-slider JS
		============================================ -->
	<script src="adminpage/js/jquery-price-slider.js"></script>
	<!-- meanmenu JS
		============================================ -->
	<script src="adminpage/js/jquery.meanmenu.js"></script>
	<!-- owl.carousel JS
		============================================ -->
	<script src="adminpage/js/owl.carousel.min.js"></script>
	<!-- sticky JS
		============================================ -->
	<script src="adminpage/js/jquery.sticky.js"></script>
	<!-- scrollUp JS
		============================================ -->
	<script src="adminpage/js/jquery.scrollUp.min.js"></script>
	<!-- mCustomScrollbar JS
		============================================ -->
	<script
		src="adminpage/js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="adminpage/js/scrollbar/mCustomScrollbar-active.js"></script>
	<!-- metisMenu JS
		============================================ -->
	<script src="adminpage/js/metisMenu/metisMenu.min.js"></script>
	<script src="adminpage/js/metisMenu/metisMenu-active.js"></script>
	<!-- peity JS
		============================================ -->
	<script src="adminpage/js/peity/jquery.peity.min.js"></script>
	<script src="adminpage/js/peity/peity-active.js"></script>
	<!-- sparkline JS
		============================================ -->
	<script src="adminpage/js/sparkline/jquery.sparkline.min.js"></script>
	<script src="adminpage/js/sparkline/sparkline-active.js"></script>
	<!-- tab JS
		============================================ -->
	<script src="adminpage/js/tab.js"></script>
	<!-- plugins JS
		============================================ -->
	<script src="adminpage/js/plugins.js"></script>
	<!-- main JS
		============================================ -->
	<script src="adminpage/js/main.js"></script>

	<c:if test="${requestScope.error!=null }">
		<script type="text/javascript">
			$(window).on('load', function() {
				$('#errorModal').modal('show');
			});
		</script>
	</c:if>
</body>

</html>