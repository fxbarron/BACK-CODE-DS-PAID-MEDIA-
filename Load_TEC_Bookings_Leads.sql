-- TRUNCATE TABLE  `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Bookings_Leads`;

-- select * from `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Bookings_Leads`;


-- INSERT INTO `primal-sunup-357522.TEC_LAYOUT_OBJETIVOS.TEC_Bookings_Leads`

select Fecha, Campaign_funnel,Funnel,Campania,Canal, Medio,sum(bookings) as Bookings, Sum(revenue) as Revenue, sum(leads)as Leads

from

(

select cast(timestamp as date) as Fecha,

    -- HOMOLOGA CAMPAIGN FUNNEL
  CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
END AS CAMPAIGN_FUNNEL,
  
    -- CALCULA FUNNEL

    -- STAGE 1
    CASE 
        WHEN REGEXP_CONTAINS(
            
            (       CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BRAND_BOTB_Alkemy|BRAND_FR_Alkemy|BRAND_ER_Alkemy|BRAND_TEC_Alkemy)') 
             AND 
             
             (   CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'AWA' THEN 'TOFU'

    -- STAGE 2 
        WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(Conde Nast|Fodors|Travel and Leisure|Teads|Taboola|TravelPulse)') 
    THEN 'TOFU'

-- STAGE 3

 WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(DV360|TripAdvisor|META|CRITEO)') 
    THEN 'MOFU'

-- STAGE 4
WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(AO)') 
          
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(PMAX)') 
    THEN 'BOFU'

-- STAGE 5 
        WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BLACK FRIDAY|AO|TEST|WEDDINGS)') -------
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(PRS|SEM GEN)')
THEN 'MOFU'

--STAGE 6

      WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP|BLACK FRIDAY|AO|TEST|WEDDINGS)') -----
            AND  REGEXP_CONTAINS(
                ( CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(RTG|SEM BRAND)')
THEN 'BOFU'

-- STAGE 7

    WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(NEW YEAR)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(RTG|SEM BRAND)')
THEN 'BOFU'

-- STAGE 8

WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(WEDDINGS)') 
          
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(Google AdWords)') 
    THEN 'BOFU'

-- STAGE 9

  WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(WEDDINGS)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(PRS)')
THEN 'MOFU'

        ELSE 'NA'
    END AS FUNNEL,


 CAMPAIGN AS Campania, 
 
  -- HOMOLOGA CHANNEL
    CASE 
        WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        ELSE CAMPAIGN_TYPE 
    END AS  Canal,
 
  MEDIA as Medio, count(*) as Bookings, sum(SALES) as Revenue, 0 as Leads  from  `primal-sunup-357522.TEC_EXCELLENCE_ADFORM_CONVERSION.Transform_Adform_Conversion_Data`
where CAST(TIMESTAMP AS DATE) >= '2024-10-01'
group by 1,2,3,4,5,6

union all

select FECHA as Fecha,

    -- HOMOLOGA CAMPAIGN FUNNEL
  CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
END AS CAMPAIGN_FUNNEL,

    -- CALCULA FUNNEL

    -- STAGE 1
    CASE 
        WHEN REGEXP_CONTAINS(
            
            (       CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BRAND_BOTB_Alkemy|BRAND_FR_Alkemy|BRAND_ER_Alkemy|BRAND_TEC_Alkemy)') 
             AND 
             
             (   CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'AWA' THEN 'TOFU'

    -- STAGE 2 
        WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(Conde Nast|Fodors|Travel and Leisure|Teads|Taboola|TravelPulse)') 
    THEN 'TOFU'

-- STAGE 3

 WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(DV360|TripAdvisor|META|CRITEO)') 
    THEN 'MOFU'

-- STAGE 4
WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(AO)') 
          
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(PMAX)') 
    THEN 'BOFU'

-- STAGE 5 
        WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BLACK FRIDAY|AO|TEST|WEDDINGS)') -------
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(PRS|SEM GEN)')
THEN 'MOFU'

--STAGE 6

      WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP|BLACK FRIDAY|AO|TEST|WEDDINGS)') -----
            AND  REGEXP_CONTAINS(
                ( CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(RTG|SEM BRAND)')
THEN 'BOFU'

-- STAGE 7

    WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(NEW YEAR)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(RTG|SEM BRAND)')
THEN 'BOFU'

-- STAGE 8

WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(WEDDINGS)') 
          
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(Google AdWords)') 
    THEN 'BOFU'

-- STAGE 9

  WHEN REGEXP_CONTAINS(
            
            (   CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE 'BRAND_TEC_Alkemy%' THEN 'BRAND_TEC_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(WEDDINGS)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy|BRAND_TEC_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(SEARCH)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(MICROSOFT)') THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GENERICO%' AND REGEXP_CONTAINS(CAMPAIGN_TYPE, r'(?i)(GOOGLE|MICROSOFT)') THEN 'SEM GEN'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(PRS)')
THEN 'MOFU'

        ELSE 'NA'
    END AS FUNNEL,
 
 
 CAMPAIGN AS Campania, 

  -- HOMOLOGA CHANNEL
    CASE 
        WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        ELSE CAMPAIGN_TYPE 
    END AS  Canal, 
 
 MEDIA as Medio, 0 as Bookings, 0 as Revenue, count(*) as Leads  from  `primal-sunup-357522.TEC_EXCELLENCE_ADFORM_CONVERSION.Transform_Adform_Leads_Weddings`
where CAST(FECHA AS DATE) >= '2024-10-01'
group by 1,2,3,4,5,6)

group by 1,2,3,4,5,6 order by 1,2,3,4,5,6 asc
