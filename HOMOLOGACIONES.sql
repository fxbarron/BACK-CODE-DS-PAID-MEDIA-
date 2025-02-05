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


update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set  CANAL = 'Mixto' where MEDIO IN ('MICROSOFTPMAX');
  


  
  
  
  
  update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Mixto' where CANAL = 'MIXTO' and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Display' where CANAL = 'DISPLAY' and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Video' where CANAL = 'VIDEO' and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set MEDIO = 'META' where MEDIO IN ('FACEBOOK','Facebook') and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Search' where CANAL = 'SEARCH' and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Search' where REGEXP_CONTAINS(CANAL, r'(?i)(MICROSOFT|GOOGLE)') and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Display' where REGEXP_CONTAINS(CANAL, r'(?i)(RTB)') and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'TOFU'
WHERE FUNNEL = 'MOFU' AND CANAL = 'Display' and CAMPANIA = 'WEDDINGS' AND MEDIO = 'Bride Click' and origen IN ('OBJETIVO DIARIO');
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'TOFU'
WHERE FUNNEL = 'MOFU' AND CANAL = 'Display' and CAMPANIA = 'WEDDINGS' AND MEDIO = 'PINTEREST' AND  ORIGEN = 'OBJETIVO DIARIO';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set FUNNEL = 'BOFU' where MEDIO IN ('MICROSOFTPMAX') AND
FECHA >= '2025-02-01' AND  ORIGEN = 'OBJETIVO DIARIO';
