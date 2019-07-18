package com.gsitm.mbms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 28.
 * @작성자 : 조성윤
 */
@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@RequestMapping("/error404")
	public String error404() {
		return "error/404";
	}
	
	@RequestMapping("/error500")
	public String error500() {
		return "error/500";
	}
	
	@RequestMapping("/errorAuthority")
	public String errorAuthority() {
		return "error/authority";
	}
}
