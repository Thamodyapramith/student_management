<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_student.aspx.cs" Inherits="sys.Pages.add_student" MasterPageFile="~/Site.master" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Student Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js' rel='stylesheet' />

    <style>
        /* Your custom CSS styles here */
        body {
            background-color: #ffffff;
        }

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

        .selected-date {
            background-color: #3498db; /* Change the background color as needed */
            color: white; /* Change the text color as needed */
        }
        #calendar {
        max-height: 400px; /* Adjust the max height as needed */
        overflow-y: auto; /* Add a vertical scrollbar if necessary */
    }
        .input {
  color: #fff;
  font-size: 0.9rem;
  background-color: transparent;
  width: 100%;
  box-sizing: border-box;
  padding-inline: 0.5em;
  padding-block: 0.7em;
  border: none;
  border-bottom: var(--border-height) solid var(--border-before-color);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.input-border {
  position: absolute;
  background: var(--border-after-color);
  width: 0%;
  height: 2px;
  bottom: 0;
  left: 0;
  transition: width 0.3s cubic-bezier(0.6, -0.28, 0.735, 0.045);
}

.input:focus {
  outline: none;
}

.input:focus + .input-border {
  width: 100%;
}

.form-control {
  position: relative;
  --width-of-input: 300px;
}

.input-alt {
  font-size: 1.2rem;
  padding-inline: 1em;
  padding-block: 0.8em;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.input-border-alt {
  height: 3px;
  background: linear-gradient(90deg, #FF6464 0%, #FFBF59 50%, #47C9FF 100%);
  transition: width 0.4s cubic-bezier(0.42, 0, 0.58, 1.00);
}

.input-alt:focus + .input-border-alt {
  width: 100%;
}
.form {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  position: relative;
  width: 400px;
  padding: 50px;
  height: 500px;
  background-color: rgb(0, 0, 0);
  border-radius: 10px;
}

.inputContainer {
  background-color: rgba(255, 0, 0, 0);
  position: relative;
  width: 100%;
  height: 50px;
}

.fInput {
  width: 100%;
  height: 50px;
  border-radius: 3px;
  border: 1px solid rgb(48, 45, 45);
  background-color: black;
  padding: 10px;
  color: white;
  transition: .1s;
  position: absolute;
}

.fInput:focus {
  border: 1px rgb(0, 136, 255) solid;
  outline: none;
}

.fInput:focus::placeholder {
  color: rgb(0, 136, 255);
}

.fInput.email {
  z-index: 1;
}

.fInput.pass:focus {
  z-index: 2;
}

.submit {
  width: 100%;
  top: 60px;
  padding: 7px 0;
  border-radius: 20px;
  cursor: pointer;
  transition: .3s;
  position: absolute;
}

.submit:focus + .email {
  display: none;
}

.login {
  width: 100%;
  color: white;
  font-family: sans-serif;
  font-weight: 700;
  font-size: 20px;
  padding: 30px 0;
  position: absolute;
  top: 90px;
  left: 55px
}

.submit:hover {
  opacity: .9;
}

.forget {
  width: 100%;
  background-color: transparent;
  color: white;
  border: 1PX solid rgba(255, 255, 255, 0.151);
  margin-top: 15px;
  padding: 7px 0;
  border-radius: 20px;
  cursor: pointer;
  transition: .3s;
  margin-top: 50px;
}

.forget:hover {
  background-color: rgba(255, 255, 255, 0.151);
}

.con {
  display: flex;
  justify-content: flex-start;
  width: 100%;
  margin-top: 30px;
  color: rgb(111, 103, 103);
  font-size: 13px;
  font-family: sans-serif;
  background-color: rgba(255, 0, 0, 0);
}

.con a {
  color: rgb(0, 136, 255);
}
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Include FullCalendar JavaScript -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>

    <script>
        function showLoading() {
            document.getElementById("loading-overlay").style.display = "block";
        }

        function hideLoading() {
            document.getElementById("loading-overlay").style.display = "none";
        }

        // Define a global array to store selected dates
        var selectedDates = [];

        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var selectedDatesHiddenField = document.getElementById('<%= selectedDatesHiddenField.ClientID %>');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                selectable: true,
                select: function (info) {
                    // This function is called when a date is selected
                    var selectedDate = info.startStr; // The selected date in string format
                    toggleSelectedDate(selectedDate); // Toggle the selected date
                    console.log('Selected date: ' + selectedDate);
                    selectedDatesHiddenField.value = selectedDates.join(', ');

                },
                dayRender: function (info) {
                    // Check if the date is in the selectedDates array
                    var dateStr = info.date.toISOString().split('T')[0];
                    if (selectedDates.includes(dateStr)) {
                        info.el.classList.add('selected-date');
                    }
                }
            });

            calendar.render();

            /* Add a button to get selected dates as a string*/
            var getSelectedDatesBtn = document.createElement('button');
            getSelectedDatesBtn.textContent = 'Get Selected Dates';
            getSelectedDatesBtn.addEventListener('click', function () {
                var selectedDatesStr = selectedDates.join(', '); // Join selected dates into a string
                alert('Selected Dates: ' + selectedDatesStr);
            });

            //document.getElementById('calendar').appendChild(getSelectedDatesBtn);

            // Define a global array to store selected dates
            var selectedDates = [];

            function toggleSelectedDate(dateStr) {
                var index = selectedDates.indexOf(dateStr);
                if (index === -1) {
                    // Date is not selected, so add it
                    selectedDates.push(dateStr);
                } else {
                    // Date is already selected, so remove it
                    selectedDates.splice(index, 1);
                }

                // Update the calendar to reflect the selection change
                updateCalendar();
            }

            function updateCalendar() {
                calendar.removeAllEvents(); // Remove all events from the calendar

                // Add events for the selected dates
                selectedDates.forEach(function (dateStr) {
                    calendar.addEvent({
                        title: 'Selected Date',
                        start: dateStr,
                        className: 'selected-date' // Apply the CSS class
                    });
                });
            }
        });

    </script>
</head>
<body>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="loading-overlay" class="loading-overlay">
        <div class="loading-spinner"></div>
    </div>

    <form id="form1" runat="server">
        <div class="container mt-5">
            <h1 class="mb-4">Add Student Details</h1>
            <div class="form-group">
                <label for="txtId">Student ID:</label>

                <asp:TextBox ID="txtId" runat="server" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="txtId"
                    ErrorMessage="ID is required" Display="Dynamic" ForeColor="Red" />
            </div>


            <div class="form-group">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <label for="txtMonthlyFee">Monthly Fee:</label>
                <asp:TextBox ID="txtMonthlyFee" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqvMonthlyFee" runat="server" ControlToValidate="txtMonthlyFee"
                    ErrorMessage="Monthly Payment required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtMonthlyPaymentDay" Visible="false" runat="server" CssClass="form-control" TextMode="date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqfMonthlyDay" runat="server" ControlToValidate="txtMonthlyPaymentDay"
                    ErrorMessage="Monthly Payment Day required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                <label for="txtAnnualFee">Annual Membership Payment:</label>
                <asp:TextBox ID="txtAnnualFee" Visible="true" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rqfAnnualFee" runat="server" ControlToValidate="txtAnnualFee"
                    ErrorMessage="Annual Membership Payment required" Display="Dynamic" ForeColor="Red" />
            </div>
            <div class="form-group">
                                <label for="calendar">Booking Dates:</label>
                        <div id='calendar'></div>

            </div>
            <asp:HiddenField ID="selectedDatesHiddenField" runat="server" />


            
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                <a href="Home.aspx" class="btn btn-primary">Home</a>
            </div>
            <div class="form-group">
                <asp:Label ID="lbl" runat="server" Style="font-weight: 700; color: #FF0000"></asp:Label>
            </div>
        </div>
    </form>


</body>
    </asp:Content>

</html>