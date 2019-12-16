package model;

import java.util.Date;

public class User {
	private int idUser;
	private Boolean type;
	private String nameUser;
	private String passUser;
	private String firstName;
	private String lastName;
	private boolean sex;
	private Date date;
	private String address;

	public User(int idUser, Boolean type, String nameUser, String passUser, String firstName, String lastName,
			boolean sex, Date date, String address) {
		super();
		this.idUser = idUser;
		this.type = type;
		this.nameUser = nameUser;
		this.passUser = passUser;
		this.firstName = firstName;
		this.lastName = lastName;
		this.sex = sex;
		this.date = date;
		this.address = address;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public Boolean getType() {
		return type;
	}

	public void setType(Boolean type) {
		this.type = type;
	}

	public String getNameUser() {
		return nameUser;
	}

	public void setNameUser(String nameUser) {
		this.nameUser = nameUser;
	}

	public String getPassUser() {
		return passUser;
	}

	public void setPassUser(String passUser) {
		this.passUser = passUser;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean isSex() {
		return sex;
	}

	public void setSex(boolean sex) {
		this.sex = sex;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
