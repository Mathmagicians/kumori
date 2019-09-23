-- Taxonomy

ALTER TABLE api.taxonomy SET SCHEMA public;

CREATE VIEW api.taxonomy
AS
SELECT
  id,
  name,
  level,
  parent
FROM
  public.taxonomy;

-- Phases

ALTER TABLE api.phases SET SCHEMA public;

CREATE VIEW api.phases
AS
SELECT
  id,
  name,
  description
FROM
  public.phases;

-- Statuses

ALTER TABLE api.statuses SET SCHEMA public;

CREATE VIEW api.statuses
AS
SELECT
  id,
  name,
  phase,
  description
FROM
  public.statuses;

-- Components

ALTER TABLE api.components SET SCHEMA public;

CREATE VIEW api.components
AS
SELECT
  id,
  name,
  description,
  primary_usecase,
  modified,
  modifiedby,
  deleted
FROM
  public.components;

-- Comments

ALTER TABLE api.comments SET SCHEMA public;

CREATE VIEW api.comments
AS
SELECT
  id,
  comment,
  component,
  modified,
  modifiedby,
  deleted
FROM
  public.comments;

-- Links

ALTER TABLE api.links SET SCHEMA public;

CREATE VIEW api.links
AS
SELECT
  id,
  ref,
  type,
  component,
  modified,
  modifiedby,
  deleted
FROM
  public.links;

-- Usecases

ALTER TABLE api.usecases SET SCHEMA public;

CREATE VIEW api.usecases
AS
SELECT
  id,
  name,
  description,
  modified,
  modifiedby,
  deleted
FROM
  public.usecases;


-- Usecase-taxonomy

ALTER TABLE api.usecase_taxonomy SET SCHEMA public;

CREATE VIEW api.usecase_taxonomy
AS
SELECT
usecase,
taxonomy
FROM
  public.usecase_taxonomy;

-- Component-usecase

ALTER TABLE api.component_usecase SET SCHEMA public;

CREATE VIEW api.component_usecase
AS
SELECT
  component,
  usecase,
  status,
  description
FROM
  public.component_usecase;
