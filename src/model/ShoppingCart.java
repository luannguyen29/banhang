package model;

import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
	private Map<Product, Integer> hashmap;
	public ShoppingCart() {
		hashmap = new HashMap<>();
	}
	public Map<Product, Integer> getHashmap() {
		return hashmap;
	}
	public void addCart(int id) {
		Product p = new DAOProduct().findWithID(id);

		if (hashmap.containsKey(p)) {
			if (hashmap.get(p) < 100)
				hashmap.put(p, hashmap.get(p) + 1);
		} else {
			hashmap.put(p, 1);
		}
	}

	public double totalPrice() {
		double result = 0;

		for (Map.Entry<Product, Integer> entry : hashmap.entrySet()) {
			result += (entry.getKey().getPriceSale() * entry.getValue());
		}
		return result;
	}

	public int amount() {
		int result = 0;

		for (Map.Entry<Product, Integer> entry : hashmap.entrySet()) {
			result += entry.getValue();
		}
		return result;
	}

	public void deleteProductIncart(int id, boolean isAll) {

		Product p = new DAOProduct().findWithID(id);

		if (isAll) {
			hashmap.remove(p);
			return;
		}
		int i = hashmap.get(p);
		if (i <= 0 )
			return;

		hashmap.put(p, i - 1);

	}
}
