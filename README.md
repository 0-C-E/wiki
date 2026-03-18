# 0 C.E. — Wiki & Game Design Document

This repository is the single source of truth for *0 C.E.*, an
open-source browser-based MMORTS set in the ancient world. It serves
simultaneously as the internal game design document (GDD) and the
public-facing player wiki.

All documentation is written in [Typst](https://typst.app/) and
compiled to PDF automatically on every push. The compiled wiki is
published at:

**https://0-c-e.github.io/wiki/**

## Structure

```
wiki/
├── overview/          # Vision, Roadmap, Glossary, Changelog
├── gameplay/
│   ├── core/          # Game loop, Progression, Victory
│   ├── economy/       # Resources, Production, Trade, Balancing
│   ├── buildings/
│   │   ├── civic/
│   │   ├── culture-religion/
│   │   ├── military/
│   │   ├── production/
│   │   └── special/
│   ├── military/      # Units, Combat, Sieges, Navy
│   ├── research/      # Tech trees, Research mechanics
│   ├── territory/     # World map, Villages, Territory control
│   └── social/        # Diplomacy, Alliances, Forums
├── civilizations/     # One file per civilization
├── advanced/          # Post-launch systems (Heroes, Espionage, Divine…)
├── technical/         # Architecture, API, Modding, Contributing
├── templates/         # Shared Typst theme (_preamble.typ, _pandoc.template)
└── utils/             # Shared formulas and constants (formulas.typ, constants.typ)
```

One concept = one `.typ` file. `templates/` and `utils/` are shared
infrastructure — they are excluded from compilation and formatting.

## Compiling Locally

### Option A — DevContainer (recommended)

The repository ships with a ready-to-use VS Code DevContainer. It
includes Typst, typstyle, and Pandoc at pinned versions, with no local
installation required.

1. Install [Docker](https://www.docker.com/) and the
   [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   VS Code extension.
2. Open the repository in VS Code.
3. When prompted, click **Reopen in Container** — or open the Command
   Palette and run `Dev Containers: Reopen in Container`.
4. Wait for the container to build. When the terminal shows
   `DevContainer ready.`, you are set.

Compile a single file:

```bash
typst compile overview/Home.typ overview/Home.pdf --root .
```

Compile all files (mirrors the CI build):

```bash
find . -type f -name "*.typ" \
  ! -path "./templates/*" \
  ! -path "./utils/*" \
  ! -path "./.github/*" | while IFS= read -r src; do
  rel="${src#./}"
  dest="_site/${rel%.typ}.pdf"
  mkdir -p "$(dirname "$dest")"
  typst compile "$src" "$dest" --root .
done
```

### Option B — Local Typst installation

Install Typst from [typst.app](https://typst.app/) or via your package
manager, then use the same commands above.

> **Font note:** all `.typ` files use `"New Computer Modern"` (body)
> and `"DejaVu Sans Mono"` (code). Both are bundled with Typst and
> require no separate installation.

## Authoring Rules

These rules keep the CI green and the document consistent.

**Imports** must use absolute paths from the repo root:

```typst
// Correct
#import "/templates/_preamble.typ": gdd-page
#import "/utils/formulas.typ": building_table

// Wrong — breaks under --root
#import "../../templates/_preamble.typ": gdd-page
```

**PDF links** must be absolute with the `/wiki/` prefix:

```typst
// Correct
#link("/wiki/gameplay/economy/Resources.pdf")[Resources]

// Wrong — resolves to the wrong path on GitHub Pages
#link("Resources.pdf")[Resources]
```

**Dollar signs** must be escaped — `$` opens math mode in Typst:

```typst
// Correct
50 USD
// Wrong — causes a compile error
$50
```

**Fonts** — do not introduce new font families. Use only
`"New Computer Modern"` and `"DejaVu Sans Mono"`. Other fonts are not
available in CI and will produce warnings or rendering fallbacks.

## Contributing

All contributions are welcome. The workflow is:

1. **Fork** the repository and create a branch from `main`.
2. **Edit or create** `.typ` files following the authoring rules above.
3. **Compile locally** to verify your changes render correctly before
   opening a PR.
4. **Open a pull request** against `main` with a clear description of
   what changed and why.
5. The CI will compile all files and deploy the result automatically
   on merge.

**For content changes** (correcting a mechanic, updating a formula,
adding a building): make the change in the relevant `.typ` file. If the
change affects a design decision that was previously documented, add an
entry to `overview/Changelog.typ`.

**For new files**: follow the one-concept-one-file convention, place
the file in the correct subfolder, and add a corresponding entry to
`overview/Home.typ`.

**For structural changes** (moving files, renaming sections): update
`overview/Home.typ`, all affected `#link` references, and the CI
validation list in `.github/workflows/docs.yml` if required files
change.

## Reporting Content Errors

If you find a factual error, a contradiction between two documents, or
a mechanic that is described inconsistently:

1. Open a [GitHub Issue](../../issues) with the label `content`.
2. Quote the incorrect passage and the file it is in.
3. Describe what is wrong and, if possible, what the correct version
   should be.

Do not open issues for compilation errors or broken links without first
checking that you are using the correct import and link formats
described in the authoring rules above.

## Licence

*To be determined.* The project intends to adopt an open licence
compatible with community contributions and self-hosting. This section
will be updated once a licence is chosen.

Until then, all content in this repository is copyright its contributors
and may not be reproduced outside of the project without explicit
permission.