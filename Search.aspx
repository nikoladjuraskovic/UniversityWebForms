<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebControlsBase.Search" %>
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
    <br />
    <br />
    
    <%--Vrsimo pretragu studenata na osnovu njihovog prezimena,
        potrebno je uneti prezime(celo ili prvih nekoliko karaktera)
        i onda ispisati sve studente sa prezimenom ciji se karakteri poklapaju
        sa onim ispisanim u TextBox-u. Pretraga se vrsi klikom na button Search.
        Pretragu takodje vrsimo izborom godine u DropDownList-i.
        
        --%>

    <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true"></asp:Label>

    <br />

    <asp:Panel ID="Panel1" runat="server" CssClass="form-group">

    <asp:Label ID="Label1" runat="server" Text="Search by Last Name:">

    </asp:Label>

    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control">

    </asp:TextBox>

    <br />

    <asp:Label ID="Label2" runat="server" Text="Search by Year:">

    </asp:Label>

    <asp:DropDownList ID="DropDownList1" runat="server"
          AutoPostBack="true" CssClass="form-control">


    </asp:DropDownList>

     <br />
    

    <asp:Button ID="Button1" runat="server"
        Text="Search"
         OnClick="Button1_Click" CssClass="btn btn-primary"/>

    </asp:Panel>

   

    <asp:GridView ID="GridView1" runat="server"
         EmptyDataText="No Data"
         AutoGenerateColumns="true"
         CssClass="table" Width="50%">

    </asp:GridView>


</asp:Content>
