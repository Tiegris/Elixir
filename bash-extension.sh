################################
# Elixir
################################
elixir-upgrade() {
    cd $HOME/.elixir/
    git pull
    docker build -t elixir:tiegris .
}

elixir-start() {
    COUNT=$(docker container ls | grep elixir | wc -l)
    if [ "$COUNT" -eq 1 ]
    then
        docker stop elixir >/dev/null
        echo "Stoping old elixir container."
    fi

    echo $(pwd) > $HOME/.elixir/elixir-home
    ELIXIR_HOME=$(cat "$HOME/.elixir/elixir-home")
    docker run --env ELIXIR_HOME=$ELIXIR_HOME --rm -dit -v "$ELIXIR_HOME:/elixir-home" --name elixir elixir:tiegris /bin/bash >/dev/null
    echo "Elixir container started."
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
            docker exec -w /elixir-home -it elixir elixir
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
            docker exec -w /elixir-home -it elixir elixirc
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
            docker exec -w /elixir-home -it elixir iex
        else 
            echo "You are not in the Elixir home directory!"
            echo "Current Elixir home: $ELIXIR_HOME"
            echo "Run \"elixir-start\", to set this directory as your Elixir home!"
        fi
    else
        echo "Elixir is not running, run: elixir-start"
    fi
}
