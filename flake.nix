{
  description = "Nix utility functions";

  outputs =
    { self }:
    {
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
        pythonVersion = version "tomlq" ".package.version";
      };

    };
}
