package com.gsitm.meeting.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gsitm.meeting.reservation.dao.EquipmentReservationDaoImpl;
import com.gsitm.meeting.reservation.service.EquipmentReservationService;

@Controller
public class EquipmentReservationController {

	@Autowired
	private EquipmentReservationService equipResService;
}
