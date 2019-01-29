# SICP Walkthrough

This repo is considerably less organized than what one might expect from someone
else working through SICP. Notably, I just write stuff in neovim and send it to
the racket interpreter.

I installed racket, and then mapped this alias, because racket has a plugin
designed specifically to work with sicp's version of scheme. Just running this
the first time might take a minute, because it will automatically download the
plugin.

    alias racket='racket -i -p neil/sicp -l xrepl'

I started using tmux for the purpose of this tutorial, and am already liking it.
It makes the terminal REPL/IDE thing work really well with neovim, in contrast
to `:terminal`.

I also added 4 pretty awesome plugins for this whole thing. They work pretty
well.

I built up this awesome tooling from [this tutorial][0]. You can copy this stuff
if you like. (I'm using Vundle, btw, for neovim plugins.)

Anyway, it's working pretty awesome. And lisp is fascinating. Much more
interesting than C, which I'll eventually have to go back to learning.

# For neovim

    Plugin 'christoomey/vim-tmux-navigator'     " Navigate tmux sessions with vim panes
    Plugin 'losingkeys/vim-niji'                " rainbow parentheses for lisp
    Plugin 'sjl/tslime.vim'                     " tslime for repl ide feel
    Plugin 'vim-scripts/paredit.vim'            " paredit for parentheses thingies

    autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt    " better lisp indenting

    let maplocalleader="\,"

    " tslime {{{
    let g:tslime_ensure_trailing_newlines = 1
    let g:tslime_normal_mapping = '<localleader>t'
    let g:tslime_visual_mapping = '<localleader>t'
    let g:tslime_vars_mapping = '<localleader>T'
    " }}}

---
# For tmux

    ### Smart pane switching with awareness of Vim splits.
    # See: https://github.com/christoomey/vim-tmux-navigator
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
    bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
    bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
    bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
    bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
    bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
    bind-key -T copy-mode-vi C-h select-pane -L
    bind-key -T copy-mode-vi C-j select-pane -D
    bind-key -T copy-mode-vi C-k select-pane -U
    bind-key -T copy-mode-vi C-l select-pane -R
    bind-key -T copy-mode-vi C-\ select-pane -l

---

# How I got here
All this makes it seem like I came to this set up pretty immediately. Believe
me, I did not. I followed a similar route to the guy in that tutorial. He says,
specifically:

> MIT Scheme was the first interpreter I tried, figuring that it would be the
> best option for working on exercises in an MIT textbook. I believe it’s the
> version of Scheme Abelman and Sussman used in their lectures. However, while
> there’s nothing especially wrong with it, there’s not much to recommend it
> either. At least in the homebrew version I’m using, I was unable to compile in
> the readline support I wanted, so I promptly moved on to something else.

I can explicitly say that `mit-scheme` is a nightmare for a vim user. It's all
built on emacs, or, rather `edwin` which is some kind of an alternate universe
emacs that is pretty much the same as emacs bu less capable. How on earth do
emacs users navigate as fast as vim users with `C-f`, `C-b`, `C-n`, and `C-p`?
This seems like a nightmare. As soon as I realized that was the primary way of
incremental navigation I abandoned it and googled `sicp vim` and found a link to
a link to that tutorial. Believe me, if you're a vim user, take a look at it.

[0]: https://crash.net.nz/posts/2014/08/configuring-vim-for-sicp/
