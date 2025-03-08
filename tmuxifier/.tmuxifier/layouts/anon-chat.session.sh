# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/projects/anon-chat"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "anon-chat"; then
  window_root "~/projects/anon-chat"

  # Create a new window inline within session layout definition.
  new_window "editor"
  run_cmd "nvim"

  new_window "terminals"
  select_window 1
  run_cmd "make air"

  split_h
  run_cmd "make templ"

  split_h
  run_cmd "make tailwind"

  tmux select-layout even-horizontal
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
