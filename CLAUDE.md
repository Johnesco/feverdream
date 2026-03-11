# Fever Dream — Project Guide

An original Inform 7 interactive fiction with native blorb sound and CSS atmospheric effects. Published to GitHub Pages at `johnesco.github.io/feverdream/`.

## Project Structure

```
C:\code\ifhub\projects\feverdream\
├── CLAUDE.md              ← You are here
├── story.ni               ← Source of truth (Inform 7 source)
├── feverdream.ulx         ← Compiled Glulx binary (build output, gitignored)
├── feverdream.gblorb      ← Blorb binary with embedded sound (build output)
├── index.html             ← Landing page
├── play.html              ← Browser-playable game (Parchment player + mood theming)
├── source.html            ← Source browser
├── walkthrough.html       ← Walkthrough viewer
├── lib/parchment/         ← Parchment JS libraries + feverdream.gblorb.js (base64 binary)
├── Sounds/                ← Audio asset files (.ogg) for Blorb packaging
└── tests/
    ├── project.conf       ← Project-specific test configuration
    ├── seeds.conf         ← Golden seeds for deterministic testing
    └── inform7/
        ├── walkthrough.txt        ← Walkthrough commands
        ├── walkthrough-guide.txt  ← Annotated walkthrough guide
        └── walkthrough_output.txt ← Generated transcript
```

## GitHub Repository

- **Repo**: `Johnesco/feverdream`
- **GitHub Pages**: `johnesco.github.io/feverdream/`
- **IF Hub**: Served in-place — the hub iframes pages directly from GitHub Pages

## Shared Resources

- **Inform 7 hub**: `C:\code\ifhub\CLAUDE.md` — syntax guides, compiler docs, testing framework
- **Syntax reference**: `C:\code\ifhub\reference\syntax-guide.md`
- **Text formatting**: `C:\code\ifhub\reference\text-formatting.md`
- **Sound architecture**: `C:\code\ifhub\reference\sound.md`
- **Testing framework**: `C:\code\ifhub\tools\testing\` — generic scripts driven by `project.conf`
- **Native interpreters**: `C:\code\ifhub\tools\interpreters\` — `glulxe.exe`, `dfrotz.exe` (build with `build.sh` in MSYS2)
- **RegTest runner**: `C:\code\ifhub\tools\regtest.py`
- **Web player setup**: `C:\code\ifhub\tools\web\` — Parchment libraries, template, setup script
- **Pipeline**: `C:\code\ifhub\tools\pipeline.py` — compile → test → push orchestrator
- **CSS overlay**: `C:\code\ifhub\reference\css-overlay.md` — play.html theming architecture

## Building

```bash
# Compile with sound (recommended — embeds .ogg audio in .gblorb)
python /c/code/ifhub/tools/compile.py feverdream --sound

# Or via pipeline (compile + test)
python /c/code/ifhub/tools/pipeline.py feverdream compile test
```

## Web Player

Open `play.html` in a browser to play. Uses Parchment (Emglken WASM Glulx interpreter) with native Glk sound.

The player includes a **dynamic CSS mood system** — Houdini `@property` color transitions, MutationObserver-driven zone detection, and event-triggered visual effects (medical monitor intro, glass break, fungus consumed, spray exposure, valve drain/flood). See `reference/css-overlay.md` for the full architecture.

To serve locally (avoids file:// CORS issues):
```bash
python /c/code/ifhub/tools/dev_server.py
# Then open http://127.0.0.1:8000/feverdream/play.html
```

After recompiling, the compile script automatically updates the web binary.

## Testing

Tests use the shared framework at `C:\code\ifhub\tools\testing\`. Platform detection in `project.conf` auto-selects native `glulxe.exe` (Git Bash) or WSL `glulxe` (Linux).

Fever Dream is a **scoreless game** — the walkthrough runner uses endgame text detection (`WON_PATTERNS` in `project.conf`) instead of score-based pass/fail.

```bash
# Run walkthrough (native — no WSL needed if interpreters are built)
python /c/code/ifhub/tools/testing/run_walkthrough.py --config tests/project.conf

# Find golden seeds
python /c/code/ifhub/tools/testing/find_seeds.py --config tests/project.conf

# Or via pipeline
python /c/code/ifhub/tools/pipeline.py feverdream compile test
```

## Game Overview

- **Scoring**: None (scoreless — win condition is reaching the endgame)
- **Sound**: Native blorb — ambient audio zones + one-shot sound effects
- **CSS effects**: Medical monitor intro, zone-reactive mood palettes, event-triggered animations (glass break, fungus ripple, spray glitch, valve drain/flood)

## Key Rules

- `story.ni` is the single source of truth
- Do NOT create `.inform/` IDE bundles
- For Inform 7 syntax and conventions, see `C:\code\ifhub\CLAUDE.md`
