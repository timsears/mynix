# Stuff your dev environment might need. The idea is to manage your dev environment similar to /etc/nixos/configuraion.nix
# Install all with
# $> nix-env -f dev.nix -i
# Install only browsers (or another attribute) with
# $> nix-env -f dev.nix -iA browsers

with import <nixpkgs> {};
let flatten = recurseIntoAttrs; # allows nested records to look like one flat record at install time.
    myEmacsPkgs = flatten (
    with emacs24Packages;
    #{ inherit colorTheme magit haskellMode structuredHaskellMode emacsw3m gitModes org2blog org ; }
    { inherit magit org2blog org ; }
    );
    utils = flatten ( { inherit ack curl wget gnumake w3m;}
              //  {mygit = gitAndTools.gitFull; }
              );
    nixUtils = flatten { inherit nix-repl; };
    browsers = flatten { inherit chromium firefox; };
    editors = flatten { emacs = emacs24; };
    otherHaskell = flatten (with haskellPackages; { inherit hasktags hindent; });
    haskell = flatten (with haskellPackages; { inherit ghc haskellPackages; });
in flatten {inherit utils  nixUtils  browsers  editors  myEmacsPkgs otherHaskell  haskell;}
