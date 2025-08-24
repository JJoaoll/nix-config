{ keymaps, lib }:

let 
  xcompose_k_reprs = {
    "`"  = "<grave>";  
    "~"  = "<asciitilde>";  
    "!"  = "<exclam>";  
    "@"  = "<at>";  
    "#"  = "<numbersign>";  
    "$"  = "<dollar>";  
    "%"  = "<percent>";  
    "^"  = "<asciicircum>";  
    "&"  = "<ampersand>";  
    "*"  = "<asterisk>";  
    "("  = "<parenleft>";  
    ")"  = "<parenright>";  
    "-"  = "<minus>";  
    "_"  = "<underscore>";  
    "="  = "<equal>";  
    "+"  = "<plus>";  
    "\"" = "<quotedbl>";  
    "'"  = "<apostrophe>";  
    "/"  = "<slash>";  
    "?"  = "<question>";  
    "\\"  = "<backslash>"; 
    "["  = "<bracketleft>";  
    "]"  = "<bracketright>"; 
    "{"  = "<braceleft>"; 
    "}"  = "<braceright>"; 
    "|"  = "<bar>"; 
    "<"  = "<less>"; 
    ">"  = "<greater>"; 
    ","  = "<comma>"; 
    "."  = "<period>"; 
    ":"  = "<colon>"; 
    ";"  = "<semicolon>"; 
    " "  = "<space>"; 
  };

  xcompose_k_greek_reprs = {
    "Α" = "<Greek_ALPHA>"; 
    "Β" = "<Greek_BETA>"; 
    "Γ" = "<Greek_GAMMA>"; 
    "Δ" = "<Greek_DELTA>"; 
    "Ε" = "<Greek_EPSILON>"; 
    "Ζ" = "<Greek_ZETA>"; 
    "Η" = "<Greek_ETA>"; 
    "Θ" = "<Greek_THETA>"; 
    "Ι" = "<Greek_IOTA>"; 
    "Κ" = "<Greek_KAPPA>"; 
    "Λ" = "<Greek_LAMBDA>"; 
    "Μ" = "<Greek_MU>"; 
    "Ν" = "<Greek_NU>"; 
    "Ξ" = "<Greek_KSI>"; 
    "Ο" = "<Greek_OMICRON>"; 
    "Π" = "<Greek_PI>"; 
    "Ρ" = "<Greek_RHO>"; 
    "Σ" = "<Greek_SIGMA>"; 
    "Τ" = "<Greek_TAU>"; 
    "Υ" = "<Greek_UPSILON>"; 
    "Φ" = "<Greek_PHI>"; 
    "Χ" = "<Greek_CHI>"; 
    "Ψ" = "<Greek_PSI>"; 
    "Ω" = "<Greek_OMEGA>"; 
    "α" = "<Greek_alpha>"; 
    "β" = "<Greek_beta>"; 
    "γ" = "<Greek_gamma>"; 
    "δ" = "<Greek_delta>"; 
    "ε" = "<Greek_epsilon>"; 
    "ζ" = "<Greek_zeta>"; 
    "η" = "<Greek_eta>"; 
    "θ" = "<Greek_theta>"; 
    "ι" = "<Greek_iota>"; 
    "κ" = "<Greek_kappa>"; 
    "λ" = "<Greek_lambda>"; 
    "μ" = "<Greek_mu>"; 
    "ν" = "<Greek_nu>"; 
    "ξ" = "<Greek_ksi>"; 
    "ο" = "<Greek_omicron>"; 
    "π" = "<Greek_pi>"; 
    "ρ" = "<Greek_rho>"; 
    "σ" = "<Greek_sigma>"; 
    "τ" = "<Greek_tau>"; 
    "υ" = "<Greek_upsilon>"; 
    "φ" = "<Greek_phi>"; 
    "χ" = "<Greek_chi>"; 
    "ψ" = "<Greek_psi>"; 
    "ω" = "<Greek_omega>"; 
  };

  xcompose_v_reprs = {
    "\"" = ''\"'';
    "\\" = ''\\'';
  };
  
  adapt = 
    mapset: str: 
    if lib.hasAttr str mapset
      then mapset.${str} 
      else str;

  convert = keymap: 
    let
      rep = if builtins.hasAttr "rep" keymap then keymap.rep else 2;
      keymap_str = with lib; 
        pipe keymap.seq 
          [ strings.stringToCharacters 
            (map (adapt xcompose_k_reprs))
            (map (adapt xcompose_k_greek_reprs))
            (map (adapt xcompose_v_reprs))
            (map (c: "<" + c + ">")) 
            lib.strings.concatStrings
          ]; 
    in 
      lib.strings.replicate rep "<Multi_key>"
      + keymap_str + "<space> : \"" + keymap.out + "\"";
in 
  with lib; pipe keymaps [
    (map convert)
    lib.strings.concatLines
  ] 
