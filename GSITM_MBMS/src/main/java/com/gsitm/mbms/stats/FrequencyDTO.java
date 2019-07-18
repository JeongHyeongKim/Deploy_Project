package com.gsitm.mbms.stats;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 30.
 * @작성자 : 송민기
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class FrequencyDTO {
	private String roomNo;
	private String countint;
	private String roomName;
}
