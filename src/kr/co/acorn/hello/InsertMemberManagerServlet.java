package kr.co.acorn.hello;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.acorn.hello.dao.MemberManagerDao;
import kr.co.acorn.hello.dto.MemberManagerDto;

@WebServlet("/InsertMemberManager")
public class InsertMemberManagerServlet extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		boolean isSuccess = false;
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		
		MemberManagerDto dto = new MemberManagerDto(id,name);
		MemberManagerDao dao = MemberManagerDao.getInstance();
		
		isSuccess = dao.insert(dto);
		
		if(isSuccess) {
			
		}else {
			response.sendRedirect("/hello/memberManagerInsert.html");
		}
		
		
	}
	
}
