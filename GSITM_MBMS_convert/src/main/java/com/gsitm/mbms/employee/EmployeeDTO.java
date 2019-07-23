package com.gsitm.mbms.employee;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @주제 : Employee테이블 DTO
 * @작성일 : 2019. 5. 3.
 * @작성자 : 조성윤
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeDTO {
	private String empNo; 
	private String empPw;
	private String empName;
	private String empPosition;
	private String empEmail;
	private String cellPhone;
	private String officePhone;
	private int deptNo;
	private char permissionYn;
	private DepartmentDTO dept;

}