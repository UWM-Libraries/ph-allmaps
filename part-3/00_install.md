<div class="alert alert-warning">
This lesson assumes some familiarity with the command line in a Unix environment
(Linux, macOS, or a Unix-like environment on a Windows PC), installing packages,
and generating and running scripts from the command line.

Never copy and paste code into your terminal unless you understand what it is doing.
This lesson requires installing software such as
[Allmaps Command Line](https://www.npmjs.com/package/@allmaps/cli),
[Node.js](https://nodejs.org/en/download),
[GDAL](https://gdal.org/en/stable/download.html),
[dezoomify-rs](https://github.com/lovasoa/dezoomify-rs),
and other dependencies.

Installation and compatibility will vary depending on your operating system,
OS version, and shell environment.
</div>

## Environment Setup

### Windows Only: Set up WSL

macOS and Linux users can skip this section and jump to [Linux and Unix](#linux-and-unix).

This lesson uses WSL for Windows because the command-line tools in this section are easiest to install and teach in a Unix-like environment.
WSL gives Windows users a Linux shell that behaves much like the macOS and Linux workflows used in the rest of the lesson, which keeps commands, paths, and troubleshooting more consistent.
Native Windows workflows are possible, but they require different setup steps.

For more detailed setup instructions, see Microsoft’s [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) documentation.

If you don't have a Linux distribution set up for WSL, install Ubuntu via PowerShell.
Ubuntu can also be installed from the Microsoft Store after WSL is enabled, but PowerShell handles both steps in one workflow.
Open PowerShell as an administrator and install WSL:

```powershell
wsl --install
```

This installs Ubuntu by default. If WSL is already installed but Ubuntu is not, you can install Ubuntu explicitly:

```powershell
wsl --install -d Ubuntu
```

Open Ubuntu from the Windows Start menu. When the Ubuntu prompt appears, continue with the Linux and Unix instructions below.

<!-- TODO: Clarify that these commands are Ubuntu/Debian-specific, or broaden the section with alternatives for other Unix-like systems. -->
### Linux and Unix
```bash
# Update and upgrade package manager
sudo apt update && sudo apt upgrade -y

# Install Node.js 20 using NodeSource
#
# TODO: Explain why this lesson prefers NodeSource here instead of system packages, nvm, or another installation method.
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# GDAL (geospatial library)
sudo apt install -y gdal-bin libgdal-dev
```

### macOS

Install Homebrew if not already installed.

```bash
# Update system & Homebrew
softwareupdate -i -a
brew update && brew upgrade

# Install Node.js 20 (LTS)
brew install node@20

# GDAL (geospatial library)
brew install gdal
```

### Install Allmaps CLI and dependencies

This section is split into tools required for all examples and tools needed only for selected workflows.

#### Required for all examples

```bash
npm install -g @allmaps/cli
```

Test the installation:

```bash
allmaps --help
gdalinfo --version
```

#### Additional tools for selected workflows

You need the following tools to complete some of the tasks in the lesson:

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs) is used for full image extraction.
It requires Rust.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install dezoomify-rs
```

Test the installation:

```bash
cargo --version
dezoomify-rs --help
```

<!-- TODO: Explain more explicitly which later steps use xclip, jq, and moreutils. -->
For clipboard interaction and working with IIIF or bash scripts:

```bash
sudo apt install -y xclip jq moreutils
```

Test the installation:

```bash
jq --version
```

<div class="alert alert-warning">
On macOS, you can install `dezoomify-rs` with Homebrew:

```bash
brew install dezoomify-rs
```

Test the installation:

```bash
dezoomify-rs --help
```

<!-- TODO: Name the most likely additional dependencies learners may need. -->
Depending on your environment, you may also need to investigate additional dependencies.
[Homebrew](https://brew.sh/) works well on Apple silicon.
</div>
