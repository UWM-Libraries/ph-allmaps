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

### Linux and Unix

The commands below are written for Ubuntu and Debian-based environments, including Ubuntu on WSL, that use the `apt` package manager.
Other Linux or Unix-like systems may use different package managers, package names, and compilation methods.

Refresh the package list and apply available system updates before installing new tools:

```bash
sudo apt update
sudo apt upgrade
```

Download the NodeSource setup script for the current long-term support (LTS) version of Node.js:

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x -o nodesource_setup.sh
```

Run the setup script:

```bash
sudo -E bash nodesource_setup.sh
```

Install Node.js:

```bash
sudo apt install nodejs
```

Install GDAL:

```bash
sudo apt install gdal-bin libgdal-dev
```

### macOS

Install [Homebrew](https://brew.sh/) if not already installed.

Refresh Homebrew’s package list:

```zsh
brew update
```

Install Node.js:

```zsh
brew install node
```

Install GDAL (geospatial data abstraction library):

```zsh
brew install gdal
```

## Install Allmaps CLI and dependencies

This section is split into tools required for all examples and tools needed only for selected workflows.

### Required for all examples

```bash
npm install -g @allmaps/cli
```

Confirm that Allmaps CLI and GDAL are available:

```bash
allmaps --help
gdalinfo --version
```

### Tools for GeoTIFF export

The GeoTIFF workflow uses jq to inspect IIIF Image API metadata and dezoomify-rs to download a full-resolution image when the source image dimensions do not match the Allmaps annotation.

On Ubuntu/Debian or Ubuntu on WSL, install jq:

```bash
sudo apt install jq
```

On macOS, install jq with Homebrew:

```zsh
brew install jq
```

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs) is used for full image extraction.
It requires Rust.

Install dezoomify-rs.

On Ubuntu/Debian or Ubuntu on WSL, install Rust and then install dezoomify-rs with Cargo:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Load Cargo in your current terminal session:

```bash
source "$HOME/.cargo/env"
```

Install dezoomify-rs:

```bash
cargo install dezoomify-rs
```

Confirm Cargo is available:

```bash
cargo --version
```

On macOS, install dezoomify-rs with Homebrew:

```zsh
brew install dezoomify-rs
```

Confirm the tools are available:

```bash
jq --version
dezoomify-rs --help
```

<div class="alert alert-warning">
If installation fails, the most likely missing pieces are Node.js, npm, GDAL, Rust/Cargo, or small command-line utilities such as `jq`.
After installing a new tool, you may need to restart your terminal before the command is available.
</div>
