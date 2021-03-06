{
  description = ''mofuw is *MO*re *F*aster, *U*ltra *W*ebserver'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."mofuw-devel".dir   = "devel";
  inputs."mofuw-devel".owner = "nim-nix-pkgs";
  inputs."mofuw-devel".ref   = "master";
  inputs."mofuw-devel".repo  = "mofuw";
  inputs."mofuw-devel".type  = "github";
  inputs."mofuw-devel".inputs.nixpkgs.follows = "nixpkgs";
  inputs."mofuw-devel".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."mofuw-master".dir   = "master";
  inputs."mofuw-master".owner = "nim-nix-pkgs";
  inputs."mofuw-master".ref   = "master";
  inputs."mofuw-master".repo  = "mofuw";
  inputs."mofuw-master".type  = "github";
  inputs."mofuw-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."mofuw-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}