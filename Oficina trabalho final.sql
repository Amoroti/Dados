create schema Bd;
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    CPF_CNPJ VARCHAR(20),
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(255)
);

CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10),
    Modelo VARCHAR(50),
    Ano INT,
    ClienteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE Mecanico (
    MecanicoID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    CPF VARCHAR(20),
    Telefone VARCHAR(15),
    Especialidade VARCHAR(50)
);

CREATE TABLE Servico (
    ServicoID INT PRIMARY KEY AUTO_INCREMENT,
    Descricao TEXT,
    Data DATE,
    Valor DECIMAL(10, 2),
    VeiculoID INT,
    MecanicoID INT,
    FOREIGN KEY (VeiculoID) REFERENCES Veiculo(VeiculoID),
    FOREIGN KEY (MecanicoID) REFERENCES Mecanico(MecanicoID)
);
servico
CREATE TABLE Pecas (
    PecaID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Valor DECIMAL(10, 2),
    ServicoID INT,
    FOREIGN KEY (ServicoID) REFERENCES Servico(ServicoID)
);

select * from bd.cliente
select * from bd.servico
select * from bd.veiculo
select * from bd.pecas




SELECT Cliente.Nome, Veiculo.Placa, Veiculo.Modelo, Veiculo.Ano
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID; -- todos os clientes com o veiculos 

SELECT Veiculo.Placa, Servico.Descricao, Servico.Data, Servico.Valor -- serviços feitos em um veiculo
FROM Veiculo
JOIN Servico ON Veiculo.VeiculoID = Servico.VeiculoID
WHERE Veiculo.Placa = 'ABC-1234';

SELECT Mecanico.Nome, Servico.Descricao, Servico.Data, Servico.Valor -- mecanicos e os serviços realizados.
FROM Mecanico
JOIN Servico ON Mecanico.MecanicoID = Servico.MecanicoID;

SELECT Mecanico.Nome, COUNT(Servico.ServicoID) AS TotalServicos -- total de serviços realizados por cada mec
FROM Mecanico
JOIN Servico ON Mecanico.MecanicoID = Servico.MecanicoID
GROUP BY Mecanico.Nome;

SELECT Servico.Descricao, pecas.Nome, pecas.Valor -- peças utilizadas em cada serviço
FROM pecas
JOIN Servico ON pecas.ServicoID = Servico.ServicoID;

SELECT Cliente.Nome, SUM(Servico.Valor) AS TotalGasto -- valor total gasto por cada cliente
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN Servico ON Veiculo.VeiculoID = Servico.VeiculoID
GROUP BY Cliente.Nome;

SELECT Cliente.Nome                                   -- nunca realizaram serviço
FROM Cliente
LEFT JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
LEFT JOIN Servico ON Veiculo.VeiculoID = Servico.VeiculoID
WHERE Servico.ServicoID IS NULL;

UPDATE Cliente                 -- atualizar o telefone de um cliente. 
SET Telefone = '98888-7777'
WHERE CPF_CNPJ = '123.456.789-00';


DELETE FROM Servico
WHERE ServicoID = 10;  -- excluir um serviço realizado 

INSERT INTO Servico (Descricao, Data, Valor, VeiculoID, MecanicoID)  -- inserir um novo servico
VALUES ('Troca de óleo', '2024-09-01', 200.00, 1, 3);

SELECT Veiculo.Placa, Servico.Descricao, Servico.Data 
FROM Veiculo 
JOIN Servico ON Veiculo.VeiculoID = Servico.VeiculoID 
WHERE Servico.Descricao LIKE '%pneu%'; 







