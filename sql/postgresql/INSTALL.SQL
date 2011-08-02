 -- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3 of the License.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.
--
-- Copyright: (C) 2006 jHelpdesk Developers Team
---

--- W tym pliku znajdują się wszystkie definicje obiektów bazy danych
--- potrzebnych do uruchomienia systemu jHelpdesk.

--- TABELE i SEKWENCJE

--- ### użytkownicy

CREATE SEQUENCE user_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE users (
  user_id integer NOT NULL DEFAULT nextval(('public.user_id_seq'::text)::regclass),
  passw character varying(40) NOT NULL,
  first_name character varying(64),
  last_name character varying(128),
  email character varying(128) NOT NULL,
  phone character varying(30),
  mobile character varying(20),
  "role" smallint NOT NULL DEFAULT 0,
  is_active boolean,
  CONSTRAINT plain_user_pkey PRIMARY KEY (user_id)
) WITH (OIDS=FALSE)
;

--- ### kategorie zgłoszeń

CREATE SEQUENCE ticket_category_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket_category (
  id integer NOT NULL DEFAULT nextval(('public.ticket_category_id_seq'::text)::regclass),
  category_name character varying(64) NOT NULL,
  category_desc character varying(255),
  is_active boolean NOT NULL DEFAULT true,
  ord integer NOT NULL DEFAULT 1,
  tickets_count integer NOT NULL DEFAULT 0,
  CONSTRAINT ticket_category_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

CREATE INDEX ticket_category_is_active_idx
  ON ticket_category
  USING btree
  (is_active)
;

INSERT INTO ticket_category (id, category_name, category_desc, t_left, t_right, t_depth) 
    VALUES (0, 'uncategorized', 'default category', 1, 2, 0);

--- ### zgłoszenia

CREATE SEQUENCE ticket_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket (
  id integer NOT NULL DEFAULT nextval(('public.ticket_id_seq'::text)::regclass),
  ticket_category integer NOT NULL,
  priority smallint NOT NULL,
  status integer NOT NULL,
  saviour integer,
  notifier integer NOT NULL,
  inputer integer NOT NULL,
  create_date timestamp with time zone,
  subject character varying(255) NOT NULL,
  description character varying(8192) NOT NULL,
  step_by_step character varying(16384),
  CONSTRAINT ticket_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_category_id_fk FOREIGN KEY (ticket_category)
    REFERENCES ticket_category (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

--- ### zdarzenia zgłoszeń

CREATE SEQUENCE ticket_event_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket_event (
  id integer NOT NULL DEFAULT nextval(('public.ticket_event_id_seq'::text)::regclass),
  ticket_id integer NOT NULL,
  event_date timestamp with time zone NOT NULL,
  user_id integer NOT NULL,
  event_type smallint NOT NULL DEFAULT 0,
  event_data character varying(255),
  CONSTRAINT ticket_event_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_event_ticket_id_fk FOREIGN KEY (ticket_id)
      REFERENCES ticket (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_event_user_id_fk FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE)
;
CREATE INDEX fki_ticket_event_ticket_id_fk
  ON ticket_event
  USING btree
  (ticket_id)
;
CREATE INDEX fki_ticket_event_user_id_fk
  ON ticket_event
  USING btree
  (user_id)
;

--- ### komentarze do zgłoszeń
CREATE SEQUENCE ticket_comment_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket_comment (
  id integer NOT NULL DEFAULT nextval(('public.ticket_comment_id_seq'::text)::regclass),
  user_id integer NOT NULL,
  comment_date timestamp with time zone NOT NULL,
  comment_text character varying(4096) NOT NULL,
  comment_type integer NOT NULL DEFAULT 0,
  not_for_plain_user boolean NOT NULL DEFAULT false,
  ticket_id integer NOT NULL,
  CONSTRAINT ticket_comment_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_comment_comment_author_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
) WITH (OIDS=FALSE)
;

--- ### BAZA WIEDZY

--- ### kategorie w bazie wiedzy

CREATE SEQUENCE article_category_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE article_category (
  id integer NOT NULL DEFAULT nextval(('public.article_category_id_seq'::text)::regclass),
  category_name character varying(255) NOT NULL,
  category_position integer NOT NULL,
  articles_count integer NOT NULL DEFAULT 0,
  CONSTRAINT article_category_pk PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

--- ### artukuły w bazie wiedzy

CREATE SEQUENCE article_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE article (
  article_id integer NOT NULL DEFAULT nextval(('public.article_id_seq'::text)::regclass),
  title character varying(255) NOT NULL,
  article_category_id integer NOT NULL,
  create_date date,
  lead text,
  body text,
  user_id integer,
  CONSTRAINT knownledge_pkey PRIMARY KEY (article_id)
) WITH (OIDS=FALSE)
;

--- ### komentarze do artykułów

CREATE SEQUENCE article_comment_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE article_comment (
  id integer NOT NULL DEFAULT nextval(('public.article_comment_id_seq'::text)::regclass),
  article_id integer NOT NULL,
  author integer NOT NULL,
  create_date date NOT NULL,
  title character varying(255) NOT NULL,
  body text NOT NULL,
  CONSTRAINT article_comment_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

--- ### wiazanie zgloszen z artykulami w bazie wiedzy

CREATE TABLE article_ticket
(
  article_id integer NOT NULL,
  ticket_id integer NOT NULL,
  CONSTRAINT article_ticket_pkey PRIMARY KEY (article_id, ticket_id),
  CONSTRAINT article_ticket_article_id_fkey FOREIGN KEY (article_id)
      REFERENCES article (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT article_ticket_ticket_id_fkey FOREIGN KEY (ticket_id)
      REFERENCES ticket (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE)
;

--- ### informacje od działu helpdesk

CREATE SEQUENCE announcement_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE announcement (
  id integer NOT NULL DEFAULT nextval(('public.announcement_id_seq'::text)::regclass),
  create_date date NOT NULL,
  title character varying(255) NOT NULL,
  lead character varying(4096) NOT NULL,
  CONSTRAINT announcement_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

CREATE INDEX announcement_create_date_idx
  ON announcement
  USING btree
  (created_at)
;

CREATE TABLE announcement_body (
  id integer NOT NULL,
  body character varying(16384) NOT NULL,
  CONSTRAINT announcement_body_announcement_id_fkey FOREIGN KEY (id)
      REFERENCES announcement (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT announcement_body_announcement_id_key UNIQUE (id)
) WITH (OIDS=FALSE)
;
