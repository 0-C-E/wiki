// =============================================================================
// docs/overview/Vision.typ — 0 C.E. Vision & Design Pillars
//
// Role:    Foundational design document. Establishes what 0 C.E. is,
//          who it is for, what it refuses to be, and why it exists.
// Audience: Game designers, developers, modders, contributors.
// Tone:    Semi-formal, open-source enthusiastic.
//
// CANON RULE: Nothing in this file may be changed without a corresponding
// decision recorded in docs/overview/Changelog.typ.
// =============================================================================

#import "/docs/templates/_preamble.typ": accent, dark, gdd-page, mid

#gdd-page(title: "0 C.E. — Vision & Design Pillars")[

  // ── Title block ────────────────────────────────────────────────────────────
  #align(center)[
    #v(1.2em)
    #text(size: 28pt, weight: "bold", fill: dark)[Vision & Design Pillars]
    #v(0.3em, weak: true)
    #text(size: 11pt, fill: luma(100), style: "italic")[
      What 0 C.E. is, who it is for, and what it will never become.
    ]
    #v(0.5em, weak: true)
    #line(length: 40%, stroke: 0.8pt + accent)
    #v(1.4em)
  ]

  // ── 1. Elevator Pitch ──────────────────────────────────────────────────────
  = What Is 0 C.E.?

  *0 C.E.* is an open-source, browser-based MMORTS set in the ancient
  world — a persistent multiplayer game where players build cities,
  command armies, forge alliances, and compete for dominance across a
  shared living world. Every player chooses their own path: the depth is
  always there for those who seek it, and never in the way of those who
  don't.

  #block(
    fill: luma(245),
    stroke: (left: 3pt + accent),
    inset: (x: 1.2em, y: 0.9em),
    radius: (right: 3pt),
  )[
    #text(size: 13pt, style: "italic", fill: dark)[
      "Your empire, your rules --- from one city to a hundred."
    ]
  ]

  #v(0.6em)

  // ── 2. Design Pillars ──────────────────────────────────────────────────────
  = Design Pillars

  These four pillars are non-negotiable. Every feature, system, and
  design decision must be evaluated against them. A feature that
  violates a pillar requires explicit justification and community
  discussion before it can be considered.

  #v(0.5em)

  == Pillar 1 — Strategic Depth

  0 C.E. rewards mastery. Every system — economy, military, diplomacy,
  research — has a visible surface and a deeper layer beneath it. A
  casual player can engage with the surface and enjoy the game. A
  dedicated optimizer can dive into the underlying formulas, spreadsheet
  production chains, and build-order sequencing to extract compounding
  advantages. Both experiences are valid and intentionally supported.

  The skill ceiling is the only balance lever between player types. The
  game never telegraphs difficulty ratings or caps the depth a player
  can reach.

  == Pillar 2 — Historical Grounding

  Every civilization, building, unit, and mechanic draws from real
  history. Names, archetypes, and identities are historically inspired —
  Sumerian ziggurats generate faith and knowledge simultaneously because
  that is what they historically did; Egyptian capital mechanics reflect
  the existential dependence of Egyptian civilization on its sacred
  capital cities.

  Where history and fun diverge, fun wins — but the departure is always
  a conscious design decision, not ignorance of the source material.
  Invented content is never presented as historical fact.

  == Pillar 3 — Open-Source Community

  0 C.E. is built in the open, for the community. The codebase,
  game data, and this documentation are all public. Modders can add new
  civilizations, buildings, and units by editing data files — no engine
  code required. Contributors follow clear conventions and are treated
  as collaborators, not users.

  Design decisions of consequence are documented in the Changelog so
  that anyone joining the project can understand not just _what_ was
  decided, but _why_.

  == Pillar 4 — Self-Hostable by Anyone

  0 C.E. runs on a 50 USD single-board computer. No cloud account, no
  monthly subscription, no vendor lock-in. A community, a school, or an
  individual can spin up their own world on commodity hardware with a
  single `docker compose up`. Sovereignty over your game server is a
  design requirement, not an afterthought.

  #v(0.6em)

  // ── 3. Target Audiences ───────────────────────────────────────────────────
  = Target Audiences

  0 C.E. is designed for four distinct player types. The game does not
  force a choice between them — the same world accommodates all four
  simultaneously.

  #figure(
    table(
      columns: (1fr, 2.2fr, 2.2fr),
      table.header(
        [*Audience*], [*What they want*], [*How 0 C.E. serves them*]
      ),
      [Spreadsheet Optimizer],
      [Exact formulas, min-maxable systems, deep build orders],
      [All formulas are documented and deterministic; production chains
        are designed to reward calculation],

      [Casual City-Builder],
      [Relaxed progression, no punishing catch-up mechanics, visual
        satisfaction],
      [Default UI hides complexity; cities grow meaningfully without
        micromanagement; no real-time pressure outside of combat],

      [Competitive PvP Player],
      [Meaningful conflict, fair rules, skill-based outcomes],
      [No pay-to-win; civilization balance is purely mechanical;
        world-speed settings control engagement intensity],

      [Modder / Contributor],
      [Extensibility, clear data formats, documented hooks],
      [Civilizations and buildings are data files; the scripting engine
        exposes gameplay hooks; this wiki is the contract],
    ),
    kind: table,
  )

  #v(0.6em)

  // ── 4. Inspirations ───────────────────────────────────────────────────────
  = Inspirations & Lineage

  0 C.E. does not emerge from a vacuum. It draws deliberately from a
  small set of reference games, each contributing a distinct idea:

  #figure(
    table(
      columns: (1.2fr, 2fr),
      table.header([*Reference*], [*What 0 C.E. borrows*]),
      [*Grepolis*],
      [Persistent browser-based world; city slot system; divine favor
        mechanics; the core tension between building and fighting in a
        shared live world],

      [*Civilization* (series)],
      [Civilization-specific asymmetric gameplay; technology trees;
        the idea that choosing a civilization is a meaningful strategic
        commitment],

      [*Forge of Empires*],
      [City era progression; accessible visual progression loop that
        rewards long-term investment without demanding constant
        attention],

      [*0 A.D.*],
      [Open-source ancient-world strategy as a viable project model;
        civilization differentiation as a core design pillar; city era
        system as a structural reference],
    ),
    kind: table,
  )

  #v(0.6em)

  // ── 5. Anti-Goals ─────────────────────────────────────────────────────────
  = Anti-Goals

  These are explicit refusals. They are not aspirational — they are
  binding constraints on every design decision.

  #figure(
    table(
      columns: (1.4fr, 2fr),
      table.header([*Anti-Goal*], [*What this means in practice*]),
      [*No pay-to-win*],
      [Real money never purchases gameplay advantage. Cosmetics and
        server hosting support are the only acceptable monetization
        paths. Any mechanic that correlates spending with winning is
        rejected unconditionally.],

      [*No predatory mechanics*],
      [0 C.E. will not implement FOMO timers, aggressive push
        notifications, artificial energy systems, or any mechanic
        whose primary purpose is to extract money through psychological
        pressure rather than deliver fun.],

      [*Community-driven design*],
      [No significant design decision is made unilaterally and
        silently. Changes to core systems are proposed openly,
        discussed, and documented. The community is a collaborator,
        not an audience.],
    ),
    kind: table,
  )

  #v(0.6em)

  // ── 6. Scope ──────────────────────────────────────────────────────────────
  = Scope & Setting

  *Period:* The ancient world spanning roughly 3000 BCE to 500 CE —
  the era of Sumer, classical Greece, Pharaonic Egypt, the Roman
  Republic and Empire, and the Maya civilization. Mechanical fit
  always takes priority over strict periodical accuracy: civilizations
  from different centuries coexist in the same world by design.

  *World structure:* Each world is a procedurally generated persistent
  map. Worlds run in real time. Each world has a defined end condition
  — a player or alliance achieves victory, the world closes, and a
  new one begins. Multiple worlds can run simultaneously, each at
  its own speed setting.

  *Technical target:* 100 concurrent players on a single-board
  computer with less than 2 GB RAM. The browser client requires no
  plugin, no download, and no WebGL 2.0.

  // ── Footer ─────────────────────────────────────────────────────────────────
  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + luma(200))
  #v(0.4em, weak: true)
  #align(center)[
    #text(size: 8.5pt, fill: luma(140))[
      Changes to this document must be recorded in
      #link("Changelog.pdf")[Changelog] ·
      #link("Home.pdf")[← Back to Wiki Home]
    ]
  ]
]
