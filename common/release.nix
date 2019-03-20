latest:
let
  data = builtins.fromJSON (builtins.readFile latest);
  assetList = builtins.filter (p: builtins.match "^.*\.sha$" p.name == null) data.assets;
  prepareName = builtins.replaceStrings ["." " "] ["_" "_"];
  # toRec = i: { name = prepareName i.name; value = i; };
  toRec = i: { name = prepareName i.name; value = {
    url    = i.browser_download_url;
    sha256 = "$(nix-prefetch-url ${i.browser_download_url})";
  }; };
in
  {
    assets = builtins.listToAttrs (builtins.map toRec assetList);
    inherit data;
  }
