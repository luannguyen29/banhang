package model;

import java.sql.Date;

public class Comment {
	private int idUser;
	private String title;
	private String comment;
	private Date date;

	public Comment(int idUser, String title, String comment, Date date) {
		super();
		this.idUser = idUser;
		this.title = title;
		this.comment = comment;
		this.date = date;
	}

	/**
	 * @return the idUser
	 */
	public int getIdUser() {
		return idUser;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}

	public java.sql.Date getDate() {
		return date;

	}
}
