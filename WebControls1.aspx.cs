using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class WebControls1 : System.Web.UI.Page
    {
        



        protected void Page_Load(object sender, EventArgs e)
        {
            

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

            } catch(Exception ex)
            {
                ErrorLabel.Text = "SERVER ERROR";
                ErrorLabel.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("Exception Message " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace " + ex.StackTrace);

            }


        }
    }
}