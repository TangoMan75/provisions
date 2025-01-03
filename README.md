![GH language](https://img.shields.io/github/languages/top/TangoMan75/provisions)
[![GH release](https://img.shields.io/github/v/release/TangoMan75/provisions)](https://github.com/TangoMan75/provisions/releases)
[![GH license](https://img.shields.io/github/license/TangoMan75/provisions)]((https://github.com/TangoMan75/provisions/blob/master/LICENSE))
[![GH stars](https://img.shields.io/github/stars/TangoMan75/provisions)](https://github.com/TangoMan75/provisions/stargazers)
[![ShellCheck CI](https://github.com/TangoMan75/provisions/workflows/ShellCheck%20CI/badge.svg)](https://github.com/TangoMan75/provisions/actions/workflows/shellcheck.yml)
![visitors](https://visitor-badge.glitch.me/badge?page_id=TangoMan75.provisions)

TangoMan Provisions
===================

**TangoMan Provisions** is a fast and handy way to provision your machines using plain shell scripts.

What to do after installing your workstation :

1. Install git
2. clone this repository
3. Setup your ssh config

💻 Dependencies
---------------

**TangoMan Provisions** requires the following dependencies:

- git

---

### 🔖 git

#### 🐧 Install git (Linux)

```bash
sudo apt-get install --assume-yes git
```

#### 🏁 Install git (Windows)

Download and install latest version from here [git-scm.com](https://git-scm.com/download/win)

#### 🍎 Install git (OSX)

```bash
brew install git
```

#### 🔧 git configuration

Push current branch only if upstream exists

```bash
git config --global push.default simple
```

Set vim as git default editor

```bash
git config --global core.editor 'vim'
```

---

🚀 Installation
---------------

### Step 1: Simply enter following command in your terminal

```bash
./update.sh
```

🔥 Usage
--------

Enter following command in your terminal:

```bash
./recipe_essentials.sh
```

📝 Notes
--------

Where to find default `.desktop` shortcuts on ubuntu ?

```bash
# default applications .desktop files can be found here
/usr/share/applications/
# or here
~/.local/share/applications/
```

```bash
# snap applications .desktop files can be found here
/var/lib/snapd/desktop/applications/
```

Where to find executables on ubuntu ?

```bash
# snap packages can be found here:
/snap
```

How to autostart an app ?

```bash
# place .desktop file here
~/.config/autostart/
```

Where to find repositories `sources.list` ?

```bash
/etc/apt/sources.list
/etc/apt/sources.list.d
```

---

### How to install dpkg package

```
sudo dpkg --install ${APP_NAME}
```

### How to remove dpkg package

```
sudo dpkg --remove ${APP_NAME}
```

🤝 Contributing
---------------

Thank you for your interest in contributing to **TangoMan Provisions**.

Please review the [code of conduct](https://github.com/TangoMan75/provisions/blob/master/CODE_OF_CONDUCT.md) and [contribution guidelines](https://github.com/TangoMan75/provisions/blob/master/CONTRIBUTION.md) before starting to work on any features.

If you want to open an issue, please check first if it was not [reported already](https://github.com/TangoMan75/provisions/issues) before creating a new one.

📜 License
----------

Copyrights (c) 2024 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENSE)
Distributed under the MIT license.

If you like **TangoMan Provisions** please star, follow or tweet:

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/provisions?style=social)](https://github.com/TangoMan75/provisions/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fprovisions)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fprovisions)

... And check my other cool projects.
