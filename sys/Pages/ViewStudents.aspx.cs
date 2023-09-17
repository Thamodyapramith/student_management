using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace sys.Pages
{
    public partial class ViewStudents : System.Web.UI.Page
    {
        private const string ConnectionString = "Server=localhost;Database=test;Uid=root;Pwd=root;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();

                string query = "SELECT StudentId, Name, MonthlyFee, MonthlyPaymentDay, AnnualFee, AnnualFeeDate FROM Students";
                MySqlCommand command = new MySqlCommand(query, connection);

                MySqlDataAdapter adapter = new MySqlDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                GridViewStudents.DataSource = dt;
                GridViewStudents.DataBind();
            }
        }

        protected void GridViewStudents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int rowIndex = e.NewEditIndex;
            string studentId = GridViewStudents.DataKeys[rowIndex]["StudentId"].ToString();
            Response.Redirect($"edit_student.aspx?edit=true&studentId={studentId}");
        }

        protected void GetStudentIdsFromGridView()
        {


            // Now you have a list of all student IDs in the GridView
            // You can use this list for further processing or operations
        }


        protected void GridViewStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string studentId = GridViewStudents.DataKeys[rowIndex]["StudentId"].ToString();

            DeleteStudentFromDatabase(studentId);
        }

        private void DeleteStudentFromDatabase(string studentId)
        {
            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();

                string query = "DELETE FROM Students WHERE StudentId = @StudentId";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@StudentId", studentId);

                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    BindGridView(); // Rebind the GridView to reflect the updated data
                }
                else
                {
                    // Handle deletion failure or show an error message
                }
            }
        }

        protected void GridViewStudents_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the cells containing the Monthly Payment Day and Annual Fee Payment Date values
                TableCell paymentDayCell = e.Row.Cells[3]; // Adjust the index based on your column order
                TableCell annualFeeDateCell = e.Row.Cells[5]; // Adjust the index based on your column order

                // Retrieve the Monthly Payment Day and Annual Fee Payment Date values from the cells
                string paymentDayText = paymentDayCell.Text;
                string annualFeeDateText = annualFeeDateCell.Text;

                DateTime thirtyDaysAgo = DateTime.Now.AddDays(-30);
                DateTime oneYearAgo = DateTime.Now.AddYears(-1);

                if (!string.IsNullOrEmpty(paymentDayText))
                {
                    DateTime paymentDate = Convert.ToDateTime(paymentDayText);

                    if (paymentDate < thirtyDaysAgo)
                    {
                        paymentDayCell.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (paymentDate >= thirtyDaysAgo && paymentDate <= DateTime.Now)
                    {
                        paymentDayCell.ForeColor = System.Drawing.Color.Green;
                    }
                }

                if (!string.IsNullOrEmpty(annualFeeDateText))
                {
                    DateTime annualFeeDate = Convert.ToDateTime(annualFeeDateText);

                    if (annualFeeDate < oneYearAgo)
                    {
                        annualFeeDateCell.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (annualFeeDate >= oneYearAgo && annualFeeDate <= DateTime.Now)
                    {
                        annualFeeDateCell.ForeColor = System.Drawing.Color.Green;
                    }
                }
            }
        }





    }
}
