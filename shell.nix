# save this as shell.nix
{ pkgs ? import <nixpkgs> {}}:

let
	python-packages = ps: with ps; [
	];
in
pkgs.mkShell {
	packages = with pkgs; [ 
		(python311.withPackages python-packages)
		bash
		ruby
	];
}

