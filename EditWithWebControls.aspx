<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditWithWebControls.aspx.cs" Inherits="WebControlsBase.EditWithWebControls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


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


    <link href="EditWithWebControls.css" rel="stylesheet" />

    <h2>Edit with ASP Web Controls</h2>
    <!--Stranica menja postojeceg studenta u bazi i vrsi ispis u GridView-->

    <asp:sqldatasource id="GridView1Source"
        selectcommand="SELECT StudentID, LastName, FirstName, Year FROM Students"
        connectionstring="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False" 
        runat="server"/>
    <%--CssClass omogucava lep ispis GridView, doduse nije identicna kao kada bismo
        obicnoj html tabeli dali da pripada css klasi table
        --%>
    <asp:GridView ID="GridView1" runat="server"
        DataSourceID="GridView1Source"
        EmptyDataText="No Data"
         AutoGenerateColumns="true"
         CssClass="table"
         AutoGenerateSelectButton="true"
         SelectedRowStyle-BackColor="SlateBlue"
         SelectedRowStyle-Font-Bold="true"
         SelectedRowStyle-ForeColor="Yellow"
         >
         </asp:GridView>

    <%--Treba nam dodatno dugme za potvrdu izbora reda da bi mogli
        da implementiramo event i upisemo podatke u textbox
        da bi ih kasnije preusmerili na backend. Ideja je
        da kad potvrdimo izbor i pripremimo sve za editovanje
        da se onda pojavi dugme edit i textbox-ovi za menjanje
        podataka, zato je za njih u pocetku Visible=false i prazan text.--%>

    <asp:Panel ID="Panel6" runat="server" CssClass="paneli">


    <asp:Button ID="Button1" runat="server"
        Text="Confirm Selection"
        CssClass="btn btn-primary"
         OnClick="Button1_Click"/>
    <%--label koji kaze korisniku da treba da izabere red ako nije
        a jeste kliknuo dugme Button1--%>
    <asp:Label ID="RowNotSelectedLabel" runat="server"
        Text=""
        Visible="false"
        Font-Bold="true"
        ForeColor ="Red"></asp:Label>

    

    <asp:Button ID="Button2" runat="server"
        Text="Edit Student"
         CssClass="btn btn-warning"
         Visible="false"
         OnClick="Button2_Click"/>

    

        <asp:Panel ID="Panel1" runat="server" CssClass="form-group">

            <asp:Label ID="Label1" runat="server" Text="Student ID:" Visible="false" Font-Bold="true">

            </asp:Label>
            <%--Posto je text box u pocetku nevidljiv a validatori ga proveravaju da
            li je nesto uneto, treba da unesemo neke random
            vrednosti(npr. prazan string) u textbox da ne bi validatori vrsili provere
            pre nego sto korisnik pokusa da unese nesto--%>
            <asp:TextBox ID="TextBoxId" runat="server"
                Text=""
                Visible="false"
                ReadOnly="true"
                CssClass="form-control"></asp:TextBox>



        </asp:Panel>

        <asp:Panel ID="Panel2" runat="server" CssClass="form-group">

            <asp:Label ID="Label2" runat="server"
                Text="Last Name:"
                Visible="false"
                Font-Bold="true"></asp:Label>

            <asp:TextBox ID="TextBoxLastName" runat="server"
                Text="a"
                Visible="false"
                ReadOnly="false"
                CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ErrorMessage="Please enter a last name!"
                ControlToValidate="TextBoxLastName"
                Display="None"
                ForeColor="red"
                EnableClientScript="false">

            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                runat="server"
                ErrorMessage="Last Name can only have letters!"
                ControlToValidate="TextBoxLastName"
                ForeColor="Red"
                Font-Bold="true"
                EnableClientScript="false"
                ValidationExpression="[a-zA-Z]+"
                Display="None"></asp:RegularExpressionValidator>

        </asp:Panel>

        <asp:Panel ID="Panel3" runat="server" CssClass="form-group">

            <asp:Label ID="Label3" runat="server"
                Text="First Name:"
                Visible="false"
                Font-Bold="true"></asp:Label>


            <asp:TextBox ID="TextBoxFirstName" runat="server"
                Text="a"
                Visible="false"
                ReadOnly="false"
                CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ErrorMessage="Please enter a name!"
                ForeColor="Red"
                ControlToValidate="TextBoxFirstName"
                Display="None"
                EnableClientScript="false">

            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                runat="server"
                ErrorMessage="Name can only have letters!"
                ControlToValidate="TextBoxFirstName"
                ForeColor="Red"
                Font-Bold="true"
                EnableClientScript="false"
                ValidationExpression="[a-zA-Z]+"
                Display="None"></asp:RegularExpressionValidator>

        </asp:Panel>

        <asp:Panel ID="Panel4" runat="server" CssClass="form-group">

            <asp:Label ID="Label4" runat="server"
                Text="Year:"
                Visible="false"
                Font-Bold="true"></asp:Label>

            <asp:TextBox ID="TextBoxYear" runat="server"
                Text="1"
                Visible="false"
                ReadOnly="false"
                CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ErrorMessage="Please enter a number!"
                ControlToValidate="TextBoxYear"
                Display="None"
                ForeColor="Red"
                EnableClientScript="false">

            </asp:RequiredFieldValidator>

            <asp:RangeValidator ID="RangeValidator1" runat="server"
                ErrorMessage="Please enter a number between 1 and 4!"
                ControlToValidate="TextBoxYear"
                MinimumValue="1"
                MaximumValue="4"
                Type="Integer"
                Display="None"
                ForeColor="red"
                EnableClientScript="false"></asp:RangeValidator>

        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="Panel5" runat="server" CssClass="paneli margine">

        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
             ShowValidationErrors="true"
             DisplayMode="List"
             ForeColor="Red"              
             EnableViewState="true"
             Font-Bold="true"
             ShowSummary="true"
             />

    </asp:Panel>

   

</asp:Content>
