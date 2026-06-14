-- CONSULTAS RENAN
-- Listar o nome de todos os clientes cadastrados
SELECT nomeCli
FROM Cliente
;

-- Exibir código do pedido, a data e o nome do cliente que realizou uma compra
SELECT p.codPed, p.data, p.nomeCli
FROM Pedido p INNER JOIN Cliente c
  ON p.telCli = c.telCli
;

-- Identificar os nomes dos acessórios que foram cadastrados, mas nunca foram utilizados em nenhuma preparação
SELECT nomeAcess
FROM Acessorio
EXCEPT
SELECT nomeAcess
FROM Preparacao
;

-- Calcular a quantidade total de itens vendidos agrupados por cada código de pedido
SELECT codPed, SUM(quantidade) AS totalItens
FROM ItemPedido
GROUP BY codPed
;

-- Selecionar o nome dos clientes que realizaram compras durante o ano de 2026
SELECT nomeCli
FROM Cliente
WHERE telCli IN (
  SELECT telCli
  FROM Pedido
  WHERE data BETWEEN '2026-01-01' AND '2026-12-31'
)
;

-- CONSULTAS PEDRO
-- Listar a descrição e o sabor de todos os queijos com maturação superior a 30 dias
SELECT descProd, sabor
FROM Queijo
WHERE maturacao > 30
;

-- Listar a descrição do produto e o teor alcoólico de todas as bebidas que já foram vendidas
SELECT b.descProd, b.teor
FROM Bebida b INNER JOIN ItemPedido i
  ON b.descProd = i.descProd
  AND b.paisOri = i.paisOri
  AND b.cidOri = i.cidOri
  AND b.regOri = i.regOri
;

-- Identificar quais produtos foram cadastrados no sistema, mas nunca saíram em nenhum pedido
SELECT descProd, paisOri, cidOri, regOri
FROM Produto
EXCEPT
SELECT descProd, paisOri, cidOri, regOri
FROM ItemPedido
;

-- Exibir a média de tempo de maturação dos queijos por região de origem, mostrando apenas as regiões cuja média calculada seja maior que 15 dias
SELECT regOri, AVG(maturacao) AS mediaMaturacao
FROM Queijo
GROUP BY regOri
HAVING AVG(maturacao) > 15
;

-- Listar os dados completos dos produtos de fabricação 'artesanal' que possuem pelo menos uma ferramenta/acessório associado na tabela de preparação
SELECT *
FROM Produto p
WHERE producao = 'artesanal'
AND EXISTS (
  SELECT 1
  FROM Preparacao prep
  WHERE prep.paisOri = p.paisOri
    AND prep.cidOri = p.cidOri
    AND prep.regOri = p.regOri
)
;