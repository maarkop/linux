{
  description = "System flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
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
        ./rutoken.nix
				./flutter.nix
				./gnome.nix
				./nvim.nix
				./zsh.nix
      ];
    };
  };
}
