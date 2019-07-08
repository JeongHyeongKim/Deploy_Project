package com.gsitm.meeting.reservation.service;

public class MakeAdminChangeEmail {

	
	private String html;
	public MakeAdminChangeEmail(String empId) {
		this.html = 
				"<link href=\"//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css\" rel=\"stylesheet\" id=\"bootstrap-css\">\r\n" + 
				"<script src=\"//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js\"></script>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"    <div class=\"container\">    \r\n" + 
				"        <div id=\"loginbox\" style=\"margin-top:50px;\" class=\"mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2\">                    \r\n" + 
				"            <div class=\"panel panel-info\" >\r\n" + 
				"                    <div class=\"panel-heading\">\r\n" + 
				"                        <div class=\"panel-title\" style=\"text-align:center\">관리자 위임 인증번호 입력</div>\r\n" + 
				"                    </div>     \r\n" + 
				"\r\n" + 
				"                    <div style=\"padding-top:30px\" class=\"panel-body\" >\r\n" + 
				"\r\n" + 
				"                        <div style=\"display:none\" id=\"login-alert\" class=\"alert alert-danger col-sm-12\"></div>\r\n" + 
				"                            \r\n" + 
				"                        <form id=\"loginform\" class=\"form-horizontal\" role=\"form\" action=\"http://localhost:8000/meeting/recognition/isCorrect\" method=\"get\" style=\"text-align:center\">                      \r\n" + 
				"                            <div style=\"margin-bottom: 25px\">\r\n" + 
				"                                        <input id=\"login-username\" type=\"text\" class=\"form-control\" name=\"randomVar\" value=\"\" placeholder=\"인증번호 입력\">\r\n" + 
				"                                        <input type=\"hidden\" name=\"empId\" value=\""+empId+"\">                                        \r\n" + 
				"                                    </div>\r\n" + 
				"                                <div style=\"margin-top:10px\" class=\"form-group\">\r\n" + 
				"                                    <!-- Button -->\r\n" + 
				"\r\n" + 
				"                                    <div class=\"col-sm-12 controls\">\r\n" + 
				"                                      <button id=\"btn-login\" type=\"submit\" class=\"btn btn-success\">인증하기</a>\r\n" + 
				"\r\n" + 
				"                                    </div>\r\n" + 
				"                                </div>\r\n" + 
				"\r\n" + 
				"                            </form>     \r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"                        </div>                     \r\n" + 
				"                    </div>  \r\n" + 
				"        </div>\r\n" + 
				"        </div>\r\n" + 
				"";
	}
	
	
	public String getEmailString() {
		return html;
	}

}
