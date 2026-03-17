#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time, polynomial_time, starting_levels,
)

= 0 C.E. --- Shrine / Temple <shrine--temple>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- Favor is consumed by the Divine System (see
  #link("#")[Divine System];).
- The #link("Divine-Statue.pdf")[Divine Statue] special building
  multiplies the output of this building.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 0, 1, 3)],
  kind: table,
)

== Shrine / Temple Levels Data <shrine-temple-level-data>
#let max_level = 30

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(30 * calc.pow(l, 1.69))
#let stone_cost(l) = calc.round(40 * calc.pow(l, 1.63))
#let metal_cost(l) = calc.round(35 * calc.pow(l, 1.65))
#let food_cost(l) = l * 7
#let pop_cost(l) = l * 5
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 830, growth: 1.195),
  late: l => polynomial_time(l, coefficient: 250, exponent: 1.92),
)
#let points(l) = calc.round(216 * calc.pow(l, 0.67))

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
