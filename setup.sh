#!/usr/bin/env sh

NVIM_DIR="$HOME/.config/nvim"

echo "Installing and setting additional dependencies ..."

echo "CHECK required dependencies"

if ! command -v nvim >/dev/null 2>&1; then
	echo "Neovim not found install it manually"
	exit 1
fi

echo "CHECK additional dependencies"

if ! [ -e "$HOME/.local/share/eclipse/lombok.jar" ]; then
	echo "Make sure lombok is installed"
fi

echo "COPY of settings files: "
cp "$NVIM_DIR/formatting/prettierrc.yaml" "$HOME/.prettierrc.yaml"

echo "POST installation actions:"

if [ -e "$HOME/nvim" ]; then
	ln -s "$NVIM_DIR" nvim
else
	echo "nvim folder already exists skipping ..."
fi
