## Installation

	git clone git://github.com/alexandremcosta/dotvim.git ~/.vim

	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc

	cd ~/.vim
	git submodule init
	git submodule update

## For proper airline fonts install powerline fonts

 - https://github.com/vim-airline/vim-airline/#integrating-with-powerline-fonts
 - On arch linux you can just install the powerline-fonts community package


## Add plugin

	cd ~/.vim
	git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
	git add .
	git commit -m "Install Fugitive.vim bundle as a submodule."

## Removing plugins
To remove `foo`

	cd ~/.vim
	git submodule deinit pack/plugins/start/foo
	git rm -r pack/plugins/start/foo
	rm -r .git/modules/pack/plugins/start/foo

## Mappings

- File explorer `\n`

- Ack  `\a`

- Ctrlp `<c-p>`

- Zoomwin `\f`

- Buffers `F5 <-` and `F6 ->`
