<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<html>
<body>
<%
try{
int eid=Integer.valueOf(request.getParameter("eid"));
String ename=request.getParameter("ename");
long phno=Long.parseLong(request.getParameter("phno"));
String address=request.getParameter("address");
String des=request.getParameter("des");
String pwd=request.getParameter("pwd");
String cpwd=request.getParameter("cpwd");
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
if(pwd.equals(cpwd)){
PreparedStatement pst=conn.prepareStatement("insert into employee values(?,?,?,?,?,?)");
pst.setInt(1,eid);
pst.setString(2,ename);
pst.setLong(3,phno);
pst.setString(4,address);
pst.setString(5,des);
pst.setString(6,pwd);
int r=pst.executeUpdate();
if(r==0){
  %>
    <%@include file="emp.html"%>
    <p>Not Inserted</p>
  <%}
else
{%>
  <%@include file="emp.html"%>
  <p>Inserted Successfully</p>
<%}
}
else{
  %>
  <%@include file="emp.html"%>
  <p>Passwords are not equal</p>
  <%=pwd%>
  <%=cpwd%>
  <%
}
}
catch(Exception e)
{%>
  <%@include file="emp.html"%>
  <p>Invalid Data</p>
<%
}
%>
</body>
<html>
