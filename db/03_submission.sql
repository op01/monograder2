CREATE TABLE submission(
    submission_id serial PRIMARY KEY,
    problem_id integer REFERENCES problem,
    account_id integer REFERENCES account,
    data jsonb NOT NULL
);

CREATE INDEX idxbtreeproblem ON submission USING BTREE (problem_id);
CREATE INDEX idxbtreeaccount ON submission USING BTREE (account_id);
