package com.example.demo.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.order.Order;
import com.example.demo.reply.Reply;

@Service
public class ProductService {

	@Autowired
	private ProductMapper mapper;
	
	/**
	 * 상품추가
	 * @param p : 추가 한 상품을 p에 담음
	 */
	public void addProduct(Product p) {
		mapper.insert(p);
	}
	
	/**
	 * 상품번호검색
	 * @param num : 상품번호를 받아옴
	 * @return : 번호검색
	 */
	public Product getProductByNum(int num) {
		return mapper.selectByNum(num);
	}
	
	
//	public List getProductByName(String name) {
//		return mapper.selectByName(name);
//	}
	
	
	public List getProductByPrice(int min, int max) {
		Map map = new HashMap();
		map.put("min", min);
		map.put("min", min);
		return mapper.selectByPrice(map);
	}
	
	public List getProductByC1(int c1) {
		return mapper.selectByC1(c1);
	}
	
	public List getProductByC2(int c2) {
		return mapper.selectByC2(c2);
	}
	
	public List getProductAll() {
		return mapper.selectAll();
	}
		
	public void editProduct(Product p) {
		mapper.update(p);
	}
		
	public void delProduct(int num) {
		mapper.delete(num);
	}
		
	public int getNum() {
		return mapper.getNum();
	}

	public ArrayList<Product> getProductByEvent() {
		// TODO Auto-generated method stub
		return mapper.selectByEvent();
	}
	
	public void decreaseProduct(Order o) {
		// TODO Auto-generated method stub
		mapper.decreaseProduct(o);
	}
	
}
