
SET search_path TO Delicatessen;



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

