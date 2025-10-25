# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/projects/spaceship-asteroids-multiplayer/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "spaceship-asteroids-multiplayer"; then
  new_window "editor"
  run_cmd "nvim"

  new_window "rust"
  select_window 1
  run_cmd "cd rust && bacon build"

  new_window "godot"
  select_window 2
  run_cmd "cd godot && godot project.godot"

  new_window "terminal"
  select_window 3
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
