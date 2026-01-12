.PHONY: python_deps sway system_deps dir_deps setup_vundle vimrc stow setup_plugins

all: system_deps sway dir_deps setup_vundle stow setup_plugins

python_deps:
	@echo "Installing python dependencies..."
	pip3 install -r requirements.txt --user

system_deps:
	sudo apt update && \
	sudo apt install -y \
		exuberant-ctags \
		python3-neovim \
		python3-mypy \
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
		alacritty

dir_deps:
	@echo "Creating .vim directories..."
	mkdir -p ~/.vim/backup
	mkdir -p ~/.vim/swap
	mkdir -p ~/.vim/undo

setup_vundle:
	@echo "Setup up Vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
		|| exit 0

vimrc:
	@echo "Copying .vimrc file..."
	install -m 755 .vimrc ~/o

stow:
	stow -vv .

setup_plugins:
	@echo "Installing plugins..."
	vim +PluginInstall +qall
