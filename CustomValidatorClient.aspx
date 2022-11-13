<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomValidatorClient.aspx.cs" Inherits="WebControlsBase.CustomValidatorClient" %>
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

    <h3>CustomValidator ClientValidate Example</h3>

      <asp:Label id="Message"  
           Text="Enter an even number:" 
           Font-Name="Verdana" 
           Font-Size="10pt" 
           runat="server"/>

      <p>

      <asp:TextBox id="Text1" 
           runat="server" />
    
        
          <!--
              CustomValidator:
        Poredi neku vrednost na osnovu nekog naseg definisanog(custom) kriterijuma.
        Ovde je nas kriterijum da li je broj deljiv sa 2.
        U ovom primeru cemo validirati na strani klijenta u javascript-u.
Dokumentacija: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.customvalidator?view=netframework-4.8
              ClientValidationFunction, da bismo validirali na strani klijenta
              poziva se navedena funkcija iz javascript-a-->
      <asp:CustomValidator id="CustomValidator1"
           ControlToValidate="Text1"
           ClientValidationFunction="ClientValidate"
 
           Display="Static"
           ErrorMessage="Not an even number!"
           ForeColor="red"
           Font-Name="verdana" 
           Font-Size="10pt"
           runat="server"/>

      <p>
 
      <asp:Button id="Button1"
           Text="Validate" 
           OnClick="Button1_Click"
           runat="server"/>


<script language="javascript"> 
            //funkcija koja validira na strani klijenta
            function ClientValidate(source, arguments) {
                if (arguments.Value % 2 == 0) {
                    arguments.IsValid = true;
                } else {
                    arguments.IsValid = false;
                }
            }
</script>

</asp:Content>
