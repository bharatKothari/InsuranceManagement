<!--
=========================================================
 Material Dashboard - v2.1.1
=========================================================

 Product Page: https://www.creative-tim.com/product/material-dashboard
 Copyright 2019 Creative Tim (https://www.creative-tim.com)
 Licensed under MIT (https://github.com/creativetimofficial/material-dashboard/blob/master/LICENSE.md)

 Coded by Creative Tim

=========================================================

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. -->

<%@ page import="java.sql.*" %>

<%ResultSet resultset =null;%>
<%
    try{
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection connection = 
         DriverManager.getConnection
            ("jdbc:mysql://localhost:3306/insurance","root","very_strong_password");

       Statement statement = connection.createStatement() ;

       resultset =statement.executeQuery("select agentID,nomineeName,nomineeID,startDate,payment_interval,cover,clientName,description,policy.status,premium from nominee,policy,client,claim where claim.policyNumber=policy.policyNumber and policy.clientID=client.clientID and policy.nomineeID=nominee.aadhaar and claimID="+session.getAttribute("claimID"));
       resultset.next();
%>

<!doctype html>
<html lang="en">

<head>
  <title>Hello, world!</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
  <!-- Material Kit CSS -->
  <link href="../assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
</head>

<body>
  <div class="wrapper ">
    <div class="sidebar" data-color="purple" data-background-color="white">
      <!--
      Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

      Tip 2: you can also add an image using data-image tag
  -->
       <div class="logo">
        <a href="http://www.creative-tim.com" class="simple-text logo-normal">
          Creative Tim
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="./dashboard.html">
              <p>Dashboard</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="./user.jsp">
              <p>All Clients</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="./viewPlans.jsp">
              <p>Plan list</p>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="./typography.html">
              <p>Add New Agent</p>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/admin/addPlan">
              <p>Add New Plan</p>
            </a>
          </li>
         <li class="nav-item active">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/admin/viewClaims">
              <p>Requested Claims</p>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/admin/logout">
              <p>Logout</p>
            </a>
          </li>
        </ul>
      </div>
    </div>
    <div class="main-panel">
    
  
 <div class="content">
    <div class="container-fluid">

  <div class="row">
   <div class="col-md-4">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><p class="h3">Policy Snapshot</p></h4>
         </div>
        <div class="card-body">

        <ul>
          <li><p class="h3 text-danger">Cover:</p>
          <p class="h3"><%=resultset.getString("cover")%></p></li>
          <li><p class="h3 text-danger">Policy Holder:</p>
          <p class="h3"><%=resultset.getString("clientName")%></p></li>
          <li><p class="h3 text-danger">Policy Status:</p> 
          <p class="h3"><%=resultset.getString("status")%></p></li>
          
        </ul>

        </div>
        </div>
      </div>
        <div class="col-md-8">
    <div class="card">
        <div class="card-header card-header-primary">
            <h4 class="card-title"><p  class="h3">Policy Details</p></h4>
        </div>
        <div class="card-body">
            <div class="row">
             <div class="col-md-6">
                <ul>
                <li><p class="h3 text-danger">Premium Amount</p>
                <p class="h3"><%=resultset.getString("premium")%></p></li>
                <li><p class="h3 text-danger">Policy Start Date</p>
                <p class="h3"><%=resultset.getString("startDate")%></p></li>
                <li><p class="h3 text-danger">Nominee</p> 
                <p class="h3"><%=resultset.getString("nomineeName")%></p></li>
              </ul>
             </div>
              <div class="col-md-6">
                <ul>
                <li><p class="h3 text-danger">Payment Interval</p>
                <p class="h3"><%=resultset.getString("payment_interval")%></p></li>
                <li><p class="h3 text-danger">Nominee Aadhaar Id</p> 
                <p class="h3"><%=resultset.getString("nomineeID")%></p></li>
                <li><p class="h3 text-danger">Agent ID</p>
                <p class="h3"><%=resultset.getString("agentID")%></p></li>
              </ul>
             </div>
           </div>

          
      </div>
      </div>

</div>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">Reason For Claim</h2>
        <p class="category">Description</p>
      </div>
      <div class="card-body">
        <form method="post">
          <div class="row">
  		<div class="col-md-10">
       <%= resultset.getString("description")%>
      </div>
  		<div class="col-md-2">
         <button type="submit" formaction="http://localhost:8080/InsuranceManagement/admin/acceptClaim" class="btn pull-right" style="background-color:green">Accept</button>
                    <div class="clearfix"></div>
         <button type="submit" formaction="http://localhost:8080/InsuranceManagement/admin/rejectClaim" class="btn pull-right" style="background-color:red">Reject</button>
                    <div class="clearfix"></div>
                  </div>
                </div>
                  </form>
      </div>

    </div>
  </div>
</div>
</div>

      <footer class="footer">
        <div class="container-fluid">
          <nav class="float-left">
            <ul>
              <li>
                <a href="https://www.creative-tim.com">
                  Creative Tim
                </a>
              </li>
            </ul>
          </nav>
          <div class="copyright float-right">
            &copy;
            <script>
              document.write(new Date().getFullYear())
            </script>, made with <i class="material-icons">favorite</i> by
            <a href="https://www.creative-tim.com" target="_blank">Creative Tim</a> for a better web.
          </div>
          <!-- your footer here -->
        </div>
      </footer>
    </div>
  </div>
</body>
<style >
  ul {
  list-style-type: none;
  
} 

   
        li  {
border-bottom: 1px solid;  
border-color: blue; 
} 
</style>

</html>
<%
//**Should I input the codes here?**
        }
        catch(Exception e)
        {
             out.println("wrong entry"+e);
        }
%>