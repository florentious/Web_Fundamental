<%-- scriptElement.jsp --%>

<%@ page pageEncoding="utf-8" %>

<%!
	private String name;
	private String id;
	
	public int plus(int a, int b) {
		return a+b;
		
		// out은 method안에 있어서 쓸수없다
	}
	
%>


<%
	out.println("1 + 2 = "+plus(1,2));
%>

<!-- 위랑 같은 결과값 -->
1+2 = <%=plus(1,2)%>, <% out.println(plus(1,2)); %><br>