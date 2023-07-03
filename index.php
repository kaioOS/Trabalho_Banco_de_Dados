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
    <title>Trabalho Banco de Dados</title>
</head>

<body>

    <?php
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd', 'root', 'ar25022002@');
    $exibirBarraPesquisa = true;
    $cpfEncontrado = "";

    // Busca no banco de dados por CPF
    if (isset($_POST['buscar'])) {
        $cpfBusca = $_POST['cpfBusca'];
        $senhaBusca = $_POST['senhaBusca'];

        $sqlBusca = $pdo->prepare("SELECT p.nome, p.cpf, ct.saldo, ct.id_conta, b.nome_banco, a.nome_agencia
                                    FROM (Pessoa p 
                                    INNER JOIN Cliente c ON (p.id_pessoa = c.id_pessoa) 
                                    INNER JOIN Conta ct ON (c.id_cliente = ct.id_cliente) AND c.senha = ?
                                    INNER JOIN Agencia a ON (c.id_agencia = a.id_agencia)
                                    INNER JOIN Banco b ON (a.id_banco = b.id_banco))
                                    WHERE p.cpf = ?");
        $sqlBusca->execute([$senhaBusca, $cpfBusca]);

        $pessoaEncontrada = $sqlBusca->fetch();

        if ($pessoaEncontrada) {
            $cpfEncontrado = $pessoaEncontrada['cpf'];
            $exibirBarraPesquisa = false; // Define como falso para ocultar a barra de pesquisa

            session_start();
            $_SESSION['cpf'] = $cpfEncontrado;


            echo "<h3>Bem vindo(a)</h3>";
            echo "Nome: " . $pessoaEncontrada['nome'] . "<br>";
            echo "CPF: " . $pessoaEncontrada['cpf'] . "<br>";
            echo "Banco: " . $pessoaEncontrada['nome_banco'] . "<br>";
            echo "Agência: " . $pessoaEncontrada['nome_agencia'] . "<br>";
            echo "Saldo: R$" . $pessoaEncontrada['saldo'] . "<br>";
            echo "<hr>";

            echo "<h3>Operações:</h3>";
            echo '<a class= "link-botao" href="saque.php?cpf=' . $pessoaEncontrada['cpf'] . '">Saque</a><br>';
            echo '<a class= "link-botao" href="deposito.php?cpf=' . $pessoaEncontrada['cpf'] . '">Depósito</a><br>';
            echo '<a class= "link-botao" href="investimento.php?cpf=' . $pessoaEncontrada['cpf'] . '">Investimento</a><br>';
            echo '<a class= "link-botao" href="emprestimo.php?cpf=' . $pessoaEncontrada['cpf'] . '">Empréstimo</a><br>';
            echo '<a class= "link-botao" href="transferencia.php?cpf=' . $pessoaEncontrada['cpf'] . '">Transferência</a><br>';
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
            $exibirBarraPesquisa = true; // Define como verdadeiro para exibir a barra de pesquisa
        }
    }
    ?>

    <div class="add-form" <?php if (!$exibirBarraPesquisa) echo 'style="display: none;"'; ?>>
        <form method="post">
            <input type="text" name="cpfBusca" placeholder="Digite o CPF">
            <input type="password" name="senhaBusca" placeholder="Digite sua senha">
            <input type="submit" name="buscar" value="Buscar">
        </form>
    </div>

</body>

</html>