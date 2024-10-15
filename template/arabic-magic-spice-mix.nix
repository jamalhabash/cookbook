{
  pkgs ? import <nixpkgs> { },
}:

(import ./recipe-template.nix {
  inherit pkgs;
  version = "1.0";
  title = "Arabic Magic Spice Mix";
  author = "Jamal Habash";
  recipeYield = "1";
  prepTime = "10M";
  totalTime = "10M";
  date = "2024-10-10";
  description = "The \"use in everything spice mix\". Literally.";
  ingredients = [
    "1/2 Cup Allspice"
    "1/2 Cup Black Pepper"
    "1/2 Cup White Pepper"
    "1/2 Cup Cinnamon"
    "1/4 Cup Ginger"
    "1/4 Cup Cloves"
    "1/4 Cup Mace"
    "1/4 Cup Nutmeg"
  ];
  instructions = [
    "Mix all spices together. Store in airtight container, away from sunlight."
  ];
})
