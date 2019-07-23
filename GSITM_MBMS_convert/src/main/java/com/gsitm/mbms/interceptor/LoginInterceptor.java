package com.gsitm.mbms.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.employee.LoginService;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 10.
 * @작성자 : 조성윤
 */
@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private LoginService loginService;
	
	@Override 
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Object login = session.getAttribute("login");
		
		

		
		
		//로그인 세션 없을 때
		if(login == null) {
			System.out.println("LoginInterceptor : "+request.getServletPath());
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				String id = loginCookie.getValue();
				EmployeeDTO employeeDTO = loginService.getEmployee(id);
				if(employeeDTO != null) {
					session.setAttribute("login", employeeDTO);
					response.sendRedirect(request.getServletPath().equals("/login") ? "/" : request.getServletPath());
					return false;
				}
			}
			
			if(!request.getServletPath().equals("/error/error404"))
				session.setAttribute("prevUrl", request.getServletPath());
			//로그인이 안되어 있는 상태 - 로그인 폼으로 돌려 보냄
			response.sendRedirect("/login");
			return false;
		}
		
		
		//민기 운영자, 결재자 판단부분----------------------------------------------
		EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("login");
		
		boolean isAdmin = loginService.isAdmin(employeeDTO.getEmpNo());
		if (isAdmin==true) session.setAttribute("isAdmin", isAdmin);
		
		boolean isApprover = loginService.isApprover(employeeDTO.getEmpNo());
		if (isApprover==true) session.setAttribute("isApprover", isApprover);
		//-------------------------------------------------------------------------

		
		
		
		if(session.getAttribute("prevUrl")!=null) {
			System.out.println(session.getAttribute("prevUrl"));
			String target = (String)session.getAttribute("prevUrl");
			session.removeAttribute("prevUrl");
			response.sendRedirect(target);
			return false;
		}

		
		
		return true;
	}
}
