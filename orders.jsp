<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.Date"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<html>
  <head>
    <title></title>
    <style>
      body {
           margin: 0;
           font-family: Arial, Helvetica, sans-serif;
         }
         h1 {
           margin-top: 4%;
           font-size: 2 rem;
           padding-left: 30%;
         }
         .topnav {
           padding-top: 1%;
           padding-right: 6%;
           overflow: hidden;
           background-color: #8abaae;
         }
         .topnav a {
           float: left;
           color: black;
           text-align: center;
           padding: 14px 16px;
           text-decoration: none;
           font-size: 1.35rem;
         }
         .topnav a.active {
           color: white;
         }
         .topnav-right {
           float: right;
         }
         .t1{
           margin-top: 40px;
           margin-bottom: 25px;
           margin-left: 65px;
         }
         .t1 input{
           margin-right: 12px;
         }
         input
         {
           font-size: 1.3rem;
         }
         td{
           font-size: 1.2rem;
         }
         button{
           font-size: 1.3rem;
           margin-top: 1%;
           margin-bottom: 1%;
           padding: 1% 0;
           width:14.6rem;
           background-color: #8abaae;
           border-radius: 0.1rem;
           border: none;
         }
         .btn {
           width:110px;
           float: right;
           padding: 0.6%;
           margin-right: 20px;
         }
         h2{
           position: absolute;
           left: 20px;
         }
         h3{
           position: absolute;
           top:60px;
           left:73px;
         }
         .med{
           margin: 0 70px;
           display: block;
         }
         p{
           font-size: 1.3rem;
           margin-right: 25px;
           margin-bottom: 25px;
           display: inline-block;
         }
         .in{
           display: inline-block;
         }
    </style>
  </head>
  <body>
    <h2>Add</h2>
    <div class="topnav">
          <div class="topnav-right">
            <a href="product.html">Medicine</a>
            <a href="stock.html">Stock</a>
            <a href="emp.html">Employee</a>
            <a class="active" href="orders.jsp">Order</a>
            <a href="supplier.html">Supplier</a>
          </div>
        </div>
        <form class="" action="index.html" method="post">
          <button class="btn" name="button">Logout</button>
        </form>
        <center>
          <h3><%
        SimpleDateFormat formatter1 = new SimpleDateFormat("dd/MM/yyyy");
         out.println(formatter1.format(new Date()));
         %></h3>
        <%
        int size=0;
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tejasree");
        Statement st3=con.createStatement();
        ResultSet rs3=st3.executeQuery("select count(*) from medicine where mid in (select mid from stock)");
        if(rs3.next())
        {
        size=rs3.getInt(1);
        }
        String[] medname=new String[size];
        int i=0;
        Statement st4=con.createStatement();
        ResultSet rs4=st4.executeQuery("select mid,mname from medicine");
        while(rs4.next()&&i<size)
        {
          medname[i]=rs4.getString(2);
          i++;
        }
        %>
      </center>
        <form action="placeorder.jsp" method="post">
          <table class="t1">
            <tr>
              <td>Name:</td><td><input type="text" name="cname" required></td>
              <td>PhoneNo:</td><td><input type="text" pattern=[0-9]{10} name="phno" required></td>
              <td>Doctor:</td><td><input type="text" name="dname" ></td>
              <td>Hospital:</td><td><input type="text" name="hname" ></td>
            </tr>
          </table>
          <div class="med">
            <%for(int j=0;j<size;j++){%>
            <input class="in" type="checkbox" name="mname" value="<%=medname[j]%>"></td>
<p>
<%=medname[j]%>
</p></td>

              <%}%>
              <table>
                <tr>
                  <td><button type="submit" name="button">Add</button></td>
                </tr>
              </table>
          </div>
        </form>
  </body>
</html>
