package com.example.demo.order;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {

	@Autowired
	private OrderMapper mapper;

	public ArrayList<Order> getMyOrderListById(String id) {
		// TODO Auto-generated method stub
		return mapper.getMyOrderListById(id);
	}

	public void addOrder(Order o) {
		// TODO Auto-generated method stub
		mapper.insertOrder(o);
	}

	public ArrayList<Order> getAllOrderList() {
		// TODO Auto-generated method stub
		return mapper.getAllOrderList();
	}
	
	public void changeState(int num, int state) {
		// TODO Auto-generated method stub
		mapper.updateState(num, state);
	}

	public int getNum() {
		// TODO Auto-generated method stub
		return mapper.getNum();
	}
}
