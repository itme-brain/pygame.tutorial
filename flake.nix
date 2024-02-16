{
  description = "Pygame Tutorial Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    py = pkgs.python310Packages;
  in
  {
  packages.${system}.default = with pkgs;
    mkShell {
      buildInputs = with pkgs; [
        # Python interpreter + venv
        py.python
        py.venvShellHook

        #SDL lib
        SDL2
        SDL2_mixer
        SDL2_image
        SDL2_ttf

        # utils
        pkg-config
        portmidi
        git

        # convert to bitmaps
        imagemagick

        # base-devel
        autoconf
        automake
        binutils
        bison
        debugedit
        fakeroot
        file
        findutils
        flex
        gawk
        gcc
        gettext
        gnugrep
        groff
        gzip
        libtool
        gnum4
        gnumake
        patch
        pkgconf
        gnused
        sudo
        texinfo
        which
      ];
      venvDir = "./.venv";
      postVenvCreation = ''
        unset SOURCE_DATE_EPOCH
        pip install -r requirements.txt --no-binary :all:
      '';
      postShellHook = ''
        unset SOURCE_DATE_EPOCH
        export SDL_VIDEODRIVER=$(echo $XDG_SESSION_TYPE)
      '';
    };
  };
}
