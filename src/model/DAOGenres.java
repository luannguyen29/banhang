package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class DAOGenres implements IDAO<Genres> {
	public static ArrayList<Genres> listGenres;

	public DAOGenres() {
		listGenres = getlist();
	}

	@Override
	public ArrayList<Genres> getlist() {
		ArrayList<Genres> listGenres = new ArrayList<>();
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select * from dbo.INFOGENRES";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int idGenres = rs.getInt(1);
				String nameGenres = rs.getString(2).trim();

				Genres g = new Genres(idGenres, nameGenres);

				listGenres.add(g);
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return listGenres;
	}

	@Override
	public boolean add(Genres content) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean edit(int id, Genres content) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Genres> search(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Genres> getlistBasedOnGenre(int genre) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Genres findWithID(int id) {
		Genres result = null;
		String sql = "SELECT * FROM INFOGENRES WHERE ID=" + id;
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(sql);
			rs.next();

			result = new Genres(id, rs.getString(2));

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void update() {
		listGenres = getlist();

	}

	@Override
	public int lastId() {
		String sql = "SELECT MAX(ID) FROM INFOGENRES";
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

}
