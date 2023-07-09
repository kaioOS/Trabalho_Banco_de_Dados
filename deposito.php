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
    <title>Depósito</title>
</head>

<body>
    <?php
    session_start();
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');
    // Verifica se o formulário de depósito foi enviado
    if (isset($_POST['deposito'])) {
        $cpf = $_POST['cpf'];
        $senha = $_POST['senha'];
        $valorDeposito = $_POST['valor'];
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

            // Verifica se o valor de depósito é válido
            if ($valorDeposito > 0) {
                // Calcula o novo saldo após o depósito
                $novoSaldo = $saldoAtual + $valorDeposito;
                // Insere a operação na tabela Operacao
                $sqlInserirOperacao = $pdo->prepare("INSERT INTO Operacao(valor, id_conta, tipo_op) VALUES (?, ?, 'D')");
                $sqlInserirOperacao->execute([$valorDeposito, $idConta]);

                // Exibe mensagem de sucesso
                echo "<h3>Depósito realizado com sucesso!</h3>";
                echo "Valor depositado: R$" . $valorDeposito . "<br>";
                echo "Saldo atual: R$" . $novoSaldo . "<br>";
                echo "<a class='link-botao' href='index.php'>Terminar operações</a><br>";
            } else {
                // Exibe mensagem de erro
                echo "<h3>Valor de depósito inválido</h3>";
            }
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
        }
    }
    ?>

    <h1>Depósito</h1>

    <form class="add-form" method="post">
        <input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
        <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
        <input type="number" id="valor" name="valor" min="0" step="0.01" placeholder="Digite o valor" required>
        <input type="submit" name="deposito" value="Realizar Depósito">
    </form>
</body>

</html>