<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.Date"  %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
String date=formatter.format(new Date());
String c_name=request.getParameter("cname");
String phoneno=request.getParameter("phno");
long phno=Long.parseLong(phoneno);
String dname=request.getParameter("dname");
String hname=request.getParameter("hname");
String mname[]=request.getParameterValues("mname");
String address="Rajahmundry";
int amt=0,cid=3,oid=0;
String qry;
int[] mid=new int[mname.length];
int[] sid=new int[mname.length];
int[] cost=new int[mname.length];
int[] qty1=new int[mname.length];
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con1=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
Statement st1=con1.createStatement();
ResultSet rs1=st1.executeQuery("SELECT oid.NEXTVAL FROM DUAL");
if(rs1.next())
{
 String id=rs1.getString(1);
 oid=Integer.valueOf(id);
}
else
{
  out.println("something went wrong");
}
Statement st10=con1.createStatement();
ResultSet rs10=st10.executeQuery("SELECT cid.NEXTVAL FROM DUAL");
if(rs10.next())
{
 String id=rs10.getString(1);
 oid=Integer.valueOf(id);
}
else
{
  out.println("something went wrong");
}
Statement st=con1.createStatement();
ResultSet rs=st.executeQuery("select cid from customer where cname='"+c_name+"' and phno='"+phoneno+"'");
if(rs.next())
{
  cid=Integer.valueOf(rs.getString(1));
}
else
{
  Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
  PreparedStatement pst=conn.prepareStatement("insert into customer values(?,?,?,?)");
  pst.setInt(1,cid);
  pst.setString(2,c_name);
  pst.setLong(3,phno);
  pst.setString(4,address);
  int r=pst.executeUpdate();
  if(r==0)
  {
    %>
      <%@include file="orders.jsp"%>
      <p>Not Inserted</p>
    <%
  }
    else
    {
      out.println("inserted");
    }
  }
    Connection con2=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
    PreparedStatement pst2=con2.prepareStatement("insert into cust_order values(?,?,to_date(?,'dd/mm/yyyy'),?,?,?)");
    pst2.setInt(1,oid);
    pst2.setInt(2,cid);
    pst2.setString(3,date);
    pst2.setString(4,dname);
    pst2.setString(5,hname);
    pst2.setInt(6,amt);
    int r=pst2.executeUpdate();
    if(r==0)
    {
      %>
        <%@include file="orders.jsp"%>
        <p>Not Inserted(o)</p>
      <%
    }
      else
      {
        if(mname==null){
          %>
            <%@include file="orders.jsp"%>
            <p>select medicine</p>
          <%
      }
        else{
          Connection con4=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
          Statement st4=con4.createStatement();
          for(int i=0;i<mname.length;i++){
          ResultSet rs4=st4.executeQuery("select mid,stripprice from medicine where mname='"+mname[i]+"'");
          if(rs4.next())
          {
          mid[i]=rs4.getInt(1);
          cost[i]=rs4.getInt(2);
        }}
        Connection con5=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
        Statement st5=con5.createStatement();
        for(int i=0;i<mname.length;i++){
          qty1[i]=0;
        ResultSet rs5=st5.executeQuery("select sid,quantity from stock where mid='"+mid[i]+"'");
        while(rs5.next())
        {
          int s=rs5.getInt(1);
          int q=rs5.getInt(2);
          if(q!=0){
        sid[i]=s;
        qty1[i]=q;}
      }}
      %>
      <table style="margin-left:100px;">
      <tr>
      <td style="margin-top: 3%; font-size: 1.4rem; width:30px;">ID</td>  <td style="margin-top: 3%; font-size: 1.4rem; width:120px;">Name</td><td style="margin-top: 3%; font-size: 1.4rem;  margin-right:40px; width:150px">Quantity</td>
      <td style="margin-top: 3%; font-size: 1.4rem; margin-left:40px; text-align:center; width:80px;">Cost</td>
      <td style="margin-top: 3%; font-size: 1.4rem; margin-left:40px; text-align:center; width:80px;">Available</td>
      </tr>
    </table>
    <form action="confirmorder.jsp" method="post">
      <input style="display:none;" type="text" name="oid" value="<%=oid%>">
        <%for(int j=0;j<mname.length;j++){%>
        <table  style="margin-left:100px;">
              <tr>
              <td style="margin-top: 3%; font-size: 1.4rem; width:30px;"><%=mid[j]%>.</td>  <td style="margin-top: 3%; font-size: 1.4rem; width:120px;"><%=mname[j]%></td><td style="margin-top: 3%; font-size: 1.4rem;  margin-right:40px;"><input type="text" name="qty" min="1" max=<%=qty1[j]%>></td>
              <td style="margin-top: 3%; font-size: 1.4rem; text-align:center; width:80px;"><%=cost[j]%></td>
              <td style="margin-top: 3%; font-size: 1.4rem; text-align:center; width:80px;"><%=qty1[j]%></td>
              </tr>
            </table>
            <%}%>
            <%for(int j=0;j<mname.length;j++){%>
            <input style="display:none;" type="text" name="mname" value="<%=mname[j]%>">
            <input style="display:none;" type="text" name="mid" value="<%=mid[j]%>">
            <input style="display:none;" type="text" name="cost" value="<%=cost[j]%>">
            <input style="display:none;" type="text" name="stc" value="<%=qty1[j]%>">
            <input style="display:none;" type="text" name="sid" value="<%=sid[j]%>">
<%}%>
        <button type="submit" name="button">SUBMIT</button>
            </form>
    <% }}%>
