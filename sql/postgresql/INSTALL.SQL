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

-- DOMENY BAZY

CREATE DOMAIN ticket_status AS smallint
CHECK(VALUE BETWEEN 1 AND 5);
  
CREATE DOMAIN comment_type AS SMALLINT
CHECK(VALUE BETWEEN 0 AND 6);

CREATE DOMAIN event_type AS SMALLINT
CHECK(VALUE BETWEEN 1 AND 12);
  
CREATE DOMAIN user_role AS SMALLINT
DEFAULT 1
CHECK(VALUE IN(1, 10, 100));

CREATE DOMAIN ticket_priority AS SMALLINT
CHECK(VALUE BETWEEN 1 AND 5);

--- TABELE i SEKWENCJE

--- ### użytkownicy

CREATE SEQUENCE user_id_seq
  START 2 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE users (
  user_id integer NOT NULL DEFAULT nextval(('public.user_id_seq'::text)::regclass),
  first_name character varying(64),
  last_name character varying(128),
  email character varying(128) NOT NULL,
  passw character varying(40) NOT NULL,
  phone character varying(30),
  mobile character varying(20),
  app_role user_role NOT NULL DEFAULT 0,
  is_active boolean NOT NULL DEFAULT false,
  CONSTRAINT hd_plain_user_pkey PRIMARY KEY (user_id),
  CONSTRAINT users_email_key UNIQUE (email)
) WITH (OIDS=FALSE)
;

-- PREFERENCJE UZYTKOWNIKA

CREATE TABLE user_preferences (
  id integer NOT NULL,
  welcome_page character varying(128) NOT NULL,
  locale character varying(32) NOT NULL,
  filter_id integer,
  new_ticket_form_view character varying(16),
  tickets_list_size integer NOT NULL DEFAULT 10,
  announcements_list_size integer NOT NULL DEFAULT 10,
  users_list_size integer NOT NULL DEFAULT 10,
  filters_list_size integer NOT NULL DEFAULT 10,
  articles_list_size integer NOT NULL DEFAULT 10,
  search_result_limit integer NOT NULL DEFAULT 10,
  CONSTRAINT laf_preferences_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

--- ### kategorie zgłoszeń

CREATE SEQUENCE ticket_category_id_seq
  START 2 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket_category (
  id integer NOT NULL DEFAULT nextval(('public.ticket_category_id_seq'::text)::regclass),
  category_name character varying(64) NOT NULL,
  category_desc character varying(255),
  is_active boolean NOT NULL DEFAULT true,
  ord integer NOT NULL DEFAULT 1,
  tickets_count integer NOT NULL DEFAULT 0,
  is_default boolean NOT NULL DEFAULT false, -- TODO: dodać check taki, zeby tylko jedna kategoria była domyślna
  CONSTRAINT ticket_category_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

CREATE INDEX ticket_category_is_active_idx
  ON ticket_category
  USING btree
  (is_active)
;

--- ### zgłoszenia

CREATE SEQUENCE ticket_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket (
  id integer NOT NULL DEFAULT nextval(('public.ticket_id_seq'::text)::regclass),
  ticket_category integer NOT NULL,
  priority ticket_priority NOT NULL,
  status ticket_status NOT NULL,
  saviour integer,
  notifier integer NOT NULL,
  inputer integer NOT NULL,
  created_at timestamp with time zone NOT NULL,
  subject character varying(255) NOT NULL,
  description character varying(8192) NOT NULL,
  step_by_step character varying(16384),
  CONSTRAINT ticket_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_notifier_fk FOREIGN KEY (notifier)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_inputer_fk FOREIGN KEY (inputer)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_fk FOREIGN KEY (ticket_category)
      REFERENCES ticket_category (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

CREATE SEQUENCE ticket_add_files_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE ticket_additional_files (
  id integer NOT NULL DEFAULT nextval('ticket_add_files_id_seq'::regclass),
  ticket_id integer NOT NULL,
  user_id integer NOT NULL,
  created_at time without time zone NOT NULL DEFAULT now(),
  original_filename character varying(128) NOT NULL,
  hashed_filename character varying(64) NOT NULL,
  file_size integer NOT NULL,
  content_type character varying(64) NOT NULL,
  digest character varying(64) NOT NULL,
  CONSTRAINT ticket_additional_files_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_additional_files_ticket_id_fkey FOREIGN KEY (ticket_id)
      REFERENCES ticket (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT additional_files_user_id_fk FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
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
  event_type event_type NOT NULL DEFAULT 0,
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
  ticket_id integer NOT NULL,
  user_id integer NOT NULL,
  comment_date timestamp with time zone NOT NULL,
  comment_text character varying(4096) NOT NULL,
  comment_type comment_type NOT NULL DEFAULT 0,
  not_for_plain_user boolean NOT NULL DEFAULT false,
  CONSTRAINT ticket_comment_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_comment_ticket_id_fkey FOREIGN KEY (ticket_id)
      REFERENCES ticket (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ticket_comment_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
) WITH (OIDS=FALSE)
;

--- FILTRY

CREATE SEQUENCE ticket_filter_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;
CREATE TABLE ticket_filters (
  id integer NOT NULL DEFAULT nextval('ticket_filter_id_seq'::regclass),
  user_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  "name" character varying(32) NOT NULL,
  tfstamp character varying(40) NOT NULL,
  begin_date timestamp(0) without time zone,
  end_date timestamp(0) without time zone,
  description character varying(512),
  priorities text,
  statuses text,
  CONSTRAINT ticket_filters_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_filters_fk FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_filters_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ticket_filters_tf_stamp_key UNIQUE (tfstamp)
) WITH (OIDS=FALSE);

CREATE SEQUENCE ticket_filters_notifiers_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;
CREATE TABLE ticket_filters_notifiers (
  id integer NOT NULL DEFAULT nextval('ticket_filters_notifiers_id_seq'::regclass),
  ticket_filter_id integer NOT NULL,
  user_id integer NOT NULL,
  CONSTRAINT ticket_filters_notifiers_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_filters_notifiers_ticket_filter_id_fkey FOREIGN KEY (ticket_filter_id)
      REFERENCES ticket_filters (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_filters_notifiers_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

CREATE SEQUENCE ticket_filters_saviours_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;
CREATE TABLE ticket_filters_saviours (
  id integer NOT NULL DEFAULT nextval('ticket_filters_saviours_id_seq'::regclass),
  ticket_filter_id integer NOT NULL,
  user_id integer NOT NULL,
  CONSTRAINT ticket_filters_saviours_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_filters_saviours_ticket_filter_id_fkey FOREIGN KEY (ticket_filter_id)
      REFERENCES ticket_filters (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_filters_saviours_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);

CREATE SEQUENCE ticket_filters_ticket_categories_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;
CREATE TABLE ticket_filters_ticket_categories (
  id integer NOT NULL DEFAULT nextval('ticket_filters_ticket_categories_id_seq'::regclass),
  ticket_filter_id integer NOT NULL,
  ticket_category_id integer NOT NULL,
  CONSTRAINT ticket_filters_ticket_categories_pkey PRIMARY KEY (id),
  CONSTRAINT ticket_filters_ticket_categories_ticket_category_id_fkey FOREIGN KEY (ticket_category_id)
      REFERENCES ticket_category (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ticket_filters_ticket_categories_ticket_filter_id_fkey FOREIGN KEY (ticket_filter_id)
      REFERENCES ticket_filters (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS=FALSE);


--- ### BAZA WIEDZY

--- ### kategorie w bazie wiedzy

CREATE SEQUENCE article_category_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE article_category (
  id integer NOT NULL DEFAULT nextval(('article_category_id_seq'::text)::regclass),
  category_name character varying(128) NOT NULL,
  ord integer NOT NULL DEFAULT 1,
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
  id integer NOT NULL DEFAULT nextval(('article_id_seq'::text)::regclass),
  category_id integer NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp with time zone NOT NULL,
  lead character varying(4096),
  body text DEFAULT 16384,
  user_id integer NOT NULL,
  ord integer NOT NULL DEFAULT 1,
  CONSTRAINT article_pkey PRIMARY KEY (id),
  CONSTRAINT article_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
) WITH (OIDS=FALSE)
;

--- ### komentarze do artykułów

CREATE SEQUENCE article_comment_id_seq
  START 1 INCREMENT 1 CACHE 1
  MINVALUE 1 MAXVALUE 9223372036854775807
;

CREATE TABLE article_comment (
  id integer NOT NULL DEFAULT nextval(('article_comment_id_seq'::text)::regclass),
  article_id integer NOT NULL,
  user_id integer NOT NULL,
  create_at timestamp with time zone NOT NULL,
  title character varying(255) NOT NULL,
  body character varying(4096) NOT NULL,
  CONSTRAINT article_comment_pkey PRIMARY KEY (id),
  CONSTRAINT article_comment_article_id_fkey FOREIGN KEY (article_id)
      REFERENCES article (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT article_comment_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
) WITH (OIDS=FALSE)
;

--- ### wiazanie zgloszen z artykulami w bazie wiedzy

CREATE TABLE article_ticket (
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
  id integer NOT NULL DEFAULT nextval(('announcement_id_seq'::text)::regclass),
  user_id integer NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  title character varying(255) NOT NULL,
  lead character varying(4096) NOT NULL,
  CONSTRAINT announcement_pkey PRIMARY KEY (id),
  CONSTRAINT announcement_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (user_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT
) WITH (OIDS=FALSE)
;

CREATE TABLE announcement_body (
  id integer NOT NULL,
  body character varying(16384) NOT NULL,
  CONSTRAINT announcement_body_announcement_id_fkey FOREIGN KEY (id)
      REFERENCES announcement (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT announcement_body_announcement_id_key PRIMARY KEY (id)
) WITH (OIDS=FALSE)
;

-- PIERWSZY UZYTKOWNIK i PREFERENCJE DLA NIEGO
INSERT INTO users(user_id, passw, email, app_role, is_active)
    VALUES (1, '849b563ed0cfa086b0c33d2772e26e098903a3f3', 'admin@localhost.localdomain', 100, true);
INSERT INTO user_preferences(id, welcome_page, locale, new_ticket_form_view,
                             tickets_list_size, announcements_list_size, users_list_size,
                             filters_list_size, articles_list_size, search_result_limit)
    VALUES (1, 'desktop', 'pl__', 'form', 25, 25, 25, 25, 25, 25);

-- DOMYSLNA KATEGORIA DLA NOWYCH ZGLOSZEN
INSERT INTO ticket_category (id, category_name, is_active, ord, tickets_count, is_default)
    VALUES (1, 'Default category', true, 0, 0, true);
