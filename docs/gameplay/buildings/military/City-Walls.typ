#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time,
  polynomial_time, starting_levels,
)

= 0 C.E. --- City Walls <city-walls>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- The #link("Watchtower.pdf")[Watchtower] special building further
  multiplies `defense_mult`.
- Wall HP is a passive layer; walls must be breached before the city
  itself can be attacked at full strength.
- See #link("#")[Military] for siege and assault mechanics.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 1, 3, 7)],
  kind: table,
)

== City Walls Levels Data <city-walls-level-data>
#let max_level = 25

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(
  if l <= max_level - 5 { 400 } else { 50 * calc.pow((l - 13), 1.01) },
)
#let stone_cost(l) = calc.round(350 * calc.pow(l, 1.05))
#let metal_cost(l) = calc.round(242 * calc.pow(l, 1.04))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = calc.round(2.9 * calc.pow(l, 1.05))
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 200, growth: 1.103, linear: true),
  late: l => polynomial_time(l, coefficient: 100),
)
#let defense_bonus(l) = calc.round(2.95 * calc.pow(l, 1.2), digits: 1)
#let base_defense(l) = (l + 1) * 10
#let points(l) = calc.round(7 + 1.8 * calc.pow(l, 1.75))

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
  extra_headers: ([*Defense Bonus*], [*Base Defense*]),
  extra: l => ([#defense_bonus(l)%], [#base_defense(l)]),
)

// ── Tables ──
=== Early game
#this_table(1, 9)

=== Mid-game
#this_table(9, 17)

=== Late-game
#this_table(17, 26)

=== City tier 2
#this_table(26, 36)

=== City tier 3
#this_table(36, 46)
