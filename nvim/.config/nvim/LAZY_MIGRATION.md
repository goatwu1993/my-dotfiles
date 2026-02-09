# Packer to Lazy.nvim Migration Guide

## What Changed

Your Neovim configuration has been migrated from Packer to Lazy.nvim.

### Files Modified
- `lua/peter_wu/init.lua` - Updated to load lazy instead of packer
- `lua/peter_wu/002_lazy.lua` - New lazy.nvim configuration (replaces 002_packer.lua)
- `lua/peter_wu/002_packer.lua.bak` - Backup of old packer config (can be deleted after verification)

### Files Unchanged
All your LSP configurations and plugin settings remain the same:
- `after/plugin/lsp.lua` - All LSP configurations preserved
- `after/plugin/telescope.lua` - Telescope keymaps preserved
- `after/plugin/colors.lua` - Rose Pine setup preserved
- `after/plugin/flash.lua` - Flash.nvim config preserved
- `after/plugin/autoformat.lua` - Auto-format settings preserved

## Installation Steps

1. **Remove Packer** (optional but recommended):
   ```bash
   rm -rf ~/.local/share/nvim/site/pack/packer
   ```

2. **Open Neovim**:
   ```bash
   nvim
   ```

3. **Lazy.nvim will auto-install** on first launch and install all plugins automatically.

4. **Verify installation**:
   - In Neovim, run `:Lazy` to open the Lazy.nvim UI
   - All plugins should be installed and loaded
   - Check `:checkhealth` to ensure everything is working

## Lazy.nvim Commands

- `:Lazy` - Open the Lazy.nvim UI
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - Profile plugin loading times
- `:Lazy health` - Check plugin health

## Benefits of Lazy.nvim

- **Faster startup** - Plugins are lazy-loaded by default
- **Better UI** - Modern, intuitive plugin manager interface
- **Active development** - Packer is no longer maintained
- **Built-in profiling** - Easily identify slow plugins
- **Automatic lazy-loading** - Plugins load only when needed

## Rollback (if needed)

If you need to rollback to Packer:

1. Restore the init.lua:
   ```bash
   cd ~/.config/nvim/lua/peter_wu
   # Edit init.lua to require 'peter_wu.002_packer' instead of 'peter_wu.002_lazy'
   ```

2. Restore packer config:
   ```bash
   mv 002_packer.lua.bak 002_packer.lua
   ```

3. Remove lazy:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm 002_lazy.lua
   ```

## Cleanup After Verification

Once you've verified everything works:

```bash
rm ~/.config/nvim/lua/peter_wu/002_packer.lua.bak
rm ~/.config/nvim/LAZY_MIGRATION.md
```
