{ config, pkgs, ... } : {

	programs.adb.enable = true;

	system.userActivationScripts = {
		stdio = {
			text = ''
				rm -f ~/Documents/Dev/SDK/Android/platform-tools/adb
				ln -s /run/current-system/sw/bin/adb ~/Documents/Dev/SDK/Android/platform-tools/adb

				rm -f ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/cmake
				ln -s /run/current-system/sw/bin/cmake ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/cmake

				rm -f ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/cpack
				ln -s /run/current-system/sw/bin/cpack ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/cpack

				rm -f ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/ctest
				ln -s /run/current-system/sw/bin/ctest ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/ctest

				rm -f ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/ninja
				ln -s /run/current-system/sw/bin/ninja ~/Documents/Dev/SDK/Android/cmake/3.22.1/bin/ninja

				rm -f ~/Documents/Dev/SDK/Android/ndk/23.1.7779620/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++
				ln -s /run/current-system/sw/bin/clang++ ~/Documents/Dev/SDK/Android/ndk/23.1.7779620/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++
			'';
			deps = [];
		};
	};
}
