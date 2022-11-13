<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrudWithHtmlJS.aspx.cs" Inherits="WebControlsBase.CrudWithHtmlJS" %>




<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <style>

        .greska {
            color: red;
            font-size: 14px;
            margin-top: 25px;
            margin-bottom: 25px;
        }


    </style>

    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />




    <h1>Insert and Select DataBase with HTML Controls </h1>


    <h2>Insert Student</h2>

    <%--
        Javascript nece raditi validaciju forme kako treba jer element form
        vec postoji u Web form with Master Page u master page-u i kada mi ovde
        ubacimo form to znaci da imamo formu u formi a to ne moze,
        i zato javascript nece ovde raditi. Pogledati u console u browser-u.
        Zato, u ASP.NET .NET Framework-u, ako hocete da imate validaciju na strani
        klijenta samo u Javascript-u(ne preko Custom Validator-a) onda
        morate napraviti web form stranicu BEZ master page-a.
        --%>

    <form id="insertForm" action="CrudWithHtmlJS.aspx" method="POST" >
        

        <div class="greska" id="error"> </div>


        <div class="form-group">

            <label for="LastName">LastName:</label>
            <input id="LastName" type="text" class="form-control" name="LastName" />
        </div>

        <div class="form-group">
            <label for="FirstName">FirstName:</label>
            <input id="FirstName" type="text" class="form-control" name="FirstName" />
        </div>


        <div class="form-group">

            <label for="Year">Year:</label>
            <input id="Year" type="number" class="form-control" name="Year" min="1" max="4" />
        </div>

        <div class="form-group">
            <input id="Submit1" type="submit" value="Insert Student" class="btn btn-outline-success btn-success btn-lg" />

        </div>

    </form>


    

    <h2>Students in DataBase</h2>

    <table class="table">
        <tr>
            <th>LastName</th>
            <th>  FirstName</th>
            <th>  Year</th>
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

    <script language="javascript" src="CrudWithHTMLjs.js">
        
    </script>


        

            



            

        

      


</asp:Content>


