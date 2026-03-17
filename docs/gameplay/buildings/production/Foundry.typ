#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time, polynomial_time, starting_levels,
)

= 0 C.E. --- Foundry <foundry>
#link("#")[← Buildings & Wonders]

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 1, 5, 15)],
  kind: table,
)

== Foundry Levels Data <foundry-level-data>
#let max_level = 40

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(19 * calc.pow(l, 1.54))
#let stone_cost(l) = calc.round(4 * calc.pow(l, 1.81))
#let metal_cost(l) = calc.round(14 * calc.pow(l, 1.46))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = calc.round(0.5 * calc.pow(l, 1.44))
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 300, growth: 1.047, linear: true),
  late: l => polynomial_time(l, coefficient: 60),
)
#let production(l) = calc.round(10 * calc.pow(l, 1.1))
#let points(l) = calc.round(10 * calc.pow(l, 1.23))

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
  points: l => points(l),
  extra_headers: ([*Production per hour*],),
  extra: l => ([#production(l)],),
)

// ── Tables ──
=== Early game
#this_table(1, 16)

=== Mid-game
#this_table(16, 31)

=== Late-game
#this_table(31, 41)

=== City tier 2
#this_table(41, 51)

=== City tier 3
#this_table(51, 61)
