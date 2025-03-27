{ config, pkgs, ... } : let
	androidHome =  "/opt/android-sdk/";
in {

	environment.variables = {
		EDITOR = "nvim";
		ANDROID_HOME = androidHome;
    JAVA_HOME = pkgs.openjdk17.home;
		CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
	};

	virtualisation.waydroid.enable = true;
	virtualisation.libvirtd.enable = true;
	boot.kernelModules = [ "kvm-amd" ];
	programs.nix-ld.enable = true;
	programs.adb.enable = true;

	systemd.services.android-sdk-setup = {
    description = "Install Android SDK components using sdkmanager (as root)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
				${pkgs.sdkmanager}/bin/sdkmanagerbuild-tools;34.0.0" \
				"tools" "platforms;android-34" "cmdline-tools;9.0" \
				"ndk-bundle;r28" "ndk;r28" "skiaparser;3"
      '';
			Environment = [ "ANDROID_HOME=${androidHome}" ];
    };
    preStart = '' mkdir -p ${androidHome} '';
  };
}
