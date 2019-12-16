package model;

public class Product {
	private int idProduct;
	private String nameProduct;
	private int idSeries;
	private float price;
	private float priceSale;
	private String linkOfImage;
	private boolean isNew;
	public Product(int idProduct, String nameProduct, int idSeries, float price, float priceSale, String linkOfImage,
			boolean isNew) {
		super();
		this.idProduct = idProduct;
		this.nameProduct = nameProduct;
		this.idSeries = idSeries;
		this.price = price;
		this.priceSale = priceSale;
		this.linkOfImage = linkOfImage;
		this.isNew = isNew;
	}
	public int getIdProduct() {
		return idProduct;
	}
	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}
	public String getNameProduct() {
		return nameProduct;
	}
	public void setNameProduct(String nameProduct) {
		this.nameProduct = nameProduct;
	}
	public int getIdSeries() {
		return idSeries;
	}
	public void setIdSeries(int idSeries) {
		this.idSeries = idSeries;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getPriceSale() {
		return priceSale;
	}
	public void setPriceSale(float priceSale) {
		this.priceSale = priceSale;
	}
	public String getLinkOfImage() {
		return linkOfImage;
	}
	public void setLinkOfImage(String linkOfImage) {
		this.linkOfImage = linkOfImage;
	}
	public boolean isNew() {
		return isNew;
	}
	public void setNew(boolean isNew) {
		this.isNew = isNew;
	}
}
