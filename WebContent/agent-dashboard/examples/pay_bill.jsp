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
<%ResultSet rs =null;%>
<%
    try{
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection connection = 
         DriverManager.getConnection
            ("jdbc:mysql://localhost:3306/insurance","root","very_strong_password");

    Statement statement = connection.createStatement() ;
		Statement statement1 = connection.createStatement() ;
    resultset = statement.executeQuery("select calculate_due_premium("+session.getAttribute("policyNumber")+")");
		rs = statement1.executeQuery("select calculate_late_fee("+session.getAttribute("policyNumber")+")");
		rs.next();
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
        <a href="http://www.creative-tim.com" class="simple-text logo-mini">
          CT
        </a>
        <a href="http://www.creative-tim.com" class="simple-text logo-normal">
          Creative Tim
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent">
              <p>Dashboard</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/clients">
              <p>MY CLIENTS</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/viewPlans">
              <p>PLANS</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/addClient">
              <p>ADD NEW CLIENT</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/calculatePremium">
              <p>ADD NEW POLICY</p>
            </a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/addPayment">
              <p>ADD PAYMENT</p>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="http://localhost:8080/InsuranceManagement/agent/logout">
              <p>LOGOUT</p>
            </a>
          </li>
        </ul>
      </div>
    </div>
    <div class="main-panel">
      <!-- Navbar -->
      <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top ">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <a class="navbar-brand" href="#pablo">Dashboard</a>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
            <span class="sr-only">Toggle navigation</span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
            <span class="navbar-toggler-icon icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link" href="#pablo">
                  <i class="material-icons">notifications</i> Notifications
                </a>
              </li>
              <!-- your navbar here -->
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
 <div class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-8">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">Make Payment</h4>
                </div>
                <div class="card-body">
                  <form method="post" action="http://localhost:8080/InsuranceManagement/agent/checkDues">

                  <div class="row">
             <div class="col-md-4">
                <ul>
                <li><p class="h3 text-danger">Policy ID:<%= session.getAttribute("policyNumber") %></p></li>
               
              </ul>
             </div>
              <div class="col-md-4">
                <ul>
                  <br>
                  <br>
                  <br>
                <li><p class="h3 ">Premium:</p></li>
                <li><p class="h3 ">Late Fee:</p></li>
                  <br>
                  
                <li><p class="h3 text-danger">Total Due:</p></li> 
              </ul>
             </div>
              <div class="col-md-4">
                <ul>
                  <br>
                  <br>
                  <br>
                <li><p class="h3 " align="centre"><%= resultset.getInt(1)%></p></li>
                <li><p class="h3 " align="centre"><%= rs.getInt(1)%><br>___________</p></li>
                <li><p class="h3 text-danger" align="centre"><%= resultset.getInt(1)+ rs.getInt(1)%></p></li> 
             </div>
           </div>
                    
                         

                    <button type="submit" class="btn btn-primary pull-right">PAY</button>
                    <div class="clearfix"></div>		
                  </form>
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
