package com.gsitm.meeting.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.gsitm.meeting.users.dao.EmployeeDaoImpl;

public class LoginFailureHandler implements AuthenticationFailureHandler 
{

	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String id = request.getParameter("id");
		String exceptionMessage = String.valueOf(exception.getMessage());
		System.out.println(id);
		System.out.println(exception.getClass());
		System.out.println(exception.getMessage());
		
		request.setAttribute("id", id);
		request.setAttribute("exceptionMessage", exceptionMessage);
		
		request.getRequestDispatcher("/users/checkFailureCnt").forward(request, response);

		
	}

}
