{
  description = "Flakes file";

  inputs = {
	nixpkg.url = "nixpkgs/nixos-unstable";
	home-manager = {
	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
  };


  outputs = { nixpkgs, home-manager, ...}: {
	nixosConfigurations.rdwp = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [
		./configuration.nix
		home-manager.nixosModules.home-manager
		{
		  home-manager = {
		    useGlobalPkgs = true;
		    useUserPackages = true;
		    users.rdwp = import ./home.nix;
		  };
		}
	  ];
 	};
  };
}
