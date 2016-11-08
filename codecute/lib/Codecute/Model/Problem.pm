package Codecute::Model::Problem;
use Mojo::Base -base;

has 'pg';

sub createProblem {
    my ($self,$name,$body) = @_;
    my $id = $self->pg->db->query('insert into problem (data) values (?) returning problem_id',{json=>{
        name => $name,
        body => $body,
        display => 'hidden',
        test => []
    }})->arrays->first->[0];
    return $id;
}

sub listProblem {
    my $self = shift;
    my $problem = $self->pg->db->query("select problem_id,data ->> 'name' from problem where data ->> 'display' = 'show'")->hashes->to_array;
    return $problem;
}

sub listAllProblem {
    my $self = shift;
    my $problem = $self->pg->db->query("select problem_id,data ->> 'name' as name from problem")->hashes->to_array;
    return $problem;
}

sub getProblem {

}

sub createTest {
    my ($self,$id,$in,$out) = @_;
    $self->pg->db->query("update problem set data=jsonb_set(data,'{test}',data -> 'test' || ?) where problem_id = ?",{json=>{in=>$in,out=>$out}},$id);
}

sub getTest {
    my ($self,$id) = @_;
    my $testcases = $self->pg->db->query("select data -> 'test' from problem where problem_id = ?",$id)->expand->arrays->first->[0];
    return $testcases;
}

1;
