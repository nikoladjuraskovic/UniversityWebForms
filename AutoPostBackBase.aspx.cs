using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class AutoPostBackBase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(GetConnectionString());

            /*
             Kod koji dohvata podatke iz baze i menja label u skladu
            sa izborom DropDownList-e moramo staviti u if(!IsPostBack) da bi se izvrsavao
            kada stranica biva ucitavana prvi put tj. ne preko AutoPostBack.
            Ovo radimo da bi se izvrsio tacan prikaz izabranog podatka u
            Label
             */
            if (!IsPostBack) //isto sto i if(IsPostBack == false)
            {

                using (con)
                {
                    con.Open();

                    PopulateDropDownListWithBase(con);


                }

           

            }
        }


        string GetConnectionString()
        {
            /*
             Konekcioni string koji se koristi je onaj kada ja baza pravljena
            rucno u Sql Server Management Studiju i razlikuje se od onog
            koji je koriscen kada smo bazu pravili koristeci Entity Framework
            tj. preko model binding-a(kada smo pravili klasu Students itd.)
            Novi konekcioni string od sada koristim a stari preko Entity Framework-a
            ostavljam u komentaru ako ste kod kuce bazu pravili preko modela.
            Bazu naravno mozete obrisati i napraviti istu novu u Sql-u
            kao na bazama i onda koristiti novi konekcioni string.
            Konekcioni string baze pravljenje SQL-om ima Catalog=University.
            Konekcioni string baze pravljenje Entity Framework-om ima Catalog=University.Models.SchoolContext.
            Ostalo je isto.
            Mozda je najbolje za vas imati bazu napravljenu SQL-om i da koristite konekcioni
            string koji se ovde koristi.
             */

            return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            //return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University.Models.SchoolContext;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        }



        void PopulateDropDownListWithBase(SqlConnection con)
        {

            string query = "SELECT LastName FROM Students;";

            SqlCommand cmd = new SqlCommand(query, con);

            //izvor podataka listbox-a je DataReader


            try
            {
                SqlDataReader reader = cmd.ExecuteReader();

                DropDownList1.DataSource = reader;

                //ovde kazemo listbox-u koje podatke hocemo da prikazemo
                DropDownList1.DataValueField = "LastName";

                //vezi podatke za ListBox
                DropDownList1.DataBind();



                reader.Close();
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }
        }
        //event metod koji se pokrece ako se promeni izbor elementa
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedItem != null)
            {
                //ispis izbor u label
                Label1.Text = DropDownList1.SelectedItem.Value;

                Label1.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                Label1.Text = "Nothing Selected";
            }
        }
    }
}