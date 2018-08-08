case "$(uname -s)" in
  Darwin)
    cp -r ~/.repos/dotfiles/fonts ~/Library/Fonts/
    ;;
  Linux)
    cp -r ~/.repos/dotfiles/fonts ~/.fonts
    ;;
esac
