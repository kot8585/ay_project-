package com.example.demo.order;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {

	ArrayList<Order> getMyOrderListById(String id);

	void insertOrder(Order o);

	ArrayList<Order> getAllOrderList();
	
	void updateState(int num, int state);

	int getNum();
}
