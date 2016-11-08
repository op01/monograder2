package Codecute::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';

sub check {
    my $self = shift;
    my $id = $self->session->{id};
    if($id){
        my $info = $self->account->getAccountInfo($id);
        $self->stash(account_info=>$info);
        return 1;
    }
    $self->app->log->info('Unauthenticated access');
    $self->render(text=>'error');
    return undef;
}

sub checkAdmin {
    my $self = shift;
    return 1 if $self->stash('account_info')->{role} eq 'admin';
    $self->app->log->info('Unauthorized access');
    $self->render(text=>'error');
    return undef;
}

sub ok {
    my $self = shift;
    my $email = $self->session->{email};
    return $self->render(text=>'error') unless $email;
    $self->account->createAccount($email) unless $self->account->auth($email);
    my $id = $self->account->getAccountIdByEmail($email);
    $self->session->{id} = $id;
    $self->app->log->info("$email AccountId $id logged in");
    $self->redirect_to('/');
}

sub toFacebook {
    my $self = shift;
    my $url = $self->oauth->getFacebookAuthUrl();
    $self->redirect_to($url);
}

sub fromFacebook {
    my $self = shift;
    my $token = $self->oauth->getFacebookToken($self->param('code'));
    my $email = $self->oauth->getFacebookEmail($token);
    # $self->session->{token} = $token;
    $self->session->{email} = $email;
    $self->redirect_to('/login/ok');
}

1;
