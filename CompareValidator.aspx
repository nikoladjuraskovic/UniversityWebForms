<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompareValidator.aspx.cs" Inherits="WebControlsBase.CompareValidator" %>
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

    <h3>CompareValidator Example</h3>
      <br />
      Enter a value in each textbox. Select a comparison operator<br />
      and data type. Click "Validate" to compare values.
 
      <table style="background-color:#eeeeee; padding:10">

         <tr valign="top">

            <td>

               <h5>String 1:</h5>
               <asp:TextBox id="TextBox1" 
                    runat="server"/>

            </td>

            <td>

               <h5>Comparison Operator:</h5>
 <!--OnSelectedIndexChanged oznacava funkciju koja se poziva pri
                    promeni tipa(ovde se radi o tipovima promenljivih)-->
               <asp:ListBox id="ListOperator" 
                    OnSelectedIndexChanged="ListOperator_SelectedIndexChanged"
                    runat="server">

                  <asp:ListItem Selected="True" Value="Equal">Equal</asp:ListItem>
                  <asp:ListItem Value="NotEqual">NotEqual</asp:ListItem>
                  <asp:ListItem Value="GreaterThan">GreaterThan</asp:ListItem>
                  <asp:ListItem Value="GreaterThanEqual">GreaterThanEqual</asp:ListItem>
                  <asp:ListItem Value="LessThan">LessThan</asp:ListItem>
                  <asp:ListItem Value="LessThanEqual">LessThanEqual</asp:ListItem>
                  <asp:ListItem Value="DataTypeCheck">DataTypeCheck</asp:ListItem>

               </asp:ListBox>

            </td>

            <td>

               <h5>String 2:</h5>
               <asp:TextBox id="TextBox2" 
                    runat="server"/>
               <br />
               <asp:Button id="Button1"
                    Text="Validate"  
                    OnClick="Button1_Click"
                    runat="server"/>

            </td>
         </tr>

         <tr>
            <td colspan="3" align="center">

               <h5>Data Type:</h5>
                
               <asp:ListBox id="ListType" 
                    OnSelectedIndexChanged="ListType_SelectedIndexChanged"
                    runat="server">

                  <asp:ListItem Selected="true" Value="String" >String</asp:ListItem>
                  <asp:ListItem Value="Integer" >Integer</asp:ListItem>
                  <asp:ListItem Value="Double" >Double</asp:ListItem>
                  <asp:ListItem Value="Date" >Date</asp:ListItem>
                  <asp:ListItem Value="Currency" >Currency</asp:ListItem>

               </asp:ListBox>
            </td>
         </tr>
      </table>
 <!--ControlToValidate i ControlToCompare su kontrole koje poredimo.
     CompareValidator:
        Poredi dve vrednosti na osnovu izabranog kirterijuma poredjenja
     Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.comparevalidator?view=netframework-4.8-->
      <asp:CompareValidator id="Compare1" 
           ControlToValidate="TextBox1" 
           ControlToCompare="TextBox2"
           EnableClientScript="False" 
           Type="String" 
           runat="server"/>
 
      <br />
       
      <asp:Label id="lblOutput" 
           Font-Names="verdana" 
           Font-Size="10pt" 
           runat="server"/>



</asp:Content>
