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
    <title>Transferência</title>
</head>

<body>
    <?php
    session_start();
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');

    // Verifica se o formulário de transferência foi enviado
    if (isset($_POST['transferir'])) {
        $cpf = $_POST['cpf'];
        $senha = $_POST['senha'];
        $valorTransferencia = $_POST['valor'];
        $contaDestino = $_POST['conta_destino'];

        // Verifica se o CPF e senha são válidos
        $sql = $pdo->prepare("SELECT p.nome, p.cpf, ct.saldo, ct.id_conta FROM (Pessoa p INNER JOIN Cliente c ON (p.id_pessoa = c.id_pessoa) INNER JOIN Conta ct ON (c.id_cliente = ct.id_cliente)) WHERE p.cpf = ? AND c.senha = ?");
        $sql->execute([$cpf, $senha]);
        $pessoaEncontrada = $sql->fetch();

        if ($pessoaEncontrada && $pessoaEncontrada['cpf'] == $_SESSION['cpf']) {
            $idContaOrigem = $pessoaEncontrada['id_conta'];
            $saldoAtual = $pessoaEncontrada['saldo'];

            // Verifica se a conta de destino existe
            $sqlContaDestino = $pdo->prepare("SELECT * FROM Conta WHERE id_conta = ?");
            $sqlContaDestino->execute([$contaDestino]);
            $contaDestinoEncontrada = $sqlContaDestino->fetch();

            if ($contaDestinoEncontrada) {
                $idContaDestino = $contaDestinoEncontrada['id_conta'];
                $cpfContaDestino = $contaDestinoEncontrada['cpf'];
                $saldoContaDestino = $contaDestinoEncontrada['saldo'];

                // Verifica se o valor da transferência é válido
                if ($valorTransferencia > 0 && $valorTransferencia <= $saldoAtual) {

                    // Atualiza o saldo na conta de origem
                    $novoSaldoOrigem = $saldoAtual - $valorTransferencia;

                    // Insere a operação de transferência na tabela Operacao
                    $sqlInserirOperacao = $pdo->prepare("INSERT INTO Operacao(valor, id_conta, tipo_op) VALUES (?, ?, 'T')");
                    $sqlInserirOperacao->execute([$valorTransferencia, $idContaOrigem]);
                    $idOperacao = $pdo->lastInsertId();

                    // Insere a transferência na tabela Transferencia
                    $sqlInserirTransferencia = $pdo->prepare("INSERT INTO Transferencia(id_operacao, id_destino, status) VALUES (?, ?, 'Em processamento')");
                    $sqlInserirTransferencia->execute([$idOperacao, $idContaDestino]);

                    $novoSaldoDestino = $saldoContaDestino + $valorTransferencia;

                    // Exibe mensagem de sucesso
                    echo "<h3>Transferência realizada com sucesso!</h3>";
                    echo "Valor transferido: R$" . $valorTransferencia . "<br>";
                    echo "Conta de origem: " . $idContaOrigem . "<br>";
                    echo "Conta de destino: " . $idContaDestino . "<br>";
                    echo "Saldo atual da conta de origem: R$" . $novoSaldoOrigem . "<br>";
                    echo "Saldo atual da conta de destino: R$" . $novoSaldoDestino . "<br>";
                    echo "<a class='link-botao' href='index.php'>Terminar operações</a>";
                } else {
                    echo "<h3>Valor inválido para transferência!</h3>";
                }
            } else {
                echo "<h3>Conta de destino não encontrada!</h3>";
            }
        } else {
            echo "<h3>CPF ou senha inválidos!</h3>";
        }
    }
    ?>

    <h3 class="card-title text-center mb-4">Transferência</h3>
    <form class="add-form" method="POST" action="">

        <input type="text" class="form-control" id="cpf" name="cpf" placeholder="Digite seu cpf" required>
        <input type="password" class="form-control" id="senha" name="senha"  placeholder="Digite sua senha" required>
        <input type="number" step="0.01" class="form-control" id="valor" name="valor" placeholder="Digite o valor" required>
        <input type="number" class="form-control" id="conta_destino" name="conta_destino" placeholder="Digite o id da conta de destino" required>
        <input type="submit" class="btn btn-primary" value="Transferir" name="transferir"></input>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-oAqomLJnpvAnlbTrNwq0/YeygFuyQzqo5QWldmjSkNVUSNjwRT62bSvUoYzqR/Df" crossorigin="anonymous"></script>
</body>

</html>