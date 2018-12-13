#!/usr/bin/env bash
cd `dirname $0`
DIRNAME=`pwd`
WEBAPP_DIR=/usr/local/your_web_app_dir/

vue_autodeploy_svn(){
    #SVN address
    SVN_PATH=http://test.com
    #SVN code tmp address
    CODE_TMP_PATH=/tmp/svntmp
    #vue project tmp
    VUE_TMP_PATH=/tmp/vuetmp

    if [ ! -d $VUE_TMP_PATH ]; then
        mkdir -p $VUE_TMP_PATH
    fi

    if [ ! -d $CODE_TMP_PATH ]; then
        mkdir -p $CODE_TMP_PATH
    fi

    svn checkout $SVN_PATH $CODE_TMP_PATH

    cd $VUE_TMP_PATH
    npm run build
    while true; do
        echo 'packing vue project from svn......'
        if [ -d $VUE_TMP_PATH/dist ]; then
            echo 'packing is done'
            break
        fi
        sleep 8
    done

    rm -rf $WEBAPP_DIR
    cp -r $VUE_TMP_PATH/dist/* $WEBAPP_DIR
}

vue_autodeploy_git(){
    echo 'packing vue project from git......'
}

param_tip(){
    echo 'missing operand or operand wrong'
    echo '1.svn'
    echo '2.git'
}

if [ "$1" = "1" ]; then
    vue_autodeploy_svn
elif [ "$1" = "2" ]; then
    vue_autodeploy_git
else
    param_tip
fi
