# Docs Folder Conventions

This folder is organized by document role. Keep files in the matching subfolder.

## Structure

- `chapters/`: Main GDD chapters (one file per topic page).
- `buildings/`: Individual building reference pages (`Building-...`).
- `nav/`: Navigation pages (`Home.typ`, `_Sidebar.typ`).
- `templates/`: Shared Typst styling/template files.
- `scripts/`: Build/helper scripts (for conversion/link utilities).

## Where New Files Go

- New core design chapter: add to `chapters/`.
- New building page: add to `buildings/`.
- New navigation/index pages: add to `nav/`.
- Shared Typst page wrapper/style changes: update `templates/`.
- Build/conversion helpers: add to `scripts/`.

## Naming Rules

- Chapters: use stable title-based names, e.g. `Naval-Logistics.typ`.
- Buildings: `Building-Name.typ` with capitalized words.
- Navigation files: short, stable names (`Home.typ`, `_Sidebar.typ`).
- Use `.typ` for documentation pages.

## Linking Rules

- Use relative Typst links with explicit `.typ` extension.
- Prefer links that remain valid when files move within their category.
- Keep anchors only when needed, e.g. `/docs/chapters/Economy.typ#section-id`.

## Maintenance Notes

- After moving/renaming files, run a link integrity check before commit.
- Keep this README updated if folder purposes or naming patterns change.

## City illustration

![Temporary AI-generated image](./city_illustration.png)
