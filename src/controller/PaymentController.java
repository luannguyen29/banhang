package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAOPayment;
import model.DAOUser;
import model.Payment;
import model.User;

/**
 * Servlet implementation class PaymentController
 */
@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOPayment listPayment;
	private DAOUser daoUser;
	private ArrayList<Payment> currentList = new ArrayList<>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentController() {
		super();
		daoUser = new DAOUser();
		listPayment = new DAOPayment();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("actionManage") != null) {
			String action = request.getParameter("actionManage");

			if (action.equals("done")) {
				int id = Integer.parseInt(request.getParameter("idOfPayment"));
				listPayment.done(id);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminpayment.jsp");
				rd.forward(request, response);
				return;
			}
			if (action.equals("deletePayment")) {

				int id = Integer.parseInt(request.getParameter("idOfPayment"));

				listPayment.remove(id);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminpayment.jsp");
				rd.forward(request, response);
				return;
			}
		}

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
			
			//tim don hang theo ten
			if (action.equals("findWithName")) {
				String name = request.getParameter("nameSearch");
				currentList = listPayment.findWithName(name);
				request.setAttribute("listpayment", currentList);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminpayment.jsp");
				rd.forward(request, response);
				return;
			}
				//thay doi don hang
			
			if (action.equals("alterPayment")) {
				int id = Integer.parseInt(request.getParameter("idOfPayment"));

				String accountUser = request.getParameter("alterIdOfUser");
				float total = Float.parseFloat(request.getParameter("alterTotal"));
				int count = Integer.parseInt(request.getParameter("alterCount"));
				String day = request.getParameter("alterDay");
				String month = request.getParameter("alterMonth");
				String year = request.getParameter("alterYear");
				String address = request.getParameter("alterAdress");
				//
				int idUser = daoUser.getIdAccountUser(accountUser);
				boolean isDone = false;
				if (request.getParameter("isDone") != null) {
					isDone = true;
				}
				String stringDate = day + "/" + month + "/" + year;
				SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
				Date date = null;
				try {
					date = sd.parse(stringDate);

				} catch (ParseException e) {
					e.printStackTrace();
				}
				listPayment.edit(id, new Payment(id, idUser, total, count, date, address, isDone));
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminpayment.jsp");
				rd.forward(request, response);
			}
		}
		doGet(request, response);

	}

}
