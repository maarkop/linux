{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	sdkHome = "${home}/.local/share";
	androidHome = "${sdkHome}/android-sdk";
	flutterHome = "${sdkHome}/flutter-sdk";
in {

	environment.variables = {
		EDITOR = "nvim";
		ANDROID_HOME = androidHome;
    JAVA_HOME = pkgs.openjdk17.home;
		CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
		PATH = [
			"$PATH"
			"${flutterHome}/bin/"
		];
	};

	virtualisation.waydroid.enable = true;
	virtualisation.libvirtd.enable = true;
	boot.kernelModules = [ "kvm-amd" ];
	programs.nix-ld.enable = true;
	programs.adb.enable = true;

	systemd.services.android-sdk-setup = {
    description = "Install Android SDK components using sdkmanager";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
			Environment = [ "ANDROID_HOME=${androidHome}" ];
			User = "${config.users.users.marko.name}";
    };
    preStart = ''mkdir -p ${androidHome}'';
		script = ''
				if [ ! -d "${flutterHome}" ]; then
					${pkgs.git}/bin/git clone https://github.com/flutter/flutter.git ${flutterHome}
				fi
				${pkgs.sdkmanager}/bin/sdkmanager "platforms;android-34" \
				"build-tools;34.0.0" "ndk-bundle;r28" "platform-tools" \
				"skiaparser;3" "tools" "cmdline-tools;9.0" "ndk;r28"
		'';
  };
}
