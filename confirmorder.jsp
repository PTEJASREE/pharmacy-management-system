<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"  %>
<head>
  <style media="screen">
    body td{
      font-size: 1.4rem;
    }
    body{
      font-size: 1.4rem;
    }
    #c{
      display: none;
    }
  </style>
</head>
<center>
<%
int oid=Integer.valueOf(request.getParameter("oid"));
String[] mn=request.getParameterValues("mname");
String[] mid=request.getParameterValues("mid");
String[] sid=request.getParameterValues("sid");
String[] q=request.getParameterValues("qty");
String[] c=request.getParameterValues("cost");
String[] qty1=request.getParameterValues("stc");
int s=mn.length;
int qty[]=new int[s];
int cost[]=new int[s];
for(int i=0;i<mn.length;i++)
{
  qty[i]=Integer.valueOf(q[i]);
  cost[i]=Integer.valueOf(c[i]);
}
int amt=0;
%>
<table style="border:1px solid black; border-collapse:collapse;">
  <tr>
    <td width=120>Medicine</td>
    <td width=120>Cost(strip)</td>
    <td width=30>Quantity</td>
  </tr>
</table><%
for(int i=0;i<mn.length;i++){
  amt+=qty[i]*cost[i];
%>
<table>
  <tr>
    <td width=120><%=mn[i]%></td>
    <td width=120>:<%=cost[i]%></td>
    <td width=30><%=qty[i]%></td>
  </tr>
<%}%>
</table>
<hr>
<table>
  <tr>
    <td width=120>Total Cost</td><td>:Rs.<%=amt%></td>
  </tr>
</table>
<form class="" action="complorder.jsp" method="post">
  <input style="display:none;" type="text" name="oid" value="<%=oid%>">
  <input style="display:none;" type="text" name="amt" value="<%=amt%>">
<%for(int j=0;j<s;j++){%>
<input style="display:none;" type="text" name="mname" value="<%=mn[j]%>">
<input style="display:none;" type="text" name="mid" value="<%=mid[j]%>">
<input style="display:none;" type="text" name="sid" value="<%=sid[j]%>">
<input style="display:none;" type="text" name="qty" value="<%=qty[j]%>">
<input style="display:none;" type="text" name="stc" value="<%=qty1[j]%>">
<%}%>
pay through:
<select id="sel" name="type" >
<option value="cash">cash</option>
<option value="cheque">cheque</option>
<option value="card">card</option>
</select>
<button type="submit" name="button">PAY</button>
</form>
<script type="text/javascript">
  function s(){
    var t=document.getElementById("sel").value;
    if(t==="card")
    {
      document.getElementById("c").style.display="block";
    }
  }
</script>
