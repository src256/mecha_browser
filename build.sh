#!/bin/sh
# rmagick for sierra
#export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig
#export PATH=/usr/local/Cellar/imagemagick@6/6.9.7-5/bin:$PATH

bundle_dir=./vendor/bundle
bundle config --local path $bundle_dir

if [ "$1" = "clean" ]; then
    echo "rm -rf $bundle_dir"
    /bin/rm -rf "$bundle_dir"
    /bin/rm Gemfile.lock    
    exit 0
fi

if [ -d "$bundle_dir" ] ; then
    echo "bunlde update"
    bundle update
    bundle clean
else
    echo "bundle install"
    /bin/rm -rf "$bundle_dir"
    bundle install
fi



