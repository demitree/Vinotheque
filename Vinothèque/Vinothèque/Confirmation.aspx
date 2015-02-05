<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Vinothèque.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <asp:Image ID="Image1" runat="server" Height="97px" ImageUrl="~/Images_bandeau/LaVinotheque.gif" Width="393px" />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
    <h2>Votre commande a été transmise à notre service de ventes par correspondance. Nous vous remercions pour votre confiance ! </h2>   
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" ForeColor="Black" BorderStyle="None" Font-Names="Century Gothic" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="True" PostBackUrl="~/Catalogue.aspx">Catalogue</asp:LinkButton>
&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="True" ForeColor="Black" BorderStyle="None" Font-Names="Century Gothic" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="True" PostBackUrl="~/Default.aspx">Acceuil</asp:LinkButton>
    </asp:Content>
