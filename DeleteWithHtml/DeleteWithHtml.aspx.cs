using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase.DeleteWithHtml
{
    public partial class DeleteWithHtml : System.Web.UI.Page
    {


        public List<Tuple<int, string, string, int>> students = new List<Tuple<int, string, string, int>>();
       


        protected void Page_Load(object sender, EventArgs e)
        {
             

            string connectionString = GetConnectionString();

            SqlConnection con = new SqlConnection(connectionString);
           


            using(con)
            {
                try
                {
                    con.Open();

                    students = SelectStudents(con);


                    if (Request.HttpMethod == "POST")
                    {

                        int id = int.Parse(Request.Form["id"]);

                        DeleteStudent(con, id);

                        Response.Redirect("~/DeleteWithHtml/DeleteWithHtml", false);

                    }


                    } catch(Exception ex)
                {
                    ErrorLabel.Text = "SERVER ERROR";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                    System.Diagnostics.Debug.WriteLine(ex.StackTrace);
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



        void DeleteStudent(SqlConnection con, int id)
        {

            SqlParameter p = new SqlParameter();

            p.Value = id;

            p.ParameterName = "@id";

            string query = "DELETE FROM Students WHERE StudentID = @id";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.Add(p);

            cmd.ExecuteNonQuery();

            System.Diagnostics.Debug.WriteLine("Obrisan student sa ID: " + id);
           

        }

        List<Tuple<int, string, string, int>> SelectStudents(SqlConnection con)
        {
            //upit dohvata 4 kolone za vise studenata te moramo imati listu tuple-ova
            List<Tuple<int, string, string, int>> students = new List<Tuple<int, string, string, int>>();


            string query = "SELECT StudentID, LastName, FirstName, Year FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);



            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    //napravi Tuple(torku) od 4 podatka i ubaci u listu
                    Tuple<int, string, string, int> student = new Tuple<int, string, string, int>(int.Parse(reader[0].ToString()), reader[1].ToString(), reader[2].ToString(), int.Parse(reader[3].ToString()));

                    students.Add(student);
                }
            }
            else
            {

                System.Diagnostics.Debug.WriteLine("No rows found");
            }
            reader.Close();

            return students;

        }
    }
}