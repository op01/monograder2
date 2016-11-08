package Codecute::Model::Submission;
use Mojo::Base -base;

has 'pg';

sub createSubmission {
    my ($self,$problem_id,$account_id,$source_code,$language) = @_;
    my $id = $self->pg->db->query('insert into submission (problem_id,account_id,data) values (?,?,?) returning submission_id',
        $problem_id,
        $account_id,
        {json=>{
            language => $language,
            source_code => $source_code,
            status => 'waiting',
            result => ''
        }}
    )->arrays->first->[0];
    return $id;
}
sub getSubmissionInfo {
    my ($self,$id) = @_;
    my $submission_info = $self->pg->db->query('select * from submission where submission_id = ?',$id)->expand->hashes->first;
    return $submission_info;
}

sub updateSubmissionInfo {
    my ($self,$id,$data) = @_;
    $self->pg->db->query('update submission set data=data||? where submission_id = ?',{json => $data},$id);
}

1;
