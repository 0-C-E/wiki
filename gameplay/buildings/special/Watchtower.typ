#import "/utils/formulas.typ": building_table, starting_levels
#import "/utils/constants.typ": (
  special_building_construction_duration, special_building_points,
  special_building_population_cost,
)

= 0 C.E. --- Watchtower #emph[(Special)] <watchtower-special>
#link("#")[← Buildings & Wonders]

== Purpose <purpose>

Long before armies reached the city gates, they could often be spotted from distant towers placed along roads and hills. These watch posts served as the city's eyes, warning defenders of approaching threats and reporting suspicious movements.

The Watchtower functions as an intelligence and surveillance center, giving your city valuable information about hostile activity.

Once constructed, the Watchtower allows you to analyze incoming military attacks, revealing their composition and structure before they arrive. It also detects espionage attempts, helping you identify covert operations targeting your city.

The Watchtower does not prevent attacks, but the information it provides allows you to prepare an effective defense.

~ Strategic focus: #strong[Intelligence] / #strong[defense]

== Requirements <requirements>

- *Senate* level 21
- *City Walls* level 15
- *Academy* level 10
- *Marketplace* level 5
- Do not have any other special building already built

#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Property], [Value]),
    table.hline(),
    [#strong[Type];], [Special (non-upgradable)],
    [#strong[Max Level];], [1],
    [#strong[Effects];], [Attack intent classification; spy detection],
  )],
  kind: table,
)

== Effect Formulas <effect-formulas>

=== Attack Intent Classification

When an attack is launched against your city, the Watchtower analyzes the incoming force composition and classifies it by dominant attack power type. The classification is probabilistic and reveals intent rather than exact composition.

```py
dominant_type = argmax(blunt_score, sharp_score, distance_score, naval_score)
confidence = (top_score - second_score) / total_score
classification_confidence_band = if confidence > threshold_high: "High"
                                 elif confidence > threshold_low: "Medium"
                                 else: "Low"
```

#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Coefficient], [Value]),
    table.hline(),
    [`threshold_high`], [0.35],
    [`threshold_low`], [0.18],
    [`siege_risk_threshold`], [0.15],
    [`siege_major_threshold`], [0.30],
  )],
  kind: table,
)

If a force contains siege weapons or siege ships above `siege_risk_threshold`, a "Siege Risk" flag is added to the classification (either "Possible" if between thresholds or "High" if exceeds major threshold).

*Example*: An incoming attack with 45% blunt units, 30% sharp, 15% distance, 10% naval would classify as *Blunt — Medium Confidence*, and if 22% siege share also present, flag as *Siege Risk: Possible*.

=== Spy Detection

The Watchtower acts as an unblinking sentinel against covert operations. When espionage is attempted against your city, the Watchtower will detect it. The detection is guaranteed, but the identity of the sender remains hidden.

```py
revealed_info_per_detection = one_of(cardinal_origin, faction_relation)
faction_relation = one_of(allied, neutral, enemy)
```

#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Spy Type], [Detection Rate]),
    table.hline(),
    [Reconnaissance], [100%],
    [Economic Sabotage], [100%],
    [Military Sabotage], [100%],
  )],
  kind: table,
)

Upon detection, defender is notified of the spy action and receives exactly one clue: either the cardinal point of origin (north, northeast, east, southeast, south, southwest, west, northwest), or the attacker's relationship status (allied, neutral, or enemy). Sender attribution is never automatic and requires advanced espionage technology to unlock (separate tech tree mechanic).

== Starting Levels <starting-levels>
#figure(
  align(center)[#table(
    columns: 2,
    align: (auto, auto),
    table.header([Mode], [Starting Level]),
    table.hline(),
    [Full World], [0],
    [Campaign], [0],
    [Skirmish], [0],
    [Game Night], [0],
  )],
  kind: table,
)

== Cost <cost>
#let max_level = 1

// ── Base values & Functions ──
#let wood_cost(l) = 420
#let stone_cost(l) = 520
#let metal_cost(l) = 140
#let food_cost(l) = 200
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

== Notes <notes>

=== Attack Classification Mechanics

- The Watchtower automatically analyzes all incoming military attacks and provides an attack intent classification.
- Classification is based on the dominant attack power type in the incoming force:
  - *Blunt*: Heavy melee and crushing weapons (war chariots, heavy infantry)
  - *Sharp*: Precision melee and slicing weapons (swordsmen, pikemen)
  - *Distance*: Ranged weapons (archers, slingers)
  - *Naval*: All naval unit types (triremes, biremes, etc.)
- Siege weapons and siege ships are flagged separately and do not dominate classification.
- Confidence bands (High/Medium/Low) reflect how clearly attackers are committing to one type vs. mixed composition.
- *Low confidence attacks are labeled "Mixed Formation"* to prevent over-precision.
- Classification updates at attack launch and again at mid-route waypoint for long-distance attacks.

=== Spy Detection Mechanics

- The Watchtower provides guaranteed spy detection in your city without requiring active scouting.
- When espionage is attempted against your city, the Watchtower *will* detect it.
- Information revealed is limited to protect diplomatic privacy:
  - You never learn the exact attacker.
  - You never learn the exact attacker location (only cardinal direction).
  - You learn only one clue per detection event: either origin direction or relationship status.
- Multiple players can attempt spies simultaneously; each detection occurs independently but is always successful.
- The anonymity protection is absolute: even with multiple detected spies, you cannot infer sender identity.

=== Strategic Counterplay

Attackers can use the following tactics to defeat Watchtower analysis:

- *Composition Spoofing*: Mix unit types to create false "Mixed Formation" classifications and hide true intent.
- *Feint Attacks*: Use cheap decoy attacks to burn out defensive resources and prepare real assault elsewhere.
- *Stealth Tech*: Research espionage technologies to reduce spy detection rates or improve sender opacity.
- *Delayed Launch*: More advanced doctrines allow attackers to mask launch windows and confuse tower intel windows.

=== Limitations

- Watchtower has no effect on attacks already in flight (launched before tower was built). Only attacks launched while tower is active are classified.
- Destroying the Watchtower immediately disables classification for new attacks; existing notifications are retained for historical reference.
- Classification confidence improves when attacker cities are nearby (within 8 map units); distant attackers get lower confidence due to march dilution.
