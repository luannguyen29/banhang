<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
.sidebar {
	top: 100px;
	position: sticky;
}
</style>
<meta charset="utf-8">
<title>Giỏ hàng</title>
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
<link href="lib/touchspin/touchspin.css" rel="stylesheet">

<!-- Main Stylesheet File -->
<link href="css/style.css" rel="stylesheet">
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
	<div class="container">
		<nav aria-label="breadcrumb" style="margin-top: 15px;">

			<a href="ProductController?action=showListgenre&idGenre=0">< Trở
				về trang mua hàng</a>
		</nav>

		<br>
		<h2>Giỏ hàng hiện tại của bạn</h2>

		<div id="content" class="spacebetweenbodyandnav">
			<div class="container">
				<div class="row bar">
					<div class="col-lg-12">
						<p>
							Bạn hiện có
							<c:choose>
								<c:when test="${sessionScope.currentAmountBuy!=null}">
							${sessionScope.currentAmountBuy }
							</c:when>
								<c:otherwise>
							0
							</c:otherwise>
							</c:choose>
							sản phẩm trong giỏ.
						</p>
					</div>
					<div id="basket" class="col-lg-9">
						<div class="box mt-0 pb-0 no-horizontal-padding">
							<form method="post" action="HandlingBuying">
								<div class="table-responsive">
									<table class="table">
										<thead>
											<tr>
												<th colspan="2">Sản phẩm</th>
												<th colspan="1">Số lượng</th>
												<th>Giá ban đầu</th>
												<th>Giá đã giảm</th>
												<th colspan="2">Giá tổng</th>
											</tr>


										</thead>
										<tbody>
									

											<c:forEach var="v" items="${sessionScope.currentlistbuy.getHashmap()}">
												<c:set var="p" value="${v.getKey() }"></c:set>
												<tr>
													<td><img src="${p.getLinkOfImage()}" class="img-fluid"></td>
													<td>${p.getName()}</td>
													<td><div style="width: 90px;"
															class="input-group bootstrap-touchspin bootstrap-touchspin-injected input-group-sm">
															<span
																onclick="location.href='ProductController?decreaseValue=${p.getIdProduct()}'"
																class="input-group-btn input-group-prepend"></span><input
																id="amount" type="text" class="input-sm form-control"
																value="${v.getValue()}" name="amount" disabled><span
																onclick="location.href='ProductController?increaseValue=${p.getIdProduct()}'"
																class="input-group-btn input-group-append"> </span>
														</div></td>
													<td>${p.getPrice()}</td>
													<td>${p.getPriceSale()}</td>
													<td>${p.getPriceSale() * v.getValue()}</td>
													<td><a
														href="ProductController?deleteProductInCart=${p.getIdProduct()}"><i
															class="fa fa-trash-o"></i></a></td>
												</tr>

											</c:forEach>
										<tfoot>
											<tr>
												<th colspan="5">Tổng</th>
												<th colspan="2">${sessionScope.currentlistbuy.totalPrice() }đ</th>
											</tr>
										</tfoot>
									</table>
								</div>
							</form>
						</div>
					</div>



					<div class="col-lg-3">
						<div class="sidebar">
							<div class="each-row">
								<div>
									<h3>Thanh toán</h3>
								</div>

								<span class="text-label">Thành tiền : </span>
								<div class="amount">

									<p>
										<strong> ${sessionScope.currentlistbuy.totalPrice() }đ </strong>
									</p>
									<p class="text-right">
										<small>(VAT include)</small>
									</p>
								</div>
								<button type="button"
									class="btn btn-large btn-block btn-danger btn-checkout"
									data-toggle="modal" data-target="#modal">Tiến hành đặt
									hàng</button>

							</div>
						</div>
					</div>
					<div class="modal fade" id="modal" role="dialog">
						<div class="modal-dialog modal-lg">
							<form action="ProductController?startOrder" method="post">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title">Thông báo</h4>
									</div>

									<div class="modal-body">
										<div style="margin-left: 15px;" class="form-group row">
											<c:choose>
												<c:when test="${sessionScope.username!=null }">

													<p>Mời bạn nhập địa chỉ mua hàng ${DAOUser.getAddress(sessionScope.iduser)}</p>
													<input type="text" name="addressBuy" class="form-control" value="${DAOUser.getAddress(sessionScope.iduser)}"
														placeholder="Địa chỉ...">
												</c:when>

												<c:otherwise>
													<p>
														Hãy đăng nhập để có thể xem tình trạng và lịch sử mua
														hàng.<a href="login.jsp">Đăng nhập</a>
													</p>
												</c:otherwise>

											</c:choose>
										</div>

									</div>

									<c:if test="${sessionScope.username!=null }">
										<div class="modal-footer">
											<button type="submit"
												class="btn btn-large btn-block btn-danger btn-checkout">
												Tiến hành đặt hàng</button>
										</div>
									</c:if>
								</div>
							</form>
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
	<script src="lib/touchspin/touchspin.js"></script>

	<script type="text/javascript">
		$("input[name='amount']").TouchSpin({
			initval : 3
		});
		$("input[name='amount2']").TouchSpin({
			initval : 3
		});
	</script>
</body>
</html>
