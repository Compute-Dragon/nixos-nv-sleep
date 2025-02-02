{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1.0.tar.gz";

    hyprland.url = "https://flakehub.com/f/hyprwm/Hyprland/0.46.2.tar.gz";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
    in
    {
      inherit lib;

      nixosConfigurations = {
        # Main Desktop
        desktop = lib.nixosSystem {
          modules = [ ./desktop.nix ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];

    auto-optimise-store = true;
  };
}
