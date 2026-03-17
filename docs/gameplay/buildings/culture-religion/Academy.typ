#import "/docs/utils/formulas.typ": (
  building_table, format_time, growth_time, starting_levels,
)

= 0 C.E. --- Academy <academy>
#link("#")[← Buildings & Wonders]

// TODO: Determine the actual academy level cap and adjust the data accordingly. The current cap of 35 is based on Grepolis, but may not be accurate for this game.

== Notes <notes>
- The Academy has a #strong[hard cap of 35] --- city tier bonuses do not
  raise this cap further #strong[yet].
- See #link("#")[Research] for the full technology tree and
  research mechanics.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 0, 3, 7)],
  kind: table,
)

== Academy Levels Data <academy-level-data>
#let max_level = 35

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(100 * calc.pow(l, 1.21))
#let stone_cost(l) = calc.round(100 + 100 * calc.pow(l, 1.37))
#let metal_cost(l) = calc.round(20 + 100 * calc.pow(l, 1.27))
#let food_cost(l) = l * 5
#let pop_cost(l) = l * 3
#let total_time(l) = calc.round(growth_time(
  l,
  base: 250,
  growth: 1.08,
  linear: true,
))
#let research_points(l) = l * 4
#let points(l) = calc.round(67 * calc.pow(l, 1.1))

// ── Helper functions ──
#let this_table = (from, to) => building_table(
  from,
  to,
  costs: l => (
    wood_cost(l),
    stone_cost(l),
    metal_cost(l),
    food_cost(l),
    pop_cost(l),
  ),
  time: total_time,
  points: points,
  extra_headers: ([📚],),
  extra: l => ([#research_points(l) (+4)],),
)

// ── Tables ──
=== Early game
#this_table(1, 13)

=== Mid game
#this_table(13, 25)

=== Late game
#this_table(25, 36)
