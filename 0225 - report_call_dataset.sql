--liquibase formatted sql
-- =============================================================================
--
-- Materialized View: datamart.report_call_dataset
--
-- Dimension Grain: Call ID, Date (Day)
--
-- Description: Contains call data which is not true
-- This is shit. Fucking piece does not work.
-- another shit comment fuck wtf WTF
-- interesting wtf
--
-- ========================
-- |- Editing Guidelines -|
-- ------------------------
-- ○ Front-end names in "Camel Case"
-- ○ Always use datamart.presentation_xxx views for major dimensions
-- ○ Organize data in CTEs if needed
-- ○ Keep CTEs simple and lean (they are not indexed!)
-- =============================================================================

--changeset cblanco:datamart.report_call_dataset runOnChange:true runAlways:true logicalFilePath:reports context:reporting
DROP MATERIALIZED VIEW IF EXISTS datamart.report_call_dataset CASCADE;
CREATE MATERIALIZED VIEW datamart.report_call_dataset
  AS  (SELECT                    call.start                                           AS "Time (Call Start)",
                                 call.call_id                                         AS "Call ID",
                                 o."Opportunity ID"                                   AS "Opportunity ID",
                                 l."Lead ID"                                          AS "Lead ID",
                                 call.partner_id                                      AS "Partner ID",
                                 call.talk_time_seconds                               AS "Consultant Talk Time",
                                 call.ring_time_seconds                               AS "Consultant Ring Duration (NVM)",
                                 call.call_direction                                  AS "Call Direction",
                                 call.consultant_id                                   AS "Consultant ID",
                                 call.is_mobile                                       AS "Is Call Mobile?",
                                 call.call_provider                                   AS "Call Provider",
                                 call.lead_attempt                                    AS "Lead Call Attempts",
                                 call.last_interaction                                AS "Last Interaction?",
                                 call.multiple_consultants_on_the_call                AS "Multiple agents?",
                                 call.call_type                                       AS "Call Type",
                                 l."Date (Lead Created)",
                                 l."Date (Reached)",
                                 l."Lead Status",
                                 l."Lead Type",
                                 o."Date (Opportunity Created)",
                                 c."Consultant Name"                                  AS "Consultant",
                                 c."Consultant Active?",
                                 c."Consultant Date (Exit)"                           AS "Consultant Exit Date",
                                 c."Consultant Date (Start)"                          AS "Consultant Start Date",
                                 c."Consultant Team Lead",
                                 c."Consultant Team"                                  AS "Team",
                                 c."Consultant Sub-Team"                              AS "Sub-Team",
                                 c."Consultant Hearo?"                                AS "Consultant Hearo?",
                                 COALESCE(C."Consultant Country", l."Country (Lead)") AS "Country"
                          FROM datamart.fact_consultant_call call
                                 INNER JOIN datamart.presentation_dim_consultant c
                                   ON call.consultant_id = c."Consultant ID"
                                 LEFT JOIN datamart.presentation_dim_lead l ON call.lead_id = l."Lead ID"
                                 LEFT JOIN datamart.presentation_dim_opportunity o
                                   ON call.opportunity_id = o."Opportunity ID")
--rollback DROP MATERIALIZED VIEW datamart.report_call_dataset;