{
  description = "Nix utility functions";

  outputs = _: {
    lib = rec {
      version =
        bin: path: pkgs: file:
        pkgs.lib.trim (
          builtins.readFile (
            pkgs.runCommandLocal "version" {
              nativeBuildInputs = [ pkgs.yq ];
            } "${bin} -r ${path} ${file} > $out"
          )
        );
      rosVersion = version "xq" ".package.version";
      pythonVersion = version "tomlq" ".project.version";
    };
  };
}
