package model;

import java.util.Date;

public class Payment {
	int id;
	int idUser;
	float total;
	int count;
	Date time;
	String adress;
	boolean isDone;

	public Payment(int id, int idUser, float total, int count, Date time, String adress, boolean isDone) {
		super();
		this.id = id;
		this.idUser = idUser;
		this.total = total;
		this.count = count;
		this.time = time;
		this.adress = adress;
		this.isDone = isDone;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getAdress() {
		return adress;
	}

	public void setAdress(String adress) {
		this.adress = adress;
	}

	public boolean isDone() {
		return isDone;
	}

	public void setDone(boolean isDone) {
		this.isDone = isDone;
	}

}
