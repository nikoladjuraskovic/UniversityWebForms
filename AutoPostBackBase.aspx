<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AutoPostBackBase.aspx.cs" Inherits="WebControlsBase.AutoPostBackBase" %>
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
    <br />
    <br />


    <%--DropDown list popunjavam podacima iz baze i zatim u label ispod
        ispisujem izabrano prezime.
        Primer sa ListBox kontrolom:
        Primer: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.listcontrol.autopostback?view=netframework-4.8#system-web-ui-webcontrols-listcontrol-autopostback

        !NAPOMENA! Prvo procitati objasnjenje na AutoPostBack stranici!!!

       Zelimo da u DropDownList ispisem podatke iz baze, npr. prezimena studenata.
        Takodje, hocu da kada kliknem na neko prezime studenta u DropDownList, da se moj
        izbor ispise u Labeli. S obzirom da radimo sa podacima iz baze koji se pri izboru
        elementa u DropDownList-i ispisuju u Labeli koja je na strani servera,
        stranica mora biti ponovo ucitana od strane servera da bi server znao
        koji izbor je klijent(korisnik) napravio u DropDownList-i i zato mu salje tu informaciju
        o izboru. Informacija se salje Post metodom koristeci AutoPostBack.
        Server tek onda zna sta je klijent izabrao u DropDownList-i i ispisuje tu promenu u Label,
        i ponovo salje korisniku(klijentu) stranicu koja je izmenjena.
        Zato opet stavljamo da je DropDownList ima property AutoPostBack koji je true.
        Jos jednom, to znaci da se pri svakom izboru elementa u DropDownList-i,
        ponovo poziva metod PageLoad. E sad, posto se u PageLoad metodi nalazi i funkcija
        koja puni DropDownList-u podacima iz baze, a PageLoad se poziva vise puta
        zbog AutoPostBack-a, to znaci da ce se uvek pri svakom postback-u DropDownList-a
        puniti podacima iz baze i resetovati izbor na default tj. prvi element liste. 
        Zato mi necemo moci zato da izaberemo nijedan element u DropDownList-i osim prvog,
        odnosno u Label-u ce uvek pisati samo prvi element DropDownList-e.
        Da bismo ovaj problem resili, moramo nekako da u metodu PageLoad kazemo programu
        da dohvata podatke iz baze samo jednom tj. samo jednom da njima puni DropDownList
        odnosno samo kada se stranica prvi put ucitava tj. kada nije ucitana postBack-om.
        Postoji property IsPostBack koji je true ako je stranica ucitana postBackom, odnosno
        false ako stranica nije ucitana postBack-om tj. ucitana je prvi put.
        Stavicemo metod koji puni DropDownList-u podacima iz baze u if(IsPostBack == false)
        tako da se samo poziva pri prvom ucitavanju stranice. Time smo resili problem
        i sada sve radi kako treba.

        Kod koji menja Label treba da bude implementiran u metodu koji se poziva
        pri event-u tj. dogadjaju OnSelectedIndexChanged DropDownList-e tj. on se
        poziva kada se vrsi promena izbora elementa u DropDownList-i.

        Events(Dogadjaji) su neka desavanja na web stranici(klik npr. ili select necega)
        nakon cega se poziva metod.
        Docs: https://learn.microsoft.com/en-us/dotnet/standard/events/
        Docs: https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/events/
        
        
        
        --%>


    <h3>DropDownList With DataBase Data</h3>

    <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true"></asp:Label>

    <br />


    <asp:DropDownList ID="DropDownList1"
    runat="server"
     AutoPostBack="true"
     OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
         CssClass="form-control">

    </asp:DropDownList>

    <br />

<asp:Label ID="Label1" runat="server" Text="Nothing Selected"
     ForeColor="Red"  Font-Bold="true"></asp:Label>

</asp:Content>
