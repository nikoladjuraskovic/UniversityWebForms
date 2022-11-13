<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomValidatorServer.aspx.cs" Inherits="WebControlsBase.CustomValidatorServer" %>
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


    <h3>CustomValidator ServerValidate Example</h3>

      <asp:Label id="Message"  
           Text="Enter an even number:" 
           Font-Names="Verdana" 
           Font-Size="10pt" 
           runat="server"
           AssociatedControlID="Text1"/>

      <br />

      <asp:TextBox id="Text1" 
           runat="server" />
    
        
       <!--CustomValidator:
        Poredi neku vrednost na osnovu nekog naseg definisanog(custom) kriterijuma.
        Ovde je nas kriterijum da li je broj deljiv sa 2.
        U ovom primeru cemo validirati na strani servera u ASP-u.
Dokumentacija: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.customvalidator?view=netframework-4.8  
           
           OnServerValidate, poziva funkciju koja validira na strani ser
         vera
           ErrorMessage je poruka koje se prikazuje-->
      <asp:CustomValidator id="CustomValidator1"
           ControlToValidate="Text1"
           Display="Static"
           ErrorMessage="Not an even number!"
           ForeColor="red"
           Font-Names="verdana" 
           Font-Size="10pt"
           OnServerValidate="CustomValidator1_ServerValidate"
           runat="server"/>

      <br />
      <br />
 
      <asp:Button id="Button1"
           Text="Validate" 
           OnClick="Button1_Click"
           runat="server"/>


</asp:Content>
