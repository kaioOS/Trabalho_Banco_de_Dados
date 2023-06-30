<!DOCTYPE html>
<html>
<head>
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
        
        $sql = $pdo->prepare("INSERT INTO Pessoa(nome,cpf,endereco,email, telefone, data_nasc, sexo) VALUES (?,?,?,?,?,?,?)");

        if($sql->execute(array($nome,$cpf,$endereco,$email,$telefone,$data,$sexo)))
        {
            echo '<script>alert("INSERÇÃO BEM SUCEDIDA!")</script>';
        }
        else 
        {
            die("Falhou");
        }
    }

    $sql = $pdo->prepare("SELECT * FROM Pessoa");
    $sql->execute();

    $pessoas = $sql->fetchALL();

    foreach($pessoas as $key => $value)
    {
        echo $value['nome'];
        echo '<br>';
        echo $value['cpf'];
        echo '<hr>' ;
    }
?>
<form method="post">
    <input type="text" name = "nome" placeholder="Digite o nome">
    <input type="text" name = "cpf" placeholder="Digite o cpf">
    <input type="text" name = "endereco" placeholder="Digite o endereço">
    <input type="text" name = "email"  placeholder="Digite o e-mail">
    <input type="text" name = "telefone" placeholder="Digite o telefone">
    <input type="text" name = "data" placeholder="Digite o data de nascimento">
    <input type="text" name = "sexo" placeholder="Digite o sexo">
    <input type="submit" name="acao" value="Cadastrar">
    
</form>
</body>
</html>
