<%-- pageDirective.jsp --%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>

<%@ page import="java.util.Calendar, java.text.SimpleDateFormat"%>


<%--<%@ page seesion="false" %> --%>

<%@ page buffer="10kb" %>
<%-- <%@ page autoFlush="false" %>  buffer 마지막이 잘리는지에 대해서 설명--%>
<%@ page isThreadSafe="false" %> 

<%@ page info="jsp 페이지 입니다." %>
<%@ page errorPage="/error/error.jsp" %>


<%
	Calendar c = Calendar.getInstance();
	SimpleDateFormat s = new SimpleDateFormat();
	
	session.setAttribute("aa", "bb");
	
	//int a = Integer.parseInt("123a");
	
	String id = request.getParameter("id");
	
	out.print(id);
	
%>

${param.id}	<!-- EL code  -->




