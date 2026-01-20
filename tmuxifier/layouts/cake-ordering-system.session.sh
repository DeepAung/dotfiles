# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/cake-ordering-system"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "cake-ordering-system"; then

  # Create a new window inline within session layout definition.
  new_window "editor"
  run_cmd "nvim"

  new_window "be_process"
  select_window 1
  run_cmd "cd backend && make up-deps"

  split_h
  run_cmd "cd backend && make up"

  tmux select-layout even-horizontal

  new_window "fe_process"
  select_window 2
  run_cmd "cd frontend && pnpm run dev"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
