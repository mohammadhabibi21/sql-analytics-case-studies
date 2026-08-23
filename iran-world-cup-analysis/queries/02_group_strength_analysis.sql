;WITH team_strength AS (
    SELECT
        ta.tournament_id,
        ta.team_id,

        CAST(
            (
                3 * SUM(CAST(ta.win AS INT))
                + SUM(CAST(ta.draw AS INT))
            ) * 1.0
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(10, 4)
        ) AS points_per_match

    FROM team_appearances AS ta

    JOIN matches AS m
        ON ta.match_id = m.match_id
        AND ta.tournament_id = m.tournament_id

    WHERE m.stage_name = 'group stage'

    GROUP BY
        ta.tournament_id,
        ta.team_id
),

group_membership AS (
    SELECT DISTINCT
        m.tournament_id,
        m.group_name,
        ta.team_id

    FROM matches AS m

    JOIN team_appearances AS ta
        ON m.match_id = ta.match_id
        AND m.tournament_id = ta.tournament_id

    WHERE
        m.stage_name = 'group stage'
        AND m.group_name IS NOT NULL
),

group_strength AS (
    SELECT
        gm.tournament_id,
        gm.group_name,

        AVG(ts.points_per_match) AS group_avg_ppm

    FROM group_membership AS gm

    JOIN team_strength AS ts
        ON gm.tournament_id = ts.tournament_id
        AND gm.team_id = ts.team_id

    GROUP BY
        gm.tournament_id,
        gm.group_name
),

iran_groups AS (
    SELECT DISTINCT
        gm.tournament_id,
        gm.group_name

    FROM group_membership AS gm

    JOIN teams AS t
        ON gm.team_id = t.team_id

    WHERE t.team_name = 'Iran'
),

iran_opponents_strength AS (
    SELECT
        ig.tournament_id,
        ig.group_name,

        AVG(ts.points_per_match) AS iran_opponents_avg_ppm

    FROM iran_groups AS ig

    JOIN group_membership AS gm
        ON ig.tournament_id = gm.tournament_id
        AND ig.group_name = gm.group_name

    JOIN teams AS t
        ON gm.team_id = t.team_id

    JOIN team_strength AS ts
        ON gm.tournament_id = ts.tournament_id
        AND gm.team_id = ts.team_id

    WHERE t.team_name <> 'Iran'

    GROUP BY
        ig.tournament_id,
        ig.group_name
)

SELECT
    ios.tournament_id,
    ios.group_name,

    CAST(
        ios.iran_opponents_avg_ppm
        AS DECIMAL(5, 2)
    ) AS iran_opponents_avg_ppm,

    CAST(
        (
            SELECT AVG(gs.group_avg_ppm)
            FROM group_strength AS gs
            WHERE gs.tournament_id = ios.tournament_id
              AND gs.group_name <> ios.group_name
        )
        AS DECIMAL(5, 2)
    ) AS other_groups_avg_ppm,

    CAST(
        ios.iran_opponents_avg_ppm
        -
        (
            SELECT AVG(gs.group_avg_ppm)
            FROM group_strength AS gs
            WHERE gs.tournament_id = ios.tournament_id
              AND gs.group_name <> ios.group_name
        )
        AS DECIMAL(5, 2)
    ) AS strength_gap

FROM iran_opponents_strength AS ios

ORDER BY
    ios.tournament_id;