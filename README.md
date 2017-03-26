![https://github.com/nobe4/SansBullshitSans.vim/blob/master/head.jpg](https://github.com/nobe4/SansBullshitSans.vim/blob/master/head.jpg)

# Huh?

Do you know [SansBullshitSans](http://www.sansbullshitsans.com/)?
It changed my life, seriously.

One problem though, this font is not really developer friendly.

Introducing 

# Sans Bullshit Sans .vim 

(that's Sans Bullshit Sans "dot" vim)

This is a concealing plugin that will remove all the bullshit language.

![Demo!](https://media.giphy.com/media/uoNSJpsqWPs1a/giphy.gif)

# How does it work ?

Vim `:h conceal` allows to hide/replace pattern of texts as part of the syntax definition. This is massively used for enhancing the coding experience on verbose languages:

- [calebsmith/vim-lambdify](https://github.com/calebsmith/vim-lambdify)
- [enomsg/vim-haskellConcealPlus](https://github.com/enomsg/vim-haskellConcealPlus)
- [plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown#syntax-concealing)

Here I use it to replace some words by others.

Bare in mind this is not what conceal is used for!

Basically, I create a maching like so:


    agile  a g i le
    |      | | | |
    v      v v v v
    b.s.   b . s .

And the following syntax will roughly be applied:

    syntax match GroupName1 contained 'a' conceal cchar=b
    ...
    syntax match GroupName4 contained 'le' conceal cchar=.

    syn match /agile/ contains=GroupName1,GroupName2,GroupName3,GroupName4

And now when you type 'agile' anywhere, a beautiful 'b.s.' will appear instead.

# Help!

If it doesn't work, if it crashes, if emacs launches, ...

This is not what conceal are used for, don't take it too seriously.

# Contributing

... Serioulsy? Don't you have anything interesting to do?

(I accept issues and pull requests)

# License

- [Picture Credits](https://unsplash.com/search/bull?photo=9uOasewOoXc)
- [SansBullshitSans Inspiration](http://www.sansbullshitsans.com/)
- [MIT License for this project](https://github.com/nobe4/SansBullshitSans.vim/blob/master/LICENSE)
