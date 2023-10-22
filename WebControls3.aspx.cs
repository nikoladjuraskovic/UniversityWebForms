using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class WebControls3 : System.Web.UI.Page
    {

        /*
         Jedini nacin da list-u odnosno neku C# promenljivu vidimo
        na stranici .aspx a da je definisana u aspx.cs-u je da je stavimo
        kao property klase stranica vidljivosti public. Da je public moramo
        specijalno naglasiti jer u C# svaki property je po defualt-u private.
        Ovako ce se videti na stranici izmedju ostalog jer backend stranice tj.
        aspx.cs nasledjuje aspx stranicu odnosno WebControls3 : System.Web.UI.Page
        sto pise gore. Slicno, mozemo prikazati i objekat kao i listu objekata.
         */
        

        public List<string> data = new List<string>();


        /*Objekat stud(instancu klase Ucenik) stavljamo da je public
         da bi bila vidljiva u Page-u(aspx).*/
        public Ucenik stud = new Ucenik();

        public List<Ucenik> students = new List<Ucenik>();


        protected void Page_Load(object sender, EventArgs e)
        {

            stud.Age = 26;
            stud.Name = "Mika";

            Ucenik stud2 = new Ucenik();
            stud2.Age = 17;
            stud2.Name = "Pera";

            Ucenik stud3 = new Ucenik();
            stud3.Age = 18;
            stud3.Name = "Zika";

            students.Add(stud);
            students.Add(stud2);
            students.Add(stud3);

            /* kada ucitamo stranicu podatke cemo ubaciti u listu*/

            data.Add("List Item 1");
            data.Add("List Item 2");
            data.Add("List Item 3");
            data.Add("List Item 4");
            data.Add("List Item 5");
            data.Add("List Item 6");
            data.Add("List Item 7");
            data.Add("List Item 8");
            data.Add("List Item 9");

            


            string connectionString = GetConnectionString();
            SqlConnection con = new SqlConnection(connectionString);




            using (con)
            {

                try
                {

                        con.Open(); // otvaram ovde konekciju i zatvoricu je nakon poziva svih metoda
                  
                        PopulateListBoxWithList();

                        PopulateListBoxWithBase(con);

                        PopulateDropDownListWithList();

                        PopulateDropDownListWithBase(con);
                    

                } catch(Exception ex)
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
            
            return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            
        }

        void PopulateListBoxWithList()
        {
            // prosledjujemo podatke ListBox-u.

            List<string> data = new List<string>();

            data.Add("List Item 1");
            data.Add("List Item 2");
            data.Add("List Item 3");
            data.Add("List Item 4");
            data.Add("List Item 5");
            data.Add("List Item 6");
            data.Add("List Item 7");

           

            ListBox2.DataSource = data; //listbox-u kazemo da je izvor podataka lista
            ListBox2.DataBind();
        }

        void PopulateListBoxWithBase(SqlConnection con)
        {
                 
                string query = "SELECT LastName FROM Students;";

                SqlCommand cmd = new SqlCommand(query, con);

            
           
                SqlDataReader reader = cmd.ExecuteReader();

            //izvor podataka listbox-a je DataReader
                ListBox3.DataSource = reader;

                //ovde kazemo listbox-u koje podatke hocemo da prikazemo
                ListBox3.DataValueField = "LastName";

                //vezi podatke za ListBox
                ListBox3.DataBind();

                reader.Close(); // zatvaramo reader jer ce nam trebati i u drugim metodama

            
        }

        void PopulateDropDownListWithList()
        {
            List<string> data = new List<string>();

            data.Add("List Item 1");
            data.Add("List Item 2");
            data.Add("List Item 3");
            data.Add("List Item 4");
            data.Add("List Item 5");
            data.Add("List Item 6");
            data.Add("List Item 7");



            DropDownList2.DataSource = data; 
            DropDownList2.DataBind();
        }

        void PopulateDropDownListWithBase(SqlConnection con)
        {
          
                string query = "SELECT LastName FROM Students;";

                SqlCommand cmd = new SqlCommand(query, con);

            //izvor podataka listbox-a je DataReader
           
                SqlDataReader reader = cmd.ExecuteReader();

                DropDownList3.DataSource = reader;

                //ovde kazemo listbox-u koje podatke hocemo da prikazemo
                DropDownList3.DataValueField = "LastName";

                //vezi podatke za ListBox
                DropDownList3.DataBind();
               
                reader.Close();
            
        }

        
    }

    /*klasu ucenik definisemo van klase WebControls3 i stavljamo
     * da bude public da bi bila vidljiva u ostalim klasama
     * u ovom fajlu.
     * 
     * */
    public class Ucenik
    {
        public string Name { get; set; }
        public int Age { get; set; }

        public string Hello()
        {
            return "Hello, my name is " + Name + " and I am " + Age + " years old.";
        }
    }
}