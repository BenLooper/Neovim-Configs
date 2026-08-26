# nvim config

Neovim 0.12 + lazy.nvim, tuned for reviewing agent-generated code across
unfamiliar languages: strong LSP/treesitter legibility, a diff-review layer,
and agent CLIs running in adjacent tmux panes.

## Layout

```
init.lua                     entry point → requires config.lazy
lua/
  config/
    lazy.lua                 lazy.nvim bootstrap + spec import (lua/plugins/**)
    options.lua              vim options (tabs, search, scrolloff, diffopt…)
    keymaps.lua              global keymaps (Oil, nohlsearch, format, gl)
  art.lua                    ascii art for the dashboard splash
  plugins/                   one spec per plugin; names match the plugin
    gruvbox-material.lua     colorscheme + custom highlights + dark/light toggle
    lsp.lua                  LSP stack: servers table, profile filtering, Mason
    roslyn.lua               C# via roslyn.nvim (only when dotnet is on PATH)
    blink.lua                completion engine
    conform.lua              formatting per filetype
    nvim-treesitter.lua      parsers + native highlight/fold setup (main branch)
    nvim-treesitter-textobjects.lua   af/if/ac/ic selects, ]m/[m moves, swaps
    fzf.lua                  all fuzzy-finding keymaps
    dashboard.lua            start screen (milli.nvim ascii art)
    oil.lua / project.lua / persistence.lua / scratchpad.lua
    diffview.lua / diffs.lua / gitsigns.lua / lazygit.lua
    code-preview.lua / hunk-review.lua / sidekick.lua   ← agent workflow
    vim-tmux-navigator.lua   Ctrl-h/j/k/l across nvim splits AND tmux panes
    …                        one small file each: context, dropbar, aerial,
                             endhints, indent, todo-comments, render-markdown,
                             rainbow-delimiters, schemastore, colorizer, snacks,
                             toggleterm, smear-cursor, which-key, statusline
lazy-lock.json               pinned commits for every plugin (reproducibility)
```

Conventions: every plugin is lazy-loaded (`event`/`keys`/`ft`/`cmd`) unless it
must load eagerly (theme, tmux-navigator, dashboard). Comments in each spec
explain the non-obvious choices — read the file before changing it.

## How startup works

1. `init.lua` → `config.lazy` bootstraps lazy.nvim from the lockfile.
2. lazy imports `lua/plugins/**/*.lua`, resolves dependencies, loads eager
   specs (gruvbox-material applies the colorscheme here).
3. Everything else waits for its trigger: opening a file (treesitter, LSP,
   gitsigns), pressing a leader key (fzf), entering insert mode (blink),
   or running a command (`:HunkReview`, `:LazyGit`).

## The layers

### Theme — gruvbox-material

Soft-contrast palette built for long sessions. Dimmed inactive windows keep
focus on the active pane during multi-pane diffs. Custom highlights live in
the theme spec: themed rainbow delimiters, deprecated-API strikethrough,
sticky-context-as-chrome, bold inline-diff text, italic end-of-line hints.
`<leader>uT` toggles dark/light.

### LSP — profile-aware

`lsp.lua` holds one `servers` table (config per server) plus a
`server_runtimes` map (gopls→go, vtsls→npm, nixd→nixd, …). At startup both are
filtered through `vim.fn.executable()`: a server without its runtime on PATH
is never configured and never Mason-installed. Standalone-binary servers
(lua_ls, rust_analyzer, marksman, ruff…) need no runtime and stay always-on.

This is deliberate: your home-manager profiles control PATH, so **switching
profiles switches your LSP set** with zero nvim changes. Work has dotnet → C#
works there. Personal doesn't → roslyn sits inert.

Inlay hints auto-enable on attach (rendered at end-of-line by nvim-lsp-endhints
so columns never shift); `<leader>th` toggles per buffer. Per-server hint
settings live in each server's entry in the `servers` table.

### Treesitter & textobjects

Parsers install on demand via the main-branch API (needs `tree-sitter` CLI on
PATH — provided by Nix). Highlighting and folding are native 0.12
(`vim.treesitter.start()` + foldexpr). Textobjects give structural editing:
`af/if` functions, `ac/ic` classes, `]m/[m` function motion, `]]/[[` class
motion, `<leader>a/<leader>A` parameter swap.

### Readability layer

Sticky context (treesitter-context), winbar breadcrumbs (dropbar), outline
sidebar (aerial), gutter signs + blame (gitsigns), TODO highlighting
(todo-comments), indent guides (ibl + mini.indentscope), rendered markdown
(render-markdown), schema-validated JSON/YAML (schemastore), inline color
swatches, and treesitter-highlighted diffs everywhere (diffs.nvim + 0.12's
`diffopt=inline:char`).

### Agent review workflow

Run opencode/Claude Code in a tmux pane next to nvim; use nvim as the review
surface:

| Tool | Role |
| --- | --- |
| code-preview.nvim | Agent edits appear as native diffs BEFORE hitting disk; accept/reject in the agent CLI. Hooks install **per project** — run once in each repo where you use agents: `:CodePreviewInstallClaudeCodeHooks` / `:CodePreviewInstallOpenCodeHooks` (already done for ~/dotfiles) |
| hunk-review.nvim (`:HunkReview`) | Batch-review the working diff, comment on hunks, export feedback back to the agent |
| diffview (`:DiffviewOpen`, `:DiffviewOpen main...HEAD`) | Branch/file-history review; `enhanced_diff_hl` syntax-highlights both sides |
| sidekick.nvim | Prompt library + NES; tmux mux backend (`create = "split"` → real tmux pane). `<leader>aa` jumps into the agent pane (starts it if none), `<leader>ax` kills it, `<C-.>` focuses, `<Tab>` accepts suggestions when present. From inside the agent: exit the TUI or `C-a x` to close |

Completion is blink.cmp; formatting is conform (`<leader>cf`, also on save).
Fuzzy finding is fzf-lua — `<leader>ff` files, `<leader>fg` grep,
`<leader>/` current buffer, `<leader>fo` old files, `<leader><leader>` buffers,
plus `<leader>../` / `<leader>.../` parent-dir greps.

## Keybinding map

Leader is `<Space>`. `<leader>?` lists everything buffer-local; `<leader>fk`
searches all of them.

```
FILES        <leader>e Oil · <leader>ff files · <leader>fg grep · <leader>fc config
             <leader>fr resume · <leader>fo old · <leader><leader> buffers
             <leader>fs session picker · <leader>../ <leader>.../ dir greps
LSP          gd def · gr refs · gI impl · gD decl · <leader>D type def
             <leader>ds doc symbols · <leader>ws workspace symbols
             <leader>cr rename · <leader>ca code action · gl diagnostics float
FORMAT       <leader>cf format buffer
GIT          ]h [h hunk jump · <leader>hs stage · <leader>hr reset
             <leader>hp preview · <leader>hb blame · <leader>hd diffthis
             <leader>lg lazygit
REVIEW       :DiffviewOpen :HunkReview · ]c [c diff hunks
NAVIGATE     Ctrl-h/j/k/l nvim↔tmux panes · { } symbol prev/next
             ]m [m functions · ]] [[ classes · ]t [t todos · ]h [h hunks
TEXT OBJECTS af if function · ac ic class · ao comment · as scope
             <leader>a <leader>A swap params
UI           <leader>uT theme dark/light · <leader>ux sticky context · <leader>; breadcrumbs
             <leader>th inlay hints · <leader>o outline · <leader>tt terminal
MISC         <Esc> clear search · <leader>s scratchpad · <leader>ps push to scratchpad
             <leader>qs ql restore session · <leader>aa jump to agent pane · <leader>ax kill agent pane
```

## Nix contract

nvim assumes these come from your home-manager profiles, not Mason:

- shared (`home/tools.nix`): `nodejs` (Mason installs JS-based LSPs via npm),
  `tree-sitter` CLI (parser compilation)
- work profile: `dotnetAll` — SDKs 8+10 combined; 8 matches the org's pinned
  .NET target, 10 hosts the Roslyn server/csharpier. Roslyn launches via
  `dotnet <dll>` rather than Mason's prebuilt apphost (Nix glibc mismatch).
- add tools like `nixd` to Nix, then list them in `server_runtimes` if they're
  a language runtime

## Extending

- **New plugin**: drop a spec file in `lua/plugins/` named after it; prefer
  `opts = {}` unless the plugin has no setup (check its README first).
- **New LSP**: add to `servers` in lsp.lua (+ `server_runtimes` if it needs a
  toolchain); Mason installs it automatically.
- **New formatter**: add to conform's `formatters_by_ft`.
- **New keymap**: near-mine go beside their plugin spec; globals in
  `config/keymaps.lua`.
