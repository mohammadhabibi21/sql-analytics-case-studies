SELECT
    t.year,
    SUM(ta.goals_for) AS goals_scored,
    SUM(ta.goals_against) AS goals_conceded,
    SUM(ta.goal_differential) AS goal_difference,

    SUM(
        CASE
            WHEN ta.win = 1 THEN 3
            WHEN ta.draw = 1 THEN 1
            ELSE 0
        END
    ) AS points

FROM team_appearances AS ta

JOIN tournaments AS t
    ON ta.tournament_id = t.tournament_id

JOIN teams AS tm
    ON tm.team_id = ta.team_id

WHERE tm.team_name = 'Iran'

GROUP BY
    t.year

ORDER BY
    t.year;