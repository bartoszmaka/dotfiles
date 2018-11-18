bash ./copy_fonts.sh
bash ./build_alt.sh
bash ./copy_fonts.sh
bash ./setup_vim_plug.sh
bash ./setup_ohmyzsh.sh
bash ./setup_symlinks.sh
case "$(uname -s)" in
  Linux)
    source ./build_ctags.sh
    ;;
esac
