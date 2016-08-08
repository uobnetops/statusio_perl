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
