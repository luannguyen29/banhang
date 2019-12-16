<%@page import="model.DAOGenres"%>
<%@page import="model.Genres"%>
<%@page import="model.Series"%>
<%@page import="model.DAOSeries"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Product</title>
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
	<c:set value="${requestScope.startOffset }" var="startOffset"></c:set>
	<c:set value="${requestScope.endOffset }" var="endOffset"></c:set>
	

	<div class="spacebetweenbodyandnav">

		<div id="content">



			<div class="container">
				<div class="row bar">
					<div class="col-md-3" style="border-right: 1px dashed #D3D3D3;">
						<!-- MENUS AND FILTERS-->
						<div class="panel panel-default sidebar-menu">

							<div class="panel-body">
								<ul class="nav nav-pills flex-column text-sm category-menu">

									<li class="nav-item"><a
										href="ProductController?action=showListLove"
										class="nav-link d-flex align-items-center justify-content-between">Các
											sản phẩm được yêu thích </a>

										<div class="panel-heading" style="margin-top: 10px;">
											<h3 class="h4 panel-title">Thể loại</h3>
										</div> <a href="ProductController?action=showListgenre&idGenre=0"
										class="nav-link d-flex align-items-center justify-content-between">Toàn
											bộ sản phẩm <span class="badge badge-secondary">${  DAOProduct().countGenre(0)}</span>
									</a>
										<ul class="nav nav-pills flex-column">


											<c:forEach items="${DAOGenres().getlist() }" var="g">
												<li class="nav-item"><a
													href="ProductController?action=showListgenre&idGenre=${ g.getId()}"
													class="nav-link">${ g.getName()} <span
														class="badge badge-secondary">${ DAOProduct().countGenre(g.getId())}</span>
												</a></li>


											</c:forEach>

										</ul></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-md-9">


						<div class="row" style="margin-left: 15px;">
							<h6 style="font-size: 20px;">
								Từ khóa bạn đang tìm kiếm: <strong style="font-weight: bold;">${requestScope.keywordsearch}
								</strong> (${requestScope.countresult} kết quả)
							</h6>
						</div>

						<div class="row" style="margin-left: 15px;">
							<div class="btn-group pull-left sort-box">
								<span>Ưu tiên xem: </span>
								<ul class="sort-list">
									<li class=""><a href="javascript:sortnew()">HÀNG MỚI</a></li>

									<li class=""><a href="javascript:sortsale()">GIẢM GIÁ
									</a></li>

									<li class=""><a href="javascript:sortlow()">GIÁ THẤP</a></li>
									<li class=""><a href="javascript:sorthigh()">GIÁ CAO</a></li>

								</ul>
							</div>
						</div>
						<hr>
						<div class="row " id="liproduct">
							<c:if test="${endOffset>0 }">
								<c:forEach items="${requestScope.listBasedOnGenre }"
									begin="${startOffset }" end="${endOffset }" var="p">


									<div class="col-lg-3 col-md-6">
										<a
											href="ProductController?action=showInfo&id=${p.getIdProduct()}"
											title="${p.getName()}">
											<div class="product">

												<div class="image">
													<img src="${p.getLinkOfImage()}" class="img-fluid image1">
												</div>
												<div class="text" style="color: black;">

													<h3 class="h5">${p.getName()}</h3>
													<p class="price">

														<c:choose>
															<c:when test="${p.getPrice() == p.getPriceSale()}">
															${p.getPrice()} đ
														</c:when>
															<c:otherwise>
															${p.getPriceSale()} đ
														<del> ${p.getPrice()} đ </del>
															</c:otherwise>
														</c:choose>



													</p>

													<p style="color: red; font-size: 12px;">Có
														${DAOProduct().countLove(p.getIdProduct())} lượt thích sản
														phẩm này</p>


												</div>


												<div class="ribbon-holder">

													<c:if test="${p.getPrice() == p.getPriceSale()}">
														<div class="ribbon sale">SALE</div>
													</c:if>


													<c:if test="${p.isNew()==true}">
														<div class="ribbon new">NEW</div>
													</c:if>

												</div>


											</div>
										</a>
									</div>

								</c:forEach>
							</c:if>

						</div>

						<div class="pages pull-right">
							<nav aria-label="Page navigation example"
								class="d-flex justify-content-center">
								<ul class="pagination">


									<c:forEach var="i" begin="1" end="${requestScope.totalPage}">

										<c:choose>
											<c:when test="${(startOffset / 8) == (i - 1) }">
												<li class="page-item active"><a href="#"
													class="page-link">${i}</a></li>
											</c:when>
											<c:otherwise>

												<li class="page-item"><a
													href="ProductController?p=${i}&keywordsearch=${requestScope.keywordsearch}"
													class="page-link">${i}</a></li>
											</c:otherwise>


										</c:choose>
									</c:forEach>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #intro -->

	<!--==========================
    Footer
  ============================-->
	<%@include file="footer.jsp"%>

	<script>
		function sortnew() {
			$.ajax({
				type : 'GET',
				url : 'ProductController',
				data : {
					"sort" : "new"
				},
				success : function() {
					$("#liproduct").load(" #liproduct > *");
				}
			})
		};
		function sortsale() {
			$.ajax({
				type : 'GET',
				url : 'ProductController',
				data : {
					"sort" : "sale"
				},
				success : function() {
					$("#liproduct").load(" #liproduct > *");
				}
			})
		};
		function sortlow() {
			$.ajax({
				type : 'GET',
				url : 'ProductController',
				data : {
					"sort" : "low"
				},
				success : function() {
					$("#liproduct").load(" #liproduct > *");
				}
			})
		};
		function sorthigh() {
			$.ajax({
				type : 'GET',
				url : 'ProductController',
				data : {
					"sort" : "high"
				},
				success : function() {
					$("#liproduct").load(" #liproduct > *");
				}
			})
		};
	</script>


</body>
</html>
