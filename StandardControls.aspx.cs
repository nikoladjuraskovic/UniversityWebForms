using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class StandardControls : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            /*promena boje labele tj. teksta na strani servera.
             * Akcija se ponistava restartovanjem servera,
             * ne klijenta(ne refresh-ovanjem stranice u browser-u)
             * 
             * */

            Label1.ForeColor = System.Drawing.Color.Red;

            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //kada kliknemo LinkButton, menja se tekst i njegova boja

            Label2.Text = "Clicked";

            Label2.ForeColor = System.Drawing.Color.Green;
        }
    }
}