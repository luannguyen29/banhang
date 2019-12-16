package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAOUser;

/**
 * Servlet implementation class HandlingLogin
 */
@WebServlet("/HandlingLogin")
public class HandlingLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HandlingLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("name");
		String password = request.getParameter("password");
		String nameerror = null;

		boolean error = false;

		if (username == null || username.equals("")) {
			error = true;
			nameerror = "usererror";

		} else if (password == null || password.equals("")) {
			error = true;
			nameerror = "passerror";

		} else {

			DAOUser daoUser = new DAOUser();

			if (daoUser.check(username, password)) {

				

				HttpSession session = request.getSession();
				session.setAttribute("loginsuccess", daoUser.isTypeUser());
				session.setAttribute("iduser", daoUser.getIdUser());
				session.setAttribute("username", daoUser.getLastname());
				

				if (daoUser.isTypeUser()) {
					
					response.sendRedirect("ProductController?action=showListgenre&idGenre=0");

				} else {

					response.sendRedirect("admin.jsp");
				}
			} else {

				request.setAttribute("cantfind", "Username or password is wrong");
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
				return;
			}
		}

		if (error) {
			request.setAttribute(nameerror, "This below field mustn't be blanked");
			error = false;
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
