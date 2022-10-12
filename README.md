## Installation

	git clone git://github.com/alexandremcosta/dotvim.git ~/.vim

	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc

	cd ~/.vim
	git submodule init
	git submodule update

## Features
- Mouse support on OSX and Linux
- Cut/copy/paste support to system clipboard using vim commands on OSX `d, D, y, Y, p, P`
- Copy/paste support to system clipboard on Linux `<Leader>c` or `<Leader>v`
- Use `:SudoW` to write (save) file with sudo
- Return to last edit position when opening files
- Navigate split panels in normal mode with `Ctrl` + `hjkl`
- Move current line in insert/visual mode with `Ctrl` + `jk`
- Elixir support: elixir-ls, credo, `mix format` on save, go to function definition `dg`, hover function docs `dh`
- [Minimap](https://github.com/wfxr/minimap.vim)
- [Airline](https://github.com/vim-airline/vim-airline)

For proper airline fonts install powerline fonts.  
Check: https://github.com/vim-airline/vim-airline/#integrating-with-powerline-fonts  
On arch linux you can just install the `powerline-fonts` community package

## Other Keyboard Mappings
`<Leader>` key points to `\`.

| Feature | Keyboard Mapping |
|---|---|
| **Navigate** file explorer | `<Leader>n` |
| Search word/regex in **all** files (`brew install ripgrep`) | `<Leader>a` |
| Find file by **path** (or name) (requires ripgrep and `brew install fzf`) | `<Ctrl-p>` |
| On `fzf`, open file in **split** pane | `<Ctrl-s>` |
| On `fzf`, open file in **vertical** split pane | `<Ctrl-v>` |
| Minimap (`brew install code-minimap`) | `:Minimap` |
| Toggle current split pane **fullscreen** | `<Leader>f` |
| Run elixir **test** under cursor | `<Leader>t` |
| Run all elixir **tests** on current file | `<Leader>T` |
| Elixir **inspect**: paste `|> IO.inspect(label: "")` leaving cursor between quotes | `<Leader>i` |

## Add plugin
For example, the famous git plugin: `vim-fugitive`

	cd ~/.vim
	git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
	git add .
	git commit -m "Install Fugitive.vim bundle as a submodule."

## Remove plugin
To remove a plugin named `foo`

	cd ~/.vim
	git submodule deinit pack/plugins/start/foo
	git rm -r pack/plugins/start/foo
	rm -r .git/modules/pack/plugins/start/foo
