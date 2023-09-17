<%@ Page Title="Calendar" Language="C#" AutoEventWireup="true" CodeBehind="Calander.aspx.cs" Inherits="sys.About" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Add Bootstrap CSS (if not already included) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <!-- Add FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js' rel='stylesheet' />
    <!-- Add jQuery (required by FullCalendar) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Add FullCalendar JavaScript -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <style>
        /* Add custom styles here */
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        #calendar {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Include a navigation bar or other elements as needed -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Calendar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                    </li>
                    <!-- Add other navigation links as needed -->
                </ul>
            </div>
        </nav>

        <!-- Full-screen Bootstrap calendar -->
        <div id="calendar"></div>

        <!-- JavaScript to initialize FullCalendar -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth', // Display month view by default
                    height: '100%', // Make the calendar fill the entire viewport
                    // Add your events and other configuration options here
                });
                calendar.render(); // Render the calendar
            });
        </script>
    </form>
</body>
</html>
