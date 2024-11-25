CREATE DATABASE HotelLabBd
USE HotelLabBd

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


-- verificar checkin
CREATE TRIGGER trg_prevent_conflicting_checkin
ON checkin
INSTEAD OF INSERT
AS
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT quartonumero, 
                   inicio AS start_date, 
                   DATEADD(DAY, qtd_dias - 1, inicio) AS end_date
            FROM reserva
            UNION ALL
            SELECT quartonumero, 
                   data_checkin AS start_date, 
                   data_checkout AS end_date
            FROM checkin
        ) AS ocupacao
        JOIN inserted i ON ocupacao.quartonumero = i.quartonumero
        WHERE 
            (i.data_checkin BETWEEN ocupacao.start_date AND ocupacao.end_date) OR
            (i.data_checkout BETWEEN ocupacao.start_date AND ocupacao.end_date) OR
            (i.data_checkin <= ocupacao.start_date AND i.data_checkout >= ocupacao.end_date)
    )
    BEGIN
        RAISERROR('O quarto já está ocupado ou reservado para o período especificado.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        
        INSERT INTO checkin(id, data_checkin, data_checkout, reservado, clientecpf, quartonumero)
        SELECT id, data_checkin, data_checkout, reservado, clientecpf, quartonumero
        FROM inserted;
    END
END;


SELECT * FROM cliente;
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
SELECT * FROM tipo

-- Tabela quarto
INSERT INTO quarto (numero, andar, descricao, tipoid) VALUES
(101, 1, 'Quarto Simples com cama de solteiro', 1),
(102, 1, 'Quarto Duplo com duas camas de solteiro', 2),
(201, 2, 'Suíte Luxo com cama king size e banheira', 3);

Select * from quarto

-- Tabela reserva
INSERT INTO reserva (id, inicio, qtd_dias, valor, clientecpf, quartonumero) VALUES
(1, '2024-10-20', 5, 750.00, '12345678901', 101),
(2, '2024-10-22', 3, 750.00, '98765432100', 201),
(3, '2024-10-24', 2, 500.00, '45678912300', 102);
SELECT * FROM reserva

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
SELECT * FROM solicitacoesServicos

SELECT * FROM f_quartosDisponiveis('2024-10-25', 3);

DELETE FROM solicitacoesServicos;
DELETE FROM checkin;
DELETE FROM reserva;
DELETE FROM quarto;
DELETE FROM tipo;
DELETE FROM servico;
DELETE FROM cliente;


INSERT INTO reserva (id, inicio, qtd_dias, clientecpf, quartonumero)
VALUES (1, '2024-11-15', 5, '1', 101);

CREATE TRIGGER trg_before_insert_reserva
ON reserva
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO reserva (id, inicio, qtd_dias, valor, clientecpf, quartonumero)
    SELECT 
        i.id,
        i.inicio,
        i.qtd_dias,
        t.preco * i.qtd_dias AS valor,
        i.clientecpf,
        i.quartonumero
    FROM 
        inserted i
    INNER JOIN 
        quarto q ON i.quartonumero = q.numero
    INNER JOIN 
        tipo t ON q.tipoid = t.id;
END;


-- Deve-se poder gerar um relatório em PDF com os dados dos quartos, tipo, valor dos
-- quartos disponíveis em um determinado dia.
	SELECT 
		q.numero AS quarto_numero,
		q.andar,
		q.descricao,
		t.nome AS tipo_nome,
		t.preco AS preco
	FROM 
		quarto q
	JOIN 
		tipo t ON q.tipoid = t.id
	LEFT JOIN 
		reserva r ON q.numero = r.quartonumero
		AND '2024-11-24' BETWEEN r.inicio AND DATEADD(DAY, r.qtd_dias, r.inicio)
	LEFT JOIN 
		checkin c ON q.numero = c.quartonumero
		AND '2024-11-24' BETWEEN c.data_checkin AND c.data_checkout
	WHERE 
		r.id IS NULL 
		AND c.id IS NULL;


--Deve-se poder gerar um relatório em PDF com os dados do cliente, da hospedagem,
--serviços consumidos e o valor total (Apenas no cabeçalho) do período contratado.
SELECT 
    cli.nome AS cliente_nome,
    cli.telefone AS cliente_telefone,
    q.numero AS quarto_numero,
    q.descricao AS quarto_descricao,
    t.nome AS tipo_quarto,
    t.preco AS preco_quarto,
    r.inicio AS data_inicio_reserva,
    r.qtd_dias AS quantidade_dias,
    r.valor AS valor_hospedagem,
    ISNULL(SUM(ss.valorTotal), 0) AS valor_servicos,
    (r.valor + ISNULL(SUM(ss.valorTotal), 0)) AS valor_total
FROM 
    cliente cli
JOIN 
    reserva r ON cli.cpf = r.clientecpf
JOIN 
    quarto q ON r.quartonumero = q.numero
JOIN 
    tipo t ON q.tipoid = t.id
LEFT JOIN 
    checkin c ON r.id = c.id
LEFT JOIN 
    solicitacoesServicos ss ON c.id = ss.checkinid
WHERE 
    r.inicio >= '2024-11-01' 
    AND DATEADD(DAY, r.qtd_dias, r.inicio) <= '2024-11-30' 
GROUP BY 
    cli.nome, cli.telefone, q.numero, q.descricao, t.nome, t.preco, r.inicio, r.qtd_dias, r.valor;


--Deve-se poder gerar um relatório em PDF com os dados dos clientes, quartos, tipo
-- e valor, das reservas de um determinado dia

SELECT 
    cli.nome AS cliente_nome,
    cli.telefone AS cliente_telefone,
    q.numero AS quarto_numero,
    q.descricao AS quarto_descricao,
    t.nome AS tipo_quarto,
    t.preco AS preco_quarto,
    r.inicio AS data_inicio_reserva,
    r.qtd_dias AS quantidade_dias,
    r.valor AS valor_reserva
FROM 
    reserva r
JOIN 
    cliente cli ON r.clientecpf = cli.cpf
JOIN 
    quarto q ON r.quartonumero = q.numero
JOIN 
    tipo t ON q.tipoid = t.id
WHERE 
    '2024-10-22' BETWEEN r.inicio AND DATEADD(DAY, r.qtd_dias - 1, r.inicio);

