#!/bin/bash

if [ -n "$POETRY_ACTIVE" ]; then
    echo "The script is running within a Poetry environment. Please exit and rerun the script."
    exit 1
fi

initialize_python_project() {
    read -p ">>> Enter the name of your Python project directory (type 'exit' to quit): " project_name
    
    if [ "$project_name" = "exit" ]; then
        echo "Exiting..."
        exit
    fi

    mkdir "$project_name" && cd "$project_name" || exit

    # Initialize a new poetry project
    poetry init --no-interaction
    poetry add pytest pre-commit

    # Copy configuration files from ~/scripts/initpy directory to the new project directory
    cp ~/scripts/initpy/.gitignore .
    cp ~/scripts/initpy/setup.cfg .
    cp ~/scripts/initpy/.pre-commit-config.yaml .
    cp -r ~/scripts/initpy/tests .

    # ask whether to include .github/workflows
    read -p ">>> Do you want to copy the github/workflows directory to your project? [Y/n]: " copy_choice
    copy_choice=${copy_choice:-y}
    if [[ "$copy_choice" =~ ^([yY][eE][sS]|[yY]|"")$ ]]; then
        mkdir -p ./.github/workflows
        cp -r ~/scripts/initpy/github/* ./.github/workflows
        echo "github/workflows directory has been copied to your project."
    elif [[ "$copy_choice" =~ ^([nN][oO]|[nN])$ ]]; then
        echo "github/workflows directory was not copied to your project."
    else
        echo "Invalid option. github/workflows directory was not copied to your project."
    fi


    while true; do
        echo "Select the type of project (1: FastAPI, 2: Scraper, 3: Quit):"
        read -p ">>> " project_type

        if [ "$project_type" = "exit" ]; then
            echo "Exiting..."
            exit
        fi

        case $project_type in
            1)
                poetry add fastapi uvicorn
                break
                ;;
            2)
                while true; do
                    echo "Enter the numbers of the packages you want to add separated by space (1: beautifulsoup4, 2: selenium):"
                    read -p ">>> " -ra packages

                    if [[ "${packages[0]}" == "exit" ]]; then
                        echo "Exiting..."
                        exit
                    fi

                    valid=true
                    for package in "${packages[@]}"; do
                        case $package in
                            1)
                                poetry add beautifulsoup4
                                ;;
                            2)
                                poetry add selenium
                                ;;
                            *)
                                echo "Invalid option $package"
                                valid=false
                                ;;
                        esac
                    done

                    $valid && break
                done
                break
                ;;
            3)
                exit
                ;;
            *)
                echo "Invalid option $project_type. Please select 1, 2, or 3."
                ;;
        esac
    done

    poetry install

    echo "Python project $project_name is initialized!"
    exit
}

initialize_python_project
