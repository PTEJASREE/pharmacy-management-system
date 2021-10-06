<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
String id=request.getParameter("un");
String n=request.getParameter("pwd");
String des="manager";
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
Statement st1=conn.createStatement();
ResultSet rs1=st1.executeQuery("select * from employee where eid='"+id+"' and password='"+n+"' and designation='"+des+"'");
if(rs1.next())
{
  %>
  <jsp:forward page="orders.jsp"></jsp:forward>
  <%
}
else{
Statement st2=conn.createStatement();
ResultSet rs2=st2.executeQuery("select * from employee where eid='"+id+"' and password='"+n+"'");
if(rs2.next())
  {
    %>
    <jsp:forward page="orders1.jsp"></jsp:forward>
    <%
  }
else
{
  %>
  <jsp:forward page="index.html"></jsp:forward>
  <%
}
}
%>
