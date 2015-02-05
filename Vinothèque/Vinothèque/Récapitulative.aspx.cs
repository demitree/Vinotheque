using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vinothèque
{

    public partial class WebForm5 : System.Web.UI.Page
    {
        private double totalHorsTaxe;
        private double tva;
        private double totalAvecTaxes;
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
                    Label lblPrice = (Label)e.Row.Cells[4].FindControl("totallabel");
                    this.totalHorsTaxe += Convert.ToDouble(lblPrice.Text.ToString());
                }
                catch
                {
                }

            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                double res = 0;
                double rate = Convert.ToDouble(Session["currencyrate"].ToString());
                tva = totalHorsTaxe * 0.196;
                totalAvecTaxes = totalHorsTaxe + tva;

                e.Row.Cells.Add(new TableCell());
                e.Row.Cells.Add(new TableCell());
                e.Row.Cells[0].Attributes.Add("rowspan", "3");

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
        protected void valider_Click(object sender, EventArgs e)
        {
            var date = DateTime.Now.ToString();
            var total = prixtotal.Text;
            var idcomm = Session["idcomm"].ToString();

            dsCommandes.SelectCommand = "SELECT idcomm FROM commandes Where idcomm = '" + idcomm + "'";
            DataView rset = (DataView)dsCommandes.Select(DataSourceSelectArguments.Empty);

            if ((rset != null) && (rset.Count > 0))
            {
                dsCommandes.UpdateParameters.Clear();
                dsCommandes.UpdateParameters.Add("total", total);
                dsCommandes.UpdateParameters.Add("date", date);
                dsCommandes.Update();
            }
            else
            {
                dsCommandes.InsertParameters.Clear();
                dsCommandes.InsertParameters.Add("total", total);
                dsCommandes.InsertParameters.Add("date", date);
                dsCommandes.Insert();
            }
            Session["idcomm"] = null;
            Session["currentregion"] = null;
            Response.Redirect("~/Confirmation.aspx");

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