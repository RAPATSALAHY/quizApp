CREATE EXTENSION IF NOT EXISTS "pgcrypto";-- Pour permettre la génération d'UUID

CREATE TABLE t_quiz (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Utilisation de gen_random_uuid() pour générer un UUID
    title VARCHAR(100) NOT NULL,                    -- Le titre du quiz
    description TEXT,                               -- La description du quiz
    tags VARCHAR(255),                              -- Les tags associés au quiz
    thumbnail VARCHAR(255)                          -- L'URL ou le chemin vers la miniature du quiz
);

create table t_user(
 id UUID primary key default gen_random_uuid(),
 email VARCHAR(100) not null,
 nom VARCHAR(100) not null,
 image VARCHAR (150),
 provider VARCHAR (100)
)

alter table t_quiz alter column description type varchar(255);

CREATE TABLE t_user_quiz (
    user_id UUID NOT NULL,                          -- Identifiant de l'utilisateur
    quiz_id UUID NOT NULL,                          -- Identifiant du quiz
    played_at TIMESTAMP NOT NULL DEFAULT NOW(),     -- Date et heure où l'utilisateur a joué au quiz
    PRIMARY KEY (user_id, quiz_id),                 -- Clé primaire composite (user_id, quiz_id)
    FOREIGN KEY (user_id) REFERENCES t_user(id) ON DELETE CASCADE,  -- Relation avec la table t_user
    FOREIGN KEY (quiz_id) REFERENCES t_quiz(id) ON DELETE CASCADE   -- Relation avec la table t_quiz
);

CREATE TABLE t_user_quiz (
    user_id UUID NOT NULL,                          -- Identifiant de l'utilisateur
    quiz_id UUID NOT NULL,                          -- Identifiant du quiz
    played_at TIMESTAMP NOT NULL DEFAULT NOW(),     -- Date et heure où l'utilisateur a joué au quiz
    correct_questions_number INTEGER,               -- Nombre de questions correctes (nouvelle colonne)
    PRIMARY KEY (user_id, quiz_id),                 -- Clé primaire composite (user_id, quiz_id)
    FOREIGN KEY (user_id) REFERENCES t_user(id) ON DELETE CASCADE,  -- Relation avec la table t_user
    FOREIGN KEY (quiz_id) REFERENCES t_quiz(id) ON DELETE CASCADE   -- Relation avec la table t_quiz
);

create table t_quiz_question(
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- ID de type UUID, généré automatiquement
question VARCHAR(255) NOT NULL,                  -- La question du quiz
options VARCHAR(255),                            -- Les options de réponse sous forme de texte
answer_index INTEGER NOT NULL,                   -- L'index de la réponse correcte
quiz_id UUID NOT NULL,                           -- Identifiant du quiz auquel la question appartient
FOREIGN KEY (quiz_id) REFERENCES t_quiz(id) ON DELETE CASCADE  -- Relation avec la table t_quiz
);

ALTER TABLE t_user_quiz RENAME TO t_quiz_play;