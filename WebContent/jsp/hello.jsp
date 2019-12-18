<%@ page pageEncoding="utf-8" %>

<!--
C:\dev\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\ROOT\org\apache\jsp\jsp
위의 주소에 servlet 파일 컴파일 및 class 파일로 컴파일 
 -->

<html>
	<body>
		<!-- html 사이에 java code 삽입 -->
		<%
		for(int i=0;i<100;i++) {
		%>
			<h1>hello jsp</h1>
			
		<%
		}
		%>
		
		<%-- 
		<%
		for(int i=0;i<100;i++) {
			out.println("<h1> hello jsp </h1>");
		}
		%>
		 --%>
	
	</body>

</html>