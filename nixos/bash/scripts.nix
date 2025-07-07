{ config } : let
	home = config.users.users.marko.home;
	nixHome = "${home}/.config/nixos";
in {
	environment.variables = {
		PATH = [ "$PATH" "${nixHome}/bash/" ];
	};
}
