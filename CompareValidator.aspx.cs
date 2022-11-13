using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebControlsBase
{
    public partial class CompareValidator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
      
    


        protected void ListOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            /*SelectedIndex property, tj indeks izabranog elementa liste je tipa int.
            Da bismo ga dodelili Operator property-ju Compare1 polja moramo ga castovati
            u enum tip, jer je Operator tipa enum(nabrojivi tj. enumeracioni tip).
            O enum tipu pogledajte ovde: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/enum*/

            /*ValidationCompareOperator: https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.webcontrols.validationcompareoperator?view=netframework-4.8*/
            Compare1.Operator = (ValidationCompareOperator)ListOperator.SelectedIndex;
            Compare1.Validate();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblOutput.ForeColor = System.Drawing.Color.Green;
                lblOutput.Text = "Result: Valid!";

            }
            else
            {
                lblOutput.ForeColor = System.Drawing.Color.Red;
                lblOutput.Text = "Result: Not valid!";

            }
        }

        protected void ListType_SelectedIndexChanged(object sender, EventArgs e)
        {
            Compare1.Type = (ValidationDataType)ListType.SelectedIndex;
            Compare1.Validate();
        }
    }
}