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

import model.DAOUser;
import model.User;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DAOUser daoUser;

	private ArrayList<User> currentList = new ArrayList<>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		daoUser = new DAOUser();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// xoa nguoi dung
		if (request.getParameter("actionManage") != null) {
			String actionManage = request.getParameter("actionManage");
			if (actionManage.equals("deleteUser")) {
				int id = Integer.parseInt(request.getParameter("idOfDeleteUser"));
				daoUser.remove(id);
				daoUser.update();
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminuser.jsp");
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
		boolean fail = false;

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		if (request.getParameter("actionManage") != null) {
			String action = request.getParameter("actionManage");

			if (action.equals("findWithID")) {
				int id = Integer.parseInt(request.getParameter("idSearch"));

				User u = (daoUser.findWithId(id));
				if (u != null) {
					currentList.add(daoUser.findWithId(id));
				}

				request.setAttribute("list", currentList);

				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminuser.jsp");
				rd.forward(request, response);
				return;
			}
			//tim kiem theo ten
			if (action.equals("findWithName")) {
				String name = request.getParameter("nameSearch");
				currentList = daoUser.findWithName(name);
				request.setAttribute("list", currentList);

				RequestDispatcher rd = getServletContext().getRequestDispatcher("/adminuser.jsp");
				rd.forward(request, response);
				return;
			}
			// them nguoi dung
			if (action.equals("addUser")) {
				String uname = request.getParameter("nameOfUser");
				String pass = request.getParameter("passOfUser");
				String firstname = request.getParameter("fnameOfUser");
				String lastname = request.getParameter("lnameOfUser");
				String sex = request.getParameter("sex");
				String day = request.getParameter("day");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String address = request.getParameter("adressOfUser");
				RequestDispatcher rd;
				String notify = "";

				if (uname == null | uname.equals("")) {
					fail = true;
					notify = "Username field mustn't be blanked";
				} else

				if (pass == null | pass.equals("")) {
					fail = true;
					notify = "Password field mustn't be blanked";
				} else

				if (firstname == null | lastname.equals("") || firstname == null | lastname.equals("")) {
					fail = true;
					notify = "Name field mustn't be blanked";
				} else

				if (sex == null) {
					fail = true;
					notify = "You don't choose your sex";
				}
				if (fail) {
					request.setAttribute("fail", "Error: " + notify);

					rd = getServletContext().getRequestDispatcher("/adminuser.jsp");
				} else {

					String date = year + "-" + month + "-" + day;
					boolean isMale;
					if (sex.equals("male")) {
						isMale = true;
					} else
						isMale = false;

					daoUser.addUser(uname, pass, firstname, lastname, isMale, date, address);
					rd = getServletContext().getRequestDispatcher("/adminuser.jsp");

				}
				rd.forward(request, response);
			}
			// sua thong tin
			if (action.equals("alterUser")) {
				String uname = request.getParameter("alterNameOfUser");
				String pass = request.getParameter("alterPassOfUser");
				String firstname = request.getParameter("alterFNameOfUser");
				String lastname = request.getParameter("alterLNameOfUser");
				String sex = request.getParameter("alterSex");
				String day = request.getParameter("alterDay");
				String month = request.getParameter("alterMonth");
				String year = request.getParameter("alterYear");
				String address = request.getParameter("alterAdressOfUser");
				RequestDispatcher rd;

				boolean isMale;
				if (sex.equals("male")) {
					isMale = true;
				} else
					isMale = false;
				int id = Integer.parseInt(request.getParameter("idOfUser").trim());
				boolean type = true;
				String stringDate = day + "/" + month + "/" + year;
				SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
				Date date = null;
				try {
					date = sd.parse(stringDate);

				} catch (ParseException e) {
					e.printStackTrace();
				}
				daoUser.edit(id, new User(id, type, uname, pass, firstname, lastname, isMale, date, address));
				rd = getServletContext().getRequestDispatcher("/adminuser.jsp");
				rd.forward(request, response);
			}
		}
		doGet(request, response);
	}

}
