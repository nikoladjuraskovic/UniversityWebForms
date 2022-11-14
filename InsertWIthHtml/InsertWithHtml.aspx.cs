using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase.InsertWIthHtml
{
    public partial class InsertWithHtml : System.Web.UI.Page
    {

        //mora biti public i u klasi definisan da bi se video na aspx stanici
        public List<Tuple<string, string, int>> students = new List<Tuple<string, string, int>>();
        

        protected void Page_Load(object sender, EventArgs e)
        {

            string connectionString = GetConnectionString();

            SqlConnection connection = new SqlConnection(connectionString);




            using (connection)
            {

                try
                {

                    connection.Open();

                    students = SelectStudents(connection);


                    if (Request.HttpMethod == "POST")
                    {

                        /*Ako je http metod post tj. ako su poslati podaci
                         * serveru, dohvati ih pomocu Form property-ja
                         * Request objekta na osnovu name property-ja input tag-a forme.
                        
                         */
                        string FirstName = Request.Form["FirstName"];
                        if (FirstName == "")
                        {
                            throw new Exception("Name Not Inserted!");
                        }

                        string LastName = Request.Form["LastName"];

                        if (LastName == "")
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

                        /*
                         <!--U Web.config smo dodali directoryBrowse enabled = true da bi mogli 
                        da izvrsimo Response.Redirect naredbu tj. da bi mogli ponovo da ucitamo
                        stranicu nakon unosenja nekog podatka.
                        Nalazi se izmedju system.webServer tag-ova.
                        Inace bi izbacio gresku tipa Forbidden
                        O tome vise ovde: https://stackoverflow.com/questions/8543761/how-to-enable-directory-browsing-by-default-on-iis-express

                            -->
                         */
                        /*navodimo ime foldera pa onda ime stranice*/
                        Response.Redirect("~/InsertWithHtml/InsertWithHtml", false);
                    }

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