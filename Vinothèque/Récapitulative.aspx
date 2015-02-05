<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Récapitulative.aspx.cs" Inherits="Vinothèque.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
    <asp:Image ID="Image1" runat="server" Height="97px" ImageUrl="~/Images_bandeau/LaVinotheque.gif" Width="393px" />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
    <asp:SqlDataSource ID="dsCommande" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT *, vins.prix*prodcomm.quantite AS total FROM prodcomm , vins WHERE (prodcomm.idcomm = @idcomm) AND (prodcomm.idvin = vins.idvin)">
        <SelectParameters>
            <asp:SessionParameter Name="idcomm" SessionField="idcomm" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>&nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idprodcomm,idcomm,idvin" DataSourceID="dsCommande" EmptyDataText="aucune commande à afficher." ShowFooter="True" OnRowDataBound="GridView1_RowDataBound" OnPreRender="GridView1_PreRender">
        <Columns>
            <asp:TemplateField ControlStyle-Width="5px" ControlStyle-Height="30px">
                <ItemTemplate>
                    <h3>&nbsp;<%#(Container.DataItemIndex + 1) %>&nbsp;</h3>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dénomination" ControlStyle-Width="250px" ControlStyle-Height="30px">
                <HeaderStyle ForeColor="Yellow" />
                <ItemTemplate>
                    <div><asp:Label ID="nomlabel" runat="server" Text='<%# Eval("nom") %>'></asp:Label><asp:Label ID="millesimelabel" runat="server" Text='<%# Eval("millesime") %>'></asp:Label> <asp:Label ID="regionlabel" runat="server" Text='<%# Eval("region", "( {0})")%>'></asp:Label>
                        </div>
                </ItemTemplate>
            </asp:TemplateField >
            <asp:TemplateField HeaderText="Quantité" ControlStyle-Width="100px" ControlStyle-Height="30px">
                <HeaderStyle ForeColor="Yellow" />
                <ItemTemplate>
                    <br />
                    <asp:Label ID="quantitelabel" runat="server" Text='<%# Eval("quantite") %>' Height="17px" TextMode="Number"></asp:Label>
                    <asp:Label ID="idvinlabel" runat="server" Text='<%# Eval("idvin") %>' Visible="False" />
                    <asp:Label ID="idcommlabel" runat="server" Text='<%# Eval("idcomm") %>' Visible="False" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prix unitaire" ControlStyle-Width="100px" ControlStyle-Height="30px">
                <HeaderStyle ForeColor="Yellow" />
                <ItemTemplate>
                    <div><asp:Label ID="prixlabel" runat="server" Text='<%# Eval("prix") %>'></asp:Label>€ (<asp:Label ID="usdLabel1" runat="server" Text='' ></asp:Label> $)
                        </div>
                </ItemTemplate>        
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total" ControlStyle-Width="100px" ControlStyle-Height="30px">
                <HeaderStyle ForeColor="Yellow" />
                <ItemTemplate>
                    <div><asp:Label ID="totallabel" runat="server" Text='<%# Eval("total") %>' />€ (<asp:Label ID="usdLabel2" runat="server" Text='' ></asp:Label> $)
                        </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsCommandes" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        InsertCommand="INSERT INTO [commandes] ([date], [total]) VALUES (@date, @total)" 
        UpdateCommand="UPDATE [commandes] SET[date] = @date, [total] = @total WHERE [idcomm] = @idcomm">
        <InsertParameters>
            <asp:Parameter Name="idclient" Type="Int32" />
            <asp:Parameter Name="date" Type="DateTime" />
            <asp:Parameter Name="total" Type="Double" />
            <asp:Parameter Name="fraisdeport" Type="Double" />
            <asp:Parameter Name="fait" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="idclient" Type="Int32" />
            <asp:Parameter Name="date" Type="DateTime" />
            <asp:Parameter Name="total" Type="Double" />
            <asp:Parameter Name="fraisdeport" Type="Double" />
            <asp:Parameter Name="fait" Type="Int32" />
            <asp:Parameter Name="idcomm" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Button ID="valider" runat="server" Text="Valider" style="margin-left: 183px" OnClick="valider_Click" />
    <asp:Label ID="prixtotal" runat="server" Text='' Visible="false" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Catalogue.aspx">Catalogue</asp:LinkButton>
&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Default.aspx">Acceuil</asp:LinkButton></asp:Content>
