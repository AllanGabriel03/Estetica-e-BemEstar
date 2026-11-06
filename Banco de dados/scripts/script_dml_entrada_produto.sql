select 
	* 
from item
	where 
tipo_item = 'p';

select * from entrada_produto;

select * from estoque;

select * from produto;

INSERT INTO entrada_produto
(
    iditem,
    data_entrada_produto,
    quantidade_entrada,
    unidade,
    valor_unitario_entrada
)
VALUES

-- Produto 1 - Protetor Solar Facial
(21, '2026-09-01', 55, 'UN', 48.60),

-- Produto 2 - Sabonete Facial
(22, '2026-09-02', 30, 'UN', 33.28),

-- Produto 3 - Gel de Limpeza Facial
(23, '2026-09-03', 500, 'UN', 50.00),

-- Produto 4 - Serum Vitamina C
(24, '2026-09-04', 10, 'UN', 71.50),

-- Produto 5 - Serum Acido Hialuronico
(25, '2026-09-05', 180, 'UN', 80.00),

-- Produto 6 - Creme Hidratante Corporal
(26, '2026-09-06', 250, 'UN', 30.00),

-- Produto 7 - Esfoliante Corporal
(27, '2026-09-07', 20, 'UN', 50.00),

-- Produto 8 - Oleo Corporal Relaxante
(28, '2026-09-08', 5, 'UN', 60.00),

-- Produto 9 - Cera Depilatoria Facial
(29, '2026-09-09', 40, 'UN', 30.00),

-- Produto 10 - Henna para Sobrancelhas
(30, '2026-09-10', 300, 'UN', 25.00),

-- Produto 31 - Protetor Labial FPS 30
(31, '2026-09-11', 3, 'UN', 100.00),

-- Produto 32 - Base Facial Liquida
(32, '2026-09-12', 200, 'UN', 95.80),

-- NOVA entrada do produto 1
(33, '2026-09-15', 150, 'UN', 65.00),

-- NOVA entrada do produto 4
(34, '2026-09-16', 100, 'UN', 120.00),

-- NOVA entrada do produto 5
(35, '2026-09-18', 120, 'UN', 70.00),

-- NOVA entrada do produto 6
(36, '2026-09-20', 20, 'UN', 45.00),

-- NOVA entrada do produto 9
(37, '2026-09-22', 25, 'UN', 42.00),

-- NOVA entrada do produto 10
(38, '2026-09-24', 15, 'UN', 75.00),

-- NOVA entrada do produto 31
(39, '2026-09-26', 400, 'UN', 20.50),

-- NOVA entrada do produto 32
(40, '2026-09-28', 105, 'UN', 54.00);

