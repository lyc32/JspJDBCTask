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
    public int insertData(Connection connection, String tableName, String columList, String valueList)
    {
        try
        {
            Statement statement = connection.createStatement();
            String sql = "INSERT INTO "+ tableName + " " + columList + " VALUES " + valueList;
            System.out.println(sql);
            int result = statement.executeUpdate(sql);
            statement.close();
            return result;
        }
        catch (SQLException e)
        {
            System.out.println("[Error]\n" + e);
            return 0;
        }
    }
%>

<body>
<%
    String dataBaseMessage ="";
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
        String pid   = request.getParameter("productID");
        String pname = request.getParameter("productName");
        String price = request.getParameter("productPrice");
        String qty   = request.getParameter("productQty");

        if(pid!=null && pname!=null && price!=null && qty!=null)
        {
            int result = insertData(connection, "`Product`",
                    "(`Pid`, `Pname`, `Qty`, `Price`)",
                    "(" + pid + ", '" + pname + "',"+ qty + "," + price+ ")");
            if (result == 0)
            {
                dataBaseMessage = "Add New Product Filed";
            }
            else
            {
                dataBaseMessage = "Add New Product Successful";
            }
        }
        connection.close();
    }
%>

<div class="container mt-4 mb-4" style="min-height: 600px; ">
    <div class="row justify-content-center">
        <div class="card" style="max-width: 600px;min-height:200px;">
            <div class="row g-0 mb-2">
                <div class="card-body">
                    <p class="card-text pt-2 pb-2">
                    <h2><%=dataBaseMessage%></h2>
                    <div id='message'></div>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script language="javascript">
    var num = 4;
    var URL = 'productList.jsp';
    window.setTimeout("doUpdate()", 1000);
    function doUpdate()
    {
        if(num != 0)
        {
            document.getElementById('message').innerHTML = '<h2>Jump after '+num+' seconds</h2>';
            num --;
            window.setTimeout("doUpdate()", 1000);
        }
        else
        {
            num = 4;
            window.location = URL;
        }
    }
</script>
</body>
</html>
