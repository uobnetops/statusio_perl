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


# Components & Containers
sub ComponentList {
  my $self = shift;

  return $self->_doGet($self->API_URL."component/list/".$self->StatusPageID);
}

sub ComponentStatusUpdate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."component/status/update", $data);
}

# Incidents - TODO
sub IncidentList {
  my $self = shift;

  return $self->_doGet($self->API_URL."incident/list/".$self->StatusPageID);
}
sub IncidentMessage {
  my $self = shift;
  my ($MessageID) = @_;
  
  return $self->_doGet($self->API_URL."incident/message/".$self->StatusPageID."/".$MessageID);
}
sub IncidentCreate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."incident/create", $data);
}
sub IncidentUpdate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."incident/update", $data);
}
sub IncidentResolve {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."incident/resolve", $data);
}
sub IncidentDelete {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."incident/delete", $data);
}

# Maintenance - TODO
sub MaintenanceList {
  my $self = shift;
  return $self->_doGet($self->API_URL."maintenance/list/".$self->StatusPageID);
}
sub MaintenanceMessage {
  my $self = shift;
  my ($MessageID) = @_;
  
  return $self->_doGet($self->API_URL."maintenance/message/".$self->StatusPageID."/".$MessageID);
}
sub MaintenanceSchedule {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."maintenance/schedule", $data);
}
sub MaintenanceStart {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."maintenance/start", $data);
}
sub MaintenanceUpdate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."maintenance/update", $data);
}
sub MaintenanceFinish {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."maintenance/finish", $data);
}
sub MaintenanceDelete {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."maintenance/delete", $data);
}

# Metrics - TODO
sub MetricUpdate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."metreic/update", $data);
}

# Status
sub StatusSummary {
  my $self = shift;

  return $self->_doGet($self->API_URL."status/summary/".$self->StatusPageID);
}

# Subscribers - TODO
sub SubscriberList {
  my $self = shift;
  
  return $self->_doGet($self->API_URL."subscriber/list/".$self->StatusPageID);
}
sub SubscriberAdd {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."subscriber/add", $data);
}
sub SubscriberUpdate {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."subscriber/update", $data);
}
sub SubscriberRemove {
  my $self = shift;
  my ($data) = @_;
  
  $$data{statuspage_id} = $self->StatusPageID;
  return $self->_doPost($self->API_URL."subscriber/remove", $data);
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
    return $self->_doDecode($resp->decoded_content);
  }
  else {
    return $self->_doError("HTTP GET Error: $resp->code(), $resp->message()");
  }
}

sub _doPost {
  my $self = shift;
  my ($url, $data) = @_;

  my $ua = LWP::UserAgent->new(timeout => 10);
  $ua->default_header('x-api-id' => $self->API_ID() );
  $ua->default_header('x-api-key' => $self->API_Key() );
  $ua->default_header('Content-Type' => 'application/json');
  
  my $json = JSON->new->allow_nonref;
  
  # warn $json->encode($data);
  
  my $resp = $ua->post($url, Content => $data);
   
  if ($resp->is_success) {
    return $self->_doDecode($resp->decoded_content);
  }
  else {
    return $self->_doError("HTTP POST Error: $resp->code(), $resp->message()");
  }

}

sub _doDecode {
  my $self  = shift;
  my ($obj) = @_;

  my $json = JSON->new->allow_nonref;
  return $json->decode($obj);
}

sub _doError {
  my $self  = shift;
  my ($txt) = @_;
  
  return $self->_doDecode(qq|{"status":{"error":"yes","message":"$txt"}}|);
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
