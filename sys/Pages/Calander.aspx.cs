using MySql.Data.MySqlClient; // Import MySQL library
using System;
using System.Collections.Generic;

namespace sys
{
    public partial class About : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch data from MySQL and prepare it for FullCalendar
                string connectionString = "Server=localhost;Database=test;Uid=root;Pwd=root;"; // Replace with your MySQL connection string
                List<object> events = GetDataFromMySQL(connectionString);

                // Serialize the data to JSON format
                string eventData = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(events);

                // Render the JavaScript to initialize FullCalendar
                string script = $@"
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {{
                            var calendarEl = document.getElementById('calendar');
                            var calendar = new FullCalendar.Calendar(calendarEl, {{
                                initialView: 'dayGridMonth',
                                height: '100%',
                                events: {eventData} // Pass the data to FullCalendar
                            }});
                            calendar.render();
                        }});
                    </script>";

                // Inject the FullCalendar JavaScript into the page
                Page.ClientScript.RegisterStartupScript(GetType(), "FullCalendarScript", script);
            }
        }

        private List<object> GetDataFromMySQL(string connectionString)
        {
            List<object> events = new List<object>();

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();

                using (MySqlCommand command = new MySqlCommand("SELECT id, date FROM studentdates", connection))
                {
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string id = reader["id"].ToString();
                            DateTime date = Convert.ToDateTime(reader["date"]);

                            // Convert date to ISO 8601 format (required by FullCalendar)
                            string isoDate = date.ToString("yyyy-MM-dd");

                            // Create an event object and add it to the list
                            events.Add(new { title = id, start = isoDate });
                        }
                    }
                }
            }

            return events;
        }
    }
}
