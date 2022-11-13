<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebControls2.aspx.cs" Inherits="WebControlsBase.WebControls2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    

    <style>

        

        .blok{
            display: inline-block;
            margin: 20px;
        }

        h3#details{
            color:red;
        }
        .moja_tabela{
            border: 2px solid black;
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

    <h1>DetailsView, FormView</h1>

    <%--Podatke za kontrole ovde cemo dohvatiti na oba nacina. tj. u aspx.cs ce biti
        nazivi metoda a ovde stavljamo sqldatasource tag-ove. Da biste videli
        da rade oba nacin samo zakomentarisite metode u backend-u i njihove pozive i
        dodajte datasourceid="ime sql data source  tag-a"
        --%>
        

    <div>

        <div class="blok">


            <%--
                GridView Kontrole je mogla da selectuje, updatetuje i delete-uje elemente, ali NE i insert.
                DetailsView moze sve od CRUD operacija. To je jos jedna od veb kontrola za rad sa podacima.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.detailsview?view=netframework-4.8
                --%>

            <h3>DetailsView</h3>

            <%--
                Details view prikazuje vrednost samo jednog reda iz baze.
                --%>

            <asp:SqlDataSource ID="SqlDataSource1"
                runat="server"
                 SelectCommand="SELECT LastName, Year, StudentID FROM Students"
                  ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False">


            </asp:SqlDataSource>

            <%--Ubaciti DataSourceID="SqlDataSource1"--%>
            <asp:DetailsView ID="DetailsView1" 
                             runat="server"
                             Height="50px"
                             Width="125px"
                             AutoGenerateRows="true"
                             DataKeyNames="StudentID"
                             >
            </asp:DetailsView>

        </div>

        <div class="blok">

            <%--DetailsView cemo koristiti u kombinaciji sa GridView.
                DetailsView ce prikazivati informacije reda selektovanog preko GridView.
                GridView je povezan na dataSource koji dohvata podatke koje zelimo da vidimo
                za svaki red, ovde je to samo LastName i Year jer njih prikazujemo.
                ID je OBAVEZNO dohvatiti jer je to primary key.
                Dok u sqlDataSource za DetialsView dohvatamo vise informacije(Detalje, outuda i ime).
                Zato u dataSource details-view-a dohvatamo sve i OBAVEZNO navodimo
                u WHERE klazi nazive parametra ID da bi znali kog studenta
                da prikazemo u Details View. Takodje u sqlDataSource za
                DetailsView navodimo parametar na osnovu kojeg dohvatamo
                detalje(ostale podatke) u select parameters tag-ovima.--%>

            <h3>DetailsView with GridView</h3>

            <%--Ubaciti DataSourceID="SqlDataSource1"--%>
            <asp:GridView ID="GridView1" runat="server" 
              AutoGenerateColumns="False"
              DataKeyNames="StudentID"
                 SelectedRowStyle-BackColor="#ff0000"
                 RowStyle-Font-Bold="true"
                 RowStyle-CssClass="text-center"
                 >
              <Columns>
                <asp:CommandField ShowSelectButton="True" />               
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />               
                <asp:BoundField DataField="Year" HeaderText="Year" />
              </Columns>
            </asp:GridView>

            <h3 id="details">Details For Selected Row:</h3>

            <%--Ubaciti DataSourceID="DetailsSource1"--%>
            <asp:DetailsView ID="DetailsView2"
                runat="server" 
                AutoGenerateRows="True"
                DataKeyNames="StudentID"
                DataSourceID="DetailsSource1"
                Height="50px"
                Width="301px"
                RowStyle-CssClass="text-center"
                CssClass="table">
            </asp:DetailsView>

            <asp:SqlDataSource ID="DetailsSource1"
                runat="server"
                SelectCommand="SELECT * FROM Students WHERE StudentID = @StudentID"
                ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1"
                        Name="StudentID"
                        PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>

            </asp:SqlDataSource>


        </div>

        <div class="blok">

            <h3>FormView</h3>

            <%--FormView kontrola - sluzi za prikazivanje jednog reda podataka iz izvora
                podataka koristeci user defined template(korisnicki definisane sablone).
                Ovde sam ja podatke predstavljao preko obicne html tabele stilizovane
                css-om.
                Ovde mozete prikaz podataka stilizovati preko property-ja FormView-a ili preko
                CSS-a vaseg sablona tj. template. Ovde smo css-om stilizovali nas sablon(html tabela).
                FormView omogucava operacije edit, update i delete.
                PagerSettings definise nacin skrolovanja kroz podatke.
                Dokumentacija: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.formview?view=netframework-4.8
                --%>
             <%--Ubaciti DataSourceID="SqlDataSource2"
                 Ako izbacimo DataSourceID i rucno dohvatamo podatke,
                 moramo obraditi event menjanja indexa:
                 OnPageIndexChanging="FormView1_PageIndexChanging"--%>
            <asp:FormView ID="FormView1"
                runat="server"
                DataSourceID="SqlDataSource2"
                AllowPaging="true"
                DataKeyNames="StudentID">

            <itemtemplate>
        
                <%--
                    Eval naredba ide izmedju ASPX view engine tagova(<% i %>) sluzi za ubacivanje
                    podataka, promenljivih iz C#(backend-a) na veb stranicu, slicno
                    Razor sintaksi iz ASP.NET Core(pomocu @{ i })
                    --%>

          <table class="table moja_tabela">
            <tr>
               <td>
                   <h3>Student ID: </h3>
               </td>
              <td>
                  <h3><%# Eval("StudentID")%></h3>
              </td>
            </tr> 

              <tr>
                  <td>
                   <h3>First Name: </h3>
               </td>
              <td>
                <h3><%# Eval("FirstName") %></h3>      
                     
              </td>

              </tr>

                <tr>
                  <td>
                   <h3>Last Name: </h3>
               </td>
              <td>
                <h3><%# Eval("LastName") %></h3>      
                     
              </td>

              </tr>

              <tr>
                  <td>
                   <h3>Year: </h3>
               </td>
              <td>
                <h3><%# Eval("Year") %></h3>      
                     
              </td>

              </tr>
            
          </table>
        
        </itemtemplate>

                <pagersettings position="Bottom"
                     mode="NextPrevious"/>

            </asp:FormView>


            <asp:SqlDataSource ID="SqlDataSource2"
                runat="server"
                SelectCommand="SELECT * FROM Students" 
                ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
                >

            </asp:SqlDataSource>


        </div>

    </div>



</asp:Content>
