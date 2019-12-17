package kr.co.acorn.hello;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
/*
  1. Servlet Annotation => @WebServlet("/hello") 
  2. Servet Annotation으로 지정된 이름을 서블릿으로 호출할 수 있다. 
  3. 만약 Servlet Annotation을 사용하지 않고 서블릿을 호출하려면 web.xml(DD파일)에 서블릿 정보를 추가해야한다.
  4. url-pattern 지정하는 방법 3가지
  	1) extension matching => *.do, *.nhn, *.acorn 			// 확장자는 맘대로 할수 있음
  	2) exact matching => /test, /acorn, /test/acorn, /*.do
  	3) wildcard matching => /test/* , /acorn/*				// 앞에 지정하면 뒤에 뭐가 오거든 이 서블릿호출
  	// 2),3)은 반드시 /로 시작해야함, 1)은 /로 절대 시작하면 안됨
 */

@WebServlet("/HelloServlet")		// 로컬 주소의 호출하는 방법에 대해서
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 응답 MIME 타입과 문자 인코딩을 지정한다.
		response.setContentType("text/html;charset=utf-8");
		
		// 클라이언트에게 응답할 출력 객체를 생성한다.
		PrintWriter out = response.getWriter();
		out.print("<!DOCTYPE html>");
		out.print("<html>");
		out.print("<body>");
		out.print("<h1>Hello</h1>");
		out.print("</body>");
		out.print("</html>");
		
		
		
		
	}

	
}
