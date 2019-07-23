package com.gsitm.mbms.equipment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 19.
 * @작성자 : 김원빈
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EquipmentDTO {
	private int roomNo;
	private int eqNo;
	private String eqName;
	private int eqCount;
}
