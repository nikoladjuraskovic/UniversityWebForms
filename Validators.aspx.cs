using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class Validators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void Button1_Click(object sender, EventArgs e)
        {
            //TODO kako ako imamo vise validatora da uklopimo provere
            //tj. da ispise da nije validno samo za taj a ne svaki

            if (Page.IsValid)
            {
                lblOutput.Text = "Page is Valid.";
            }
            else
            {
                lblOutput.Text = "Page is InValid.";
            }
        }
        /*funkcija koja vrsi obradu validnosti.*/





    }
}