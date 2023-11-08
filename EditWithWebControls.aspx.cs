using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class EditWithWebControls : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(GetConnectionString());


            /*NAPOMENA: Mesto otvaranje i zatvaranja konekcije moze biti razlicito u zavisnosti kako kucate kod.
             Bitno je da kod koji koristi bazu podataka ima otvorenu konekciju i da se ona posle zatvori.
            Sve delove koda koji mogu ispaliti izuzetak obavezno obraditi*/

            try
            {
                using (con)
                {
                    con.Open();

                    GridViewFill(con);
                }
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "SERVER ERROR";
                System.Diagnostics.Debug.WriteLine("Exception Message: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace: " + ex.StackTrace);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (GridView1.SelectedRow != null)
            { /* seljacki nacin da se spreci ispaljivanje izuzetaka
               * jer iz nekog razloga nece da uhvati izuzetak
               * ako red nije selectovan.
               */

                /*Label je na pocetku visible = false tako da se
                 * nista ne menja ako opet stavimo false.
                 * A ako je prethodno bilo nesto napisano a to nesto
                 * je da treba izabrati red, sada skrivamo poruku
                 * jer znamo da ovde u kodu red je izabran.
                 * 
                 * */
                RowNotSelectedLabel.Visible = false;


                try
                {


                    GridViewRow row = GridView1.SelectedRow;
                    Button2.Visible = true;

                    /*cells[1] a ne 0 jer na 0 poziciji je select kolona
                     */
                    Label1.Visible = true;
                    TextBoxId.Text = row.Cells[1].Text;
                    TextBoxId.Visible = true;
                   

                    Label2.Visible = true;
                    TextBoxLastName.Text = row.Cells[2].Text;
                    TextBoxLastName.Visible = true;

                    

                    Label3.Visible = true;
                    TextBoxFirstName.Visible = true;
                    TextBoxFirstName.Text = row.Cells[3].Text;


                    Label4.Visible = true;
                    TextBoxYear.Text = row.Cells[4].Text;
                    TextBoxYear.Visible = true;
                    

                }
                catch (System.NullReferenceException ex)
                {
                    //TODO ne hvata izuzetak System.NullReferenceException
                    RowNotSelectedLabel.Text = "Please select a row.";
                    RowNotSelectedLabel.Visible = true;
                    System.Diagnostics.Debug.WriteLine("Exception Message: " + ex.Message);
                    System.Diagnostics.Debug.WriteLine("Stack Trace: " + ex.StackTrace);
                }
                catch (Exception e2)
                {
                    System.Diagnostics.Debug.WriteLine("Exception Message: " + e2.Message);
                    System.Diagnostics.Debug.WriteLine("Stack Trace: " + e2.StackTrace);
                }

            }
            else
            {
                RowNotSelectedLabel.Text = "Please select a row.";
                RowNotSelectedLabel.Visible = true;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            /*Objasnjenje slicne funkcije je u InsertWithWebControls
             */

            TextBoxFirstName.CssClass = "form-control";
            TextBoxLastName.CssClass = "form-control";
            TextBoxYear.CssClass = "form-control";


            try
            {

                if (Page.IsValid)
                {

                    string connectionString = GetConnectionString();

                    SqlConnection con = new SqlConnection(connectionString);

                    int id = int.Parse(TextBoxId.Text);
                    string lastName = TextBoxLastName.Text.Trim();
                    string firstName = TextBoxFirstName.Text.Trim();
                    int year = int.Parse(TextBoxYear.Text);

                    UpdateStudentParameter(con, year, id, lastName, firstName);


                    /*Objasnjenje u InsertWithWebControls*/
                    Response.Redirect("~/EditWithWebControls", false);

                }
                else
                {

                    if (RequiredFieldValidator1.IsValid == false || RegularExpressionValidator1.IsValid == false)
                        TextBoxLastName.CssClass += " alert-danger textbox-warning";
                    if (RequiredFieldValidator2.IsValid == false || RegularExpressionValidator2.IsValid == false)
                        TextBoxFirstName.CssClass += " alert-danger textbox-warning";
                    // if (TextBoxYear.Text.Trim().Equals("") || (TextBoxYear.Text.Trim() != "1" && TextBoxYear.Text.Trim() != "2") && TextBoxYear.Text.Trim() != "3" && TextBoxYear.Text.Trim() != "4") // I nacin
                    if (RequiredFieldValidator3.IsValid == false || RangeValidator1.IsValid == false) //II nacin
                        TextBoxYear.CssClass += " alert-danger textbox-warning";


                }

            } catch(Exception ex)
            {
                ErrorLabel.Text = "SERVER ERROR";                         
                System.Diagnostics.Debug.WriteLine("Exception Message: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace: " + ex.StackTrace);
            }
        }

        string GetConnectionString()
        {
         
            return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            
        }

        void UpdateStudentParameter(SqlConnection connection, int year, int id, string lastName, string firstName)
        {
         
                using (connection)
                {
                    connection.Open();

                    SqlParameter p1 = new SqlParameter();
                    SqlParameter p2 = new SqlParameter();
                    SqlParameter p3 = new SqlParameter();
                    SqlParameter p4 = new SqlParameter();
                    

                    p1.Value = year;
                    p2.Value = id;
                    p3.Value = lastName;
                    p4.Value = firstName;

                    p1.ParameterName = "@year";
                    p2.ParameterName = "@id";
                    p3.ParameterName = "@lastName";
                    p4.ParameterName = "@firstName";

                    string query = "UPDATE Students " +
                                    "SET Year = @year, LastName = @lastName, FirstName = @firstName " +
                                    "WHERE StudentID = @id";

                    SqlCommand command = new SqlCommand(query, connection);

                    command.Parameters.Add(p1);
                    command.Parameters.Add(p2);
                    command.Parameters.Add(p3);
                    command.Parameters.Add(p4);

                    command.ExecuteNonQuery();

                }

            
        }

        void GridViewFill(SqlConnection con)
        {
            string query = "SELECT * FROM Students";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();

            GridView1.DataSource = reader;

            GridView1.DataBind();

            reader.Close();
        }
    }
}