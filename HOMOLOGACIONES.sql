update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Mixto' where CANAL = 'MIXTO';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Display' where CANAL = 'DISPLAY';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Video' where CANAL = 'VIDEO';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set MEDIO = 'META' where MEDIO IN ('FACEBOOK','Facebook');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Search' where CANAL = 'SEARCH';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Search' where REGEXP_CONTAINS(CANAL, r'(?i)(MICROSOFT|GOOGLE)');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Display' where REGEXP_CONTAINS(CANAL, r'(?i)(RTB)');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'TOFU'
WHERE FUNNEL = 'MOFU' AND CANAL = 'Display' and CAMPANIA = 'WEDDINGS' AND MEDIO = 'Bride Click';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'TOFU'
WHERE FUNNEL = 'MOFU' AND CANAL = 'Display' and CAMPANIA = 'WEDDINGS' AND MEDIO = 'PINTEREST';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'BOFU' where MEDIO IN ('MICROSOFTPMAX') AND
FECHA >= '2025-02-01';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'BOFU', CANAL = 'Mixto',CAMPANIA = 'AO' where MEDIO IN ('MICROSOFTPMAX') AND
FECHA >= '2025-02-01';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set  CANAL = 'Social Media' WHERE MEDIO = 'META' AND CAMPANIA = 'BLACK FRIDAY' AND canal = 'Display';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set  CANAL = 'Mixto'where medio = 'PMAX' AND CANAL = 'Display';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia`  set campania = 'AO' WHERE CAMPANIA = 'OPENING XCP' AND fecha >= '2025-03-01';
