package model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class HistoryBuy {
	private int idPayment;
	private float total;
	private int countProduct;
	private Map<Integer, Integer> listProduct;
	private Date date;
	private boolean isDone;
	private String add;

	public HistoryBuy(int idPayment, float total, int countProduct, Map<Integer, Integer> listProduct, Date date,
			boolean isDone, String add) {
		super();
		this.idPayment = idPayment;
		this.total = total;
		this.countProduct = countProduct;
		this.listProduct = listProduct;
		this.date = date;
		this.isDone = isDone;
		this.add = add;
	}

	public int getIdPayment() {
		return idPayment;
	}

	public void setIdPayment(int idPayment) {
		this.idPayment = idPayment;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public int getCountProduct() {
		return countProduct;
	}

	public void setCountProduct(int countProduct) {
		this.countProduct = countProduct;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public boolean isDone() {
		return isDone;
	}

	public void setDone(boolean isDone) {
		this.isDone = isDone;
	}

	public String getAdd() {
		return add;
	}

	public void setAdd(String add) {
		this.add = add;
	}

	public Map<Product, Integer> getListProduct() {
		Map<Product, Integer> duplicates = new HashMap<Product, Integer>();
		for (Map.Entry<Integer, Integer> entry : listProduct.entrySet()) {
			Product p = new DAOProduct().findWithID(entry.getKey());

			duplicates.put(p, entry.getValue());
		}

		return duplicates;
	}

}
