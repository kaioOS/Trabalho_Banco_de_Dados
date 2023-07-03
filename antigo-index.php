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

        $sqlBusca = $pdo->prepare("SELECT p.nome,p.cpf,ct.saldo,ct.id_conta,b.nome_banco,a.nome_agencia FROM (Pessoa p 
        INNER JOIN Cliente c on (p.id_pessoa = c.id_pessoa) 
        INNER JOIN Conta ct on (c.id_cliente = ct.id_cliente) and c.senha = ?
        INNER JOIN Agencia a on (c.id_agencia = a.id_agencia)
        INNER JOIN Banco b on (a.id_banco = b.id_banco)) WHERE p.cpf = ?");
        $sqlBusca->execute([$senhaBusca, $cpfBusca]);

        $pessoaEncontrada = $sqlBusca->fetch();

        if ($pessoaEncontrada) {
            $cpfEncontrado = $pessoaEncontrada['cpf'];
            $exibirBarraPesquisa = false; // Define como falso para ocultar a barra de pesquisa
            echo "<h3>Pessoa Encontrada:</h3>";
            echo "Nome: " . $pessoaEncontrada['nome'] . "<br>";
            echo "CPF: " . $pessoaEncontrada['cpf'] . "<br>";
            echo "Banco: " . $pessoaEncontrada['nome_banco'] . "<br>";
            echo "Agencia: " . $pessoaEncontrada['nome_agencia'] . "<br>";
            echo "Saldo: " . $pessoaEncontrada['saldo'] . "<br>";
            /* echo "Endereço: " . $pessoaEncontrada['endereco'] . "<br>";
            echo "E-mail: " . $pessoaEncontrada['email'] . "<br>";
            echo "Telefone: " . $pessoaEncontrada['telefone'] . "<br>";
            echo "Data de Nascimento: " . $pessoaEncontrada['data_nasc'] . "<br>";
            echo "Sexo: " . $pessoaEncontrada['sexo'] . "<br>";*/
            echo "<hr>";

            //Caso encontre permite realizar as operações



            echo '<div class="add-form">';
            echo '<form method="post">';
            echo '<input type="text" name="valor" placeholder="Digite o valor" pattern="[0-9]+([,.][0-9]+)?">';
            echo '<br>';
            echo '<form method="post">';
            echo '<input type="text" name="cpf" placeholder="Digite o CPF" pattern="[0-9]+([,.][0-9]+)?">';
            echo '<br>';
            echo '<input type="submit" name="saque" value="Saque">';
            echo '&nbsp';
            echo '<input type="submit" name="deposito" value="Deposito">';
            echo '</form>';
            echo '</div>';
        } else {
            echo "<h3>CPF ou senha incorretos</h3>";
            $exibirBarraPesquisa = true; // Define como verdadeiro para exibir a barra de pesquisa
        }
    }
    if (isset($_POST['saque'])) {

        $sqlBusca = $pdo->prepare("SELECT p.nome,p.cpf,ct.saldo,ct.id_conta,b.nome_banco,a.nome_agencia FROM (Pessoa p 
        INNER JOIN Cliente c on (p.id_pessoa = c.id_pessoa) 
        INNER JOIN Conta ct on (c.id_cliente = ct.id_cliente) 
        INNER JOIN Agencia a on (c.id_agencia = a.id_agencia)
        INNER JOIN Banco b on (a.id_banco = b.id_banco)) WHERE p.cpf = ?");
        $sqlBusca->execute([$_POST['cpf']]);
        $pessoaEncontrada = $sqlBusca->fetch();

        $valor = floatval(strip_tags($_POST['valor']));
        $id_conta = strip_tags($pessoaEncontrada['id_conta']);

        if ($id_conta != '') {

            $sql = $pdo->prepare("INSERT INTO Operacao(valor,id_conta,tipo_op) VALUES (?,?,?)");

            if ($sql->execute(array($valor, $id_conta, 'S'))) {
                echo '<script>alert("SAQUE BEM SUCEDIDO!")</script>';
            } else {
                die("Operação de saque falhou! Volte e tente novamente");
            }
        } else {
            die("Operação de saque falhou! Volte e tente novamente");
        }
    }
    if (isset($_POST['deposito'])) {

        $sqlBusca = $pdo->prepare("SELECT p.nome,p.cpf,ct.saldo,ct.id_conta FROM (Pessoa p INNER JOIN Cliente c on (p.id_pessoa = c.id_pessoa) INNER JOIN Conta ct on (c.id_cliente = ct.id_cliente)) WHERE p.cpf = ?");
        $sqlBusca->execute([$_POST['cpf']]);
        $pessoaEncontrada = $sqlBusca->fetch();

        $valor = floatval(strip_tags($_POST['valor']));
        $id_conta = strip_tags($pessoaEncontrada['id_conta']);

        if ($id_conta != '') {

            $sql = $pdo->prepare("INSERT INTO Operacao(valor,id_conta,tipo_op) VALUES (?,?,?)");

            if ($sql->execute(array($valor, $id_conta, 'D'))) {
                echo '<script>alert("DEPÓSITO BEM SUCEDIDO!")</script>';
            } else {
                die("Operação de deposito falhou! Volte e tente novamente");
            }
        } else {
            die("Operação de deposito falhou! Volte e tente novamente");
        }
    }



    /*foreach($pessoas as $key => $value)
    {
        echo $value['nome'];
        echo '<br>';
        echo $value['cpf'];
        echo '<hr>' ;
    }*/
    ?>
    <a href="login.php">Login</a>
    <div class="search-form" <?php if (!$exibirBarraPesquisa) echo 'style="display: none;"'; ?>>
        <form method="post">
            <input type="text" name="cpfBusca" placeholder="Digite o CPF">
            <input type="password" name="senhaBusca" placeholder="Digite sua senha">
            <input type="submit" name="buscar" value="Buscar">
        </form>
    </div>
    <!--
 <div class="add-form">
    <form method="post">
        <input type="text" name="nome" placeholder="Digite o nome">
        <input type="text" name="cpf" placeholder="Digite o CPF">
        <input type="text" name="endereco" placeholder="Digite o endereço">
        <input type="text" name="email" placeholder="Digite o e-mail">
        <input type="text" name="telefone" placeholder="Digite o telefone">
        <input type="text" name="data" placeholder="Digite a data de nascimento">
        <input type="text" name="sexo" placeholder="Digite o sexo">
        <input type="submit" name="acao" value="Cadastrar">
    </form>
</div>
-->
</body>

</html>