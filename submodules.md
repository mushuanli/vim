# Using git-submodules to version-control Vim plugins
If you work across many computers (and even otherwise!), it's a good idea to keep a copy of your setup on the cloud, preferably in a git repository, and clone it on another machine when you need.
Thus, you should keep the `.vim` directory along with your `.vimrc` version-controlled.

But when you have plugins installed inside `.vim/bundle` (if you use [pathogen](https://github.com/tpope/vim-pathogen)), or inside `.vim/pack` (if you use Vim 8's packages), keeping a copy where you want to be able to update the plugins (individual git repositories), as well as your vim-configuration as a whole, requires you to use git submodules.

### Creating the repository
Initialize a git repository inside your `.vim` directory, add everything (including the vimrc), commit and push to a GitHub/BitBucket/GitLab repository:
```
cd ~/.vim
cp ~/.vimrc vimrc
git init
git add *
git commit -m "Initial commit."
git remote add origin https://github.com/username/reponame.git
git push -u origin master
```

To enable submodules:
```
cd ~/.vim
git submodule init
```

### Installing plugins
To install plugins (say always-loaded `foo` and optionally-loaded `bar`, located at `https://github.com/manasthakur/foo` and `https://github.com/manasthakur/bar`, respectively) using Vim 8's package feature:
```
git submodule add https://github.com/manasthakur/foo.git pack/plugins/start/foo
git submodule add https://github.com/manasthakur/bar.git pack/plugins/opt/bar
git commit -m "Added submodules."
```

### Replicating the repository on a machine
- Clone the repository (_recursively_ to clone plugins as well):

    ```
    git clone --recursive https://github.com/username/reponame.git
    ```
    
- Symlink `.vim` and `.vimrc`:

    ```
    ln -sf reponame ~/.vim
    ln -sf reponame/vimrc ~/.vimrc
    ```
    
- Generate helptags for plugins:
    ```
    vim
    :helptags ALL
    ```
    
### Removing plugins
To remove `foo`:
```
cd ~/.vim
git submodule deinit pack/plugins/start/foo
git rm -r pack/plugins/start/foo
rm -r .git/modules/pack/plugins/start/foo
```

### Updating plugins
To update `foo`:
```
cd ~/.vim/pack/plugins/start/foo
git pull origin master
```
It is recommended to first `git fetch origin master` a plugin, review changes, and then `git merge`.

To update all the plugins:
```
cd ~/.vim
git submodule foreach git pull origin master
```

Note that new commits to plugins create uncommitted changes in the main repository.
Thus, after any updates in the submodules, you need to commit the main repository as well:
```
cd ~/.vim
git commit -am "Updated plugins."
```

On another machine, if a `git pull` for the main repository leads to uncommitted changes in the submodules (as a few plugins got updated), perform `git submodule update` to change the recorded state of the submodules.

Even though slightly complicated, submodules are a necessary devil when you want to maintain an easily-cloneable `.vim` repository.
The other option is to _not_ version-control submodules at all by adding a line `pack` in `~/.vim/.gitignore`, and manually add plugins on a new machine.



作为一个四年的 neovim “老”用户，前段时间尝试从 neovim 迁移到了 vim 8 上。

迁移的原因是，neovim 的主要特性——异步 API ——已经在 vim 8 上实现了。其他的，比如作为一个组建内嵌到其他应用中，目前看来因为种种原因，很难达到理想的目标。将 VimScript 编译到 lua，然后通过内置的 lua 解释器来执行，来达到性能提升，这个目标也遥遥无期，似乎不会被实现了。

而 vim 因为 neovim 的刺激，加快了开发进度，这一年来新功能不断，一些在 neovim 中反馈良好的特性也“移植”了回来，比如最重要的异步 API，并且发布了 8.0 这个大版本。

并且 vim 8 中，也增加了更多 neovim 没有的功能，比如 :smile，以及内置的“包管理”功能。

不过 vim 钦点内置的这个包管理器，可能大家熟悉的 Vundle 或者 vim-plug 不太一样，用西方的那一套来形容，就是更 "na?ve" 一些。

实际上，vim 引入了一个新的 package 的概念，来实现包管理器。与之前 vim 的 plugin 概念不同的是，一个 package 是很多 plugin 的集合，一个包里的 plugin 之间可以有相互依赖关系。并且一个 package 只要放到指定目录中，vim 在启动的时候就可以自动加载它们（也可以选择启动之后再进行加载）。

使用
只要在 ~/.vim/pack 下创建一个新的目录，就可以作为一个 package 了。因为目前 vim 社区绝大部分插件，都是按照 plugin 的形式来组织的，所以目前想要在 package 系统中使用的话，我们需要自己创建一个 package，在其中管理需要的所有第三方 plugin。

所以可以先创建一个 ~/.vim/pack/myplugins 的目录，作为存放所有 plugin 的 package。myplugins 改成其他的也没有问题。接下来再在其中分别创建 start 和 opt 两个目录。

接下来的事情就比较简单了，将之前所有的第三方插件，一股脑丢到 ~/.vim/pack/myplugins/start 就可以，重新启动 vim 之后，就可以自动加载了。如果不想启动加载的插件，就丢到 ~/.vim/pack/myplugins/opt 里，需要用到的时候，执行 :packadd pluginname 就可以了。

管理
现在我们可以很容易发现，其实配合使用 git 的 submodule 功能，就可以很方便的添加/升级第三方插件，不再需要额外的第三方插件管理器了。

现在可以把整个 .vim 目录做成一个 git 仓库，然后通过 $ git submodule init 初始化 submodule。

接下来想要添加一个第三方插件，比如 ale，只要执行：

$ git submodule add https://github.com/w0rp/ale.git pack/myplugins/start/ale
升级所有第三方插件，只要执行：

$ git submodule update --recursive --remote
分享
使用 git 配合内置 vim 8 的包管理还有另外一个好处，现在想分享你的 vim 配置给别人，或者快速的在一台新机器上配置好 vim，只要简单的把仓库 clone 下来即可。比如想要使用我的 vim 配置：

$ git clone --recursive https://github.com/aisk/.vim.git ~/.vim 
