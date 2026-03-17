#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time, polynomial_time, starting_levels,
)

= 0 C.E. --- Marketplace <marketplace>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- Trade is the primary post-founding source of Gold (see
  #link("/docs/chapters/Economy.typ#62-tile-scan-resource-production")[Economy §6.2];).
- See #link("#")[Diplomacy and Trade] for trade
  route rules.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 0, 1, 2)],
  kind: table,
)

== Marketplace Levels Data <Marketplace-level-data>
#let max_level = 30

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(139 * calc.pow(l, 1.175))
#let stone_cost(l) = calc.round(61 * calc.pow(l, 1.29))
#let metal_cost(l) = calc.round(20 * calc.pow(l, 1.57))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = calc.round(2 * calc.pow(l, 1.1))
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 150, growth: 1.111, linear: true),
  late: l => polynomial_time(l, coefficient: 120),
)
#let trade_capacity(l) = if l <= max_level { l * 500 } else {
  max_level * 500 + (l - max_level) * 350
}
#let points(l) = calc.round(100 + 9 * calc.pow(l, 1.36))

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
  extra_headers: ([*Trade Capacity*],),
  extra: l => ([#trade_capacity(l)],),
)

// ── Tables ──
=== Early game
#this_table(1, 11)

=== Mid-game
#this_table(11, 21)

=== Late game
#this_table(21, 31)

=== City tier 2
#this_table(31, 41)

=== City tier 3
#this_table(41, 51)
