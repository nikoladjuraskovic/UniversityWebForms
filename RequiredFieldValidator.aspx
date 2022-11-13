<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RequiredFieldValidator.aspx.cs" Inherits="WebControlsBase.RequiredFieldValidator" %>
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

    <%--
        Validatori(Validation Web Controls):
        Validatori su web kontrole koje validiraju tj. proveravaju unos podataka
        u druge asp web kontrole kao sto je npr. TextBox
        --%>


    <h3>RequiredField Validator Example</h3>
 
      <table style="background-color:#eeeeee; padding:10">
         <tr valign="top">
            <td colspan="3">
                <!--AssociatedControlID, kontrola sa kojom ima vezu-->
               <asp:Label ID="lblOutput" 
                    Text="Fill in the required field below"
                    runat="server"
                    AssociatedControlID="TextBox1"/>
               <br />
            </td>
         </tr>
 
         <tr>
            <td colspan="3">
               <b>Credit Card Information</b>
            </td>
         </tr>
     
         <tr>
            <td align="right">
               Card Number:
            </td>
            <td>
               <asp:TextBox id="TextBox1" 
                    runat="server"/>
            </td>
            <td>
                <!--ControlToValidate atribut je kontrola koju validiramo
                    Display property: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.basevalidator.display?view=netframework-4.8
                    Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.requiredfieldvalidator?view=netframework-4.8
                    RequiredFieldValidator - validira unos tako sto vrsi
                    proveru da li je nesto uneto.
                    
                    -->
               <asp:RequiredFieldValidator id="RequiredFieldValidator2"
                    ControlToValidate="TextBox1"
                    Display="Static"
                    ErrorMessage="*"
                    ForeColor="red"
                    runat="server"/> 
            </td>
         </tr>
         <tr>
            <td></td>
            <td>
                <!--OnClick atribut, funkcija koja se poziva pri kliku na dugme-->
               <asp:Button id="Button1" 
                    Text="Validate" 
                    OnClick="Button1_Click"
                    runat="server"/>
            </td>
            <td></td>
         </tr>
      </table>

</asp:Content>
