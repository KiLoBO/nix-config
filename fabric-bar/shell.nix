{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python311
    python311Packages.pip
    python311Packages.virtualenv
    
    # GTK and related dependencies
    gtk3
    cairo
    gtk-layer-shell
    libgirepository
    gobject-introspection
    gobject-introspection-runtime
    python311Packages.gobject3
    python311Packages.pycairo
    python311Packages.loguru
    pkg-config
  ];

  shellHook = ''
    echo "Fabric development environment ready!"
    echo "Create a virtual environment with: python -m venv venv"
    echo "Activate it with: source venv/bin/activate"
  '';
}
