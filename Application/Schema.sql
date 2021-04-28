-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE installers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE negotiations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    installer_id UUID NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TABLE messages (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    negotiation_id UUID NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    sent_by UUID DEFAULT uuid_generate_v4() NOT NULL
);
ALTER TABLE messages ADD CONSTRAINT messages_ref_negotiation_id FOREIGN KEY (negotiation_id) REFERENCES negotiations (id) ON DELETE NO ACTION;
ALTER TABLE negotiations ADD CONSTRAINT negotiations_ref_installer_id FOREIGN KEY (installer_id) REFERENCES installers (id) ON DELETE NO ACTION;
ALTER TABLE negotiations ADD CONSTRAINT negotiations_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
