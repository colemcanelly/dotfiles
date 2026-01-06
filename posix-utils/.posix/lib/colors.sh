
# ==================== COLORS ====================
# ANSI color codes
function red() { printf "\e[31m"; }
function green() { printf "\e[32m"; }
function yellow() { printf "\e[33m"; }
function blue() { printf "\e[34m"; }
function magenta() { printf "\e[35m"; }
function cyan() { printf "\e[36m"; }

function light_red() { printf "\e[91m"; }
function light_green() { printf "\e[92m"; }
function light_yellow() { printf "\e[93m"; }
function light_blue() { printf "\e[94m"; }
function light_magenta() { printf "\e[95m"; }
function light_cyan() { printf "\e[96m"; }

function bold() { printf "\e[1m"; }
function small() { printf "\e[2m"; }
function underline() { printf "\e[4m"; }
function reset() { printf "\e[0m"; }
