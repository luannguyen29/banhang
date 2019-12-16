package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.DAOGenres;
import model.DAOProduct;
import model.DAOSeries;
import model.DAOUser;
import model.Product;
import model.Series;
import model.ShoppingCart;

/**
 * Servlet implementation class ProductController
 */
@WebServlet("/ProductController")
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	private DAOProduct daoProduct = new DAOProduct();

	private DAOSeries daoSeries = new DAOSeries();
	// list show
	private ArrayList<Product> currentList = new ArrayList<>();

	// list series show
	private ArrayList<Series> currentSeriesList = new ArrayList<>();

	// start value of list
	private int startValue = 0;
	private int endValue = 8;
	private int pageId = 1;

	private final int PRODUCTPERPAGE = 8;

	private String keywordsearch = " ";

	public ProductController() {
		super();
		daoProduct = new DAOProduct();

		daoSeries = new DAOSeries();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	/**
	 * Each if else we also have attribute totalPage which defines how many pages
	 * that we need
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		daoProduct.update();
		daoSeries.update();
		RequestDispatcher rd = null;
		boolean cart = false;

		// if you trigger button buy...
		if (request.getParameter("buyButton") != null) {

			request.setAttribute("notifyAfterBuy", 1);

			if (request.getSession().getAttribute("currentlistbuy") == null) {
				ShoppingCart listcart = new ShoppingCart();

				listcart.addCart(Integer.parseInt(request.getParameter("buyButton")));
				request.getSession().setAttribute("currentlistbuy", listcart);

			} else {
				((ShoppingCart) request.getSession().getAttribute("currentlistbuy"))
						.addCart(Integer.parseInt(request.getParameter("buyButton")));

			}
			request.getSession().setAttribute("currentAmountBuy",
					((ShoppingCart) request.getSession().getAttribute("currentlistbuy")).amount());

			PrintWriter out = response.getWriter();
			out.println((int) request.getSession().getAttribute("currentAmountBuy"));
			out.flush();
			return;
		}

		if (request.getParameter("sort") != null) {

			String currentSort = request.getParameter("sort");
			daoProduct.setKeyWord(currentSort);
			pageId = 1;

		}

		// work in manage product

		if (request.getParameter("actionManage") != null) {

			String actionManage = request.getParameter("actionManage");

			if (actionManage.equals("deleteProduct")) {
				int id = Integer.parseInt(request.getParameter("idOfDeleteProduct"));
				daoProduct.remove(id);

				rd = getServletContext().getRequestDispatcher("/admin.jsp");
				rd.forward(request, response);
				return;
			}

			if (actionManage.equals("deleteSeries")) {
				int id = Integer.parseInt(request.getParameter("idOfDeleteSeries"));
				daoSeries.remove(id);

				rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
				rd.forward(request, response);
				return;
			}
			// define page to forward

		}

		// deifne page
		if (request.getParameter("p") != null) {
			pageId = Integer.parseInt(request.getParameter("p"));

		}
		String action = request.getParameter("action");

		if (action != null) {
			// serach product
			if (action.equals("searchWithGivenText")) {
				currentList.clear();
				String keyWord = request.getParameter("search-product");

				if (keyWord == null) {
					keyWord = keywordsearch;
				} else {
					keywordsearch = keyWord;
				}
				currentList = daoProduct.search(keyWord.trim());
				request.setAttribute("listBasedOnGenre", currentList);

				pageId = 1;

				if (request.getSession().getAttribute("loginsuccess") != null) {
					if (!(boolean) request.getSession().getAttribute("loginsuccess")) {
						rd = getServletContext().getRequestDispatcher("/admin.jsp");
						rd.forward(request, response);
						return;
					}
				}
			}

			if (action.equals("searchWithGivenID")) {
				currentList.clear();

				try {
					int id = Integer.parseInt(request.getParameter("idSearch"));
					Product p = daoProduct.findWithID(id);
					System.out.println(p.getIdProduct());

					currentList.add(p);
					request.setAttribute("listBasedOnGenre", currentList);

					rd = getServletContext().getRequestDispatcher("/admin.jsp");
					rd.forward(request, response);

				} catch (Exception e) {
					request.setAttribute("error", "Lỗi nhập dữ liệu");
					rd = getServletContext().getRequestDispatcher("/admin.jsp");
					rd.forward(request, response);
					return;
				}

			}

			// show list genre
			if (action.equals("showListgenre")) {
				currentList.clear();
				int currentGenre = Integer.parseInt(request.getParameter("idGenre"));

				currentList = daoProduct.getlistBasedOnGenre(currentGenre);
				pageId = 1;
				request.setAttribute("listBasedOnGenre", currentList);

				if (request.getSession().getAttribute("loginsuccess") != null) {
					if (!(boolean) request.getSession().getAttribute("loginsuccess")) {
						rd = getServletContext().getRequestDispatcher("/admin.jsp");
						rd.forward(request, response);
						return;
					}
				}

				if (currentGenre != 0) {
					keywordsearch = new DAOGenres().findWithID(currentGenre).getName();
				} else {
					keywordsearch = "Toàn bộ";
				}

			}

			// show lít love
			if (action.equals("showListLove")) {
				pageId = 1;
				currentList = daoProduct.getlistLove();

				keywordsearch = "Được yêu thích";
				request.setAttribute("listBasedOnGenre", currentList);

			}

			// search author
			if (action.equals("searchAuthor")) {
				String name = request.getParameter("nameAuthor");
				pageId = 1;
				currentList = daoProduct.getlistBasedOnAuthor(name);

				keywordsearch = name;
				request.setAttribute("listBasedOnGenre", currentList);

			}

			// show info manga
			if (action.equals("showInfo")) {
				int id = Integer.valueOf(request.getParameter("id"));
				request.setAttribute("notifyAfterClickProduct", daoProduct.findWithID(id));

				rd = getServletContext().getRequestDispatcher("/watchproduct.jsp");
				rd.forward(request, response);
				return;
			}

			// like product

			if (action.equals("likeProduct")) {
				int id = Integer.valueOf(request.getParameter("idProduct"));

				boolean b = daoProduct.updateLove(id, (int) request.getSession().getAttribute("iduser"));

				if (b == false) {
					daoProduct.createReview(id, (int) request.getSession().getAttribute("iduser"));
				}

				request.setAttribute("notifyAfterClickProduct", daoProduct.findWithID(id));
				rd = getServletContext().getRequestDispatcher("/watchproduct.jsp");
				rd.forward(request, response);
				return;

			}

			if (action.equals("writeComment")) {
				String title = request.getParameter("titleReview");
				String text = request.getParameter("textReview");
				int idProduct = Integer.parseInt(request.getParameter("idProduct"));

				int idComment = daoProduct.getIdComment(idProduct, (int) request.getSession().getAttribute("iduser"));

				daoProduct.updateComment(idComment, title, text);

				request.setAttribute("notifyAfterClickProduct", daoProduct.findWithID(idProduct));
				rd = getServletContext().getRequestDispatcher("/watchproduct.jsp");
				rd.forward(request, response);
				return;

			}
		}

		if (request.getParameter("startOrder") != null) {

			ShoppingCart scart = (ShoppingCart) request.getSession().getAttribute("currentlistbuy");
			DAOUser.saveBuy(scart.getHashmap(), (int) request.getSession().getAttribute("iduser"),
					(float) scart.totalPrice(), scart.amount(), request.getParameter("addressBuy"));

			request.getSession().removeAttribute("currentlistbuy");
			request.getSession().removeAttribute("currentAmountBuy");
			request.setAttribute("buysuccess", "Mua thành công");

		}

		// enter cart.jsp page
		if (request.getParameter("currentCart") != null) {
			cart = true;
		}

		// decreaseProductValue
		if (request.getParameter("decreaseValue") != null) {

			int id = Integer.parseInt(request.getParameter("decreaseValue"));
			((ShoppingCart) request.getSession().getAttribute("currentlistbuy")).deleteProductIncart(id, false);
			cart = true;

		}

		// increaseProductValue
		if (request.getParameter("increaseValue") != null) {

			int id = Integer.parseInt(request.getParameter("increaseValue"));
			((ShoppingCart) request.getSession().getAttribute("currentlistbuy")).addCart(id);

			cart = true;

		}

		// deleteProductInCart
		if (request.getParameter("deleteProductInCart") != null) {

			int id = Integer.parseInt(request.getParameter("deleteProductInCart"));
			((ShoppingCart) request.getSession().getAttribute("currentlistbuy")).deleteProductIncart(id, true);

			cart = true;

		}
		if (cart) {
			request.getSession().setAttribute("currentAmountBuy",
					((ShoppingCart) request.getSession().getAttribute("currentlistbuy")).amount());
			response.sendRedirect("cart.jsp");
			return;
		} else {

			request.setAttribute("keywordsearch", keywordsearch);

			defineValueOfOnePageNumber();
			request.setAttribute("countresult", currentList.size());
			request.setAttribute("totalPage", totalPage());
			request.setAttribute("startOffset", startValue);
			request.setAttribute("endOffset", endValue);

			if (request.getAttribute("listBasedOnGenre") == null)
				request.setAttribute("listBasedOnGenre", currentList);

			rd = getServletContext().getRequestDispatcher("/product.jsp");
		}
		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		if (request.getParameter("actionManage") != null) {

			String action = request.getParameter("actionManage");
			try {
				if (action.equals("searchIDSeries")) {
					currentSeriesList.clear();
					int id = Integer.parseInt(request.getParameter("idSearch"));
					currentSeriesList.add(daoSeries.findWithID(id));
					request.setAttribute("seriesList", currentSeriesList);

					RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
					rd.forward(request, response);
					return;
				}

				if (action.equals("searchGenreSeries")) {
					int currentGenre = Integer.parseInt(request.getParameter("searchGenreSeriestext"));
					currentSeriesList = daoSeries.getlistBasedOnGenre(currentGenre);
					request.setAttribute("seriesList", currentSeriesList);
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
					rd.forward(request, response);
					return;
				}

				if (action.equals("searchNameSeries")) {

					currentSeriesList = daoSeries.search(request.getParameter("searchNameSeriestext"));
					request.setAttribute("seriesList", currentSeriesList);

					RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
					rd.forward(request, response);
					return;
				}
			} catch (Exception e) {
				request.setAttribute("error", "Lỗi nhập dữ liệu");
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
				rd.forward(request, response);
				return;
			}

			if (action.equals("alterSeries") || action.equals("addSeries")) {

				String name = request.getParameter("nameOfSeries").trim();
				String author = request.getParameter("authorOfSeries").trim();
				String summary = request.getParameter("summaryOfSeries").trim();
				String[] listGenres = request.getParameterValues("listCheckBox");

				ArrayList<Integer> listIdGenres = new ArrayList<>();

				for (int i = 0; i < listGenres.length; i++) {
					listIdGenres.add(Integer.parseInt(listGenres[i]));
				}

				if (action.equals("alterSeries")) {

					int id = Integer.parseInt(request.getParameter("idOfSeries").trim());
					daoSeries.edit(id, new Series(daoSeries.lastId() + 1, name, listIdGenres, author, summary));

				} else if (action.equals("addSeries")) {

					if (daoSeries.duplicate(name)) {
						request.setAttribute("error", "Lỗi trùng tên");
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
						rd.forward(request, response);
						return;
					} else {

						daoSeries.add(new Series(daoSeries.lastId() + 1, name, listIdGenres, author, summary));
					}

				}

				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminseries.jsp");
				rd.forward(request, response);
				return;
			}

			if (action.equals("alterProduct") || action.equals("addProduct")) {

				String name = request.getParameter("nameOfProduct").trim();
				float price, priceSale;
				try {
					price = Float.parseFloat(request.getParameter("priceOfProduct").trim());
					priceSale = Float.parseFloat(request.getParameter("priceSaleOfProduct").trim());
				} catch (Exception e) {
					request.setAttribute("error", "Lỗi nhập giá sản phẩm");
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
					rd.forward(request, response);
					return;
				}

				String linkOfImage = request.getParameter("linkImageOfProduct").trim();
				String series = request.getParameter("seriesOfProduct");
				boolean isNew = false;

				if (request.getParameter("productIsNew") != null) {
					isNew = true;
				}

				int idSeries = daoSeries.getIdBasedOnGivenName(series);

				if (action.equals("alterProduct")) {

					int id = Integer.parseInt(request.getParameter("idOfProduct").trim());
					daoProduct.edit(id, new Product(id, name, idSeries, price, priceSale, linkOfImage, isNew));

				} else if (action.equals("addProduct")) {
					if (daoProduct.duplicate(name)) {
						request.setAttribute("error", "Lỗi trùng tên");
						RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
						rd.forward(request, response);
						return;
					} else {
						daoProduct.add(new Product(daoProduct.lastId() + 1, name, idSeries, price, priceSale,
								linkOfImage, isNew));
					}

				}
				request.getSession().setAttribute("currentLinkImageProduct", linkOfImage);

				RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
				rd.forward(request, response);
				return;

			}

			if (action.equals("addImageProduct")) {
				uploadImage(request, response);
				request.getSession().removeAttribute("currentLinkImageProduct");

				RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
				rd.forward(request, response);
				return;
			}

		}

		doGet(request, response);
	}

	// upload image
	private void uploadImage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uploadFolder = getServletContext().getRealPath("/");
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory())
						.parseRequest((HttpServletRequest) request);

				for (FileItem fileItem : multiparts) {
					if (!fileItem.isFormField() && fileItem.getSize() != 0) {
						String name = (String) request.getSession().getAttribute("currentLinkImageProduct");

						File f = new File(uploadFolder + "//" + name);

						if (f.exists()) {
							f.delete();
						}
						fileItem.write(f);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("message", "File Upload Failed" + e);
			}
		} else {

			request.setAttribute("message", "Sorry! Well done!");
		}

	}

	private int totalPage() {

		int result = 0;
		int listSize = currentList.size();

		if ((listSize % PRODUCTPERPAGE) != 0)
			result = listSize / PRODUCTPERPAGE + 1;
		else
			result = listSize / PRODUCTPERPAGE;

		return result;

	}

	private void defineValueOfOnePageNumber() {
		startValue = (PRODUCTPERPAGE * (pageId - 1));
		if ((startValue + PRODUCTPERPAGE - 1) >= (currentList.size() - 1)) {
			endValue = currentList.size() - 1;
		} else {
			endValue = startValue + PRODUCTPERPAGE - 1;
		}
	}

}
