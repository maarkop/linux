{
  description = "System flake";
  inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nvf.url = "github:notashelf/nvf";
  };
  outputs = { nix-flatpak, nixpkgs, nvf, ... } : {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
				nvf.nixosModules.default
				./hardware-configuration.nix
        ./configuration.nix
				./packages.nix
        ./network.nix
				./flutter.nix
				./gnome.nix
				./nvim.nix
				./zsh.nix
      ];
    };
  };
}
