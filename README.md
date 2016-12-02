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

# Update a component/container
$sp->ComponentStatusUpdate({
        components     => ['component-id-list'],
        containers     => ['component-container-list'],
        details        => "On Fire",
        current_status => 500
        });

```

All methods are CamelCased versions of the API call.  Eg "incident/list" is $sp->IncidentList();

## ToDo
This is a bare-bones POC implementation of the API.  There is little to no error checking.  It will be worked on more seriously if/when we start using status.io for something more than a POC.

ToDo List:
* add more error handling for non-api related failure modes (eg missing parameters)
* add appropriate POD documentation
* test suite
* consider refactoring so that we return proper perl objects rather than complex datastructures.  This would make things like "what's the current status of this container/component" easier to answer.
