// =============================================================================
// gameplay/economy/Resources.typ — 0 C.E. Resource Definitions
//
// Role:    Defines every resource in the game: what it is, how it is
//          obtained, how it is spent, its storage rules, and its scope
//          (per-city vs. account-wide).
// Audience: Game designers, developers, players.
//
// CANON RULE: Storage cap values must stay consistent with
//             /gameplay/buildings/production/Granary.typ (Food),
//             /gameplay/buildings/production/Warehouse.typ (Wood/Stone/Metal),
//             and /gameplay/buildings/culture-religion/Shrine-Temple.typ (Favor).
// =============================================================================

#import "/templates/_preamble.typ": accent, dark, gdd-page, mid

// ── Helpers ───────────────────────────────────────────────────────────────────

#let tag(label, color) = box(
  fill: color.lighten(75%),
  stroke: 0.5pt + color,
  inset: (x: 0.5em, y: 0.2em),
  radius: 2pt,
)[#text(size: 8.5pt, fill: color, weight: "semibold")[#label]]

#let per-city = tag("Per city", rgb("#2a7a4b"))
#let account = tag("Account-wide", rgb("#1a5f7a"))
#let has-cap = tag("Capped", rgb("#7a5c2a"))
#let no-cap = tag("Uncapped", rgb("#5a2a7a"))
#let tbd = tag("TBD", luma(120))

#gdd-page(title: "0 C.E. — Resources")[

  // ── Title block ────────────────────────────────────────────────────────────
  #align(center)[
    #v(1.2em)
    #text(size: 28pt, weight: "bold", fill: dark)[Resources]
    #v(0.3em, weak: true)
    #text(size: 11pt, fill: luma(100), style: "italic")[
      What resources exist, where they come from, and how they are spent.
    ]
    #v(0.5em, weak: true)
    #line(length: 40%, stroke: 0.8pt + accent)
    #v(1.4em)
  ]

  // ── 1. Overview ───────────────────────────────────────────────────────────
  = Overview

  0 C.E. has seven resources. Four are *primary materials* produced
  passively by buildings and consumed by construction, training, and
  research. Two are *strategic resources* scoped at the account level
  and shared across all of a player's cities. One is a *population
  resource* that acts simultaneously as a cap and a consumed quantity.

  #figure(
    table(
      columns: (1fr, 1.2fr, 1fr, 1fr),
      table.header([*Resource*], [*Icon*], [*Scope*], [*Storage*]),
      [Wood], [🪵], per-city, has-cap,
      [Stone], [🪨], per-city, has-cap,
      [Metal], [⛏️], per-city, has-cap,
      [Food], [🌾], per-city, has-cap,
      [Population], [👥], per-city, has-cap,
      [Favor], [✨], tag("Per world", rgb("#1a5f7a")), has-cap,
      [Gold], [💰], account, no-cap,
    ),
    kind: table,
  )

  Resources exist at three distinct scopes:

  - *Per city* --- isolated to the city that produced them. Cannot be
    transferred to another city without trade.
  - *Per world* --- shared across all of a player's cities within a
    single world instance, but independent between worlds. A player
    running two simultaneous worlds has two separate pools.
  - *Account-wide* --- shared across all worlds and all cities on the
    account simultaneously.

  All resources accumulate fully passively --- there is no collection
  action. When a storage cap is reached, production of that resource
  stops until the cap is raised or resources are spent.

  #v(0.6em)

  // ── 2. Primary Materials ──────────────────────────────────────────────────
  = Primary Materials

  Wood, Stone, Metal, and Food are the backbone of city development.
  They are produced per city, stored per city, and spent per city.
  They cannot be transferred between a player's own cities directly
  — redistribution requires trade.

  == Wood 🪵

  Harvested from forests surrounding the city. The primary material
  for construction of most buildings and training of early-tier units.

  *Sources:*
  - Lumber Camp (passive production, modified by terrain)
  - Terrain bonus from forested tiles in the city's scan radius
  - Player-to-player commerce
  - Village tribute requests and village commerce (see §6)
  - Pillaging enemy cities

  *Consumed by:* building construction, unit training, research,
  cultural festivals.

  *Storage:* capped by Warehouse level. Overflow production is lost.

  == Stone 🪨

  Quarried from rocky outcrops and highland terrain. Used heavily in
  defensive structures and mid-to-late tier buildings.

  *Sources:* Quarry, terrain bonus (hills/mountains), commerce,
  village interactions, pillage.

  *Consumed by:* building construction, unit training, research,
  cultural festivals.

  *Storage:* capped by Warehouse level. Overflow production is lost.

  == Metal ⛏️

  Smelted from ore deposits. The scarcest primary material — required
  for military units and advanced buildings. Metal-rich terrain is
  a meaningful founding consideration.

  *Sources:* Foundry, terrain bonus (metal veins), commerce,
  village interactions, pillage.

  *Consumed by:* building construction, unit training, research,
  cultural festivals.

  *Storage:* capped by Warehouse level. Overflow production is lost.

  == Food 🌾

  Grown on farmland surrounding the city. Food sustains population
  growth and is required for most construction queues as a minor cost.

  *Sources:* Farm, terrain bonus (plains/valleys/coastal tiles),
  commerce, village interactions, pillage.

  *Consumed by:* building construction (minor cost per level),
  unit training (minor cost), cultural festivals.

  *Storage:* capped by *Granary* level — separate from the Warehouse.
  A city can hold both a Granary and a Warehouse simultaneously; they
  apply to separate resource pools.

  #v(0.6em)

  // ── 3. Population ─────────────────────────────────────────────────────────
  = Population 👥

  Population is the most constrained resource in the game. It functions
  simultaneously as a *hard cap* and a *reserved quantity*:

  - Every building constructed *reserves* a number of population slots
    for as long as it stands.
  - Every unit trained *reserves* a number of population slots for as
    long as it lives.
  - The total population of a city is fixed by the Granary level
    (which sets the population cap alongside food storage).

  This means a city's population is a finite budget. A player who
  builds densely has less room for a large garrison; a player who
  fields a large army has less room for buildings. This tension is
  central to city planning.

  Population is *restored* when a reservation ends: a building that
  is destroyed frees its reserved slots immediately, and units that
  die in combat return their slots to the city pool.

  #block(
    fill: luma(245),
    stroke: (left: 3pt + accent),
    inset: (x: 1.2em, y: 0.9em),
    radius: (right: 3pt),
  )[
    *Example:* a city at population cap builds a Barracks (reserving
    15 slots) and trains 10 Spearmen (reserving 10 slots). If the
    Barracks is destroyed in a siege, 15 slots are freed immediately.
    If the Spearmen die in battle, 10 more slots are freed --- the
    city can recruit or build again.
  ]

  *Storage cap:* set by Granary level. The Public Baths special
  building adds a flat +10% to the cap.

  #v(0.6em)

  // ── 4. Favor ──────────────────────────────────────────────────────────────
  = Favor ✨

  Favor is the divine resource --- it fuels the powers granted by the
  gods through the Divine System. Unlike primary materials, Favor is
  *per world*: it is pooled across all of a player's cities within a
  single world, but each world the player participates in has its own
  independent Favor reserve.

  *Sources:*
  - Shrine / Temple buildings (passive production, scales with level)
  - Grand Temple special building (multiplies Shrine/Temple output)
  - Civilization-specific bonuses (Sumer, Egypt, Maya, Greece each
    have unique Favor generation mechanics — see their respective
    civilization pages)

  *Consumed by:* activating divine powers (see
  #link("/wiki/advanced/Divine-System.pdf")[Divine System]).

  *Storage cap:* fixed per world configuration. The cap is
  shared across all cities — a player cannot exceed the global Favor
  cap regardless of how many Shrines they own.

  *Scope:* per world. Favor generated in any city within a world
  contributes to the shared pool for that world. A player active in
  two worlds simultaneously has two independent Favor pools. Divine
  powers can be activated from any city within the same world.

  #v(0.6em)

  // ── 5. Gold ───────────────────────────────────────────────────────────────
  = Gold 💰

  Gold is obtained *once*, at city founding, by settling on a map
  location that contains a gold deposit. The amount is fixed by the
  deposit — it cannot be increased after founding. There is no passive
  gold production and no way to acquire additional gold through
  construction or research.

  *Source:* city founding on a gold-bearing tile (one-time grant).

  *Scope:* account-wide. Gold from all founded cities is pooled
  into a single account reserve.

  *Storage:* uncapped. Gold does not overflow and does not decay.

  #block(
    fill: luma(245),
    stroke: (left: 3pt + accent),
    inset: (x: 1.2em, y: 0.9em),
    radius: (right: 3pt),
  )[
    *Status: #tbd* — the exact uses of Gold have not yet been
    defined. Candidates include cosmetic unlocks, account-level
    features, and inter-player premium trade. Gold will never
    purchase combat advantage (see
    #link("/wiki/overview/Vision.pdf")[Vision § Anti-Goals]).
    This page will be updated once the design is settled.
  ]

  #v(0.6em)

  // ── 6. Village Interactions ───────────────────────────────────────────────
  = Village Resource Interactions

  Neutral villages captured by a player are a supplementary source
  of primary materials. They do not produce resources continuously
  like buildings — instead, they support two interaction types:

  #figure(
    table(
      columns: (1.2fr, 2fr),
      table.header([*Interaction*], [*Description*]),
      [*Tribute request*],
      [The player requests a resource payment from a controlled
        village. The village fulfils the request after a cooldown.
        One request per village per cooldown window.],

      [*Village commerce*],
      [The player sends a merchant to trade with a controlled
        village, exchanging one resource type for another at
        village-defined ratios.],
    ),
    kind: table,
  )

  Village interactions are distinct from player-to-player commerce
  and use a separate cooldown system. See
  #link("/wiki/gameplay/territory/Villages.pdf")[Villages] for
  capture mechanics and full interaction rules.

  #v(0.6em)

  // ── 7. Resource Scope Summary ─────────────────────────────────────────────
  = Resource Scope Summary

  #figure(
    table(
      columns: (1fr, 1fr, 1fr, 2fr),
      table.header([*Resource*], [*Scope*], [*Cap*], [*Cap set by*]),
      [Wood], [Per city], [Yes], [Warehouse],
      [Stone], [Per city], [Yes], [Warehouse],
      [Metal], [Per city], [Yes], [Warehouse],
      [Food], [Per city], [Yes], [Granary],
      [Population], [Per city], [Yes], [Granary (+Public Baths)],
      [Favor], [Per world], [Yes], [World configuration],
      [Gold], [Account-wide], [No], [---],
    ),
    kind: table,
  )

  // ── Footer ────────────────────────────────────────────────────────────────
  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + luma(200))
  #v(0.4em, weak: true)
  #align(center)[
    #text(size: 8.5pt, fill: luma(140))[
      #link("/wiki/gameplay/economy/Production-Chains.pdf")[Production Chains →] ·
      #link("/wiki/gameplay/economy/Overview.pdf")[← Economy Overview] ·
      #link("/wiki/overview/Home.pdf")[← Wiki Home]
    ]
  ]
]
