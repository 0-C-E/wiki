#import "/docs/utils/formulas.typ": (
  building_table, capped_construction_time, format_time, growth_time,
  polynomial_time, starting_levels, units_table,
)

= 0 C.E. --- Barracks <barracks>
#link("#")[← Buildings & Wonders]

== Notes <notes>
- All land units are trained, stored, and managed in the Barracks
  garrison context.
- Naval units are managed separately in the
  #link("Harbor.pdf")[Harbor] garrison.
- Siege weapons require the
  #link("Siege-Workshop.pdf")[Siege Workshop] special building to
  unlock.
- See #link("#")[Military] for unit types and combat rules.

== Starting Levels <starting-levels>
#figure(
  align(center)[#starting_levels(0, 1, 3, 5)],
  kind: table,
)

== Barracks Levels Data <barracks-level-data>
#let max_level = 30

// ── Base values & Functions ──
#let wood_cost(l) = calc.round(70 * calc.pow(l, 1.22))
#let stone_cost(l) = calc.round(20 * calc.pow(l, 1.67))
#let metal_cost(l) = calc.round(40 * calc.pow(l, 1.54))
#let food_cost(l) = (l + 1) * 7
#let pop_cost(l) = calc.round(1.5 * calc.pow(l, 1.13))
#let total_time(l) = capped_construction_time(
  l,
  max_level,
  early: l => growth_time(l, base: 300, growth: 1.055, linear: true),
  late: l => polynomial_time(l, coefficient: 50),
)
#let training_time_reduction = 0.982
#let training_time(l) = calc.round(
  100 * calc.pow(training_time_reduction, (l - 1)),
  digits: 1,
)
#let points(l) = calc.round(33 * calc.pow(l, 1.21))

// ── Units training times ──
#let swordsman_time(l) = calc.round(
  20 * 60 * calc.pow(training_time_reduction, l),
)
#let light_cavalry_time(l) = calc.round(
  55 * 60 * calc.pow(training_time_reduction, l),
)
#let war_chariot_time(l) = calc.round(
  80 * 60 * calc.pow(training_time_reduction, l),
)
#let spearman_time(l) = calc.round(
  18 * 60 * calc.pow(training_time_reduction, l),
)
#let archer_time(l) = calc.round(20 * 60 * calc.pow(training_time_reduction, l))
#let slinger_time(l) = calc.round(
  22 * 60 * calc.pow(training_time_reduction, l),
)
#let heavy_infantry_time(l) = calc.round(
  75 * 60 * calc.pow(training_time_reduction, l),
)
#let pikeman_time(l) = calc.round(
  25 * 60 * calc.pow(training_time_reduction, l),
)
#let peltast_time(l) = calc.round(
  35 * 60 * calc.pow(training_time_reduction, l),
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
  units_table(
    from,
    to,
    row: l => (
      [#l],
      [#format_time(swordsman_time(l))],
      [#format_time(light_cavalry_time(l))],
      [#format_time(war_chariot_time(l))],
      [#format_time(spearman_time(l))],
      [#format_time(archer_time(l))],
      [#format_time(slinger_time(l))],
      [#format_time(heavy_infantry_time(l))],
      [#format_time(pikeman_time(l))],
      [#format_time(peltast_time(l))],
    ),
    header: table.header(
      [*Level*],
      [⚔️],
      [🐎],
      [🐴],
      [↗️],
      [🏹],
      [🪨],
      [🛡️],
      [↗️],
      [🪓],
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
