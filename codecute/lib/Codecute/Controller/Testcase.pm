package Codecute::Controller::Testcase;
use Mojo::Base 'Mojolicious::Controller';

sub create {
    my $self = shift;
    my $data = $self->req->json;
    my $id=$self->problem->createTest($self->param('problem_id'),$data->{in},$data->{out});
    $self->render(json=>{success=>\1});
}

1;
