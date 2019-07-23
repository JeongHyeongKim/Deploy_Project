package com.gsitm.mbms.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @주제 :
 * @작성일 : 2019. 5. 10.
 * @작성자 : 송민기
 */
@Component
public class AuthorityInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		boolean isAdmin = session.getAttribute("isAdmin")==null ? false : (boolean)session.getAttribute("isAdmin");
		
		// 운영자 아닐때 권한에러 출력
		if (!isAdmin) {     
			response.sendRedirect("/error/errorAuthority");
			return false;
		}

		return true;
	}
}
