# nix-lib

```nix
inputs = {
  gepetto-lib.url = "github:Gepetto/nix-lib";
};
```

## Get version from local files

### Python `pyproject.toml`

```nix
version = inputs.gepetto-lib.lib.pythonVersion pkgs ./pyproject.toml;
```
### ROS `package.xml`

```nix
version = inputs.gepetto-lib.lib.rosVersion pkgs ./package.xml;
```
