SELECT
    CASE
        WHEN g.minute_regulation BETWEEN 0 AND 15 THEN '0-15'
        WHEN g.minute_regulation BETWEEN 16 AND 30 THEN '16-30'
        WHEN g.minute_regulation BETWEEN 31 AND 45 THEN '31-45'
        WHEN g.minute_regulation BETWEEN 46 AND 60 THEN '46-60'
        WHEN g.minute_regulation BETWEEN 61 AND 75 THEN '61-75'
        WHEN g.minute_regulation BETWEEN 76 AND 90 THEN '76-90'
        ELSE '+90'
    END AS time_interval,

    SUM(IIF(g.team_id = 'T-38', 1, 0)) AS goals_scored,

    SUM(IIF(g.team_id <> 'T-38', 1, 0)) AS goals_conceded,

    (
        SUM(IIF(g.team_id = 'T-38', 1, 0))
        -
        SUM(IIF(g.team_id <> 'T-38', 1, 0))
    ) AS goal_difference

FROM goals AS g

JOIN team_appearances AS ta
    ON g.tournament_id = ta.tournament_id
    AND g.match_id = ta.match_id

WHERE ta.team_id = 'T-38'

GROUP BY
    CASE
        WHEN g.minute_regulation BETWEEN 0 AND 15 THEN '0-15'
        WHEN g.minute_regulation BETWEEN 16 AND 30 THEN '16-30'
        WHEN g.minute_regulation BETWEEN 31 AND 45 THEN '31-45'
        WHEN g.minute_regulation BETWEEN 46 AND 60 THEN '46-60'
        WHEN g.minute_regulation BETWEEN 61 AND 75 THEN '61-75'
        WHEN g.minute_regulation BETWEEN 76 AND 90 THEN '76-90'
        ELSE '+90'
    END;