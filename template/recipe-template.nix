{
  pkgs ? import <nixpkgs> { },
  name,
  version,
  date,
  title,
  author,
  recipeYield,
  prepTime,
  totalTime,
  description,
  ingredients,
  instructions,
}:

pkgs.stdenv.mkDerivation {
  inherit version;
  pname = name;

  recipefile = builtins.toFile "file" ''
    ---

    layout: default
    date: ${date}
    title: ${title}
    author: ${author} 
    tags: [vegan]
    description: ${description}
    image: ""

    schemadotorg:
      "@context": http://schema.org/
      "@type": Recipe
      name: ${title} 
      author:
        "@type": Person
        name: ${author}
      description: ${description} 
      datePublished: "${date}T12:00:00+00:00"
      image: [""]
      recipeYield: ["${recipeYield}"]
      prepTime: "${prepTime}"
      totalTime: "${totalTime}"
      recipeIngredient: [ "${(pkgs.lib.concatStringsSep "\", \"" ingredients)}" ]
      recipeInstructions:
        - "@type": HowToStep
          text: "First instruction."
          name: "First instruction."
        ${
          pkgs.lib.concatStringsSep "\n    " (
            builtins.map (x: "- \"@type\": HowToStep\n      text: \"${x}\"\n      name: \"${x}\"") instructions
          )
        }
      aggregateRating:
        - "@type": AggregateRating
          ratingValue: 4.9
          ratingCount: 1
      recipeCategory: ["Vegan"]
      recipeCuisine: ["Vegan"]
      keywords: "${title}"
      "@id": "https://jamalhabash.ca/${
        (pkgs.lib.strings.toLower (pkgs.lib.strings.stringAsChars (x: if x == " " then "-" else x) name))
      }"

    ---
    # ${title} 

    ## Ingredients

    - ${(pkgs.lib.concatStringsSep "\n- " ingredients)}

    [ "${(pkgs.lib.concatStringsSep "\", \"" ingredients)}" ]
    ## Directions

    ${
      (pkgs.lib.concatStringsSep "\n" (
        pkgs.lib.lists.imap1 (i: list: "${builtins.toString i}. ${list}") instructions
      ))
    }
  '';

  installPhase = ''
    mkdir -p $out  
    cp $recipefile $out/${
      (pkgs.lib.strings.toLower (pkgs.lib.strings.stringAsChars (x: if x == " " then "-" else x) name))
    }.md
  '';

  dontUnpack = true;
  dontBuild = true;
}
