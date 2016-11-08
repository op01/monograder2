package Codecute::Controller::Account;
use Mojo::Base 'Mojolicious::Controller';

sub me {
    my $self = shift;
    my $id = $self->session->{id};
    if($id){
        my $data=$self->account->getAccountInfo($id);
        $self->render(json=>$data);
    }
    else{
        $self->render(json=>{
            role=>'guest'
        });
    }
}

1;
