package Codecute::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;
  # Render template "example/welcome.html.ep" with message
  $self->session->{GG}=1;
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}
sub test {
    my $self=shift;
    $self->render(json=>$self->req->json);
}

1;
