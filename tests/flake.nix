{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    gepetto-lib.url = "path:../.";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        {
          checks = {

            python = pkgs.runCommandLocal "python-test" { } ''
              parsed=${inputs.gepetto-lib.lib.pythonVersion pkgs ./pyproject.toml}
              expected="5.8.3"
              [ "$parsed" = "$expected" ] || {
                  echo "Python test failed: expected '$expected', got '$parsed'"
                  exit 1
              }
              touch $out
            '';

            ros = pkgs.runCommandLocal "ros-test" { } ''
              parsed=${inputs.gepetto-lib.lib.rosVersion pkgs ./package.xml}
              expected="8.3.5"
              [ "$parsed" = "$expected" ] || {
                  echo "ROS test failed: expected '$expected', got '$parsed'"
                  exit 1
              }
              touch $out
            '';

          };
        };
    };
}
