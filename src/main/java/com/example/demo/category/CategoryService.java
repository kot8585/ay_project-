package com.example.demo.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 카테고리와 관련된 기능들을 구현한 Service 클래스입니다.
 * @author 김평기
 * @version main 1
 */
@Service
public class CategoryService {

	@Autowired
	private CategoryMapper mapper;

	/**
	 * 카테고리 추가.
	 * @param c : 추가할 카테고리 내용을 담은 DTO
	 * @param type : 카테고리 분류
	 */
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

	/**
	 * 원하는 카테고리의 리스트를 받아오는 기능을 제공합니다.
	 * @param type 카테고리 분류
	 * @param c_id 카테고리 ID
	 * @return 받아온 리스트
	 */
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

	/**
	 * 원하는 카테고리를 받아오는 기능을 제공합니다.
	 * @param id 카테고리 id
	 * @param type 카테고리 분류
	 * @return 받아온 카테고리
	 */
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

	/**
	 * 카테고리 삭제
	 * @param type : 카테고리 분류
	 * @param id : 삭제한 카테고리의 id
	 */
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

	/**
	 * 카테고리 수정
	 * @param type : 카테고리 분류
	 * @param c : 수정할 카테고리 내용을 담은 DTO
	 */
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
