{
  description = " Fast, encrypted, deduplicated backups in Rust — with friendly YAML config, a desktop GUI, and support for S3, custom REST and SFTP storage.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
          pname = "vykar";
          version = "0.12.7";

          src = pkgs.fetchFromGitHub {
            owner = "borgbase";
            repo = "vykar";
            tag = "v${finalAttrs.version}";
            hash = "sha256-YUAGVrUGye9LlMNCfkFbxFLR5Le9k7E6Vx/y5o66uCY=";
          };

          cargoLock.lockFile = finalAttrs.src + "/Cargo.lock";

          buildInputs = with pkgs; [
            glib
            gtk3
            libayatana-appindicator
            xdotool
          ];

          nativeBuildInputs = with pkgs; [
            fontconfig
            pkg-config
          ];
        });
      }
    );
}
