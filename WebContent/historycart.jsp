<%@page import="java.util.Map"%>
<%@page import="model.Product"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.DAOUser"%>
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


	<c:set value="${DAOUser.getHistoryBuy( sessionScope.iduser) }"
		var="list"></c:set>
	<div class="container">
		<div class="spacebetweenbodyandnav">

			<h1 style="font-weight: bold;font-size: 20px;">LỊCH SỬ MUA HÀNG</h1>

			<c:if test="${list.size()==0 }">
				<p>Bạn chưa từng mua hàng!</p>
			</c:if>
			
			

			<div id="accordion">

				<c:forEach items="${list}" var="v" varStatus="c">
					<div class="card">
						<div class="card-header">
							<strong><a
								class="<c:if test="${c.index==0}">collapsed</c:if> card-link"
								data-toggle="collapse" href="#${c.index}" style="color: black">
									ID đơn hàng: ${ v.getIdPayment()}, Mua hàng ngày
									${v.getDate().toString()}, Trạng thái : <c:choose>
										<c:when test="${v.isDone()==false}">Chưa giao hàng</c:when>
										<c:otherwise>
										Giao hàng thành công
										</c:otherwise>
									</c:choose>
							</a></strong>

						</div>

						<div id="${c.index}"
							class="collapse <c:if test="${c.index==0}">show</c:if>
							data-parent="#accordion">
							<div class="card-body">
								<p>Bạn đã mua ${v.getCountProduct()} sản phẩm</p>
								<table class="table">
									<thead>
										<tr>
											<th colspan="2">Sản phẩm</th>
											<th colspan="1">Số lượng</th>
											<th>Giá sản phẩm</th>
											<th>Giá tiền</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="li" items="${v.getListProduct()}">
											<c:set var="key" value="${li.getKey() }"></c:set>

											<tr>
												<td><img src="${ key.getLinkOfImage()}"
													class="img-fluid"></td>
												<td>${ key.getName()}</td>
												<td>${ li.getValue()}</td>
												<td>${ key.getPriceSale()}</td>
												<td>${ key.getPriceSale() * li.getValue()}</td>
											</tr>

										</c:forEach>


									</tbody>
									<tfoot>
										<tr>
											<th colspan="4">Total</th>
											<th colspan="2">${v.getTotal()}</th>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>

				</c:forEach>

			</div>
		</div>
	</div>







	<!-- #intro -->

	<%@include file="footer.jsp"%>
</body>
</html>
