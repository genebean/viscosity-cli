{
  description = "A CLI for controlling Viscosity VPN connections on macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          viscosity-cli = pkgs.buildGoModule {
            pname = "viscosity-cli";
            version = "0.1.0";

            src = ./.;

            vendorHash = null;

            meta = {
              description = "A CLI for controlling Viscosity VPN connections on macOS";
              homepage = "https://github.com/danielbooth-cloud/viscosity-cli";
              license = pkgs.lib.licenses.mit;
              platforms = pkgs.lib.platforms.darwin;
              mainProgram = "viscosity-cli";
            };
          };

          default = self.packages.${system}.viscosity-cli;
        };
      }
    );
}

