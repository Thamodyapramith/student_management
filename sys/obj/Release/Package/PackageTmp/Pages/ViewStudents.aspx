<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudents.aspx.cs" Inherits="sys.Pages.ViewStudents" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Students</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
   <script type="text/javascript">
       function confirmDelete(Name) {
           return confirm("Are you sure you want to delete the student with ID " + Name + "?");
       }
   </script>
    <style>
    .bold-cell {
        font-weight: bold;
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h1 class="mb-4">View Students</h1>
        <asp:GridView ID="GridViewStudents" runat="server" CssClass="table table-bordered"
    OnRowEditing="GridViewStudents_RowEditing" OnRowDeleting="GridViewStudents_RowDeleting"
    AutoGenerateColumns="False" OnRowDataBound="GridViewStudents_RowDataBound" DataKeyNames ="StudentId">

                <Columns>
                    <asp:BoundField DataField="StudentId" HeaderText="Student Id" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="MonthlyFee" HeaderText="Monthly Fee" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="MonthlyPaymentDay" HeaderText="Last Monthly Fee Payment" ItemStyle-CssClass="bold-cell" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="AnnualFee" HeaderText="Annual Fee" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="AnnualFeeDate" HeaderText="Last Annual Fee Payment" ItemStyle-CssClass="bold-cell" DataFormatString="{0:d}" />
<%--                    <asp:ButtonField ButtonType="Button" Text="Edit" CommandName="Edit" ControlStyle-CssClass="btn btn-primary" />--%>
<%--                    <asp:ButtonField ButtonType="Button" Text="Delete" CommandName="Delete" OnClientClick="return confirmDelete();" ControlStyle-CssClass="btn btn-danger" />--%>
                <asp:TemplateField>
        <ItemTemplate>
            <asp:Button ID="btnDelete" runat="server" Text="Delete"
                CommandName="Delete" class="btn btn-danger" OnClientClick='<%# "return confirmDelete(" + Eval("StudentId") + ");" %>' />
            <a href='<%# "edit_student.aspx?action=edit&studentId=" + Eval("StudentId") %>' class="btn btn-primary">Edit</a>
        </ItemTemplate>
    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="mt-4">
    <a href="Home.aspx" class="btn btn-primary">Home</a>
</div>
        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
