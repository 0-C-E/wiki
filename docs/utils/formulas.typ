// ── General formulas ──
#let format_time(time) = {
  let h = calc.floor(time / 3600)
  let m = calc.floor(calc.rem(time, 3600) / 60)
  let s = calc.floor(calc.rem(time, 60))
  let pad(n) = if n < 10 { "0" + str(n) } else { str(n) }
  pad(h) + ":" + pad(m) + ":" + pad(s)
}

#let growth_time(l, base: none, growth: none, linear: false) = (
  base * (if linear { l } else { 1 }) * calc.pow(growth, l)
)

#let polynomial_time(l, coefficient: none, exponent: 2) = (
  coefficient * calc.pow(l, exponent)
)

#let capped_construction_time(
  l,
  max_level,
  early: none,
  late: none,
) = calc.round(
  if l <= max_level { early(l) } else { late(l) },
)

#let construction_duration_curve(
  l,
  base: 2,
  growth: 1.4983,
  level_offset: 1,
) = calc.round(
  base * calc.pow(growth, l - level_offset),
)

// ── Building-specific formulas ──
#let starting_levels(full_world, campaign, skirmish, game_night) = table(
  columns: 2,
  align: (auto, auto),
  table.header([Mode], [Starting Level]),
  table.hline(),
  [Full World], [#full_world],
  [Campaign], [#campaign],
  [Skirmish], [#skirmish],
  [Game Night], [#game_night],
)

#let building_header(extra: ()) = table.header(
  [*Level*],
  [🪵],
  [🪨],
  [⛏️],
  [🌾],
  [👥],
  [⏱️],
  ..extra,
  [*Points*],
)

#let building_row(l, costs: none, time: none, points: none, extra: l => ()) = {
  let (wood, stone, metal, food, pop) = costs(l)
  (
    [#l],
    [#wood],
    [#stone],
    [#metal],
    [#food],
    [#pop],
    [#format_time(time(l))],
    ..extra(l),
    [#points(l)],
  )
}

#let building_table(
  from,
  to,
  costs: none,
  time: none,
  points: none,
  extra_headers: (),
  extra: l => (),
) = figure(
  align(center)[#table(
    columns: building_row(
      1,
      costs: costs,
      time: time,
      points: points,
      extra: extra,
    ).len(),
    align: (center,)
      * building_row(
        1,
        costs: costs,
        time: time,
        points: points,
        extra: extra,
      ).len(),
    building_header(extra: extra_headers),
    table.hline(),
    ..for l in range(from, to) {
      building_row(l, costs: costs, time: time, points: points, extra: extra)
    },
  )],
  kind: table,
)

#let units_table(from, to, row: none, header: none) = figure(
  align(center)[#table(
    columns: row(1).len(),
    align: (center,) * row(1).len(),
    header,
    table.hline(),
    ..for l in range(from, to) { row(l) },
  )],
  kind: table,
)
