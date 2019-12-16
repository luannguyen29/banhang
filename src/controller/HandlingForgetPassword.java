package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAOUser;

/**
 * Servlet implementation class HandlingForgetPassword
 */
@WebServlet("/HandlingForgetPassword")
public class HandlingForgetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HandlingForgetPassword() {
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("name");
		RequestDispatcher rd = null;

		if (username == null || username.equals("")) {
			request.setAttribute("errorforgetpass", "Please don't blank this field");
			rd = getServletContext().getRequestDispatcher("/forget.jsp");
		} else {
			String result = new DAOUser().getPassWordUserName(username);
			if (result != null) {
				request.setAttribute("forgetpass", result);
			} else
				request.setAttribute("forgetpass", "Không tìm thấy tên user");
			rd = getServletContext().getRequestDispatcher("/user.jsp");
		}
		rd.forward(request, response);
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
