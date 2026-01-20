# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/monkeylang"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "monkeylang"; then
  new_window "editor"
  run_cmd "nvim"

  new_window "editor_finished"
  run_cmd "nvim ~/Projects/waiig_code_1.3"

  select_window 0
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
