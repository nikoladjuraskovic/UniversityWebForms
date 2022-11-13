using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class CustomValidatorClient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void ValidateBtn_OnClick(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Display whether the page passed validation.
            if (Page.IsValid)
            { //uvek validno jer je validacija na strani klijenta!
                Message.Text = "Page is valid.";
                Message.ForeColor = System.Drawing.Color.Green; //izmena boje ispisa
            }

            else
            {
                Message.Text = "Page is not valid!";
                Message.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}