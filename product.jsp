<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.*"  %>
<html>
<body>
<%
try{
int mid=Integer.valueOf(request.getParameter("mid"));
int eid=1;
String mname=request.getParameter("mname");
int dose=Integer.valueOf(request.getParameter("mdose"));
int sp =Integer.valueOf(request.getParameter("stripprice"));
int rno=Integer.valueOf(request.getParameter("rackno"));
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
PreparedStatement pst=conn.prepareStatement("insert into medicine values(?,?,?,?,?,?)");
pst.setInt(1,mid);
pst.setInt(2,eid);
pst.setString(3,mname);
pst.setInt(4,dose);
pst.setInt(5,sp);
pst.setInt(6,rno);
int r=pst.executeUpdate();
if(r==0)
{%>
  <%@include file="product.html"%>
  <p>Not Inserted</p>
<%}
else
{%>
  <%@include file="product.html"%>
  <p>Inserted Successfully</p>
<%}
}
catch(Exception e)
{%>
<%@include file="product.html"%>
<p>Not Valid Data</p>
<%
}
%>
</body>
<html>
