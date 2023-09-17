using MySql.Data.MySqlClient;
using System;

namespace sys.Pages
{
    public partial class edit_student : System.Web.UI.Page
    {
        private const string ConnectionString = "Server=localhost;Database=test;Uid=root;Pwd=root;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // Check if the studentId key exists in the POST data
                if (Request.QueryString["studentId"] != null)
                {
                    string studentId = Request.QueryString["studentId"];
                    txtId.Text = studentId;

                    // Fetch data from the database based on the student ID
                    PopulateStudentData(studentId);
                }
            }
        }

        private void PopulateStudentData(string studentId)
        {
            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();

                string query = "SELECT * FROM Students WHERE StudentId = @StudentId";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@StudentId", studentId);

                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate other controls with data from the reader
                        txtName.Text = reader["Name"].ToString();
                        txtMonthlyFee.Text = reader["MonthlyFee"].ToString();
                        string day = reader["MonthlyPaymentDay"].ToString();
                        if (reader["MonthlyPaymentDay"] != DBNull.Value)
                        {
                            DateTime dateTime = DateTime.Parse(day);

                            txtMonthlyPaymentDay.Text = dateTime.ToString("yyyy-MM-dd");
                        }
                        if (reader["AnnualFeeDate"] != DBNull.Value)
                        {
                            DateTime annualFeeDate = Convert.ToDateTime(reader["AnnualFeeDate"]);
                            txtAnnualFeeDate.Text = annualFeeDate.ToString("yyyy-MM-dd");
                        }
                        txtAnnualFee.Text = reader["AnnualFee"].ToString();
                        ddlbatch.SelectedValue = reader["batch"].ToString();
                        // Populate other controls as needed
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            UpdateStudentData();
        }
        private void UpdateStudentData()
        {
            string selectedStudentId = txtId.Text;
            string name = txtName.Text;
            string monthlyfee = txtMonthlyFee.Text;
            string monthlyfeeday = txtMonthlyPaymentDay.Text;
            string annualfee = txtAnnualFee.Text;
            string annualfeeday = txtAnnualFeeDate.Text;
            string batch = ddlbatch.SelectedValue;


            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                string query = "UPDATE students SET MonthlyPaymentDay = @MonthlyPaymentDay, MonthlyFee = @Monthlyfee, Name = @Nme, AnnualFee = @AnnualFee, AnnualFeeDate = @AnnualFeeDay, batch = @batch WHERE StudentId = @StudentId";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@MonthlyPaymentDay", monthlyfeeday);
                command.Parameters.AddWithValue("@Monthlyfee", monthlyfee);
                command.Parameters.AddWithValue("@StudentId", selectedStudentId);
                command.Parameters.AddWithValue("@Nme", name);
                command.Parameters.AddWithValue("@AnnualFee", annualfee);
                command.Parameters.AddWithValue("@AnnualFeeDay", annualfeeday);
                command.Parameters.AddWithValue("@batch", batch);


                try
                {
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ClearTextboxes();
                        lbl.Text = "Paid Successfully";
                    }
                    else
                    {
                        lbl.Text = "Failed";

                        // Update failed
                    }
                }
                catch (Exception)
                {
                    // Handle exception
                }
            }

        }

        private void ClearTextboxes()
        {
            txtId.Text = "";
            txtName.Text = "";
            txtMonthlyFee.Text = "";
            txtMonthlyPaymentDay.Text = "";
            txtAnnualFee.Text = "";
            txtAnnualFeeDate.Text = "";
        }

    }
}