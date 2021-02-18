package com.example.demo.event;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EventMapper {

	ArrayList<Event> selectEventList();

	int getNum();

	void insertEvent(Event e);

	Event selectEventByNum(int num);

	void updateEvent(Event e);
	
}
