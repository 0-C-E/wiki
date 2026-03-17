#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time, polynomial_time, starting_levels,
)

= 0 C.E. --- Farm <farm>
#link("#")[← Buildings & Wonders]

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(1, 3, 5, 10)],
  kind: table,
)

== Farm Levels Data <farm-level-data>
#let max_level = 45

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(24 * calc.pow(l, 1.58))
#let stone_cost(l) = calc.round(18 * calc.pow(l, 1.69))
#let metal_cost(l) = calc.round(5 * calc.pow(l, 1.975))
#let food_cost(l) = (l - 1) * 3
#let pop_cost(l) = 0
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 300, growth: 1.061, linear: true),
  late: l => polynomial_time(l, coefficient: 50),
)
#let production(l) = calc.round(10 * calc.pow(l, 1.1))
#let militia(l) = if l <= max_level { l * 10 } else {
  max_level * 10 + (l - max_level) * 5
}
#let points(l) = calc.round(17 * calc.pow(l, 1.31))

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
  extra_headers: ([*Production per hour*], [*Militia*]),
  extra: l => ([#production(l)], [#militia(l)]),
)

// ── Tables ──
=== Early game
#this_table(1, 16)

=== Mid-game
#this_table(16, 31)

=== Late game
#this_table(31, 46)

=== City tier 2
#this_table(46, 56)

=== City tier 3
#this_table(56, 66)
