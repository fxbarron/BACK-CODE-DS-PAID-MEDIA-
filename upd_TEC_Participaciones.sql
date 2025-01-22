# Despende de `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Stg_P2C_Part`

INSERT INTO `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Participaciones`
SELECT FECHA_CONVERSION as Fecha,Funnel,CAMPAIGN_FUNNEL AS Campaign,Canal,Medio,count(distinct P2C_ID_DL) AS Paticipaciones FROM
`primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Stg_P2C_Part` where FUNNEL <> 'NA'
GROUP BY 1,2,3,4,5 ORDER BY FECHA_CONVERSION ASC;
