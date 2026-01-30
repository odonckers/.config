#!/usr/bin/env zsh

# Reset directory to origin or clone
NETCOREDBG_DIR=$XDG_DATA_HOME/netcoredbg
if [ -d $NETCOREDBG_DIR ]; then
  cd $NETCOREDBG_DIR
  git reset --hard origin/master
else
  git clone git@github.com:Samsung/netcoredbg.git $NETCOREDBG_DIR
  cd $NETCOREDBG_DIR
fi

# Build the project
mkdir -p build
cd build/
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/../bin -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang
make
make install

# Symlink to bin
ln -s $NETCOREDBG_DIR/bin/* $HOME/.local/bin/
