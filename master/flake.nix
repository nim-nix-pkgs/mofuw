{
  description = ''more faster, ultra performance webserver'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-mofuw-master.flake = false;
  inputs.src-mofuw-master.ref   = "refs/heads/master";
  inputs.src-mofuw-master.owner = "2vg";
  inputs.src-mofuw-master.repo  = "mofuw";
  inputs.src-mofuw-master.type  = "github";
  
  inputs."github-2vg-mofuparser".owner = "nim-nix-pkgs";
  inputs."github-2vg-mofuparser".ref   = "master";
  inputs."github-2vg-mofuparser".repo  = "github-2vg-mofuparser";
  inputs."github-2vg-mofuparser".dir   = "master";
  inputs."github-2vg-mofuparser".type  = "github";
  inputs."github-2vg-mofuparser".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-2vg-mofuparser".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github-2vg-mofuhttputils".owner = "nim-nix-pkgs";
  inputs."github-2vg-mofuhttputils".ref   = "master";
  inputs."github-2vg-mofuhttputils".repo  = "github-2vg-mofuhttputils";
  inputs."github-2vg-mofuhttputils".dir   = "master";
  inputs."github-2vg-mofuhttputils".type  = "github";
  inputs."github-2vg-mofuhttputils".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-2vg-mofuhttputils".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-mofuw-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-mofuw-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}