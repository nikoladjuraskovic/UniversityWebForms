using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class CrudWithHtmlJS : System.Web.UI.Page
    {

        //mora biti public i u klasi definisan da bi se video na aspx stanici
        public List<Tuple<string, string, int>> students = new List<Tuple<string, string, int>>();

        




        protected void Page_Load(object sender, EventArgs e)
        {

            string connectionString = GetConnectionString();

            SqlConnection connection = new SqlConnection(connectionString);

            //List<Tuple<string, string, int>> students = new List<Tuple<string, string, int>>();

            using(connection)
            {

                try {

                    connection.Open();

                    students = SelectStudents(connection);

                    if (Request.HttpMethod == "POST")
                    {

                        /*Ako je http metod post tj. ako su poslati podaci
                         * serveru, dohvati ih pomocu Form property-ja
                         * Request objekta na osnovu name property-ja input tag-
                        Javascript ne radi, te cemo validaciju izvrsiti na strani servera
                        i sami ispaliti nase izuzetke ako se desi greska.
                         */
                        string FirstName = Request.Form["FirstName"];
                        if (FirstName == "")
                        {
                            throw new Exception("Name Not Inserted!");
                        }

                        string LastName = Request.Form["LastName"];

                        if(LastName == "")
                        {
                            throw new Exception("Last Name Not Inserted!");

                            
                        }

                        if (Request.Form["Year"] == "")
                        {
                            throw new Exception("Year Not Inserted!");

                        }


                        int year = int.Parse(Request.Form["Year"]);

                        

                        InsertStudent(connection, FirstName, LastName, year);

                        System.Diagnostics.Debug.WriteLine("Uneto Ime: " + FirstName);
                        System.Diagnostics.Debug.WriteLine("Uneto Prezime: " + LastName);
                        System.Diagnostics.Debug.WriteLine("Uneta godina: " + year);

                        /*preusmeravanjem na stranicu na kojoj se nalazim se
                         * refreshuje tabela sa studentima pri cemu se vide
                         * novo ubaceni studenti.
                         */
                        Response.Redirect("~/CrudWithHtmlJS", false);
                    }

                }
                catch (Exception ex)
                {
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

        void InsertStudent(SqlConnection con, string FirstName, string LastName, int year)
        {

          
                    string insert = "INSERT INTO Students (FirstName, LastName, Year) " +
                                    "VALUES (@name, @surname, @year);";

                    SqlCommand command = new SqlCommand(insert, con);

                    SqlParameter p1 = new SqlParameter();
                    SqlParameter p2 = new SqlParameter();
                    SqlParameter p3 = new SqlParameter();

                    p1.Value = FirstName;
                    p2.Value = LastName;
                    p3.Value = year;

                    p1.ParameterName = "@name";
                    p2.ParameterName = "@surname";
                    p3.ParameterName = "@year";

                    command.Parameters.Add(p1);
                    command.Parameters.Add(p2);
                    command.Parameters.Add(p3);

                    command.ExecuteNonQuery();

                

        }



        List<Tuple<string, string, int>> SelectStudents(SqlConnection con)
        {
            //upit dohvata 3 kolone za vise studenata te moramo imati listu tuple-ova
            List<Tuple<string, string, int>> students = new List<Tuple<string, string, int>>();

   
                    string query = "SELECT LastName, FirstName, Year FROM Students";

                    SqlCommand cmd = new SqlCommand(query, con);



                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            /*
                            System.Diagnostics.Debug.WriteLine("\t{0}\t{1}",
                                    reader[0], reader[1]);
                            */

                            Tuple<string, string, int> student = new Tuple<string, string, int>(reader[0].ToString(), reader[1].ToString(), int.Parse(reader[2].ToString()));

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




 