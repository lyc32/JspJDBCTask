<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<%!
    public ResultSet getAllData(Connection connection, String columList, String tableName)
    {
        try
        {
            Statement statement = connection.createStatement();
            System.out.println("SELECT " + columList + " FROM " + tableName);
            ResultSet resultSet = statement.executeQuery("SELECT " + columList + " FROM " + tableName);
            return resultSet;
        }
        catch (SQLException e)
        {
            System.out.println("[Error]\n" + e);
            return null;
        }
    }
%>

<%
    String listTable ="";
    String driver  = "com.mysql.cj.jdbc.Driver";
    String url     = "jdbc:mysql://localhost:3306/TestDB?useSSL=false";
    String userName= "root";
    String password= "";
    Connection connection;
    try
    {
        Class.forName(driver);
        connection = DriverManager.getConnection(url,userName,password);
    }
    catch (SQLException | ClassNotFoundException e)
    {
        connection = null;
    }

    if(connection != null)
    {
        ResultSet resultSet = getAllData(connection, "*", "Product");
        while (true)
        {
            try {
                if (!resultSet.next())
                {
                    break;
                }
                else
                {listTable = listTable + "<tr><td>" + resultSet.getString("Pid")
                            + "</td><td>" + resultSet.getString("Pname")
                            + "</td><td>" + resultSet.getString("Qty")
                            + "</td><td>" + resultSet.getString("Price") +"</td></tr>";
                }
            } catch (SQLException e) {
                listTable = e.toString();
            }
        }
        connection.close();
    }
%>

<body>
<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="card" style="max-width: 700px;">
            <div class="row g-0">
                <div class="card-body">
                    <h2 class="card-title text-center border-bottom  pb-4">Product List</h2>
                    <p class="card-text text-center pb-4">
                    <table class="table table-sm table-hover table-dark text-secondary">
                        <thead class="thead-dark border-bottom text-center text-secondary h4">
                        <tr>
                            <th scope="col">id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Qty</th>
                            <th scope="col">Price</th>
                        </tr>
                        </thead>
                        <tbody class="thead-dark border-bottom text-center text-secondary h4">
                            <%=listTable%>
                        </tbody>
                    </table>
                    </p>
                </div>
            </div>
            <div class="row g-0 text-center justify-content-end">
                <a href="index.html" class="btn btn-outline-secondary mb-3 btn-lg " style="height:50px; width:50px"><h4>+</h4></a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
