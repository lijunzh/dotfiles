# ============================================================================
# Zsh Environment Variables
# ============================================================================
# This file is sourced on all shell invocations (login, interactive, scripts)
# Keep it minimal - only essential environment variables should go here

# ============================================================================
# XDG Base Directory Specification
# ============================================================================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# ============================================================================
# Local Customizations
# ============================================================================

# Source local environment configuration if it exists
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
