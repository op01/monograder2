package Codecute::Model::Account;
use Mojo::Base -base;

has 'pg';

sub auth {
    my ($self,$email) = @_;
    my $count = $self->pg->db->query("select count(*) from account where data ->> 'email' = ?",$email)->arrays->first->[0];
    return $count;
}

sub createAccount {
    my ($self,$email) = @_;
    $self->pg->db->query('insert into account (data) values (?)',{json=>{
        email => $email,
        info => {
            role => 'user'
        }
    }});
}

sub getAccountIdByEmail {
    my ($self,$email) = @_;
    my $id = $self->pg->db->query("select account_id from account where data ->> 'email' = ?",$email)->arrays->first->[0];
    return $id;
}

sub getAccountInfo {
    my ($self,$id) = @_;
    my $info = $self->pg->db->query("select data -> 'info' from account where account_id = ?",$id)->expand->arrays->first->[0];
    return $info;
}

1;
