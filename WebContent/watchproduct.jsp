<%@page import="model.DAOUser"%>
<%@page import="model.Comment"%>
<%@page import="model.DAOGenres"%>
<%@page import="model.Series"%>
<%@page import="model.Genres"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.DAOSeries"%>
<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<style type="text/css">
</style>
<meta charset="utf-8">
<title>Group 9</title>
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

<!-- =======================================================
    Theme Name: Reveal
    Theme URL: https://bootstrapmade.com/reveal-bootstrap-corporate-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body id="body">
	<%@include file="header2.jsp"%>



	<!-- #header -->

	<!--==========================
    Intro Section
  ============================-->





	<c:set var="p" value="${requestScope.notifyAfterClickProduct}" />
	<c:set var="s" value="${DAOSeries().findWithID(p.getIdSeries())}" />
	<c:set var="listComment"
		value="${DAOProduct().getCommentProduct(p.getIdProduct())}" />
	<c:set var="titleCommentOfU" value="" />
	<c:set var="textCommentOfU" value="" />

	<div class="container">
		<div class="spacebetweenbodyandnav">

			<nav aria-label="breadcrumb">

				<a href="ProductController?action=showListgenre&idGenre=0">< Trở
					về trang mua hàng</a>
			</nav>

			<div style="margin-top: 50px;" class="row" id="watch">

				<div class="col-md-2">
					<img src="${p.getLinkOfImage()}" alt="" class="img-fluid image1">

				</div>



				<div class="col-md-7">

					<div class="row">
						<div class="col-md-9">
							<h2 style="font-size: 25px">${p.getNameProduct()}</h2>

						</div>
						<div class="col-md-3">

							<c:if test="${ p.isNew()==true}"></c:if>
							<p style="color: red" class="pull-right">(Sản phẩm mới)</p>


						</div>
					</div>
					<hr>


					<div class="row">
						<div class="col-md-4">
							<p style="color: red">Có ${ DAOProduct().countLove(p.getIdProduct())}
								lượt thích sản phẩm này</p>
						</div>
						<div class="col-md-4">
							<c:choose>
								<c:when test="${sessionScope.iduser != null}">
									<c:choose>
										<c:when
											test="${DAOProduct().isLoveProduct(p.getIdProduct(), sessionScope.iduser)}">

											<a
												href="ProductController?action=likeProduct&status=like&idProduct=${p.getIdProduct()}"
												style="color: red" class="pull-right"><i
												class="fa fa-heart"></i> Bạn đã thích sản phẩm</a>
										</c:when>

										<c:otherwise>
											<a
												href="ProductController?action=likeProduct&status=notlike&idProduct=${p.getIdProduct()}"
												style="color: black" class="pull-right"><i
												class="fa fa-heart-o"></i> Thích sản phẩm</a>
										</c:otherwise>
									</c:choose>

								</c:when>
								<c:otherwise>
									<a href="#myModal" data-target="#myModal" data-toggle="modal"
										style="color: black" class="pull-right"><i
										class="fa fa-heart-o"></i> Thích sản phẩm</a>
								</c:otherwise>

							</c:choose>
						</div>
						<div class="col-md-4">
							<a href="#myModal" data-target="#myModal" data-toggle="modal"
								style="color: black" class="pull-right"><i
								class="fa fa-edit"></i> Viết nhận xét của bạn</a>
						</div>
					</div>

					<h6>
						Tác giả :
						<button
							onclick="location.href='ProductController?action=searchAuthor&nameAuthor=${s.getAuthor()}'"
							style="font-size: 18px;" type="button" class="btn btn-link">${s.getAuthor()}</button>
					</h6>
					<h6>

						Thuộc Series : <a
							href="ProductController?action=searchWithGivenText&search-product=
						${s.getNameSeries()}"><button
								type="submit" type="button" class="btn btn-outline-primary">${s.getNameSeries()}</button></a>
					</h6>

					<h6>
						Thể loại :

						<c:forEach items="${s.getGenres()}" var="i">

							<a href="ProductController?action=showListgenre&idGenre=${i }"><button
									type="submit" type="button" class="btn btn-outline-primary">${DAOGenres().findWithID(i).getName()}</button></a>
						</c:forEach>



					</h6>

					<p>Tóm tắt:
						${DAOSeries().findWithID(p.getIdSeries()).getSummary()}</p>
				</div>
				<div class="col-md-3">
					<div class="sidebar">
						<div class="each-row">
							<div>
								<h3>
									<strong>Thanh toán</strong>
								</h3>
								<hr>
							</div>

							<div class="amount">

								<c:choose>

									<c:when test="${p.getPrice() == p.getPriceSale()}">
										<p>Giá sản phẩm: ${p.getPrice()} đ</p>

									</c:when>

									<c:otherwise>
										<p>
											Giá ban đầu:
											<del> ${p.getPrice()} đ </del>
										</p>
										<p>Giá khuyến mại: ${p.getPriceSale()} đ</p>
									</c:otherwise>

								</c:choose>
								<p class="text-right">
									<small>(Bao gồm VAT)</small>
								</p>
							</div>

							<button name="buyButton" id="buyButton"
								class="btn btn-large btn-block btn-danger btn-checkout"
								value="${p.getIdProduct()}" formmethod="post">Thêm vào
								giỏ</button>

						</div>
					</div>
				</div>

			</div>
			<div class="spacebetweenbodyandnav">
				<section>

					<div class="container">
						<h2 style="color: red">Nhận xét của khách hàng</h2>
						<c:choose>
							<c:when test="${listComment.size()!=0 }">


								<c:forEach items="${listComment}" var="m">
									<c:if test="${m.getIdUser() == sessionScope.iduser }">
										<c:set var="titleCommentOfU" value="${m.getTitle() }"></c:set>
										<c:set var="textCommentOfU" value="${m.getComment() }"></c:set>

									</c:if>

									<div style="display: none" class="comment">
										<p style="font-family: Arial;">
											<strong>${m.getTitle()}</strong>
										</p>
										<p style="font-style: italic; font-family: Arial;">
											Nhận xét bởi <strong>
												${DAOUser().nameUser(m.getIdUser())}</strong> ,nhận xét vào ngày
											${m.getDate().toString()}
										</p>
										<p>${m.getComment()}
										<hr>
									</div>


								</c:forEach>

								<button id="loadMore" type="button" class="btn btn-primary"
									style="text-align: center;">
									<p style="color: white;">Tải thêm Comment</p>
								</button>
							</c:when>
							<c:otherwise>
								<p>(Sản phẩm chưa có nhận xét )</p>
							</c:otherwise>
						</c:choose>
					</div>
				</section>
			</div>
		</div>


	</div>
	<div class="modal fade" id="myModal">
		<form
			action="ProductController?action=writeComment&idProduct=${p.getIdProduct()}"
			method="post">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Đánh giá sản phẩm</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<div class="modal-body">
						<c:choose>
							<c:when test="${sessionScope.loginsuccess==null }">

								<p>Chức năng này yêu cầu đăng nhập, mời bạn đăng nhập để
									đánh giá, bình luận sản phẩm</p>

							</c:when>

							<c:otherwise>
								<p>Tên tựa đề (không quá 200 chữ)</p>
								<input class="form-control" name="titleReview"
									value="${titleCommentOfU}">
								<br>
								<p>Nội dung (không quá 500 chữ)</p>
								<textarea class="form-control" rows="5" name="textReview">${textCommentOfU}</textarea>
							</c:otherwise>
						</c:choose>

					</div>
					<div class="modal-footer">

						<c:choose>
							<c:when test="${sessionScope.loginsuccess == null}">
								<a href="login.jsp"><button type="button"
										class="btn btn-primary">Đăng nhập</button></a>
							</c:when>
							<c:otherwise>

								<button type="submit" class="btn btn-primary">Submit</button>
							</c:otherwise>
						</c:choose>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</form>
	</div>


	<!-- #intro -->

	<!--==========================
    Footer
  ============================-->
	<%@include file="footer.jsp"%>

	<script type="text/javascript">
		$(function() {
			x = 0;
			$(".comment").slice(0, 3).show();
			$("#loadMore").on('click', function(e) {
				e.preventDefault();
				$(".comment:hidden").slice(0, 3).slideDown();
				if ($(".comment:hidden").length == 0) {
					$("#loadMore").hide();
				}
			});
		});

		$("#buyButton").on('click', function() {
			$.ajax({
				type : 'GET',
				url : 'ProductController',
				data : {
					"buyButton" : $("#buyButton").val()
				},
				success : function(response) {
					trigger();
					$('.cart-count').text(response);
				}
			});
		});
	</script>
</body>
</html>
