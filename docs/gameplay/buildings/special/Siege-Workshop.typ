#import "/docs/utils/formulas.typ": building_table, starting_levels
#import "/docs/utils/constants.typ": (
  special_building_construction_duration, special_building_points,
  special_building_population_cost,
)

= 0 C.E. --- Siege Workshop #emph[(Special)] <siege-workshop-special>
#link("#")[← Buildings & Wonders]

== Purpose <purpose>

Power is power, and sometimes you need to break down a door to assert it. Siege weapons can break through even the most hardened city walls, but building and operating them requires a dedicated facility. The Siege Workshop provides the infrastructure, tools, and trained crews necessary to manufacture and field siege weapons.

Once built, all siege weapon unit types become available to train in the #link("Barracks.pdf")[Barracks] and #link("Siege-Workshop.pdf")[Siege Workshop]. Demolishing the Siege Workshop removes access to siege weapons, disbands any currently queued units and removes any already trained siege units from your garrison.

== Requirements <requirements>

- *Senate* level 21
- *Barracks* level 20
- *Foundry* level 10
- Do not have any other special building already built

#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Property], [Value]),
    table.hline(),
    [#strong[Type];], [Special (non-upgradable)],
    [#strong[Max Level];], [1],
    [#strong[Effects];], [Enables siege weapon training],
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
#let wood_cost(l) = 8000
#let stone_cost(l) = 12000
#let metal_cost(l) = 9000
#let food_cost(l) = 1000
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
