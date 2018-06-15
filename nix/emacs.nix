{ pkgs ? import <nixpkgs> {} }:


let
  myEmacs = pkgs.emacs;
  # myEmacs = (pkgs.emacs.override {
  #   # Use gtk3 instead of the default gtk2
  #   withGTK3 = true;
  #   withGTK2 = false;
  # }).overrideAttrs (attrs: {
  #   # I don't want emacs.desktop file because I only use
  #   # emacsclient.
  #   postInstall = (attrs.postInstall or "") + ''
  #     rm $out/share/applications/emacs.desktop
  #   '';
  # });

  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;

in
  emacsWithPackages (epkgs: with epkgs; [
    # use-package diminish bind-key
    # rainbow-delimiters smartparens
    evil-surround evil-indent-textobject evil-cleverparens avy undo-tree
    helm
    magit
    # git-timemachine
    # /* LaTeX */ auctex helm-bibtex cdlatex
    # markdown-mode
    # flycheck
    # pkgs.ledger
    # yaml-mode
    # company
    # /* Haskell */ haskell-mode flycheck-haskell
    # /* Org */ org org-ref
    # rust-mode cargo flycheck-rust
    # /* mail */ notmuch messages-are-flowing
    # /* Nix */ pkgs.nix nix-buffer
    spaceline # modeline beautification
    zerodark-theme
    # winum eyebrowse # window management
    # auto-compile
    # /* Maxima */ pkgs.maxima
    # visual-fill-column
    # melpaStablePackages.idris-mode helm-idris
  ])
