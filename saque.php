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
    <title>Saque</title>
</head>

<body>
    <?php
    session_start();
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');
    // Verifica se o formulário de saque foi enviado
    if (isset($_POST['saque'])) {
        $cpf = $_POST['cpf'];
        $senha = $_POST['senha'];
        $valorSaque = $_POST['valor'];
        // Verifica se o CPF e senha são válidos
        $sql = $pdo->prepare("SELECT p.nome,p.cpf, p.cnpj,ct.saldo,ct.id_conta 
            FROM (Pessoa p INNER JOIN Cliente c on (p.id_pessoa = c.id_pessoa) 
            INNER JOIN Conta ct on (c.id_cliente = ct.id_cliente)) 
            WHERE (p.cpf = ? OR p.cnpj = ?) AND c.senha = ?");
        $sql->execute([$cpf, $cpf, $senha]);
        $pessoaEncontrada = $sql->fetch();

        if ($pessoaEncontrada && ($pessoaEncontrada['cpf'] == $_SESSION['cpf'] || $pessoaEncontrada['cnpj'] == $_SESSION['cpf'])) {
            $idConta = $pessoaEncontrada['id_conta'];
            $saldoAtual = $pessoaEncontrada['saldo'];

            // Verifica se o valor de saque é válido e suficiente
            if ($valorSaque > 0 && $valorSaque <= $saldoAtual) {
                // Calcula o novo saldo após o saque
                $novoSaldo = $saldoAtual - $valorSaque;

                // Insere a operação na tabela Operacao
                $sqlInserirOperacao = $pdo->prepare("INSERT INTO Operacao(valor, id_conta, tipo_op) VALUES (?, ?, 'S')");
                $sqlInserirOperacao->execute([$valorSaque, $idConta]);

                // Exibe mensagem de sucesso
                echo "<h3>Saque realizado com sucesso!</h3>";
                echo "Valor sacado: R$" . $valorSaque . "<br>";
                echo "Saldo atual: R$" . ($saldoAtual - $valorSaque) . "<br>";
                echo "<a class='link-botao' href='index.php'>Terminar operações</a><br>";
            } else {
                // Exibe mensagem de erro
                echo "<h3>Valor de saque inválido ou saldo insuficiente</h3>";
            }
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
        }
    }
    ?>

    <h1>Saque</h1>
    <form class="add-form" method="post">
        <input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
        <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
        <input type="number" id="valor" placeholder="Valor do saque" name="valor" min="0" step="0.01" required>
        <input type="submit" name="saque" value="Realizar Saque">
    </form>
</body>

</html>