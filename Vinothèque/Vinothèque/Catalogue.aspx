<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Catalogue.aspx.cs" Inherits="Vinothèque.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <asp:Image ID="Image1" runat="server" Height="97px" ImageUrl="~/Images_bandeau/LaVinotheque.gif" Width="393px" />
    <br />
    <h2>Veuillez choisir la région qui vous intéresse.</h2>
    <asp:DropDownList ID="chooseRegion" runat="server" DataSourceID="dsCatalogue" DataTextField="region" DataValueField="region" AutoPostBack="True" Height="16px" style="margin-left: 0px">
    </asp:DropDownList>
    <br />
    <asp:SqlDataSource ID="dsCatalogue" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [region] FROM [vins]"></asp:SqlDataSource>
    <br />
    <asp:Button ID="Button1" runat="server" Text="Voir les vins de cette région" style="margin-left: 183px" OnClick="Button1_Click" />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
    <h2><asp:Label ID="regionshow" runat="server" width ="300px"></asp:Label></h2>
    <br />
    <asp:SqlDataSource ID="dsVins" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vins] WHERE ([region] = @region)">
        <SelectParameters>
            <asp:SessionParameter Name="region" SessionField="currentregion" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>    

    
    <asp:DataList ID="VinList" runat="server" DataSourceID="dsVins" OnPreRender="VinList_PreRender" Width="400px">
        <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <div><asp:Image ID="imageVin" runat="server" ImageUrl ='<%# Eval("nomgif") %>' width="200px" Height ="200px" /><div>
                            <br />
                            <br />
                            <br />
                        </td>
                        <td>
                            <div>
                               <h2><asp:Label ID="nomLabel" runat="server" Text='<%# Eval("nom") %>' /></h2><br />
                                <h3>   
                                Millesime <asp:Label ID="millesimeLabel" runat="server" Text='<%# Eval("millesime") %>' />
                                <br />
                                Prix: <asp:Label ID="prixlabel" runat="server" Text='<%# Eval("prix") %>' />€ (<asp:Label ID="usdLabel" runat="server" Text=""></asp:Label>$)
                                <br />
                                Quantité: <asp:TextBox ID="quantitetext" runat="server" TextMode="Number">1</asp:TextBox>
                                <asp:Button ID="Commander" runat="server" OnClick="Commander_Click" Text="Commander" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="quantitetext" ErrorMessage="Veuillez saisir la quantité" Font-Size="Small" ForeColor="White"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator" runat="server" ControlToValidate="quantitetext" ErrorMessage="Chiffre supérieur à 0" Font-Size="Small" ForeColor="White" ValidationExpression="^[1-9][0-9]*$"></asp:RegularExpressionValidator>
                                <br />
                                <asp:Label ID="idvin" runat="server" Text='<%# Eval("idvin") %>' Visible="False" />
                                </h3>
                            </div>
                        </td>
                    </tr>
                <table>
        </ItemTemplate>
    </asp:DataList>
    <br />
    <asp:SqlDataSource ID="dsCommande" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        InsertCommand="INSERT INTO [prodcomm] ([idcomm], [idvin], [quantite]) VALUES (@idcomm, @idvin, @quantite)" 
        UpdateCommand="UPDATE [prodcomm] SET [quantite] = @quantite WHERE [idcomm] = @idcomm AND [idvin] = @idvin">
        <InsertParameters>
            <asp:SessionParameter Name="idcomm" SessionField="idcomm" />
            <asp:ControlParameter ControlID="idvin" Name="idvin" PropertyName="Text" Type="Int32" DefaultValue="" />
            <asp:ControlParameter ControlID="quantite" DefaultValue="1" Name="quantite" PropertyName="Text" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
                <asp:Parameter Name="idcomm" Type="Int32" />
                <asp:Parameter Name="idvin" Type="Int32" />
                <asp:Parameter Name="quantite" Type="Int32" />
            </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Caddie.aspx">Voir le caddie</asp:LinkButton>
    &nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Default.aspx">Acceuil</asp:LinkButton>
</asp:Content>
