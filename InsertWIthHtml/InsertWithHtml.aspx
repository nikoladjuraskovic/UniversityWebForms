<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertWithHtml.aspx.cs" Inherits="WebControlsBase.InsertWIthHtml.InsertWithHtml" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert Student</title>

    <link href="InsertWithHtml.css" rel="stylesheet" />
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous"/>

</head>
<body>


    <div class="container">

        <a href="../Default.aspx">Home Page</a>


        <h1>Insert and Select DataBase with HTML Controls </h1>
        <%--
            InsertWithHtml je aspx stranica koja putem HTML forme unosi
            novog studenta u bazu i ispisuje sve studente u HTML tabeli.
            Stranica, posto je ona web form bez master page-a, se stilizuje
            u posebnom css fajlu koristeci biblioteku bootstrap,
            a provere se vrse na strani klijenta u javascriptu u posebnom fajlu.
            Nakon toga, se na strani servera u aspx.cs-u, dohvataju podaci
            iz forme i ubacuju u bazu.
             Domaci: uraditi Edit Studenta preko html forme
            
            --%>

        <h2>Insert Student</h2>

        <%--
        
        --%>

        <form id="insertForm" method="post">


            <div class="greska" id="error"></div>


            <div class="form-group">

                <label for="LastName">LastName:</label>
                <input id="LastName" type="text" class="form-control" name="LastName" />
                <div class="invalid-feedback">
                    Please provide a valid last name.
                </div>
            </div>

            <div class="form-group">
                <label for="FirstName">FirstName:</label>
                <input id="FirstName" type="text" class="form-control" name="FirstName" />
                <div class="invalid-feedback">
                    Please provide a valid first name.
                </div>
            </div>


            <div class="form-group">

                <label for="Year">Year:</label>
                <input id="Year" type="number" class="form-control" name="Year" min="1" max="4" />
                <div class="invalid-feedback">
                    Please provide a valid year.
                </div>
            </div>

            <br />
            <div class="form-group">

                <input id="Submit1" type="submit" value="Insert Student" class="btn btn-success" />

            </div>

        </form>




        <h2>Students in DataBase</h2>

        <table class="table">
            <tr>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Year</th>
            </tr>

            <%  
                foreach (var item in students)
                {
                    
            %>

            <tr>
                <td><%= item.Item1 %></td>
                <td><%= item.Item2 %></td>
                <td><%= item.Item3 %></td>
            </tr>

            <% } %>
        </table>



    </div>

    <footer class="modal-footer">
                <p>&copy; Nikola Đurašković - <%: DateTime.Now.Year %> </p>
    </footer>

    <script src="InsertWithHtml.js"></script>

</body>
</html>
