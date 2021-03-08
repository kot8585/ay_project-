package com.example.demo.order;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {

	@Autowired
	private OrderMapper mapper;

	public ArrayList<Order> getMyOrderListById(String id) {
		return mapper.getMyOrderListById(id);
	}

	@Transactional
	public void addOrder(Order o) {
		mapper.insertOrder(o);
	}

	public ArrayList<Order> getAllOrderList() {
		return mapper.getAllOrderList();
	}
	
	@Transactional
	public void changeState(int num, int state) {
		// TODO Auto-generated method stub
		mapper.updateState(num, state);
	}

	@Transactional
	public int getNum() {
		// TODO Auto-generated method stub
		return mapper.getNum();
	}
}
