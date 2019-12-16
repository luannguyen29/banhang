 package model;

import java.util.ArrayList;

public class Series {
	private int iDSeries;
	private String nameSeries;
	private ArrayList<Integer> genres;
	private String producer;
	private String summary;
	public Series(int iDSeries, String nameSeries, ArrayList<Integer> genres, String producer, String summary) {
		super();
		this.iDSeries = iDSeries;
		this.nameSeries = nameSeries;
		this.genres = genres;
		this.producer = producer;
		this.summary = summary;
	}
	public int getiDSeries() {
		return iDSeries;
	}
	public void setiDSeries(int iDSeries) {
		this.iDSeries = iDSeries;
	}
	public String getNameSeries() {
		return nameSeries;
	}
	public void setNameSeries(String nameSeries) {
		this.nameSeries = nameSeries;
	}
	public ArrayList<Integer> getGenres() {
		return genres;
	}
	public void setGenres(ArrayList<Integer> genres) {
		this.genres = genres;
	}
	public String getProducer() {
		return producer;
	}
	public void setProducer(String producer) {
		this.producer = producer;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
}
