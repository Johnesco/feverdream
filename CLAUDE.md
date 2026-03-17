# Fever Dream

An original Inform 7 interactive fiction with native blorb sound and CSS atmospheric effects.

- **Repo**: `Johnesco/feverdream` — `johnesco.github.io/feverdream/`

For build, test, and publish workflows, see `C:\code\ifhub\reference\project-guide.md`.

## Project-Specific Notes

- **Sound**: Compile with `--sound` to embed `.ogg` audio in `.gblorb`
- **Scoreless**: Walkthrough runner uses endgame text detection (`WON_PATTERNS`) instead of score-based pass/fail
- **CSS effects**: Dynamic mood system — medical monitor intro, zone-reactive mood palettes, event-triggered animations (glass break, fungus ripple, spray glitch, valve drain/flood)

## Game Overview

- **Scoring**: None (scoreless — win condition is reaching the endgame)
- **Sound**: Native blorb — ambient audio zones + one-shot sound effects
