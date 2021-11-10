
/* Creating Schema */
/* Here Schema name is invitation */
DROP SCHEMA IF  EXISTS invitation CASCADE;
CREATE SCHEMA Invitation ;
SET SEARCH_PATH TO invitation ;



/* Sequences */
CREATE SEQUENCE OBJECT_ID_SEQ                   START 1 INCREMENT 1;
CREATE SEQUENCE ROW_ID_SEQ                      START 1 INCREMENT 1;


/* Enums */
CREATE TYPE OBJECT_TYPE   AS ENUM (
'PERSON',
'INVITATION',
'LOGIN'
);


/* Tables */
CREATE TABLE CASSINI_OBJECT (
    OBJECT_ID                   INTEGER             NOT NULL PRIMARY KEY,
    CREATED_DATE                TIMESTAMP           NOT NULL DEFAULT now(),
    MODIFIED_DATE               TIMESTAMP           NOT NULL DEFAULT now(),
    OBJECT_TYPE                 OBJECT_TYPE         NOT NULL
);


CREATE TABLE PERSON (
  PERSON_ID     INTEGER                  NOT NULL PRIMARY KEY,
  FIRST_NAME    VARCHAR(32),
  LAST_NAME     VARCHAR(32),
  MIDDLE_NAME   VARCHAR(32),
  PHONE_OFFICE  VARCHAR(100),
  PHONE_MOBILE  VARCHAR(100),
  EMAIL         VARCHAR(100),
  IMAGE         BYTEA,
  FOREIGN KEY (PERSON_ID) REFERENCES CASSINI_OBJECT (OBJECT_ID) ON DELETE CASCADE
);


CREATE TABLE LOGIN (
    LOGIN_ID                    INTEGER             NOT NULL PRIMARY KEY,
    LOGIN_NAME                  VARCHAR(50)         NOT NULL UNIQUE,
    PERSON_ID                   INTEGER             NOT NULL UNIQUE REFERENCES PERSON (PERSON_ID) ON DELETE CASCADE,
    PASSWORD                    TEXT                NOT NULL,
    FINGERPRINTDATA             TEXT                ,
    IS_ACTIVE                   BOOLEAN             NOT NULL,
    IS_LOCKED                   BOOLEAN             DEFAULT FALSE,
    IS_SUPERUSER                BOOLEAN             DEFAULT FALSE,
    EXTERNAL                    BOOLEAN             DEFAULT FALSE,
    FOREIGN KEY (LOGIN_ID)      REFERENCES          CASSINI_OBJECT (OBJECT_ID) ON DELETE CASCADE
);


CREATE TABLE INVITATION (

  ID              INTEGER            NOT NULL PRIMARY KEY,
  NAME            TEXT,
  INFORMATION     VARCHAR(250),
  DATE_VALUE      DATE DEFAULT CURRENT_DATE,
  TIME_VALUE      TIME DEFAULT CURRENT_TIME,
  PHONE_MOBILE    TEXT,
  INVITEDBY       INTEGER           NOT NULL REFERENCES PERSON (PERSON_ID) ON DELETE CASCADE,
  ADDRESS         TEXT,
  FOREIGN KEY (ID) REFERENCES CASSINI_OBJECT (OBJECT_ID) ON DELETE CASCADE

);


CREATE TABLE INVITE_PERSON (

 ID               INTEGER            NOT NULL PRIMARY KEY,
 INVITATION       INTEGER            NOT NULL REFERENCES INVITATION(ID),
 PERSON           INTEGER            NOT NULL REFERENCES PERSON(PERSON_ID)

);

/* Alter Statements*/
ALTER TABLE CASSINI_OBJECT ADD COLUMN CREATED_BY INTEGER REFERENCES PERSON (PERSON_ID) ON DELETE CASCADE;
ALTER TABLE CASSINI_OBJECT ADD COLUMN MODIFIED_BY INTEGER REFERENCES PERSON (PERSON_ID) ON DELETE CASCADE;




/* Insert Statements*/

INSERT INTO CASSINI_OBJECT (OBJECT_ID, CREATED_DATE, CREATED_BY, MODIFIED_DATE, OBJECT_TYPE)
    VALUES (nextval('OBJECT_ID_SEQ'), default, null, default, 'PERSON');
INSERT INTO PERSON (PERSON_ID, FIRST_NAME)
    VALUES (currval('OBJECT_ID_SEQ'), 'Administrator');

INSERT INTO CASSINI_OBJECT (OBJECT_ID, CREATED_DATE, CREATED_BY, MODIFIED_DATE, OBJECT_TYPE)
    VALUES (nextval('OBJECT_ID_SEQ'), default, null, default, 'LOGIN');
INSERT INTO LOGIN (LOGIN_ID, LOGIN_NAME, PERSON_ID, PASSWORD, IS_ACTIVE,IS_LOCKED,IS_SUPERUSER)
    VALUES (currval('OBJECT_ID_SEQ'), 'admin', 1, '$2a$10$obVTeK7h/NcihDIfxjcNge9zHxN.BR4yZhpJBauBWuYBZAN2kDZvG', TRUE,FALSE,TRUE);


INSERT INTO CASSINI_OBJECT (OBJECT_ID, CREATED_DATE, CREATED_BY, MODIFIED_DATE, OBJECT_TYPE)
VALUES (nextval('OBJECT_ID_SEQ'), default, null, default, 'LOGIN');
INSERT INTO INVITATION VALUES (currval('OBJECT_ID_SEQ'), 'Aniversary', 'This is Cassini Systems Aniversary Invitation', default, default, '7675828864', 1, 'Mangalpally, Ibrahimpatnam');

INSERT INTO CASSINI_OBJECT (OBJECT_ID, CREATED_DATE, CREATED_BY, MODIFIED_DATE, OBJECT_TYPE)
VALUES (nextval('OBJECT_ID_SEQ'), default, null, default, 'LOGIN');

INSERT INTO INVITATION VALUES (currval('OBJECT_ID_SEQ'), 'New Office Opening', 'This is Cassini Systems New Office Opening Invitation', default, default, '9701030235', 1, 'Hyderabad, India');

CREATE SEQUENCE hibernate_sequence START 2;
