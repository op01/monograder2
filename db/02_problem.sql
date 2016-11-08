CREATE TABLE problem(
    problem_id serial PRIMARY KEY,
    data jsonb NOT NULL
);

CREATE INDEX idxbtreedisplay ON problem USING BTREE ((data -> 'display'));
