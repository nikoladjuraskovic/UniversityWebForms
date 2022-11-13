<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteWithHtml.aspx.cs" Inherits="WebControlsBase.DeleteWithHtml.DeleteWithHtml" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delete Student</title>

    <link href="DeleteWithHtml.css" rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous"/>

</head>
<body>
   
    <%--
        Stranica brise izabranog studenta putem HTML forme.
        Ideja je ubaciti dugme u formu za svakog studenta
        i dohvatiti id u C# i na osnovu njega obrisati studenta.
        Domaci: uraditi Edit Studenta preko html forme
        --%>
    
    
    <div class="container">


        <a href="../Default.aspx">Home Page</a>


        <h3>Students to Delete</h3>


        <%for (int i = 0; i < students.Count; i++)
            { %>

        <div class="studentRow red" >

            <form id="deleteForm" method="post">


                <div class="form-group red">

                    <label for="id">Student ID: </label>
                    <input id="id" type="number" name="id" value="<%= students[i].Item1 %>" class="form-control" readonly="true" />

                </div>

                <div class="form-group red">

                    <label for="lastName">Last Name: </label>
                    <input id="lastName" type="text" name="lastName" value="<%= students[i].Item2 %>" class="form-control" readonly="true" />

                </div>

                <br />

                <div class="form-group red">

                    <br />
                    <input type="submit" name="delete" value="Delete Student" class="btn btn-danger" />

                </div>

            </form>



        </div>

        <% } %>





        <h3>Students in DataBase</h3>

        <table class="table">
            <tr>
                <th>StudentID</th>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Year</th>
            </tr>

            <% for (int i = 0; i < students.Count; i++)
                { %>

            <tr>
                <td><%= students[i].Item1 %></td>
                <td><%= students[i].Item2 %></td>
                <td><%= students[i].Item3 %></td>
                <td><%= students[i].Item4 %></td>

            </tr>

            <% } %>
        </table>


    </div>

    <footer class="modal-footer">
                <p>&copy; Nikola Đurašković - <%: DateTime.Now.Year %> </p>
    </footer>

</body>
</html>
