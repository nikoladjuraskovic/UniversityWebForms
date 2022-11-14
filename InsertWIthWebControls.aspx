<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsertWIthWebControls.aspx.cs" Inherits="WebControlsBase.InsertWIthWebControls" %>
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
    <br />
    <!-- CSS only -->
    <style>

        .textbox-warning{
            outline: 1px solid red;
        }

       

    </style>

    <h2>Insert Student With ASP Web Controls</h2>
    <!--Stranica ubacuje studenta u bazu i vrsi ispis u GridView-->

    <!--Panel kontrola je slicna div u html-u i zato ovako pisemo
        da bi stilizovali formu kao sto smo prosle godine, koristimo bootstrap klase.
        Proveru validnosti ulaza cemo vrsiti pomocu validatora. Pre svega svuda treba
        uneti nesto, dakle RequiredField Vaidator, zatim godine moraju da su od 1 do 4
        tj. Range Validator i Ime i prezime mora biti samo od karaktera tj. to je sablon(pattern).
        Dakle, treba nam Regular Expression Validator.
        Koristicemo i Validation Summary radi lepseg ispisa gresaka.
        Lepe Bootstrap klase za stilizovanje Web Control-a:
        https://getbootstrap.com/docs/4.0/components/forms/
        Oprez! Ako uvezete bootstrap putem linka narusicete layout sajta
        jer on vec u sebi ima neku bootstrap biblioteku!
        -->

    <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true"></asp:Label>

    <h3>Insert Student</h3>

    <asp:Panel ID="Panel1" runat="server" CssClass="form-group">

        <asp:Label ID="Label1" runat="server" Text="First Name:" Font-Bold="true"></asp:Label>

        <asp:TextBox ID="TextBoxFirstName" runat="server" CssClass="form-control" ></asp:TextBox>

    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" CssClass="form-group">

        <asp:Label ID="Label2" runat="server" Text="Last Name:" Font-Bold="true"></asp:Label>

        <asp:TextBox ID="TextBoxLastName" runat="server" CssClass="form-control"></asp:TextBox>

    </asp:Panel>

    <asp:Panel ID="Panel3" runat="server" CssClass="form-group">

        <asp:Label ID="Label3" runat="server" Text="Year:" Font-Bold="true"></asp:Label>

        <asp:TextBox ID="TextBoxYear" runat="server" CssClass="form-control"></asp:TextBox>

    </asp:Panel>

    <asp:Panel ID="Panel4" runat="server" CssClass="form-group">

        <asp:Button ID="Button1" runat="server"
            Text="Insert Student"
            CssClass="btn btn-outline-success btn-success btn-lg"
             OnClick="Button1_Click"/>

    </asp:Panel>

    <asp:Label ID="lblOutput"
        runat="server"
        Text=""
        Font-Bold="true"></asp:Label>

    <%--Da bi se TextBox-ovi crveneli ako unos nije dobar,
        moramo svuda staviti property EnableClientScript="false".
        Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.basevalidator.enableclientscript?view=netframework-4.8
        --%>

    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
        ErrorMessage="Enter Name!"
        ControlToValidate="TextBoxFirstName"       
         ForeColor="red"
         Font-Bold="true"
         EnableClientScript="false"
         Display="None"></asp:RequiredFieldValidator>

    <%--Regularni izraz [a-zA-Z]+ oznacava da su za unos dozvoljena
        samo mala i velika slova abecede jedan ili vise puta.
        Tj. ime koje se unosi mora imati bar jedno malo i/ili veliko slovo
        engleske abecede.
        --%>

    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
        runat="server"
        ErrorMessage="Name can only have letters!"
        ControlToValidate="TextBoxFirstName"
        ForeColor="Red"
        Font-Bold="true"
        EnableClientScript="false"
        ValidationExpression="[a-zA-Z]+"
        Display="None"
        ></asp:RegularExpressionValidator>

    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
        ErrorMessage="Enter LastName!"
         ControlToValidate="TextBoxLastName"
        ForeColor="red"
         Font-Bold="true"
        EnableClientScript="false"
        Display="None">

        <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
        runat="server"
        ErrorMessage="Last Name can only have letters!"
        ControlToValidate="TextBoxLastName"
        ForeColor="Red"
        Font-Bold="true"
        EnableClientScript="false"
        ValidationExpression="[a-zA-Z]+"
        Display="None"
        ></asp:RegularExpressionValidator>

    </asp:RequiredFieldValidator>

    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
        ErrorMessage="Year!"
         ControlToValidate="TextBoxYear"
        ForeColor="Red"
        Font-Bold="true"
        EnableClientScript="false"
        Display="None"
        >

    </asp:RequiredFieldValidator>

    <asp:RangeValidator ID="RangeValidator1" runat="server"
        ErrorMessage="Please enter a number between 1 and 4!"
         ControlToValidate="TextBoxYear"
         ForeColor="Red"
         Font-Bold="true"
         MaximumValue="4"
         MinimumValue="1"
         Type="Integer"
         EnableClientScript="false"
         Display="None">


    </asp:RangeValidator>


    <asp:ValidationSummary ID="ValidationSummary1" runat="server"
         DisplayMode="BulletList"
          HeaderText="Input Errors:"
         ForeColor ="red"
         Font-Bold="true"
        />


    <h3>Students in Database</h3>

    <asp:sqldatasource id="GridView1Source"
        selectcommand="SELECT * FROM Students"
        connectionstring="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False" 
        runat="server"/>
    <%--CssClass omogucava lep ispis GridView, doduse nije identicna kao kada bismo
        obicnoj html tabeli dali da pripada css klasi table
        --%>
    <asp:GridView ID="GridView1" runat="server"
        DataSourceID="GridView1Source"
        EmptyDataText="No Data"
        EmptyDataRowStyle-ForeColor="Red"
         AutoGenerateColumns="true"
         CssClass="table"
         ></asp:GridView>

   


</asp:Content>
