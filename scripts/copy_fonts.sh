case "$(uname -s)" in
  Darwin)
    cp -r ~/.repos/dotfiles/resources/fonts ~/Library/Fonts/
    ;;
  Linux)
    cp -r ~/.repos/dotfiles/resources/fonts ~/.fonts
    ;;
esac
