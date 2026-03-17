// =============================================================================
// gameplay/core/Game-Loop.typ — 0 C.E. Game Loop & Time Model
//
// Role:    Defines how time flows, what actions exist, how long they take,
//          and how the server processes the world continuously.
// Audience: Game designers, developers, players.
//
// CANON RULE: All duration formulas reference /utils/formulas.typ.
//             All building queue values must stay consistent with
//             /gameplay/buildings/civic/Senate.typ and
//             /gameplay/buildings/special/Governors-Palace.typ.
// =============================================================================

#import "/templates/_preamble.typ": accent, dark, gdd-page, mid

#gdd-page(title: "0 C.E. — Game Loop & Time Model")[

  // ── Title block ────────────────────────────────────────────────────────────
  #align(center)[
    #v(1.2em)
    #text(size: 28pt, weight: "bold", fill: dark)[Game Loop & Time Model]
    #v(0.3em, weak: true)
    #text(size: 11pt, fill: luma(100), style: "italic")[
      How time flows, what players do, and how the world never stops.
    ]
    #v(0.5em, weak: true)
    #line(length: 40%, stroke: 0.8pt + accent)
    #v(1.4em)
  ]

  // ── 1. Time Model ─────────────────────────────────────────────────────────
  = Time Model

  0 C.E. runs in *continuous real time*. There are no turns, no ticks
  that players wait for, and no scheduled phases. Every action a player
  initiates has a duration — a countdown that runs against the wall clock
  regardless of whether the player is connected. The server processes the
  world permanently; logging out does not pause, protect, or suspend any
  ongoing action.

  This model is identical in spirit to Grepolis: a building queued at
  noon will complete at 2 PM whether the player is watching or asleep.

  == World Speed

  Each world instance is created with a configured speed multiplier that
  compresses all durations uniformly. A world speed of *x2* means every
  action completes in half the real time compared to x1.

  #figure(
    table(
      columns: (1fr, 1fr, 2fr),
      table.header([*Speed*], [*Multiplier*], [*Effect*]),
      [x1], [1.0], [Standard — intended reference experience],
      [x2], [0.5], [All durations halved],
      [x5], [0.2], [All durations divided by five — fast worlds],
    ),
    kind: table,
  )

  World speed is set at world creation and cannot be changed while a
  world is running. All duration values in this wiki are expressed at
  *x1 speed*. To find the actual duration on a given world, divide by
  the world speed multiplier.

  #v(0.6em)

  // ── 2. Action Types ───────────────────────────────────────────────────────
  = Action Types

  All player-initiated actions fall into one of six categories. Each
  category has its own queue, duration model, and cancellation rules.

  #figure(
    table(
      columns: (1.3fr, 1fr, 2fr),
      table.header([*Action*], [*Queue*], [*Duration model*]),
      [*Building construction*],
      [Per city, see §3],
      [Fixed duration per level, modified by Senate level and
        civilization bonuses. Determined at queue time.],

      [*Resource production*],
      [Passive — no queue],
      [Continuous. Resources accumulate per second based on building
        levels. No player action required.],

      [*Unit training*],
      [Per building (Barracks / Harbor)],
      [Fixed duration per unit type, modified by building level.
        Units train sequentially within each building's queue.],

      [*Army movement*],
      [Per army],
      [Duration determined by distance and unit speed at dispatch time.
        Not visible on the map --- only a countdown timer is shown.],

      [*Research*],
      [Per city, one at a time],
      [Fixed duration per technology, modified by Academy level.],

      [*Trade routes*],
      [Per Marketplace slot],
      [Round-trip duration determined by distance to target at
        dispatch time.],
    ),
    kind: table,
  )

  No action can be accelerated by any means. There is no premium
  currency, no resource cost, and no mechanic that shortens a running
  timer. This is a binding anti-goal — see
  #link("/wiki/overview/Vision.pdf")[Vision § Anti-Goals].

  #v(0.6em)

  // ── 3. Building Queue ─────────────────────────────────────────────────────
  = Building Queue

  Each city has a single *active construction slot* — only one building
  can be under construction at a time. Additional buildings can be
  *queued* in advance; the queue processes sequentially.

  == Queue Capacity

  The maximum queue size depends on the city's Senate level and whether
  the Governor's Palace special building has been constructed.

  #figure(
    table(
      columns: (2fr, 1fr),
      table.header([*Condition*], [*Max queue size*]),
      [Senate level 1--10], [1],
      [Senate level 11--20], [2],
      [Senate level 21+], [3],
      [Governor's Palace built (any Senate level)], [+5 additional slots],
    ),
    kind: table,
  )

  The queue size is the number of buildings that can be *pending*, not
  including the one currently under construction. A city with Senate
  level 25 and a Governor's Palace can have 1 active + 8 pending = 9
  total concurrent entries.

  == Queue Rules

  - Buildings are processed strictly in order — no reordering once
    queued.
  - Resource costs are deducted at queue time, not at construction start.

  === Cancelling the Active Construction

  The building currently under construction *can* be cancelled at any
  time. The refund is proportional to the remaining work:

  #block(
    fill: luma(245),
    stroke: (left: 3pt + accent),
    inset: (x: 1.2em, y: 0.9em),
    radius: (right: 3pt),
  )[
    *refund = cost × (1 − progression)*

    Where `progression` is a value between 0.0 (just started) and 1.0
    (complete). A building cancelled at 10% completion refunds 90% of
    its cost; a building cancelled at 90% completion refunds only 10%.
  ]

  This means there is always a cost to changing your mind mid-construction,
  and that cost grows the longer you wait.

  === Cancelling Queued Buildings

  A building that has not yet started construction (sitting in the queue)
  can be cancelled at any time for a *75% resource refund*. The 25%
  loss reflects a planning penalty and discourages using the queue as a
  free resource reservation system.

  #figure(
    table(
      columns: (2fr, 1fr, 2fr),
      table.header([*Cancellation type*], [*Refund*], [*Formula*]),
      [Active construction],
      [0% -- 100%],
      [cost × (1 − progression)],
      [Queued (not yet started)],
      [75%],
      [cost × 0.75],
    ),
    kind: table,
  )

  #v(0.6em)

  // ── 4. Combat Resolution ──────────────────────────────────────────────────
  = Combat Resolution

  When an army completes its march and arrives at the target city,
  combat resolves *instantaneously*. There is no real-time battle phase,
  no waiting period, and no mid-combat intervention. The outcome is
  computed in a single server-side calculation at the moment of arrival.

  The result — losses, loot, and city state changes — is immediately
  visible to both attacker and defender. See
  #link("/wiki/gameplay/military/Combat-Resolution.pdf")[Combat Resolution]
  for the full battle formula.

  #v(0.6em)

  // ── 5. Offline Continuity ─────────────────────────────────────────────────
  = Offline Continuity

  The world server runs continuously and independently of player
  connections. When a player logs out:

  - All queued constructions continue and complete on schedule.
  - Resources continue accumulating up to storage cap.
  - Armies in transit continue marching and arrive as computed.
  - Incoming attacks arrive and resolve even if the defender is offline.
  - Trade routes complete and resources are deposited automatically.
  - Research continues and completes.

  There is no individual protection mode, no vacation pause mechanic,
  and no way to shield a single city from the shared world. The only
  protection is collective --- night mode, when enabled by the host,
  raises the cost of attacks for everyone equally. The world does not
  wait; it simply fights back a little harder after midnight.

  This is a deliberate design choice: it creates genuine strategic
  stakes around timing, alliance coordination, and city defence. Players
  who need protection rely on diplomacy, alliances, and City Walls —
  not on a pause button.

  #v(0.6em)

  // ── 6. Notifications ──────────────────────────────────────────────────────
  = Notifications

  Players can opt into browser notifications for any combination of the
  following events. Notifications are disabled by default and never
  mandatory.

  #figure(
    table(
      columns: (2fr, 1fr),
      table.header([*Event*], [*Default*]),
      [Construction completed], [Off],
      [Unit training completed], [Off],
      [Research completed], [Off],
      [Trade route returned], [Off],
      [*Incoming attack detected*], [*On*],
      [Army arrived at target], [Off],
      [Storage cap reached], [Off],
    ),
    kind: table,
  )

  Incoming attack is the only notification enabled by default — it is
  the only event that affects city security rather than player
  convenience. All other notifications are opt-in.

  #v(0.6em)

  // ── 7. Session Structure ──────────────────────────────────────────────────
  = Session Structure

  Because the world runs continuously, there is no prescribed session
  length. A player can log in for two minutes to queue a building and
  log out, or spend hours coordinating an alliance attack. Both are
  valid playstyles.

  The typical engagement loop is:

  + *Check* — review completed actions, read incoming reports, assess
    your resource levels and whether any storage cap is being hit.
  + *Queue* — queue the next building, research, or unit batch. If
    resources are near the storage cap, spending them on a construction
    or training order is the only way to avoid overflow loss.
  + *Dispatch* — send armies or trade routes if applicable.
  + *Plan* — review the map, coordinate with allies, set timers.
  + *Log out* — the world continues without the player.

  Resources accumulate fully passively — there is nothing to click or
  collect. When a storage cap is reached, production of that resource
  simply stops until cap is raised or resources are spent. The player
  is never rewarded for logging in more often just to "harvest".

  The game is designed so that a player checking in once or twice a day
  can remain competitive. Deep optimizers who check more frequently gain
  marginal advantages in timing precision, but the game never
  *requires* constant presence.

  // ── 8. Night Mode ─────────────────────────────────────────────────────────
  = Night Mode

  Night mode is an *optional, host-configured* protection window. When
  enabled, all cities on the world receive a flat defense bonus for the
  duration of the window. It exists to protect players who sleep, work,
  or simply choose not to play around the clock — without removing the
  permanence of the world or introducing a pause mechanic.

  Night mode is a world-level setting. Individual players cannot set
  their own window; the host defines a single shared schedule that
  applies equally to everyone.

  == Default Configuration

  #figure(
    table(
      columns: (2fr, 1fr),
      table.header([*Parameter*], [*Default value*]),
      [Night mode enabled], [Yes],
      [Start time (server time)], [00:00],
      [End time (server time)], [06:00],
      [Defense bonus], [+100%],
    ),
    kind: table,
  )

  A +100% defense bonus means all defensive unit stats are doubled for
  the duration of the window. An attacker sending a force that would
  normally win 60/40 may lose decisively against the same garrison
  during night mode.

  == Host Configuration

  The host can freely adjust all parameters at world creation. There is
  no constraint on the window length or timing — a host running a world
  for a specific community may set the window to match their local night,
  regardless of server timezone.

  #figure(
    table(
      columns: (2fr, 1.2fr, 2fr),
      table.header([*Parameter*], [*Type*], [*Notes*]),
      [`night_mode_enabled`], [`bool`], [Defaults to `true`. Set to `false` to disable entirely.],
      [`night_start`], [`HH:MM`], [Server time. Any valid 24h time.],
      [`night_end`], [`HH:MM`], [Server time. Can cross midnight (e.g. 23:00--05:00).],
      [`defense_bonus`], [`float`], [Multiplier added to base defense. 1.0 = +100%. Min 0, no hard max.],
    ),
    kind: table,
  )

  == Army Arrival During Night Mode

  If a player dispatches an army whose calculated arrival time falls
  within the active night window, the game *visibly warns* them at
  dispatch time. The warning is prominent — the arrival time is
  highlighted and the active defense bonus is shown alongside the
  normal combat preview.

  The player retains full control: they may dispatch anyway, delay
  departure to arrive after the window, or cancel. No action is blocked
  or forced. The warning is informational, not a restriction.

  #block(
    fill: luma(245),
    stroke: (left: 3pt + accent),
    inset: (x: 1.2em, y: 0.9em),
    radius: (right: 3pt),
  )[
    *Design intent:* night mode does not make attacks impossible. A
    sufficiently large or well-timed force can still succeed. It raises
    the cost and risk of night attacks enough to make them unattractive
    for casual raids, while keeping the world genuinely persistent.
  ]

  == Economy During Night Mode

  Night mode affects *combat only*. Construction, resource production,
  unit training, research, and trade routes all continue normally
  throughout the window. Players who log in during the night window can
  queue buildings, dispatch merchants, and manage their cities without
  restriction.

  #v(0.6em)

  // ── Footer ────────────────────────────────────────────────────────────────
  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + luma(200))
  #v(0.4em, weak: true)
  #align(center)[
    #text(size: 8.5pt, fill: luma(140))[
      #link("/wiki/gameplay/core/Progression.pdf")[Progression →] ·
      #link("/wiki/gameplay/core/Victory-and-Prestige.pdf")[Victory & Prestige →] ·
      #link("/wiki/overview/Home.pdf")[← Wiki Home]
    ]
  ]
]
