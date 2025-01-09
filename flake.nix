{
  description = "Nix flake for Mullvad's wgephemeralpeer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    packages.x86_64-linux.wgephemeralpeer = pkgs.buildGoModule {
      name = "wgephemeralpeer";
      version = "1.0.5";

      src = ./.; 
      vendorHash = null;

      subPackages = [ "./cmd/mullvad-upgrade-tunnel" ];

      meta = with pkgs.lib; {
        description = "Mullvad's post-quantum-secure WireGuard tunnels tool";
        license = licenses.gpl3;
        maintainers = [ maintainers.maatteogekko ];
        platforms = platforms.linux;
      };
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.wgephemeralpeer;
  };
}
