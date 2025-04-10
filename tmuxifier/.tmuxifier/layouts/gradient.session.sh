# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/projects/gradient"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "gradient"; then
  new_window "editor"
  run_cmd "nvim"

  new_window "air templ tailwind"
  select_window 1
  run_cmd "cd website-server && make air"

  split_h
  run_cmd "cd website-server && make templ"

  split_h
  run_cmd "cd website-server && make tailwind"

  tmux select-layout even-horizontal

  new_window "db grader"
  select_window 2
  run_cmd "cd website-server && make db.start"

  split_h
  run_cmd "cd grader-server && make air"

  new_window "cms"
  select_window 3
  run_cmd "cd ../cms && nvim"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
