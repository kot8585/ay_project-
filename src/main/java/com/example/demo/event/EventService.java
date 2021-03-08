package com.example.demo.event;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EventService {

	@Autowired
	private EventMapper mapper;
	
	public ArrayList<Event> getEventList() {
		return mapper.selectEventList();
	}

	public int getNum() {
		return mapper.getNum();
	}

	@Transactional
	public void addEvent(Event e) {
		mapper.insertEvent(e);
	}

	public Event getEventByNum(int num) {
		return mapper.selectEventByNum(num);
	}

	@Transactional
	public void editEvent(Event e) {
		mapper.updateEvent(e);
	}

	@Transactional
	public void deleteEvent(int num) {
		mapper.deleteEvent(num);
	}
	
}
