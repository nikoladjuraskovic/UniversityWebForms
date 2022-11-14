<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebControls1Backend.aspx.cs" Inherits="WebControlsBase.WebControls1Backend" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        

        .blok{
            display: inline-block;
            margin: 2px;
        }
    </style>


    <%--
        Ovde ne koristimo sqlDataSource kontrolu nego izvor podataka je sada
        u backend-u tj. u aspx.cs. Odnosno podaci se dohvataju metodama i event-ima.
        Sve kontrole organizujemo u spoljasnje i unutrasnje div-ove.
        Spoljasnji div-ovi su redovi, a u svakom redu, svaka kontrola je u
        unutrasnjem div-u(sa display = inline-block), da bi stajali jedan do drugog.
        U naredni primerima cemo koristiti Panel umesto div-a. Panel je Web Control-a
        koja se provodi u div kada stize do klijenta.
        --%>
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

    <h1>GridView, Chart</h1>

    <%--
        Veb Kontrole za rad sa podacima iz baze podataka.
        Ove C# klase pomazu i ubrzavaju rad CRUD operacija sa podacima iz baza podataka.
        Dohvataju se iz Toolbox(View->Toobox) i stavljaju se na veb stranu presvlacenjem i pustanjem tj.
        drag and drop. S obzirom da su ovo asp.net tagovi oni imaju svoje property-je pomocu kojih se 
        customize-uju. Ovde cemo ih customize-ovati u c# backend-u(aspx.cs) sve ono sto se odnosi
        na baze podataka(ADO.NET), dok cemo stilizovanje raditi i dalje na frontend-u tj. aspx.
        Ovako je mozda bolje zbog predikcija(intelissence) frontend naredbi na frontendu
        i predikcija backend naredbi na backendu.
        --%>

    


    

    

    <%-- Ovog puta pravimo stranice kao web form with master page i sav sadrzaj je unutar asp:Content-a
        sa atributom runat = "server" te ne moramo stavljati form element sa atributom runat="server"
        kao kada bismo pravili web form ali bez master page(obican web form).

       
        --%>

    

    <%--
        GridView - tabelarni prikaz podataka
        Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview?view=netframework-4.8
        
        emptydatatext je tekst koji se pojavljuje ako nema dohvacenih podataka upitom
        autogeneratecolumns moze biti false(sami pravimo kolone podataka pomocu Columns tag-a.
        Ako je autogeneratecolumns true onda se kolona same prave i treba zakomentarisati Columns tagove
        kao i sve unutar njih.
        Ako je allowpaging = True, to znaci da ako imamo vise redova u bazi da se nece svi prikazati
        na jednoj stranici nego samo nekoliko njih(prvih 3 ovde) pri cemu cemo imati link da se prikazu 
        narednih 3, itd. Tj. ne vidimo ih sve odjednom.
        PageSize svojstvom podesavamo koliko ce se podataka videti odjednom na stranici u datoj kontroli.
        Columns su kolone koje predstavljaju tip podatka a podaci se pisu u svakom redu.
        DataField je ime kolone iz baze, HeaderText je naziv kolone koji se korisniku prikazuje na stranici.
        ReadOnly da nema izmena, vec je samo za citanje.
        Ako zelite da vidite koje jos property-je imaju veb kontrole, mozete pogledati dokumentaciju
        ili kursorom selectovati prostor izmedju tagova i pritisnuti space i iskocice vam lista
        svih property-ja koje ima kontrola. Takodje se mogu videti klikom na kontrolu
        i u prozoru properties u donjem desnom uglu. Kontrole se takodje mogu napisati u backend-u i
        pritisnuti tacka da bi iskocile sve metode, event-i i properties.
        S obzirom da podatke dohvatamo u backend-u onda moramo implementirati sta se
        desava kada se promeni index paging-a u kontroli. Tj. sve moguce event-e
        koje su automatski implementira sqlDataSource kontrola, mi sada moramo
        sami da implementiramo(otkucamo kod).
        Pozove se property OnPageIndexChanging cija vrednost je ime metode.
        Najbolje je kliknuti misem u tag Gridview, pritisnuti space i izabrati
        OnPageIndexChanging, zatim nakon jednako sacekati da intelisense izbaci
        create new event i pritisnuti enter, tada se telo metoda samo napravi u backend-u(aspx.cs)
        --%>
    
    <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true"></asp:Label>


    <div>

        <div class="blok">

            <h3>GridView Selects Students</h3>


        <asp:GridView ID="StudentsView0" 
        runat="server"       
        emptydatatext ="No data"
        autogeneratecolumns="False">
        
       
            
        <Columns>
            <asp:BoundField DataField="StudentID" HeaderText="ID Studenta" ReadOnly="True" />
            
            <asp:BoundField DataField="LastName" HeaderText="Prezime" ReadOnly="true"/>
                
            <asp:BoundField DataField="FirstName" HeaderText="Ime"  ReadOnly="true" />
               
            <asp:BoundField DataField="Year" HeaderText="Godina" ReadOnly="true"/>
        </Columns>
            

    </asp:GridView>





        </div>

        <div class="blok">

        <h3>GridView Selects and Pages Students</h3>


    <asp:GridView ID="StudentsView1" 
        runat="server"       
        emptydatatext ="No data"
        autogeneratecolumns="False"
        allowpaging ="True"
        PageSize="3"
        OnPageIndexChanging="StudentsView1_PageIndexChanging">
        
       
            
        <Columns>
            <asp:BoundField DataField="StudentID" HeaderText="ID Studenta" ReadOnly="True" />
            
            <asp:BoundField DataField="LastName" HeaderText="Prezime" ReadOnly="true"/>
                
            <asp:BoundField DataField="FirstName" HeaderText="Ime"  ReadOnly="true" />
               
            <asp:BoundField DataField="Year" HeaderText="Godina" ReadOnly="true"/>
        </Columns>
            

    </asp:GridView>

       </div>

    <div class="blok">
    <h3>GridView Sorts Students</h3>

    <%--
        Ovak kontrola ima podrsku za sortiranje podataka po svim kolonama(atributima).
        Postize se: allowsorting="true". Zato je dobro napisati 
        autogeneratecolumns = True jer se tada kolone same naprave spremne za sortiranje
        Inace biste morali sami da kucate.
        Vise informacija o tome ovde: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.allowsorting?view=netframework-4.8
        Ova sortiranja se samo vrse na stranici, tj. NE menja se redosled podataka u bazi!
        Kada vam se otvori stranica, sortiranje se vrsi klikom na header kolone(ime kolone na koje se
        moze kliknuti tj. kao link). Da biste vec imali na neki nacin sortirane kolone na stranici, 
        mozete promeniti sql upit i staviti komandu order by po nekoj koloni.
        Npr. ako hocu da mi je odmah sortirano po godinama opadajuce.
        Ako stavimo allowsorting= "true" taj event moramo da implementiramo u backend-u.
        Vrednost property-ja OnSorting je ime metode u aspx.cs koja implementira sortiranje
        Slicno, ako ne koristimo sql Data Source, onda isto moramo sami da implementiramo
        metode update, delete, insert, sort, ...
        --%>

   
    
    <asp:GridView ID="GridView2" 
        runat="server"
        emptydatatext ="No data"
        autogeneratecolumns="True"
        allowpaging ="False"
        allowsorting="true"
         OnSorting="GridView2_Sorting">


    </asp:GridView>
    </div>


    <div class="blok">
    <h3>GridView Students and Exams</h3>

  

    <asp:GridView ID="GridView3" 
        runat="server"                   
        emptydatatext ="No data"
        autogeneratecolumns="True"
        allowpaging ="False"
        allowsorting="true"
        OnSorting="GridView3_Sorting">

    </asp:GridView>
        </div>
        
     </div>
    <%--
        Podatke koje smo ispisali u GridView gore, mozemo ispisati i graficki kontrolom ChartType.
        Tip koji koristimo je tip Column(podaci se prikazuju pravougaonikom tj. kolonom koji je 
        visi ako su vrednosti podataka vece) tj. to je jedan od mnogobrojnih nacina kako mozemo
        prikazivati podatke. DataSourceID je izvor podataka. Width je sirina. Postavite vecu
        da biste videli sve podatke.
        xValueMember = 0 znaci da ce se na x osi prikazati prva kolona upita iz datasource tj. imena.
        YValueMembers = 1 znaci da ce se na y osi prikazati druga kolona upita iz datasource tj. prosek.
        Chart dalje mozete menjati prelaskom misa na asp:Chart i klikom na > znak koji se pojavljuje.
        Kada krenete da kucate nesto u tag-ovima pogledajte predikciju teksta i videcete da chart
        ima razna svojstva koja mozete promeniti, npr. Color u asp:Series.
        Chart je bio ID=ctl00
        --%>

    <div>

        <div class="blok">

    <h3>Chart with students and their exam average</h3>

    <asp:Chart runat="server" ID="Chart1" Width="500px">
        <series>
            <asp:Series Name="Series1" XValueMember="0" YValueMembers="1" ></asp:Series>
        </series>
        <chartareas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </chartareas>
    </asp:Chart>

        </div>

        <div class="blok">

    <h3>GridView Update and Delete</h3>

    <%--Podatke u GridView mozemo menjati i brisati. Ako hocemo da menjamo(update) podatke,
        moramo u datasource dodati property updatecommand pri cemu ne menjam StudentID jer
        nam je takva baza podakata.
        Sa leve strane jednakosti kao i uvek navodimo imena kolona koje menjamo, a sa desne
        strane se navodi ime vrednosti koje je dohvaceno iz gridview kontrole ispred cega ide
        @ karakter kao kod parametara :)
        S obzirom da u gridview kontroli ispod imamo svojstvo autogeneratecolumns="True" to znaci
        da se imena vrednosti automatski dodeljuju tj. bice jednaka imenima kolona.
        Ako bismo sami kucali kolone, onda iza @ ide ime property-ja DataField elementa BoundField.
        Slicno vazi i za brisanje.
        --%>

  
         

       


    <%--U gridview kontroli stavljamo  AutoGenerateEditButton ="true" da bi se dugme za
        editovanje samo napravilo. Slicno i za brisanje. U Gridview moramo
        dodati svojstvo DataKeyNames="StudentID" da bi program znao koja je
        vrednost parametra @StudentID da bi mogao da brise studenta.
        Svaki event vezan za brisanje, editovanje i sortiranje se sada MORA
        implementirati u Backend-u. Koriste se RowEditing, Sorting i RowDeleting eventi.
        Potrebno je i row Cancelling da implementiramo, kao i RowUpdating.
        --%>

    <asp:GridView ID="GridView4" 
        runat="server"       
        emptydatatext ="No data"
        autogeneratecolumns="true"
        allowpaging ="False"
        allowsorting="true"
        AutoGenerateEditButton ="true"
        AutoGenerateDeleteButton ="true"
        DataKeyNames="StudentID"
        OnSorting="GridView4_Sorting"
        OnRowDeleting="GridView4_RowDeleting"
        OnRowEditing="GridView4_RowEditing"
        OnRowCancelingEdit="GridView4_RowCancelingEdit"
        OnRowUpdating="GridView4_RowUpdating"
        >


 
    </asp:GridView>


            

        </div>

        <%--Hocemo da prikazemo sliku u kolonu GridView-a --%>

        <div class="blok">
        <h3>GridView with Image</h3> <%--TODO, How to Insert Image in GridView?--%>

            <asp:GridView ID="GridView5"
                runat="server"              
                EmptyDataText="No data"
                AutoGenerateColumns="False"
                AllowPaging="False"
                PageSize="3">


                <Columns>
                    <asp:BoundField DataField="StudentID" HeaderText="Student ID" ReadOnly="True" />

                    <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="true" />

                    <asp:ImageField DataImageUrlField="" DataImageUrlFormatString="" ControlStyle-Width="100" ControlStyle-Height="100" HeaderText="My Image" />
                </Columns>


            </asp:GridView>


            </div>

    </div>

    <div>


        <div class="blok">

            <h3>GridView with Exams Stylized</h3>

            <%--Hocemo ispis GridView ali stilizovan u zavisnosti od vrednosti
                podataka u bazi, npr. za svaku ocenu razlicita boja reda, tj. za pad(1) je crvena
                a za ostale ocene je zelena boja--%>

            <%--Video sa objasnjenjima:
                https://www.youtube.com/watch?v=F7ADEYhwqxk

                https://stackoverflow.com/questions/18670189/how-to-style-asp-net-gridview-cells-with-colour-based-on-cell-value
                --%>

          
                <%--Da bismo postigli bojenje redova u zavisnosti od vrednosti podataka u bazi,
                    moramo dodati property OnRowDataBound event(dogadjaj) cija vrednost je ime metoda
                    koja je implementirana u .asp.cs tj. u backend delu stranice tj. tu su naredbe koje
                    se izvrsavaju kada se podaci iz baze dovuku i ispisu u GridView kontroli.
                    RowStyle-HorizontalAlign atribut samo govori da podatke centriram u celijama kontrole.
                    Postoji jos property-ja kako mozete dodatno stilizovati vase kontrole.
                    Pogledajte u dokumentaciji: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview?view=netframework-4.8
                    --%>

            <asp:GridView ID="GridView6"
                EmptyDataText="No data"
                AutoGenerateColumns="False"
                runat="server"
                RowStyle-HorizontalAlign="Center"
                OnRowDataBound="GridView6_RowDataBound"
                Font-Bold="true"
                Font-Size="14pt"
                RowStyle-BorderStyle="Solid"
                RowStyle-BorderColor="Black"
                RowStyle-BorderWidth="2px">

                <Columns>
                    <asp:BoundField DataField="StudentID" HeaderText="ID Studenta" ReadOnly="True" />


                    <asp:BoundField DataField="Grade" HeaderText="Ocena" ReadOnly="true" />
                </Columns>

            </asp:GridView>
            <%--U asp:BoundField postoji property ItemStyle-BackColor="Yellow" za podesavanje boje reda.
                Select komanda dohvata samo Ne NULL vrednosti ocena jer ako bi dohvatao null
                onda bi u metodi GridView6_RowDataBound u backend-u bio ispaljen izuzetak jer
                se null vrednost ne moze konvertovati u validan float tip!--%>
            

        </div>

        <div class="blok">

            <%--
                CssClass je css klasa koju dodeljujemo GridView kontroli.
                Zasto je ovo moguce? Pogledajte view page source kada pokrente sajt i vidite kako se
                korisniku render-uje GridView.
                Jos imamo neka svojstva koja dodatno stilizuju GridView.
                Njihova imena lepo opisuju sta rade.
                AutoGenerateSelectButton omogucava selectovanje jednog reda u gridview.
                RowStyle je css dizajn reda.
                SelectedRow Style je css dizajn izabranog(selektovanog reda).
                --%>

            <h3>Grid View Select, Stylized</h3>

            <asp:GridView ID="GridView7"
                runat="server"                
                EmptyDataText="No data"
                AutoGenerateColumns="True"
                AllowPaging="False"
                AllowSorting="true"
                CssClass="table"
                Font-Bold="true"
                Font-Size="14pt"
                RowStyle-CssClass="text-center"
                SelectedRowStyle-BackColor="#666699"
                AutoGenerateSelectButton="True"
                AutoGenerateDeleteButton="True"
                AutoGenerateEditButton="true"
                DataKeyNames="StudentID"
                SelectedRowStyle-ForeColor="Red"
                OnSorting="GridView7_Sorting"
                OnRowDeleting="GridView7_RowDeleting"
                OnRowEditing="GridView7_RowEditing"
                OnRowCancelingEdit="GridView7_RowCancelingEdit"
                OnRowUpdating="GridView7_RowUpdating">
            </asp:GridView>


        </div>



    </div>



</asp:Content>
