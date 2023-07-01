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
    
    $pdo = new PDO('mysql:host=localhost;dbname=trabalho_bd','root','KAio1906');

    if(isset($_POST['acao']))
    {
        $nome = strip_tags($_POST['nome']);
        $cpf = strip_tags($_POST['cpf']);
        $endereco = strip_tags($_POST['endereco']);
        $email = strip_tags($_POST['email']);
        $telefone = strip_tags($_POST['telefone']);
        $data = strip_tags($_POST['data']);
        $sexo = strip_tags($_POST['sexo']);
        
        $sql = $pdo->prepare("INSERT INTO Pessoa(nome,cpf,endereco,email,telefone,data_nasc,sexo) VALUES (?,?,?,?,?,?,?)");

        if($sql->execute(array($nome,$cpf,$endereco,$email,$telefone,$data,$sexo)))
        {
            echo '<script>alert("INSERÇÃO BEM SUCEDIDA!")</script>';
        }
        else 
        {
            die("Falhou");
        }
    }

    // Busca no banco de dados por CPF
    if (isset($_POST['buscar']))
    {
        $cpfBusca = $_POST['cpfBusca'];
        $sqlBusca = $pdo->prepare("SELECT * FROM Pessoa WHERE cpf = ?");
        $sqlBusca->execute([$cpfBusca]);

        $pessoaEncontrada = $sqlBusca->fetch();

        if ($pessoaEncontrada)
        {
            echo "<h3>Pessoa Encontrada:</h3>";
            echo "Nome: " . $pessoaEncontrada['nome'] . "<br>";
            echo "CPF: " . $pessoaEncontrada['cpf'] . "<br>";
            echo "Endereço: " . $pessoaEncontrada['endereco'] . "<br>";
            echo "E-mail: " . $pessoaEncontrada['email'] . "<br>";
            echo "Telefone: " . $pessoaEncontrada['telefone'] . "<br>";
            echo "Data de Nascimento: " . $pessoaEncontrada['data_nasc'] . "<br>";
            echo "Sexo: " . $pessoaEncontrada['sexo'] . "<br>";
            echo "<hr>";
        }
        else
        {
            echo "<h3>Nenhuma pessoa encontrada com o CPF informado.</h3>";
        }
    }

    $sql = $pdo->prepare("SELECT * FROM Pessoa");
    $sql->execute();

    $pessoas = $sql->fetchAll();

    /*foreach($pessoas as $key => $value)
    {
        echo $value['nome'];
        echo '<br>';
        echo $value['cpf'];
        echo '<hr>' ;
    }*/
?>

<div class="search-form">
    <form method="post">
        <input type="text" name="cpfBusca" placeholder="Digite o CPF">
        <input type="submit" name="buscar" value="Buscar">
    </form>
</div>

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

</body>
</html>
