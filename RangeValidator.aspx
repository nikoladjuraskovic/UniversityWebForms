<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RangeValidator.aspx.cs" Inherits="WebControlsBase.RangeValidator" %>
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

    <h3>RangeValidator Example</h3>
    
      Enter a number from 1 to 10:

      <br />

      <asp:TextBox id="TextBox1"
           runat="server"/>

      <br />
      <!--RangeValidator:
        Obezbedjuje da je korisnik uneo nesto u dozvoljenom opsegu vrednosti.
          MinimumValue i MaximumValue su dozvoljeni opsezi vrednosti koja se unosi.
          
          EnableClientScript property: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.basevalidator.enableclientscript?view=netframework-4.8
          Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.rangevalidator?view=netframework-4.8-->
      <asp:RangeValidator id="Range1"
           ControlToValidate="TextBox1"
           MinimumValue="1"
           MaximumValue="10"
           Type="Integer"
           EnableClientScript="false"
           Text="The value must be from 1 to 10!"
           ForeColor="red"
           runat="server"/>

      <br /><br />

      <asp:Label id="Label1"
           runat="server"/>

      <br /><br />

      <asp:Button id="Button1"
           Text="Submit"
           OnClick="Button1_Click"
           runat="server"/>
            



</asp:Content>
