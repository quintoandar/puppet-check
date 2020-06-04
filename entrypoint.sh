#!/bin/bash

function help-usage { 
    echo -e '
USAGE: 
    docker container run --rm -it \
      -v /path/to/manifests:/manifests/ \
        quintoandar/puppet-check \
          subcommand [arguments...]

Available subcommands:

  validate              Validates Puppet DSL syntax 
  lint                  Verify style guide conformity
'
}

function help-validate { 
    echo -e '
USAGE: 
    docker container run --rm -it \
      -v /path/to/manifests:/manifests/ \
          quintoandar/puppet-check \
            validate <directory>

This action validates Puppet DSL syntax without compiling a catalog or
syncing any resources. If no manifest files are provided, it will
validate the default site manifest.

RETURNS: Nothing, or the first syntax error encountered

OPTIONS:
        --version
            Display Puppet Current Version

        --default
            Scan default manifest folder (current)
'
}

function help-lint { 
    echo -e '
USAGE: 
    docker container run --rm -it \
      -v /path/to/manifests:/manifests/ \
        quintoandar/puppet-check \
          lint <directory>

This action check Puppet Manifests for style guide conformity

OPTIONS:
        --version
            Display Puppet Lint Current Version
        --default
            Scan default manifest folder (current)
'
}

if [ "$#" == "0" ] || [ "$1" == "--help" ]
  then
    help-usage
    exit 0
  elif [ "$1" == "validate" ]
    then
      if [ "$2" == "" ] || [ "$2" == "--help" ]
        then
            help-validate
      elif [ "$2" == "--version" ]
        then
          v=$(puppet --version)
          echo "Puppet Version: $v"
      elif [ "$2" == "--default" ]    
        then
            puppet parser validate $(find /manifests/ -name "*.pp")
        else
            puppet parser validate $2 
      fi
  elif [ "$1" == "lint" ]
    then
      if [ "$2" == "" ] || [ "$2" == "--help" ]
        then
            help-lint
            exit 0
      elif [ "$2" == "--version" ]
        then
          v=$(puppet-lint --version | cut -d " " -f 2)
          echo "Puppet Lint Version: $v"
      elif [ "$2" == "--default" ]    
        then
            puppet-lint /manifests/*
        else
            puppet-lint $2
      fi
  else 
    help-usage
    exit 0
fi
