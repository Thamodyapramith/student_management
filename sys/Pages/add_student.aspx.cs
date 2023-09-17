using MySql.Data.MySqlClient;
using System;
namespace sys.Pages
{
    public partial class add_student : System.Web.UI.Page
    {
        private const string ConnectionString = "Server=localhost;Database=test;Uid=root;Pwd=root;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtMonthlyPaymentDay.Text = DateTime.Now.ToString("yyyy-MM-dd");

            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowLoading", "showLoading();", true);

            // Perform your data loading or processing here

            // Hide the loading animation after the process is complete
            string selectedDates = selectedDatesHiddenField.Value;

            if (string.IsNullOrEmpty(selectedDates))
            {
                // The string is either null or empty
                lbl.Text = "Please Select Booking Dates";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HideLoading", "hideLoading();", true);

            }
            else
            {
                string[] dateArray = selectedDates.Split(',');

                // Insert each date into the database with the associated student ID
                foreach (string dateStr in dateArray)
                {
                    DateTime date = DateTime.Parse(dateStr);
                    string stuid = txtId.Text;
                    // Insert the student ID and date into the database using MySQL INSERT statement
                    InsertDateIntoDatabase(stuid, date);
                }

                string studentId = txtId.Text;
                string name = txtName.Text;
                decimal monthlyFee = Convert.ToDecimal(txtMonthlyFee.Text);
                decimal annualFee = Convert.ToDecimal(txtAnnualFee.Text);
                DateTime monthlyPaymentDay = Convert.ToDateTime(txtMonthlyPaymentDay.Text);
                DateTime annualPaymentDay = Convert.ToDateTime(DateTime.Now);
                InsertStudentData(studentId, name, monthlyFee, monthlyPaymentDay, annualFee, annualPaymentDay, selectedDates);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HideLoading", "hideLoading();", true);
            }
        }
        protected void btnview_click(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudents.aspx");
        }
        private void InsertStudentData(string studentId, string name, decimal monthlyFee, DateTime monthlyPaymentDay, decimal annualFee, DateTime annualPaymentDay, string selectedDates)
        {

            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();
                try
                {
                    string query = "INSERT INTO Students (StudentId, Name, MonthlyFee, MonthlyPaymentDay,AnnualFee,AnnualFeeDate) VALUES (@StudentId, @Name, @MonthlyFee, @MonthlyPaymentDay,@AnnualFee,@AnnualFeeDate)";
                    MySqlCommand command = new MySqlCommand(query, connection);

                    command.Parameters.AddWithValue("@StudentId", studentId);
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@MonthlyFee", monthlyFee);
                    command.Parameters.AddWithValue("@MonthlyPaymentDay", monthlyPaymentDay);
                    command.Parameters.AddWithValue("@AnnualFee", annualFee);
                    command.Parameters.AddWithValue("@AnnualFeeDate", annualPaymentDay);

                    command.ExecuteNonQuery();
                    lbl.Text = "Added Successfully";
                    ClearTextboxes();
                }
                catch (Exception)
                {
                    lbl.Text = "Student ID Is Alredy Used";
                }
            }

        }
        private void ClearTextboxes()
        {
            txtId.Text = "";
            txtName.Text = "";
            txtMonthlyFee.Text = "";
            txtAnnualFee.Text = "";
            txtMonthlyPaymentDay.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
        private void InsertDateIntoDatabase(string stuid, DateTime date)
        {
            // Use MySQL data access code to insert the data into the database
            // Replace this with your actual MySQL database connection and query
            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();

                string query = "INSERT INTO StudentDates (id, Date) VALUES (@StudentID, @Date)";
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", stuid);
                    command.Parameters.AddWithValue("@Date", date);

                    command.ExecuteNonQuery();
                }
            }
        }

    }

}
