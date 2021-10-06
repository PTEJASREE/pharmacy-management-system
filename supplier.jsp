<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<html>
<body>
<%

int sid=Integer.valueOf(request.getParameter("sid"));
String sname=request.getParameter("sname");
long phno=Long.parseLong(request.getParameter("phno"));
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
PreparedStatement pst=conn.prepareStatement("insert into supplier values(?,?,?)");
pst.setInt(1,sid);
pst.setString(2,sname);
pst.setLong(3,phno);
int r=pst.executeUpdate();
if(r==0)
{%>
<%@include file="supplier.html"%>
<p>Not Inserted</p>
<%}
else
{%>
<%@include file="supplier.html"%>
<p>Inserted Successfully</p>
<%}

%>
</body>
<html>
