SET client_min_messages TO WARNING;

-- Create Database
DROP DATABASE IF EXISTS meritocracy;

CREATE DATABASE meritocracy ENCODING 'utf-8';

GRANT CONNECT ON DATABASE meritocracy TO meritocracy;

-- Connect Database
\connect meritocracy;

SET
client_min_messages TO WARNING;

-- Create Schema
DROP SCHEMA IF EXISTS api CASCADE;

CREATE SCHEMA api;

-- Create priviliges
GRANT USAGE ON SCHEMA api TO meritocracy;

GRANT USAGE ON SCHEMA api TO web_anon;

ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT ALL ON TABLES TO meritocracy;
