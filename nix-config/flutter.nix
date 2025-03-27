{ config, pkgs, ... } : let
	androidHome = "/home/marko/Documents/Dev/SDK/Android";
in {

	environment.variables = {
		EDITOR = "nvim";
		DOCS = "/home/marko/Documents";
		CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
    JAVA_HOME = "${pkgs.openjdk17.home}";
		ANDROID_HOME = "${androidHome}";
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
      ExecStart = ''
        ${pkgs.sdkmanager}/bin/sdkmanager "platform-tools" "build-tools;34.0.0" "platforms;android-34" "cmdline-tools;9.0" "ndk-bundle;r28" "ndk;r28" "tools" "skiaparser;3"
      '';
      User = "${config.users.users.marko.name}";
			Environment = [
        "ANDROID_HOME=${androidHome}"
      ];
    };
    preStart = '' mkdir -p ${androidHome} '';
  };
}
