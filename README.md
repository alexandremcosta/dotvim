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
	

## How to add plugin

	cd ~/.vim
	git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
	git add .
	git commit -m "Install Fugitive.vim bundle as a submodule."

## Mappings

- Ack  `\a`

- Ctrlp `&lt;c-p>`

- Emmet `<c-y>,`

- NERDTree `\n`

- Zoomwin `\f`
