![GH language](https://img.shields.io/github/languages/top/TangoMan75/provisions)
[![GH release](https://img.shields.io/github/v/release/TangoMan75/provisions)](https://github.com/TangoMan75/provisions/releases)
[![GH license](https://img.shields.io/github/license/TangoMan75/provisions)]((https://github.com/TangoMan75/provisions/blob/master/LICENSE))
[![GH stars](https://img.shields.io/github/stars/TangoMan75/provisions)](https://github.com/TangoMan75/provisions/stargazers)
[![ShellCheck CI](https://github.com/TangoMan75/provisions/workflows/ShellCheck%20CI/badge.svg)](https://github.com/TangoMan75/provisions/actions/workflows/shellcheck.yml)
![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fprovisions&labelColor=%23697689&countColor=%2337d67a&style=flat)

TangoMan Provisions
===================

**TangoMan Provisions** is a fast and handy way to provision your machines using plain shell scripts.

📦 Installation
---------------

### Clone Repository

```bash
git clone https://github.com/TangoMan75/provisions
```

🛠️ Usage
--------

### Execute Recipe

```bash
./recipe_essentials.sh
```

🌐 Linux Apps Stores
--------------------

- [https://flathub.org](https://flathub.org)
- [https://snapcraft.io](https://snapcraft.io)

📝 Notes
--------

### Where to find default `.desktop` shortcuts on ubuntu ?

Debian packages:
```bash
# default applications .desktop files can be found here
"/usr/share/applications/${APP_NAME}.desktop"
# or here
"~/.local/share/applications/${APP_NAME}.desktop"
```

Snap packages:
```bash
# snap applications .desktop files can be found here
"/var/lib/snapd/desktop/applications/${APP_NAME}.desktop"
```

Flatpak packages:
```bash
# flatpak applications .desktop files can be found here
"/var/lib/flatpak/app/${APP_NAME}/current/active/files/share/applications/${APP_NAME}.desktop"
```

How to find a shortcut ?
```bash
ls /usr/share/applications | grep "${APP_NAME}"
ls /var/lib/snapd/desktop/applications | grep "${APP_NAME}"
ls /var/lib/flatpak/app | grep "${APP_NAME}"
```

### How to search for specific packages in apt-get ?

```bash
apt-cache pkgnames | grep "${APP_NAME}"
```

### How to list installed packages in apt ?

```bash
apt list --installed | grep "${APP_NAME}"
```

### How to autostart an app ?

```bash
# place .desktop file here
~/.config/autostart/
```

### Where to find repositories `sources.list` ?

```bash
/etc/apt/sources.list
/etc/apt/sources.list.d
```

### Where to find snap executables on ubuntu ?

```bash
# snap packages can be found here:
/snap
```

### How to install dpkg package ?

```
sudo dpkg --install ${APP_NAME}
```

### How to remove dpkg package ?

```
sudo dpkg --remove ${APP_NAME}
```

### How to install flatpak package ?

```
flatpak install flathub -y ${APP_NAME}
```

### How to remove flatpak package ?

```
flatpak uninstall -y --delete-data ${APP_NAME}
```

🤝 Contributing
---------------

Thank you for your interest in contributing to **TangoMan Provisions**.

Please review the [code of conduct](https://github.com/TangoMan75/provisions/blob/master/CODE_OF_CONDUCT.md) and [contribution guidelines](https://github.com/TangoMan75/provisions/blob/master/CONTRIBUTION.md) before starting to work on any features.

If you want to open an issue, please check first if it was not [reported already](https://github.com/TangoMan75/provisions/issues) before creating a new one.

📜 License
----------

Copyrights (c) 2026 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENSE)
Distributed under the MIT license.

If you like **TangoMan Provisions** please star, follow or tweet:

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/provisions?style=social)](https://github.com/TangoMan75/provisions/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fprovisions)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fprovisions)

... And check my other cool projects.

👋 Let's Build Your Next Project Together !
-------------------------------------------

Clean code. Clear communication.

From first sketch to final launch, I've got your back.

[![tangoman.io](https://img.shields.io/badge/✉️%20Get%20in%20touch%20now%20!-FD9400?style=for-the-badge)](https://tangoman.io)
