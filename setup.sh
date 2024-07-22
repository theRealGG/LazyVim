#!/usr/bin/env sh

echo "Installing and setting additional dependencies ..."

echo "CHECK additional dependencies"

if ! [ -e "$HOME/.local/share/eclipse/lombok.jar" ]; then
	echo "Make sure lombok is installed"
fi

echo "COPY of settings files: "
cp "$HOME/.config/nvim/formatting/prettierrc.yaml" "$HOME/.prettierrc.yaml"
