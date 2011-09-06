DROP TABLE announcement_body;
DROP TABLE announcement;

DROP TABLE article_category;
DROP TABLE article_comment;
DROP TABLE article_ticket;
DROP TABLE article;

DROP TABLE ticket_filters_notifiers;
DROP TABLE ticket_filters_saviours;
DROP TABLE ticket_filters_ticket_categories;
DROP TABLE ticket_filters;

DROP TABLE ticket_additional_files;
DROP TABLE ticket_comment;
DROP TABLE ticket_event;
DROP TABLE ticket;
DROP TABLE ticket_category;

DROP TABLE user_preferences;
DROP TABLE users;

DROP SEQUENCE announcement_id_seq;

DROP SEQUENCE article_category_id_seq;
DROP SEQUENCE article_comment_id_seq;
DROP SEQUENCE article_id_seq;

DROP SEQUENCE ticket_filters_notifiers_id_seq;
DROP SEQUENCE ticket_filters_saviours_id_seq;
DROP SEQUENCE ticket_filters_ticket_categories_id_seq;
DROP SEQUENCE ticket_filter_id_seq;

DROP SEQUENCE ticket_add_files_id_seq;
DROP SEQUENCE ticket_comment_id_seq;
DROP SEQUENCE ticket_event_id_seq;
DROP SEQUENCE ticket_id_seq;
DROP SEQUENCE ticket_category_id_seq;

DROP SEQUENCE user_id_seq;

DROP DOMAIN comment_type;
DROP DOMAIN event_type;
DROP DOMAIN ticket_priority;
DROP DOMAIN ticket_status;
DROP DOMAIN user_role;