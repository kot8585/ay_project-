package com.example.demo.board;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * by 문효정
 */
@Getter @Setter
@ToString
public class Board {
	private int num;
	private String type; //faq / notice
	private String writer;
	private String title;
	private String content;
	private Date regdate;
	private Date updatedate;

	public Board() {
		super();
	}

	public Board(String type, String title, String content) {
		super();
		this.type = type;
		this.title = title;
		this.content = content;
	}

	public Board(int num, String type, String writer, String title, String content, Date regdate, Date updatedate) {
		super();
		this.num = num;
		this.type = type;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.updatedate = updatedate;
	}

}
