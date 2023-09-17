<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pay_year.aspx.cs" Inherits="sys.Pages.pay_year" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pay Monthly Fee</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h1 class="mb-4">Pay Yearly Membership</h1>
            <div class="form-group">
                <label for="txtId">Student ID:</label>
<%--                <asp:TextBox ID="txtId" runat="server" CssClass="form-control" TextMode ="Number" OnTextChanged ="txtId_TextChanged"></asp:TextBox>--%>
                <asp:TextBox ID="txtId" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtid_TextChanged"></asp:TextBox>

            </div>
            <div class="form-group">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ReadOnly ="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtMonthlyFee">Monthly Fee:</label>
                <asp:TextBox ID="txtMonthlyFee" runat="server" CssClass="form-control" ReadOnly ="true" TextMode ="Number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtMonthlyPaymentDay">Monthly Payment Day:</label>
                <asp:TextBox ID="txtMonthlyPaymentDay" runat="server" CssClass="form-control" ReadOnly ="true" TextMode ="date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtAnnualFee">Annual Fee:</label>
                <asp:TextBox ID="txtAnnualFee" runat="server" CssClass="form-control" TextMode ="Number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtAnnualFeeDate">Annual Fee Date:</label>
                <asp:TextBox ID="txtAnnualFeeDate" runat="server" CssClass="form-control" TextMode ="date"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
    <a href="Home.aspx" class="btn btn-primary">Home</a>
            </div>
            <div class="form-group">
         
    <asp:Label ID="lbl" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
</div>
        </div>
    </form>
        </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

