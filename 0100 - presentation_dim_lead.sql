--liquibase formatted sql
-- ============================================================================================
--
-- NOTE:
-- ============================================================================================

--changeset kpodkov:presentation_dim_lead logicalFilePath:datamart/ddl/dim context:reporting runAlways:true runOnChange:true
DROP VIEW IF EXISTS datamart.presentation_dim_lead CASCADE;
CREATE OR REPLACE VIEW datamart.presentation_dim_lead
  AS (SELECT lead.id                                  AS "Lead ID",
       lead.dw_lead_type                        AS "Lead Type",
       lead.act                                 AS "Marketing ACT",
       lead.assigned_team                       AS "Lead Assigned Team",
       lead.aud                                 AS "Marketing AUD",
       lead.created_by                          AS "Lead Created By",
       lead.created_during_office_hours         AS "Lead Created During Office Hours",
       lead.distance_to_intital_nearest_partner AS "Distance to Intital Nearest Partner (km/mi)",
       lead.donotcall                           AS "Do Not Call",
       lead.doi_status                          AS "Double Opt-in Status",
       lead.had_phone_hearing_test              AS "Phone Hearing Test?",
       lead.closing_category                    AS "Lead Closing Category",
       lead.country_code_iso3                   AS "Country (Lead)",
       lead.created_date                        AS "Date (Lead Created)",
       lead.lead_score                          AS "Lead Score",
       lead.source                              AS "Lead Source",
       lead.status                              AS "Lead Status",
       lead.number_of_unsuccessful_attempts     AS "Lead Unsuccessful Call Attempts",
       lead.original_lead_id                    AS "Lead ID (Original)",
       lead.owned_by_consultant_id              AS "Lead Owner ID",
       lead.reached_date                        AS "Date (Reached)",
       lead.reason_for_closing                  AS "Lead Reason For Closing",
       lead.sub_publisher                       AS "Marketing Sub Publisher",
       lead.time_to_first_call                  AS "Time to First Call (Minutes)",
       lead.user_device                         AS "Lead User Device",
       lead.age                                 AS "Age",
       lead.tv_campaign                         AS "TV Campaign",
       lead.tv_channel                          AS "TV Channel",
       lead.tv_spot_time                        AS "TV Spot Time",
       lead.tv_est_spoteffects_cost_eur         AS "TV Spoteffects Cost (EUR) (Estimated)",
       lead.tv_est_spoteffects_cost_local       AS "TV Spoteffects Cost (Local) (Estimated)",
       lead.tv_weighted_probability             AS "TV Probability",
       lead.hearing_test_id                     AS "Hearing Test ID",
       lead.lead_url                            AS "Lead URL",
       lead.owner_team_role                     AS "Lead Queue Name",
       lead.t_parameter                         AS "AB-Test T-Parameter",
       lead.lead_score_calculated               AS "Lead Score (Calculated)",
       lead.lead_score_initial                  AS "Lead Score (Initial)",
       lead.isblacklisted                       AS "Lead is blacklisted?",
       lead.result                              AS "Hearing Test Result (Number)",
       lead.hearing_test_result                 AS "Hearing Test Result",
       lead.cosi_basic_type_1                   AS "COSI Basic Type 1",
       lead.cosi_basic_type_2                   AS "COSI Basic Type 2",
       lead.cosi_basic_type_3                   AS "COSI Basic Type 3",
       lead.cosi_basic_subtype_1                AS "COSI Basic Subtype 1",
       lead.cosi_basic_subtype_2                AS "COSI Basic Subtype 2",
       lead.cosi_basic_subtype_3                AS "COSI Basic Subtype 3",
       lead.cosi_basic_remark_1                 AS "COSI Basic Remark 1",
       lead.cosi_basic_remark_2                 AS "COSI Basic Remark 2",
       lead.cosi_basic_remark_3                 AS "COSI Basic Remark 3",
       lead.vorqualifizierung_von               AS "Marketing Promoter",
       lead.recommended_by                      AS "Marketing Promoter Location",
       lead.region                              AS "Lead Region",
       lead.offline_hearing_test_left_500       AS "Offline Hearing Test Left 500",
       lead.offline_hearing_test_left_1000      AS "Offline Hearing Test Left 1000",
       lead.offline_hearing_test_left_2000      AS "Offline Hearing Test Left 2000",
       lead.offline_hearing_test_left_4000      AS "Offline Hearing Test Left 4000",
       lead.offline_hearing_test_right_500      AS "Offline Hearing Test Right 500",
       lead.offline_hearing_test_right_1000     AS "Offline Hearing Test Right 1000",
       lead.offline_hearing_test_right_2000     AS "Offline Hearing Test Right 2000",
       lead.offline_hearing_test_right_4000     AS "Offline Hearing Test Right 4000",
       lead.bswcode__c                           AS "BSW Code",
       lead.hearing_test_with__c                 AS "Hearing Test Device",
       lead.responsiblesubteam__c                AS "Responsible Subteam (Lead)"
FROM datamart.dim_lead lead);

SUM(
                              master_fad."Days to First Appointment (FAD)") OVER (PARTITION BY "Country", "Type" ORDER BY "Date" ASC
                              ROWS BETWEEN 30 PRECEDING AND CURRENT ROW) -
                            SUM(master_fad."Days to First Appointment (FAD)")                    AS "Days to First Appointment (FAD) (Rolling L30D/d)",



WITH src AS (
                                      -- logic duplicated from datamart.fact_partner_status_monthly
                                      WITH max_weekly_date AS (


ALTER TABLE datamart.presentation_dim_lead
  OWNER TO dbmaster;
--rollback DROP VIEW datamart.presentation_dim_lead;
