<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="lib/jquery/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Roboto"
	rel="stylesheet">

<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="css/moi.css">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<body>
	<div class="main-nav">
		<div class="container row">

			<div class="feature exclusive">
				<span class="tikicon icon-exclusive"></span> Tất cả sản phẩm 100%
				chính hiệu
			</div>
			<div class="feature return" style="margin-left: 15px;">
				<span class="tikicon icon-return"> </span> 30 ngày đổi trả dễ dàng
			</div>
			<div id="popup-sms"></div>
		</div>
	</div>

	<header id="header" class="nav-collapse">

		<div class="header-form-container">
			<div class="container">
				<a href="index.jsp" class="logo">
					<h1>GROUP 9</h1>
				</a>

				<div class="form-search">
					<form action="ProductController?action=searchWithGivenText"
						method="post">
						<div class="search-wrap">
							<div class="input">
								<div class="flex">
									<input type="text" id="search-product" name="search-product"
										autocomplete="off" value=""
										placeholder="Tìm sản phẩm (manga) mong muốn ...">
								</div>
							</div>
							<button type="submit">
								<i class="tikicon icon-search"></i> <span>Tìm kiếm</span>
							</button>
						</div>
					</form>
				</div>
				<div class="header-link">
					<div class="user-profile item" id="header-user">
						<div data-reactroot="">
							<div>
								<a href="ProductController?action=showListgenre&idGenre=0"
									style="color: white; font-size: 13px;"><i
									class="icon-style-1 fa fa-list-alt tikicon "></i> Xem toàn bộ <br>mặt
									hàng</a>
							</div>
							<div class="box-noti"></div>
						</div>
					</div>
					<div class="user-profile item" id="header-user">
						<div data-reactroot="">
							<div id="show">
								<i class="icon-style-1 tikicon icon-user"></i>

								<c:choose>
									<c:when test="${sessionScope.username==null }">

										<b><a href="login.jsp" style="color: white">Đăng nhập</a></b>
										<br>
									</c:when>
									<c:otherwise>

										<b>Chào ${sessionScope.username}</b>
										<br>

									</c:otherwise>
								</c:choose>
								<small>Tài khoản</small>
							</div>
							<div class="box" id="modalOfUser" style="display: none">
								<ul class="user-ajax-guest">
									<li id="login_link"><a href="historycart.jsp"
										title="Lịch sử mua hàng" class="user-name-login"><span
											class="text">Lịch sử mua hàng</span></a></li>
									<li id="login_link"><a href="listlove.jsp"
										title="Lịch sử mua hàng" class="user-name-login"><span
											class="text">Mặt hàng yêu thích</span></a></li>

									<li class="user-name-register"><a href="user.jsp"
										title="Đăng xuất"><span class="text">Đăng xuất</span></a></li>

								</ul>
							</div>
						</div>
					</div>
					<div id="header-cart">
						<a data-reactroot="" rel="nofollow" href="cart.jsp"
							class="header-cart item"><i class="tikicon icon-cart"></i> <!-- react-text: 3 -->Giỏ
							hàng<!-- /react-text --> <span class="cart-count" id="cart-count">
								<c:choose>
									<c:when test="${sessionScope.currentAmountBuy!=null }">
								${sessionScope.currentAmountBuy}
							</c:when>
									<c:otherwise>0							
							</c:otherwise>
								</c:choose>
						</span>
							<div id="modalNotify" class="add-to-cart-success"
								style="display: none">
								<span onclick="" id="close" class="close"><i
									class="fa fa-close"></i></span>
								<p class="text">
									<i class="tikicon icon-circle-tick"></i>
									<!-- react-text: 10 -->

									<c:choose>
										<c:when test="${requestScope.buysuccess !=null}">Bạn đã mua thành công</c:when>
										<c:otherwise>Thêm vào giỏ hàng thành công</c:otherwise>
									</c:choose>

									<!-- /react-text -->
								</p>

								<c:if test="${requestScope.buysuccess==null }">
									<button class="btn">Xem giỏ hàng và thanh toán</button>
								</c:if>

							</div></a>
					</div>
					<!-- Tooltip Link social -->
				</div>
			</div>
		</div>


	</header>
</body>
<script>
	$(document).click(function(event) {
		//if you click on anything except the modal itself or the "open modal" link, close the modal

		if (!$(event.target).closest(".add-to-cart-success").length) {
			document.getElementById("modalNotify").style.display = "none";
		}

	});
</script>
<c:if test="${sessionScope.username!=null }">
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#show')
									.click(
											function() {
												if (document
														.getElementById("modalOfUser").style.display === "block") {
													document
															.getElementById("modalOfUser").style.display = "none";
												} else {
													document
															.getElementById("modalOfUser").style.display = "block";
												}
												;
											});
						});
	</script>
</c:if>

<c:if test="${requestScope.buysuccess!=null}">
	<script type="text/javascript">
		$(document).ready(function() {
			$('.add-to-cart-success').slideToggle("fast");
			document.getElementById("modalNotify").style.display = "block";
			$('#close').click(function() {
				document.getElementById("modalNotify").style.display = "none";
			});
		});
	</script>
</c:if>
<script type="text/javascript">
	function trigger() {

		$('.add-to-cart-success').slideToggle("fast");
		document.getElementById("modalNotify").style.display = "block";

	};
</script>
</html>