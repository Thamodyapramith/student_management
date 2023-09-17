using MySql.Data.MySqlClient;
using System;

namespace sys.Pages
{
    public partial class pay_year : System.Web.UI.Page
    {
        private const string ConnectionString = "Server=localhost;Database=test;Uid=root;Pwd=root;";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            UpdateStudentData();
        }

        protected void txtid_TextChanged(object sender, EventArgs e)
        {
            LoadStudentData();
        }


        private void LoadStudentData()
        {

            string selectedStudentId = txtId.Text;
            // Fetch student data based on selectedStudentId from the database
            // Example: DataRow studentRow = YourDataAccessLayer.GetStudentById(selectedStudentId);

            // Assuming you have a SQLDataReader called reader
            // Make sure to replace "your_connection_string" with your actual connection string
            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                connection.Open();
                string query = "SELECT * FROM students WHERE StudentId ='" + selectedStudentId + "'";
                MySqlCommand command = new MySqlCommand(query, connection);
                object result = command.ExecuteScalar();

                {
                    MySqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        txtName.Text = reader["Name"].ToString(); // Change to actual field name
                        txtMonthlyFee.Text = reader["MonthlyFee"].ToString(); // Change to actual field name

                        //txtAnnualFeeDate.Text = reader["AnnualFeeDate"].ToString(); // Change to actual field name

                        if (reader["MonthlyPaymentDay"] != DBNull.Value)
                        {
                            DateTime annualFeeDate = Convert.ToDateTime(reader["AnnualFeeDate"]);
                            txtMonthlyPaymentDay.Text = annualFeeDate.ToString("yyyy-MM-dd");
                        }

                        txtAnnualFeeDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Default payment date
                    }
                    reader.Close();
                }
            }
        }

        private void UpdateStudentData()
        {
            string selectedStudentId = txtId.Text;
            string monthlyfee = txtAnnualFee.Text;
            string monthlyfeeday = txtAnnualFeeDate.Text;


            using (MySqlConnection connection = new MySqlConnection(ConnectionString))
            {
                string query = "UPDATE students SET AnnualFeeDate = @MonthlyPaymentDay, AnnualFee = @Monthlyfee WHERE StudentId = @StudentId";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@MonthlyPaymentDay", monthlyfeeday);
                command.Parameters.AddWithValue("@Monthlyfee", monthlyfee);
                command.Parameters.AddWithValue("@StudentId", selectedStudentId);

                try
                {
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Update successful
                        // You can redirect to a confirmation page or perform other actions
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