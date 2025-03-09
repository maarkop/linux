function fish_greeting
    echo Hello (set_color yellow)(date +%T)(set_color normal) :P(set_color green)
end

function flutter
		steam-run flutter $argv
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
