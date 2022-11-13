<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AutoPostBack.aspx.cs" Inherits="WebControlsBase.AutoPostBack" %>
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

    <!--Auto Post Back property TextBox-a.
        Metod post - HTTP metod kojim se podaci salju serveru.
        PostBack - ponovljeno slanje podataka serveru, time se stranica
        ponovo ucitava od strane servera, tj. opet se poziva metod Page_Load
        AutoPostBack - automatski ponovljeno slanje podataka serveru
        AutoPostBack property veb kontrola omogucava da nakon sto korisnik unese
        neke podatke u neku kontrolu, npr. TextBox, da se podaci salju serveru automatski
        nakon sto taj TextBox izgubi focus(TextBox vise nije selektovan kursorom tj. misem).
        Dakle, nema potrebe da napravimo neki Button i event kojim bismo to radili,
        ali smo mogli i tako.
Dokumentacija: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.textbox.autopostback?view=netframework-4.8
        https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.postbackoptions.autopostback?view=netframework-4.8
      Objasnjenje:  https://www.c-sharpcorner.com/uploadfile/2f73dd/what-is-postback-in-Asp-Net/
       U ovom primeru se automatski salje sadrzaj TextBox-ova serveru i vrsi zbir.
        Jos bolji primer bi bio kada bi iz neke kontrole vrsili izbor nekog podatka
        i onda tim podacima popunili neke druge kontrole(npr. Label, TextBox, ...)
        Primer: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.listcontrol.autopostback?view=netframework-4.8#system-web-ui-webcontrols-listcontrol-autopostback
        -->


    <h3> TextBox Example </h3>


      <table>

         <tr>

            <td colspan="5">

               Enter integer values into the text boxes. <br />
               The two values are automatically added <br />
               when you tab out of the text boxes. <br />

            </td>

         </tr>

         <tr>

            <td colspan="5">

                

            </td>

         </tr>

         <tr align="center">

            <td>
                <!--AutoPostBack svojstvo TextBox-a , probajte za domaci da stavite
                    na false-->
               <asp:TextBox ID="Value1"
                    Columns="2"
                    MaxLength="3"
                    AutoPostBack="True"
                    Text="1"
                    runat="server"
                    CssClass="form-control"/>

            </td>

            <td>

               + 

            </td>

            <td>

               <asp:TextBox ID="Value2"
                    Columns="2"
                    MaxLength="3"
                    AutoPostBack="True"
                    Text="1"
                    runat="server"
                    CssClass="form-control"/>

            </td>

            <td>

               =

            </td>

            <td>
               
               <asp:Label ID="AnswerMessage"
                    runat="server"
                     Font-Bold="true" />

            </td>

         </tr>

         <tr>

            <td colspan="2">
                <!--Dodajemo kontrole da je obavezno uneti nesto-->
               <asp:RequiredFieldValidator
                    ID="Value1RequiredValidator"
                    ControlToValidate="Value1"
                    ErrorMessage="Please enter a value.<br />"
                    EnableClientScript="False"
                    Display="Dynamic"
                    runat="server"/>
                <!--Dodajemo kontrole da to sto unosimo mora biti broj izmedju 1 i 100-->
               <asp:RangeValidator
                    ID="Value1RangeValidator"
                    ControlToValidate="Value1"
                    Type="Integer"
                    MinimumValue="1"
                    MaximumValue="100"
                    ErrorMessage="Please enter an integer <br /> between than 1 and 100.<br />"
                    EnableClientScript="False"
                    Display="Dynamic"
                    runat="server"/>

            </td>

            <td colspan="2">

               <asp:RequiredFieldValidator
                    ID="Value2RequiredValidator"
                    ControlToValidate="Value2"
                    ErrorMessage="Please enter a value.<br />"
                    EnableClientScript="False"
                    Display="Dynamic"
                    runat="server"/>

               <asp:RangeValidator
                    ID="Value2RangeValidator"
                    ControlToValidate="Value2"
                    Type="Integer"
                    MinimumValue="1"
                    MaximumValue="100"
                    ErrorMessage="Please enter an integer <br /> between than 1 and 100.<br />"
                    EnableClientScript="False"
                    Display="Dynamic"
                    runat="server"/>

            </td>

            <td>

               &nbsp
 
            </td>

         </tr>

      </table>

    <%--Ova stranica omogucava da se nakon izbora
        elementa u DropDown List, isti ispise u Label. Posto se Label nalazi na strani
        servera, onda se i promena sadrzaja Label-a mora izvrsiti na strani servera,
        a to je jedino moguce ako server zna koji izbor je napravljen u DropDownList-i.
        Da bi server znao koji izbor je napravljen u DropDownListi, taj podatak se mora
        slati serveru svaki put kada se promeni izbor u DropDownListi. Slanje podataka
        serveru se vrsi HTTP POST metodom. Posto ponovo(vise puta) saljemo serveru podatke,
        to se zove PostBack. Podatke serveru o izboru u DropDownListi ne zelim da saljem
        klikom na neko dugme, vec automatski pri svakom izboru. To se radi pomocu svojstva
        AutoPostBack cija vrednost mora biti true i taj property stavljamo u DropDownList.
        Sada se pri svakom izboru elementa u DropDownList-i salje informacija o izboru serveru
        i stranica se ponovo ucitava tj. metod PageLoad se opet pokrece i u .aspx.cs
        fajlu se vrsi promena Labele jer se kod koji implementira promenu Labele
        nalazi u metodu PageLoad.

        Sustina je u tome da kada se korisniku posalje stranica, salje se samo
        klijentski deo tj. HTML, CSS i JS odnosno DropDownList se tretira kao obican
        HTML select i kada se tu klijent napravi izbor, server o tome mora biti obavesten zbog
        Label, a server se obavestava podacima koji se salju sa klijenta a to se radi
        PostBack-om odnosno post metodom. Stranica se ponovo ucitava na strani servera, menja se Label i
        opet salje klijentu sa izmenjenom label-om tj. njenim prevedenim elementom u HTML-u.
        Server generise funkciju doPostBack u Javascript-u koja to radi.        
        --%>
   

<asp:DropDownList ID="DropDownList2" runat="server"
        AutoPostBack="true" CssClass="form-control">

        <asp:ListItem>Item 1</asp:ListItem>
        <asp:ListItem>Item 2</asp:ListItem>
        <asp:ListItem>Item 3</asp:ListItem>
        <asp:ListItem>Item 4</asp:ListItem>
        <asp:ListItem>Item 5</asp:ListItem>
        <asp:ListItem>Item 6</asp:ListItem>


    </asp:DropDownList>

    <asp:Label ID="Label2" runat="server"
        Text="No Choice">

    </asp:Label>




</asp:Content>
