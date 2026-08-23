;WITH opponent_strength AS (
    SELECT
        ta.team_id,
        CAST(
            (
                3 * SUM(CAST(ta.win AS INT))
                + SUM(CAST(ta.draw AS INT))
            ) * 1.0 / COUNT(*)
            AS DECIMAL(5, 2)
        ) AS opponent_world_cup_ppm

    FROM team_appearances AS ta

    GROUP BY
        ta.team_id
),

iran_matches AS (
    SELECT
        ta_iran.tournament_id,
        t_opp.team_name AS opponent_team_name,
        m.stage_name,

        ta_iran.goals_for,
        ta_iran.goals_against,
        ta_iran.goal_differential,
        ta_iran.result,

        os.opponent_world_cup_ppm

    FROM team_appearances AS ta_iran

    JOIN matches AS m
        ON ta_iran.match_id = m.match_id
        AND ta_iran.tournament_id = m.tournament_id

    JOIN teams AS t_iran
        ON ta_iran.team_id = t_iran.team_id

    JOIN team_appearances AS ta_opp
        ON ta_iran.match_id = ta_opp.match_id
        AND ta_iran.tournament_id = ta_opp.tournament_id
        AND ta_iran.team_id <> ta_opp.team_id

    JOIN teams AS t_opp
        ON ta_opp.team_id = t_opp.team_id

    JOIN opponent_strength AS os
        ON ta_opp.team_id = os.team_id

    WHERE t_iran.team_name = 'Iran'
),

match_threshold AS (
    SELECT
        *,
        PERCENTILE_CONT(0.5)
            WITHIN GROUP (ORDER BY opponent_world_cup_ppm)
            OVER () AS median_opponent_ppm

    FROM iran_matches
)

SELECT
    tournament_id,
    opponent_team_name,
    stage_name,
    goals_for,
    goals_against,
    goal_differential,
    result,
    opponent_world_cup_ppm,

    CAST(median_opponent_ppm AS DECIMAL(5, 2))
        AS median_opponent_ppm,

    CASE
        WHEN result = 'win'
            THEN 'Win'

        WHEN result = 'draw'
             AND opponent_world_cup_ppm >= median_opponent_ppm
            THEN 'Draw vs strong opponent'

        WHEN goal_differential <= -3
            THEN 'Heavy defeat'

    END AS key_match_type

FROM match_threshold

WHERE
       result = 'win'
    OR (
        result = 'draw'
        AND opponent_world_cup_ppm >= median_opponent_ppm
    )
    OR goal_differential <= -3

ORDER BY
    tournament_id,
    opponent_team_name;