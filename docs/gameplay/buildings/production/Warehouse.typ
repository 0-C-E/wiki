#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time,
  polynomial_time, starting_levels,
)

= 0 C.E. --- Warehouse <warehouse>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- Food has its own storage building: the
  #link("Granary.pdf")[Granary];.
- A city can have both a Granary and a Warehouse; they apply to separate
  resource pools.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(1, 3, 5, 10)],
  kind: table,
)

== Warehouse Levels Data <warehouse-level-data>
#let max_level = 35

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(-90 + 100 * calc.pow(l, 1.23))
#let stone_cost(l) = calc.round(-85 + 100 * calc.pow(l, 1.36))
#let metal_cost(l) = calc.round(-96 + 100 * calc.pow(l, 1.27))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = 0
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 100, growth: 1.101, linear: true),
  late: l => polynomial_time(l, coefficient: 101),
)
#let storage(l) = calc.round(300 + 181 * calc.pow(l, 1.42))
#let stash_size(l) = l * 100
#let points(l) = calc.round(7 * calc.pow(l, 1.46))

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
  extra_headers: ([*Storage*], [*Stash size*]),
  extra: l => ([#storage(l)], [#stash_size(l)]),
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
