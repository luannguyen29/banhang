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
 * Servlet implementation class HandlingAccount
 */
@WebServlet("/HandlingAccount")
public class HandlingAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DAOUser user = new DAOUser();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HandlingAccount() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		boolean fail = false;

		String uname = request.getParameter("username");
		String pass = request.getParameter("password");
		String passagain = request.getParameter("npassword");

		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String sex = request.getParameter("sex");
		String day = request.getParameter("day");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String prov = request.getParameter("prov");

		RequestDispatcher rd;
		String notify = "";

		if (uname == null || uname.equals("")) {
			fail = true;
			notify = "Username field mustn't be blanked";
		} else if (!passagain.equals(pass)) {
			fail = true;
			notify = "Password doesn't match";
		} else

		if (passagain == null || passagain.equals("") || pass == null || pass.equals("")) {
			fail = true;
			notify = "Password field mustn't be blanked";
		} else

		if (firstname == null || lastname.equals("") || firstname == null || lastname.equals("")) {
			fail = true;
			notify = "Name field mustn't be blanked";
		} else

		if (sex == null) {
			fail = true;
			notify = "You don't choose your sex";
		}

		if (fail) {
			request.setAttribute("fail", "Error: " + notify);

			rd = getServletContext().getRequestDispatcher("/createanaccount.jsp");
		} else {

			String date = year + "-" + month + "-" + day;
			boolean isMale;
			if (sex.equals("male")) {
				isMale = true;
			} else
				isMale = false;

			if (user.getPassWordUserName(uname) != null) {
				request.setAttribute("fail", "Đã có tên đăng nhập này trong CSDL");

				rd = getServletContext().getRequestDispatcher("/createanaccount.jsp");
			} else {

				user.addUser(uname, pass, firstname, lastname, isMale, date, prov);

				request.setAttribute("success", "Your account is created");
				rd = getServletContext().getRequestDispatcher("/user.jsp");
			}

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
