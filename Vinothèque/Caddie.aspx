<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Caddie.aspx.cs" Inherits="Vinothèque.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <asp:Image ID="Image1" runat="server" Height="97px" ImageUrl="~/Images_bandeau/LaVinotheque.gif" Width="393px" />
    <br />
    <h2>Votre caddie est le suivant</h2>
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">

    <asp:SqlDataSource ID="dsCommande" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT *, vins.prix*prodcomm.quantite AS total FROM prodcomm , vins WHERE (prodcomm.idcomm = @idcomm) AND  (prodcomm.idvin = vins.idvin)"
        UpdateCommand="UPDATE [prodcomm] SET [quantite] = @quantite WHERE [idcomm] = @idcomm AND [idvin] = @idvin"
        DeleteCommand="DELETE FROM [prodcomm] WHERE [idcomm] = @idcomm AND [idvin] = @idvin">
        <SelectParameters>
            <asp:SessionParameter Name="idcomm" SessionField="idcomm" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="idcomm" Type="Int32" />
            <asp:Parameter Name="idvin" Type="Int32" />
            <asp:Parameter Name="quantite" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idprodcomm,idcomm,idvin" DataSourceID="dsCommande" EmptyDataText="aucune commande à afficher." ShowFooter="True" OnRowDataBound="GridView1_RowDataBound" OnPreRender="GridView1_PreRender" HorizontalAlign="Justify" >
        <Columns>
            <asp:TemplateField  ControlStyle-Width="5px" ControlStyle-Height="30px">
                <ItemTemplate>
                    <h3>&nbsp;<%#(Container.DataItemIndex + 1) %>&nbsp;</h3>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ControlStyle-Width="100px" >
                <ItemTemplate>
                    <asp:Image ID="imageVin" runat="server" ImageUrl='<%# Eval("nomgif") %>' width="100px" Height ="100px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dénomination" ControlStyle-Width="250px" ControlStyle-Height="30px">
                <ItemTemplate>
                    <div>
                        <asp:Label ID="nomlabel" runat="server" Text='<%# Eval("nom") %>'></asp:Label> <asp:Label ID="millesimelabel" runat="server" Text='<%# Eval("millesime") %>'></asp:Label> <asp:Label ID="regionlabel" runat="server" Text='<%# Eval("region", "( {0})")%>'></asp:Label>
                        </div>
                </ItemTemplate>
                <HeaderStyle ForeColor="Yellow"/>
            </asp:TemplateField >
            <asp:TemplateField HeaderText="Quantité" ControlStyle-Width="100px" ControlStyle-Height="30px">
                <HeaderStyle ForeColor="Yellow"/>
                <ItemTemplate>
                    <div>
                        <asp:TextBox ID="quantitetext" runat="server" Text='<%# Bind("quantite") %>' TextMode="Number" ></asp:TextBox>
                        <br />
                        <asp:Button ID="modifier" runat="server" Text="Modifier" OnClick="modifier_Click" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="quantitetext" ErrorMessage="Veuillez saisir la quantité!" Font-Size="Small" ForeColor="White"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator" runat="server" ControlToValidate="quantitetext" ErrorMessage="Veuillez saisir les numéros!" Font-Size="Small" ForeColor="White" ValidationExpression="^[1-9][0-9]*$"></asp:RegularExpressionValidator>
                        <asp:Label ID="idvinlabel" runat="server" Text='<%# Eval("idvin") %>' Visible="False" /><asp:Label ID="idcommlabel" runat="server" Text='<%# Eval("idcomm") %>' Visible="False" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prix unitaire" ControlStyle-Width="100px"  ControlStyle-Height="30px">
                <ItemTemplate>
                    <div><asp:Label ID="prixlabel" runat="server" Text='<%# Eval("prix") %>'></asp:Label>€ (<asp:Label ID="usdLabel1" runat="server" Text='' ></asp:Label> $)
                        </div>
                </ItemTemplate>
                <HeaderStyle ForeColor="Yellow" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total" ControlStyle-Width="100px" ControlStyle-Height="30px">
                <ItemTemplate>
                    <div><asp:Label ID="totallabel" runat="server" Text='<%# Bind("total") %>' />€ (<asp:Label ID="usdLabel2" runat="server" Text='' ></asp:Label> $)
                        </div>
                </ItemTemplate>
                <HeaderStyle ForeColor="Yellow" />
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="envoyerCommande" runat="server" Text="Envoyer la commande" style="margin-left: 183px" PostBackUrl="~/Récapitulative.aspx" />

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">

    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Catalogue.aspx">Catalogue</asp:LinkButton>
&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Default.aspx">Acceuil</asp:LinkButton>

</asp:Content>
