using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class CustomValidatorServer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Display whether the page passed validation.
            if (Page.IsValid)
            {

                Message.Text = "Page is valid.";
                Message.ForeColor = System.Drawing.Color.Green;
            }

            else
            { // ako unos na serveru nije prosao, ispisi da stranica nije validna

                Message.Text = "Page is not valid!";
                Message.ForeColor = System.Drawing.Color.Red;
            }
        }
        //ASP funkcija za validaciju na strani servera
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {

            
            try
            {

                // Test whether the value entered into the text box is even.
                int i = int.Parse(args.Value);
                args.IsValid = ((i % 2) == 0);

            }

            catch (Exception ex)
            {
                //ako je ispaljen izuzetak, to znaci da stranica ne treba da je validna
                args.IsValid = false;
            }
        }
    }
}