package com.gsitm.mbms.employee;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 7.
 * @작성자 : 조성윤
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentDTO {
	private int deptNo;		//부서번호
	private String deptName;	//부서명
	private String bossNo;		//부서장
	private int mgrDeptNo;	//상위 부서 번호

}
