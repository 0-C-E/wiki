#import "/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time,
  polynomial_time, starting_levels, units_table,
)

= 0 C.E. --- Harbor <harbor>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- All naval units are trained, stored, and managed in the Harbor
  garrison context.
- Land units are managed separately in the
  #link("Barracks.pdf")[Barracks] garrison.
- See #link("#")[Military] for naval unit types and combat
  rules.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 0, 1, 1)],
  kind: table,
)

== Harbor Levels Data <harbor-level-data>
#let max_level = 30

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(1 * calc.pow(l, 1))
#let stone_cost(l) = calc.round(1 * calc.pow(l, 1))
#let metal_cost(l) = calc.round(1 * calc.pow(l, 1))
#let food_cost(l) = (l - 1) * 5
#let pop_cost(l) = l * 4
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 300, growth: 1.082, linear: true),
  late: l => polynomial_time(l, coefficient: 50),
)
#let training_time_reduction = 0.982
#let training_time(l) = calc.round(
  100 * calc.pow(training_time_reduction, (l - 1)),
  digits: 1,
)
#let points(l) = calc.round(66 * calc.pow(l, 0.61))

// ── Units training times ──
#let fire_ship_time(l) = calc.round(
  400 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let bireme_time(l) = calc.round(
  650 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let hemolia_time(l) = calc.round(
  1100 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let trireme_time(l) = calc.round(
  900 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let quadrireme_time(l) = calc.round(
  1050 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let liburnian_time(l) = calc.round(
  750 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let tower_ship_time(l) = calc.round(
  1350 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let cataphract_time(l) = calc.round(
  1450 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let penteconters_time(l) = calc.round(
  1600 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let freighter_time(l) = calc.round(
  550 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let converted_trireme_time(l) = calc.round(
  850 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let invasion_galley_time(l) = calc.round(
  1250 * 40 * calc.pow(training_time_reduction, (l - 1)),
)
#let colony_ship_time(l) = calc.round(
  1550 * 40 * calc.pow(training_time_reduction, (l - 1)),
)

// ── Helper functions ──
#let this_table = (from, to) => {
  building_table(
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
    extra_headers: ([*Units Training Times*],),
    extra: l => ([#training_time(l)%],),
  )
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    units_table(
      from,
      to,
      row: l => (
        [#l],
        [#format_time(fire_ship_time(l))],
        [#format_time(bireme_time(l))],
        [#format_time(hemolia_time(l))],
      ),
      header: table.header([*Level*], [*Fire Ship*], [*Bireme*], [*Hemolia*]),
    ),
    units_table(
      from,
      to,
      row: l => (
        [#l],
        [#format_time(trireme_time(l))],
        [#format_time(quadrireme_time(l))],
        [#format_time(liburnian_time(l))],
      ),
      header: table.header(
        [*Level*],
        [*Trireme*],
        [*Quadrireme*],
        [*Liburnian*],
      ),
    ),

    units_table(
      from,
      to,
      row: l => (
        [#l],
        [#format_time(tower_ship_time(l))],
        [#format_time(cataphract_time(l))],
        [#format_time(penteconters_time(l))],
      ),
      header: table.header(
        [*Level*],
        [*Tower Ship*],
        [*Cataphract*],
        [*Penteconters*],
      ),
    ),
    units_table(
      from,
      to,
      row: l => (
        [#l],
        [#format_time(freighter_time(l))],
        [#format_time(converted_trireme_time(l))],
        [#format_time(invasion_galley_time(l))],
        [#format_time(colony_ship_time(l))],
      ),
      header: table.header(
        [*Level*],
        [*Freighter*],
        [*Converted Trireme*],
        [*Invasion Galley*],
        [*Colony Ship*],
      ),
    ),
  )
}

// ── Tables ──
=== Early game
#this_table(1, 11)

=== Mid game
#this_table(11, 21)

=== Late game
#this_table(21, 31)

=== City tier 2
#this_table(31, 41)

=== City tier 3
#this_table(41, 51)
