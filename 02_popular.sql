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