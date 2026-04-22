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

<!-- TODO: Briefly explain why Windows users are being directed to WSL instead of  Windows workflow. -->

[Windows Subsystem for Linux Documentation](https://learn.microsoft.com/en-us/windows/wsl/)

If you don't have a Linux distribution set up for WSL, install Ubuntu:

```bash
wsl --install -d Ubuntu
```

Now you can launch a Ubuntu environment from your Windows desktop environment. Follow Linux/Unix instructions below.

<!-- TODO: Clarify that these commands are Ubuntu/Debian-specific, or broaden the section with alternatives for other Unix-like systems. -->
### Linux/Unix
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
