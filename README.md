# nix-koreader-mac

Nix flake for [KOReader](https://koreader.rocks) on macOS, a cross-platform reader.

Add to your home-manager/nix-darwin config like so:
```nix
inputs.gtimelog-mac = {
	url = "github:i-am-karan-singh/nix-koreader-mac";
	inputs.nixpkgs.follows = "nixpkgs";
};
# OR for flakehub
inputs.gtimelog-mac = {
	url = "https://flakehub.com/f/karan/nix-koreader-mac/0.1";
	inputs.nixpkgs.follows = "nixpkgs";
};
...
# AND
home.packages = [ 
	inputs.koreader-mac.packages.${pkgs.stdenv.hostPlatform.system}.default 
];
```

## Why does this flake exist?
On nixpkgs, koreader does not support darwin [build targets](https://github.com/NixOS/nixpkgs/blob/nixos-26.05/pkgs/by-name/ko/koreader/package.nix#L142). Same for homebrew. However, macOS packages for KOReader can be accessed as [artifacts](https://github.com/koreader/koreader/wiki/Installation-on-MacOS) on the koreader repo, sadly only available post github authentication.

Here we mirror those as releases via a github action. This is action is run manually for now, at least until macOS packages make it to the releases page on the koreader repo. This isn't so bad because koreader releases seem to follow a semiannual cadence.

## Other tips
If you are not a nix user, you can simply download the 7z file on the releases page for this repo, and extract the same to get .app.

The config is stored at `~/Library/Application Support/koreader/`, which seems to be usable for plugins too. This is nice because the app, although mutable, might be overwritten by home-manager/nix-darwin.
