package com.example.demo.page;

public class PageDTO {
	private int startPage; //화면에서 보여지는 페이지의 시작 번호
	private int endPage; //화면에서 보여지는 페이지의 끝 번호
	private boolean prev, next; //이전과 다음으로 이동가능한 링크의 표시여부
	
	private int total; //게시물의 총 개수
	private Criteria cri; 
	
	public PageDTO(Criteria cri, int total) {
		this.total = total;
		this.cri = cri;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0) * 10);
		this.startPage = endPage - 9;
		
		//실제 끝번호
		int realEnd = (int) Math.ceil(total * 1.0/ cri.getAmount());
		if(realEnd < endPage)
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getTotal() {
		return total;
	}

	public Criteria getCri() {
		return cri;
	}
	
	
}
