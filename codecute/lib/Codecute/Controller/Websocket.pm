package Codecute::Controller::Websocket;
use Mojo::Base 'Mojolicious::Controller';

sub ws {
    my $self=shift;
    $self->on(json=>sub {
        
    });
    $self->on(finish=>sub {

    });
}

1;
