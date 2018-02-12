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



��Ϊһ������� neovim ���ϡ��û���ǰ��ʱ�䳢�Դ� neovim Ǩ�Ƶ��� vim 8 �ϡ�

Ǩ�Ƶ�ԭ���ǣ�neovim ����Ҫ���ԡ����첽 API �����Ѿ��� vim 8 ��ʵ���ˡ������ģ�������Ϊһ���齨��Ƕ������Ӧ���У�Ŀǰ������Ϊ����ԭ�򣬺��Ѵﵽ�����Ŀ�ꡣ�� VimScript ���뵽 lua��Ȼ��ͨ�����õ� lua ��������ִ�У����ﵽ�������������Ŀ��Ҳңң���ڣ��ƺ����ᱻʵ���ˡ�

�� vim ��Ϊ neovim �Ĵ̼����ӿ��˿������ȣ���һ�����¹��ܲ��ϣ�һЩ�� neovim �з������õ�����Ҳ����ֲ���˻�������������Ҫ���첽 API�����ҷ����� 8.0 �����汾��

���� vim 8 �У�Ҳ�����˸��� neovim û�еĹ��ܣ����� :smile���Լ����õġ����������ܡ�

���� vim �յ����õ�����������������ܴ����Ϥ�� Vundle ���� vim-plug ��̫һ��������������һ�������ݣ����Ǹ� "na?ve" һЩ��

ʵ���ϣ�vim ������һ���µ� package �ĸ����ʵ�ְ�����������֮ǰ vim �� plugin ���ͬ���ǣ�һ�� package �Ǻܶ� plugin �ļ��ϣ�һ������� plugin ֮��������໥������ϵ������һ�� package ֻҪ�ŵ�ָ��Ŀ¼�У�vim ��������ʱ��Ϳ����Զ��������ǣ�Ҳ����ѡ������֮���ٽ��м��أ���

ʹ��
ֻҪ�� ~/.vim/pack �´���һ���µ�Ŀ¼���Ϳ�����Ϊһ�� package �ˡ���ΪĿǰ vim �������󲿷ֲ�������ǰ��� plugin ����ʽ����֯�ģ�����Ŀǰ��Ҫ�� package ϵͳ��ʹ�õĻ���������Ҫ�Լ�����һ�� package�������й�����Ҫ�����е����� plugin��

���Կ����ȴ���һ�� ~/.vim/pack/myplugins ��Ŀ¼����Ϊ������� plugin �� package��myplugins �ĳ�������Ҳû�����⡣�������������зֱ𴴽� start �� opt ����Ŀ¼��

������������ͱȽϼ��ˣ���֮ǰ���еĵ����������һ���Զ��� ~/.vim/pack/myplugins/start �Ϳ��ԣ��������� vim ֮�󣬾Ϳ����Զ������ˡ���������������صĲ�����Ͷ��� ~/.vim/pack/myplugins/opt ���Ҫ�õ���ʱ��ִ�� :packadd pluginname �Ϳ����ˡ�

����
�������ǿ��Ժ����׷��֣���ʵ���ʹ�� git �� submodule ���ܣ��Ϳ��Ժܷ�������/���������������������Ҫ����ĵ���������������ˡ�

���ڿ��԰����� .vim Ŀ¼����һ�� git �ֿ⣬Ȼ��ͨ�� $ git submodule init ��ʼ�� submodule��

��������Ҫ���һ����������������� ale��ֻҪִ�У�

$ git submodule add https://github.com/w0rp/ale.git pack/myplugins/start/ale
�������е����������ֻҪִ�У�

$ git submodule update --recursive --remote
����
ʹ�� git ������� vim 8 �İ�����������һ���ô��������������� vim ���ø����ˣ����߿��ٵ���һ̨�»��������ú� vim��ֻҪ�򵥵İѲֿ� clone �������ɡ�������Ҫʹ���ҵ� vim ���ã�

$ git clone --recursive https://github.com/aisk/.vim.git ~/.vim 
