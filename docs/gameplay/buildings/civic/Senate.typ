#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time,
  polynomial_time, starting_levels,
)

= 0 C.E. --- Senate <senate>
#link("#")[← Buildings & Wonders]

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(1, 2, 5, 10)],
  kind: table,
)

== Senate Levels Data <senate-level-data>
#let max_level = 25

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(25 * calc.pow(l, 1.7))
#let stone_cost(l) = calc.round(12 * calc.pow(l, 2))
#let metal_cost(l) = calc.round(10 * calc.pow(l, 1.8))
#let food_cost(l) = calc.round(7 * calc.pow(l, 1.05))
#let pop_cost(l) = calc.round(3 * calc.pow(l, 1.21))
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 110, growth: 1.157, linear: true),
  late: l => polynomial_time(l, coefficient: 50),
)
#let construction_time(l) = calc.round(
  if l <= max_level { 100 * calc.pow(0.965, (l - 1)) } else {
    -47 + 100 * calc.pow(0.995, l)
  },
  digits: 1,
)
#let points(l) = calc.round(110 * calc.pow(l, 0.75))

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
  extra_headers: ([*Buildings Construction Time*],),
  extra: l => ([#construction_time(l)%],),
)

// ── Tables ──
=== Early game
#this_table(1, 9)

=== Mid-game
#this_table(9, 17)

=== Late game
#this_table(17, 26)

=== City tier 2
#this_table(26, 36)

=== City tier 3
#this_table(36, 46)
