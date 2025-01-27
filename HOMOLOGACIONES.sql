update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Mixto' where CANAL = 'MIXTO';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Display' where CANAL = 'DISPLAY';
update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set canal = 'Video' where CANAL = 'VIDEO';

update `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Objetivos_dia` set MEDIO = 'META' where MEDIO IN ('FACEBOOK','Facebook');
