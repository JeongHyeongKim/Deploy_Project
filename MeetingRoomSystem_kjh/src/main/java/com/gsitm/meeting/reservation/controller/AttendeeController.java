package com.gsitm.meeting.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gsitm.meeting.reservation.dao.AttendeeDaoImpl;
import com.gsitm.meeting.reservation.service.AttendeeService;

@Controller
public class AttendeeController {

	@Autowired
	private AttendeeService attService;
}
