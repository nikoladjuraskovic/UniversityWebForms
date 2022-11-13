<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DeleteWithWebControls.aspx.cs" Inherits="WebControlsBase.DeleteWithWebControls" %>
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

    <h3>Delete with ASP Web Controls</h3>
    <!--stranica brise studenta iz baze preko Gridiew-->

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
         SelectedRowStyle-ForeColor="Red"
         
         ></asp:GridView>

    <asp:Button ID="Button1" runat="server"
        Text="Delete Selected Student"
         OnClick="Button1_Click"
         CssClass="btn btn-danger"/>


</asp:Content>
