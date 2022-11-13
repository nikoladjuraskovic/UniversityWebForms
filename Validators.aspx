<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Validators.aspx.cs" Inherits="WebControlsBase.Validators" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


     <%--
        Validatori. Posebne klase u ASP-u za validiranje unos podataka na
        strani SERVERA. Njih takodje stavljamo u asp-ove tagove nakon cega navodimo
        njihova imena. Validatori su izvedene klase WebControl klase.
        Na ucionici imate sliku kako su Validator klase izvedene od WebControl klase.

        RequiredField Validator:
        Obezbedjuje da korisnik unese neku vrednost u TextBox.
Dokumentacija: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.requiredfieldvalidator?view=netframework-4.8
        --%>

    <style>

        .kontejner{
            
        }

        .blok{
            display: inline-block;
            margin: 20px;
        }
        .auto-style1 {
            height: 20px;
        }
    </style>

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

    <h1>Regular Expression Validator</h1>

    <div>

        

        <div class="blok">

            <%--
                Validator za proveru validnosti regularnih izraza.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.regularexpressionvalidator?view=netframework-4.8

                Regularni izrazi su izrazi tj. nizovi karaktera(slova, cifara, znakova) kojima se 
                opisuju patterni reci tj. sabloni reci. Npr. svaka mejl adresa ima sledeci pattern(sablon):
                rec@rec.domen ili rec.rec@rec.domen pri cemu rec moze biti bilo koja kombinacija slova i cifara
                dok domen moze biti: .com, .rs, ...
                Regularni izrazi imaju mnogo pravila kako opisuju pattern-e.
                Mozete ih pogledati ovde:  https://www.regular-expressions.info/tutorial.html
                Dobar sajt za ucenje i vezbanje regularnih izraza: https://regexr.com/
                Neke regularne izraze vec imate gotove u properties-u pod
                ValidationExpression ali ne i sve neophodne i ceste.
                --%>

            <table style="background-color:#eeeeee; padding:10px">
          <tr valign="top">
             <td colspan="3">
                <asp:Label ID="lblOutput" 
                     Text="Enter a 5-digit ZIP Code" 
                     runat="server"
                     AssociatedControlID="TextBox1"/>
             </td>
          </tr>
 
          <tr>
             <td colspan="3" class="auto-style1">
                <b>Personal Information</b>
             </td>
          </tr>
          <tr>
             <td align="right">
                Zip Code:
             </td>
             <td>
                <asp:TextBox id="TextBox1" 
                     runat="server"/>
             </td>
             <td>

                 <%--Display je none, dole u komentaru pise zasto.
                     U oba validatora treba staviti EnableClientScript="False"
                     da bi se validnost stranice u lblOutput-u prikazivala
                     tacno.--%>
                <asp:RegularExpressionValidator id="RegularExpressionValidator1" 
                     ControlToValidate="TextBox1"
                     Display="None"
                     ErrorMessage="ZIP code must be 5 numeric digits"                    
                     ForeColor="Red"
                     EnableClientScript="False" 
                     runat="server"
                     ValidationExpression="\d{5}" />
             </td>
              
            <td>
                <asp:RequiredFieldValidator id="RequiredFieldValidator2"
                    ControlToValidate="TextBox1"
                    Display="None"
                    ErrorMessage="Enter a 5 digit code!"
                    ForeColor="red"
                    runat="server"
                    EnableClientScript="False"/>
                     


            </td>
             
          </tr>
           <tr>
               <%--
                   Validation Summary
                   https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.validationsummary?view=netframework-4.8
                  ASP.NET veb kontrola koja na jednom mestu ispisuje greske pri unosu
                   podataka u kontrolu koju validiraju validatori
                   Zato u RequiredFiledValidotor i RegularExpression Validator
                   Display smo stavili none da bi se greska samo prikazala
                   u ValidationSummary, a ne preko Validatora direktno.
                   Zgodno je kad npr. imamo vise validatora pa da ispis
                   bude lepsi tj. da lepo izgleda korisniku na stranici.
                   ErrorMessage validatora se sada prikazuje u Validation Summary.
                   
                    --%>
               <asp:ValidationSummary ID="ValidationSummary1"
                   runat="server"
                   DisplayMode="BulletList"                
                   HeaderText="You must enter a value in the following fields:"
                   Font-Names="verdana" 
                   Font-Size="12"
                   ForeColor="Red"
                   />

           </tr>
          <tr>
             <td></td>
             <td>
                <asp:Button ID ="Button1"
                    text="Validate" 
                     OnClick="Button1_Click"
                     runat="server" />
             </td>
             <td></td>
          </tr>
       </table>


        </div>


    </div>

</asp:Content>
