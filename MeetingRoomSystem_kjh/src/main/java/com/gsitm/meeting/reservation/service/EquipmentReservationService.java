package com.gsitm.meeting.reservation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.meeting.reservation.dao.EquipmentReservationDaoImpl;

@Service
public class EquipmentReservationService {

	@Autowired
	private EquipmentReservationDaoImpl equipResDao;
}
