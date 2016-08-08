#!/usr/bin/perl
package statusio;

use JSON;
use LWP::UserAgent;
use Data::Dumper;

sub new {
  my $class = shift;

  my %params = @_;

  my $self = bless {
    statuspage_id => $params{statuspage_id},
    api_id        => $params{api_id},
    api_key       => $params{api_key},
    api_url       => "https://api.status.io/v2/"
  }, $class;

  return $self;
}


# Components & Containers - TODO
sub ComponentList {
  my $self = shift;

  my $rv = $self->_doGet($self->API_URL."component/list/".$self->StatusPageID);
  return $self->_doDecode($rv);
}

sub ComponentStatusUpdate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}

# Incidents - TODO
sub IncidentList {
  my $self = shift;
  my $rv = $self->_doGet($self->API_URL."incident/list/".$self->StatusPageID);
  return $self->_doDecode($rv);
}
sub IncidentMessage {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub IncidentCreate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub IncidentUpdate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub IncidentResolve {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub IncidentDelete {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}

# Maintenance - TODO
sub MaintenanceList {
  my $self = shift;
  my $rv = $self->_doGet($self->API_URL."maintenance/list/".$self->StatusPageID);
  return $self->_doDecode($rv);
}
sub MaintenanceMessage {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub MaintenanceSchedule {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub MaintenanceStart {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub MaintenanceUpdate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub MaintenanceFinish {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub MaintenanceDelete {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}

# Metrics - TODO
sub MetricUpdate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}

# Status
sub StatusSummary {
  my $self = shift;

  my $rv = $self->_doGet($self->API_URL."status/summary/".$self->StatusPageID);
  return $self->_doDecode($rv);
}

# Subscribers - TODO
sub SubscriberList {
  my $self = shift;
  my $rv = $self->_doGet($self->API_URL."subscriber/list/".$self->StatusPageID);
  return $self->_doDecode($rv);
}
sub SubscriberAdd {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub SubscriberUpdate {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}
sub SubscriberRemove {
  my $self = shift;
  die "Method Not Implemented... Yet";
  return undef;
}











# Internal Functions
sub _doGet {
  my $self  = shift;
  my ($url) = @_;

  my $ua = LWP::UserAgent->new(timeout => 10);
  $ua->default_header('x-api-id' => $self->API_ID() );
  $ua->default_header('x-api-key' => $self->API_Key() );
  my $resp = $ua->get($url);
  
  if ($resp->is_success) {
    return $resp->decoded_content;
  }
  else {
    die Dumper $resp;
    return undef;
  }
}

sub _doDecode {
  my $self  = shift;
  my ($obj) = @_;

  my $json = JSON->new->allow_nonref;
  return $json->decode($obj);
}

# Accessors
sub StatusPageID {
  my $self = shift;
  return $self->{statuspage_id};
}

sub API_ID {
  my $self = shift;
  return $self->{api_id};
}

sub API_Key {
  my $self = shift;
  return $self->{api_key};
}

sub API_URL {
  my $self = shift;
  return $self->{api_url};
}



# Package return
return 1;
