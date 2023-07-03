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
    <title>Empréstimo</title>
</head>

<body>
    <?php
    session_start();
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');

    // Verifica se o formulário de empréstimo foi enviado
    if (isset($_POST['solicitar'])) {
        $cpf = $_POST['cpf'];
        $senha = $_POST['senha'];
        $valorSolicitado = $_POST['valor'];
        $parcelas = $_POST['parcelas'];

        // Verifica se o CPF e senha são válidos
        $sql = $pdo->prepare("SELECT p.nome, p.cpf, ct.saldo, ct.id_conta FROM (Pessoa p INNER JOIN Cliente c ON (p.id_pessoa = c.id_pessoa) INNER JOIN Conta ct ON (c.id_cliente = ct.id_cliente)) WHERE p.cpf = ? AND c.senha = ?");
        $sql->execute([$cpf, $senha]);
        $pessoaEncontrada = $sql->fetch();

        if ($pessoaEncontrada && $pessoaEncontrada['cpf'] == $_SESSION['cpf']) {
            $idConta = $pessoaEncontrada['id_conta'];
            $saldoAtual = $pessoaEncontrada['saldo'];

            // Verifica se o valor solicitado é válido
            if ($valorSolicitado > 0) {
                // Calcula a taxa de juros com base no número de parcelas (exemplo: 1% de taxa de juros por parcela)
                $taxaJuros = $parcelas * 1;

                // Calcula os juros do empréstimo (valor solicitado * taxa de juros)
                $juros = $valorSolicitado * ($taxaJuros / 100);

                // Calcula o valor total a pagar (valor solicitado + juros)
                $valorTotal = $valorSolicitado + $juros;

                // Atualiza o saldo na tabela Conta
                $novoSaldo = $saldoAtual + $valorSolicitado;
                $sqlAtualizarSaldo = $pdo->prepare("UPDATE Conta SET saldo = ? WHERE id_conta = ?");
                $sqlAtualizarSaldo->execute([$novoSaldo, $idConta]);

                // Insere a operação de empréstimo na tabela Operacao
                $sqlInserirOperacao = $pdo->prepare("INSERT INTO Operacao(valor, id_conta, tipo_op) VALUES (?, ?, 'E')");
                $sqlInserirOperacao->execute([$valorSolicitado, $idConta]);
                $idOperacao = $pdo->lastInsertId();

                $sqlInserirEmprestimo = $pdo->prepare("INSERT INTO Emprestimo(id_operacao, taxa_juros, parcelas) VALUES (?, ?, ?)");
                $sqlInserirEmprestimo->execute([$idOperacao, $taxaJuros, $parcelas]);

                // Exibe mensagem de sucesso
                echo "<h3>Empréstimo solicitado com sucesso!</h3>";
                echo "Valor solicitado: R$" . $valorSolicitado . "<br>";
                echo "Juros: R$" . $juros . "<br>";
                echo "Valor total a pagar: R$" . $valorTotal . "<br>";
                echo "Saldo atual: R$" . $novoSaldo . "<br>";
                echo "<a class='link-botao' href='index.php'>Terminar operações</a><br>";
            } else {
                // Exibe mensagem de erro se o valor solicitado for inválido
                echo "<h3>Valor de empréstimo inválido</h3>";
            }
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
        }
    }
    ?>

    <h1>Empréstimo</h1>

    <form class="add-form" method="post">
        <input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
        <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
        <input type="number" id="valor" name="valor" min="0" step="0.01" placeholder="Digite o valor solicitado" required>
        <select name="parcelas" id="parcelas" required>
            <option value="">Selecione o número de parcelas</option>
            <option value="6">6 parcelas</option>
            <option value="12">12 parcelas</option>
            <option value="18">18 parcelas</option>
            <option value="24">24 parcelas</option>
        </select>
        <input type="submit" name="solicitar" value="Solicitar Empréstimo">
    </form>
</body>

</html>

