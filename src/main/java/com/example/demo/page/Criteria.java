package com.example.demo.page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

/**
 * by 문효정
 */
@Getter
@ToString
@Slf4j
@Setter
public class Criteria {
	private int pageNum; // 현재 페이지 번호
	private int amount; // 한 페이지에 보여줄 게시물의 개수
	private String keyword;
	private int offset;
	private Integer cursorId;

	public Criteria() {
		this(1, 10,""); 
	}

	public Criteria(int pageNum, int amount) {
		this(pageNum, amount, "");
	}

	public Criteria(int pageNum, int amount, String keyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.keyword = keyword;
		log.info("cri.pageNum:{}, ammount:{}",this.pageNum, this.amount);
		//setOffset(pageNum, amount);
	}

	public int changeOffset(int pageNum, int amount) {
		this.offset = (pageNum - 1) * amount;
		return offset;
	}

}
