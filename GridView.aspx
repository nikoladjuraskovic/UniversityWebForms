<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GridView.aspx.cs" Inherits="WebControlsBase.GridView" %>
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
    

    <%--U ovoj labeli ispisujemo ako dodje do greske na serveru--%>
    <asp:Label ID="ErrorLabel" runat="server" Text="" ForeColor="Red" Font-Bold="true" Font-Size="Large"></asp:Label>

    <%--
        GridView. Veb kontrole asp.net-a iz grupe Data kontrola za prikaz(ispis) nekih podataka, najčešće iz baze.
        Na strani klijenta se pretvara u html tabelu.
        Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview?view=netframework-4.8.1
        
        --%>

    <h3>GridView ispis iz C# liste objekata</h3>

    <%--AutoGenerateColumns = true znaci da ce program sam izgenerisati kolone podataka GridView kontrole na osnovu podataka koje ima--%>
    <%--koristimo css klasu table iz Bootstrap biblioteke--%>
    <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="true">

    </asp:GridView>

    <h3>GridView ispis iz baze podataka, Automatski generisane kolone</h3>

    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="true" CssClass="table">

    </asp:GridView>

    <h3>GridView ispis iz baze podataka, rucno pravljene kolone</h3>
    <%--Rucnim pravljenjem kolona imam vecu slobodu pri dizajnu tabele--%>



     <%---Columns - kolone GridView tabele--%>

        <%--DataField je oznaka na koji podatak se odnosi ta kolona, HeaderText je sta ce pisati na stranici.

            DataField polje se MORA zvati isto kao i kolona tabele podataka iz baze!--%>


    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="false" CssClass="table">

       
        <Columns>
            
            <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="Year" HeaderText="Year" />
            
        </Columns>


    </asp:GridView>

    <h3>GridView ispis iz baze podataka, podaci dohvaceni koriscenjem sqlDataSource kontrole</h3>

    <%--podatke u GridView mozete dohvatiti i koriscenjem sqlDataSource kontrole iz Data grupe kontrola.
        u GridView navodimo DataSourceID da je ID sqlDataSource kontrole. Width je sirina tabele
        Sve se vrsi na aspx delu--%>


    <asp:GridView ID="GridView4" runat="server" CssClass="table" AutoGenerateColumns="true" DataSourceID="SqlDataSource1"  Width="30%">


    </asp:GridView>


    <%--SqlDataSource kontrola za pravljenje izvora podataka. ConnectionString je za konekcioni string baze.
        SelectCommand je za select komandu koja govori sta dohvatamo, OnSelected je dogadjaj u kojem obradjujemo izuzetke.
        OPREZ! U konekctionom stringu ovde se \ tumaci bas kao \ karakter, tako da nije potrebno imate dve kose crte--%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False" 
        SelectCommand="SELECT LastName, Year FROM Students"
        OnSelected="SqlDataSource1_Selected">

    </asp:SqlDataSource>

    <h3>GridView ispis prosecnih ocena studenata</h3>

    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="true">

    </asp:GridView>

    <%--Kontrola Chart omogucava graficki ispis podataka.
        Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.datavisualization.charting.chart?view=netframework-4.8.1
        https://www.c-sharpcorner.com/UploadFile/63f5c2/chart-control-in-Asp-Net/
        --%>

    <h3>Chart ispis prosecnih ocena studenata</h3>

    <asp:Chart ID="Chart1" runat="server" Width="500px">
        <Series>
            <asp:Series Name="Series1" XValueMember="0" YValueMembers="1" ></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
    </asp:Chart>

</asp:Content>
