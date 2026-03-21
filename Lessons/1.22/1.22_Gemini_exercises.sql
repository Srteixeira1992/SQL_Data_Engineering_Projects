--1

CREATE OR REPLACE TABLE staging.data_analyst_remote AS
SELECT 
    jpf.job_title_short,
    cd.name
FROM
    data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_work_from_home = TRUE;

SELECT * FROM staging.data_analyst_remote;

--2

CREATE OR REPLACE VIEW staging.jobs_with_insurance_view AS
SELECT jpf.* 
FROM staging.job_postings_flat AS jpf
WHERE job_health_insurance = TRUE;

SELECT 
    *
FROM 
    staging.jobs_with_insurance_view;

--3

CREATE TEMPORARY TABLE senior_python_temp AS
SELECT *
FROM 
    staging.job_postings_flat
WHERE job_title LIKE '%Senior%' AND salary_year_avg > 120000;

SELECT * FROM senior_python_temp;

--4
SELECT COUNT(*) FROM staging.job_postings_flat;

DELETE FROM staging.job_postings_flat
WHERE job_location = 'Anywhere' OR job_location IS NULL;

SELECT COUNT(*) FROM staging.job_postings_flat;

--5
TRUNCATE TABLE staging.job_postings_flat;

SELECT COUNT(*) FROM staging.job_postings_flat;

INSERT INTO staging.job_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_posted_date > '2024-06-01';

SELECT COUNT(*) FROM staging.job_postings_flat;

/*
1. CTAS (Create Table As Select)
O que é: Cria uma tabela física permanente com os dados resultantes de uma consulta.

Quando usar: Quando precisas de guardar um "snapshot" (fotografia) dos dados para que outros possam consultar sem sobrecarregar as tabelas originais.

Vantagem: É muito rápida para ler dados, pois estes já estão "mastigados" e gravados no disco.

Cenário ideal: Criar tabelas de "staging" ou relatórios mensais que não mudam.

2. VIEW (Vista)
O que é: Uma tabela virtual. Não guarda dados, guarda apenas a "receita" (o código SQL).

Quando usar: Quando precisas de simplificar consultas complexas (com muitos JOINs) para que pareçam uma tabela simples.

Vantagem: Não ocupa espaço extra em disco e está sempre atualizada. Se os dados na tabela original mudarem, a View mostra a alteração no segundo seguinte.

Cenário ideal: Criar "atalhos" seguros para utilizadores que não sabem fazer JOINs complexos.

3. TEMP TABLE (Tabela Temporária)
O que é: Uma tabela física que existe apenas durante a tua sessão atual. Quando fechas o programa, ela desaparece.

Quando usar: Quando estás a realizar cálculos em várias etapas e precisas de guardar resultados intermédios sem "sujar" a base de dados principal.

Vantagem: É privada (outros utilizadores não a vêem) e permite fazer testes rápidos sem compromisso.

Cenário ideal: Limpeza de dados complexa ou preparativos para um cálculo final.

Resumo Comparativo
Dica de Ouro: Se os dados são gigantes e mudam pouco, usa CTAS. Se os dados mudam a toda a hora e queres simplicidade, usa uma VIEW. Se estás apenas a "brincar" com os dados para chegar a um resultado, usa TEMP TABLE.
*/