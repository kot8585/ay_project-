package com.example.demo.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {

	@Autowired
	private CategoryMapper mapper;

	public void addCategory(Category c, int type) { //카테고리  추가 

		switch (type) {
		case 1:
			mapper.insertC1(c);
			break;
		case 2:
			mapper.insertC2(c);
			break;
		}
	}

	public List getAll(int type, int c_id) { // 카테고리 전체 출력 
		List list = null;

		switch (type) {
		case 1:
			list = mapper.selectAllC1();
			break;
		case 2:
			list = mapper.selectAllC2(c_id);
			break;
		}
		return list;
	}

	public Category getCategory(int id, int type) {
		Category category = null;

		switch (type) {
		case 1:
			category = mapper.selectC1(id);
			break;
		case 2:
			category = mapper.selectC2(id);
			break;
		}
		return category;
	}

	public void delCategory(int id, int type) {
		switch (type) {
		case 1:
			mapper.deleteC1(id);
			break;
		case 2:
			mapper.deleteC2(id);
			break;
		}
	}

	public void editCategory(int type, Category c) {
		switch (type) {
		case 1:
			mapper.updateC1(c);
			break;

		case 2:
			mapper.updateC2(c);
			break;
		}
	}
}
