<%@page import="java.util.Map"%>
<%@page import="model.Product"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.DAOUser"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.HistoryBuy"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Lịch sử mua hàng</title>
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


</head>

<!--==========================
    Header
  ============================-->
<body id="body">
	<%@include file="header2.jsp"%>


	<!-- #header -->

	<!--==========================
    Intro Section
  ============================-->


	<c:set var="list"
		value="${DAOProduct().getListLoveOfUser(sessionScope.iduser)}"></c:set>
	<div class="container">
		<div class="spacebetweenbodyandnav">
			<h1 style="font-weight: bold; font-size: 20px;">MẶT HÀNG YÊU
				THÍCH</h1>

			<c:if test="${list.size()==0 }">
				<p>Bạn chưa có sản phẩm yêu thích!</p>
			</c:if>

			<p style="font-size: 13px">Bạn đã yêu thích ${list.size()} mặt
				hàng</p>

			<div class="container row">
				<c:forEach items="${list}" var="p">


					<div class="col-lg-3 col-md-6">
						<a href="ProductController?action=showInfo&id=${p.getIdProduct()}"
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


							</div>
						</a>
					</div>


				</c:forEach>
			</div>

		</div>
	</div>

	<!-- #intro -->

	<%@include file="footer.jsp"%>
</body>
</html>
