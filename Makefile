.PHONY: sway system_deps dir_deps setup_vundle vimrc stow setup_plugins

all: system_deps stow

system_deps:
	sudo apt update && \
	sudo apt install -y \
		exuberant-ctags \
		ripgrep \
		fd-find \
		tree-sitter-cli \
		stow

sway:
	sudo apt update && \
	sudo apt install -y \
		sway \
		swaylock \
		swayidle \
		sway-backgrounds \
		waybar \
		xwayland \
		rofi \
		alacritty \
		grim \
		slurp

stow:
	stow -vv .
