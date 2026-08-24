# Iran World Cup Analysis

T-SQL analysis of Iran's 18 FIFA World Cup matches across six tournaments, using the Fjelstul World Cup Database to explore performance trends, group difficulty, goal timing, comparisons with Asian teams, and statistically defined key matches.

## Project Questions

This case study investigates five analytical questions:

1. How has Iran's World Cup performance changed across tournaments?
2. Were Iran's group-stage opponents generally stronger than teams in other groups?
3. During which 15-minute intervals has Iran been most vulnerable?
4. How does Iran compare with selected Asian World Cup teams?
5. Which matches can be identified as key historical results using statistical criteria?

## Data Source

This project uses data derived from the **Fjelstul World Cup Database**, created by **Joshua C. Fjelstul, Ph.D.**

Source repository:

https://github.com/jfjelstul/worldcup

The database provides relational World Cup data covering tournaments, teams, matches, team appearances, goals, groups, standings, and other match-level and tournament-level information.

Tables used in this analysis include:

- `tournaments`
- `teams`
- `matches`
- `team_appearances`
- `goals`

The SQL Server database used during the original workshop was based on this dataset.

## Analysis 1 — Performance Trend

The first query summarizes Iran's performance by tournament using:

- Goals scored
- Goals conceded
- Goal difference
- Points

### Key Findings

Iran's strongest defensive tournament in the dataset was 2018, when it finished with a goal difference of `0`.

Iran scored its highest number of goals in a single tournament in 2022 with `4` goals.

| Tournament | Goals Scored | Goals Conceded | Goal Difference | Points |
|---|---:|---:|---:|---:|
| 1978 | 2 | 8 | -6 | 1 |
| 1998 | 2 | 4 | -2 | 3 |
| 2006 | 2 | 6 | -4 | 1 |
| 2014 | 1 | 4 | -3 | 1 |
| 2018 | 2 | 2 | 0 | 4 |
| 2022 | 4 | 7 | -3 | 3 |

## Analysis 2 — Group Strength

To evaluate group difficulty, opponent strength is measured using group-stage points per match.

Iran's opponents are compared with the average team strength of the other groups in the same tournament.

A positive `strength_gap` means Iran's opponents performed better than the average of teams in the other groups.

| Tournament | Iran Group | Opponents Avg PPM | Other Groups Avg PPM | Strength Gap |
|---|---|---:|---:|---:|
| 1978 | Group 4 | 1.67 | 1.39 | +0.28 |
| 1998 | Group F | 1.56 | 1.32 | +0.23 |
| 2006 | Group D | 1.67 | 1.39 | +0.27 |
| 2014 | Group F | 1.78 | 1.40 | +0.37 |
| 2018 | Group B | 1.22 | 1.43 | -0.21 |
| 2022 | Group B | 1.44 | 1.40 | +0.04 |

### Interpretation

Iran faced above-average group-stage opposition in five of the six tournaments based on this metric.

The largest positive gap occurred in 2014 at `+0.37`, while 2018 was the only tournament in which Iran's opponents performed below the average of the other groups.

This metric reflects observed performance during the tournament. It should not be interpreted as a direct measure of pre-draw team strength or as proof that Iran was lucky or unlucky in the draw.

## Analysis 3 — Goal Timing

Goals scored and conceded are grouped into 15-minute intervals.

| Time Interval | Goals Scored | Goals Conceded | Goal Difference |
|---|---:|---:|---:|
| 0-15 | 0 | 1 | -1 |
| 16-30 | 0 | 2 | -2 |
| 31-45 | 3 | 9 | -6 |
| 46-60 | 1 | 5 | -4 |
| 61-75 | 2 | 5 | -3 |
| 76-90 | 7 | 9 | -2 |

### Key Finding

The `31-45` minute interval produced Iran's worst goal difference at `-6`, making it the most vulnerable period in the dataset.

Iran was most productive offensively during the final 15 minutes, scoring `7` goals between minutes 76 and 90.

## Analysis 4 — Asian Team Comparison

World Cup performance is compared using relative metrics so that teams with different numbers of matches can be evaluated more fairly.

The analysis includes:

- Win rate
- Points per match
- Goal difference per match
- Points-per-match ranking among teams from the selected Asian regions in the dataset

| Team | Matches | Wins | Points | Win Rate | Points per Match | Goal Difference per Match |
|---|---:|---:|---:|---:|---:|---:|
| Japan | 58 | 22 | 73 | 37.93% | 1.26 | -0.48 |
| South Korea | 48 | 9 | 37 | 18.75% | 0.77 | -1.25 |
| North Korea | 20 | 4 | 15 | 20.00% | 0.75 | -1.15 |
| Iran | 18 | 3 | 13 | 16.67% | 0.72 | -1.00 |

Japan shows the strongest overall performance among these four teams based on points per match, while Iran records `0.72` points per match.

## Analysis 5 — Key Matches

Key matches are identified using explicit statistical criteria rather than subjective historical selection.

A match is classified as a key match when it meets at least one of these conditions:

- Iran won the match.
- Iran drew against an opponent whose historical World Cup points per match was at or above the median strength of Iran's opponents.
- Iran suffered a heavy defeat with a goal difference of `-3` or worse.

The median historical opponent strength in this analysis is `1.51` points per match.

The resulting key-match set contains seven matches.

These classifications are analytical definitions created for this case study and are not intended to represent an official historical ranking of Iran's most important matches.

## SQL Files

- `queries/01_performance_trend.sql` — tournament-level performance trend
- `queries/02_group_strength_analysis.sql` — group-strength comparison
- `queries/03_goal_timing_analysis.sql` — goals by 15-minute interval
- `queries/04_asian_team_comparison.sql` — comparison with selected Asian teams
- `queries/05_key_matches.sql` — statistically defined key matches

## SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Multi-table joins
- Aggregations
- Conditional aggregation
- Subqueries
- Window functions
- `RANK()`
- `PERCENTILE_CONT()`
- `CASE`
- `NULLIF`
- Data-driven thresholds
- Relative performance metrics

## Tools

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)

## Data Attribution

The source data is derived from the **Fjelstul World Cup Database**:

**Joshua C. Fjelstul, Ph.D.**  
© 2023 Joshua C. Fjelstul, Ph.D.

Repository:

https://github.com/jfjelstul/worldcup

The Fjelstul World Cup Database is distributed under the **Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)**.

License:

https://creativecommons.org/licenses/by-sa/4.0/

The database was adapted for use in a SQL Server workshop environment. The analytical queries in this repository were written, reviewed, and documented separately for this portfolio case study.

## Author

**Mohammad Habibi**