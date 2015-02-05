<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Vinothèque.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Default.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            margin-left: 115px;
            margin-bottom: 0px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images_bandeau/vignoble3.jpg"></asp:Image>
    <br />
    <br />
    <br />
    <h1>
        Bienvenue au site web de la sociéte "La Vinothèque", fondée en 1962.
        <br />
        Nous vous proposons des vins de qualité provenant de 10 région françaises.<br />
    </h1>
        <br />
        <br />
    <h2>
        1. Alsace<br />
        2. Beaupolais<br />
        3. Bordeaux<br />
        4. Bourgogne<br />
        5. Champagne<br />
        5. Languedoc-Roussillon<br />
        7. Médoc<br />
        8. Provence<br />
        9. Savoie<br />
        10. Val de Loire<br />
        <br />
        <br />
    </h2>
    <span class="auto-style1">

    <asp:Button ID="ButtonMain" runat="server" CssClass="auto-style1" OnClick="Button1_Click" Text="Voir notre catalogue" PostBackUrl="~/Catalogue.aspx" />
    </span>
</asp:Content>

