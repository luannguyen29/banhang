package model;

import java.util.ArrayList;

public interface IDAO <E> {
public ArrayList<E> getlist();
	
	public boolean add(E content);

	public boolean remove(int id);

	public boolean edit(int id, E content);

	public ArrayList<E> search(String name);

	public ArrayList<E> getlistBasedOnGenre(int genre);

	public E findWithID(int id);
	
	public void update();
	
	public int lastId();
}
