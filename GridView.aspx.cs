using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class GridView : System.Web.UI.Page
    {

        List<Student> students = new List<Student>();
        Student s1 = new Student("John", "Smith", 1);
        Student s2 = new Student("Jane", "Doe", 3);
        Student s3 = new Student("Bob", "Craig", 2);

        protected void Page_Load(object sender, EventArgs e)
        {

            //ponovite obradu izuzetaka
            try
            {

                string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
                SqlConnection con = new SqlConnection(connectionString);

                students.Add(s1);
                students.Add(s2);
                students.Add(s3);

                GridView1Fill();

                /*OPREZ! Preporuka je da otvorite konekciju na pocetku i drzite je otvorenu
                 dokle god pozivate razlicite funkcije. Nakon svih poziva gde se koristi
                con objektat, onda zatvorite konekciju.*/

                using (con)
                {
                    con.Open();
                   
                    GridView2Fill(con);
                    GridView3Fill(con);
                    GridView5Fill(con);
                    Chart1Fill(con);

                }

            } catch (Exception ex)
            {
                //na veb stranici obavestavamo korisnika da je doslo do greske na strani servera
                ErrorLabel.Text = "SERVER ERROR";
                /*na strani servera u Visual Studio programu ispisujemo detalje greske za nas(programera).
                NIKADA DETALJE GRESKE, IMPLEMENTACIJE NE ISPISUJTE KLIJENTIMA NA VEB STRANICI JER JE TO BEZBEDNOSNI RIZIK!
                TIME OTKRIVATE TEHNOLOGIJU, DETALJE IMPLEMENTACIJE VASEG SAJTA

                */

                System.Diagnostics.Debug.WriteLine(ex);
                System.Diagnostics.Debug.WriteLine(ex.Message);
                System.Diagnostics.Debug.WriteLine(ex.StackTrace);
                
            }
        }


        //fja prikazuje podakte Liste objekata koristeci GridView
        void GridView1Fill()
        {
            //izvor podataka GridView kontrole je students
            GridView1.DataSource = students;
            //veži podatke za GridView
            GridView1.DataBind();
        }

        void GridView2Fill(SqlConnection con)
        {
           
                string query = "SELECT * FROM Students";
                
                SqlCommand cmd = new SqlCommand(query, con);

                SqlDataReader reader = cmd.ExecuteReader();

                GridView2.DataSource = reader;

                GridView2.DataBind();

                reader.Close();
            

            /*NAPOMENA: Ne morate uvek dohvatati sve podatke svih kolona. Dohvatacete ono sto se trazi od vas
             u zadacima i shodno tome prilagoditi izgled GridView kontrole*/
        }

        void GridView3Fill(SqlConnection con)
        {
            
                string query = "SELECT * FROM Students";

                SqlCommand cmd = new SqlCommand(query, con);

                SqlDataReader reader = cmd.ExecuteReader();

                GridView3.DataSource = reader;

                GridView3.DataBind();

                reader.Close();
            
        }


        //fja ispisuje prosecne ocene studenata u GridView sortirane po prosecnoj oceni
        void GridView5Fill(SqlConnection con)
        {
            string query = "SELECT s.LastName, AVG(e.Grade) as Average " +
                            "FROM Students s JOIN Exams e" +
                            " ON s.StudentID = e.StudentID " +
                            " GROUP BY LastName " +
                            " ORDER BY AVG(e.Grade) DESC";
            
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();

            GridView5.DataSource = reader;

            GridView5.DataBind();

            reader.Close();
        }

        void Chart1Fill(SqlConnection con)
        {
            string query = "SELECT s.LastName, AVG(e.Grade) as Average " +
                            "FROM Students s JOIN Exams e" +
                            " ON s.StudentID = e.StudentID " +
                            " GROUP BY LastName";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();

            Chart1.DataSource = reader;

            Chart1.DataBind();

            reader.Close();
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            /*Obrada izuzetka iz sqldatasource*/

            if (e.Exception != null) // ako postoji izuzetak
            {
                ErrorLabel.Text = "SERVER ERROR";              
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Exception.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.Exception.StackTrace);
                e.ExceptionHandled = true; // obavezno navesti inace izuzetak nece biti obradjen!
            }
        }
    }


    /*Klasa student predstavlja jednog studenta, slicno onom kao iz baze University.
     Da bi mogli da prikazete podatke u GridView, polja(properties) klase morate
    navoditi novim nacinom gde se promenljive navode sa geterima i seterima zajedno u jednom redu.
    O tome vise ovde: 
    https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/auto-implemented-properties
    https://www.w3schools.com/cs/cs_properties.php */

    public class Student
    {
       
        public string lastName { get; set; }

        
        public string firstName { get; set; }

        
        public int year { get; set; }
       

        public Student(string lastName, string firstName, int year)
        {
            this.lastName = lastName;
            this.firstName = firstName;
            this.year = year;

        }


    }
}