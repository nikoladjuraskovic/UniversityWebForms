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
    public partial class WebControls1Backend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = GetConnectionString();
            SqlConnection con = new SqlConnection(connectionString);

            using (con)
            {

                try
                {

                    con.Open(); // otvaram ovde konekciju

                } catch(Exception ex)
                {

                    ErrorLabel.Text = "SERVER ERROR";
                    ErrorLabel.ForeColor = System.Drawing.Color.Red;
                    System.Diagnostics.Debug.WriteLine("Exception Message " + ex.Message);
                    System.Diagnostics.Debug.WriteLine("Stack Trace " + ex.StackTrace);
                }
                /*
                 primetite da ovde NISU pozvani metod vezani za events:
                OnSorting
                OnRowDeleting
                OnRowEditing
                OnRowCancelingEdit
                OnRowUpdating itd. jer su to events(dogadjaji) i metode se
                pozivaju onda kada se desi okidac za taj dogadjaj(klikne se dugme ili se nesto
                drugo desi na stranici)
                Npr. klikne se ime kolone da bi se sortirali elementi i onda se pozove
                metod za sortiranje.
                 */

                StudentsView0_Show(con);

                StudentsView1_Show(con);

                GridView2_Show(con);

                GridView3_Show(con);

                Chart1_Show(con);

                GridView4_Show(con);

                GridView5_Show(con);

                GridView6_Show(con);

                GridView7_Show(con);

            }
            //konekciju zatvaramo nakon poziva svih metoda



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


        void StudentsView0_Show(SqlConnection con)
        {


            string query = "SELECT * FROM Students;";

            SqlCommand cmd = new SqlCommand(query, con);


            try
            {

                SqlDataReader reader = cmd.ExecuteReader();

                StudentsView0.DataSource = reader; //izvor podataka je DataReader

                StudentsView0.DataBind(); // vezi podatke za GridView kontrolu



                reader.Close(); //zatvori reader, NEOPHODNO jer cemo ga koristiti nadalje

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);

            }



        }

        void StudentsView1_Show(SqlConnection con)
        {
            string query = "SELECT * FROM Students;";

            SqlCommand cmd = new SqlCommand(query, con);

            /*

            //Naredni kod bi proizveo gresku: 
            // The data source does not support server-side data paging
            //Zasto? Jer smo u GridView kontroli rekli da je paging=true,
            //a to znaci da mozemo listati podatke napred i nazad a DataReader
            //nema tu mogucnost tj. on je forward only, odnosno moze citati samo unapred
            //i ne cuva podatke,
            //zato MORAMO preko DataAdapter-a koji to dozvoljava
            //u klasama DataTable, DataSet, ...
            //Zato sto DataTable, DataSet stalno cuvaju podatke u memoriji.
            
            try{
            
            SqlDataReader reader = cmd.ExecuteReader();

            StudentsView1.DataSource = reader; //izvor podataka je DataReader

            StudentsView1.DataBind(); // vezi podatke za GridView kontrolu

            

            reader.Close(); //zatvori reader, NEOPHODNO jer cemo ga koristiti nadalje

            } catch(Exception e){
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);

            }

            */

            SqlDataAdapter adapter = new SqlDataAdapter();

            adapter.SelectCommand = cmd;

            DataTable students = new DataTable();

            try
            {

                adapter.Fill(students);

                /*
                 * izvor podataka GridView kontrole je dataTable tj. podatke sada
                 * prikazujemo na veb stranici, tj. na strani klijenta
                 * */
                StudentsView1.DataSource = students;

                StudentsView1.DataBind();

            } catch(Exception e)
            {

                /*
                 Izuzetke obradjujemo i ispisujemo i dalje na strani servera
                 */
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);

            }
        }


        protected void StudentsView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //na ovaj nacin omogucavam rad paging-a u kontroli.

            StudentsView1.PageIndex = e.NewPageIndex;
            StudentsView1.DataBind();
        }

        void GridView2_Show(SqlConnection con)
        {
            string query = "SELECT * FROM Students ORDER BY Year DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                //sada mozemo koristiti reader jer GridView2 nema paging

                SqlDataReader reader = cmd.ExecuteReader();

                GridView2.DataSource = reader;

                GridView2.DataBind();

                

                reader.Close();
            } catch(Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }

        }

        protected void GridView2_Sorting(object sender, GridViewSortEventArgs e)
        {
            //TODO

            /* Potrebno je implementirati sorting event, sada se ne generise
             * automatski jer koristimo metode, ne sql source asp tag.
             * Tako da ako ovako radite, tj. bez sql source tag-a sve operacije(events)
             * se MORAJU rucno implementirati u backend-u.
             * Slicno vazi i za Select, Update, Delete operacije nad GridView
             * 
             * Koga zanima moze se ovako uraditi:
             * https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.sorting?view=netframework-4.8
             * Ostale Events mozete videti ovde: https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview?view=netframework-4.8
             * i skrolujte dole dok ne dodjete do Events
             * O dogadjajima(events): https://learn.microsoft.com/en-us/dotnet/standard/events/
             * O Page Life Cycle-u: https://learn.microsoft.com/en-us/previous-versions/aspnet/ms178472(v=vs.100)
             * dodajte desnu zagradu na link iznad da bi radio
             * https://www.c-sharpcorner.com/UploadFile/8911c4/page-life-cycle-with-examples-in-Asp-Net/
             * */



        }

        protected void GridView3_Sorting(object sender, GridViewSortEventArgs e)
        {
            //TODO
            // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.sorting?view=netframework-4.8
        }

        void GridView3_Show(SqlConnection con)
        {
            string query = "SELECT LastName, AVG(Grade) as Average " +
                        "FROM Students s JOIN Exams e " +
                        "on s.StudentID = e.StudentID " +
                        "WHERE e.Grade is not null " +
                        "GROUP BY s.LastName;";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {

                SqlDataReader reader = cmd.ExecuteReader();

                GridView3.DataSource = reader;

                GridView3.DataBind();

                reader.Close();

            } catch(Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }
        }

        void Chart1_Show(SqlConnection con)
        {
            string query = "SELECT LastName, AVG(Grade) as Average " +
                         "FROM Students s JOIN Exams e " +
                         "on s.StudentID = e.StudentID " +
                         "WHERE e.Grade is not null " +
                         "GROUP BY s.LastName;";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {

                SqlDataReader reader = cmd.ExecuteReader();

                Chart1.DataSource = reader;

                Chart1.DataBind();

                reader.Close();

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }
        }

        void GridView4_Show(SqlConnection con)
        {
            string query = "SELECT * FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                SqlDataReader reader = cmd.ExecuteReader();

                GridView4.DataSource = reader;

                GridView4.DataBind();

                reader.Close();


            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }
        }

        protected void GridView4_Sorting(object sender, GridViewSortEventArgs e)
        {
            //TODO
            // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.sorting?view=netframework-4.8
        }

        protected void GridView4_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        //TODO
        // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.rowdeleting?view=netframework-4.8
        }

        protected void GridView4_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //TODO
            // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.rowediting?view=netframework-4.8
        }

        protected void GridView4_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //TODO
            // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.rowcancelingedit?view=netframework-4.8
        }

        protected void GridView4_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //TODO
            // https://learn.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.gridview.rowupdating?view=netframework-4.8
        }


        void GridView5_Show(SqlConnection con)
        {
            string query = "SELECT StudentID, LastName FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                SqlDataReader reader = cmd.ExecuteReader();

                GridView5.DataSource = reader;

                GridView5.DataBind();

                reader.Close();


            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }

        }

        void GridView6_Show(SqlConnection con)
        {
            string query = "SELECT StudentID, Grade FROM Exams WHERE Grade IS NOT NULL";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                SqlDataReader reader = cmd.ExecuteReader();

                GridView6.DataSource = reader;

                GridView6.DataBind();

                reader.Close();


            } catch(Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }
        }





        protected void GridView6_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            try
            {

                //iteracija kroz sve redove kontrola
                for (int i = 0; i < GridView6.Rows.Count; i++)
                {
                    GridViewRow row = GridView6.Rows[i]; // dohvatam jedan red
                    string grade;
                    float floatGrade;

                    grade = row.Cells[1].Text; //citam vrednosti celije u obliku stringa
                                               //System.Diagnostics.Debug.WriteLine("GridText[" + i + "]: " + grade);
                    floatGrade = float.Parse(grade); //cast-ujem u float radi ispitvanja
                    if (floatGrade < 2) // ako je ocena manja od 2
                    {
                        row.BackColor = System.Drawing.Color.Red; // oboji red u crveno
                    }
                    else
                    {
                        row.BackColor = System.Drawing.Color.Green; // inace u zeleno
                    }

                }

            } catch(Exception e2)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e2.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e2.StackTrace);
            }


        }

        void GridView7_Show(SqlConnection con)
        {
            string query = "SELECT * FROM Students;";

            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                SqlDataReader reader = cmd.ExecuteReader();

                GridView7.DataSource = reader;

                GridView7.DataBind();

                reader.Close();


            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Exception Message " + e.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + e.StackTrace);
            }

        }

        protected void GridView7_Sorting(object sender, GridViewSortEventArgs e)
        {
            //TODO
        }

        protected void GridView7_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //TODO
        }

        protected void GridView7_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //TODO
        }

        protected void GridView7_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //TODO
        }

        protected void GridView7_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //TODO
        }
    }
}