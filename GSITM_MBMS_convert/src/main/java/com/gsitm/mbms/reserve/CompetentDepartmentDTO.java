package com.gsitm.mbms.reserve;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 23.
 * @작성자 : 조성윤
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompetentDepartmentDTO {
	private int reserveNo;
	private int deptNo;
	private int empCount;
}
