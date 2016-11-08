CREATE TABLE account(
    account_id serial PRIMARY KEY,
    data jsonb NOT NULL
);

CREATE UNIQUE INDEX idxbtreeemail ON account USING BTREE ((data -> 'email'));
