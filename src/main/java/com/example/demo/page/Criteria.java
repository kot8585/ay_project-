package com.example.demo.page;

public class Criteria {
	private int pageNum; // 현재 페이지 번호
	private int amount; // 한 페이지에 보여줄 게시물의 개수
	private String keyword;

	public Criteria() {
		this(1, 10,""); 
	}

//	public Criteria(String keyword) {
//		this(1,10,keyword);
//	}

	public Criteria(int pageNum, int amount) {
		this(pageNum, amount, "");
	}

	public Criteria(int pageNum, int amount, String keyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.keyword = keyword;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public String getKeyword() {
		return keyword;
	}

	
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", keyword=" + keyword + "]";
	}

}
