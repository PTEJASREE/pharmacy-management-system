<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.*"  %>
<html>
<body>
<%
try{
int mid=Integer.valueOf(request.getParameter("mid"));
int sid=Integer.valueOf(request.getParameter("sid"));
String mfd=request.getParameter("mfd");
String exp=request.getParameter("exp");
int qty=Integer.valueOf(request.getParameter("qty"));
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
PreparedStatement pst=conn.prepareStatement("insert into stock values(?,?,TO_DATE(?,'mm/dd/yyyy'),TO_DATE(?,'mm/dd/yyyy'),?)");
pst.setInt(1,mid);
pst.setInt(2,sid);
pst.setString(3,mfd);
pst.setString(4,exp);
pst.setInt(5,qty);
int r=pst.executeUpdate();
if(r==0){
  %>
    <%@include file="stock.html"%>
    <p>Not Inserted</p>
  <%}
else
{%>
  <%@include file="stock.html"%>
  <p>Inserted Successfully</p>
<%}
}
catch(Exception e)
{%>
<%@include file="stock.html"%>
<p>Not Valid Data</p>
<%
}
%>
</body>
<html>
