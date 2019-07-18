package com.gsitm.mbms.employee;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.gsitm.mbms.employee.LoginService;

import lombok.extern.slf4j.Slf4j;

/**
 * @주제 :
 * @작성일 : 2019. 5. 3.
 * @작성자 : 조성윤
 */
@Controller
@Slf4j
public class EmployeeController {

	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);

	@Autowired
	private LoginService loginService;
	
	@Autowired
	private EmployeeService employeeService;

	/** 로그인 화면 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpSession session) {
		logger.info("Login Page !!");
		
		if(session.getAttribute("login") != null) return "reserve/calendar";
		
		return "login";
	}

	/** 로그인 */
	@RequestMapping(value = "/logincheck", method = RequestMethod.POST)
	@ResponseBody
	public String loginCheck(@RequestParam Map<String, String> map, HttpSession session, HttpServletResponse response)
			throws Exception {
		logger.info("Login Check !!");
		EmployeeDTO employeeDTO = loginService.login(map);

		if (employeeDTO == null) {
			if (loginService.getEmployee(map.get("emp_no")) == null)
				return "notExist"; // 아이디 존재하지 않음
			else
				return "fail"; // 비밀번호 틀림
		}

		if (map.get("useCookie").equals("true")) {
			Cookie cookie = new Cookie("loginCookie", employeeDTO.getEmpNo());
			cookie.setPath("/");
			int amount = 60 * 60 * 24 * 7;
			cookie.setMaxAge(amount); // 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
			response.addCookie(cookie);
		}

		session.setAttribute("login", employeeDTO); // 로그인정보 저장

		return "success"; // 로그인 성공
	}

	/** 로그아웃 **/
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	@ResponseBody
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.info("logout!!");
		
		Object obj = session.getAttribute("login");
		if (obj != null) {
			//session.removeAttribute("login");
			session.invalidate(); // 세션 전체를 날려버림
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
			}
		}

		return "logout";
	}
	@GetMapping("/employee/getEmployee")
	public ModelAndView getEmployee(@RequestParam String mgrEmpNo) {
		ModelAndView mav = new ModelAndView();
		log.info("GetEmployee Action");
		EmployeeDTO dto = employeeService.getEmployee(mgrEmpNo);
		mav.addObject("dto",dto);
		mav.setViewName("jsonView");
		System.out.println(mav);
		return mav;
	}
}
