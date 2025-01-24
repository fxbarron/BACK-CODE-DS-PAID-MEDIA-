SELECT 
DISTINCT
    CAMPAIGN,
    BANNER_ADGROUP,
    CAMPAIGN_TYPE,
    MEDIA,

    -- HOMOLOGA CHANNEL
    CASE 
        WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        ELSE CAMPAIGN_TYPE 
    END AS channel,

    -- HOMOLOGA PLACEMENT (Line Item)
    CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END AS PLACEMENT_FUNNEL,

    -- HOMOLOGA CAMPAIGN FUNNEL
  CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
END AS CAMPAIGN_FUNNEL,

    -- CALCULA FUNNEL

    -- STAGE 1
    CASE 
        WHEN REGEXP_CONTAINS(
            
            (     CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BRAND_BOTB_Alkemy|BRAND_FR_Alkemy|BRAND_ER_Alkemy)') 
             AND 
             
             (   CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'AWA' THEN 'TOFU'

    -- STAGE 2 
        WHEN REGEXP_CONTAINS(
            
            (     CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (   CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(Conde Nast|Fodors|Travel and Leisure|Teads|Taboola|TravelPulse)') 
    THEN 'TOFU'

-- STAGE 3

 WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP)') 
             AND 
             
             (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END) = 'PRS' 
    AND REGEXP_CONTAINS(MEDIA, r'(?i)(DV360|TripAdvisor|META|CRITEO)') 
    THEN 'MOFU'

-- STAGE 4
WHEN REGEXP_CONTAINS(
            
            (    CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
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
            
            (     CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(BLACK FRIDAY|AO|TEST|WEDDINGS)') -------
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
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
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(OPENING XCP|BLACK FRIDAY|AO|TEST|WEDDINGS)') -----
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(RTG|SEM BRAND)')
THEN 'BOFU'

-- STAGE 7

    WHEN REGEXP_CONTAINS(
            
            (     CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(NEW YEAR)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
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
            
            (     CASE
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)')  THEN 'OPENING XCP'
 WHEN BANNER_ADGROUP LIKE '%_BF_%' THEN 'BLACK FRIDAY'
 WHEN BANNER_ADGROUP LIKE '%BBDD-NN%' THEN 'NEW YEAR'
 WHEN CAMPAIGN LIKE '%BRAND_FR_Alkemy%' THEN 'BRAND_FR_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_ER_Alkemy%' THEN 'BRAND_ER_Alkemy'
 WHEN CAMPAIGN LIKE '%BRAND_BOTB_Alkemy%' THEN 'BRAND_BOTB_Alkemy'
 WHEN CAMPAIGN LIKE '%WED%' THEN 'WEDDINGS'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(AO)') AND NOT REGEXP_CONTAINS(CAMPAIGN, r'(?i)(XCP)') THEN 'AO'
 WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(TEST)') THEN 'TEST_Alkemy'
  ELSE 'RESTO'
    END)
            , r'(?i)(WEDDINGS)') 
            AND  REGEXP_CONTAINS(
                (  CASE 
        WHEN REGEXP_CONTAINS(CAMPAIGN, r'(?i)(BRAND_BOTB_Alkemy|BRAND_ER_Alkemy|BRAND_FR_Alkemy)') THEN 'AWA'
        -- WHEN BANNER_ADGROUP LIKE '%EMAIL%' THEN 'Email'
        -- WHEN BANNER_ADGROUP LIKE '%VIDEO%' THEN 'Video'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%BRAND%' AND CAMPAIGN_TYPE = 'Google' THEN 'SEM BRAND'
        WHEN CAMPAIGN LIKE '%GEN%' AND CAMPAIGN_TYPE = 'Search' THEN 'SEM GEN'
        ELSE PLACEMENT 
    END )
                
                , r'(?i)(PRS)')
THEN 'MOFU'

        ELSE 'NA'
    END AS FUNNEL

FROM 
    `TEC_EXCELLENCE_ADFORM_CLICS_IMPRESSION.Transform_Adform_Impression`
    
where cast(LEFT(timestamp,10) as date) >= '2024-10-01';
