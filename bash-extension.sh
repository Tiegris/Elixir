################################
# Elixir
################################
elixir-upgrade() {
    pwdbak=$(pwd) && \
    cd $HOME/.elixir/ && \
    git pull && \
    docker build --no-cache -t elixir:tiegris . && \
    source $HOME/.elixir/bash-extension.sh && \
    echo "Elixir extension successfully upgraded and reloaded"
    cd $pwdbak
}

elixir-start() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        docker stop elixir >/dev/null && \
        echo "Stopping old elixir container."
    fi

    echo $(pwd) > $HOME/.elixir/elixir-home
    ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
    docker run --env ELIXIR_HOME=$ELIXIR_HOME --rm -dit -v "$ELIXIR_HOME:/elixir-home" --name elixir elixir:tiegris /bin/bash >/dev/null && \
    echo "Elixir container started." || \
    echo "Could not start Elixir. Is the Docker daemon running?"
}

elixir-exec() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        # elixir is running
        ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
        if [ "$ELIXIR_HOME" = $(pwd) ]
        then
            docker exec -w /elixir-home -it elixir /bin/bash
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}

elixir() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        # elixir is running
        ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
        if [ "$ELIXIR_HOME" = $(pwd) ]
        then
            docker exec -w /elixir-home -it elixir elixir "$@"
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}

elixirc() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        # elixir is running
        ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
        if [ "$ELIXIR_HOME" = $(pwd) ]
        then
            docker exec -w /elixir-home -it elixir elixirc "$@"
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}

elixir-build() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        # elixir is running
        ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
        if [ "$ELIXIR_HOME" = $(pwd) ]
        then
            docker exec -w /elixir-home -it elixir elixirc $(ls | grep ".ex$")
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}

iex() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        # elixir is running
        ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
        if [ "$ELIXIR_HOME" = $(pwd) ]
        then
            docker exec -w /elixir-home -it elixir iex "$@"
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}

#######################
# Prolog
#######################
prolog() {
    docker run -it --rm --name prolog -v `pwd`:/home -w /home swip
}
