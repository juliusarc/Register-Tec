<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterT.aspx.cs" Inherits="Register.RegisterT" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registros de Cadastros</title>
   <style>
    body {
        background: linear-gradient(90deg, #000000 0%, #004080 100%);
        color: #ffffff;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .container {
        padding: 20px;
        width: 80%;
        max-width: 1200px;
        background: rgba(0, 0, 0, 0.7);
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #e0e0e0;
    }

    .form-group {
        width: 100%;
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #cccccc;
    }

    .form-group input[type="text"], 
    .form-group input[type="date"],
    .form-group input[type="number"] {
        width: calc(100% - 24px);
        padding: 12px;
        border: 1px solid #555;
        border-radius: 5px;
        box-sizing: border-box;
        background-color: #333;
        color: #ffffff;
    }

    .buttons-group {
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .buttons-group button {
        flex: 1;
        margin: 5px;
        background-color: #0056b3;
        color: #ffffff;
        padding: 15px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .buttons-group button:hover {
        background-color: #003d7a;
    }

    .btnUpdate {
        background-color: #004080;
    }

    .btnDelete {
        background-color: #d9534f;
    }

    .btnViewBooks {
        background-color: #0099cc;
    }

    #lblResult {
        margin-top: 20px;
        color: #ffffff;
        font-weight: bold;
        text-align: center;
    }

    .gridview {
        margin-top: 20px;
        width: 100%;
    }

    .gridview table {
        width: 100%;
        border-collapse: collapse;
    }

    .gridview th, .gridview td {
        border: 1px solid #555;
        padding: 10px;
        text-align: left;
    }

    .gridview th {
        background-color: #004080;
    }

    .search-group {
        display: flex;
        width: 100%;
        margin-top: 20px;
        align-items: center;
    }

    .search-group input[type="text"] {
        flex: 3;
        margin-right: 10px;
        padding: 12px;
        border: 1px solid #555;
        border-radius: 5px;
        background-color: #333;
        color: #ffffff;
    }

    .search-group button {
        flex: 1;
        background-color: #0056b3;
        color: #ffffff;
        padding: 12px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .search-group button:hover {
        background-color: #003d7a;
    }

    @media (max-width: 768px) {
        .container {
            width: 90%;
        }

        .buttons-group button {
            width: calc(50% - 10px);
        }

        .form-group input[type="text"], 
        .form-group input[type="date"],
        .form-group input[type="number"] {
            width: calc(100% - 20px);
        }
    }

    @media (max-width: 480px) {
        .container {
            width: 100%;
            padding: 10px;
        }

        .buttons-group {
            flex-direction: column;
            align-items: stretch;
        }

        .buttons-group button {
            width: 100%;
            margin: 5px 0;
        }

        .form-group input[type="text"], 
        .form-group input[type="date"],
        .form-group input[type="number"] {
            width: calc(100% - 10px);
        }
    }
</style>


    <script>
        function formatDate(input) {
            let value = input.value.replace(/\D/g, '');
            let formattedValue = '';
            if (value.length > 2) {
                formattedValue = value.substring(0, 2) + '/';
                if (value.length > 4) {
                    formattedValue += value.substring(2, 4) + '/';
                    formattedValue += value.substring(4, 8);
                } else {
                    formattedValue += value.substring(2, 4);
                }
            } else {
                formattedValue = value;
            }
            input.value = formattedValue;
        }

        function permitirSomenteLetras(input) {
            input.value = input.value.replace(/[^a-zA-Z\s]/g, '');
        }

        function formatarCPF(input) {
            let value = input.value.replace(/\D/g, '');
            if (value.length > 3) value = value.substring(0, 3) + '.' + value.substring(3);
            if (value.length > 7) value = value.substring(0, 7) + '.' + value.substring(7);
            if (value.length > 11) value = value.substring(0, 11) + '-' + value.substring(11, 13);
            input.value = value;
        }

        function formatarValor(input) {
            let value = input.value.replace(/\D/g, '');
            let number = parseFloat(value) / 100;
            if (!isNaN(number)) {
                input.value = number.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }).replace('R$', '').trim();
            } else {
                input.value = '';
            }
        }
    </script>


</head>
<body>
      <form id="form1" runat="server">
        <div class="container">
            <h2>REGISTROS</h2>
            <asp:Label ID="lblResult" runat="server" EnableViewState="false"></asp:Label>

            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Nome:"></asp:Label>
                <asp:TextBox ID="txtName" runat="server" oninput="permitirSomenteLetras(this)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblCPF" runat="server" Text="CPF:"></asp:Label>
                <asp:TextBox ID="txtCPF" runat="server" oninput="formatarCPF(this)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblGenerationDate" runat="server" Text="Data de Geração:"></asp:Label>
                <asp:TextBox ID="txtGenerationDate" runat="server" oninput="formatDate(this)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPaymentDate" runat="server" Text="Data de Pagamento:"></asp:Label>
                <asp:TextBox ID="txtPaymentDate" runat="server" oninput="formatDate(this)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblValor" runat="server" Text="Valor:"></asp:Label>
                <asp:TextBox ID="txtValor" runat="server" oninput="formatarValor(this)"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblObservation" runat="server" Text="Observação:"></asp:Label>
                <asp:TextBox ID="txtObservation" runat="server"></asp:TextBox>
            </div>

            <div class="buttons-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Salvar Registro" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Atualizar Registro" OnClick="btnUpdate_Click" CssClass="btnUpdate" />
                <asp:Button ID="btnDelete" runat="server" Text="Excluir Registro" OnClick="btnDelete_Click" CssClass="btnDelete" />
                <asp:Button ID="btnViewBooks" runat="server" Text="Ver Registros" OnClick="btnViewBooks_Click" CssClass="btnViewBooks" />
            </div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview">
                <Columns>
                    <asp:BoundField DataField="Nome" HeaderText="Nome" />
                    <asp:BoundField DataField="CPF" HeaderText="CPF" />
                    <asp:BoundField DataField="DataGerado" HeaderText="Data de Geração" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="DataPagamento" HeaderText="Data de Pagamento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Valor" HeaderText="Valor" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Observacao" HeaderText="Observação" />
                </Columns>
            </asp:GridView>
           
            <div class="search-group">
                    <asp:Label ID="lblSearchCPF" runat="server" Text="Buscar por CPF:" AssociatedControlID="txtSearchCPF"></asp:Label>
                    <asp:TextBox ID="txtSearchCPF" runat="server" oninput="formatarCPF(this)"></asp:TextBox>
                    <asp:Button ID="btnSearchCPF" runat="server" Text="Buscar" OnClick="btnSearchCPF_Click" CssClass="btnViewBooks" />
                </div>
           </div>
    </form>
</body>
</html>