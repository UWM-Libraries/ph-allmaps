> **Warning:** 
> 
> This lesson assumes some familiarity with the command line in a Unix environment
> (Linux, macOS/osX, or a Unix-like enviornment on a Windows PC),
> installing packages, and 
> generating and running scripts from the command line.
> 
> Never copy-paste code into your terminal unless you understand what it's doing.
> This lesson requires installing software like the
> [Allmaps Command Line](https://www.npmjs.com/package/@allmaps/cli),
> [Node.js](https://nodejs.org/en/download),
> [GDAL](https://gdal.org/en/stable/download.html),
> [deezoomify-rs](https://github.com/lovasoa/dezoomify-rs),
> and other dependencies.
>
> Installation and compatability with your environment will vary depending
> on your operating system, OS version, shell environment, etc. 
>
{: .callout .warning }

<a class="btn" href="#generating-a-geotiff-using-allmaps-cli">Skip setup instructions</a>
<a class="btn" href="{{ '/lessons/fun' | relative_url }}">🕹️ Have fun instead</a>

## Environment Setup

### Windows Only: Set up WSL

[Windows Subsystem for Linux Documentation](https://learn.microsoft.com/en-us/windows/wsl/)

If you don't have a Linux distribution set up for WSL, install Ubuntu:

`wsl --install -d Ubuntu`

Now you can launch a Ubuntu environment from your Windows desktop environment. Follow Linux/Unix instructions below.

### Linux/Unix
```bash
# Update and upgrade package manager
sudo apt update && sudo apt upgrade -y

# Install Node.js 20 using NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# GDAL (geospatial library)
sudo apt install -y gdal-bin libgdal-dev
```

### macOS/OSX:

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

```bash
npm install -g @allmaps/cli
```

Test it with `allmaps --help`

You need the following tools to complete the tasks performed in the leson:

[`dezoomify-rs`](https://github.com/lovasoa/dezoomify-rs)
for full image extraction;
**This requires Rust.**

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install dezoomify-rs
```

For clipboard interaction and working with IIIF or bash scripts:

```bash
sudo apt install -y xclip jq moreutils
```

> **macOS/OSX:**
>
> Install via Homebrew
>
> ```bash
> brew install dezoomify-rs
> ```
> 
> I recommend investigating other dependencies depending on your environment.
> [Homebrew](https://brew.sh/)
> works best for me on Apple silicon.
>
{: .callout .tip }

