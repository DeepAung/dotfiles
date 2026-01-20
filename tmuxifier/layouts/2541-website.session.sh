# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/2541-website"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "2541-website"; then

  new_window "editor"
  run_cmd "nvim"

  new_window "process"
  select_window 1
  run_cmd "pnpm run db:up"

  split_h
  run_cmd "pnpm run dev"

  new_window "lazygit"
  select_window 2
  run_cmd "lazygit"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
