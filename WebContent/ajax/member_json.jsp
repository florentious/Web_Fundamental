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
	JSONObject jsonObj = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	
	/* Object에 넣을떄는 put, Array에 넣을때는 add */
	
	JSONObject item1 = new JSONObject();
	item1.put("name","man1");
	item1.put("clubid","aaa");
	
	JSONObject item2 = new JSONObject();
	item2.put("name","man2");
	item2.put("clubid","bbb");
	
	JSONObject item3 = new JSONObject();
	item3.put("name","man3");
	item3.put("clubid","ccc");
	
	jsonArray.add(item1);
	jsonArray.add(item2);
	jsonArray.add(item3);
	
	jsonObj.put("cafelist",jsonArray);
	/* Obj에 toString override 해놓음 */
	out.print(jsonObj.toString());
	
	
%>