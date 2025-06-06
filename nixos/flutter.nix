{ config, pkgs, ... } : let 
  home = config.users.users.marko.home;
	androidDir = "${home}/.local/share/android-sdk";
in {
	environment.variables = {
    JAVA_HOME = pkgs.openjdk17.home;
    ANDROID_HOME = androidDir;
	};

	environment.systemPackages = (with pkgs;[
		openjdk17 unzip firebase-tools
		steam-run sdkmanager clang cmake
    ninja pkg-config flutter332

    #Debatable
    udev alsa-lib
    atk cairo libepoxy gdk-pixbuf
    glib gtk3 harfbuzz pango pcre
    glibc zip
	]);

	virtualisation.waydroid.enable = true;
	virtualisation.libvirtd.enable = true;
	boot.kernelModules = [ "kvm-amd" ];
	programs.nix-ld.enable = true;
	programs.adb.enable = true;
  
  #ANDROID SDK ISNT IMMUTABLE >:(
  systemd.services.android-sdk-setup = {
    description = "Install Android SDK components using sdkmanager";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
			Environment = [ "ANDROID_HOME=${androidDir}" ];
			User = "${config.users.users.marko.name}";
    };
    preStart = ''mkdir -p ${androidDir}'';
		script = ''
				${pkgs.sdkmanager}/bin/sdkmanager "platforms;android-34" \
				"build-tools;34.0.0" "ndk-bundle;r28" "platform-tools" \
				"skiaparser;3" "tools" "cmdline-tools;9.0" "ndk;r28"
		'';
  };
}
