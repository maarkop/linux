{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	sdkHome = "${home}/.local/share";
	androidHome = "${sdkHome}/android-sdk";
	flutterHome = "${sdkHome}/flutter-sdk";
in {
	environment.variables = {
		ANDROID_HOME = androidHome;
    JAVA_HOME = pkgs.openjdk17.home;
		PATH = [ "$PATH" "${flutterHome}/bin/" ];
	};

	environment.systemPackages = with pkgs;[
		openjdk17 unzip firebase-tools
		steam-run waydroid sdkmanager
		clang cmake ninja pkg-config

    atk cairo libepoxy gdk-pixbuf
    glib gtk3 harfbuzz pango pcre
    udev alsa-lib glibc zip melos
	];

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
			User = config.users.users.marko.name;
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
