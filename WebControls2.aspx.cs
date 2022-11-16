using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class WebControls2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = GetConnectionString();
            SqlConnection con = new SqlConnection(connectionString);

            using (con)
            {
                try
                {

                    con.Open();

                    DetailsView1_Show(con);

                    GridView1_Show(con);

                    //DetailsView2_Show(con);

                    //FormView1_Show(con);

                }
                catch (Exception ex)
                {

                    ErrorLabel.Text = "SERVER ERROR";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                    System.Diagnostics.Debug.WriteLine("Exception Message " + ex.Message);
                    System.Diagnostics.Debug.WriteLine("Stack Trace " + ex.StackTrace);
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

        void DetailsView1_Show(SqlConnection con)
        {
            string query = "SELECT LastName, Year, StudentID FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);
          
            SqlDataReader reader = cmd.ExecuteReader();

            DetailsView1.DataSource = reader;

            DetailsView1.DataBind();

            reader.Close();
           

        }

        void GridView1_Show(SqlConnection con)
        {
            string query = "SELECT LastName, Year, StudentID FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);
         
            SqlDataReader reader = cmd.ExecuteReader();

            GridView1.DataSource = reader;

            GridView1.DataBind();

            reader.Close();
           
        }

        void DetailsView2_Show(SqlConnection con)
        {

            //TODO
            
        }

        void FormView1_Show(SqlConnection con)
        {
            string query = "SELECT * FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);

        

                /* ne mozemo da radimo preko DataReader-a jer FormView
                 * podrazumeva skrolovanje u oba smera kroz podatke,
                 * zato moramo da primenimo DataAdapter
                 * 
                 */

                SqlDataAdapter adapter = new SqlDataAdapter(query, con);

                DataTable students = new DataTable();

                adapter.Fill(students);

                FormView1.DataSource = students;

                FormView1.DataBind();            


        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {
            //TODO
            //https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.formview.pageindexchanging?view=netframework-4.8
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                ErrorLabel.Text = "SERVER ERROR";
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Exception.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.Exception.StackTrace);
                e.ExceptionHandled = true; // obavezno navesti inace izuzetak nece biti obradjen!
            }
        }
    }
}