package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class DAOPayment {
	private static ArrayList<Payment> listPayment = new ArrayList<Payment>();

	public DAOPayment() {
		listPayment = getList();
	}

	public static ArrayList<Payment> getList() {
		ArrayList<Payment> listPayment = new ArrayList<Payment>();
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select * from dbo.PAYMENT";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int id = rs.getInt(1);
				int idUser = rs.getInt(2);
				float total = rs.getFloat(3);
				int count = rs.getInt(4);
				Date time = rs.getDate(5);
				String adress = rs.getString(6);
				boolean isDone = rs.getBoolean(7);

				Payment u = new Payment(id, idUser, total, count, time, adress, isDone);

				listPayment.add(u);
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		DAOPayment.listPayment = listPayment;
		return listPayment;

	}

	public boolean remove(int id) {
		String sql = "DELETE FROM PAYMENT WHERE PAYMENT_ID=?";
		int check;
		try {

			Connection conn = DatabaseConnection.getConnection();

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, id);

			check = ps.executeUpdate();

			ps.close();
			conn.close();
		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}
		if (check == 0)
			return false;
		return true;

	}

	public boolean done(int id) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = "UPDATE PAYMENT SET  ISDONE=? WHERE PAYMENT_ID = " + id + ";";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1, true);
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
		return false;
	}

	public void update() {
		getList();
	}

	public boolean edit(int id, Payment payment) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = "UPDATE PAYMENT SET  PAYMENT_ID=? , USER_ID=?,TOTAL=?, COUNT=?, TIME=?, ADDRESSCUS=?, ISDONE=? WHERE PAYMENT_ID = "
					+ id + ";";
			PreparedStatement ps = conn.prepareStatement(sql);
			Date ultiDate = payment.getTime();
			java.sql.Date sqlDate = new java.sql.Date(ultiDate.getTime());

			ps.setInt(1, payment.getId());
			ps.setInt(2, payment.getIdUser());
			ps.setFloat(3, payment.getTotal());
			ps.setInt(4, payment.getCount());
			ps.setDate(5, sqlDate);
			ps.setString(6, payment.getAdress());
			ps.setBoolean(7, payment.isDone);

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

	public ArrayList<Payment> findWithName(String name) {

		int idUser = new DAOUser().getIdAccountUser(name);
		ArrayList<Payment> result = new ArrayList<>();

		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT * FROM  dbo.PAYMENT WHERE USER_ID=" + idUser;

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int id = rs.getInt(1);
				int idAccountUser = rs.getInt(2);
				float total = rs.getFloat(3);
				int count = rs.getInt(4);
				Date date = rs.getDate(5);
				String address = rs.getString(6);
				boolean isDone = rs.getBoolean(7);

				Payment p = new Payment(id, idAccountUser, total, count, date, address, isDone);
				result.add(p);
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

//	public static void main(String[] args) {
//		System.out.println(DAOPayment.getList());
//		System.out.println("luan");
//	}
}
