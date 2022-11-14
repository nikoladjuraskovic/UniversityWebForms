using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class DeleteWithWebControls : System.Web.UI.Page
    {

        

        protected void Page_Load(object sender, EventArgs e)
        {
            
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


        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = GetConnectionString();

            SqlConnection con = new SqlConnection(connectionString);

            try
            {

                
                GridViewRow row = GridView1.SelectedRow;
                //bojimo select u boju pozadina, kao da nema opcije select 
                // jer je vec izabrano
                row.Cells[0].ForeColor = System.Drawing.Color.SlateBlue;

                //Cells[1] je pozicija id-a jer Cells[0] je kolona sa select
                int id = Convert.ToInt32(row.Cells[1].Text.Trim());

                DeleteStudentParameter(con, id);

                /*Objasnjenje u InsertWithWebControls*/
                Response.Redirect("~/DeleteWithWebControls", false);

            } catch(Exception ex)
            {
                ErrorLabel.Text = "SERVER ERROR";
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("Exception Message: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace: " + ex.StackTrace);
            }
        }

        void DeleteStudentParameter(SqlConnection connection, int id)
        {
            using (connection)
            {
                connection.Open();

                SqlParameter p1 = new SqlParameter();

                p1.Value = id;

                p1.ParameterName = "@id";

                string query = "DELETE FROM Students " +
                                "WHERE StudentID = @id";

                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.Add(p1);

                command.ExecuteNonQuery();
            }
        }
    }
}