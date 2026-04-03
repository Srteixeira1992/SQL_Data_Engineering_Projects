/* ===============================================================================
TEXT AND NULL FUNCTIONS PRACTICE EXERCISES
Focus: LOWER, UPPER, TRIM, REPLACE, COALESCE, NULLIF
===============================================================================
*/

-- 🧩 Exercício 1: Normalização de Títulos
-- Objetivo: Lista os 'job_title_short' mas garante que aparecem todos em 
-- LETRAS MINÚSCULAS e sem espaços extra no início ou no fim.
-- Hint: Usa LOWER() e TRIM().

-- ESCREVE O TEU CÓDIGO AQUI:

SELECT 
    LOWER(TRIM(job_title_short))
FROM job_postings_fact;


-- 🧩 Exercício 2: Substituição de Termos (REPLACE)
-- Objetivo: Mostra o 'job_title', mas onde aparecer a palavra 'Senior', 
-- substitui por 'SR.'.
-- Hint: Usa REPLACE(coluna, 'velho', 'novo').

-- ESCREVE O TEU CÓDIGO AQUI:

SELECT
    REPLACE(job_title, 'Senior', 'SR.')
FROM job_postings_fact
LIMIT 100;


-- 🧩 Exercício 3: A Rede de Segurança (COALESCE)
-- Objetivo: Mostra o 'job_title' e o 'salary_year_avg'. 
-- Se o salário for NULL, mostra o valor '0'. 
-- Garante que o resultado é tratado como um número.
-- Hint: COALESCE(coluna, valor_alternativo).

-- ESCREVE O TEU CÓDIGO AQUI:

SELECT
    job_title,
    COALESCE(salary_year_avg, 0)
FROM job_postings_fact
LIMIT 100;


-- 🧩 Exercício 4: Limpeza de Dados "Lixo" (NULLIF + COALESCE)
-- Objetivo: Imagina que algumas vagas têm a localização escrita como 'Unknown'.
-- 1. Usa NULLIF para transformar 'Unknown' em NULL.
-- 2. Depois, usa COALESCE para que, se for NULL, apareça 'Remote'.
-- Hint: COALESCE(NULLIF(job_location, 'Unknown'), 'Remote').

-- ESCREVE O TEU CÓDIGO AQUI:

SELECT
    job_title,
    COALESCE(NULLIF(job_location, 'Unknown'), 'Remote') AS location_cleaned
FROM job_postings_fact
LIMIT 150;

/* -- 🧩 Exercício 5: O Desafio do "Data Janitor" (Nível Pro)
-- Coluna alvo: job_via
-- Funções a usar: LOWER, REPLACE, NULLIF, COALESCE
*/

-- ESCREVE O TEU CÓDIGO AQUI:

SELECT 
    job_title,
    job_via AS original_source,
    -- Constrói aqui a tua mega-função encadeada:
    COALESCE(
    NULLIF(
        REPLACE(LOWER(job_via), 'via ', ''), 
        ''
    ), 
    'other source'
) AS source_clean
FROM job_postings_fact
LIMIT 50;