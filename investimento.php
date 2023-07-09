<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../img/icone.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="../css/Index.css">
    <title>Investimento</title>
</head>

<body>
    <?php
    session_start();
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');

    // Define os tipos de investimento e suas respectivas taxas anuais
    $investimentos = array(
        'Poupança' => 0.5,
        'CDB' => 1.2,
        'Tesouro Direto' => 0.8,
        'Fundos de Investimento' => 1.5,
        'Ações' => 0.3,
        'Fundos Imobiliários' => 0.7,
        'Criptomoedas' => 0.2,
        'LCI e LCA' => 0
    );

    // Verifica se o formulário de investimento foi enviado
    if (isset($_POST['investir'])) {
        $cpf = $_POST['cpf'];
        $senha = $_POST['senha'];
        $valorInvestimento = $_POST['valor'];
        $tipoInvestimento = $_POST['tipo'];
        $prazo = $_POST['prazo'];

        // Verifica se o CPF e senha são válidos
        $sql = $pdo->prepare("SELECT p.nome, p.cpf, p.cnpj, ct.saldo, ct.id_conta 
        FROM (Pessoa p INNER JOIN Cliente c ON (p.id_pessoa = c.id_pessoa)
        INNER JOIN Conta ct ON (c.id_cliente = ct.id_cliente)) 
        WHERE (p.cpf = ? OR p.cnpj = ?) AND c.senha = ?");
        $sql->execute([$cpf, $cpf, $senha]);
        $pessoaEncontrada = $sql->fetch();

        if ($pessoaEncontrada &&  ($pessoaEncontrada['cpf'] == $_SESSION['cpf'] || $pessoaEncontrada['cnpj'] == $_SESSION['cpf'])) {
            $idConta = $pessoaEncontrada['id_conta'];
            $saldoAtual = $pessoaEncontrada['saldo'];

            // Verifica se o valor de investimento é válido
            if ($valorInvestimento > 0 && isset($investimentos[$tipoInvestimento])) {
                $taxaAnual = $investimentos[$tipoInvestimento];
                // Calcula o rendimento do investimento
                $rendimento = $valorInvestimento * ($taxaAnual / 100);

                $novoSaldo = $saldoAtual - $valorInvestimento;

                // Insere a operação de investimento na tabela Operacao
                $sqlInserirOperacao = $pdo->prepare("INSERT INTO Operacao(valor, id_conta, tipo_op) VALUES (?, ?, 'I')");
                $sqlInserirOperacao->execute([$valorInvestimento, $idConta]);
                $idOperacao = $pdo->lastInsertId();

                 // Insere a operação de investimento na tabela Operacao
                 $sqlInserirOperacao = $pdo->prepare("INSERT INTO Investimento(id_operacao, tipo, taxa_rendimento, prazo) VALUES (?, ?, ?, ?)");
                 $sqlInserirOperacao->execute([$idOperacao,  $tipoInvestimento, $taxaAnual, $prazo]);

                // Exibe mensagem de sucesso
                echo "<h3>Investimento realizado com sucesso!</h3>";
                echo "Tipo de Investimento: " . $tipoInvestimento . "<br>";
                echo "Valor investido: R$" . $valorInvestimento . "<br>";
                echo "Taxa anual: " . $taxaAnual . "%<br>";
                echo "Rendimento: R$" . $rendimento . "<br>";
                echo "Saldo atual: R$" . $novoSaldo . "<br>";
                echo "Prazo de " . $prazo . " meses " . "<br>";
                echo "<a class='link-botao' href='index.php'>Terminar operações</a><br>";
            } else {
                // Exibe mensagem de erro se o tipo de investimento não existir
                echo "<h3>Tipo de investimento inválido</h3>";
            }
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
        }
    }
    ?>

    <h1>Investimento</h1>

    <form class="add-form" method="post">
        <input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
        <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
        <select name="tipo" id="tipo" required>
            <option value="" disabled selected>Selecione o tipo de investimento</option>
            <?php
            foreach ($investimentos as $tipo => $taxa) {
                echo "<option value='" . $tipo . "'>" . $tipo . " - Taxa: " . $taxa . "% ao ano</option>";
            }
            ?>
        </select>
        <input type="number" id="valor" name="valor" min="1" step="0.01" placeholder="Digite o valor" required>
        <input type="number" id="prazo" name="prazo" min="1" placeholder="Qual o prazo" required>
        <input type="submit" name="investir" value="Realizar Investimento">
    </form>
</body>

</html>