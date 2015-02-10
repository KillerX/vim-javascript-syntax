# Enhanced Demandware Script Syntax for Vim

### Credits
- Jose Elera Campana (Who created the JS syntax this is based on)
- Zhao Yi, Claudio Fleiner, Scott Shattuck (This file is based on their hard work)
- gumnos (From the #vim IRC Channel in Freenode) (Who helped me figured out the
  crazy Vim Regexes)

### Description
This file is a fork of [this repo](https://github.com/jelera/vim-javascript-syntax)

This version of this file features the following text highlights:

- Parenthesis, curly and regular brackets.
- The semicolon or comma at the end of line.
- Operation, comparison and logical symbols (`=`,`==`,`===`,`!=`,etc.).
- Separate highlight of the arguments. Thanks to [Billychan](https://github.com/jelera/vim-javascript-syntax/commit/b03f40ff6ddf605ac146634a651632d6c1e8a50b).
- Highlighting of types when a variable is defined and in function returns and args
- Highlighting of DW keywords in comments

### Installation
- Using [Vundle](https://github.com/gmarik/vundle),
  add this line to your `.vimrc`

```vim
Plugin 'killerx/vim-javascript-syntax'
```

- Using [Pathogen](https://github.com/tpope/vim-pathogen),
  run this command in your shell

```bash
git clone https://github.com/killerx/vim-javascript-syntax.git ~/.vim/bundle/vim-javascript-syntax
```
### Contributions
Always welcome

###  Screenshots
![Screenshot](scr.png)

### License
The same as Vim
