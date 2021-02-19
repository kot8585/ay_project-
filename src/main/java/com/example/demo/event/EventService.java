package com.example.demo.event;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public void addEvent(Event e) {
		mapper.insertEvent(e);
	}

	public Event getEventByNum(int num) {
		return mapper.selectEventByNum(num);
	}

	public void editEvent(Event e) {
		mapper.updateEvent(e);
	}

	public void deleteEvent(int num) {
		mapper.deleteEvent(num);
	}
	
}
