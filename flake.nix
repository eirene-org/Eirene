{
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs =
    { nixpkgs, ... }:
    let
      forSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function (import nixpkgs { inherit system; })
        );
    in
    {
      devShells = forSystems (pkgs: {
        default = pkgs.mkShell {
          name = "eirene-wayland-shell";

          nativeBuildInputs = with pkgs; [
            bashInteractive
            nixd
            nixfmt-rfc-style

            zig_0_13
            zls
          ];
        };
      });
    };
}
