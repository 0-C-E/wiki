#import "/docs/utils/formulas.typ": building_table, starting_levels
#import "/docs/utils/constants.typ": (
  special_building_construction_duration, special_building_points,
  special_building_population_cost,
)

= 0 C.E. --- Public Baths #emph[(Special)] <public-baths-special>
#link("#")[← Buildings & Wonders]

== Purpose <purpose>

Public bathing complexes were a hallmark of advanced urban life in the ancient world. These facilities promoted hygiene, social interaction, and overall public health. Cities that invested in such infrastructure were able to sustain larger and healthier populations.

Public Baths improve the living conditions of your citizens and make it possible for your city to support a greater population.

Once constructed, the Public Baths increase your city's maximum population by 10%, allowing you to sustain a larger workforce and army.

~ Strategic focus: #strong[Population capacity]

== Requirements <requirements>

- *Senate* level 21
- *Granary* level 20
- *Farm* level 10
- *Academy* level 5
- *Harbor* level 1
- Do not have any other special building already built

#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Property], [Value]),
    table.hline(),
    [#strong[Type];], [Special (non-upgradable)],
    [#strong[Max Level];], [1],
    [#strong[Effects];], [+10% population],
  )],
  kind: table,
)

== Starting Levels <starting-levels>

#figure(
  align(center)[#starting_levels(0, 0, 0, 0)],
  kind: table,
)

== Cost <cost>
#let max_level = 1

// ── Base values & Functions ──
#let wood_cost(l) = 9000
#let stone_cost(l) = 7000
#let metal_cost(l) = 8000
#let food_cost(l) = 3000
#let pop_cost(l) = special_building_population_cost
#let total_time(l) = special_building_construction_duration
#let points(l) = special_building_points

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

#this_table(1, 2)
