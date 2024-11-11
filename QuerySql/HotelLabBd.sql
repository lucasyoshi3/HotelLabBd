CREATE DATABASE HotelLabBd
USE HotelLabBd

ALTER TABLE cliente ALTER COLUMN cpf VARCHAR(11);
ALTER TABLE checkin ALTER COLUMN clientecpf VARCHAR(11);

CREATE TABLE cliente(
	cpf				VARCHAR(11),
	nome			VARCHAR(100)		NOT NULL,
	telefone		VARCHAR(11)			NOT NULL,
	cidade			VARCHAR(100)		NOT NULL
	PRIMARY KEY(cpf)
)

CREATE TABLE tipo(
	id				INT,
	nome			VARCHAR(100)		NOT NULL,
	preco			DECIMAL(10,2)		NOT NULL
	PRIMARY KEY(id)
)

CREATE TABLE quarto(
	numero			INT,
	andar			INT					NOT NULL,
	descricao		VARCHAR(200)		NOT NULL,
	tipoid			INT					NOT NULL,
	PRIMARY KEY(numero),
	FOREIGN KEY(tipoid) REFERENCES tipo(id)
)

CREATE TABLE reserva(
	id				INT,
	inicio			DATE				NOT NULL,
	qtd_dias		INT					NOT NULL,
	valor			DECIMAL(10,2)		NOT NULL,
	clientecpf		VARCHAR(11)			NOT NULL,
	quartonumero	INT					NOT NULL
	PRIMARY KEY(id),
	FOREIGN KEY(clientecpf) REFERENCES cliente(cpf),
	FOREIGN KEY(quartonumero) REFERENCES quarto(numero)
)

CREATE TABLE checkin(
	id				INT,
	data_checkin	DATE				NOT NULL,
	data_checkout	DATE				NOT NULL,
	reservado		BIT					NOT NULL,
	clientecpf		VARCHAR(11)			NOT NULL,
	quartonumero	INT					NOT NULL
	PRIMARY KEY(id),
	FOREIGN KEY(clientecpf)	REFERENCES cliente(cpf),
	FOREIGN KEY(quartonumero) REFERENCES quarto(numero)
)

CREATE TABLE servico(
	id				INT,
	nome			VARCHAR(100)		NOT NULL,
	descricao		VARCHAR(200)		NOT NULL,
	valor			DECIMAL(6,2)		NOT NULL
	PRIMARY KEY(id)
)

CREATE TABLE solicitacoesServicos(
	id				INT,
	quantidade		INT					NOT NULL,
	valorTotal		DECIMAL(8,2)		NOT NULL,
	servicoid		INT					NOT NULL,
	checkinid		INT					NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(servicoid) REFERENCES servico(id),
	FOREIGN KEY(checkinid) REFERENCES checkin(id)
)

CREATE FUNCTION f_quartosDisponiveis(
    @data_inicio DATE, 
    @qtd_dias INT
) 
RETURNS @quartos_disponiveis TABLE (
    numero INT,
    andar INT,
    descricao VARCHAR(200),
    nome_tipo VARCHAR(100)
)
AS
BEGIN
    DECLARE @data_fim DATE;
    DECLARE @quarto_numero INT;
    DECLARE @andar INT;
    DECLARE @descricao VARCHAR(200);
    DECLARE @nome_tipo VARCHAR(100);

    SET @data_fim = DATEADD(DAY, @qtd_dias, @data_inicio);

    DECLARE cursor_quartos CURSOR FOR
        SELECT q.numero, q.andar, q.descricao, t.nome
        FROM quarto q
        JOIN tipo t ON q.tipoid = t.id;

    OPEN cursor_quartos;

    FETCH NEXT FROM cursor_quartos INTO @quarto_numero, @andar, @descricao, @nome_tipo;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF NOT EXISTS (
            SELECT 1 
            FROM reserva r
            WHERE r.quartonumero = @quarto_numero
              AND r.inicio < @data_fim
              AND DATEADD(DAY, r.qtd_dias, r.inicio) > @data_inicio
        )
        AND NOT EXISTS (
            SELECT 1
            FROM checkin c
            WHERE c.quartonumero = @quarto_numero
              AND c.data_checkin < @data_fim
              AND c.data_checkout > @data_inicio
        )
        BEGIN
            INSERT INTO @quartos_disponiveis (numero, andar, descricao, nome_tipo)
            VALUES (@quarto_numero, @andar, @descricao, @nome_tipo);
        END
        FETCH NEXT FROM cursor_quartos INTO @quarto_numero, @andar, @descricao, @nome_tipo;
    END;

    CLOSE cursor_quartos;
    DEALLOCATE cursor_quartos;

    RETURN;
END;

-- Tabela cliente
INSERT INTO cliente (cpf, nome, telefone, cidade) VALUES
('12345678901', 'Maria Silva', '11987654321', 'São Paulo'),
('98765432100', 'João Souza', '21987654321', 'Rio de Janeiro'),
('45678912300', 'Ana Costa', '31987654321', 'Belo Horizonte');

-- Tabela tipo
INSERT INTO tipo (id, nome, preco) VALUES
(1, 'Quarto Simples', 150.00),
(2, 'Quarto Duplo', 250.00),
(3, 'Suíte Luxo', 500.00);

-- Tabela quarto
INSERT INTO quarto (numero, andar, descricao, tipoid) VALUES
(101, 1, 'Quarto Simples com cama de solteiro', 1),
(102, 1, 'Quarto Duplo com duas camas de solteiro', 2),
(201, 2, 'Suíte Luxo com cama king size e banheira', 3);

-- Tabela reserva
INSERT INTO reserva (id, inicio, qtd_dias, valor, clientecpf, quartonumero) VALUES
(1, '2024-10-20', 5, 750.00, '12345678901', 101),
(2, '2024-10-22', 3, 750.00, '98765432100', 201),
(3, '2024-10-24', 2, 500.00, '45678912300', 102);

-- Tabela checkin
INSERT INTO checkin (id, data_checkin, data_checkout, reservado, clientecpf, quartonumero) VALUES
(1, '2024-10-20', '2024-10-25', 1, '12345678901', 101),
(2, '2024-10-22', '2024-10-25', 1, '98765432100', 201),
(3, '2024-10-24', '2024-10-26', 1, '45678912300', 102);

-- Tabela servico
INSERT INTO servico (id, nome, descricao, valor) VALUES
(1, 'Serviço de Quarto', 'Entrega de refeições e limpeza do quarto', 50.00),
(2, 'Spa', 'Acesso ao spa com sauna e massagens', 200.00),
(3, 'Estacionamento', 'Uso do estacionamento privativo', 30.00);

-- Tabela solicitacoesServicos
INSERT INTO solicitacoesServicos (id, quantidade, valorTotal, servicoid, checkinid) VALUES
(1, 1, 50.00, 1, 1),
(2, 2, 60.00, 3, 2),
(3, 1, 200.00, 2, 3);


SELECT * FROM f_quartosDisponiveis('2024-10-25', 3);

DELETE FROM solicitacoesServicos;
DELETE FROM checkin;
DELETE FROM reserva;
DELETE FROM quarto;
DELETE FROM tipo;
DELETE FROM servico;
DELETE FROM cliente;

