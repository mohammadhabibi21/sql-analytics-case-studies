;WITH comparison AS (
    SELECT
        t.team_name,

        COUNT(*) AS matches_played,

        SUM(CAST(ta.win AS TINYINT)) AS wins,
        SUM(CAST(ta.lose AS TINYINT)) AS losses,
        SUM(CAST(ta.draw AS TINYINT)) AS draws,

        SUM(ta.goals_for) AS goals_scored,
        SUM(ta.goals_against) AS goals_conceded,
        SUM(ta.goal_differential) AS goal_difference,

        (
            SUM(CAST(ta.win AS TINYINT)) * 3
            +
            SUM(CAST(ta.draw AS TINYINT))
        ) AS points,

        CAST(
            100.0 * SUM(CAST(ta.win AS TINYINT))
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(5, 2)
        ) AS win_rate_pct,

        CAST(
            1.0 * (
                SUM(CAST(ta.win AS TINYINT)) * 3
                +
                SUM(CAST(ta.draw AS TINYINT))
            )
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(5, 2)
        ) AS points_per_match,

        CAST(
            1.0 * SUM(ta.goal_differential)
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(6, 2)
        ) AS goal_difference_per_match

    FROM team_appearances AS ta

    JOIN teams AS t
        ON t.team_id = ta.team_id

    WHERE t.region_name IN (
        'East Asia',
        'Middle East',
        'South East Asia'
    )

    GROUP BY
        t.team_name
),

ranked_asian_teams AS (
    SELECT
        RANK() OVER (
            ORDER BY points_per_match DESC
        ) AS points_per_match_rank,
        *
    FROM comparison
)

SELECT *
FROM ranked_asian_teams

WHERE team_name IN (
    'Japan',
    'South Korea',
    'North Korea',
    'Iran'
)

ORDER BY points_per_match_rank;