# Puppet Check Container
Parser and Validate  verifier for Puppet Manifests

Make sure that you mount a volume with the manifests that you would like to verify to /manifests

### Usage
`docker container run --rm -it -v /path/to/manifests:/manifests/ quintoandar/puppet-check --help`

### Available subcommands:

- **validate** - Validates Puppet DSL syntax   
  - Reference: _puppet parser validate_

- **lint** - Verify style guide conformity  
  - Reference: _puppet-lint_

