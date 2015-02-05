using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vinothèque
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["idcomm"] == null)
                Session["idcomm"] = Guid.NewGuid().GetHashCode();
            if (Session["currentregion"] != null)
            {
                regionshow.Text = Session["currentregion"].ToString();
            }
            if (Session["currencyrate"] == null)
            {
                CurrencyService.CurrencyConvertorSoap cc = new CurrencyService.CurrencyConvertorSoapClient();
                double rate = cc.ConversionRate(CurrencyService.Currency.EUR, CurrencyService.Currency.USD);
                Session["currencyrate"] = rate;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["currentregion"] = chooseRegion.SelectedValue.ToString();
            regionshow.Text = Session["currentregion"].ToString();
        }


        protected void Commander_Click(object sender, EventArgs e)
        {
            var quantite = ((TextBox)((Button)sender).Parent.FindControl("quantitetext")).Text;
            var idvin = ((Label)((Button)sender).Parent.FindControl("idvin")).Text;
            var idcomm = Session["idcomm"].ToString();

            dsCommande.SelectCommand = "SELECT idvin FROM prodcomm Where idvin = '" + idvin + "' AND idcomm = '" + idcomm + "'";
            DataView rset = (DataView)dsCommande.Select(DataSourceSelectArguments.Empty);

            if ((rset != null) && (rset.Count > 0))
            {
                dsCommande.UpdateParameters.Clear();
                dsCommande.UpdateParameters.Add("idcomm", idcomm);
                dsCommande.UpdateParameters.Add("idvin", idvin);
                dsCommande.UpdateParameters.Add("quantite", quantite);
                dsCommande.Update();
            }
            else
            {
                dsCommande.InsertParameters.Clear();
                dsCommande.InsertParameters.Add("idcomm", idcomm);
                dsCommande.InsertParameters.Add("idvin", idvin);
                dsCommande.InsertParameters.Add("quantite", quantite);
                dsCommande.Insert();
            }
            Response.Redirect("~/Caddie.aspx");
        }

        protected void VinList_PreRender(object sender, EventArgs e)
        {
            double rate = Convert.ToDouble(Session["currencyrate"].ToString());
            foreach (DataListItem Item in VinList.Items) {
                double prixEur = Convert.ToDouble(((Label)(Item.FindControl("prixlabel"))).Text);
                ((Label)(Item.FindControl("usdLabel"))).Text = (prixEur * rate).ToString("0.00");
            }

        }

    }
}