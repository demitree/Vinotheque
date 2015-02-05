using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vinothèque
{

    public partial class WebForm4 : System.Web.UI.Page
    {
        private double totalHorsTaxe = 0;
        private double tva = 0;
        private double totalAvecTaxes = 0;
        private double rate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currencyrate"] == null)
            {
                CurrencyService.CurrencyConvertorSoap cc = new CurrencyService.CurrencyConvertorSoapClient();
                double rate = cc.ConversionRate(CurrencyService.Currency.EUR, CurrencyService.Currency.USD);
                Session["currencyrate"] = rate;
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            //System.Globalization.NumberFormatInfo.CurrentInfo.NumberDecimalSeparator = ".";
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowType != DataControlRowType.Header)
            {
                try
                {
                    Label lblPrice = (Label)e.Row.Cells[5].FindControl("totallabel");
                    totalHorsTaxe += Convert.ToDouble(lblPrice.Text.ToString());
                }
                catch {
                }
                
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                double res = 0;
                double rate = Convert.ToDouble(Session["currencyrate"].ToString());
                tva = totalHorsTaxe * 0.196;
                totalAvecTaxes = totalHorsTaxe + tva;
                e.Row.Cells[0].Attributes.Add("rowspan", "3");
                e.Row.Cells[0].Attributes.Add("colspan", "2");

                e.Row.Cells[1].Text = "Total Hors Taxe";
                e.Row.Cells[1].Attributes.Add("colspan", "3");
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Yellow;
                res = totalHorsTaxe * rate;
                e.Row.Cells[2].Text = totalHorsTaxe.ToString("0.00") + "€ (" + res.ToString("0.00") + "$)" + "</th></tr><tr>";
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Yellow;

                e.Row.Cells[3].Text = "TVA 19.6%";
                e.Row.Cells[3].Attributes.Add("colspan", "3");
                res = tva * rate;
                e.Row.Cells[4].Text = tva.ToString() + "€ (" + res.ToString("0.00") + "$)" + "</th></tr><tr>";
                
                e.Row.Cells[5].Text = "Total Toutes Taxes Comprises";
                e.Row.Cells[5].Attributes.Add("colspan", "3");
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Yellow;
                res = totalAvecTaxes * rate;
                e.Row.Cells[6].Text = totalAvecTaxes.ToString() + "€ (" + res.ToString("0.00") + "$)";
                e.Row.Cells[6].ForeColor = System.Drawing.Color.Yellow;
            }

        }

        protected void modifier_Click(object sender, EventArgs e)
        {
            var quantite = ((TextBox)((Button)sender).Parent.FindControl("quantitetext")).Text;
            var idvin = ((Label)((Button)sender).Parent.FindControl("idvinlabel")).Text;
            var idcomm = ((Label)((Button)sender).Parent.FindControl("idcommlabel")).Text;
            dsCommande.UpdateParameters.Clear();
            dsCommande.UpdateParameters.Add("idcomm", idcomm);
            dsCommande.UpdateParameters.Add("idvin", idvin);
            dsCommande.UpdateParameters.Add("quantite", quantite);
            dsCommande.Update();
            Response.Redirect("~/Caddie.aspx");

        }

        protected void image_resize(object sender, EventArgs e)
        {
            double factor = 1;
            Image image = (Image)sender;
            double resizeWidth = image.Width.Value * factor;
            double resizeHeight = image.Height.Value * factor;
            image.Height = new Unit(resizeHeight);
            image.Width = new Unit(resizeWidth);
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            rate = Convert.ToDouble(Session["currencyrate"].ToString());
            foreach (GridViewRow row in GridView1.Rows)
            {
                double prixEur = Convert.ToDouble(((Label)(row.FindControl("prixlabel"))).Text);
                ((Label)(row.FindControl("usdLabel1"))).Text = (prixEur * rate).ToString("0.00");
                double totalEur = Convert.ToDouble(((Label)(row.FindControl("totallabel"))).Text);
                ((Label)(row.FindControl("usdLabel2"))).Text = (totalEur * rate).ToString("0.00");
            }

        }


    }
}