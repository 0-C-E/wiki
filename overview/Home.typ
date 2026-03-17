// =============================================================================
// overview/Home.typ — 0 C.E. Wiki Home & Table of Contents
//
// Role:    Master index for the entire GDD / player wiki.
// Audience: Game designers, developers, modders.
// Tone:    Semi-formal, open-source enthusiastic.
//
// PDF links use relative paths from the compiled _site/ root.
// Each entry resolves to its compiled PDF sibling on GitHub Pages.
// =============================================================================

#import "/templates/_preamble.typ": gdd-page

// ── Helpers ──────────────────────────────────────────────────────────────────

// Renders a clickable PDF link styled as a document entry.
// `label` – visible text; `path` – relative URL to the compiled PDF.
#let doc-link(label, path) = link(path)[
  #text(fill: rgb("#e94560"))[#label]
]

// Renders a full section block: coloured left bar + title + entry grid.
#let section(title, accent-color, entries) = {
  // Left-bar rule + section heading
  grid(
    columns: (2pt, 1fr),
    column-gutter: 1em,
    block(
      fill: accent-color,
      width: 4pt,
      height: 1.6em + 1.8em * entries.len(),
    ),
    [
      #text(size: 13pt, weight: "bold", fill: accent-color)[#title]
      #v(1.3em, weak: true)
      #for (lbl, path, desc) in entries [
        #grid(
          columns: (8em, 1fr),
          column-gutter: 2em,
          row-gutter: 0.35em,
          doc-link(lbl, path), text(size: 9.5pt, fill: luma(80))[#desc],
        )
      ]
    ],
  )
  v(1.2em, weak: true)
}

// ── Document ─────────────────────────────────────────────────────────────────

#gdd-page(title: "0 C.E. — Wiki Home")[

  // ── Title block ────────────────────────────────────────────────────────────
  #align(center)[
    #v(1.2em)
    #text(size: 32pt, weight: "bold", fill: rgb("#1a1a2e"))[0 C.E.]
    #v(0.2em, weak: true)
    #text(size: 13pt, fill: luma(90), style: "italic")[
      Year Zero Common Era — Open-Source MMORTS
    ]
    #v(0.6em, weak: true)
    #line(length: 60%, stroke: 0.8pt + rgb("#e94560"))
    #v(0.4em, weak: true)
    #text(size: 10pt, fill: luma(110))[
      Game Design Document & Player Wiki ·
      #link("https://github.com/0-C-E/")[GitHub]
      · License: TBD
    ]
    #v(1.6em)
  ]

  // ── About ──────────────────────────────────────────────────────────────────
  = About This Document

  This wiki is the single source of truth for *0 C.E.* — covering game
  mechanics, systems design, technical architecture, and modding. It serves
  simultaneously as the internal GDD and the public-facing player reference.

  Everything here is open: if you spot an error or want to contribute, open a
  pull request on GitHub. Sections marked as _post-launch_ describe systems
  planned beyond the initial release.

  #v(1.4em)

  // ── Section 1 · Overview ───────────────────────────────────────────────────
  #section(
    "Overview",
    rgb("#e94560"),
    (
      (
        "Changelog",
        "/wiki/overview/Changelog.pdf",
        "History of significant design decisions and revisions.",
      ),
      (
        "Glossary",
        "/wiki/overview/Glossary.pdf",
        "Key terms and abbreviations used throughout the wiki.",
      ),
      (
        "Roadmap",
        "/wiki/overview/Roadmap.pdf",
        "MVP scope, post-launch phases, and milestone tracking.",
      ),
      (
        "Vision",
        "/wiki/overview/Vision.pdf",
        "Design pillars, target audiences, and playstyle philosophy.",
      ),
    ),
  )

  // ── Section 2 · Gameplay ───────────────────────────────────────────────────
  #section(
    "Gameplay — Core",
    rgb("#2a7a4b"),
    (
      (
        "Game Loop",
        "/wiki/gameplay/core/Game-Loop.pdf",
        "Tick system, real-time phases, and session structure.",
      ),
      (
        "Progression",
        "/wiki/gameplay/core/Progression.pdf",
        "Player growth curve, unlock thresholds, and pacing.",
      ),
      (
        "Victory & Prestige",
        "/wiki/gameplay/core/Victory-and-Prestige.pdf",
        "Win conditions, prestige scoring, and end-game.",
      ),
    ),
  )

  #section(
    "Gameplay — Economy",
    rgb("#2a7a4b"),
    (
      (
        "Balancing",
        "/wiki/gameplay/economy/Balancing.pdf",
        "Tuning parameters, formulas, and simulation targets.",
      ),
      (
        "Overview",
        "/wiki/gameplay/economy/Overview.pdf",
        "Economy model, resource loop, and design goals.",
      ),
      (
        "Production Chains",
        "/wiki/gameplay/economy/Production-Chains.pdf",
        "Input/output ratios, chain efficiency, bottlenecks.",
      ),
      (
        "Resources",
        "/wiki/gameplay/economy/Resources.pdf",
        "Food, Wood, Stone, Gold, Population — definitions and caps.",
      ),
      (
        "Trade",
        "/wiki/gameplay/economy/Trade.pdf",
        "Trade routes, Market mechanics, inter-player exchange.",
      ),
    ),
  )

  #section(
    "Gameplay — Buildings",
    rgb("#2a7a4b"),
    (
      (
        "Overview",
        "/wiki/gameplay/buildings/Overview.pdf",
        "Building tiers (1–8), slot rules, and upgrade logic.",
      ),
      // Civic
      (
        "Market Place",
        "/wiki/gameplay/buildings/civic/Marketplace.pdf",
        "Local trade capacity and tax revenue.",
      ),
      (
        "Senate",
        "/wiki/gameplay/buildings/civic/Senate.pdf",
        "Governance, policy slots, and decree costs.",
      ),
      // Culture & Religion
      (
        "Academy",
        "/wiki/gameplay/buildings/culture-religion/Academy.pdf",
        "Research speed and scholar capacity.",
      ),
      (
        "Shrine / Temple",
        "/wiki/gameplay/buildings/culture-religion/Shrine-Temple.pdf",
        "Faith generation and deity favour.",
      ),
      // Military
      (
        "Barracks",
        "/wiki/gameplay/buildings/military/Barracks.pdf",
        "Unit training queues and capacity.",
      ),
      (
        "City Walls",
        "/wiki/gameplay/buildings/military/City-Walls.pdf",
        "Defensive rating, repair, and breach mechanics.",
      ),
      (
        "Harbor",
        "/wiki/gameplay/buildings/civic/Harbor.pdf",
        "Naval trade routes and fleet support.",
      ),
      // Production
      (
        "Farm",
        "/wiki/gameplay/buildings/production/Farm.pdf",
        "Food production, fertility modifiers.",
      ),
      (
        "Foundry",
        "/wiki/gameplay/buildings/production/Foundry.pdf",
        "Metal processing, fuel consumption.",
      ),
      (
        "Granary",
        "/wiki/gameplay/buildings/production/Granary.pdf",
        "Food storage and spoilage mechanics.",
      ),
      (
        "Lumber Camp",
        "/wiki/gameplay/buildings/production/Lumber-Camp.pdf",
        "Wood production and deforestation limits.",
      ),
      (
        "Quarry",
        "/wiki/gameplay/buildings/production/Quarry.pdf",
        "Stone extraction and terrain constraints.",
      ),
      (
        "Warehouse",
        "/wiki/gameplay/buildings/production/Warehouse.pdf",
        "General storage, overflow penalties.",
      ),
      // Special
      (
        "Central Storehouses",
        "/wiki/gameplay/buildings/production/Central-Storehouses.pdf",
        "Alliance-level shared storage.",
      ),
      (
        "Governor's Palace",
        "/wiki/gameplay/buildings/civic/Governors-Palace.pdf",
        "Regional control and administrator assignment.",
      ),
      (
        "Grand Bazaar",
        "/wiki/gameplay/buildings/culture-religion/Grand-Bazaar.pdf",
        "Wonder-class; trade network hub.",
      ),
      (
        "Grand Temple",
        "/wiki/gameplay/buildings/culture-religion/Grand-Temple.pdf",
        "Wonder-class religious building, civ-specific.",
      ),
      (
        "Great Library",
        "/wiki/gameplay/buildings/culture-religion/Great-Library.pdf",
        "Wonder-class; unlocks unique tech branches.",
      ),
      (
        "Guild District",
        "/wiki/gameplay/buildings/civic/Guild-District.pdf",
        "Artisan bonuses and trade-good unlocks.",
      ),
      (
        "Public Baths",
        "/wiki/gameplay/buildings/civic/Public-Baths.pdf",
        "Happiness bonus and disease mitigation.",
      ),
      (
        "Siege Workshop",
        "/wiki/gameplay/buildings/military/Siege-Workshop.pdf",
        "Siege engine construction and deployment.",
      ),
      (
        "Theatre",
        "/wiki/gameplay/buildings/civic/Theatre.pdf",
        "Culture output and unrest reduction.",
      ),
      (
        "Watchtower",
        "/wiki/gameplay/buildings/military/Watchtower.pdf",
        "Visibility radius and early-warning triggers.",
      ),
    ),
  )

  #section(
    "Gameplay — Military",
    rgb("#2a7a4b"),
    (
      (
        "Combat Resolution",
        "/wiki/gameplay/military/Combat-Resolution.pdf",
        "Battle formula, modifiers, and outcome calculation.",
      ),
      (
        "Navy",
        "/wiki/gameplay/military/Navy.pdf",
        "Naval units, sea lanes, and coastal combat.",
      ),
      (
        "Overview",
        "/wiki/gameplay/military/Overview.pdf",
        "Military design philosophy and scope.",
      ),
      (
        "Sieges",
        "/wiki/gameplay/military/Sieges.pdf",
        "Siege phases, wall mechanics, and defender bonuses.",
      ),
      (
        "Unit Types",
        "/wiki/gameplay/military/Unit-Types.pdf",
        "Infantry, cavalry, ranged, siege — stats and counters.",
      ),
    ),
  )

  #section(
    "Gameplay — Research",
    rgb("#2a7a4b"),
    (
      (
        "Overview",
        "/wiki/gameplay/research/Overview.pdf",
        "Research system design and pacing goals.",
      ),
      (
        "Research Mechanics",
        "/wiki/gameplay/research/Research-Mechanics.pdf",
        "Research points, speed modifiers, prerequisites.",
      ),
      (
        "Tech Trees",
        "/wiki/gameplay/research/Tech-Trees.pdf",
        "Full technology trees per civilisation.",
      ),
    ),
  )

  #section(
    "Gameplay — Territory",
    rgb("#2a7a4b"),
    (
      (
        "Fog of War",
        "/wiki/gameplay/territory/Fog-of-War.pdf",
        "Visibility rules, scouting, and intel decay.",
      ),
      (
        "Territory Control",
        "/wiki/gameplay/territory/Territory-Control.pdf",
        "Border expansion, influence, and contested zones.",
      ),
      (
        "Villages",
        "/wiki/gameplay/territory/Villages.pdf",
        "Neutral villages, capture mechanics, and bonuses.",
      ),
      (
        "World Map",
        "/wiki/gameplay/territory/World-Map.pdf",
        "Map generation, tile types, and region structure.",
      ),
    ),
  )

  #section(
    "Gameplay — Social",
    rgb("#2a7a4b"),
    (
      (
        "Alliances",
        "/wiki/gameplay/social/Alliances.pdf",
        "Alliance structure, roles, and shared objectives.",
      ),
      (
        "Diplomacy",
        "/wiki/gameplay/social/Diplomacy.pdf",
        "Diplomatic actions, treaties, and reputation.",
      ),
      (
        "Forums",
        "/wiki/gameplay/social/Forums.pdf",
        "In-game communication, announcements, and councils.",
      ),
    ),
  )

  // ── Section 3 · Civilizations ─────────────────────────────────────────────
  #section(
    "Civilizations",
    rgb("#7a5c2a"),
    (
      (
        "Overview",
        "/wiki/civilizations/Overview.pdf",
        "Shared traits, differentiation axes, and design rules.",
      ),
      (
        "Sumer",
        "/wiki/civilizations/Sumer.pdf",
        "Foundation Builder — construction efficiency, Ziggurat, Anunnaki pantheon.",
      ),
      (
        "Greece",
        "/wiki/civilizations/Greece.pdf",
        "Naval / Trade — Triremes, Hoplites, full Olympian pantheon.",
      ),
      (
        "Egypt",
        "/wiki/civilizations/Egypt.pdf",
        "Hybrid Builder + Divine — capital compounding, Pharaoh mechanics.",
      ),
      (
        "Rome",
        "/wiki/civilizations/Rome.pdf",
        "Administrative Builder — multi-city scaling, Provincial Administration.",
      ),
      (
        "Maya",
        "/wiki/civilizations/Maya.pdf",
        "Divine / Sacrifice — blood offering economy, Sacred Calendar.",
      ),
    ),
  )

  // ── Section 4 · Advanced Systems ──────────────────────────────────────────
  #section(
    "Advanced Systems",
    rgb("#5a2a7a"),
    (
      (
        "Cultural Events",
        "/wiki/advanced/Cultural-Events.pdf",
        "Seasonal events, festivals, and timed bonuses.",
      ),
      (
        "Divine System",
        "/wiki/advanced/Divine-System.pdf",
        "Deity favour, miracles, and religious conflict.",
      ),
      (
        "Espionage",
        "/wiki/advanced/Espionage.pdf",
        "Spy networks, sabotage, counter-intelligence.",
      ),
      (
        "Event System",
        "/wiki/advanced/Event-System.pdf",
        "Engine architecture for scripted and random events.",
      ),
      (
        "Heroes",
        "/wiki/advanced/Heroes.pdf",
        "Hero units, traits, levelling, and narrative hooks.",
      ),
      (
        "Scripting Engine",
        "/wiki/advanced/Scripting-Engine.pdf",
        "Lua/Rhai hooks for events and modding scripts.",
      ),
    ),
  )

  // ── Section 5 · Technical ─────────────────────────────────────────────────
  #section(
    "Technical",
    rgb("#1a5f7a"),
    (
      (
        "API",
        "/wiki/technical/API.pdf",
        "REST endpoints, WebSocket protocol, auth flow.",
      ),
      (
        "Architecture",
        "/wiki/technical/Architecture.pdf",
        "Rust crate layout, Actix-web, async runtime design.",
      ),
      (
        "Contributing",
        "/wiki/technical/Contributing.pdf",
        "PR workflow, code conventions, test requirements.",
      ),
      (
        "Data Models",
        "/wiki/technical/Data-Models.pdf",
        "PostgreSQL schemas, entity relationships, migrations.",
      ),
      (
        "Modding",
        "/wiki/technical/Modding.pdf",
        "Mod format, data overrides, hook points, packaging.",
      ),
      (
        "Performance",
        "/wiki/technical/Performance.pdf",
        "SBC benchmarks, profiling targets, tick optimisation.",
      ),
      (
        "UI / UX",
        "/wiki/technical/UI-UX.pdf",
        "Leaflet.js integration, Canvas/WebGL, design system.",
      ),
    ),
  )

  // ── Footer ─────────────────────────────────────────────────────────────────
  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + luma(200))
  #v(0.4em, weak: true)
  #align(center)[
    #text(size: 8.5pt, fill: luma(140))[
      0 C.E. is an open-source project. Documentation and game content are
      community-maintained. · #link("https://github.com/0-C-E/")[Contribute on GitHub]
    ]
  ]
]
