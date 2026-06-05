
```python
markdown_content = """# Arch Linux on WSL2: Complete Setup Guide (with Kitty Terminal)

This guide walks you through installing Arch Linux on Windows Subsystem for Linux (WSL2), configuring a standard user, tweaking the package manager, and setting up the GPU-accelerated **Kitty** terminal to run natively on your Windows desktop using WSLg.

---

## Prerequisites

Before starting, ensure your Windows machine has WSL2 enabled and updated. Open **PowerShell as Administrator** and run:


```

```text
File saved to /mnt/data/Arch_WSL_Setup_Guide.md

```powershell
wsl --update
wsl --set-default-version 2

```

---

## Phase 1: Install ArchWSL

Since Arch Linux is not available in the Microsoft Store, we use the open-source **ArchWSL** project.

1. Go to the [ArchWSL GitHub Releases page](https://www.google.com/search?q=https://github.com/yuk7/ArchWSL/releases/latest).
2. Download the latest **`Arch.zip`** file.
3. Extract the `.zip` file to a permanent location (e.g., `C:\\WSL\\Arch`). *Do not leave it in your Downloads folder.*
4. Double-click **`Arch.exe`** inside the extracted folder. It will register Arch with WSL and open a root terminal. Press **Enter** to close it when it finishes.

---

## Phase 2: Initialize the Package Manager (Pacman)

Open your terminal and launch Arch as the root user by double-clicking `Arch.exe` again or running `wsl -d Arch` in PowerShell.

Initialize the pacman security keys and update the system:

```bash
pacman-key --init
pacman-key --populate
pacman -Syyu

```

---

## Phase 3: Create a Standard User

Running as root is a security risk. Create a standard user with `sudo` privileges.

1. Install `sudo`, a text editor, and the base development tools:
```bash
pacman -S sudo nano base-devel

```


2. Create the user (replace `yourusername` with your desired name):
```bash
useradd -m -G wheel -s /bin/bash yourusername

```


3. Set a password:
```bash
passwd yourusername

```


4. Allow the `wheel` group to use `sudo`:
```bash
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

```


5. Tell WSL to use this user by default:
```bash
echo -e "[user]\\ndefault=alex" > /etc/wsl.conf

```


6. Exit the terminal (`exit`) and completely shut down WSL from PowerShell:
```powershell
wsl --terminate archlinux

```



*The next time you open Arch, you will be logged in as your new standard user.*

---

## Phase 4: Pacman Tweaks (Multilib & Easter Egg)

Open Arch (you should now be your standard user) and edit the pacman configuration file:

```bash
sudo nano /etc/pacman.conf

```

**1. Enable the Pac-Man Eating Animation:**
Scroll to the `[options]` section. Uncomment `Color` and add `ILoveCandy` right below it:

```ini
Color
ILoveCandy

```

**2. Enable 32-bit (Multilib) Support:**
Scroll to the bottom of the file and uncomment these two lines:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist

```

Save and exit (`Ctrl+O`, `Enter`, `Ctrl+X`), then sync the repositories to apply the changes:

```bash
sudo pacman -Sy

```

---

## Phase 5: Set Up Kitty Terminal via WSLg

WSLg handles graphical Linux apps natively on Windows, but Arch needs a slight tweak to find the display sockets.

**1. Install Kitty, Wayland, and a Monospace Font:**

```bash
sudo pacman -S kitty ttf-hack wayland

```

**2. Fix Display Sockets for WSLg:**
Add the required environment variables and symbolic links to your profile so Arch can communicate with the Windows GUI. Run these commands:

```bash
echo 'export DISPLAY=:0' >> ~/.bash_profile
echo 'export WAYLAND_DISPLAY=wayland-0' >> ~/.bash_profile
echo '[ ! -L "/run/user/$UID/wayland-0" ] && ln -sf "/mnt/wslg/runtime-dir/wayland-0" "/run/user/$UID/wayland-0"' >> ~/.bash_profile
echo '[ ! -L "/tmp/.X11-unix" ] && ln -sf "/mnt/wslg/X11-unix" "/tmp/.X11-unix"' >> ~/.bash_profile

```

**3. Apply the changes:**

```bash
source ~/.bash_profile

```

**4. Launch Kitty:**
You can now run `kitty` directly from your Arch terminal:

```bash
kitty

```

*(If Kitty throws OpenGL errors or crashes, force it to use software rendering with `LIBGL_ALWAYS_SOFTWARE=1 kitty`)*.
"""

file_path = "/mnt/data/Arch_WSL_Setup_Guide.md"
with open(file_path, "w") as f:
f.write(markdown_content)

print(f"File saved to {file_path}")

```
Your MD file is ready
[file-tag: code-generated-file-0-1780649614930591904]

I have compiled the entire process into a clean, formatted Markdown file that you can use as a README. It covers everything from installing ArchWSL to configuring your standard user, enabling the multilib repository and the Pac-Man candy animation, and finally setting up Kitty with the correct WSLg sockets.

```
