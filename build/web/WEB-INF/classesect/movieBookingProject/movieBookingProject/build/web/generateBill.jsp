<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Generate Bill</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .bill-container {
            width: 50%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .total {
            font-weight: bold;
            color: green;
        }
        .back-btn {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="bill-container">
        <h2>Movie Ticket Bill</h2>
        
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
                out.println("<p style='color:red;'>" + errorMessage + "</p>");
                return;
            }

            String[][] seatDetails = (String[][]) request.getAttribute("seatDetails");
            String totalAmount = (String) request.getAttribute("totalAmount");

            if (seatDetails == null || totalAmount == null) {
                out.println("<p>Error generating bill. Please try again.</p>");
            } else {
        %>
        
        <table>
            <tr>
                <th>Seat Number</th>
                <th>Seat Type</th>
                <th>Price</th>
            </tr>
            <%
                for (String[] seat : seatDetails) {
            %>
            <tr>
                <td><%= seat[0] %></td>
                <td><%= seat[1] %></td>
                <td><%= seat[2] %></td>
            </tr>
            <%
                }
            %>
            <tr>
                <td colspan="2" class="total">Total Amount</td>
                <td class="total"><%= totalAmount %></td>
            </tr>
        </table>
        
        <button class="back-btn" onclick="window.location.href='index.jsp'">Back to Home</button>
        
        <%
            }
        %>
    </div>
</body>
</html>
