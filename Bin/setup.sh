#!/bin/sh
project_path="./CodeSample.xcodeproj"
project_name="CodeSample"

# FUNCTIONS

function install_homebrew {
    echo "🟡 Installing Homebrew..."
    echo -ne '\n' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

function install_swiftlint {
    echo "🟡 Installing SwiftLint..."
    brew install swiftlint
}

function install_swiftgen {
    echo "🟡 Installing SwiftGen..."
    brew install swiftgen
}

function install_xcodegen {
    echo "🟡 Installing XcodeGen..."
    brew install xcodegen
}

function install_carthage {
    echo "🟡 Installing XcodeGen..."
    brew install carthage
}

function install_project_tools {
    echo "⚙️  Installing tools..."
    install_homebrew
    install_carthage
    install_swiftlint
    install_swiftgen
    install_xcodegen
    echo "🟢 Ready to go!"
}

function generate_xcode_project {
    cp -R Custom\ Templates ~/Library/Developer/Xcode/Templates/
    carthage checkout --use-ssh
    carthage build --platform iOS --no-use-binaries --use-xcframeworks
    echo "🛠  Generating xcode project..."
    cd Modules/Core
    xcodegen
    cd ../Components
    xcodegen
    cd ../..
    xcodegen

    echo "🟢 Ready to go! Opening project..."
    open "$project_path"
}

function clean_derived_data {
    echo "🚽 Cleaning derived data..."
    find ~/Library/Developer/Xcode/DerivedData/ -type d -name "$project_name-*" -print0 | xargs -0 -I {} /bin/rm -rf "{}"
    echo "🟢 Ready to go!"
}


# ARGS SETUP

args=$@
[[ ${args[*]} =~ 'init' ]] && init=true || init=false
[[ ${args[*]} =~ 'generate' ]] && generate=true || generate=false
[[ ${args[*]} =~ 'clean' ]] && clean=true || clean=false


# EXEC

if [ "$init" = true ]; then
    install_project_tools
fi

if [ "$generate" = true ]; then
    generate_xcode_project
fi

if [ "$clean" = true ]; then
    clean_derived_data
fi
