package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class DAOSeries implements IDAO<Series> {
	public static ArrayList<Series> listSeries;

	public DAOSeries() {
		listSeries = getlist();
	}

	@Override
	public ArrayList<Series> getlist() {
		ArrayList<Series> listSeries = new ArrayList<>();
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " Select * from dbo.SERIES";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				int idSeries = rs.getInt(1);
				String nameSeries = rs.getString(2).trim();
				String producer = rs.getString(3).trim();
				String summary = rs.getString(4).trim();

				Statement stmt2 = conn.createStatement();
				String sql2 = " Select GENRES_ID from GENRES  WHERE SERIES_ID = " + idSeries;
				ResultSet rs2 = stmt2.executeQuery(sql2);

				ArrayList<Integer> genres = new ArrayList<>();
				while (rs2.next()) {
					genres.add(rs2.getInt(1));
				}

				Series s = new Series(idSeries, nameSeries, genres, producer, summary);

				listSeries.add(s);
				stmt2.close();
			}

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return listSeries;
	}

	@Override
	public boolean add(Series content) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = " insert into SERIES(SERIES_ID,NAMESERIES,PRODUCER,SUMMARY) values(?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, content.getiDSeries());
			ps.setString(2, content.getNameSeries());
			ps.setString(3, content.getProducer());
			ps.setString(4, content.getSummary());

			int check1 = ps.executeUpdate();
			if (check1 != 1) {
				ps.close();

				conn.close();
				return false;

			}

			int check2;
			String sql2 = " insert into GENRES(SERIES_ID,GENRES_ID) values(?,?)";
			PreparedStatement ps2 = conn.prepareStatement(sql2);

			for (int i = 0; i < content.getGenres().size(); i++) {
				ps2.setInt(1, content.getiDSeries());
				ps2.setInt(2, content.getGenres().get(i));

				check2 = ps2.executeUpdate();

				if (check2 != 1) {
					ps2.close();

					conn.close();
					return false;

				}
			}

			ps.close();

			update();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public boolean remove(int id) {
		String sql1 = "DELETE FROM GENRES WHERE SERIES_ID=?";
		String sql2 = "DELETE FROM SERIES WHERE SERIES_ID=?";

		int check1, check2;
		try {

			Connection conn = DatabaseConnection.getConnection();

			PreparedStatement ps1 = conn.prepareStatement(sql1);
			ps1.setInt(1, id);

			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ps2.setInt(1, id);

			check1 = ps1.executeUpdate();

			check2 = ps2.executeUpdate();

			ps1.close();
			conn.close();
		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}
		if (check1 == 0 || check2 == 0)
			return false;
		return true;
	}

	@Override
	public boolean edit(int id, Series content) {
		try {
			Connection conn = DatabaseConnection.getConnection();
			String sql = "UPDATE SERIES SET   NAMESERIES=?,PRODUCER=?, SUMMARY=? WHERE SERIES_ID = " + id + ";";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, content.getNameSeries());
			ps.setString(2, content.getProducer());
			ps.setString(3, content.getSummary());

			int check1 = ps.executeUpdate();

			int check2;
			String sql2 = "DELETE FROM GENRES WHERE SERIES_ID=?";
			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ps2.setInt(1, id);
			check2 = ps2.executeUpdate();

			int check3 = 0;

			String sql3 = " insert into GENRES(SERIES_ID,GENRES_ID) values(?,?)";
			PreparedStatement ps3 = conn.prepareStatement(sql3);

			for (int i = 0; i < content.getGenres().size(); i++) {
				ps3.setInt(1, id);
				ps3.setInt(2, content.getGenres().get(i));

				check3 = ps3.executeUpdate();

			}
			if (check3 != 1 || check2 != 1 || check1 != 1) {
				ps2.close();

				conn.close();
				return false;

			}

			ps.close();

			update();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public ArrayList<Series> search(String name) {
		ArrayList<Series> result = new ArrayList<>();
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT * FROM SERIES  WHERE NAMESERIES LIKE N'" + name + " %'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				int idSeries = rs.getInt(1);
				String nameSeries = rs.getString(2).trim();
				String author = rs.getString(3).trim();
				String summary = rs.getString(4).trim();

				Statement stmt2 = conn.createStatement();
				String sql2 = " Select GENRES_ID from GENRES  WHERE SERIES_ID = " + idSeries;
				ResultSet rs2 = stmt2.executeQuery(sql2);

				ArrayList<Integer> genres = new ArrayList<>();
				while (rs2.next()) {
					genres.add(rs2.getInt(1));
				}

				Series s = new Series(idSeries, nameSeries, genres, author, summary);

				result.add(s);
				stmt2.close();
			}
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ArrayList<Series> getlistBasedOnGenre(int genre) {
		if (genre == 0) {
			return listSeries;
		}
		ArrayList<Series> result = new ArrayList<>();

		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT SERIES_ID,NAMESERIES,PRODUCER,SUMMARY FROM SERIES S INNER JOIN GENRES G  WHERE G.GENRES_ID ="
					+ genre;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				int idSeries = rs.getInt(1);
				String nameSeries = rs.getString(2).trim();
				String author = rs.getString(3).trim();
				String summary = rs.getString(4).trim();

				Statement stmt2 = conn.createStatement();
				String sql2 = " Select GENRES_ID from GENRES  WHERE SERIES_ID = " + idSeries;
				ResultSet rs2 = stmt2.executeQuery(sql2);

				ArrayList<Integer> genres = new ArrayList<>();
				while (rs2.next()) {
					genres.add(rs2.getInt(1));
				}

				Series s = new Series(idSeries, nameSeries, genres, author, summary);

				result.add(s);
				stmt2.close();
			}
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Series findWithID(int id) {
		Series result = null;

		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT * FROM SERIES  WHERE SERIES_ID=" + id;
			ResultSet rs = stmt.executeQuery(sql);

			rs.next();

			int idSeries = rs.getInt(1);
			String nameSeries = rs.getString(2).trim();
			String author = rs.getString(3).trim();
			String summary = rs.getString(4).trim();

			Statement stmt2 = conn.createStatement();
			String sql2 = " Select GENRES_ID from GENRES  WHERE SERIES_ID = " + idSeries;
			ResultSet rs2 = stmt2.executeQuery(sql2);

			ArrayList<Integer> genres = new ArrayList<>();
			while (rs2.next()) {
				genres.add(rs2.getInt(1));
			}

			result = new Series(idSeries, nameSeries, genres, author, summary);

			stmt2.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public void update() {
		listSeries = getlist();

	}

	public boolean duplicate(String name) {
		try {

			Connection conn = DatabaseConnection.getConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT * FROM SERIES WHERE NAMESERIES='" + name + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				stmt.close();
				conn.close();
				return true;
			}
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public String generateGenresIntoString(int idSeries) {

		ArrayList<Integer> listId = findWithID(idSeries).getGenres();
		ArrayList<String> genre = new ArrayList<>();

		for (int i = 0; i < listId.size(); i++) {
			genre.add(new DAOGenres().findWithID(listId.get(i)).getName());
		}

		StringBuilder sb = new StringBuilder();

		for (int j = 0; j < genre.size(); j++) {
			if (j != (genre.size() - 1)) {
				sb.append(genre.get(j) + ", ");
			} else {
				sb.append(genre.get(j) + ".");
			}
		}

		return sb.toString();
	}

	public int getIdBasedOnGivenName(String text) {

		for (int i = 0; i < listSeries.size(); i++) {
			if (listSeries.get(i).getNameSeries().trim().equalsIgnoreCase(text)) {
				return listSeries.get(i).getiDSeries();
			}
		}
		return 0;

	}

	@Override
	public int lastId() {
		String sql = "SELECT MAX(SERIES_ID) FROM SERIES";
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
