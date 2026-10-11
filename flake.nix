{
	description = "koreader on macOS";

	inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

	outputs = { nixpkgs, ... }: let
		system = "aarch64-darwin";
		pkgs = nixpkgs.legacyPackages.${system};
		source = import ./source.nix;
	in {
		packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
			pname = "koreader-mac";
			inherit (source) version;

			nativeBuildInputs = [ pkgs.p7zip ];
			src = pkgs.fetchurl {
				inherit (source) url hash;
			};

			dontUnpack = true;

			installPhase = ''
				runHook preInstall

				mkdir -p "$out/Applications"
				7z x "$src" -o"$out/Applications"

				runHook postInstall
			'';
		};
	};
}
