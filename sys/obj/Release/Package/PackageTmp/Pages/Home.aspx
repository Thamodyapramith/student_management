<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="sys.Pages.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        /* Add a background color to the body */
        body {
            background-color: #ffffff; /* Change to the desired color */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div classWelcome !er h-100">
            <div class="row h-100 justify-content-center align-items-center">
                <div class="col-md-6 text-center">
                    <h1>Welcome ! </h1>
                    <a href="add_student.aspx" class="btn btn-primary btn-block mb-3">Add Students</a>
                    <a href="ViewStudents.aspx" class="btn btn-primary btn-block mb-3">View Students</a>                 
                    <a href="pay_month.aspx" class="btn btn-success btn-block mb-3">Pay Monthly Fee</a>
                    <a href="pay_year.aspx" class="btn btn-warning btn-block mb-3">Pay Yearly Membership</a>
                    <a href="Calander.aspx" class="btn btn-secondary btn-block mb-3" target="_blank">Calander</a>               

                </div>
            </div>
        </div>
    </form>
</body>
</html>
