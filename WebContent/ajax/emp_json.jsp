<%@page import="kr.co.acorn.dao.EmpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>
<%-- {
	"cafelist" : [
	{"name":"man1","clubid":"aaa"},
	{"name":"man2","clubid":"bbb"},
	{"name":"man3","clubid":"ccc"},
	
	]
} --%>

<%
	EmpDao dao = EmpDao.getInstance();

	int start = Integer.parseInt(request.getParameter("start"));
	int length = Integer.parseInt(request.getParameter("length"));
	
	out.print(dao.selectJson(start, length));
	
%>