# statusio_perl
prototype perl module for the status.io API

Intention is to implement V2.0 of the API as described at http://docs.statusio.apiary.io

I'll write some POD docs later, but for now - to use it do something like:
```
use lib ".";
use statusio;

my $sp = new statusio(
  statuspage_id => '$statuspage_id',
  api_id        => '$api_id',
  api_key       => '$api_key
  );

my $statusSummary = $sp->StatusSummary();
```

All methods are CamelCased versions of the API call.  Eg "incident/list" is $sp->IncidentList();

## ToDo
This is a bare-bones POC implementation of the API.  Most methods are not yet implemented, and there is little to no error checking.  It will be worked on more seriously if/when we start using status.io for something more than a POC.

ToDo List:
* refactor parameter passing to ComponentStatusUpdate() to accept a datastructure rather than a parameter list
* parse replies from the API and return an appropriate perl datastructure rather than json
* add more error handling for non-api related failure modes
* implement the remaining methods
* add appropriate POD documentation
* test suite
