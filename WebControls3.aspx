<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebControls3.aspx.cs" Inherits="WebControlsBase.WebControls3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%--
        ListBox DataBound:
        https://www.aspsnippets.com/Articles/Bind-Fill-Populate-ListBox-control-from-database-in-ASPNet-using-C-and-VBNet.aspx

        --%>

    <style>

        

        .blok{
            display: inline-block;
            margin: 20px;
            
        }

        table{
            width: 100%;
            
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

    <h1>ListBox, DropDownList</h1>


    <%--
        ListBox kontrola
        Sluzi za izbor jednog ili vise item-a tj. elemenata liste(neki podaci).
        Property Rows predstavlja broj redova koji se vide odjednom.
        ListItem su redovi podataka, ovde je to obican tekst.
        Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.listbox?view=netframework-4.8
        --%>

    <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true"></asp:Label>

    <div>

        <div class="blok">

    <h3>ListBox bez podataka</h3>

    <asp:ListBox ID="ListBox1"
        runat="server"
        Rows="3"
        SelectionMode="Single" CssClass="form-control">

         <asp:ListItem>HTML Item 1</asp:ListItem>
         <asp:ListItem>HTML Item 2</asp:ListItem>
         <asp:ListItem>HTML Item 3</asp:ListItem>
         <asp:ListItem>HTML Item 4</asp:ListItem>
         <asp:ListItem>HTML Item 5</asp:ListItem>
         <asp:ListItem>HTML Item 6</asp:ListItem>
         <asp:ListItem>HTML Item 7</asp:ListItem>


    </asp:ListBox>


       </div>

        <div class="blok">

            <h3>ListBox sa podacima iz C# Liste</h3>

            <%--Ovde ce nam izvor podataka biti c# List<string> tj. njeni elementi.
                Dohaveci su u backend-u stranice(aspx.cs)
                --%>

            <asp:ListBox ID="ListBox2" CssClass="form-control"
                runat="server"
                Width="100px">

            </asp:ListBox>

        </div>

        <div class="blok">

            <h3>ListBox sa podacima iz Baze</h3>

            <asp:ListBox ID="ListBox3" CssClass="form-control"
                runat="server"
                Width="100px"></asp:ListBox>


        </div>

    </div>

    <div>

        <div class="blok">

            <h3>DropDownList bez podataka</h3>

            <%--DropDownList - kontrola za prikaz liste elemenata.
                Meni elemenata pada dole(drop down) kada se klikne na nju.
                Docs: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.dropdownlist?view=netframework-4.8
                
                --%>

            <asp:DropDownList ID="DropDownList1"
                runat="server" CssClass="form-control">

                <asp:ListItem>HTML Item 1</asp:ListItem>
                <asp:ListItem>HTML Item 2</asp:ListItem>
                <asp:ListItem>HTML Item 3</asp:ListItem>
                <asp:ListItem>HTML Item 4</asp:ListItem>

            </asp:DropDownList>

        </div>

        <div class="blok">

            <h3>DropDownList, podaci iz C# Liste</h3>

            <asp:DropDownList ID="DropDownList2"
                runat="server" CssClass="form-control">
                
            </asp:DropDownList>


        </div>

        <div class="blok">

            <h3>DropDownList, podaci iz baze</h3>

            <asp:DropDownList ID="DropDownList3"
                runat="server" CssClass="form-control">

            </asp:DropDownList>

        </div>

        <div class="blok">

            <h3>HTML table, popunjen podacima iz C# Liste</h3>
            <%


/* podatke ispusujemo ASPX view engine sintaksom(mesanje html-a i c#-a).
ugradjena klasa table ima lepo formatiranu tabelu
To podrazumeva navodjenjem c# promenljivih izmedju <%= i % > tagova.
To sluzi da bismo prevodiocu razdvojili html od c#-a.
Imamo for petlju koja mora imati { i } u svom telu,
tako de je obavezno navesti i zatvorenu zagradu tj. }
nakon reda tabele.
Promenljive tj. samo jednu vrednost navodimo izmedju <%= i % > tagova,
dok citave naredbe izmedju <% i % >. Procenat je razdvojen od znaka
vece ovde da ne bih zatvorio komentar.
Listu smo napisali u aspx.cs-u sto je bolja praksa nego
da pisemo ovde izmedju < % i % > tag-ova.

Tabela ce imati onoliko redova(<tr> tag-ova) koliko iteracija
ima petlja for jer se nalaze u njoj.
    */
                %>
            
           

            <table class="table">
                <%for (int i = 0; i < data.Count; i += 3) //pretpostavka je da je br elemenata deljiv sa 3
                    { %>
                <tr>
                    <td><%= data[i] %></td>
                    <td><%= data[i+1]%></td>
                    <td><%= data[i+2] %></td>
                </tr>
                <% } %>
            </table>

                
            <h3>HTML table, popunjen podacima iz C# Liste 2. nacin</h3>
            <table class="table">

                <%foreach (var datum in data) { %>
                <tr>
                    <td><%= datum %></td>
                </tr>

                <% } %>
            </table>

            <h3>HTML table, popunjen C# objektom</h3>

            <%--mozemo dohvatati i property-je i metode objekata--%>

            <table class="table">
                <tr>
                    <td><%= stud.Name %></td>
                    <td><%= stud.Age %></td>
                    <td><%= stud.Hello() %></td>
                    
                </tr>
            </table>

            <h3>HTML table, popunjen C# Listom objekata</h3>

            <table class="table">

             <%  for (int i = 0; i < students.Count; i++)
                 { %> 

                <tr>
                    <td><%= students[i].Name %></td>
                    <td><%= students[i].Age %></td>
                    <td><%= students[i].Hello() %></td>
                </tr>

                <% } %>
            </table>

            


            <%--
                Ovde smo u html tabelu stavljali aspx sintaksom c# promenljive.
                Kako da ubacimo podatke iz baze? Mozemo rucno kao na sledecem linku:
                https://www.aspsnippets.com/Articles/Display-data-from-database-in-HTML-table-in-ASPNet.aspx
                ali necemo ovako raditi jer nema potrebe.
                Postoji Table web controla ali ona nema datasourceid property
                te nju nije moguce direktno povezati sa bazom. Mozda bismo
                mogli da dohvatimo podatke iz baze u neku C# List-u(stringova
                ili Tuple-ova ako ima vise kolona) i onda da
                ih ispisemo u asp Table slicno kao u HTML table. Mozete probati za domaci.
                Tuple: https://learn.microsoft.com/en-us/dotnet/api/system.tuple?view=net-6.0
                Mi cemo za tabelarni ispis koristiti posebne veb kontrole za rad
                sa podacima iz baze iz kategorije Data: GridView, ...
                
                --%>

            </div>

    </div>

    
    

</asp:Content>
