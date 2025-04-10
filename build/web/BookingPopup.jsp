<%@ page session="true" %>
<%
    String carName = (String) session.getAttribute("carName");
    String name = (String) session.getAttribute("name");
    String startDate = (String) session.getAttribute("startDate");
    String endDate = (String) session.getAttribute("endDate");
    int days = (Integer) session.getAttribute("days");
    int totalPrice = (Integer) session.getAttribute("totalPrice");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #1d1b36;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .popup {
            background: #292447;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.1);
            text-align: center;
            max-width: 400px;
        }
        h2 {
            color: #ff9800;
        }
        .details {
            margin: 20px 0;
        }
        .btns {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btns button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .confirm {
            background: #4caf50;
            color: white;
        }
        .cancel {
            background: #f44336;
            color: white;
        }
        .btns button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="popup">
        <h2>Booking Summary</h2>
        <div class="details">
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Car:</strong> <%= carName %></p>
            <p><strong>Duration:</strong> <%= startDate %> to <%= endDate %> (<%= days %> days)</p>
            <p><strong>Total Price:</strong> <%= totalPrice %></p>
            <p><strong>Payment:</strong> Please pay at the reception counter.</p>
        </div>
        <div class="btns">
            <form action="login.jsp" method="post">
                <button class="confirm">OK</button>
            </form>
            <form action="userDashboard.jsp" method="post">
                <button class="cancel">Back</button>
            </form>
        </div>
    </div>
</body>
</html>
