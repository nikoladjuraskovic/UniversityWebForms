using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class AutoPostBack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*S obzirom da je AutoPostBack = true za TextBox-ove i DropDownList-u
             svako put kada TextBox izgubi fokus ili se izabere element DropDownListe,
            podaci se salju serveru i stranica se ponovo ucitava, samim tim
            se uvek ponovo poziva metod Page_Load. Tj. naredni kod se ponovo izvrsava
            zbog postback-a kada se opet ucita stranica.*/
            try
            {

                int Answer;

                // Due to a timing issue with when page validation occurs, call the
                // Validate method to ensure that the values on the page are valid.
                Page.Validate();

                // Add the values in the text boxes if the page is valid.
                if (Page.IsValid)
                {
                    Answer = Convert.ToInt32(Value1.Text) + Convert.ToInt32(Value2.Text);

                    AnswerMessage.Text = Answer.ToString();





                    //ako je neki item izabran
                    if (DropDownList2.SelectedItem != null)
                    {
                        //ispis izbor u label
                        Label2.Text = DropDownList2.SelectedItem.Value;

                        Label2.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        Label2.Text = "Nothing Selected";
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