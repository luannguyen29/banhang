package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;



public class DAOUser {
	private boolean typeUser;
	private String lastname = "";
	private int idUser;
	public static ArrayList<User> listUser;

	public DAOUser() {
		listUser = getList();
	}

	// lay danh sach nguoi dung
	public ArrayList<User> getList() {
		ArrayList<User> listUser = new ArrayList<User>();
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			String sql = "Select * from dbo.USERPAGE";
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				int idUser = resultSet.getInt(1);
				boolean type = resultSet.getBoolean(2);
				String nameUser = resultSet.getString(3);
				String passUser = resultSet.getString(4);
				String firstName = resultSet.getString(5);
				String lastName = resultSet.getString(6);
				boolean sex = resultSet.getBoolean(7);
				Date date = resultSet.getDate(8);
				String address = resultSet.getString(9);
				User p = new User(idUser, type, nameUser, passUser, firstName, lastName, sex, date, address);

				listUser.add(p);
			}

			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return listUser;
	}

	public boolean check(String username, String password) {

		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select IDUSER,TYPE,LASTNAME from dbo.USERPAGE WHERE NAMEUSER = '" + username
					+ "' AND PASSUSER = '" + password + "'";
			ResultSet rs = stmt.executeQuery(sql);

			if (!rs.next()) {
				stmt.close();
				conn.close();
				return false;
			} else {

				idUser = rs.getInt(1);
				typeUser = rs.getBoolean(2);
				lastname = rs.getString(3).trim();
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

	}

	public String getAddress(int id) {
		String result = null;
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement stmt = connection.createStatement();

			String sql = " Select ADDRESS from dbo.USERPAGE WHERE IDUSER=" + id;
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getString(1);

			stmt.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// findID
	public User findWithId(int id) {

		User u = null;
		try {
			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select * from dbo.USERPAGE WHERE IDUSER=" + id;
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int idUser = rs.getInt(1);
				Boolean type = rs.getBoolean(2);
				String nameUser = rs.getString(3);
				String passUser = rs.getString(4);
				String firstName = rs.getString(5);
				String lastName = rs.getString(6);
				boolean sex = rs.getBoolean(7);
				Date date = rs.getDate(8);
				String address = rs.getString(9);

				u = new User(idUser, type, nameUser, passUser, firstName, lastName, sex, date, address);

			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return u;
	}

//getidacountuser
	public int getIdAccountUser(String uname) {
		int result = 0;

		String sql = "SELECT IDUSER FROM USERPAGE WHERE NAMEUSER='" + uname + "'";
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			rs.next();

			result = rs.getInt(1);

			stmt.close();
			conn.close();
		} catch (Exception e) {
		}
		return result;
	}
	// PassWordUserName

	public String getPassWordUserName(String uname) {
		String result = null;

		String sql = "SELECT PASSWORD FROM USERPAGE WHERE NAMEUSER='" + uname + "'";
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			rs.next();

			result = rs.getString(1);

			stmt.close();
			conn.close();
		} catch (Exception e) {
		}

		return result;
	}

	//
	public int lastId() {
		String sql = "SELECT MAX(IDUSER) FROM USERPAGE";
		int result = 0;
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			rs.next();

			result = rs.getInt(1);

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// name
	public String nameUser(int idUser) {
		String first = null;
		String last = null;
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select FIRSTNAME,LASTNAME from USERPAGE WHERE IDUSER = " + idUser;

			ResultSet rs = stmt.executeQuery(sql);
			rs.next();

			first = rs.getString(1).trim() + "  ";
			last = rs.getString(2).trim();

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return first + last;
	}

	public static void saveBuy(Map<Product, Integer> list, int idUser, float total, int count, String address) {
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sqlStart = " SELECT MAX(PAYMENT_ID) FROM PAYMENT";
			ResultSet rsStart = stmt.executeQuery(sqlStart);
			rsStart.next();

			int idPayment = rsStart.getInt(1) + 1;

			rsStart.close();

			String sql = " insert into PAYMENT(PAYMENT_ID,USER_ID,TOTAL,COUNT,TIME,ADDRESSCUS,ISDONE) values(?,?,?,?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idPayment);
			ps.setInt(2, idUser);
			ps.setFloat(3, total);
			ps.setInt(4, count);

			long time = System.currentTimeMillis();
			Date date = new Date(time);

			ps.setDate(5, date);

			ps.setString(6, address);
			ps.setBoolean(7, false);

			ps.executeUpdate();
			ps.close();

			String sql2 = " insert into PAYMENTINFO(PAYMENT_ID,PRODUCT_ID,COUNT) values(?,?,?)";
			PreparedStatement ps2 = conn.prepareStatement(sql2);

			HashMap<Product, Integer> listMap = (HashMap<Product, Integer>) list;
			for (Map.Entry<Product, Integer> entry : listMap.entrySet()) {
				Product p = entry.getKey();
				ps2.setInt(1, idPayment);
				ps2.setInt(2, p.getIdProduct());
				ps2.setInt(3, entry.getValue());

				ps2.executeUpdate();
			}

			ps2.close();

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ArrayList<HistoryBuy> getHistoryBuy(int idUser) {
		ArrayList<HistoryBuy> listHistoryBuy = new ArrayList<>();
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select PAYMENT_ID,TOTAL,COUNT,TIME,ADDRESSCUS,ISDONE from PAYMENT WHERE USER_ID = " + idUser
					+ " ORDER BY TIME DESC";

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int idPaymet = rs.getInt(1);
				float total = rs.getFloat(2);
				int count = rs.getInt(3);
				Date date = rs.getDate(4);

				String sql2 = "Select PRODUCT_ID,COUNT from PAYMENTINFO WHERE PAYMENT_ID = " + idPaymet;
				Statement stmt2 = conn.createStatement();
				ResultSet rs2 = stmt2.executeQuery(sql2);
				Map<Integer, Integer> listMap = new HashMap<>();

				while (rs2.next()) {
					listMap.put(rs2.getInt(1), rs2.getInt(2));
				}

				rs2.close();
				stmt2.close();

				String add = rs.getString(5);
				boolean isDone = rs.getBoolean(6);

				listHistoryBuy.add(new HistoryBuy(idPaymet, total, count, listMap, date, isDone, add));

			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listHistoryBuy;

	}

	// DEL USER
	public boolean remove(int id) {
		String sql = "DELETE FROM USERPAGE WHERE IDUSER=?";

		try {

			Connection conn = DatabaseConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, id);
			ps.executeUpdate();
			ps.close();
			conn.close();
		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}

		return true;

	}

	// SEARCH NAME
	public ArrayList<User> findWithName(String name) {
		ArrayList<User> result = new ArrayList<>();

		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT * FROM USERPAGE WHERE LASTNAME LIKE N'" + name + " %'";

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int idUser = rs.getInt(1);
				Boolean type = rs.getBoolean(2);
				String nameUser = rs.getString(3);
				String passUser = rs.getString(4);
				String firstName = rs.getString(5);
				String lastName = rs.getString(6);
				boolean sex = rs.getBoolean(7);
				Date date = rs.getDate(8);
				String address = rs.getString(9);

				User u = new User(idUser, type, nameUser, passUser, firstName, lastName, sex, date, address);
				result.add(u);
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// ADD USER
	public void addUser(String username, String password, String firstName, String lastName, boolean sex, String date,
			String address) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = " insert into USERPAGE(IDUSER,TYPE,NAMEUSER,PASSUSER,FIRSTNAME,LASTNAME,SEX,DATE,ADDRESS) values(?,?,?,?,?,?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);

			new java.util.Date();
			java.sql.Date sqlDate = java.sql.Date.valueOf(date);

			ps.setInt(1, lastId() + 1);
			ps.setBoolean(2, true);
			ps.setString(3, username);
			ps.setString(4, password);
			ps.setString(5, firstName);
			ps.setString(6, lastName);
			ps.setBoolean(7, sex);
			ps.setDate(8, sqlDate);
			ps.setString(9, address);

			ps.executeUpdate();

			ps.close();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//EDIT USER
	public boolean edit(int id, User user) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = "UPDATE USERPAGE SET  IDUSER=? , TYPE=?,NAMEUSER=?, PASSUSER=?, FIRSTNAME=?, LASTNAME=?, SEX=?, DATE=?, ADDRESS=? WHERE IDUSER = "
					+ id + ";";
			PreparedStatement ps = conn.prepareStatement(sql);

			Date sqlDate = new Date(user.getDate().getTime());

			ps.setInt(1, user.getIdUser());
			ps.setBoolean(2, user.getType());
			ps.setString(3, user.getNameUser());
			ps.setString(4, user.getPassUser());
			ps.setString(5, user.getFirstName());
			ps.setString(6, user.getLastName());
			ps.setBoolean(7, user.isSex());
			ps.setDate(8, sqlDate);
			ps.setString(9, user.getAddress());

			int i = ps.executeUpdate();

			ps.close();

			update();

			conn.close();
			if (i == 1) {
				return true;
			}
			return false;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;

	}

	public void update() {
		getList();
		
	}

	
}
