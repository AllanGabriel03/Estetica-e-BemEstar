-- TESTANDO
select * from item;

select * from produto;

select * from estoque;


INSERT INTO item
(
    idcategoria,
    item,
    descricao_item,
    preco,
    tipo_item,
    ativo_produto_servico
)
VALUES
-- 01
(1,
 'Limpeza de Pele Profunda',
 'Limpeza de pele profunda com higienizacao, esfoliacao, extracao e hidratacao.',
 120.00,
 'S',
 'S'),

-- 02
(1,
 'Limpeza de Pele Express',
 'Limpeza facial rapida para remocao de impurezas e oleosidade.',
 80.00,
 'S',
 'S'),

-- 03
(2,
 'Tratamento Facial Hidratante',
 'Tratamento facial para hidratacao e revitalizacao da pele.',
 150.00,
 'S',
 'S'),

-- 04
(2,
 'Tratamento Facial Antiacne',
 'Tratamento facial direcionado para controle da oleosidade e acne.',
 160.00,
 'S',
 'S'),

-- 05
(3,
 'Tratamento Corporal Modelador',
 'Tratamento corporal estetico para modelagem e definicao do contorno corporal.',
 180.00,
 'S',
 'S'),

-- 06
(3,
 'Tratamento Corporal Redutor',
 'Tratamento estetico corporal para auxiliar na reducao de medidas.',
 200.00,
 'S',
 'S'),

-- 07
(4,
 'Massagem Relaxante',
 'Massagem corporal relaxante para alivio de tensoes musculares.',
 100.00,
 'S',
 'S'),

-- 08
(4,
 'Massagem Modeladora',
 'Massagem corporal com tecnicas de modelagem e estimulacao circulatoria.',
 130.00,
 'S',
 'S'),

-- 09
(5,
 'Depilacao Pernas',
 'Depilacao completa das pernas com cera.',
 90.00,
 'S',
 'S'),

-- 10
(5,
 'Depilacao Axilas',
 'Depilacao das axilas com cera.',
 35.00,
 'S',
 'S'),

-- 11
(6,
 'Design de Sobrancelhas',
 'Modelagem e definicao das sobrancelhas de acordo com o formato do rosto.',
 45.00,
 'S',
 'S'),

-- 12
(6,
 'Design de Sobrancelhas com Henna',
 'Design de sobrancelhas com aplicacao de henna.',
 65.00,
 'S',
 'S'),

-- 13
(7,
 'Micropigmentacao de Sobrancelhas',
 'Procedimento estetico para definicao e preenchimento das sobrancelhas.',
 450.00,
 'S',
 'S'),

-- 14
(8,
 'Extensao de Cilios',
 'Aplicacao de extensao de cilios para alongamento e volume.',
 180.00,
 'S',
 'S'),

-- 15
(9,
 'Lash Lifting',
 'Procedimento para curvatura e realce dos cilios naturais.',
 150.00,
 'S',
 'S'),

-- 16
(10,
 'Peeling Facial',
 'Procedimento de renovacao da pele por meio de peeling facial.',
 180.00,
 'S',
 'S'),

-- 17
(11,
 'Drenagem Linfatica',
 'Massagem corporal com tecnica de drenagem linfatica.',
 120.00,
 'S',
 'S'),

-- 18
(12,
 'Radiofrequencia Facial',
 'Procedimento estetico facial utilizando tecnologia de radiofrequencia.',
 180.00,
 'S',
 'S'),

-- 19
(12,
 'Radiofrequencia Corporal',
 'Procedimento estetico corporal utilizando tecnologia de radiofrequencia.',
 220.00,
 'S',
 'S'),

-- 20
(13,
 'Tratamento Capilar Hidratante',
 'Tratamento capilar para hidratacao e recuperacao dos fios.',
 100.00,
 'S',
 'S');
