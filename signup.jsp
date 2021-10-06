<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
String name=request.getParameter("name");
String phno=request.getParameter("phno");
String address=request.getParameter("address");
String un=request.getParameter("un");
String pwd=request.getParameter("pwd");
String cpwd=request.getParameter("cpwd");
if(pwd.equals(cpwd))
{
PreparedStatement ps=con.prepareStatement("insert into customer values(next value for seq,?,?,?,?,?)");
ps.setString(1,name);
ps.setString(2,phno);
ps.setString(3,address);
ps.setString(4,un);
ps.setString(5,pwd);
int r=ps.executeUpdate();
if(r!=0){%>
  <jsp:forward page="index.html"></jsp:forward><%
}
else{
%><%@include file="signup.html"%>
<p>Something went wrong try again</p>
<%
}
}
else{%>
<jsp:forward page="signup.html"></jsp:forward>
<p>Password should be same</p>
<%}
%>
