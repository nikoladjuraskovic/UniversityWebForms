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
            
            return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
           
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = GetConnectionString();

            SqlConnection con = new SqlConnection(connectionString);

            try
            {


                GridViewRow row = GridView1.SelectedRow;

                if (row != null)
                {
                    //ako je korisnik kliknuo red tj postoji takav red

                    //bojimo select u boju pozadina, kao da nema opcije select 
                    // jer je vec izabrano
                    row.Cells[0].ForeColor = System.Drawing.Color.SlateBlue;

                    //Cells[1] je pozicija id-a jer Cells[0] je kolona sa select
                    int id = Convert.ToInt32(row.Cells[1].Text.Trim());

                    DeleteStudentParameter(con, id);

                    /*Objasnjenje u InsertWithWebControls*/
                    Response.Redirect("~/DeleteWithWebControls", false);

                }
                else
                {
                    //inace ispisi korisniku da nije dohvatio red i probaj opet
                    SelectLabel.Visible = true;
                }

            } catch(NullReferenceException exnull)
            {
                //TODO ne radi obrada izuzetka, zato mora  preko if( != null)
                SelectLabel.Visible = true;
                System.Diagnostics.Debug.WriteLine("Exception Message: " + exnull.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace: " + exnull.StackTrace);

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