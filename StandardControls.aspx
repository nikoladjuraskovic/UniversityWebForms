<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardControls.aspx.cs" Inherits="WebControlsBase.StandardControls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <%--PODSETNIK ZA SVE KONTROLE--%>

    <%--


        Komentar u ASP-u(.NET Framework).
        Radimo ASP.NET iz .NET Framework-a 4.8
        --%>

    <%--
        Veb Kontrole.
        .NET Framework 4.8 sadrzi klase za pravljenje veb
        serverskih kontrola na veb stranici. Izvrsavaju se na strani SERVERA i
        imaju kontrole za forme, npr. unos podataka(input) ili dugme.
        Mi cemo raditi veb kontrole za forme, tako da nase kontrole moraju biti
        unutar form tag-a sa atributom runat cija je vrednost server,
        dakle: <form runat ="server">. Ovo je neophodno ako se pravi web form
        stranica bez master page, ali se nepise ako se pravi web form with master
        page jer onda u master page-u vec postoji form tag tako da ga ne moramo
        pisati.
        Veb kontrole su zapravo posebni asp-ovi
        tagovi koji se ubacuju u HTML kod. Imaju i svoje posebne atribute(svojstva).
        OBAVEZAN je atribut runat sa vrednoscu server u svim kontrolama!
        Svaka veb kontrola pocinje tag-om asp: nakon cega ide naziv veb kontrole.
        Ove veb kontrole su zapravo C# klase.
        Web Control je bazna klasa svih veb kontrola.
        O njoj vise ovde: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.webcontrol?view=netframework-4.8
        Kontrole podesavate:
        1. menjanjem njihovih svojstava rucno tako sto kucate u tag-u(aspx).
        Najbolje je da kursor pozicionirate na tag i pritisnete space, tada imate
        intelisense za sve metode, event-e, property-je...
        2. Kliknete na ime kontrole i svojstva menjate u properties window(obicno
        se nalazi dole sa desne strane).
        3. Klikom na kontrolu u Design-u(preview stranice kako bi izgledala pri
        prevodjenju). OPREZ! Nije uvek precizan izgled stranice, najbolje
        je prevesti tj. pokrenuti projekat i videti.
        Diskusija o kontrolama (HTML tagovi vs ASP.NET Web Controls:
        https://learn.microsoft.com/en-us/troubleshoot/developer/webapps/aspnet/development/server-controls
        Sve ove web kontrole se korisniku salju kao HTML elementi tj.u to
        se prevode kada stignu do browser-a, samim tim ih je moguce
        stilizovati CSS-om i bibliotekom Bootstrap. To se radi pomocu
        property-ja CssClass i mnogih drugih. Mozemo i sami napraviti css klasu
        i onda kontrolu dodeliti da pripada toj klasi.
        Kada pokrente stranicu i kliknete view page source videce u koji
        html element se prevodi koja kontrola.

        Server                              Klijent

        ASP.NET(Web Control-e)              HTML(tag-ovi)
      
        Label         --------------->      span
        TextBox       --------------->      textarea
        Button        --------------->      input type='submit'
        ListBox       --------------->      select
        Calendar      --------------->      table
        Image         --------------->      img
        DropDownList  --------------->      select
        HyperLink     --------------->      a
        LinkButton    --------------->      a
        Table         --------------->      table
        Panel         --------------->      div
        
        --%>

    <style>
        /*pozeljno je da css stavljate u poseban fajl(desnim klikom na ime projekta
            i onda add new item(css stylesheet)  a sve fajlove u poseban folder
            */

        .blok {
            display: inline-block;
            margin: 15px;
        }

        #client_button{
            background-color:  gold;
            color: black;
            padding: 4px;
        }

        .label_style{
            padding: 4px;
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

    <h1>Web Controls</h1>
    <br />
    <br />


    <!-- kotrola smo stavljali u div-ov da bi ih pozicionirali
        jedne uz druge(u istom redu) pomocu display:inline-block.
        Moglo je i preko kontrola Panel koje se prevode u div-ove
        kada se salju klijentu.
        -->

    <div>

        <div class="blok">

            <h3>Label</h3>
            <!--Labela. Za ispis teksta-->
            <br />
            <!--ID je identifikator elementa
        Text je ono sto ispisuje
        runat je mesto izvrsavanja, OBAVEZNO za sve asp kontrole.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.label?view=netframework-4.8 -->
            <asp:Label ID="lblOutput"
                Text="Neki Tekst u Labeli"
                runat="server" />

        </div>

        <div class="blok">

            <br />
            <h3>Text Box</h3>
            <!--Text Box. Za unos.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.textbox?view=netframework-4.8
                TextMode je nacin prikazivanja texta, ako stavimo singleline bice u jednoj liniji(obican textbox).
                Za MultiLine je vise linije i moze mu se menjati velicina.
                Obrisite TextMode="MultiLine" da biste videli obican textBox
                -->
            <asp:TextBox ID="TextBox1"
                runat="server" TextMode="MultiLine" />
            <br />
        </div>
        <div class="blok">
            <%--Ako zelimo da dodatno customize-ujemo label klasu sa svojstvima
                kojih nema u njegovom properties kao sto je padding, onda mu dodelimo
                css klasu koju smo definisali u obicnom css-u.
                --%>
            <asp:Label ID="Label1" runat="server" Text="Server Button" Font-Size="X-Large" BackColor="#3333CC" ForeColor="White" CssClass="label_style"></asp:Label>
            <br />
            <br />
            <!--Dugme. Za validaciju forme npr.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.button?view=netframework-4.8 -->
            <asp:Button ID="Button1"
                Text="Server Validate"
                runat="server" CssClass="btn btn-primary"
                OnClick="Button1_Click"/>
            
            <br />
            <%--button je stilizovan boostrsap css klasom--%>
        </div>

        <div class="blok">

            <h3 id="client_button">Client Button</h3>
            <input id="Button2" type="button" value="Client Validate" />

        </div>

        <div class="blok">

            <h3>List Box and List Items</h3>
            <br />
            <!--Lista nekih elemenata od kojih se biraju opcije-->
            <!--ListItem je element liste
             Selected, da li je izabran element liste
             Izmedju tagova list itema se ispisuje ono sto vidi korisnik,
            Value je interna vrednost koja se  moze iskoristiti u backend-u.
               Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.listbox?view=netframework-4.8 
                
                -->
            <asp:ListBox ID="ListOperator"
                runat="server">

                <asp:ListItem Selected="True" Value="1">Item1</asp:ListItem>
                <asp:ListItem Value="2">Item2</asp:ListItem>
                <asp:ListItem Value="3">Item3</asp:ListItem>
                <asp:ListItem Value="4">Item4</asp:ListItem>
                <asp:ListItem Value="4">Item5</asp:ListItem>
                <asp:ListItem Value="4">Item6</asp:ListItem>


            </asp:ListBox>


        </div>

        <div class="blok">
            <%--Calendar, za biranje datuma i vremena.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.calendar?view=netframework-4.8
                --%>

            <h3>Calendar</h3>



            <asp:Calendar ID="Calendar1" runat="server">


                <OtherMonthDayStyle ForeColor="LightGray"></OtherMonthDayStyle>

                <TitleStyle BackColor="Blue"
                    ForeColor="White"></TitleStyle>

                <DayStyle BackColor="gray"></DayStyle>

                <SelectedDayStyle BackColor="LightGray"
                    Font-Bold="True"></SelectedDayStyle>


            </asp:Calendar>

        </div>

       
        <div>

            <div class="blok">
                <%--
                    Image - kontrola za prikaz slika.
                    Dokumentacjia: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.image?view=netframework-4.8
                    --%>
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/aspnet-featured.jpg" BorderColor="#0099FF" BorderWidth="1px" Width="200px" />

            </div>

            <div class="blok">

                <h3>DropDownList </h3>

                <%--DropDownList - kontrola za prikaz liste elemenata.
                Meni elemenata pada dole(drop down) kada se klikne na nju.
                Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.dropdownlist?view=netframework-4.8
                Selected property znaci da je unapred izabran item, u nasem slucaju treci
                --%>


            <asp:DropDownList ID="DropDownList1"
                runat="server">

                <asp:ListItem>Item 1</asp:ListItem>
                <asp:ListItem>Item 2</asp:ListItem>
                <asp:ListItem Selected="true">Item 3</asp:ListItem>
                <asp:ListItem>Item 4</asp:ListItem>

            </asp:DropDownList>


            </div>

            <div class="blok">

                <%--Hyperlink kontrola za postavljanje linkova ka drugim stranicama.
                    Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.hyperlink?view=netframework-4.8
                    U properties postavite lokaciju navigateUrl
                    --%>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Validators.aspx">Validators</asp:HyperLink>


            </div>

            <div class="blok">

                <%--LinkButton je button koji izgleda kao link.
                    Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.linkbutton?view=netframework-4.8
                    Klikom na ovo dugme promenicemo sadrzaj nekog label elementa.
                    --%>

                <asp:LinkButton ID="LinkButton1" runat="server"
                     Text="LinkButton"
                     ForeColor="Violet"
                     OnClick="LinkButton1_Click">LinkButton</asp:LinkButton>

                <asp:Label ID="Label2" Text="Not Clicked" runat="server" 
                     ForeColor="Red"/>

            </div>

            <div class="blok">
                <%--Table Web Control, za tabelarni prikaz informacija.
                    Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.table?view=netframework-4.8
                    --%>

                <asp:Table ID="Table1" runat="server"
                    CellPadding="10"
                    GridLines="Both"
                    HorizontalAlign="Center" CssClass="table">
                    <asp:TableRow>
                        <asp:TableCell>
                            Row 0, Col 0
                        </asp:TableCell>
                        <asp:TableCell>
                            Row 0, Col 1
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            Row 1, Col 0
                        </asp:TableCell>
                        <asp:TableCell>
                            Row 1, Col 1
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>

            </div>

            

          
        </div>

        
        
    </div>



<script>
    //promena boje naslova klikom na dugme na strani klijenta,
    //akcija se ponistava refresh-ovanjem stranice u browser-u
    let button = document.getElementById("Button2");

    button.addEventListener("click", function (ev) {
        let h3 = document.getElementById("client_button");

        h3.style.color = 'red';
    }
        );



</script>






</asp:Content>


