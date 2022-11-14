using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class Search : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection(GetConnectionString());

            if (!IsPostBack) /*ako stranica nije ucitana postBack-om, tj 
                              ako je ucitana prvi put*/
            {
                /*ovako radimo da bi DropDownList sacuvao promene naseg izbora i ispravno
                 dohvatio trazene podatke iz baze. Detaljna objasnjenja
                se nalaze na stranici AutoPostBackBase.*/

                try
                {

                    using (con)
                    {
                        con.Open();

                        DropDownList1_Show(con);
                    }

                }
                catch (Exception e2)
                {
                    ErrorLabel.Text = "SERVER ERROR";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                    System.Diagnostics.Debug.WriteLine("Exception Message " + e2.Message);
                    System.Diagnostics.Debug.WriteLine("Stack Trace " + e2.StackTrace);
                }

            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            /* otvaramo opet konekciju zbog klika na dugme,
             * ako neko smisli nacin da je dovoljno samo jednom otvoriti
             * konekciju i za GridView i za DropDown list, neka pise mejl meni
             */
            try
            {

                using (con)
                {
                    con.Open();

                    string searchParameter = TextBox1.Text.Trim();

                    int yearSearch = int.Parse(DropDownList1.SelectedItem.Value);

                    GridView1_Show(con, searchParameter, yearSearch);

                }

            } catch(Exception ex)
            {
                ErrorLabel.Text = "SERVER ERROR";
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("Exception Message " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + ex.StackTrace);
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

        void GridView1_Show(SqlConnection con, string searchParameter, int yearSearch)
        {

            SqlParameter p = new SqlParameter();
            SqlParameter p2 = new SqlParameter();

            /*da bi mogli da pretrazujemo ne samo tacna prezimena, vec prezimena koja pocinju
             sa prosledjenim parametrom
            SQL Like operator: https://www.w3schools.com/sql/sql_like.asp
             */
            p.Value = searchParameter + "%";
            p2.Value = yearSearch;

            p.ParameterName = "@searchParameter";
            p2.ParameterName = "@year";

            /*iza like naredbe ide string kojim pocinje trazena kolona,
             nakon toga pretraga po godini*/
            string query = "SELECT * FROM Students " +
                            "WHERE LastName LIKE @searchParameter " + 
                            "AND Year = @year";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.Add(p);
            cmd.Parameters.Add(p2);
           
                SqlDataReader reader = cmd.ExecuteReader();

                GridView1.DataSource = reader; //izvor podataka je DataReader

                GridView1.DataBind(); // vezi podatke za GridView kontrolu

                reader.Close(); //zatvori reader, NEOPHODNO jer cemo ga koristiti nadalje
                   
        }

        void DropDownList1_Show(SqlConnection con)
        {
            //distinct da bi se svaka godina dohvatila jednom
                string query = "SELECT DISTINCT(Year) FROM Students";

                SqlCommand cmd = new SqlCommand(query, con);

                SqlDataReader reader = cmd.ExecuteReader();

                DropDownList1.DataSource = reader;

                DropDownList1.DataValueField = "Year";

                DropDownList1.DataBind();

                reader.Close();
          
        }
    }
}