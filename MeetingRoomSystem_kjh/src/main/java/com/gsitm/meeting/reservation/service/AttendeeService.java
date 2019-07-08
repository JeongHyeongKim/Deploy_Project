package com.gsitm.meeting.reservation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.meeting.reservation.dao.AttendeeDaoImpl;

@Service
public class AttendeeService {

	@Autowired
	private AttendeeDaoImpl attDao;
}
