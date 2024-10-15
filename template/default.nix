{ pkgs ? import <nixpkgs> {} }: pkgs.stdenv.mkDerivation {  
  pname = "recipes";
  version = "0.1";  
  
  recipes = [
    (pkgs.callPackage ./arabic-magic-spice-mix.nix {})
  ];

  installPhase = ''  
    mkdir -p $out  
  
    # Copy the outputs from the other derivations  
    for recipe in $recipes; do
      cp -r $recipe/* $out/
    done
  '';  
  
  # read about phases here: https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
  # since you don't have a source, you need to say dontUnpack otherwise you will get an error
  dontUnpack = true;  
  
  # turn off other phases that aren't being used
  dontPatch = true;
  dontConfigure = true; 
  dontFixup = true;
  dontBuild = true;
}  

