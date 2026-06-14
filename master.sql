DROP SCHEMA IF EXISTS Delicatessen CASCADE;
CREATE SCHEMA Delicatessen;
SET search_path TO Delicatessen;

CREATE TABLE Cliente (
	telCli        VARCHAR(20)     NOT NULL,
	nomeCli       VARCHAR(100)    NOT NULL,

	CONSTRAINT PK_CLIENTE PRIMARY KEY (telCli, nomeCli)
);

CREATE TABLE Origem (
	paisOri       VARCHAR(50)     NOT NULL,
	cidOri        VARCHAR(50)     NOT NULL,
	regOri        VARCHAR(50)     NOT NULL,
	
	CONSTRAINT PK_ORIGEM PRIMARY KEY (paisOri, cidOri, regOri)
);

CREATE TABLE Produto (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  tipo          VARCHAR(30)       NOT NULL,
  producao      VARCHAR(20)       NOT NULL CHECK (producao IN ('artesanal', 'industrial')),

  CONSTRAINT PK_PRODUTO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_PRODUTO FOREIGN KEY (paisOri, cidOri, regOri)
  	REFERENCES Origem(paisOri, cidOri, regOri)
);

CREATE TABLE Queijo (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  sabor         VARCHAR(30)       NOT NULL,
  textura       VARCHAR(30)       NOT NULL,
  maturacao     INT               NOT NULL CHECK (maturacao >= 0),

  CONSTRAINT PK_QUEIJO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_QUEIJO_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Paes (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  formato		VARCHAR(50)		  NOT NULL,
  
  CONSTRAINT PK_PAES PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_PAES_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Bebida (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  teor          DECIMAL(4,2)      NOT NULL,
  aroma         VARCHAR(50)       NOT NULL,
  
  CONSTRAINT PK_BEBIDA PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_BEBIDA_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Infusao (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  
  CONSTRAINT PK_INFUSAO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_INFUSAO_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Pedido (
  codPed        INT               PRIMARY KEY,
  data          DATE              NOT NULL,
  condicao      VARCHAR(100),
  telCli        VARCHAR(20),
  nomeCli       VARCHAR(100),

  CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (telCli, nomeCli) 
    REFERENCES Cliente(telCli, nomeCli) ON DELETE SET NULL
);

CREATE TABLE ItemPedido (
  codPed        INT,
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  quantidade    INT               NOT NULL CHECK (quantidade > 0),
  preferencias	VARCHAR(100),		  
  condicao      VARCHAR(50),

  CONSTRAINT PK_ITEM_PEDIDO PRIMARY KEY (codPed, descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_ITEM_PEDIDO_MAPA FOREIGN KEY (codPed)
    REFERENCES Pedido(codPed) ON DELETE CASCADE,
  CONSTRAINT FK_ITEM_PEDIDO_PROD FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri)
);

CREATE TABLE Item (
  valItem 		DATE 		  	  NOT NULL, 
  numItem		INT				  NOT NULL,

  CONSTRAINT PK_ITEM PRIMARY KEY (valItem, numItem)
);

CREATE TABLE ItemVenda(
  valItem		DATE			  NOT NULL,
  numItem		INT				  NOT NULL,
  descProd		VARCHAR(100)	  NOT NULL,
  paisOri		VARCHAR(50)		  NOT NULL,
  cidOri		VARCHAR(50)		  NOT NULL,
  regOri		VARCHAR(50)		  NOT NULL,

  CONSTRAINT PK_ITEM_VENDA PRIMARY KEY (valItem, numItem),
  -- Item
  CONSTRAINT FK_ITEM_VENDA_ITEM FOREIGN KEY (valItem, numItem)
  	REFERENCES Item(valItem, numItem),
-- Produto
  CONSTRAINT FK_ITEM_VENDA_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri)
  	REFERENCES Produto(descProd, paisOri, cidOri, regOri)
);

CREATE TABLE ItemPreparado(
  valItem		DATE			  NOT NULL,
  numItem		INT				  NOT NULL,
  codPed		INT				  NOT NULL,
  descProd 		VARCHAR(100)	  NOT NULL,
  paisOri		VARCHAR(50)		  NOT NULL,
  cidOri		VARCHAR(50)		  NOT NULL,
  regOri		VARCHAR(50)		  NOT NULL,
  data		    DATE			  NOT NULL,
  horario       TIME		      NOT NULL,
	
  CONSTRAINT PK_ITEM_PREPARADO PRIMARY KEY (valItem, numItem),
-- Item
  CONSTRAINT FK_ITEM_PREPARADO_ITEM FOREIGN KEY (valItem, numItem)
	REFERENCES Item(valItem, numItem),	
-- ItemPedido
  CONSTRAINT FK_ITEM_PREPARADO_ITEM_PEDIDO FOREIGN KEY (codPed, descProd, paisOri, cidOri, regOri)
  	REFERENCES ItemPedido(codPed, descProd, paisOri, cidOri, regOri)
);

CREATE TABLE Acessorio (
  nomeAcess     VARCHAR(50)       PRIMARY KEY,
  funcao        VARCHAR(100)      NOT NULL
);

CREATE TABLE Preparacao (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  nomeAcess     VARCHAR(50)       NOT NULL,
  tempo 		INT				  NOT NULL, -- EM MINUTOS
  modo			VARCHAR(50)		  NOT NULL, -- 

  CONSTRAINT PK_PREPARACAO PRIMARY KEY (descProd, paisOri, cidOri, regOri, nomeAcess),
  CONSTRAINT FK_PREPARACAO_INFUSAO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Infusao(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE,
  CONSTRAINT FK_PREPARACAO_ACESS FOREIGN KEY (nomeAcess)
    REFERENCES Acessorio(nomeAcess) ON DELETE CASCADE
);

CREATE TABLE Ornamentacao (
  descProdQ      VARCHAR(100)      NOT NULL,
  paisOriQ       VARCHAR(50)       NOT NULL,
  cidOriQ        VARCHAR(50)       NOT NULL,
  regOriQ        VARCHAR(50)       NOT NULL,
  descProdB      VARCHAR(100)      NOT NULL,
  paisOriB       VARCHAR(50)       NOT NULL,
  cidOriB        VARCHAR(50)       NOT NULL,
  regOriB        VARCHAR(50)       NOT NULL,

  CONSTRAINT PK_ORNAMENTACAO PRIMARY KEY (descProdQ, paisOriQ, cidOriQ, regOriQ, descProdB, paisOriB, cidOriB, regOriB),
  -- QUEIJO
  CONSTRAINT FK_ORNAMENTACAO_QUEIJO FOREIGN KEY (descProdQ, paisOriQ, cidOriQ, regOriQ)
  	REFERENCES Queijo(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE,
  -- BEBIDA
  CONSTRAINT FK_ORNAMENTACAO_BEBIDA FOREIGN KEY (descProdB, paisOriB, cidOriB, regOriB)
  	REFERENCES Bebida(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);


SET search_path TO Delicatessen;
INSERT INTO Cliente VALUES
('000000001', 'Mariana Oliveira'),
('000000002', 'Sofia Ferreti'),
('000000003', 'Mario Adriano'),
('000000004', 'Roberto Silva'),
('000000005', 'Loan Vieira'),
('000000006', 'Gustavo Bernardo'),
('000000007', 'Juliana Costa'),
('000000008', 'Paulo Henrique'),
('000000009', 'Ana Beatriz'),
('000000010', 'Fernanda Rocha');

INSERT INTO Origem VALUES
('Franca', 'Paris', 'Ile-de-France'),
('Italia', 'Parma', 'Emilia-Romagna'),
('Portugal', 'Lisboa', 'Lisboa'),
('Brasil', 'Petropolis', 'Rio de Janeiro'),
('Suica', 'Gruyeres', 'Fribourg'),
('Espanha', 'La Mancha', 'Castela-La Mancha'),
('Argentina', 'Mendoza', 'Mendoza'),
('Japao', 'Uji', 'Quioto'),
('Inglaterra', 'Cheddar', 'Somerset'),
('Holanda', 'Gouda', 'Holanda do Sul');

INSERT INTO Produto VALUES
('Brie',                 'Franca',      'Paris',      'Ile-de-France',      'Queijo',  'artesanal'),
('Camembert',            'Franca',      'Paris',      'Ile-de-France',      'Queijo',  'artesanal'),
('Parmigiano Reggiano',  'Italia',      'Parma',      'Emilia-Romagna',     'Queijo',  'artesanal'),
('Gruyere',              'Suica',       'Gruyeres',   'Fribourg',           'Queijo',  'artesanal'),
('Gouda',                'Holanda',     'Gouda',      'Holanda do Sul',     'Queijo',  'industrial'),
('Manchego',             'Espanha',     'La Mancha',  'Castela-La Mancha',  'Queijo',  'artesanal'),

('Baguete Tradicional',  'Franca',      'Paris',      'Ile-de-France',      'Pao',     'artesanal'),
('Ciabatta',             'Italia',      'Parma',      'Emilia-Romagna',     'Pao',     'artesanal'),
('Pao Australiano',      'Brasil',      'Petropolis', 'Rio de Janeiro',     'Pao',     'industrial'),

('Vinho Tinto Reserva',  'Portugal',    'Lisboa',     'Lisboa',             'Bebida',  'industrial'),
('Vinho Malbec',         'Argentina',   'Mendoza',    'Mendoza',            'Bebida',  'industrial'),
('Vinho do Porto',       'Portugal',    'Lisboa',     'Lisboa',             'Bebida',  'artesanal'),

('Cha Verde Uji',    'Japao',      'Uji',        'Quioto',          'Infusao', 'artesanal'),
('Cha Preto Ingles', 'Inglaterra', 'Cheddar',    'Somerset',        'Infusao', 'industrial'),
('Cha de Camomila',  'Brasil',     'Petropolis', 'Rio de Janeiro',  'Infusao', 'artesanal');

INSERT INTO Queijo VALUES
('Brie',                'Franca',  'Paris',     'Ile-de-France',     'Suave',   'Cremosa', 45),
('Camembert',           'Franca',  'Paris',     'Ile-de-France',     'Intenso', 'Macia',   30),
('Parmigiano Reggiano', 'Italia',  'Parma',     'Emilia-Romagna',    'Forte',   'Dura',    365),
('Gruyere',             'Suica',   'Gruyeres',  'Fribourg',          'Leve',    'Firme',   180),
('Gouda',               'Holanda', 'Gouda',     'Holanda do Sul',    'Doce',    'Semi-dura',120),
('Manchego',            'Espanha', 'La Mancha', 'Castela-La Mancha', 'Picante', 'Firme',   150);

INSERT INTO Paes VALUES
('Baguete Tradicional', 'Franca', 'Paris', 'Ile-de-France', 'Alongado'),
('Ciabatta',            'Italia', 'Parma', 'Emilia-Romagna', 'Retangular'),
('Pao Australiano',     'Brasil', 'Petropolis', 'Rio de Janeiro', 'Redondo');

INSERT INTO Bebida VALUES
('Vinho Tinto Reserva', 'Portugal',  'Lisboa',  'Lisboa',   13.5, 'Frutado'),
('Vinho Malbec',        'Argentina', 'Mendoza', 'Mendoza',  14.0, 'Amadeirado'),
('Vinho do Porto',      'Portugal',  'Lisboa',  'Lisboa',   19.0, 'Adocicado');

INSERT INTO Infusao VALUES
('Cha Verde Uji',    'Japao',      'Uji',        'Quioto'),
('Cha Preto Ingles', 'Inglaterra', 'Cheddar',    'Somerset'),
('Cha de Camomila',  'Brasil',     'Petropolis', 'Rio de Janeiro');

INSERT INTO Acessorio VALUES
('Bule', 'Preparo de cha por infusao'),
('Infusor de Cha', 'Preparo individual de cha por infusao'),
('Coador', 'Filtragem de cha solto');
 
INSERT INTO Ornamentacao VALUES
('Parmigiano Reggiano', 'Italia', 'Parma', 'Emilia-Romagna', 'Vinho Tinto Reserva', 'Portugal', 'Lisboa', 'Lisboa'),
('Brie', 'Franca', 'Paris', 'Ile-de-France', 'Vinho do Porto', 'Portugal', 'Lisboa', 'Lisboa'),
('Manchego', 'Espanha', 'La Mancha', 'Castela-La Mancha', 'Vinho Malbec', 'Argentina', 'Mendoza', 'Mendoza');
 
INSERT INTO Preparacao VALUES
('Cha Verde Uji', 'Japao', 'Uji', 'Quioto', 'Bule', 3, 'Infusionar em agua a 80 graus'),
('Cha Preto Ingles', 'Inglaterra', 'Cheddar', 'Somerset', 'Infusor de Cha', 5, 'Infusionar em agua quente'),
('Cha de Camomila', 'Brasil', 'Petropolis', 'Rio de Janeiro', 'Coador', 4, 'Infusionar em agua fervente');
 
INSERT INTO Produto VALUES
('Sanduiche de Pastrami', 'Brasil', 'Petropolis', 'Rio de Janeiro', 'Sanduiche', 'artesanal'),
('Salada Caprese', 'Brasil', 'Petropolis', 'Rio de Janeiro', 'Salada', 'artesanal'),
('Tabua de Queijos e Frios', 'Brasil', 'Petropolis', 'Rio de Janeiro', 'Prato Pronto', 'artesanal');
 
INSERT INTO Pedido (codPed, data, condicao, telCli, nomeCli) VALUES
(1, '2026-06-01', 'retirado',  '000000001', 'Mariana Oliveira'),
(2, '2026-06-02', 'pendente',  '000000002', 'Sofia Ferreti'),
(3, '2026-06-03', 'pendente',  '000000003', 'Mario Adriano'),
(4, '2026-06-03', 'cancelado', '000000004', 'Roberto Silva'),
(5, '2026-06-05', 'retirado',  '000000001', 'Mariana Oliveira');
 
INSERT INTO ItemPedido (codPed, descProd, paisOri, cidOri, regOri, quantidade, preferencias, condicao) VALUES
-- Pedido 1 (Mariana, retirado)
(1, 'Sanduiche de Pastrami', 'Brasil', 'Petropolis', 'Rio de Janeiro', 2, 'Sem cebola', 'entregue'),
(1, 'Cha Verde Uji', 'Japao', 'Uji', 'Quioto', 1, NULL, 'entregue'),
 
-- Pedido 2 (Sofia, pendente)
(2, 'Salada Caprese', 'Brasil', 'Petropolis', 'Rio de Janeiro', 1, 'Sem azeite extra', 'pendente'),
(2, 'Vinho Malbec', 'Argentina', 'Mendoza', 'Mendoza', 1, NULL, 'pendente'),
 
-- Pedido 3 (Mario, pendente)
(3, 'Tabua de Queijos e Frios', 'Brasil', 'Petropolis', 'Rio de Janeiro', 1, NULL, 'pendente'),
(3, 'Vinho do Porto', 'Portugal', 'Lisboa', 'Lisboa', 1, NULL, 'pendente'),
 
-- Pedido 4 (Roberto, cancelado - cozinheiro cancelou por falta de ingrediente)
(4, 'Sanduiche de Pastrami', 'Brasil', 'Petropolis', 'Rio de Janeiro', 1, NULL, 'cancelado'),
 
-- Pedido 5 (Mariana, retirado)
(5, 'Cha Preto Ingles', 'Inglaterra', 'Cheddar', 'Somerset', 2, NULL, 'entregue'),
(5, 'Baguete Tradicional', 'Franca', 'Paris', 'Ile-de-France', 1, NULL, 'entregue');

INSERT INTO Item VALUES
('2026-12-01', 1),  -- Brie (estoque)
('2027-06-01', 2),  -- Vinho Malbec (estoque)
('2026-12-15', 3),  -- Cha Preto Ingles (estoque)
('2026-06-15', 4),  -- Baguete Tradicional (estoque)
('2027-01-01', 5),  -- Vinho do Porto (estoque)
('2026-06-03', 6),  -- Sanduiche de Pastrami (preparado p/ pedido 1)
('2026-06-04', 7),  -- Salada Caprese (preparado p/ pedido 2)
('2026-06-05', 8);  -- Tabua de Queijos e Frios (preparado p/ pedido 3)
 
INSERT INTO ItemVenda VALUES
('2026-12-01', 1, 'Brie', 'Franca', 'Paris', 'Ile-de-France'),
('2027-06-01', 2, 'Vinho Malbec', 'Argentina', 'Mendoza', 'Mendoza'),
('2026-12-15', 3, 'Cha Preto Ingles', 'Inglaterra', 'Cheddar', 'Somerset'),
('2026-06-15', 4, 'Baguete Tradicional', 'Franca', 'Paris', 'Ile-de-France'),
('2027-01-01', 5, 'Vinho do Porto', 'Portugal', 'Lisboa', 'Lisboa');
 
INSERT INTO ItemPreparado VALUES
('2026-06-03', 6, 1, 'Sanduiche de Pastrami', 'Brasil', 'Petropolis', 'Rio de Janeiro', '2026-06-01', '12:15:00'),
('2026-06-04', 7, 2, 'Salada Caprese', 'Brasil', 'Petropolis', 'Rio de Janeiro', '2026-06-02', '13:00:00'),
('2026-06-05', 8, 3, 'Tabua de Queijos e Frios', 'Brasil', 'Petropolis', 'Rio de Janeiro', '2026-06-03', '11:30:00');


-- CONSULTAS RENAN
-- 1 - Listar o nome de todos os clientes cadastrados
SELECT nomeCli
FROM Cliente;

-- 2 - Exibir código do pedido, a data e o nome do cliente que realizou uma compra
SELECT p.codPed, p.data, c.nomeCli
FROM Pedido p
INNER JOIN Cliente c
  ON p.telCli = c.telCli
 AND p.nomeCli = c.nomeCli
;

-- 3 - Identificar os nomes dos acessórios que foram cadastrados, mas nunca foram utilizados em nenhuma preparação
SELECT nomeAcess
FROM Acessorio
EXCEPT
SELECT nomeAcess
FROM Preparacao
;

-- 4 - Calcular a quantidade total de itens vendidos agrupados por cada código de pedido
SELECT codPed, SUM(quantidade) AS totalItens
FROM ItemPedido
GROUP BY codPed
;

-- 5 - Selecionar o nome dos clientes que realizaram compras durante o ano de 2026
SELECT DISTINCT nomeCli
FROM Cliente
WHERE telCli IN (
  SELECT telCli
  FROM Pedido
  WHERE data BETWEEN '2026-01-01' AND '2026-12-31'
)
;

---------------------------------------------------------

-- CONSULTAS PEDRO

-- 6 - Listar a descrição e o sabor de todos os queijos com maturação superior a 30 dias
SELECT descProd, sabor
FROM Queijo
WHERE maturacao > 30
;

-- 7 -  Listar a descrição do produto e o teor alcoólico de todas as bebidas que já foram vendidas
SELECT DISTINCT b.descProd, b.teor
FROM Bebida b
INNER JOIN ItemPedido i
  ON b.descProd = i.descProd
 AND b.paisOri = i.paisOri
 AND b.cidOri = i.cidOri
 AND b.regOri = i.regOri
;

-- 8 - Identificar quais produtos foram cadastrados no sistema, mas nunca saíram em nenhum pedido
SELECT descProd, paisOri, cidOri, regOri
FROM Produto
EXCEPT
SELECT descProd, paisOri, cidOri, regOri
FROM ItemPedido
;


-- 9 - Exibir a média de tempo de maturação dos queijos por região de origem,
-- mostrando apenas as regiões cuja média calculada seja maior que 15 dias
SELECT regOri, AVG(maturacao) AS mediaMaturacao
FROM Queijo
GROUP BY regOri
HAVING AVG(maturacao) > 15
;

-- 10 - Listar os dados completos dos produtos de fabricação 'artesanal'
-- que possuem pelo menos um acessório associado na tabela de preparação
SELECT *
FROM Produto p
WHERE producao = 'artesanal'
AND EXISTS (
  SELECT 1
  FROM Preparacao prep
  WHERE prep.descProd = p.descProd
    AND prep.paisOri = p.paisOri
    AND prep.cidOri = p.cidOri
    AND prep.regOri = p.regOri
)
;

-- CONSULTAS LOHAN
-- 11 - Listar a(s) bebida(s) mais vendidas de 2026 e a quantidade. 
SELECT b.descProd,
SUM(ip.quantidade) AS total_vendido
FROM Bebida b
JOIN ItemPedido ip
ON b.descProd = ip.descProd
AND b.paisOri = ip.paisOri
AND b.cidOri = ip.cidOri
AND b.regOri = ip.regOri
JOIN Pedido p
ON p.codPed = ip.codPed
WHERE p.data BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY b.descProd
ORDER BY total_vendido DESC;


-- 12 - Listar os clientes que fizeram mais de um pedido 
SELECT c.nomeCli,
      COUNT(p.codPed) AS qtdPedidos
FROM Cliente c
JOIN Pedido p
    ON c.telCli = p.telCli
   AND c.nomeCli = p.nomeCli
GROUP BY c.nomeCli
HAVING COUNT(p.codPed) > 1;

-- 13 - Listar os produtos que possuem alguma preparação cadastrada
SELECT p.descProd,
p.paisOri,
p.cidOri,
p.regOri
FROM Produto p
WHERE EXISTS (
SELECT 1
FROM Preparacao pr
WHERE pr.descProd = p.descProd
AND pr.paisOri = p.paisOri
AND pr.cidOri = p.cidOri
AND pr.regOri = p.regOri
); 

-- 14 - Exibir o código do pedido e a quantidade de itens de cada pedido 
SELECT codPed,
SUM(quantidade) AS totalItens
FROM ItemPedido
GROUP BY codPed; 

-- 15 - Listar os pedidos e os respectivos clientes que os realizaram 
SELECT p.codPed,
p.data,
c.nomeCli
FROM Pedido p
JOIN Cliente c
ON p.telCli = c.telCli
AND p.nomeCli = c.nomeCli; 

-- CONSULTAS SIMPLICIO

-- 16 - Listar os pedidos cancelados e seus itens
SELECT p.codPed, p.data, p.condicao, i.descProd, i.quantidade
FROM Pedido p
JOIN ItemPedido i
ON p.codPed = i.codPed
WHERE p.condicao = 'cancelado';

-- 17 - Listar bebidas com teor alcolico menor ou igual a 15.0
SELECT *
FROM Bebida b
WHERE b.teor <= 15.0;

-- 18 - Listar quandos produtos existem por tipo
SELECT tipo, COUNT(*) AS qtdProdutos
FROM Produto
GROUP BY tipo
ORDER BY qtdProdutos DESC;

-- 19 - Listar os queijos e as bebidas que os ornam
SELECT o.descProdQ AS Nome, o.descProdB AS Bebida, b.teor
FROM Ornamentacao o
JOIN Bebida b
ON o.descProdB = b.descProd
AND o.paisOriB  = b.paisOri
AND o.cidOriB   = b.cidOri
AND o.regOriB   = b.regOri;

-- 20 - Listar as infusões, seus acessorios e tempo e modo de preparo
SELECT pr.descProd AS infusao, a.nomeAcess, a.funcao, pr.tempo, pr.modo
FROM Acessorio a
JOIN Preparacao pr
ON a.nomeAcess = pr.nomeAcess;

-- CONSULTAS LEO

-- 21 - Exibir a quantidade de pedidos para as seguites categorias: Somente comida, Somente bebida ou ambos
SELECT
  COUNT(*) FILTER (WHERE tem_comida > 0 AND tem_bebida = 0) AS somente_comida,
  COUNT(*) FILTER (WHERE tem_bebida > 0 AND tem_comida = 0) AS somente_bebida,
  COUNT(*) FILTER (WHERE tem_comida > 0 AND tem_bebida > 0) AS ambos
FROM (
  SELECT
  codPed,
  COUNT(*) FILTER (WHERE prod.tipo IN ('Queijo','Pao','Sanduiche','Salada','Prato Pronto')) AS tem_comida,
  COUNT(*) FILTER (WHERE prod.tipo IN ('Bebida','Infusao'))                                 AS tem_bebida
  FROM ItemPedido i
  JOIN Produto prod
  ON  i.descProd = prod.descProd
  AND i.paisOri  = prod.paisOri
  AND i.cidOri   = prod.cidOri
  AND i.regOri   = prod.regOri
  GROUP BY codPed
);

-- 22 - Exibir a quantidade de pedidos que possuem uma ornamentação indicada pelo Sommelier
SELECT COUNT(DISTINCT q.codPed)
FROM ItemPedido q
JOIN Ornamentacao o
ON q.descProd = o.descProdQ
AND q.paisOri  = o.paisOriQ
AND q.cidOri   = o.cidOriQ
AND q.regOri   = o.regOriQ
JOIN ItemPedido b
ON b.codPed   = q.codPed
AND b.descProd = o.descProdB
AND b.paisOri  = o.paisOriB
AND b.cidOri   = o.cidOriB
AND b.regOri   = o.regOriB;

-- 23 - Listar os clientes que ainda não fizeram pedidos
SELECT c.nomeCli
FROM Cliente c
WHERE NOT EXISTS (
  SELECT
  FROM Pedido p
  WHERE p.telCli = c.telCli
  AND p.nomeCli = c.nomeCli
);

-- 24 - Lista de todos os produtos da frança
SELECT *
FROM Produto p
WHERE p.paisOri = 'Franca';

-- 25 - Lista de quantidade de produtos por país de origem (decrescente)
SELECT o.paisOri, COUNT(*) AS qtdProdutos
FROM Produto p
JOIN Origem o
ON p.paisOri = o.paisOri
GROUP BY o.paisOri
ORDER BY qtdProdutos DESC;

