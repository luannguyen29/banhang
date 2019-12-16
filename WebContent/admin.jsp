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
		<c:when test="${requestScope.listBasedOnGenre!=null}">
			<c:set var="listProduct" value="${requestScope.listBasedOnGenre}" />
		</c:when>
		<c:otherwise>
			<c:set var="listProduct" value="${DAOProduct().getlist()}" />
		</c:otherwise>
	</c:choose>

	<c:set var="listGenres" value="${DAOGenres().getlist()}" />
	<c:set var="listSeries" value="${DAOSeries().getlist()}" />
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
				<div class="modal-body">

					${requestScope.error }
				</div>
				<div class="modal-footer">
					
					<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>
	<form action="ProductController?actionManage=addProduct" method="post">
		<div class="modal fade" id="addModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title">Thêm sản phẩm</h3>
						<button type="button" class="close" data-dismiss="modal">&times;</button>

					</div>
					<div class="modal-body">

						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Tên:</label>
							<div class="col-sm-9">
								<input class="form-control" name="nameOfProduct">
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Tên Series: </label>
							<div class="col-sm-9">
								<select name="seriesOfProduct" class="form-control">

									<c:forEach items="${listSeries }" var="ls">

										<option>${ls.getNameSeries()}</option>

									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Giá:</label>
							<div class="col-sm-9">
								<input class="form-control" name="priceOfProduct">
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Giá khuyến mãi:</label>
							<div class="col-sm-9">
								<input class="form-control" name="priceSaleOfProduct">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Link Hình ảnh:</label>
							<div class="col-sm-9">
								<input class="form-control" name="linkImageOfProduct">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label">Sản phẩm mới:</label>
							<div class="col-sm-9">
								<div class="form-check">
									<input class="form-check-input position-static" type="checkbox"
										name="productIsNew" value="option1">
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">Thêm sản
							phẩm</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="modal fade" id="imageModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">Add Image Product</h3>
				</div>
				<div class="modal-body">
					<div class="form-group row">
						<div class="col-sm-3">
							<img src="${sessionScope.currentLinkImageProduct}"
								id="imgOfProduct" alt="" class="img-fluid image1" height="120"
								width="200">
						</div>

						<div class="col-sm-9">
							<form action="ProductController?actionManage=addImageProduct"
								enctype="multipart/form-data" method="post">
								<p>Add Image Here</p>
								<input id="imgInp" type="file" name="file" />
								<button type="submit" class="btn btn-primary">Add Image</button>
							</form>
						</div>

					</div>

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
												<button data-toggle="modal" data-target="#addModal"
													class="btn btn-info ">Thêm sản phẩm</button>
											</div>
											<div class="row">
												<div class="col-lg-4">
													<div class="form-group">
														<form action="ProductController?action=searchWithGivenID"
															method="post">
															<div class="input-bar-item">
																<div class="input-group">
																	<input name="idSearch" class="form-control"
																		placeholder="Tìm theo ID sản phẩm ..."> <span
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
															action="ProductController?action=searchWithGivenText"
															method="post">
															<div class="input-bar-item">

																<div class="input-group">
																	<input name="search-product" class="form-control"
																		placeholder="Tìm theo tên sản phẩm..."> <span
																		class="input-group-btn"><button type="submit"
																			class="btn btn-info">Tìm tên</button></span>
																</div>

															</div>
														</form>
													</div>
												</div>

												<div class="col-lg-4">
													<form action="ProductController?action=showListgenre"
														method="post">
														<div class="input-group">

															<select name="idGenre" class="form-control">
																<option>Tìm kiếm theo thể loại</option>


																<c:forEach items="${ listGenres}" var="g">
																	<option value="${ g.getId()}">${ g.getName()}</option>
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

											<li><span class="bread-blod">Quản lí mặt hàng</span></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Static Table Start -->
		<div class="static-table-area" style="margin-bottom: 20px;">
			<div class="container">
				<div class="row">

					<div class="container">


						<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th>ID</th>
									<th>Tên sản phẩm</th>
									<th>Giá SP</th>
									<th>Giá giảm</th>
									<th>Hình ảnh</th>
									<th>Series</th>
									<th>Sản phẩm mới</th>
									<th>Action</th>
								</tr>
							</thead>

							<tbody>


								<c:forEach items="${listProduct}" var="p">

									<tr>
										<td>${p.getIdProduct()}</td>
										<td>${p.getName()}</td>
										<td>${p.getPrice()}</td>
										<td>${p.getPriceSale()}</td>
										<td>${p.getLinkOfImage()}</td>
										<td>${DAOSeries().findWithID(p.getIdSeries()).getNameSeries()}</td>
										<td>${p.isNew()}</td>
										<td><a data-toggle="modal"
											data-target="#myModal${p.getIdProduct()}"><button
													style="margin: auto;" type="button" class="btn btn-info">
													<i class="fa fa-pencil"></i><span>Sửa</span>
												</button></a><br> <a
											href="ProductController?actionManage=deleteProduct&idOfDeleteProduct=${p.getIdProduct()}"><button
													style="margin: auto;" type="button" class="btn btn-danger">
													<i class="fa fa-trash-o"></i><span>Xóa</span>
												</button></a></td>

									</tr>
									<div class="modal fade" id="myModal${p.getIdProduct()}"
										role="dialog">
										<form
											action="ProductController?actionManage=alterProduct&idOfProduct=${p.getIdProduct()}"
											method="post">
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
													<div class="modal-header">
														<h3 class="modal-title">Alter Product</h3>
														<button type="button" class="close" data-dismiss="modal">&times;</button>

													</div>
													<div class="modal-body">
														<div class="form-group row">
															<label class="col-sm-3 col-form-label">ID:</label>
															<div class="col-sm-9">
																<input class="form-control" value="${p.getIdProduct()}"
																	disabled="disabled">
															</div>
														</div>

														<div class="form-group row">
															<label class="col-sm-3 col-form-label">Name:</label>
															<div class="col-sm-9">
																<input class="form-control" name="nameOfProduct"
																	value="${p.getNameProduct()}">
															</div>
														</div>
														<div class="form-group row">
															<label class="col-sm-3 col-form-label">Name
																Series: </label>
															<div class="col-sm-9">
																<select name="seriesOfProduct" class="form-control">
																	<c:forEach items="${listSeries }" var="li">


																		<c:choose>
																			<c:when
																				test="${li.getiDSeries() == p.getIdSeries() }">
																				<option selected>${li.getNameSeries()}</option>
																			</c:when>

																			<c:otherwise>
																				<option>${li.getNameSeries()}</option>
																			</c:otherwise>

																		</c:choose>
																	</c:forEach>
																</select>
															</div>
														</div>

														<div class="form-group row">
															<label class="col-sm-3 col-form-label">Price:</label>
															<div class="col-sm-9">
																<input class="form-control" name="priceOfProduct"
																	value="${p.getPrice()}">
															</div>
														</div>

														<div class="form-group row">
															<label class="col-sm-3 col-form-label">Price
																After Sale:</label>
															<div class="col-sm-9">
																<input class="form-control" name="priceSaleOfProduct"
																	value="${p.getPriceSale()}">
															</div>
														</div>
														<div class="form-group row">
															<label class="col-sm-3 col-form-label">Link
																Image:</label>
															<div class="col-sm-9">
																<input class="form-control" name="linkImageOfProduct"
																	value="${p.getLinkOfImage()}">
															</div>
														</div>
														<div class="form-group row">
															<label for="staticEmail" class="col-sm-3 col-form-label">New:</label>
															<div class="col-sm-9">
																<div class="form-check">
																	<input class="form-check-input position-static"
																		type="checkbox" name="productIsNew" value="option1"
																		<c:if test="${p.isNew()}">
																		checked="checked" 
										</c:if>>

																</div>
															</div>
														</div>
														<div class="form-group row">
															<div class="col-sm-3">
																<img src="${p.getLinkOfImage()}" id="imgOfProduct"
																	alt="" class="img-fluid image1" height="100"
																	width="200">
															</div>
															<div class="col-sm-9">
																<p>The showed image in the left is product's image</p>
																<p>If you click alter product,you'll able to alter
																	image</p>
															</div>

														</div>
													</div>
													<div class="modal-footer">
														<button type="submit" class="btn btn-primary">Chỉnh
															sửa sản phẩm</button>
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



	<c:if test="${sessionScope.currentLinkImageProduct!=null }">
		<script type="text/javascript">
			$(window).on('load', function() {
				$('#imageModal').modal('show');
			});
		</script>
	</c:if>
	
	<c:if test="${requestScope.error!=null }">
		<script type="text/javascript">
			$(window).on('load', function() {
				$('#errorModal').modal('show');
			});
		</script>
	</c:if>

	<script>
		function readURL(input) {

			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#imgOfProduct').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#imgInp").change(function() {
			readURL(this);
		});
	</script>


</body>

</html>