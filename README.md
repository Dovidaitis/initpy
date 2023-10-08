# initpy

`initpy` is a command-line tool designed to simplify the initialization of Python projects. With an interactive setup, it automates the creation of project directories, installation of dependencies, and the setup of environments for FastAPI and web scraping projects.

## Setup

1. Clone the repository to your local `~/scripts` directory:
    ```sh
    git clone <repository-url> ~/scripts/initpy
    ```
    (Replace `<repository-url>` with the actual URL of the repository.)

2. Add the `initpy` alias to your `.zshrc`, `.bashrc`, or appropriate shell configuration file:
    ```sh
    echo "alias initpy='bash ~/scripts/initpy/initpy.sh'" >> ~/.zshrc
    ```
    (Adjust the path according to where the script is stored and replace `.zshrc` with your shell’s configuration file if needed.)

3. Apply the changes:
    ```sh
    source ~/.zshrc
    ```
    (Again, adjust with your shell’s configuration file if different.)

## Usage

Navigate to the directory where you want to create your new project and run:
```sh
initpy
```

## Dependencies
Make sure that *Poetry* is installed on your system. If it's not, install it.