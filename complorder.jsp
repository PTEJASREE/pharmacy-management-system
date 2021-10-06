<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<%
int oid=Integer.valueOf(request.getParameter("oid"));
int amt=Integer.valueOf(request.getParameter("amt"));
String[] mi=request.getParameterValues("mid");
String[] si=request.getParameterValues("sid");
String[] mn=request.getParameterValues("mname");
String[] q=request.getParameterValues("qty");
String[] stock=request.getParameterValues("stc");
String bt=request.getParameter("type");
int s=mn.length;
int mid[]=new int[s];
int qty[]=new int[s];
int stc[]=new int[s];
int sid[]=new int[s];
for(int i=0;i<mn.length;i++)
{
  qty[i]=Integer.valueOf(q[i]);
  mid[i]=Integer.valueOf(mi[i]);
  sid[i]=Integer.valueOf(si[i]);
  stc[i]=Integer.valueOf(stock[i]);
}
String query1="update cust_order set amount="+amt+" where oid="+oid;
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
PreparedStatement ps=con.prepareStatement(query1);
int r=ps.executeUpdate();
if(r==0)
out.println("failure");
Connection con1=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
PreparedStatement ps1=con1.prepareStatement("insert into billtype values(?,?)");
ps1.setInt(1,oid);
ps1.setString(2,bt);
int r1=ps1.executeUpdate();
if(r1==0)
out.println("failure");
for(int i=0;i<mn.length;i++)
{
  Connection con2=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
  PreparedStatement ps2=con2.prepareStatement("insert into bill values(?,?,?)");
  ps2.setInt(1,mid[i]);
  ps2.setInt(2,oid);
  ps2.setInt(3,qty[i]);
  int r2=ps2.executeUpdate();
  if(r2==0)
  out.println("failure");
}
for(int i=0;i<mn.length;i++)
{
  out.println(stc[i]+"   "+qty[i]+"\n");
  int lo=stc[i]-qty[i];
  Connection con3=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
  PreparedStatement ps3=con3.prepareStatement("update stock set quantity=? where mid=? and sid=?");
  ps3.setInt(1,lo);
  ps3.setInt(2,mid[i]);
  ps3.setInt(3,sid[i]);
  int r3=ps3.executeUpdate();
  if(r3==0)
  out.println("failure");
}
%>
<a href="orders.jsp">Successfull! Place another order</a>
<a href="orders1.jsp">GO BACK</a>
