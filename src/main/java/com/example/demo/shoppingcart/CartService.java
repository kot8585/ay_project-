package com.example.demo.shoppingcart;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CartService {

	@Autowired
	private CartMapper mapper;
	
	public ArrayList<Shoppingcart> getShoppingcartById(String id) {
		return mapper.getShoppingcartById(id);
	}

	@Transactional
	public void addCart(Shoppingcart cart) {
		mapper.insertCart(cart);
	}
	
	
}
