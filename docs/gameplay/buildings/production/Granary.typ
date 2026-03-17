#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time, polynomial_time, starting_levels,
)

= 0 C.E. --- Granary <granary>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- Food uses the Granary storage line; all other resources use the
  #link("Warehouse.pdf")[Warehouse];.
- A city can have both a Granary and a Warehouse; they apply to separate
  resource pools.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(1, 3, 6, 15)],
  kind: table,
)

== Granary Levels Data <granary-level-data>
#let max_level = 35

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(-95 + 100 * calc.pow(l, 1.29))
#let stone_cost(l) = calc.round(-96 + 100 * calc.pow(l, 1.33))
#let metal_cost(l) = calc.round(-99 + 100 * calc.pow(l, 1.27))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = 0
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 120, growth: 1.093, linear: true),
  late: l => polynomial_time(l, coefficient: 100),
)
#let food_storage(l) = calc.round(250 + 80 * calc.pow(l, 1.5))
#let pop_cap(l) = calc.round(50 + 11 * calc.pow(l, 1.625))
#let points(l) = calc.round(17 + 2 * calc.pow(l, 1.355))

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
  extra_headers: ([*Max. Population*], [*Storage*]),
  extra: l => ([#pop_cap(l)], [#food_storage(l)]),
)

// ── Tables ──
=== Early game
#this_table(1, 16)

=== Mid-game
#this_table(16, 26)

=== Late-game
#this_table(26, 36)

=== City tier 2
#this_table(36, 46)

=== City tier 3
#this_table(46, 56)
