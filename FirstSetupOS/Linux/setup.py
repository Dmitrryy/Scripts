import subprocess
import os
import shutil
import urllib.request
import re

#TODO: 1) установка этих зависимостей требует sudo
#      2) не работает на windows power shall
#sudo apt install build-essential cmake vim-nox python3-dev
#sudo apt install mono-complete golang nodejs default-jdk npm

# to change the working directory. CD analog
#===----------------------------------------------
class cd:
    def __init__(self, newPath):
        self.newPath = os.path.expanduser(newPath)

    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

# config pathes
#===----------------------------------------------
home_path = os.environ.get('HOME')
vimrc_path = home_path + '/.vimrc'
bash_profile_path = home_path + '/.bash_profile'
vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ohmyzsh_url = 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh'

print('Home path:', home_path)
print('vimrc path:', vimrc_path)
print('path to bash_profile:', bash_profile_path)

# настройка bash_profile
#===----------------------------------------------
if os.path.isfile(bash_profile_path):
    shutil.copyfile(bash_profile_path, bash_profile_path + '_saved_FirstSetupOS')
shutil.copyfile('.bash_profile', bash_profile_path)

# настройка vim
#===----------------------------------------------
if not os.path.exists(home_path + '/.vim/autoload/'):
    os.makedirs(home_path + '/.vim/autoload/')

with urllib.request.urlopen(vimplug_url) as urlvimplug, open(home_path + '/.vim/autoload/plug.vim', 'wb') as destfile:
    shutil.copyfileobj(urlvimplug, destfile)

#
if os.path.isfile(vimrc_path):
    shutil.copyfile(vimrc_path, vimrc_path + '_saved_FirstSetupOS')

if os.path.isfile(vimrc_path + '.plug'):
    shutil.copyfile(vimrc_path + '.plug', vimrc_path + '.plug_saved_FirstSetupOS')

shutil.copyfile('.vimrc', vimrc_path)
shutil.copyfile('.vimrc.plug', vimrc_path + '.plug')

#
ret = subprocess.run(['sudo', 'apt', 'install', 'clangd-12'])
print(ret)
ret = subprocess.run(['sudo', 'apt', 'install', 'build-essential', 'cmake', 'vim-nox', 'python3-dev'])
print(ret)
ret = subprocess.run(['sudo', 'apt', 'install', 'mono-complete', 'golang', 'nodejs', 'default-jdk', 'npm'])
print(ret)

#
with cd(home_path + '/.vim/plugged/YouCompleteMe'):
    ret1 = subprocess.run(["python3", 'install.py', '--all', '--clangd-completer'])
    print(ret)

ret = subprocess.run(["vim", "-c", "PlugInstall", '-c', '-q', '-c', '-q'])
print(ret)

# zsh
#===----------------------------------------------
ret = subprocess.run(['sudo', 'apt-get', 'install', 'git', 'zsh', '-y'])
print(ret)
with urllib.request.urlopen(ohmyzsh_url) as urlohmyzsh, open('install.sh', 'wb') as destfile:
    shutil.copyfileobj(urlohmyzsh, destfile)
ret = subprocess.run(['sh', 'install.sh', '--skip-chsh', '--unattended'])
print(ret)
os.remove('install.sh')

with open(home_path + '/.zshrc', "rt") as file:
    zshrc = file.read()

with open(home_path + '/.zshrc', "wt") as file:
    zshrc = re.sub('ZSH_THEME=\"robbyrussell\"', 'ZSH_THEME=\"bira\"', zshrc)
    file.write(zshrc)
