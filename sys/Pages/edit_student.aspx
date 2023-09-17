<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_student.aspx.cs" Inherits="sys.Pages.edit_student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Student Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
</style>
    <style>
    .loading-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
        display: none; /* Hide by default */
        z-index: 1000; /* Ensure it's above other content */
    }

    .loading-spinner {
        border: 4px solid #f3f3f3; /* Light gray border */
        border-top: 4px solid #3498db; /* Blue border on top for animation */
        border-radius: 50%;
        width: 40px;
        height: 40px;
        animation: spin 2s linear infinite; /* Apply rotation animation */
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>
<script>
    function showLoading() {
        document.getElementById("loading-overlay").style.display = "block";
    }

    function hideLoading() {
        document.getElementById("loading-overlay").style.display = "none";
    }
</script>

</head>
<body>
    <div id="loading-overlay" class="loading-overlay">
    <div class="loading-spinner"></div>
</div>
    

    <form id="form1" runat="server">
        <div class="container mt-5">
            <h1 class="mb-4">Edit Student Details</h1>
            <div class="form-group">
                <label for="txtId">Student ID:</label>
                <asp:TextBox ID="txtId" runat="server" CssClass="form-control"  ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="txtId"
    ErrorMessage="ID is required" Display="Dynamic" ForeColor="Red" />

            </div>
                        <div class="form-group">
                <label for="txtbatch">Batch:</label>
                            <asp:DropDownList ID="ddlbatch" runat="server" CssClass="form-control">
                                <asp:ListItem>Monday</asp:ListItem>
                                <asp:ListItem> Tuesday</asp:ListItem>
                                <asp:ListItem> Wednesday</asp:ListItem>
                                <asp:ListItem> Thursday</asp:ListItem>
                                <asp:ListItem> Friday</asp:ListItem>
                                <asp:ListItem> Saturday</asp:ListItem>
                                <asp:ListItem>Sunday</asp:ListItem>
                            </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvbatch" runat="server" ControlToValidate="ddlbatch"
    ErrorMessage="Batch is required" Display="Dynamic" ForeColor="Red" />

            </div>
            <div class="form-group">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
ErrorMessage="Name is required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <label for="txtMonthlyFee">Monthly Fee:</label>
                <asp:TextBox ID="txtMonthlyFee" runat="server" CssClass="form-control" TextMode ="Number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqvMonthlyFee" runat="server" ControlToValidate="txtMonthlyFee"
ErrorMessage="Monthly Payment required" Display="Dynamic" ForeColor="Red" />

            </div>
            <div class="form-group">
                <label for="txtMonthlyPaymentDay">Monthly Payment Day:</label>
                <asp:TextBox ID="txtMonthlyPaymentDay" runat="server" CssClass="form-control" TextMode ="date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rqfMonthlyDay" runat="server" ControlToValidate="txtMonthlyPaymentDay"
ErrorMessage="Monthly Payment Day required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <label for="txtAnnualFee">Annual Fee:</label>
                <asp:TextBox ID="txtAnnualFee" runat="server" CssClass="form-control" TextMode ="Number"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvAnnualFee" runat="server" ControlToValidate="txtAnnualFee"
ErrorMessage="Annual Fee Payment required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <label for="txtAnnualFeeDate">Annual Fee Date:</label>
                <asp:TextBox ID="txtAnnualFeeDate" runat="server" CssClass="form-control" TextMode ="date"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="rfvAnnualFeeDay" runat="server" ControlToValidate="txtAnnualFeeDate"
ErrorMessage="Annual Fee Day required" Display="Dynamic" ForeColor="Red" />
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