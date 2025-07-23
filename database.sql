--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO '$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT anon TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticated TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT authenticated TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO supabase_storage_admin WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT pg_create_subscription TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_signal_backend TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT service_role TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT service_role TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_realtime_admin TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: calculate_dpd(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_dpd(due_date date, payment_date date DEFAULT NULL::date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF payment_date IS NOT NULL THEN
        RETURN 0;
    ELSE
        RETURN GREATEST(0, CURRENT_DATE - due_date);
    END IF;
END;
$$;


ALTER FUNCTION public.calculate_dpd(due_date date, payment_date date) OWNER TO postgres;

--
-- Name: get_collector_by_auth_id(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_collector_by_auth_id(auth_id uuid) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_collector_id VARCHAR(20);
BEGIN
    SELECT collector_id INTO v_collector_id
    FROM collectors
    WHERE auth_user_id = auth_id;
    
    RETURN v_collector_id;
END;
$$;


ALTER FUNCTION public.get_collector_by_auth_id(auth_id uuid) OWNER TO postgres;

--
-- Name: get_collector_dashboard(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_collector_dashboard(collector_auth_id uuid) RETURNS TABLE(total_cases integer, total_outstanding numeric, cases_contacted_today integer, amount_collected_today numeric, active_ptps integer)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_collector_id VARCHAR(20);
BEGIN
    SELECT collector_id INTO v_collector_id
    FROM collectors
    WHERE auth_user_id = collector_auth_id;

    RETURN QUERY
    SELECT 
        COUNT(DISTINCT cc.case_id)::INTEGER,
        SUM(cc.total_outstanding),
        COUNT(DISTINCT CASE 
            WHEN DATE(ca.activity_datetime) = CURRENT_DATE 
            THEN ca.case_id 
        END)::INTEGER,
        COALESCE(SUM(CASE 
            WHEN pt.payment_date = CURRENT_DATE 
            THEN pt.payment_amount 
        END), 0),
        COUNT(DISTINCT CASE 
            WHEN ptp.ptp_status = 'Active' 
            THEN ptp.ptp_id 
        END)::INTEGER
    FROM collection_cases cc
    LEFT JOIN collection_activities ca ON cc.case_id = ca.case_id
    LEFT JOIN payment_transactions pt ON cc.account_id = pt.account_id
    LEFT JOIN promise_to_pay ptp ON cc.case_id = ptp.case_id
    WHERE cc.assigned_collector_id = v_collector_id
    AND cc.case_status = 'Active';
END;
$$;


ALTER FUNCTION public.get_collector_dashboard(collector_auth_id uuid) OWNER TO postgres;

--
-- Name: handle_new_collector(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_collector() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    INSERT INTO collectors (collector_id, auth_user_id, email, employee_name, collection_role, is_active)
    VALUES (
        'COL' || LPAD(NEXTVAL('collectors_id_seq')::TEXT, 6, '0'),
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
        'Collector',
        TRUE
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_collector() OWNER TO postgres;

--
-- Name: update_account_bucket(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_account_bucket() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.bucket := CASE 
        WHEN NEW.dpd = 0 THEN 'Current'
        WHEN NEW.dpd BETWEEN 1 AND 30 THEN 'Bucket 1'
        WHEN NEW.dpd BETWEEN 31 AND 60 THEN 'Bucket 2'
        WHEN NEW.dpd BETWEEN 61 AND 90 THEN 'Bucket 3'
        WHEN NEW.dpd BETWEEN 91 AND 180 THEN 'Bucket 4'
        ELSE 'Bucket 5'
    END;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_account_bucket() OWNER TO postgres;

--
-- Name: update_ptp_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_ptp_status() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Mark overdue PTPs as broken
    UPDATE promise_to_pay
    SET ptp_status = 'Broken'
    WHERE promise_date < CURRENT_DATE
    AND ptp_status = 'Active'
    AND actual_payment_date IS NULL;
    
    -- Mark paid PTPs as kept
    UPDATE promise_to_pay
    SET ptp_status = 'Kept',
        kept_flag = TRUE
    WHERE actual_payment_amount >= promise_amount
    AND ptp_status = 'Active';
    
    -- Mark partially paid PTPs
    UPDATE promise_to_pay
    SET ptp_status = 'Partial'
    WHERE actual_payment_amount > 0
    AND actual_payment_amount < promise_amount
    AND ptp_status = 'Active';
END;
$$;


ALTER FUNCTION public.update_ptp_status() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: update_updated_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_date = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_date() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: asset_recovery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_recovery (
    recovery_id integer NOT NULL,
    account_id character varying(20),
    asset_type character varying(30),
    asset_description character varying(255),
    repossession_date date,
    storage_location character varying(100),
    estimated_value numeric(15,2),
    auction_date date,
    sale_amount numeric(15,2),
    recovery_costs numeric(15,2),
    net_recovery numeric(15,2),
    recovery_status character varying(30),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.asset_recovery OWNER TO postgres;

--
-- Name: asset_recovery_recovery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asset_recovery_recovery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asset_recovery_recovery_id_seq OWNER TO postgres;

--
-- Name: asset_recovery_recovery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asset_recovery_recovery_id_seq OWNED BY public.asset_recovery.recovery_id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branches (
    id integer NOT NULL,
    branch_code character varying(50) NOT NULL,
    branch_name character varying(255) NOT NULL,
    region character varying(100),
    city character varying(100),
    manager_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.branches OWNER TO postgres;

--
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_id_seq OWNER TO postgres;

--
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;


--
-- Name: collection_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_activities (
    activity_id integer NOT NULL,
    case_id integer,
    account_id character varying(20),
    collector_id character varying(20),
    activity_type character varying(30),
    activity_datetime timestamp with time zone,
    contact_person character varying(100),
    contact_number character varying(100),
    activity_result character varying(50),
    promise_amount numeric(15,2),
    promise_date date,
    notes text,
    next_action character varying(100),
    next_action_date date,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT collection_activities_activity_type_check CHECK (((activity_type)::text = ANY ((ARRAY['Call'::character varying, 'SMS'::character varying, 'Email'::character varying, 'Visit'::character varying, 'Letter'::character varying, 'Legal Notice'::character varying])::text[])))
);


ALTER TABLE public.collection_activities OWNER TO postgres;

--
-- Name: collection_activities_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_activities_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_activities_activity_id_seq OWNER TO postgres;

--
-- Name: collection_activities_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collection_activities_activity_id_seq OWNED BY public.collection_activities.activity_id;


--
-- Name: collection_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_cases (
    case_id integer NOT NULL,
    account_id character varying(20),
    customer_id character varying(20),
    assigned_collector_id character varying(20),
    assignment_date date,
    case_status character varying(30),
    priority_level character varying(20),
    total_outstanding numeric(15,2),
    last_payment_date date,
    last_contact_date timestamp with time zone,
    next_action_date date,
    resolution_date date,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collection_cases OWNER TO postgres;

--
-- Name: collection_cases_case_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_cases_case_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_cases_case_id_seq OWNER TO postgres;

--
-- Name: collection_cases_case_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collection_cases_case_id_seq OWNED BY public.collection_cases.case_id;


--
-- Name: collection_targets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_targets (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    target_month integer NOT NULL,
    target_year integer NOT NULL,
    target_amount numeric(15,2) NOT NULL,
    currency character varying(10) DEFAULT 'SAR'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collection_targets OWNER TO postgres;

--
-- Name: collection_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_targets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_targets_id_seq OWNER TO postgres;

--
-- Name: collection_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collection_targets_id_seq OWNED BY public.collection_targets.id;


--
-- Name: collection_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_transactions (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    transaction_date date NOT NULL,
    customer_id character varying(100),
    customer_name character varying(255),
    account_number character varying(100),
    transaction_type character varying(50) NOT NULL,
    amount numeric(15,2) NOT NULL,
    currency character varying(10) DEFAULT 'SAR'::character varying,
    payment_method character varying(50),
    collector_id integer,
    status character varying(50) DEFAULT 'completed'::character varying,
    reference_number character varying(100),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collection_transactions OWNER TO postgres;

--
-- Name: collection_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_transactions_id_seq OWNER TO postgres;

--
-- Name: collection_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collection_transactions_id_seq OWNED BY public.collection_transactions.id;


--
-- Name: collector_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collector_performance (
    performance_id integer NOT NULL,
    collector_id character varying(20),
    performance_date date,
    assigned_cases integer,
    contacted_cases integer,
    collected_amount numeric(15,2),
    target_amount numeric(15,2),
    ptp_obtained integer,
    ptp_kept integer,
    calls_made integer,
    visits_made integer,
    success_rate numeric(5,2),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collector_performance OWNER TO postgres;

--
-- Name: collector_performance_performance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collector_performance_performance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collector_performance_performance_id_seq OWNER TO postgres;

--
-- Name: collector_performance_performance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collector_performance_performance_id_seq OWNED BY public.collector_performance.performance_id;


--
-- Name: collectors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collectors (
    collector_id character varying(20) NOT NULL,
    auth_user_id uuid,
    employee_name character varying(100),
    employee_name_ar character varying(100),
    department character varying(50),
    team_name character varying(50),
    supervisor_id character varying(20),
    contact_number character varying(20),
    email character varying(100),
    collection_role character varying(30),
    is_active boolean DEFAULT true,
    join_date date,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.collectors OWNER TO postgres;

--
-- Name: collectors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collectors_id_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collectors_id_seq OWNER TO postgres;

--
-- Name: customer_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_contacts (
    contact_id integer NOT NULL,
    customer_id character varying(20),
    contact_type character varying(20),
    contact_value character varying(255),
    is_primary boolean DEFAULT false,
    is_valid boolean DEFAULT true,
    verified_date date,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customer_contacts_contact_type_check CHECK (((contact_type)::text = ANY ((ARRAY['Mobile'::character varying, 'Home'::character varying, 'Work'::character varying, 'Email'::character varying, 'Address'::character varying])::text[])))
);


ALTER TABLE public.customer_contacts OWNER TO postgres;

--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_contacts_contact_id_seq OWNER TO postgres;

--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_contacts_contact_id_seq OWNED BY public.customer_contacts.contact_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id character varying(20) NOT NULL,
    national_id character varying(20) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name_ar character varying(50),
    last_name_ar character varying(50),
    date_of_birth date,
    gender character(1),
    nationality character varying(50),
    employment_status character varying(30),
    employer_name character varying(100),
    monthly_income numeric(15,2),
    credit_score integer,
    risk_category character varying(20),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customers_gender_check CHECK ((gender = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: dashboard_widgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_widgets (
    id integer NOT NULL,
    dashboard_id integer,
    widget_type character varying(100) NOT NULL,
    widget_title character varying(255),
    position_x integer DEFAULT 0,
    position_y integer DEFAULT 0,
    width integer DEFAULT 4,
    height integer DEFAULT 4,
    config jsonb,
    is_visible boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dashboard_widgets OWNER TO postgres;

--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dashboard_widgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dashboard_widgets_id_seq OWNER TO postgres;

--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dashboard_widgets_id_seq OWNED BY public.dashboard_widgets.id;


--
-- Name: finance_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_accounts (
    account_id character varying(20) NOT NULL,
    customer_id character varying(20),
    product_type character varying(30),
    finance_amount numeric(15,2),
    profit_rate numeric(5,2),
    tenure_months integer,
    monthly_installment numeric(15,2),
    outstanding_amount numeric(15,2),
    principal_outstanding numeric(15,2),
    profit_outstanding numeric(15,2),
    origination_date date,
    maturity_date date,
    branch_code character varying(10),
    officer_id character varying(20),
    account_status character varying(20),
    dpd integer DEFAULT 0,
    bucket character varying(20),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT finance_accounts_product_type_check CHECK (((product_type)::text = ANY ((ARRAY['Auto Finance'::character varying, 'Personal Finance'::character varying, 'Home Finance'::character varying, 'SME Finance'::character varying, 'Credit Card'::character varying])::text[])))
);


ALTER TABLE public.finance_accounts OWNER TO postgres;

--
-- Name: legal_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legal_cases (
    legal_case_id integer NOT NULL,
    account_id character varying(20),
    customer_id character varying(20),
    case_type character varying(30),
    court_name character varying(100),
    case_number character varying(50),
    filing_date date,
    lawyer_name character varying(100),
    case_status character varying(30),
    judgment_date date,
    judgment_amount numeric(15,2),
    legal_costs numeric(15,2),
    next_hearing_date date,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.legal_cases OWNER TO postgres;

--
-- Name: legal_cases_legal_case_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legal_cases_legal_case_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_cases_legal_case_id_seq OWNER TO postgres;

--
-- Name: legal_cases_legal_case_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legal_cases_legal_case_id_seq OWNED BY public.legal_cases.legal_case_id;


--
-- Name: monthly_collection_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.monthly_collection_summary AS
 SELECT b.id AS branch_id,
    b.branch_name,
    b.branch_code,
    date_trunc('month'::text, (ct.transaction_date)::timestamp with time zone) AS month,
    count(DISTINCT ct.id) AS transaction_count,
    sum(ct.amount) AS total_collected,
    count(DISTINCT ct.customer_id) AS unique_customers,
    avg(ct.amount) AS avg_transaction_amount
   FROM (public.collection_transactions ct
     JOIN public.branches b ON ((ct.branch_id = b.id)))
  WHERE ((ct.status)::text = 'completed'::text)
  GROUP BY b.id, b.branch_name, b.branch_code, (date_trunc('month'::text, (ct.transaction_date)::timestamp with time zone));


ALTER VIEW public.monthly_collection_summary OWNER TO postgres;

--
-- Name: payment_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_schedule (
    schedule_id integer NOT NULL,
    account_id character varying(20),
    installment_no integer,
    due_date date,
    principal_amount numeric(15,2),
    profit_amount numeric(15,2),
    total_amount numeric(15,2),
    paid_amount numeric(15,2) DEFAULT 0,
    payment_date date,
    payment_status character varying(20) DEFAULT 'Pending'::character varying,
    dpd integer DEFAULT 0
);


ALTER TABLE public.payment_schedule OWNER TO postgres;

--
-- Name: payment_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_schedule_schedule_id_seq OWNER TO postgres;

--
-- Name: payment_schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_schedule_schedule_id_seq OWNED BY public.payment_schedule.schedule_id;


--
-- Name: payment_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_transactions (
    transaction_id integer NOT NULL,
    account_id character varying(20),
    customer_id character varying(20),
    payment_date date,
    payment_amount numeric(15,2),
    payment_method character varying(30),
    payment_channel character varying(30),
    receipt_number character varying(50),
    collected_by character varying(20),
    allocation_type character varying(30),
    principal_paid numeric(15,2),
    profit_paid numeric(15,2),
    late_fee_paid numeric(15,2),
    transaction_status character varying(20),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment_transactions OWNER TO postgres;

--
-- Name: payment_transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_transactions_transaction_id_seq OWNER TO postgres;

--
-- Name: payment_transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_transactions_transaction_id_seq OWNED BY public.payment_transactions.transaction_id;


--
-- Name: promise_to_pay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promise_to_pay (
    ptp_id integer NOT NULL,
    case_id integer,
    account_id character varying(20),
    customer_id character varying(20),
    collector_id character varying(20),
    promise_amount numeric(15,2),
    promise_date date,
    ptp_status character varying(20) DEFAULT 'Active'::character varying,
    actual_payment_amount numeric(15,2),
    actual_payment_date date,
    kept_flag boolean DEFAULT false,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.promise_to_pay OWNER TO postgres;

--
-- Name: promise_to_pay_ptp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promise_to_pay_ptp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promise_to_pay_ptp_id_seq OWNER TO postgres;

--
-- Name: promise_to_pay_ptp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promise_to_pay_ptp_id_seq OWNED BY public.promise_to_pay.ptp_id;


--
-- Name: quarterly_collection_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.quarterly_collection_summary AS
 SELECT b.id AS branch_id,
    b.branch_name,
    b.branch_code,
    date_trunc('quarter'::text, (ct.transaction_date)::timestamp with time zone) AS quarter,
    count(DISTINCT ct.id) AS transaction_count,
    sum(ct.amount) AS total_collected,
    count(DISTINCT ct.customer_id) AS unique_customers,
    avg(ct.amount) AS avg_transaction_amount
   FROM (public.collection_transactions ct
     JOIN public.branches b ON ((ct.branch_id = b.id)))
  WHERE ((ct.status)::text = 'completed'::text)
  GROUP BY b.id, b.branch_name, b.branch_code, (date_trunc('quarter'::text, (ct.transaction_date)::timestamp with time zone));


ALTER VIEW public.quarterly_collection_summary OWNER TO postgres;

--
-- Name: settlements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settlements (
    settlement_id integer NOT NULL,
    account_id character varying(20),
    customer_id character varying(20),
    original_outstanding numeric(15,2),
    settlement_amount numeric(15,2),
    discount_amount numeric(15,2),
    discount_percentage numeric(5,2),
    approval_level character varying(30),
    approved_by character varying(20),
    approval_date date,
    settlement_status character varying(20),
    payment_plan character varying(20),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.settlements OWNER TO postgres;

--
-- Name: settlements_settlement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settlements_settlement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settlements_settlement_id_seq OWNER TO postgres;

--
-- Name: settlements_settlement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settlements_settlement_id_seq OWNED BY public.settlements.settlement_id;


--
-- Name: sharia_compliance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sharia_compliance (
    compliance_id integer NOT NULL,
    account_id character varying(20),
    compliance_type character varying(50),
    late_payment_charges numeric(15,2),
    charity_amount numeric(15,2),
    charity_paid_date date,
    profit_purification numeric(15,2),
    compliance_status character varying(20),
    reviewed_by character varying(50),
    review_date date,
    notes text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sharia_compliance OWNER TO postgres;

--
-- Name: sharia_compliance_compliance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sharia_compliance_compliance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sharia_compliance_compliance_id_seq OWNER TO postgres;

--
-- Name: sharia_compliance_compliance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sharia_compliance_compliance_id_seq OWNED BY public.sharia_compliance.compliance_id;


--
-- Name: user_dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_dashboards (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dashboard_name character varying(255) NOT NULL,
    is_default boolean DEFAULT false,
    layout_config jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_dashboards OWNER TO postgres;

--
-- Name: user_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_dashboards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_dashboards_id_seq OWNER TO postgres;

--
-- Name: user_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_dashboards_id_seq OWNED BY public.user_dashboards.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    role character varying(50) DEFAULT 'viewer'::character varying NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: v_collector_performance_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_collector_performance_summary AS
 SELECT c.collector_id,
    c.employee_name,
    count(DISTINCT cc.case_id) AS active_cases,
    sum(cc.total_outstanding) AS total_assigned_amount,
    count(DISTINCT ca.activity_id) AS total_activities,
    count(DISTINCT ptp.ptp_id) AS total_ptps,
    sum(
        CASE
            WHEN (ptp.kept_flag = true) THEN 1
            ELSE 0
        END) AS kept_ptps,
    COALESCE(sum(pt.payment_amount), (0)::numeric) AS total_collected
   FROM ((((public.collectors c
     LEFT JOIN public.collection_cases cc ON (((c.collector_id)::text = (cc.assigned_collector_id)::text)))
     LEFT JOIN public.collection_activities ca ON ((((c.collector_id)::text = (ca.collector_id)::text) AND (ca.activity_datetime >= (CURRENT_DATE - '30 days'::interval)))))
     LEFT JOIN public.promise_to_pay ptp ON (((c.collector_id)::text = (ptp.collector_id)::text)))
     LEFT JOIN public.payment_transactions pt ON ((((c.collector_id)::text = (pt.collected_by)::text) AND (pt.payment_date >= (CURRENT_DATE - '30 days'::interval)))))
  GROUP BY c.collector_id, c.employee_name;


ALTER VIEW public.v_collector_performance_summary OWNER TO postgres;

--
-- Name: v_daily_collection_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_daily_collection_summary AS
 SELECT payment_date AS collection_date,
    count(DISTINCT account_id) AS accounts_collected,
    count(transaction_id) AS total_transactions,
    sum(payment_amount) AS total_collected,
    count(DISTINCT collected_by) AS active_collectors
   FROM public.payment_transactions pt
  WHERE (payment_date >= (CURRENT_DATE - '30 days'::interval))
  GROUP BY payment_date;


ALTER VIEW public.v_daily_collection_summary OWNER TO postgres;

--
-- Name: v_npf_by_product; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_npf_by_product AS
 SELECT product_type,
    count(*) AS total_accounts,
    sum(
        CASE
            WHEN (dpd > 90) THEN 1
            ELSE 0
        END) AS npf_accounts,
    sum(finance_amount) AS total_financed,
    sum(
        CASE
            WHEN (dpd > 90) THEN outstanding_amount
            ELSE (0)::numeric
        END) AS npf_amount,
    round(((sum(
        CASE
            WHEN (dpd > 90) THEN outstanding_amount
            ELSE (0)::numeric
        END) / NULLIF(sum(outstanding_amount), (0)::numeric)) * (100)::numeric), 2) AS npf_ratio
   FROM public.finance_accounts
  GROUP BY product_type;


ALTER VIEW public.v_npf_by_product OWNER TO postgres;

--
-- Name: v_portfolio_aging; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_portfolio_aging AS
 SELECT
        CASE
            WHEN (dpd = 0) THEN 'Current'::text
            WHEN ((dpd >= 1) AND (dpd <= 30)) THEN 'Bucket 1 (1-30)'::text
            WHEN ((dpd >= 31) AND (dpd <= 60)) THEN 'Bucket 2 (31-60)'::text
            WHEN ((dpd >= 61) AND (dpd <= 90)) THEN 'Bucket 3 (61-90)'::text
            WHEN ((dpd >= 91) AND (dpd <= 180)) THEN 'Bucket 4 (91-180)'::text
            ELSE 'Bucket 5 (180+)'::text
        END AS aging_bucket,
    count(*) AS account_count,
    sum(outstanding_amount) AS total_outstanding,
    avg(dpd) AS avg_dpd
   FROM public.finance_accounts
  WHERE ((account_status)::text = 'Delinquent'::text)
  GROUP BY
        CASE
            WHEN (dpd = 0) THEN 'Current'::text
            WHEN ((dpd >= 1) AND (dpd <= 30)) THEN 'Bucket 1 (1-30)'::text
            WHEN ((dpd >= 31) AND (dpd <= 60)) THEN 'Bucket 2 (31-60)'::text
            WHEN ((dpd >= 61) AND (dpd <= 90)) THEN 'Bucket 3 (61-90)'::text
            WHEN ((dpd >= 91) AND (dpd <= 180)) THEN 'Bucket 4 (91-180)'::text
            ELSE 'Bucket 5 (180+)'::text
        END;


ALTER VIEW public.v_portfolio_aging OWNER TO postgres;

--
-- Name: v_ptp_success_rate; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_ptp_success_rate AS
 SELECT promise_date AS ptp_date,
    count(*) AS total_ptps,
    sum(
        CASE
            WHEN (kept_flag = true) THEN 1
            ELSE 0
        END) AS kept_ptps,
    sum(
        CASE
            WHEN ((ptp_status)::text = 'Broken'::text) THEN 1
            ELSE 0
        END) AS broken_ptps,
    sum(promise_amount) AS total_promised,
    sum(COALESCE(actual_payment_amount, (0)::numeric)) AS total_collected,
    round((((sum(
        CASE
            WHEN (kept_flag = true) THEN 1
            ELSE 0
        END))::numeric / (NULLIF(count(*), 0))::numeric) * (100)::numeric), 2) AS success_rate
   FROM public.promise_to_pay
  WHERE (promise_date <= CURRENT_DATE)
  GROUP BY promise_date;


ALTER VIEW public.v_ptp_success_rate OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: asset_recovery recovery_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_recovery ALTER COLUMN recovery_id SET DEFAULT nextval('public.asset_recovery_recovery_id_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: collection_activities activity_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_activities ALTER COLUMN activity_id SET DEFAULT nextval('public.collection_activities_activity_id_seq'::regclass);


--
-- Name: collection_cases case_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_cases ALTER COLUMN case_id SET DEFAULT nextval('public.collection_cases_case_id_seq'::regclass);


--
-- Name: collection_targets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_targets ALTER COLUMN id SET DEFAULT nextval('public.collection_targets_id_seq'::regclass);


--
-- Name: collection_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_transactions ALTER COLUMN id SET DEFAULT nextval('public.collection_transactions_id_seq'::regclass);


--
-- Name: collector_performance performance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collector_performance ALTER COLUMN performance_id SET DEFAULT nextval('public.collector_performance_performance_id_seq'::regclass);


--
-- Name: customer_contacts contact_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.customer_contacts_contact_id_seq'::regclass);


--
-- Name: dashboard_widgets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_widgets ALTER COLUMN id SET DEFAULT nextval('public.dashboard_widgets_id_seq'::regclass);


--
-- Name: legal_cases legal_case_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_cases ALTER COLUMN legal_case_id SET DEFAULT nextval('public.legal_cases_legal_case_id_seq'::regclass);


--
-- Name: payment_schedule schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.payment_schedule_schedule_id_seq'::regclass);


--
-- Name: payment_transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.payment_transactions_transaction_id_seq'::regclass);


--
-- Name: promise_to_pay ptp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay ALTER COLUMN ptp_id SET DEFAULT nextval('public.promise_to_pay_ptp_id_seq'::regclass);


--
-- Name: settlements settlement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements ALTER COLUMN settlement_id SET DEFAULT nextval('public.settlements_settlement_id_seq'::regclass);


--
-- Name: sharia_compliance compliance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharia_compliance ALTER COLUMN compliance_id SET DEFAULT nextval('public.sharia_compliance_compliance_id_seq'::regclass);


--
-- Name: user_dashboards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_dashboards ALTER COLUMN id SET DEFAULT nextval('public.user_dashboards_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: asset_recovery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_recovery (recovery_id, account_id, asset_type, asset_description, repossession_date, storage_location, estimated_value, auction_date, sale_amount, recovery_costs, net_recovery, recovery_status, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:13.956523+00
2	ACC046	Investment	Asset description for recovery 1	2025-06-20	Riyadh Warehouse	60736.89	2025-08-14	\N	6073.69	\N	In Storage	2025-07-22 16:48:11.764233+00
3	ACC022	Jewelry	Asset description for recovery 2	2025-06-13	Dammam Facility	141139.38	2025-07-23	\N	14113.94	\N	Sold	2025-07-22 16:48:11.764233+00
4	ACC027	Real Estate	Asset description for recovery 3	2025-07-20	Jeddah Storage	68768.28	\N	52944.21	6876.83	46067.39	Sold	2025-07-22 16:48:11.764233+00
5	ACC013	Real Estate	Asset description for recovery 4	2025-05-21	Dammam Facility	244316.70	2025-09-11	\N	24431.67	\N	Auctioned	2025-07-22 16:48:11.764233+00
6	ACC003	Equipment	Asset description for recovery 5	2025-05-31	Dammam Facility	186952.60	\N	\N	18695.26	\N	Auctioned	2025-07-22 16:48:11.764233+00
7	ACC045	Investment	Asset description for recovery 6	2025-05-20	Riyadh Warehouse	114709.90	2025-07-29	95747.31	11470.99	84276.32	Repossessed	2025-07-22 16:48:11.764233+00
8	ACC019	Investment	Asset description for recovery 7	2025-05-02	Riyadh Warehouse	61867.73	2025-08-20	\N	6186.77	\N	Sold	2025-07-22 16:48:11.764233+00
9	ACC038	Equipment	Asset description for recovery 8	2025-06-09	Riyadh Warehouse	183167.41	2025-09-14	\N	18316.74	\N	In Storage	2025-07-22 16:48:11.764233+00
10	ACC009	Jewelry	Asset description for recovery 9	2025-06-08	Riyadh Warehouse	200714.17	\N	146188.24	20071.42	126116.82	Sold	2025-07-22 16:48:11.764233+00
11	ACC046	Real Estate	Asset description for recovery 10	2025-05-28	Jeddah Storage	245710.31	\N	\N	24571.03	\N	Sold	2025-07-22 16:48:11.764233+00
12	ACC029	Vehicle	Asset description for recovery 11	2025-06-06	Riyadh Warehouse	189094.99	\N	135448.26	18909.50	116538.76	In Storage	2025-07-22 16:48:11.764233+00
13	ACC020	Vehicle	Asset description for recovery 12	2025-05-07	Jeddah Storage	53417.01	\N	40556.23	5341.70	35214.53	Auctioned	2025-07-22 16:48:11.764233+00
14	ACC008	Investment	Asset description for recovery 13	2025-07-03	Dammam Facility	248196.77	2025-08-15	207425.55	24819.68	182605.87	Sold	2025-07-22 16:48:11.764233+00
15	ACC041	Real Estate	Asset description for recovery 14	2025-07-22	Dammam Facility	165370.16	\N	127998.70	16537.02	111461.69	Auctioned	2025-07-22 16:48:11.764233+00
16	ACC047	Vehicle	Asset description for recovery 15	2025-04-24	Dammam Facility	82441.67	2025-08-07	\N	8244.17	\N	Auctioned	2025-07-22 16:48:11.764233+00
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branches (id, branch_code, branch_name, region, city, manager_id, is_active, created_at, updated_at) FROM stdin;
1	BR001	Riyadh Main Branch	Central	Riyadh	6	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
2	BR002	Jeddah Branch	Western	Jeddah	6	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
3	BR003	Dammam Branch	Eastern	Dammam	6	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
\.


--
-- Data for Name: collection_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection_activities (activity_id, case_id, account_id, collector_id, activity_type, activity_datetime, contact_person, contact_number, activity_result, promise_amount, promise_date, notes, next_action, next_action_date, created_date) FROM stdin;
143	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:11.635188+00
244	128	ACC008	COL002	Call	2025-06-03 16:48:49.926+00	Mohammed Al-Qasimi	+9661275803569	No Answer	10858.53	2025-08-01	Collection activity for case 128. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-23	2025-07-22 16:48:50.038659+00
245	97	ACC007	COL004	Email	2025-07-21 16:48:49.926+00	Fatima Al-Zahra	+9661016453950	Dispute	14136.04	2025-07-27	Collection activity for case 97. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-24	2025-07-22 16:48:50.038659+00
246	82	ACC022	COL001	Call	2025-06-14 16:48:49.926+00	Fatima Al-Zahra	+966682794719	No Answer	28364.03	2025-07-29	Collection activity for case 82. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-25	2025-07-22 16:48:50.038659+00
247	145	ACC025	COL009	Legal Notice	2025-07-14 16:48:49.926+00	Ahmed Al-Rashid	+966517818651	Payment Received	\N	2025-08-04	Collection activity for case 145. Customer contacted regarding overdue payment.	Schedule visit	2025-08-04	2025-07-22 16:48:50.038659+00
248	80	ACC020	COL003	SMS	2025-07-20 16:48:49.926+00	Fatima Al-Zahra	+9661214280592	Promise to Pay	5944.99	2025-07-26	Collection activity for case 80. Customer contacted regarding overdue payment.	Follow up call	2025-07-24	2025-07-22 16:48:50.038659+00
249	85	ACC025	COL007	Legal Notice	2025-05-04 16:48:49.926+00	Sarah Al-Mansouri	+966706771187	Refused to Pay	\N	\N	Collection activity for case 85. Customer contacted regarding overdue payment.	Schedule visit	2025-08-03	2025-07-22 16:48:50.038659+00
250	148	ACC028	COL010	Legal Notice	2025-06-04 16:48:49.926+00	Sarah Al-Mansouri	+9661089745631	Dispute	\N	2025-08-05	Collection activity for case 148. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-30	2025-07-22 16:48:50.038659+00
251	143	ACC023	COL002	SMS	2025-05-17 16:48:49.926+00	Ahmed Al-Rashid	+9661169214151	Promise to Pay	33665.61	\N	Collection activity for case 143. Customer contacted regarding overdue payment.	Schedule visit	2025-08-02	2025-07-22 16:48:50.038659+00
252	112	ACC022	COL004	Visit	2025-06-13 16:48:49.926+00	Mohammed Al-Qasimi	+966851889013	Dispute	14584.98	2025-08-08	Collection activity for case 112. Customer contacted regarding overdue payment.	Schedule visit	2025-07-23	2025-07-22 16:48:50.038659+00
253	121	ACC001	COL004	SMS	2025-04-26 16:48:49.926+00	Ahmed Al-Rashid	+966562923921	Payment Received	28108.63	2025-07-24	Collection activity for case 121. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-22	2025-07-22 16:48:50.038659+00
254	127	ACC007	COL007	Letter	2025-07-11 16:48:49.926+00	Fatima Al-Zahra	+966735892549	Promise to Pay	\N	\N	Collection activity for case 127. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-28	2025-07-22 16:48:50.038659+00
255	71	ACC011	COL006	Call	2025-06-01 16:48:49.926+00	Fatima Al-Zahra	+966959153818	No Answer	20490.15	2025-08-17	Collection activity for case 71. Customer contacted regarding overdue payment.	Schedule visit	2025-08-05	2025-07-22 16:48:50.038659+00
256	76	ACC016	COL004	Visit	2025-07-13 16:48:49.926+00	Ahmed Al-Rashid	+9661082815285	Dispute	13804.67	2025-07-22	Collection activity for case 76. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-29	2025-07-22 16:48:50.038659+00
257	110	ACC020	COL008	Legal Notice	2025-04-26 16:48:49.926+00	Mohammed Al-Qasimi	+9661026994087	Promise to Pay	\N	2025-07-22	Collection activity for case 110. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-23	2025-07-22 16:48:50.038659+00
258	77	ACC017	COL008	Email	2025-06-17 16:48:49.926+00	Ahmed Al-Rashid	+966693761207	Refused to Pay	6027.91	\N	Collection activity for case 77. Customer contacted regarding overdue payment.	Schedule visit	2025-07-30	2025-07-22 16:48:50.038659+00
259	144	ACC024	COL010	SMS	2025-04-25 16:48:49.926+00	Mohammed Al-Qasimi	+9661017853908	Dispute	\N	2025-07-25	Collection activity for case 144. Customer contacted regarding overdue payment.	Schedule visit	2025-08-03	2025-07-22 16:48:50.038659+00
260	79	ACC019	COL007	Legal Notice	2025-07-03 16:48:49.926+00	Ahmed Al-Rashid	+966684084808	Refused to Pay	32834.70	2025-08-01	Collection activity for case 79. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-05	2025-07-22 16:48:50.038659+00
261	144	ACC024	COL004	Visit	2025-06-15 16:48:49.926+00	Ahmed Al-Rashid	+9661108698050	Promise to Pay	\N	2025-07-30	Collection activity for case 144. Customer contacted regarding overdue payment.	Schedule visit	2025-08-04	2025-07-22 16:48:50.038659+00
262	74	ACC014	COL010	Legal Notice	2025-07-01 16:48:49.926+00	Mohammed Al-Qasimi	+966536489770	No Answer	\N	\N	Collection activity for case 74. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-23	2025-07-22 16:48:50.038659+00
263	99	ACC009	COL004	Legal Notice	2025-07-09 16:48:49.926+00	Sarah Al-Mansouri	+966733821723	Contact Made	23399.34	\N	Collection activity for case 99. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-24	2025-07-22 16:48:50.038659+00
264	126	ACC006	COL007	SMS	2025-06-20 16:48:49.926+00	Fatima Al-Zahra	+966720607011	Dispute	\N	\N	Collection activity for case 126. Customer contacted regarding overdue payment.	Schedule visit	2025-08-04	2025-07-22 16:48:50.038659+00
265	86	ACC026	COL007	Email	2025-06-27 16:48:49.926+00	Mohammed Al-Qasimi	+9661134566501	No Answer	32071.58	\N	Collection activity for case 86. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-04	2025-07-22 16:48:50.038659+00
266	65	ACC005	COL001	Email	2025-06-08 16:48:49.926+00	Sarah Al-Mansouri	+9661229559924	Promise to Pay	\N	\N	Collection activity for case 65. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-25	2025-07-22 16:48:50.038659+00
267	144	ACC024	COL001	Letter	2025-05-17 16:48:49.926+00	Mohammed Al-Qasimi	+966797422757	Promise to Pay	\N	2025-07-24	Collection activity for case 144. Customer contacted regarding overdue payment.	Follow up call	2025-07-24	2025-07-22 16:48:50.038659+00
268	112	ACC022	COL009	Legal Notice	2025-05-08 16:48:49.926+00	Mohammed Al-Qasimi	+966982123299	No Answer	\N	\N	Collection activity for case 112. Customer contacted regarding overdue payment.	Schedule visit	2025-08-03	2025-07-22 16:48:50.038659+00
269	137	ACC017	COL007	Visit	2025-06-23 16:48:49.926+00	Fatima Al-Zahra	+966889438588	Promise to Pay	12110.61	\N	Collection activity for case 137. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-04	2025-07-22 16:48:50.038659+00
270	79	ACC019	COL007	Visit	2025-04-29 16:48:49.926+00	Mohammed Al-Qasimi	+9661095448113	Promise to Pay	10017.80	2025-08-02	Collection activity for case 79. Customer contacted regarding overdue payment.	Follow up call	2025-07-22	2025-07-22 16:48:50.038659+00
271	127	ACC007	COL007	Legal Notice	2025-07-06 16:48:49.926+00	Fatima Al-Zahra	+9661123182948	Payment Received	\N	2025-08-18	Collection activity for case 127. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-29	2025-07-22 16:48:50.038659+00
272	89	ACC029	COL005	Letter	2025-04-28 16:48:49.926+00	Mohammed Al-Qasimi	+966847921922	Refused to Pay	\N	2025-08-15	Collection activity for case 89. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-23	2025-07-22 16:48:50.038659+00
273	100	ACC010	COL005	Call	2025-07-15 16:48:49.926+00	Mohammed Al-Qasimi	+9661007279012	No Answer	\N	\N	Collection activity for case 100. Customer contacted regarding overdue payment.	Follow up call	2025-07-29	2025-07-22 16:48:50.038659+00
274	120	ACC030	COL008	Visit	2025-06-26 16:48:49.926+00	Ahmed Al-Rashid	+966673314753	Dispute	15612.58	\N	Collection activity for case 120. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-30	2025-07-22 16:48:50.038659+00
275	125	ACC005	COL010	Call	2025-05-31 16:48:49.926+00	Ahmed Al-Rashid	+966849717925	Contact Made	\N	2025-08-06	Collection activity for case 125. Customer contacted regarding overdue payment.	Schedule visit	2025-08-05	2025-07-22 16:48:50.038659+00
276	116	ACC026	COL005	SMS	2025-06-10 16:48:49.926+00	Sarah Al-Mansouri	+966943370737	Promise to Pay	10750.33	\N	Collection activity for case 116. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-24	2025-07-22 16:48:50.038659+00
277	148	ACC028	COL001	SMS	2025-05-15 16:48:49.926+00	Sarah Al-Mansouri	+966649610154	No Answer	17392.44	2025-08-10	Collection activity for case 148. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-26	2025-07-22 16:48:50.038659+00
278	102	ACC012	COL010	Legal Notice	2025-07-12 16:48:49.927+00	Sarah Al-Mansouri	+9661192428630	Refused to Pay	\N	2025-08-17	Collection activity for case 102. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-01	2025-07-22 16:48:50.038659+00
279	70	ACC010	COL003	Letter	2025-06-01 16:48:49.927+00	Ahmed Al-Rashid	+9661235143330	Dispute	\N	2025-08-05	Collection activity for case 70. Customer contacted regarding overdue payment.	Follow up call	2025-07-23	2025-07-22 16:48:50.038659+00
280	118	ACC028	COL005	Legal Notice	2025-05-16 16:48:49.927+00	Sarah Al-Mansouri	+9661282600032	Promise to Pay	17387.21	\N	Collection activity for case 118. Customer contacted regarding overdue payment.	Follow up call	2025-07-25	2025-07-22 16:48:50.038659+00
281	140	ACC020	COL005	Call	2025-05-20 16:48:49.927+00	Sarah Al-Mansouri	+9661167729867	Promise to Pay	\N	\N	Collection activity for case 140. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-28	2025-07-22 16:48:50.038659+00
282	134	ACC014	COL009	Legal Notice	2025-06-23 16:48:49.927+00	Fatima Al-Zahra	+9661124077839	Dispute	\N	\N	Collection activity for case 134. Customer contacted regarding overdue payment.	Follow up call	2025-07-24	2025-07-22 16:48:50.038659+00
283	133	ACC013	COL007	Visit	2025-06-29 16:48:49.927+00	Fatima Al-Zahra	+966632989482	Contact Made	\N	\N	Collection activity for case 133. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-23	2025-07-22 16:48:50.038659+00
284	64	ACC004	COL010	Call	2025-06-17 16:48:49.927+00	Sarah Al-Mansouri	+966806074008	Contact Made	22063.98	\N	Collection activity for case 64. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-05	2025-07-22 16:48:50.038659+00
285	146	ACC026	COL002	Legal Notice	2025-06-13 16:48:49.927+00	Mohammed Al-Qasimi	+9661301889894	No Answer	\N	2025-07-26	Collection activity for case 146. Customer contacted regarding overdue payment.	Schedule visit	2025-07-26	2025-07-22 16:48:50.038659+00
286	88	ACC028	COL007	SMS	2025-06-15 16:48:49.927+00	Mohammed Al-Qasimi	+966676553376	Contact Made	\N	2025-08-12	Collection activity for case 88. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-31	2025-07-22 16:48:50.038659+00
287	110	ACC020	COL002	Call	2025-06-02 16:48:49.927+00	Fatima Al-Zahra	+966860014161	No Answer	\N	\N	Collection activity for case 110. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-31	2025-07-22 16:48:50.038659+00
288	71	ACC011	COL002	Call	2025-05-04 16:48:49.927+00	Mohammed Al-Qasimi	+966690110438	Promise to Pay	\N	\N	Collection activity for case 71. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-04	2025-07-22 16:48:50.038659+00
289	126	ACC006	COL008	Legal Notice	2025-05-04 16:48:49.927+00	Mohammed Al-Qasimi	+9661188209849	Contact Made	14728.46	2025-07-30	Collection activity for case 126. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-03	2025-07-22 16:48:50.038659+00
290	95	ACC005	COL009	Legal Notice	2025-07-22 16:48:49.927+00	Fatima Al-Zahra	+966675914449	Promise to Pay	\N	\N	Collection activity for case 95. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-31	2025-07-22 16:48:50.038659+00
291	65	ACC005	COL006	SMS	2025-06-25 16:48:49.927+00	Sarah Al-Mansouri	+966811603576	Dispute	30014.67	2025-07-29	Collection activity for case 65. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-29	2025-07-22 16:48:50.038659+00
292	96	ACC006	COL001	Letter	2025-06-22 16:48:49.927+00	Sarah Al-Mansouri	+966673153884	Refused to Pay	6345.52	2025-08-17	Collection activity for case 96. Customer contacted regarding overdue payment.	Follow up call	2025-07-22	2025-07-22 16:48:50.038659+00
293	98	ACC008	COL004	Call	2025-06-29 16:48:49.927+00	Sarah Al-Mansouri	+966918205601	Promise to Pay	\N	\N	Collection activity for case 98. Customer contacted regarding overdue payment.	Follow up call	2025-08-02	2025-07-22 16:48:50.038659+00
294	138	ACC018	COL002	Legal Notice	2025-05-07 16:48:49.927+00	Ahmed Al-Rashid	+966985442117	Payment Received	17462.74	2025-08-11	Collection activity for case 138. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-28	2025-07-22 16:48:50.038659+00
295	65	ACC005	COL003	SMS	2025-05-22 16:48:49.927+00	Sarah Al-Mansouri	+9661135311806	No Answer	\N	\N	Collection activity for case 65. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-30	2025-07-22 16:48:50.038659+00
296	121	ACC001	COL010	Email	2025-05-23 16:48:49.927+00	Ahmed Al-Rashid	+9661269003558	No Answer	31617.99	\N	Collection activity for case 121. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-31	2025-07-22 16:48:50.038659+00
297	85	ACC025	COL007	SMS	2025-06-05 16:48:49.927+00	Sarah Al-Mansouri	+9661169881000	Refused to Pay	\N	\N	Collection activity for case 85. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-24	2025-07-22 16:48:50.038659+00
298	127	ACC007	COL004	SMS	2025-05-20 16:48:49.927+00	Fatima Al-Zahra	+966717454419	Dispute	\N	\N	Collection activity for case 127. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-30	2025-07-22 16:48:50.038659+00
299	81	ACC021	COL006	SMS	2025-06-18 16:48:49.927+00	Fatima Al-Zahra	+966960110919	Payment Received	22274.01	2025-07-22	Collection activity for case 81. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-01	2025-07-22 16:48:50.038659+00
300	135	ACC015	COL002	SMS	2025-05-05 16:48:49.927+00	Mohammed Al-Qasimi	+966566367254	No Answer	\N	2025-08-04	Collection activity for case 135. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-27	2025-07-22 16:48:50.038659+00
301	109	ACC019	COL003	Visit	2025-05-13 16:48:49.927+00	Ahmed Al-Rashid	+966879534480	No Answer	\N	\N	Collection activity for case 109. Customer contacted regarding overdue payment.	Schedule visit	2025-07-31	2025-07-22 16:48:50.038659+00
302	98	ACC008	COL007	Letter	2025-05-23 16:48:49.927+00	Mohammed Al-Qasimi	+966537803410	Refused to Pay	11474.92	\N	Collection activity for case 98. Customer contacted regarding overdue payment.	Follow up call	2025-08-04	2025-07-22 16:48:50.038659+00
303	137	ACC017	COL006	Call	2025-04-24 16:48:49.927+00	Sarah Al-Mansouri	+9661110564141	No Answer	22666.51	2025-07-23	Collection activity for case 137. Customer contacted regarding overdue payment.	Follow up call	2025-07-30	2025-07-22 16:48:50.038659+00
304	120	ACC030	COL004	Letter	2025-06-01 16:48:49.927+00	Mohammed Al-Qasimi	+966597886603	Payment Received	\N	2025-07-29	Collection activity for case 120. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-03	2025-07-22 16:48:50.038659+00
305	101	ACC011	COL003	Legal Notice	2025-05-07 16:48:49.927+00	Sarah Al-Mansouri	+966993005750	Payment Received	\N	\N	Collection activity for case 101. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-25	2025-07-22 16:48:50.038659+00
306	109	ACC019	COL003	Visit	2025-05-14 16:48:49.927+00	Ahmed Al-Rashid	+966855399019	Dispute	\N	2025-08-16	Collection activity for case 109. Customer contacted regarding overdue payment.	Follow up call	2025-07-31	2025-07-22 16:48:50.038659+00
307	87	ACC027	COL006	Email	2025-05-30 16:48:49.927+00	Mohammed Al-Qasimi	+9661366475717	Payment Received	18087.44	2025-08-17	Collection activity for case 87. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-22	2025-07-22 16:48:50.038659+00
308	94	ACC004	COL001	SMS	2025-05-02 16:48:49.927+00	Fatima Al-Zahra	+9661077260049	Payment Received	\N	\N	Collection activity for case 94. Customer contacted regarding overdue payment.	Schedule visit	2025-07-29	2025-07-22 16:48:50.038659+00
309	68	ACC008	COL007	SMS	2025-05-22 16:48:49.927+00	Ahmed Al-Rashid	+9661192107081	Dispute	17668.43	\N	Collection activity for case 68. Customer contacted regarding overdue payment.	Follow up call	2025-07-31	2025-07-22 16:48:50.038659+00
310	147	ACC027	COL009	Visit	2025-05-25 16:48:49.927+00	Mohammed Al-Qasimi	+966739600814	Payment Received	8049.04	2025-08-18	Collection activity for case 147. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-05	2025-07-22 16:48:50.038659+00
311	149	ACC029	COL010	Letter	2025-06-22 16:48:49.927+00	Ahmed Al-Rashid	+966793003183	Promise to Pay	\N	2025-08-04	Collection activity for case 149. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-04	2025-07-22 16:48:50.038659+00
312	88	ACC028	COL003	Legal Notice	2025-07-18 16:48:49.927+00	Mohammed Al-Qasimi	+966670031708	No Answer	16510.93	\N	Collection activity for case 88. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-01	2025-07-22 16:48:50.038659+00
313	76	ACC016	COL002	SMS	2025-06-11 16:48:49.927+00	Fatima Al-Zahra	+966803928452	Dispute	5003.97	2025-07-31	Collection activity for case 76. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-30	2025-07-22 16:48:50.038659+00
314	116	ACC026	COL007	Letter	2025-07-13 16:48:49.927+00	Ahmed Al-Rashid	+9661186552542	Contact Made	32220.88	2025-08-08	Collection activity for case 116. Customer contacted regarding overdue payment.	Send SMS reminder	2025-07-23	2025-07-22 16:48:50.038659+00
315	77	ACC017	COL010	Email	2025-05-31 16:48:49.927+00	Sarah Al-Mansouri	+9661148934307	Contact Made	\N	2025-07-30	Collection activity for case 77. Customer contacted regarding overdue payment.	Follow up call	2025-07-28	2025-07-22 16:48:50.038659+00
316	113	ACC023	COL009	Legal Notice	2025-07-11 16:48:49.927+00	Fatima Al-Zahra	+966727524054	Contact Made	23172.71	\N	Collection activity for case 113. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-28	2025-07-22 16:48:50.038659+00
317	119	ACC029	COL009	Visit	2025-07-14 16:48:49.927+00	Mohammed Al-Qasimi	+966896895189	Dispute	\N	\N	Collection activity for case 119. Customer contacted regarding overdue payment.	Follow up call	2025-08-04	2025-07-22 16:48:50.038659+00
318	95	ACC005	COL007	Call	2025-07-01 16:48:49.927+00	Ahmed Al-Rashid	+966652528966	Refused to Pay	\N	2025-08-03	Collection activity for case 95. Customer contacted regarding overdue payment.	Schedule visit	2025-08-04	2025-07-22 16:48:50.038659+00
319	126	ACC006	COL008	Call	2025-07-02 16:48:49.927+00	Fatima Al-Zahra	+966885282486	Promise to Pay	\N	\N	Collection activity for case 126. Customer contacted regarding overdue payment.	Send SMS reminder	2025-08-04	2025-07-22 16:48:50.038659+00
320	75	ACC015	COL006	Call	2025-04-29 16:48:49.927+00	Sarah Al-Mansouri	+966746700095	Dispute	27930.56	\N	Collection activity for case 75. Customer contacted regarding overdue payment.	Follow up call	2025-08-02	2025-07-22 16:48:50.038659+00
321	127	ACC007	COL006	Letter	2025-06-20 16:48:49.927+00	Ahmed Al-Rashid	+9661110404503	Dispute	21760.49	\N	Collection activity for case 127. Customer contacted regarding overdue payment.	Escalate to legal	2025-08-02	2025-07-22 16:48:50.038659+00
322	89	ACC029	COL003	Email	2025-05-12 16:48:49.927+00	Ahmed Al-Rashid	+9661276958237	Refused to Pay	34493.55	2025-08-04	Collection activity for case 89. Customer contacted regarding overdue payment.	Escalate to legal	2025-07-24	2025-07-22 16:48:50.038659+00
323	112	ACC022	COL006	Email	2025-05-24 16:48:49.927+00	Mohammed Al-Qasimi	+966674716828	Refused to Pay	\N	2025-08-04	Collection activity for case 112. Customer contacted regarding overdue payment.	Follow up call	2025-07-22	2025-07-22 16:48:50.038659+00
\.


--
-- Data for Name: collection_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection_cases (case_id, account_id, customer_id, assigned_collector_id, assignment_date, case_status, priority_level, total_outstanding, last_payment_date, last_contact_date, next_action_date, resolution_date, created_date) FROM stdin;
61	ACC001	CUST001	COL001	2024-10-01	Active	High	125000.00	2024-09-15	2025-01-20 10:30:00+00	2025-01-22	\N	2025-07-22 07:41:47.652491+00
62	ACC002	CUST002	COL002	2024-11-15	Active	Medium	35000.00	2024-10-20	2025-01-19 14:15:00+00	2025-01-23	\N	2025-07-22 07:41:47.652491+00
63	ACC003	CUST003	COL003	2024-09-01	Legal	Critical	950000.00	2024-08-10	2025-01-18 09:00:00+00	2025-01-25	\N	2025-07-22 07:41:47.652491+00
64	ACC004	CUST004	COL001	2024-12-05	Active	Low	65000.00	2024-11-30	2025-01-21 11:45:00+00	2025-01-24	\N	2025-07-22 07:41:47.652491+00
65	ACC005	CUST005	COL004	2024-07-01	Write-off Review	Critical	48000.00	2024-06-01	2025-01-15 16:00:00+00	2025-01-30	\N	2025-07-22 07:41:47.652491+00
66	ACC006	CUST006	COL002	2024-10-15	Active	High	580000.00	2024-09-20	2025-01-20 15:30:00+00	2025-01-26	\N	2025-07-22 07:41:47.652491+00
67	ACC007	CUST007	COL003	2024-11-20	Active	Medium	145000.00	2024-11-01	2025-01-19 10:00:00+00	2025-01-27	\N	2025-07-22 07:41:47.652491+00
68	ACC008	CUST008	COL004	2024-12-10	Active	Low	65000.00	2024-12-05	2025-01-21 14:00:00+00	2025-01-28	\N	2025-07-22 07:41:47.652491+00
69	ACC009	CUST009	COL005	2024-10-25	Active	High	720000.00	2024-09-30	2025-01-18 11:00:00+00	2025-01-29	\N	2025-07-22 07:41:47.652491+00
70	ACC010	CUST010	COL001	2024-08-15	Legal	Critical	42000.00	2024-07-10	2025-01-17 09:30:00+00	2025-01-31	\N	2025-07-22 07:41:47.652491+00
71	ACC011	CUST011	COL006	2024-11-01	Active	Medium	85000.00	2024-10-15	2025-01-20 09:00:00+00	2025-01-23	\N	2025-07-22 07:41:47.652491+00
72	ACC012	CUST012	COL007	2024-12-15	Active	Low	25000.00	2024-12-01	2025-01-21 10:30:00+00	2025-01-24	\N	2025-07-22 07:41:47.652491+00
73	ACC013	CUST013	COL008	2024-10-20	Active	High	350000.00	2024-09-25	2025-01-19 11:15:00+00	2025-01-25	\N	2025-07-22 07:41:47.652491+00
74	ACC014	CUST014	COL009	2024-12-20	Active	Low	45000.00	2024-12-10	2025-01-21 13:45:00+00	2025-01-26	\N	2025-07-22 07:41:47.652491+00
75	ACC015	CUST015	COL010	2024-11-10	Active	Medium	1350000.00	2024-10-20	2025-01-20 14:30:00+00	2025-01-27	\N	2025-07-22 07:41:47.652491+00
76	ACC016	CUST016	COL001	2024-11-05	Active	Medium	120000.00	2024-10-10	2025-01-19 15:00:00+00	2025-01-28	\N	2025-07-22 07:41:47.652491+00
77	ACC017	CUST017	COL002	2024-10-30	Active	High	55000.00	2024-09-15	2025-01-18 16:15:00+00	2025-01-29	\N	2025-07-22 07:41:47.652491+00
78	ACC018	CUST018	COL003	2024-12-25	Active	Low	95000.00	2024-12-20	2025-01-21 09:30:00+00	2025-01-30	\N	2025-07-22 07:41:47.652491+00
79	ACC019	CUST019	COL004	2024-09-15	Legal	Critical	420000.00	2024-08-01	2025-01-17 10:45:00+00	2025-01-31	\N	2025-07-22 07:41:47.652491+00
80	ACC020	CUST020	COL005	2024-12-01	Active	Medium	38000.00	2024-11-15	2025-01-20 11:30:00+00	2025-02-01	\N	2025-07-22 07:41:47.652491+00
81	ACC021	CUST021	COL006	2024-11-25	Active	Medium	18000.00	2024-10-30	2025-01-19 12:00:00+00	2025-01-25	\N	2025-07-22 07:41:47.652491+00
82	ACC022	CUST022	COL007	2024-11-15	Active	Medium	45000.00	2024-10-25	2025-01-20 13:15:00+00	2025-01-26	\N	2025-07-22 07:41:47.652491+00
83	ACC023	CUST023	COL008	2024-10-10	Active	High	22000.00	2024-09-05	2025-01-18 14:30:00+00	2025-01-27	\N	2025-07-22 07:41:47.652491+00
84	ACC024	CUST024	COL009	2024-12-10	Active	Low	58000.00	2024-11-25	2025-01-21 15:45:00+00	2025-01-28	\N	2025-07-22 07:41:47.652491+00
85	ACC025	CUST025	COL010	2024-08-20	Write-off Review	Critical	15000.00	2024-07-01	2025-01-15 16:30:00+00	2025-02-01	\N	2025-07-22 07:41:47.652491+00
86	ACC026	CUST026	COL001	2024-11-20	Active	Medium	48000.00	2024-10-28	2025-01-20 09:15:00+00	2025-01-24	\N	2025-07-22 07:41:47.652491+00
87	ACC027	CUST027	COL002	2024-12-15	Active	Low	28000.00	2024-12-08	2025-01-21 10:00:00+00	2025-01-25	\N	2025-07-22 07:41:47.652491+00
88	ACC028	CUST028	COL003	2024-10-25	Active	High	38000.00	2024-09-20	2025-01-19 11:30:00+00	2025-01-26	\N	2025-07-22 07:41:47.652491+00
89	ACC029	CUST029	COL004	2024-09-10	Legal	Critical	20000.00	2024-08-05	2025-01-17 12:45:00+00	2025-01-30	\N	2025-07-22 07:41:47.652491+00
90	ACC030	CUST030	COL005	2024-11-15	Active	Medium	62000.00	2024-10-22	2025-01-20 13:30:00+00	2025-01-27	\N	2025-07-22 07:41:47.652491+00
91	ACC001	CUST001	COL001	2024-10-01	Active	High	125000.00	2024-09-15	2025-01-20 10:30:00+00	2025-01-22	\N	2025-07-22 07:44:33.132608+00
92	ACC002	CUST002	COL002	2024-11-15	Active	Medium	35000.00	2024-10-20	2025-01-19 14:15:00+00	2025-01-23	\N	2025-07-22 07:44:33.132608+00
93	ACC003	CUST003	COL003	2024-09-01	Legal	Critical	950000.00	2024-08-10	2025-01-18 09:00:00+00	2025-01-25	\N	2025-07-22 07:44:33.132608+00
94	ACC004	CUST004	COL001	2024-12-05	Active	Low	65000.00	2024-11-30	2025-01-21 11:45:00+00	2025-01-24	\N	2025-07-22 07:44:33.132608+00
95	ACC005	CUST005	COL004	2024-07-01	Write-off Review	Critical	48000.00	2024-06-01	2025-01-15 16:00:00+00	2025-01-30	\N	2025-07-22 07:44:33.132608+00
96	ACC006	CUST006	COL002	2024-10-15	Active	High	580000.00	2024-09-20	2025-01-20 15:30:00+00	2025-01-26	\N	2025-07-22 07:44:33.132608+00
97	ACC007	CUST007	COL003	2024-11-20	Active	Medium	145000.00	2024-11-01	2025-01-19 10:00:00+00	2025-01-27	\N	2025-07-22 07:44:33.132608+00
98	ACC008	CUST008	COL004	2024-12-10	Active	Low	65000.00	2024-12-05	2025-01-21 14:00:00+00	2025-01-28	\N	2025-07-22 07:44:33.132608+00
99	ACC009	CUST009	COL005	2024-10-25	Active	High	720000.00	2024-09-30	2025-01-18 11:00:00+00	2025-01-29	\N	2025-07-22 07:44:33.132608+00
100	ACC010	CUST010	COL001	2024-08-15	Legal	Critical	42000.00	2024-07-10	2025-01-17 09:30:00+00	2025-01-31	\N	2025-07-22 07:44:33.132608+00
101	ACC011	CUST011	COL006	2024-11-01	Active	Medium	85000.00	2024-10-15	2025-01-20 09:00:00+00	2025-01-23	\N	2025-07-22 07:44:33.132608+00
102	ACC012	CUST012	COL007	2024-12-15	Active	Low	25000.00	2024-12-01	2025-01-21 10:30:00+00	2025-01-24	\N	2025-07-22 07:44:33.132608+00
103	ACC013	CUST013	COL008	2024-10-20	Active	High	350000.00	2024-09-25	2025-01-19 11:15:00+00	2025-01-25	\N	2025-07-22 07:44:33.132608+00
104	ACC014	CUST014	COL009	2024-12-20	Active	Low	45000.00	2024-12-10	2025-01-21 13:45:00+00	2025-01-26	\N	2025-07-22 07:44:33.132608+00
105	ACC015	CUST015	COL010	2024-11-10	Active	Medium	1350000.00	2024-10-20	2025-01-20 14:30:00+00	2025-01-27	\N	2025-07-22 07:44:33.132608+00
106	ACC016	CUST016	COL001	2024-11-05	Active	Medium	120000.00	2024-10-10	2025-01-19 15:00:00+00	2025-01-28	\N	2025-07-22 07:44:33.132608+00
107	ACC017	CUST017	COL002	2024-10-30	Active	High	55000.00	2024-09-15	2025-01-18 16:15:00+00	2025-01-29	\N	2025-07-22 07:44:33.132608+00
108	ACC018	CUST018	COL003	2024-12-25	Active	Low	95000.00	2024-12-20	2025-01-21 09:30:00+00	2025-01-30	\N	2025-07-22 07:44:33.132608+00
109	ACC019	CUST019	COL004	2024-09-15	Legal	Critical	420000.00	2024-08-01	2025-01-17 10:45:00+00	2025-01-31	\N	2025-07-22 07:44:33.132608+00
110	ACC020	CUST020	COL005	2024-12-01	Active	Medium	38000.00	2024-11-15	2025-01-20 11:30:00+00	2025-02-01	\N	2025-07-22 07:44:33.132608+00
111	ACC021	CUST021	COL006	2024-11-25	Active	Medium	18000.00	2024-10-30	2025-01-19 12:00:00+00	2025-01-25	\N	2025-07-22 07:44:33.132608+00
112	ACC022	CUST022	COL007	2024-11-15	Active	Medium	45000.00	2024-10-25	2025-01-20 13:15:00+00	2025-01-26	\N	2025-07-22 07:44:33.132608+00
113	ACC023	CUST023	COL008	2024-10-10	Active	High	22000.00	2024-09-05	2025-01-18 14:30:00+00	2025-01-27	\N	2025-07-22 07:44:33.132608+00
114	ACC024	CUST024	COL009	2024-12-10	Active	Low	58000.00	2024-11-25	2025-01-21 15:45:00+00	2025-01-28	\N	2025-07-22 07:44:33.132608+00
115	ACC025	CUST025	COL010	2024-08-20	Write-off Review	Critical	15000.00	2024-07-01	2025-01-15 16:30:00+00	2025-02-01	\N	2025-07-22 07:44:33.132608+00
116	ACC026	CUST026	COL001	2024-11-20	Active	Medium	48000.00	2024-10-28	2025-01-20 09:15:00+00	2025-01-24	\N	2025-07-22 07:44:33.132608+00
117	ACC027	CUST027	COL002	2024-12-15	Active	Low	28000.00	2024-12-08	2025-01-21 10:00:00+00	2025-01-25	\N	2025-07-22 07:44:33.132608+00
118	ACC028	CUST028	COL003	2024-10-25	Active	High	38000.00	2024-09-20	2025-01-19 11:30:00+00	2025-01-26	\N	2025-07-22 07:44:33.132608+00
119	ACC029	CUST029	COL004	2024-09-10	Legal	Critical	20000.00	2024-08-05	2025-01-17 12:45:00+00	2025-01-30	\N	2025-07-22 07:44:33.132608+00
120	ACC030	CUST030	COL005	2024-11-15	Active	Medium	62000.00	2024-10-22	2025-01-20 13:30:00+00	2025-01-27	\N	2025-07-22 07:44:33.132608+00
121	ACC001	CUST001	COL001	2024-10-01	Active	High	125000.00	2024-09-15	2025-01-20 10:30:00+00	2025-01-22	\N	2025-07-22 07:46:12.951564+00
122	ACC002	CUST002	COL002	2024-11-15	Active	Medium	35000.00	2024-10-20	2025-01-19 14:15:00+00	2025-01-23	\N	2025-07-22 07:46:12.951564+00
123	ACC003	CUST003	COL003	2024-09-01	Legal	Critical	950000.00	2024-08-10	2025-01-18 09:00:00+00	2025-01-25	\N	2025-07-22 07:46:12.951564+00
124	ACC004	CUST004	COL001	2024-12-05	Active	Low	65000.00	2024-11-30	2025-01-21 11:45:00+00	2025-01-24	\N	2025-07-22 07:46:12.951564+00
125	ACC005	CUST005	COL004	2024-07-01	Write-off Review	Critical	48000.00	2024-06-01	2025-01-15 16:00:00+00	2025-01-30	\N	2025-07-22 07:46:12.951564+00
126	ACC006	CUST006	COL002	2024-10-15	Active	High	580000.00	2024-09-20	2025-01-20 15:30:00+00	2025-01-26	\N	2025-07-22 07:46:12.951564+00
127	ACC007	CUST007	COL003	2024-11-20	Active	Medium	145000.00	2024-11-01	2025-01-19 10:00:00+00	2025-01-27	\N	2025-07-22 07:46:12.951564+00
128	ACC008	CUST008	COL004	2024-12-10	Active	Low	65000.00	2024-12-05	2025-01-21 14:00:00+00	2025-01-28	\N	2025-07-22 07:46:12.951564+00
129	ACC009	CUST009	COL005	2024-10-25	Active	High	720000.00	2024-09-30	2025-01-18 11:00:00+00	2025-01-29	\N	2025-07-22 07:46:12.951564+00
130	ACC010	CUST010	COL001	2024-08-15	Legal	Critical	42000.00	2024-07-10	2025-01-17 09:30:00+00	2025-01-31	\N	2025-07-22 07:46:12.951564+00
131	ACC011	CUST011	COL006	2024-11-01	Active	Medium	85000.00	2024-10-15	2025-01-20 09:00:00+00	2025-01-23	\N	2025-07-22 07:46:12.951564+00
132	ACC012	CUST012	COL007	2024-12-15	Active	Low	25000.00	2024-12-01	2025-01-21 10:30:00+00	2025-01-24	\N	2025-07-22 07:46:12.951564+00
133	ACC013	CUST013	COL008	2024-10-20	Active	High	350000.00	2024-09-25	2025-01-19 11:15:00+00	2025-01-25	\N	2025-07-22 07:46:12.951564+00
134	ACC014	CUST014	COL009	2024-12-20	Active	Low	45000.00	2024-12-10	2025-01-21 13:45:00+00	2025-01-26	\N	2025-07-22 07:46:12.951564+00
135	ACC015	CUST015	COL010	2024-11-10	Active	Medium	1350000.00	2024-10-20	2025-01-20 14:30:00+00	2025-01-27	\N	2025-07-22 07:46:12.951564+00
136	ACC016	CUST016	COL001	2024-11-05	Active	Medium	120000.00	2024-10-10	2025-01-19 15:00:00+00	2025-01-28	\N	2025-07-22 07:46:12.951564+00
137	ACC017	CUST017	COL002	2024-10-30	Active	High	55000.00	2024-09-15	2025-01-18 16:15:00+00	2025-01-29	\N	2025-07-22 07:46:12.951564+00
138	ACC018	CUST018	COL003	2024-12-25	Active	Low	95000.00	2024-12-20	2025-01-21 09:30:00+00	2025-01-30	\N	2025-07-22 07:46:12.951564+00
139	ACC019	CUST019	COL004	2024-09-15	Legal	Critical	420000.00	2024-08-01	2025-01-17 10:45:00+00	2025-01-31	\N	2025-07-22 07:46:12.951564+00
140	ACC020	CUST020	COL005	2024-12-01	Active	Medium	38000.00	2024-11-15	2025-01-20 11:30:00+00	2025-02-01	\N	2025-07-22 07:46:12.951564+00
141	ACC021	CUST021	COL006	2024-11-25	Active	Medium	18000.00	2024-10-30	2025-01-19 12:00:00+00	2025-01-25	\N	2025-07-22 07:46:12.951564+00
142	ACC022	CUST022	COL007	2024-11-15	Active	Medium	45000.00	2024-10-25	2025-01-20 13:15:00+00	2025-01-26	\N	2025-07-22 07:46:12.951564+00
143	ACC023	CUST023	COL008	2024-10-10	Active	High	22000.00	2024-09-05	2025-01-18 14:30:00+00	2025-01-27	\N	2025-07-22 07:46:12.951564+00
144	ACC024	CUST024	COL009	2024-12-10	Active	Low	58000.00	2024-11-25	2025-01-21 15:45:00+00	2025-01-28	\N	2025-07-22 07:46:12.951564+00
145	ACC025	CUST025	COL010	2024-08-20	Write-off Review	Critical	15000.00	2024-07-01	2025-01-15 16:30:00+00	2025-02-01	\N	2025-07-22 07:46:12.951564+00
146	ACC026	CUST026	COL001	2024-11-20	Active	Medium	48000.00	2024-10-28	2025-01-20 09:15:00+00	2025-01-24	\N	2025-07-22 07:46:12.951564+00
147	ACC027	CUST027	COL002	2024-12-15	Active	Low	28000.00	2024-12-08	2025-01-21 10:00:00+00	2025-01-25	\N	2025-07-22 07:46:12.951564+00
148	ACC028	CUST028	COL003	2024-10-25	Active	High	38000.00	2024-09-20	2025-01-19 11:30:00+00	2025-01-26	\N	2025-07-22 07:46:12.951564+00
149	ACC029	CUST029	COL004	2024-09-10	Legal	Critical	20000.00	2024-08-05	2025-01-17 12:45:00+00	2025-01-30	\N	2025-07-22 07:46:12.951564+00
150	ACC030	CUST030	COL005	2024-11-15	Active	Medium	62000.00	2024-10-22	2025-01-20 13:30:00+00	2025-01-27	\N	2025-07-22 07:46:12.951564+00
\.


--
-- Data for Name: collection_targets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection_targets (id, branch_id, target_month, target_year, target_amount, currency, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: collection_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collection_transactions (id, branch_id, transaction_date, customer_id, customer_name, account_number, transaction_type, amount, currency, payment_method, collector_id, status, reference_number, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: collector_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collector_performance (performance_id, collector_id, performance_date, assigned_cases, contacted_cases, collected_amount, target_amount, ptp_obtained, ptp_kept, calls_made, visits_made, success_rate, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:14.986602+00
2	COL001	2025-07-22	38	25	180251.61	173561.79	10	7	132	15	65.79	2025-07-22 16:48:12.156433+00
3	COL001	2025-06-22	37	25	77800.69	86650.24	10	7	87	18	67.57	2025-07-22 16:48:12.156433+00
4	COL001	2025-05-22	10	6	138587.58	140861.35	2	1	178	22	60.00	2025-07-22 16:48:12.156433+00
5	COL001	2025-04-22	16	12	176832.69	171464.63	4	2	236	20	75.00	2025-07-22 16:48:12.156433+00
6	COL001	2025-03-22	20	16	228731.05	198591.63	6	4	117	14	80.00	2025-07-22 16:48:12.156433+00
7	COL001	2025-02-22	36	31	194182.27	207576.16	12	8	203	10	86.11	2025-07-22 16:48:12.156433+00
8	COL002	2025-07-22	30	23	168944.50	155460.18	9	6	249	5	76.67	2025-07-22 16:48:12.156433+00
9	COL002	2025-06-22	28	21	285172.54	306979.98	8	5	151	21	75.00	2025-07-22 16:48:12.156433+00
10	COL002	2025-05-22	29	18	129859.05	152896.44	7	4	192	15	62.07	2025-07-22 16:48:12.156433+00
11	COL002	2025-04-22	11	8	332519.34	360952.56	3	2	67	14	72.73	2025-07-22 16:48:12.156433+00
12	COL002	2025-03-22	14	9	191886.29	164337.11	3	2	204	21	64.29	2025-07-22 16:48:12.156433+00
13	COL002	2025-02-22	38	22	209510.14	220665.17	8	5	183	23	57.89	2025-07-22 16:48:12.156433+00
14	COL003	2025-07-22	36	29	256126.46	242451.93	11	7	207	8	80.56	2025-07-22 16:48:12.156433+00
15	COL003	2025-06-22	24	15	317683.84	283499.13	6	4	245	5	62.50	2025-07-22 16:48:12.156433+00
16	COL003	2025-05-22	39	27	281144.52	232464.04	10	7	203	6	69.23	2025-07-22 16:48:12.156433+00
17	COL003	2025-04-22	33	28	212435.56	214671.99	11	7	242	9	84.85	2025-07-22 16:48:12.156433+00
18	COL003	2025-03-22	28	24	225600.79	217609.52	9	6	85	5	85.71	2025-07-22 16:48:12.156433+00
19	COL003	2025-02-22	32	24	317162.25	323325.09	9	6	189	24	75.00	2025-07-22 16:48:12.156433+00
20	COL004	2025-07-22	30	22	291659.41	329437.64	8	5	211	23	73.33	2025-07-22 16:48:12.156433+00
21	COL004	2025-06-22	14	9	233893.43	262898.82	3	2	57	20	64.29	2025-07-22 16:48:12.156433+00
22	COL004	2025-05-22	31	26	112226.47	95703.05	10	7	52	18	83.87	2025-07-22 16:48:12.156433+00
23	COL004	2025-04-22	34	23	269182.47	223963.46	9	6	153	14	67.65	2025-07-22 16:48:12.156433+00
24	COL004	2025-03-22	39	28	182150.15	205982.55	11	7	236	6	71.79	2025-07-22 16:48:12.156433+00
25	COL004	2025-02-22	25	21	226221.85	203430.73	8	5	244	6	84.00	2025-07-22 16:48:12.156433+00
26	COL005	2025-07-22	26	16	188968.14	177550.21	6	4	111	7	61.54	2025-07-22 16:48:12.156433+00
27	COL005	2025-06-22	15	12	320209.29	332896.88	4	2	151	15	80.00	2025-07-22 16:48:12.156433+00
28	COL005	2025-05-22	11	6	170813.11	178066.54	2	1	66	15	54.55	2025-07-22 16:48:12.156433+00
29	COL005	2025-04-22	12	9	61114.60	70478.18	3	2	156	13	75.00	2025-07-22 16:48:12.156433+00
30	COL005	2025-03-22	36	28	244042.26	201025.65	11	7	222	21	77.78	2025-07-22 16:48:12.156433+00
31	COL005	2025-02-22	25	19	82788.93	74180.26	7	4	99	13	76.00	2025-07-22 16:48:12.156433+00
32	COL006	2025-07-22	15	9	177926.87	146717.55	3	2	63	8	60.00	2025-07-22 16:48:12.156433+00
33	COL006	2025-06-22	14	8	265688.11	295630.48	3	2	243	17	57.14	2025-07-22 16:48:12.156433+00
34	COL006	2025-05-22	38	28	158269.65	134139.03	11	7	59	16	73.68	2025-07-22 16:48:12.156433+00
35	COL006	2025-04-22	30	24	337486.96	377816.47	9	6	193	10	80.00	2025-07-22 16:48:12.156433+00
36	COL006	2025-03-22	26	20	171780.17	192658.40	8	5	89	22	76.92	2025-07-22 16:48:12.156433+00
37	COL006	2025-02-22	30	22	274906.18	245542.49	8	5	54	11	73.33	2025-07-22 16:48:12.156433+00
38	COL007	2025-07-22	26	16	188221.88	157069.66	6	4	72	19	61.54	2025-07-22 16:48:12.156433+00
39	COL007	2025-06-22	25	19	158227.93	159425.87	7	4	143	15	76.00	2025-07-22 16:48:12.156433+00
40	COL007	2025-05-22	10	8	104954.26	108748.79	3	2	249	18	80.00	2025-07-22 16:48:12.156433+00
41	COL007	2025-04-22	34	27	170563.12	168544.16	10	7	149	14	79.41	2025-07-22 16:48:12.156433+00
42	COL007	2025-03-22	33	24	212619.66	252143.95	9	6	108	10	72.73	2025-07-22 16:48:12.156433+00
43	COL007	2025-02-22	21	14	189793.60	174160.94	5	3	198	6	66.67	2025-07-22 16:48:12.156433+00
44	COL008	2025-07-22	28	19	118739.79	142048.47	7	4	162	15	67.86	2025-07-22 16:48:12.156433+00
45	COL008	2025-06-22	26	20	339473.00	383769.28	8	5	135	10	76.92	2025-07-22 16:48:12.156433+00
46	COL008	2025-05-22	16	13	331712.56	313344.76	5	3	98	15	81.25	2025-07-22 16:48:12.156433+00
47	COL008	2025-04-22	14	11	164820.47	184968.87	4	2	129	22	78.57	2025-07-22 16:48:12.156433+00
48	COL008	2025-03-22	21	16	280008.01	242673.63	6	4	110	13	76.19	2025-07-22 16:48:12.156433+00
49	COL008	2025-02-22	24	15	348408.04	408363.66	6	4	249	17	62.50	2025-07-22 16:48:12.156433+00
50	COL009	2025-07-22	36	29	273163.78	299760.13	11	7	76	7	80.56	2025-07-22 16:48:12.156433+00
51	COL009	2025-06-22	32	20	53544.83	61848.06	8	5	88	21	62.50	2025-07-22 16:48:12.156433+00
52	COL009	2025-05-22	23	15	54169.38	55481.10	6	4	231	17	65.22	2025-07-22 16:48:12.156433+00
53	COL009	2025-04-22	11	8	141493.55	146645.53	3	2	179	23	72.73	2025-07-22 16:48:12.156433+00
54	COL009	2025-03-22	19	12	126320.30	108924.27	4	2	112	10	63.16	2025-07-22 16:48:12.156433+00
55	COL009	2025-02-22	32	20	180480.72	183286.92	8	5	235	5	62.50	2025-07-22 16:48:12.156433+00
56	COL010	2025-07-22	32	23	172589.46	141775.53	9	6	98	17	71.88	2025-07-22 16:48:12.156433+00
57	COL010	2025-06-22	34	25	271255.85	287111.25	10	7	228	11	73.53	2025-07-22 16:48:12.156433+00
58	COL010	2025-05-22	13	9	145097.94	117617.28	3	2	141	5	69.23	2025-07-22 16:48:12.156433+00
59	COL010	2025-04-22	22	17	211926.90	181344.65	6	4	62	11	77.27	2025-07-22 16:48:12.156433+00
60	COL010	2025-03-22	14	11	239464.35	237015.75	4	2	82	8	78.57	2025-07-22 16:48:12.156433+00
61	COL010	2025-02-22	13	8	71019.12	69394.93	3	2	162	14	61.54	2025-07-22 16:48:12.156433+00
\.


--
-- Data for Name: collectors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collectors (collector_id, auth_user_id, employee_name, employee_name_ar, department, team_name, supervisor_id, contact_number, email, collection_role, is_active, join_date, created_date) FROM stdin;
COL001	\N	Abdulaziz Al-Rasheed	عبدالعزيز الرشيد	Collections	Team A	SUP001	+966551234567	abdulaziz.rasheed@osoul.com	Senior Collector	t	2020-01-15	2025-07-22 07:38:28.617499+00
COL002	\N	Sara Al-Mutairi	سارة المطيري	Collections	Team A	SUP001	+966552345678	sara.mutairi@osoul.com	Collector	t	2021-06-01	2025-07-22 07:38:28.617499+00
COL003	\N	Mohammed Al-Qahtani	محمد القحطاني	Collections	Team B	SUP002	+966553456789	mohammed.qahtani@osoul.com	Senior Collector	t	2019-03-10	2025-07-22 07:38:28.617499+00
COL004	\N	Huda Al-Shahrani	هدى الشهراني	Collections	Team B	SUP002	+966554567890	huda.shahrani@osoul.com	Collector	t	2022-08-20	2025-07-22 07:38:28.617499+00
COL005	\N	Omar Al-Harbi	عمر الحربي	Collections	Team C	SUP003	+966555678901	omar.harbi@osoul.com	Team Leader	t	2018-11-05	2025-07-22 07:38:28.617499+00
COL006	\N	Fatima Al-Zahrani	فاطمة الزهراني	Collections	Team C	SUP003	+966556789012	fatima.zahrani@osoul.com	Senior Collector	t	2020-04-12	2025-07-22 07:38:28.617499+00
COL007	\N	Khalid Al-Otaibi	خالد العتيبي	Collections	Team A	SUP001	+966557890123	khalid.otaibi@osoul.com	Collector	t	2023-01-08	2025-07-22 07:38:28.617499+00
COL008	\N	Noura Al-Ghamdi	نورة الغامدي	Collections	Team B	SUP002	+966558901234	noura.ghamdi@osoul.com	Collector	t	2022-11-15	2025-07-22 07:38:28.617499+00
COL009	\N	Faisal Al-Enezi	فيصل العنزي	Collections	Team C	SUP003	+966559012345	faisal.enezi@osoul.com	Senior Collector	t	2021-02-20	2025-07-22 07:38:28.617499+00
COL010	\N	Amal Al-Shehri	أمل الشهري	Collections	Team A	SUP001	+966550123456	amal.shehri@osoul.com	Collector	t	2023-03-25	2025-07-22 07:38:28.617499+00
\.


--
-- Data for Name: customer_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_contacts (contact_id, customer_id, contact_type, contact_value, is_primary, is_valid, verified_date, created_date) FROM stdin;
1	CUST001	Mobile	+966501234567	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
2	CUST002	Mobile	+966502345678	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
3	CUST003	Mobile	+966503456789	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
4	CUST004	Mobile	+966504567890	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
5	CUST005	Mobile	+966505678901	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
6	CUST006	Mobile	+966506789012	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
7	CUST007	Mobile	+966507890123	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
8	CUST008	Mobile	+966508901234	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
9	CUST009	Mobile	+966509012345	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
10	CUST010	Mobile	+966500123456	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
11	CUST001	Email	ahmad.rashid@email.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
12	CUST001	Address	King Fahd Road, Riyadh 12345	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
13	CUST002	Home	+966112345678	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
14	CUST003	Work	+966114567890	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
15	CUST003	Email	mohammed.otaibi@business.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
16	CUST004	Email	norah.harbi@email.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
17	CUST005	Address	Al Olaya District, Riyadh 11111	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
18	CUST006	Email	aisha.dosari@email.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
19	CUST006	Work	+966113456789	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
20	CUST007	Email	abdullah.ghamdi@email.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
21	CUST008	Work	+966115678901	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
22	CUST009	Home	+966116789012	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
23	CUST010	Email	sara.mutairi@email.com	f	t	2024-01-15	2025-07-22 07:38:02.988494+00
24	CUST011	Mobile	+966511111111	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
25	CUST012	Mobile	+966512222222	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
26	CUST013	Mobile	+966513333333	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
27	CUST014	Mobile	+966514444444	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
28	CUST015	Mobile	+966515555555	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
29	CUST016	Mobile	+966516666666	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
30	CUST017	Mobile	+966517777777	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
31	CUST018	Mobile	+966518888888	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
32	CUST019	Mobile	+966519999999	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
33	CUST020	Mobile	+966520000000	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
34	CUST021	Mobile	+966521111111	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
35	CUST022	Mobile	+966522222222	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
36	CUST023	Mobile	+966523333333	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
37	CUST024	Mobile	+966524444444	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
38	CUST025	Mobile	+966525555555	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
39	CUST026	Mobile	+966526666666	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
40	CUST027	Mobile	+966527777777	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
41	CUST028	Mobile	+966528888888	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
42	CUST029	Mobile	+966529999999	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
43	CUST030	Mobile	+966530000000	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
44	CUST031	Mobile	+966531111111	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
45	CUST032	Mobile	+966532222222	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
46	CUST033	Mobile	+966533333333	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
47	CUST034	Mobile	+966534444444	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
48	CUST035	Mobile	+966535555555	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
49	CUST036	Mobile	+966536666666	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
50	CUST037	Mobile	+966537777777	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
51	CUST038	Mobile	+966538888888	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
52	CUST039	Mobile	+966539999999	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
53	CUST040	Mobile	+966540000000	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
54	CUST041	Mobile	+966541111111	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
55	CUST042	Mobile	+966542222222	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
56	CUST043	Mobile	+966543333333	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
57	CUST044	Mobile	+966544444444	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
58	CUST045	Mobile	+966545555555	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
59	CUST046	Mobile	+966546666666	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
60	CUST047	Mobile	+966547777777	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
61	CUST048	Mobile	+966548888888	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
62	CUST049	Mobile	+966549999999	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
63	CUST050	Mobile	+966550000000	t	t	2024-01-15	2025-07-22 07:38:02.988494+00
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, national_id, first_name, last_name, first_name_ar, last_name_ar, date_of_birth, gender, nationality, employment_status, employer_name, monthly_income, credit_score, risk_category, created_date, updated_date) FROM stdin;
CUST001	1234567890	Ahmad	Al-Rashid	أحمد	الراشد	1985-03-15	M	Saudi	Employed	Saudi Aramco	25000.00	750	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST002	2345678901	Fatima	Al-Zahrani	فاطمة	الزهراني	1990-07-22	F	Saudi	Employed	Ministry of Health	18000.00	680	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST003	3456789012	Mohammed	Al-Otaibi	محمد	العتيبي	1988-11-10	M	Saudi	Self-Employed	Own Business	35000.00	620	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST004	4567890123	Norah	Al-Harbi	نورة	الحربي	1992-05-18	F	Saudi	Employed	STC	15000.00	700	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST005	5678901234	Khalid	Al-Maliki	خالد	المالكي	1983-09-25	M	Saudi	Unemployed	\N	0.00	550	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST006	6789012345	Aisha	Al-Dosari	عائشة	الدوسري	1987-12-03	F	Saudi	Employed	SABIC	22000.00	720	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST007	7890123456	Abdullah	Al-Ghamdi	عبدالله	الغامدي	1991-06-28	M	Saudi	Employed	Al Rajhi Bank	16000.00	690	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST008	8901234567	Maryam	Al-Shehri	مريم	الشهري	1989-09-14	F	Saudi	Self-Employed	Fashion Store	28000.00	650	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST009	9012345678	Faisal	Al-Anazi	فيصل	العنزي	1984-01-20	M	Saudi	Employed	Ministry of Education	14000.00	710	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST010	0123456789	Sara	Al-Mutairi	سارة	المطيري	1993-04-07	F	Saudi	Employed	King Faisal Hospital	17000.00	580	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST011	1122334455	Omar	Al-Qahtani	عمر	القحطاني	1986-08-12	M	Saudi	Employed	Saudi Telecom	13000.00	670	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST012	2233445566	Layla	Al-Shammari	ليلى	الشمري	1994-02-28	F	Saudi	Employed	Flynas	11000.00	640	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST013	3344556677	Yousef	Al-Enezi	يوسف	العنزي	1982-11-05	M	Saudi	Self-Employed	Trading Company	20000.00	600	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST014	4455667788	Huda	Al-Dossari	هدى	الدوسري	1995-06-15	F	Saudi	Employed	KPMG	14500.00	695	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST015	5566778899	Turki	Al-Subaie	تركي	السبيعي	1988-03-22	M	Saudi	Employed	NEOM	30000.00	730	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST016	6677889900	Reem	Al-Rashidi	ريم	الرشيدي	1991-09-08	F	Saudi	Employed	PwC	16500.00	685	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST017	7788990011	Majed	Al-Otaibi	ماجد	العتيبي	1985-12-17	M	Saudi	Employed	Saudi Airlines	18500.00	660	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST018	8899001122	Nouf	Al-Harbi	نوف	الحربي	1993-07-03	F	Saudi	Employed	Deloitte	15500.00	705	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST019	9900112233	Saleh	Al-Ghamdi	صالح	الغامدي	1987-04-25	M	Saudi	Self-Employed	Restaurant Owner	25000.00	630	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST020	0011223344	Dalal	Al-Zahrani	دلال	الزهراني	1996-01-14	F	Saudi	Employed	Ernst & Young	13500.00	675	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST021	1234561111	Hamad	Al-Tamimi	حمد	التميمي	1989-05-20	M	Saudi	Employed	Local Company	9000.00	620	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST022	2345672222	Asma	Al-Khatib	أسماء	الخطيب	1992-10-15	F	Saudi	Employed	School Teacher	10000.00	650	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST023	3456783333	Nawaf	Al-Shahrani	نواف	الشهراني	1986-07-08	M	Saudi	Employed	Municipality	11500.00	640	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST024	4567894444	Hessa	Al-Sulaiman	حصة	السليمان	1994-03-25	F	Saudi	Employed	Private Clinic	12000.00	660	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST025	5678905555	Bandar	Al-Rasheed	بندر	الرشيد	1983-12-01	M	Saudi	Self-Employed	Small Shop	8000.00	590	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST026	6789016666	Munira	Al-Faisal	منيرة	الفيصل	1991-08-18	F	Saudi	Employed	Bank Clerk	9500.00	670	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST027	7890127777	Saud	Al-Mutlaq	سعود	المطلق	1988-02-14	M	Saudi	Employed	Government	13000.00	680	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST028	8901238888	Jawaher	Al-Rashid	جواهر	الراشد	1995-11-22	F	Saudi	Employed	Retail Store	8500.00	630	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST029	9012349999	Meshal	Al-Qahtani	مشعل	القحطاني	1985-06-30	M	Saudi	Employed	Construction	10500.00	610	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST030	0123450000	Abeer	Al-Harbi	عبير	الحربي	1993-09-12	F	Saudi	Employed	Healthcare	11000.00	655	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST031	1111222233	Fahad	Al-Dakhil	فهد	الدخيل	1990-04-05	M	Saudi	Employed	Security Guard	5000.00	580	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST032	2222333344	Wafa	Al-Salem	وفاء	السالم	1987-11-28	F	Saudi	Employed	Cashier	4500.00	570	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST033	3333444455	Nasser	Al-Otaibi	ناصر	العتيبي	1984-08-15	M	Saudi	Part-time	Uber Driver	6000.00	590	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST034	4444555566	Ghada	Al-Rasheed	غادة	الرشيد	1992-05-03	F	Saudi	Unemployed	\N	0.00	540	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST035	5555666677	Waleed	Al-Subaie	وليد	السبيعي	1989-01-20	M	Saudi	Employed	Warehouse Worker	5500.00	585	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST036	6666777788	Haifa	Al-Maliki	هيفاء	المالكي	1994-10-08	F	Saudi	Employed	Call Center	6500.00	600	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST037	7777888899	Adel	Al-Harbi	عادل	الحربي	1986-07-25	M	Saudi	Self-Employed	Taxi Driver	7000.00	595	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST038	8888999900	Basma	Al-Zahrani	بسمة	الزهراني	1991-03-12	F	Saudi	Employed	Receptionist	5800.00	605	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST039	9999000011	Rashed	Al-Ghamdi	راشد	الغامدي	1988-12-28	M	Saudi	Employed	Delivery Driver	6200.00	575	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST040	0000111122	Latifa	Al-Otaibi	لطيفة	العتيبي	1993-06-15	F	Saudi	Part-time	Home Business	4000.00	560	High	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST041	1212121212	Ibrahim	Al-Saud	إبراهيم	آل سعود	1985-09-10	M	Saudi	Employed	Oil Company	28000.00	740	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST042	2323232323	Amal	Al-Rasheed	أمل	الرشيد	1990-02-25	F	Saudi	Employed	University Professor	19000.00	710	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST043	3434343434	Sultan	Al-Qahtani	سلطان	القحطاني	1987-11-15	M	Saudi	Self-Employed	IT Consultant	32000.00	690	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST044	4545454545	Maha	Al-Shehri	مها	الشهري	1992-08-05	F	Saudi	Employed	Marketing Manager	16000.00	700	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST045	5656565656	Yasir	Al-Harbi	ياسر	الحربي	1984-05-20	M	Saudi	Employed	Engineer	21000.00	680	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST046	6767676767	Shahad	Al-Otaibi	شهد	العتيبي	1995-12-10	F	Saudi	Employed	HR Specialist	12500.00	665	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST047	7878787878	Mishal	Al-Ghamdi	مشعل	الغامدي	1989-03-30	M	Saudi	Employed	Accountant	14000.00	695	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST048	8989898989	Lulwa	Al-Zahrani	لولوة	الزهراني	1991-10-18	F	Saudi	Employed	Pharmacist	15500.00	705	Low	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST049	9090909090	Ziyad	Al-Mutairi	زياد	المطيري	1986-07-08	M	Saudi	Self-Employed	Real Estate	45000.00	630	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
CUST050	0101010101	Jawaher	Al-Subaie	جواهر	السبيعي	1994-04-22	F	Saudi	Employed	Interior Designer	13000.00	675	Medium	2025-07-22 07:37:51.418917+00	2025-07-22 07:37:51.418917+00
\.


--
-- Data for Name: dashboard_widgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dashboard_widgets (id, dashboard_id, widget_type, widget_title, position_x, position_y, width, height, config, is_visible, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: finance_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_accounts (account_id, customer_id, product_type, finance_amount, profit_rate, tenure_months, monthly_installment, outstanding_amount, principal_outstanding, profit_outstanding, origination_date, maturity_date, branch_code, officer_id, account_status, dpd, bucket, created_date) FROM stdin;
ACC001	CUST001	Auto Finance	250000.00	4.50	60	4687.50	125000.00	115000.00	10000.00	2021-01-15	2026-01-15	BR001	OFF001	Delinquent	95	Bucket 4	2025-07-22 07:38:15.536645+00
ACC002	CUST002	Personal Finance	75000.00	5.00	36	2250.00	35000.00	32000.00	3000.00	2022-03-20	2025-03-20	BR002	OFF002	Delinquent	45	Bucket 2	2025-07-22 07:38:15.536645+00
ACC003	CUST003	Home Finance	1200000.00	3.80	240	7200.00	950000.00	900000.00	50000.00	2020-06-10	2040-06-10	BR001	OFF001	Delinquent	120	Bucket 4	2025-07-22 07:38:15.536645+00
ACC004	CUST004	Auto Finance	180000.00	4.50	48	4275.00	65000.00	60000.00	5000.00	2022-09-01	2026-09-01	BR003	OFF003	Delinquent	15	Bucket 1	2025-07-22 07:38:15.536645+00
ACC005	CUST005	Personal Finance	50000.00	5.50	24	2291.67	48000.00	46000.00	2000.00	2023-01-01	2025-01-01	BR002	OFF002	Delinquent	180	Bucket 4	2025-07-22 07:38:15.536645+00
ACC006	CUST006	SME Finance	800000.00	4.20	84	11333.33	580000.00	550000.00	30000.00	2021-05-20	2028-05-20	BR001	OFF001	Delinquent	65	Bucket 3	2025-07-22 07:38:15.536645+00
ACC007	CUST007	Auto Finance	220000.00	4.50	60	4125.00	145000.00	138000.00	7000.00	2021-11-10	2026-11-10	BR002	OFF002	Delinquent	35	Bucket 2	2025-07-22 07:38:15.536645+00
ACC008	CUST008	Personal Finance	100000.00	5.00	48	2291.67	65000.00	61000.00	4000.00	2022-02-15	2026-02-15	BR003	OFF003	Current	7	Bucket 1	2025-07-22 07:38:15.536645+00
ACC009	CUST009	Home Finance	900000.00	3.80	180	6300.00	720000.00	690000.00	30000.00	2021-08-01	2036-08-01	BR001	OFF001	Delinquent	75	Bucket 3	2025-07-22 07:38:15.536645+00
ACC010	CUST010	Personal Finance	60000.00	5.50	36	1833.33	42000.00	39000.00	3000.00	2022-06-15	2025-06-15	BR002	OFF002	Delinquent	150	Bucket 4	2025-07-22 07:38:15.536645+00
ACC011	CUST011	Auto Finance	150000.00	4.50	48	3562.50	85000.00	80000.00	5000.00	2022-04-10	2026-04-10	BR001	OFF001	Delinquent	55	Bucket 2	2025-07-22 07:38:15.536645+00
ACC012	CUST012	Personal Finance	45000.00	5.00	24	2062.50	25000.00	23000.00	2000.00	2023-02-20	2025-02-20	BR002	OFF002	Delinquent	25	Bucket 1	2025-07-22 07:38:15.536645+00
ACC013	CUST013	SME Finance	500000.00	4.20	60	9333.33	350000.00	330000.00	20000.00	2021-10-15	2026-10-15	BR003	OFF003	Delinquent	90	Bucket 3	2025-07-22 07:38:15.536645+00
ACC014	CUST014	Personal Finance	80000.00	5.00	36	2400.00	45000.00	42000.00	3000.00	2022-07-01	2025-07-01	BR001	OFF001	Current	10	Bucket 1	2025-07-22 07:38:15.536645+00
ACC015	CUST015	Home Finance	1500000.00	3.80	240	9000.00	1350000.00	1300000.00	50000.00	2021-03-25	2041-03-25	BR002	OFF002	Delinquent	40	Bucket 2	2025-07-22 07:38:15.536645+00
ACC016	CUST016	Auto Finance	200000.00	4.50	60	3750.00	120000.00	113000.00	7000.00	2022-01-10	2027-01-10	BR003	OFF003	Delinquent	60	Bucket 2	2025-07-22 07:38:15.536645+00
ACC017	CUST017	Personal Finance	90000.00	5.00	48	2062.50	55000.00	52000.00	3000.00	2022-05-15	2026-05-15	BR001	OFF001	Delinquent	85	Bucket 3	2025-07-22 07:38:15.536645+00
ACC018	CUST018	Auto Finance	170000.00	4.50	48	4037.50	95000.00	90000.00	5000.00	2022-08-20	2026-08-20	BR002	OFF002	Current	5	Bucket 1	2025-07-22 07:38:15.536645+00
ACC019	CUST019	SME Finance	600000.00	4.20	72	10000.00	420000.00	400000.00	20000.00	2021-12-01	2027-12-01	BR003	OFF003	Delinquent	110	Bucket 4	2025-07-22 07:38:15.536645+00
ACC020	CUST020	Personal Finance	70000.00	5.00	36	2100.00	38000.00	35000.00	3000.00	2022-09-10	2025-09-10	BR001	OFF001	Delinquent	30	Bucket 1	2025-07-22 07:38:15.536645+00
ACC021	CUST021	Personal Finance	30000.00	5.50	24	1375.00	18000.00	17000.00	1000.00	2023-03-15	2025-03-15	BR002	OFF002	Delinquent	70	Bucket 3	2025-07-22 07:38:15.536645+00
ACC022	CUST022	Auto Finance	80000.00	4.50	36	2375.00	45000.00	42000.00	3000.00	2022-10-20	2025-10-20	BR003	OFF003	Delinquent	50	Bucket 2	2025-07-22 07:38:15.536645+00
ACC023	CUST023	Personal Finance	40000.00	5.50	24	1833.33	22000.00	20500.00	1500.00	2023-01-25	2025-01-25	BR001	OFF001	Delinquent	95	Bucket 4	2025-07-22 07:38:15.536645+00
ACC024	CUST024	Auto Finance	100000.00	4.50	48	2375.00	58000.00	55000.00	3000.00	2022-06-30	2026-06-30	BR002	OFF002	Delinquent	20	Bucket 1	2025-07-22 07:38:15.536645+00
ACC025	CUST025	Personal Finance	25000.00	5.50	18	1458.33	15000.00	14000.00	1000.00	2023-04-05	2024-10-05	BR003	OFF003	Delinquent	160	Bucket 4	2025-07-22 07:38:15.536645+00
ACC026	CUST026	Auto Finance	90000.00	4.50	36	2675.00	48000.00	45000.00	3000.00	2022-11-15	2025-11-15	BR001	OFF001	Delinquent	45	Bucket 2	2025-07-22 07:38:15.536645+00
ACC027	CUST027	Personal Finance	50000.00	5.00	36	1500.00	28000.00	26000.00	2000.00	2022-08-10	2025-08-10	BR002	OFF002	Current	12	Bucket 1	2025-07-22 07:38:15.536645+00
ACC028	CUST028	Auto Finance	70000.00	4.50	36	2083.33	38000.00	35500.00	2500.00	2022-12-20	2025-12-20	BR003	OFF003	Delinquent	80	Bucket 3	2025-07-22 07:38:15.536645+00
ACC029	CUST029	Personal Finance	35000.00	5.50	24	1604.17	20000.00	18500.00	1500.00	2023-02-15	2025-02-15	BR001	OFF001	Delinquent	125	Bucket 4	2025-07-22 07:38:15.536645+00
ACC030	CUST030	Auto Finance	110000.00	4.50	48	2612.50	62000.00	58000.00	4000.00	2022-07-25	2026-07-25	BR002	OFF002	Delinquent	55	Bucket 2	2025-07-22 07:38:15.536645+00
ACC031	CUST031	Personal Finance	20000.00	6.00	18	1166.67	15000.00	14000.00	1000.00	2023-05-10	2024-11-10	BR003	OFF003	Delinquent	200	Bucket 5	2025-07-22 07:38:15.536645+00
ACC032	CUST032	Auto Finance	60000.00	4.50	36	1785.00	32000.00	30000.00	2000.00	2023-01-15	2026-01-15	BR001	OFF001	Delinquent	140	Bucket 4	2025-07-22 07:38:15.536645+00
ACC033	CUST033	Personal Finance	30000.00	5.50	24	1375.00	18000.00	16500.00	1500.00	2023-03-20	2025-03-20	BR002	OFF002	Delinquent	100	Bucket 4	2025-07-22 07:38:15.536645+00
ACC034	CUST034	Personal Finance	15000.00	6.00	12	1291.67	12000.00	11500.00	500.00	2023-06-01	2024-06-01	BR003	OFF003	Delinquent	220	Bucket 5	2025-07-22 07:38:15.536645+00
ACC035	CUST035	Auto Finance	75000.00	4.50	36	2232.50	40000.00	37500.00	2500.00	2022-09-15	2025-09-15	BR001	OFF001	Delinquent	115	Bucket 4	2025-07-22 07:38:15.536645+00
ACC036	CUST036	Personal Finance	40000.00	5.00	36	1200.00	22000.00	20000.00	2000.00	2022-11-20	2025-11-20	BR002	OFF002	Delinquent	75	Bucket 3	2025-07-22 07:38:15.536645+00
ACC037	CUST037	Auto Finance	85000.00	4.50	48	2018.75	48000.00	45000.00	3000.00	2022-04-25	2026-04-25	BR003	OFF003	Delinquent	165	Bucket 4	2025-07-22 07:38:15.536645+00
ACC038	CUST038	Personal Finance	35000.00	5.50	24	1604.17	20000.00	18500.00	1500.00	2023-02-10	2025-02-10	BR001	OFF001	Delinquent	85	Bucket 3	2025-07-22 07:38:15.536645+00
ACC039	CUST039	Auto Finance	65000.00	4.50	36	1935.00	35000.00	32500.00	2500.00	2022-12-05	2025-12-05	BR002	OFF002	Delinquent	130	Bucket 4	2025-07-22 07:38:15.536645+00
ACC040	CUST040	Personal Finance	25000.00	6.00	18	1458.33	18000.00	17000.00	1000.00	2023-04-15	2024-10-15	BR003	OFF003	Delinquent	190	Bucket 5	2025-07-22 07:38:15.536645+00
ACC041	CUST041	Home Finance	2000000.00	3.80	240	12000.00	1850000.00	1800000.00	50000.00	2020-09-10	2040-09-10	BR001	OFF001	Delinquent	25	Bucket 1	2025-07-22 07:38:15.536645+00
ACC042	CUST042	Auto Finance	300000.00	4.50	60	5625.00	180000.00	170000.00	10000.00	2021-02-25	2026-02-25	BR002	OFF002	Delinquent	40	Bucket 2	2025-07-22 07:38:15.536645+00
ACC043	CUST043	SME Finance	1000000.00	4.20	96	13333.33	750000.00	720000.00	30000.00	2020-11-15	2028-11-15	BR003	OFF003	Delinquent	60	Bucket 2	2025-07-22 07:38:15.536645+00
ACC044	CUST044	Personal Finance	120000.00	5.00	48	2750.00	75000.00	70000.00	5000.00	2022-03-05	2026-03-05	BR001	OFF001	Current	8	Bucket 1	2025-07-22 07:38:15.536645+00
ACC045	CUST045	Auto Finance	280000.00	4.50	60	5250.00	165000.00	155000.00	10000.00	2021-05-20	2026-05-20	BR002	OFF002	Delinquent	70	Bucket 3	2025-07-22 07:38:15.536645+00
ACC046	CUST046	Personal Finance	85000.00	5.00	36	2550.00	48000.00	45000.00	3000.00	2022-07-15	2025-07-15	BR003	OFF003	Delinquent	35	Bucket 2	2025-07-22 07:38:15.536645+00
ACC047	CUST047	Auto Finance	190000.00	4.50	48	4512.50	105000.00	98000.00	7000.00	2022-01-30	2026-01-30	BR001	OFF001	Delinquent	50	Bucket 2	2025-07-22 07:38:15.536645+00
ACC048	CUST048	Personal Finance	95000.00	5.00	48	2177.08	58000.00	54000.00	4000.00	2022-04-18	2026-04-18	BR002	OFF002	Current	15	Bucket 1	2025-07-22 07:38:15.536645+00
ACC049	CUST049	SME Finance	1500000.00	4.20	120	17500.00	1200000.00	1150000.00	50000.00	2020-07-08	2030-07-08	BR003	OFF003	Delinquent	95	Bucket 4	2025-07-22 07:38:15.536645+00
ACC050	CUST050	Personal Finance	65000.00	5.00	36	1950.00	36000.00	33000.00	3000.00	2022-10-22	2025-10-22	BR001	OFF001	Delinquent	42	Bucket 2	2025-07-22 07:38:15.536645+00
\.


--
-- Data for Name: legal_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legal_cases (legal_case_id, account_id, customer_id, case_type, court_name, case_number, filing_date, lawyer_name, case_status, judgment_date, judgment_amount, legal_costs, next_hearing_date, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:13.209306+00
2	ACC024	CUST025	Bankruptcy	Dammam Commercial Court	LC-2024-0001	2025-07-04	Sarah Al-Mansouri	Judgment	\N	91369.65	10004.53	2025-07-29	2025-07-22 16:48:11.404358+00
3	ACC004	CUST031	Asset Seizure	Jeddah Commercial Court	LC-2024-0002	2025-05-11	Mohammed Al-Qasimi	Filed	2025-08-21	\N	7104.46	2025-09-18	2025-07-22 16:48:11.404358+00
4	ACC002	CUST042	Bankruptcy	Riyadh Commercial Court	LC-2024-0003	2025-03-28	Ahmed Al-Rashid	Filed	2025-08-03	\N	8365.33	2025-08-13	2025-07-22 16:48:11.404358+00
5	ACC011	CUST015	Asset Seizure	Dammam Commercial Court	LC-2024-0004	2025-06-24	Mohammed Al-Qasimi	Filed	\N	64812.39	5168.67	2025-08-28	2025-07-22 16:48:11.404358+00
6	ACC012	CUST028	Bankruptcy	Jeddah Commercial Court	LC-2024-0005	2025-07-14	Ahmed Al-Rashid	Appeal	2025-08-26	36088.48	11892.43	2025-08-10	2025-07-22 16:48:11.404358+00
7	ACC021	CUST043	Asset Seizure	Riyadh Commercial Court	LC-2024-0006	2025-04-25	Ahmed Al-Rashid	Filed	2025-09-08	45384.83	8710.44	2025-08-05	2025-07-22 16:48:11.404358+00
8	ACC017	CUST010	Garnishment	Jeddah Commercial Court	LC-2024-0007	2025-04-08	Sarah Al-Mansouri	Filed	\N	56683.27	5606.49	2025-09-14	2025-07-22 16:48:11.404358+00
9	ACC019	CUST033	Garnishment	Riyadh Commercial Court	LC-2024-0008	2025-04-11	Mohammed Al-Qasimi	In Progress	2025-08-14	\N	8034.71	2025-07-23	2025-07-22 16:48:11.404358+00
10	ACC021	CUST034	Bankruptcy	Dammam Commercial Court	LC-2024-0009	2025-06-19	Mohammed Al-Qasimi	Appeal	2025-08-25	46862.54	3638.80	2025-09-04	2025-07-22 16:48:11.404358+00
11	ACC050	CUST045	Asset Seizure	Riyadh Commercial Court	LC-2024-0010	2025-07-20	Sarah Al-Mansouri	Appeal	\N	27575.18	3826.85	2025-09-22	2025-07-22 16:48:11.404358+00
12	ACC036	CUST015	Garnishment	Dammam Commercial Court	LC-2024-0011	2025-06-03	Mohammed Al-Qasimi	Appeal	2025-08-16	\N	8911.03	2025-10-01	2025-07-22 16:48:11.404358+00
13	ACC008	CUST009	Debt Recovery	Jeddah Commercial Court	LC-2024-0012	2025-06-02	Ahmed Al-Rashid	In Progress	2025-08-20	59796.85	4270.07	2025-09-12	2025-07-22 16:48:11.404358+00
\.


--
-- Data for Name: payment_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_schedule (schedule_id, account_id, installment_no, due_date, principal_amount, profit_amount, total_amount, paid_amount, payment_date, payment_status, dpd) FROM stdin;
1	ACC001	1	2024-01-01	12058.95	80.39	12139.35	12139.35	2024-01-01	Paid	0
2	ACC001	2	2024-02-01	6609.93	44.07	6654.00	6654.00	2024-02-01	Paid	0
3	ACC001	3	2024-03-03	10163.92	67.76	10231.68	10231.68	2024-03-03	Paid	0
4	ACC001	4	2024-03-31	12851.51	85.68	12937.19	12937.19	2024-03-31	Paid	0
5	ACC001	5	2024-05-01	14748.25	98.32	14846.57	14846.57	2024-05-01	Paid	0
6	ACC001	6	2024-05-31	10969.71	73.13	11042.84	11042.84	2024-05-31	Paid	0
7	ACC001	7	2024-07-01	11071.80	73.81	11145.62	11145.62	\N	Pending	83
8	ACC001	8	2024-07-31	13415.81	89.44	13505.25	13505.25	\N	Paid	0
9	ACC001	9	2024-08-31	14079.60	93.86	14173.47	14173.47	\N	Paid	0
10	ACC001	10	2024-10-01	7962.55	53.08	8015.64	8015.64	\N	Paid	0
11	ACC001	11	2024-10-31	6769.84	45.13	6814.97	6814.97	\N	Paid	40
12	ACC001	12	2024-12-02	7130.58	47.54	7178.11	7178.11	\N	Pending	5
13	ACC002	1	2024-01-01	9793.42	65.29	9858.71	9858.71	2024-01-01	Paid	0
14	ACC002	2	2024-02-01	7077.43	47.18	7124.61	7124.61	2024-02-01	Paid	0
15	ACC002	3	2024-03-03	8508.36	56.72	8565.08	8565.08	2024-03-03	Paid	0
16	ACC002	4	2024-03-31	12356.78	82.38	12439.16	12439.16	2024-03-31	Paid	0
17	ACC002	5	2024-05-01	8259.15	55.06	8314.21	8314.21	2024-05-01	Paid	0
18	ACC002	6	2024-05-31	7127.16	47.51	7174.67	7174.67	2024-05-31	Paid	0
19	ACC002	7	2024-07-01	9373.17	62.49	9435.66	9435.66	\N	Pending	4
20	ACC002	8	2024-07-31	9367.23	62.45	9429.68	0.00	\N	Paid	30
21	ACC002	9	2024-08-31	13741.76	91.61	13833.37	13833.37	\N	Paid	45
22	ACC002	10	2024-10-01	14843.78	98.96	14942.74	14942.74	\N	Paid	88
23	ACC002	11	2024-10-31	8149.47	54.33	8203.80	8203.80	\N	Paid	23
24	ACC002	12	2024-12-02	11085.87	73.91	11159.78	11159.78	\N	Paid	46
25	ACC003	1	2024-01-01	9704.61	64.70	9769.31	9769.31	2024-01-01	Paid	0
26	ACC003	2	2024-02-01	13435.92	89.57	13525.50	13525.50	2024-02-01	Paid	0
27	ACC003	3	2024-03-03	11580.87	77.21	11658.07	11658.07	2024-03-03	Paid	0
28	ACC003	4	2024-03-31	12257.84	81.72	12339.56	12339.56	2024-03-31	Paid	0
29	ACC003	5	2024-05-01	11942.27	79.62	12021.88	12021.88	2024-05-01	Paid	0
30	ACC003	6	2024-05-31	10512.55	70.08	10582.63	10582.63	2024-05-31	Paid	0
31	ACC003	7	2024-07-01	13111.91	87.41	13199.32	13199.32	\N	Paid	10
32	ACC003	8	2024-07-31	5696.96	37.98	5734.94	0.00	\N	Paid	0
33	ACC003	9	2024-08-31	11046.85	73.65	11120.50	11120.50	\N	Pending	59
34	ACC003	10	2024-10-01	13783.59	91.89	13875.49	13875.49	\N	Paid	80
35	ACC003	11	2024-10-31	5032.12	33.55	5065.66	0.00	\N	Pending	0
36	ACC003	12	2024-12-02	14614.02	97.43	14711.45	14711.45	\N	Pending	81
37	ACC004	1	2024-01-01	9187.75	61.25	9249.01	9249.01	2024-01-01	Paid	0
38	ACC004	2	2024-02-01	10331.82	68.88	10400.70	10400.70	2024-02-01	Paid	0
39	ACC004	3	2024-03-03	10588.95	70.59	10659.54	10659.54	2024-03-03	Paid	0
40	ACC004	4	2024-03-31	6127.50	40.85	6168.35	6168.35	2024-03-31	Paid	0
41	ACC004	5	2024-05-01	9981.73	66.54	10048.27	10048.27	2024-05-01	Paid	0
42	ACC004	6	2024-05-31	14829.87	98.87	14928.74	14928.74	2024-05-31	Paid	0
43	ACC004	7	2024-07-01	10372.15	69.15	10441.30	0.00	\N	Paid	30
44	ACC004	8	2024-07-31	9250.85	61.67	9312.52	9312.52	\N	Paid	0
45	ACC004	9	2024-08-31	13909.06	92.73	14001.79	14001.79	\N	Pending	0
46	ACC004	10	2024-10-01	7846.44	52.31	7898.75	7898.75	\N	Pending	13
47	ACC004	11	2024-10-31	8565.22	57.10	8622.33	8622.33	\N	Paid	70
48	ACC004	12	2024-12-02	9546.08	63.64	9609.72	9609.72	\N	Paid	0
49	ACC005	1	2024-01-01	9105.82	60.71	9166.53	9166.53	2024-01-01	Paid	0
50	ACC005	2	2024-02-01	14167.29	94.45	14261.74	14261.74	2024-02-01	Paid	0
51	ACC005	3	2024-03-03	14247.51	94.98	14342.49	14342.49	2024-03-03	Paid	0
52	ACC005	4	2024-03-31	7825.26	52.17	7877.43	7877.43	2024-03-31	Paid	0
53	ACC005	5	2024-05-01	12884.90	85.90	12970.80	12970.80	2024-05-01	Paid	0
54	ACC005	6	2024-05-31	12191.53	81.28	12272.81	12272.81	2024-05-31	Paid	0
55	ACC005	7	2024-07-01	5679.92	37.87	5717.79	5717.79	\N	Paid	0
56	ACC005	8	2024-07-31	14048.51	93.66	14142.17	14142.17	\N	Paid	0
57	ACC005	9	2024-08-31	6993.28	46.62	7039.90	7039.90	\N	Paid	27
58	ACC005	10	2024-10-01	6832.54	45.55	6878.09	0.00	\N	Paid	17
59	ACC005	11	2024-10-31	6183.64	41.22	6224.87	0.00	\N	Paid	5
60	ACC005	12	2024-12-02	12084.79	80.57	12165.35	12165.35	\N	Paid	0
61	ACC006	1	2024-01-01	11970.42	79.80	12050.23	12050.23	2024-01-01	Paid	0
62	ACC006	2	2024-02-01	6874.79	45.83	6920.62	6920.62	2024-02-01	Paid	0
63	ACC006	3	2024-03-03	13810.25	92.07	13902.32	13902.32	2024-03-03	Paid	0
64	ACC006	4	2024-03-31	12358.89	82.39	12441.29	12441.29	2024-03-31	Paid	0
65	ACC006	5	2024-05-01	9616.22	64.11	9680.32	9680.32	2024-05-01	Paid	0
66	ACC006	6	2024-05-31	5907.60	39.38	5946.99	5946.99	2024-05-31	Paid	0
67	ACC006	7	2024-07-01	8810.21	58.73	8868.95	8868.95	\N	Paid	0
68	ACC006	8	2024-07-31	9197.50	61.32	9258.81	0.00	\N	Paid	12
69	ACC006	9	2024-08-31	7460.42	49.74	7510.15	7510.15	\N	Paid	48
70	ACC006	10	2024-10-01	14715.23	98.10	14813.33	14813.33	\N	Paid	60
71	ACC006	11	2024-10-31	12118.51	80.79	12199.30	12199.30	\N	Paid	28
72	ACC006	12	2024-12-02	5590.81	37.27	5628.08	5628.08	\N	Paid	46
73	ACC007	1	2024-01-01	8325.65	55.50	8381.15	8381.15	2024-01-01	Paid	0
74	ACC007	2	2024-02-01	11456.40	76.38	11532.78	11532.78	2024-02-01	Paid	0
75	ACC007	3	2024-03-03	8437.93	56.25	8494.19	8494.19	2024-03-03	Paid	0
76	ACC007	4	2024-03-31	8295.04	55.30	8350.34	8350.34	2024-03-31	Paid	0
77	ACC007	5	2024-05-01	8515.16	56.77	8571.92	8571.92	2024-05-01	Paid	0
78	ACC007	6	2024-05-31	12149.15	80.99	12230.14	12230.14	2024-05-31	Paid	0
79	ACC007	7	2024-07-01	5332.75	35.55	5368.30	5368.30	\N	Paid	0
80	ACC007	8	2024-07-31	8096.82	53.98	8150.80	8150.80	\N	Paid	41
81	ACC007	9	2024-08-31	10038.30	66.92	10105.22	0.00	\N	Paid	0
82	ACC007	10	2024-10-01	12674.18	84.49	12758.67	12758.67	\N	Paid	89
83	ACC007	11	2024-10-31	12296.32	81.98	12378.30	0.00	\N	Paid	16
84	ACC007	12	2024-12-02	5566.77	37.11	5603.88	5603.88	\N	Paid	11
85	ACC008	1	2024-01-01	11752.15	78.35	11830.49	11830.49	2024-01-01	Paid	0
86	ACC008	2	2024-02-01	6761.23	45.07	6806.30	6806.30	2024-02-01	Paid	0
87	ACC008	3	2024-03-03	7927.89	52.85	7980.75	7980.75	2024-03-03	Paid	0
88	ACC008	4	2024-03-31	8701.94	58.01	8759.96	8759.96	2024-03-31	Paid	0
89	ACC008	5	2024-05-01	12798.46	85.32	12883.79	12883.79	2024-05-01	Paid	0
90	ACC008	6	2024-05-31	5338.45	35.59	5374.04	5374.04	2024-05-31	Paid	0
91	ACC008	7	2024-07-01	10795.00	71.97	10866.97	10866.97	\N	Pending	9
92	ACC008	8	2024-07-31	9408.60	62.72	9471.32	9471.32	\N	Pending	3
93	ACC008	9	2024-08-31	14469.51	96.46	14565.98	0.00	\N	Pending	24
94	ACC008	10	2024-10-01	5375.87	35.84	5411.71	5411.71	\N	Paid	41
95	ACC008	11	2024-10-31	10854.49	72.36	10926.85	0.00	\N	Paid	0
96	ACC008	12	2024-12-02	8426.88	56.18	8483.06	8483.06	\N	Paid	58
97	ACC009	1	2024-01-01	5406.23	36.04	5442.27	5442.27	2024-01-01	Paid	0
98	ACC009	2	2024-02-01	6519.62	43.46	6563.09	6563.09	2024-02-01	Paid	0
99	ACC009	3	2024-03-03	13348.01	88.99	13437.00	13437.00	2024-03-03	Paid	0
100	ACC009	4	2024-03-31	10195.88	67.97	10263.85	10263.85	2024-03-31	Paid	0
101	ACC009	5	2024-05-01	10512.72	70.08	10582.80	10582.80	2024-05-01	Paid	0
102	ACC009	6	2024-05-31	11549.95	77.00	11626.95	11626.95	2024-05-31	Paid	0
103	ACC009	7	2024-07-01	14223.18	94.82	14318.00	14318.00	\N	Pending	18
104	ACC009	8	2024-07-31	9570.12	63.80	9633.92	0.00	\N	Pending	0
105	ACC009	9	2024-08-31	11419.93	76.13	11496.07	11496.07	\N	Pending	38
106	ACC009	10	2024-10-01	14642.14	97.61	14739.76	14739.76	\N	Paid	74
107	ACC009	11	2024-10-31	5516.67	36.78	5553.44	0.00	\N	Paid	38
108	ACC009	12	2024-12-02	12639.03	84.26	12723.29	12723.29	\N	Pending	0
109	ACC010	1	2024-01-01	5470.56	36.47	5507.03	5507.03	2024-01-01	Paid	0
110	ACC010	2	2024-02-01	7796.48	51.98	7848.46	7848.46	2024-02-01	Paid	0
111	ACC010	3	2024-03-03	6592.08	43.95	6636.03	6636.03	2024-03-03	Paid	0
112	ACC010	4	2024-03-31	5665.86	37.77	5703.63	5703.63	2024-03-31	Paid	0
113	ACC010	5	2024-05-01	8736.61	58.24	8794.85	8794.85	2024-05-01	Paid	0
114	ACC010	6	2024-05-31	7550.87	50.34	7601.21	7601.21	2024-05-31	Paid	0
115	ACC010	7	2024-07-01	10284.47	68.56	10353.04	10353.04	\N	Paid	48
116	ACC010	8	2024-07-31	6127.63	40.85	6168.48	6168.48	\N	Paid	2
117	ACC010	9	2024-08-31	8034.41	53.56	8087.97	0.00	\N	Paid	76
118	ACC010	10	2024-10-01	8954.64	59.70	9014.34	9014.34	\N	Paid	0
119	ACC010	11	2024-10-31	14068.65	93.79	14162.44	0.00	\N	Paid	47
120	ACC010	12	2024-12-02	7475.32	49.84	7525.15	0.00	\N	Paid	0
121	ACC011	1	2024-01-01	13873.68	92.49	13966.17	13966.17	2024-01-01	Paid	0
122	ACC011	2	2024-02-01	12158.39	81.06	12239.44	12239.44	2024-02-01	Paid	0
123	ACC011	3	2024-03-03	13796.08	91.97	13888.05	13888.05	2024-03-03	Paid	0
124	ACC011	4	2024-03-31	12663.46	84.42	12747.89	12747.89	2024-03-31	Paid	0
125	ACC011	5	2024-05-01	13271.67	88.48	13360.15	13360.15	2024-05-01	Paid	0
126	ACC011	6	2024-05-31	13668.77	91.13	13759.90	13759.90	2024-05-31	Paid	0
127	ACC011	7	2024-07-01	9200.17	61.33	9261.50	0.00	\N	Paid	0
128	ACC011	8	2024-07-31	13904.82	92.70	13997.52	13997.52	\N	Paid	15
129	ACC011	9	2024-08-31	11315.02	75.43	11390.45	11390.45	\N	Paid	32
130	ACC011	10	2024-10-01	12808.10	85.39	12893.49	12893.49	\N	Paid	87
131	ACC011	11	2024-10-31	12057.52	80.38	12137.90	0.00	\N	Paid	42
132	ACC011	12	2024-12-02	11925.91	79.51	12005.41	12005.41	\N	Pending	12
133	ACC012	1	2024-01-01	10973.80	73.16	11046.96	11046.96	2024-01-01	Paid	0
134	ACC012	2	2024-02-01	11271.11	75.14	11346.25	11346.25	2024-02-01	Paid	0
135	ACC012	3	2024-03-03	7723.38	51.49	7774.87	7774.87	2024-03-03	Paid	0
136	ACC012	4	2024-03-31	10334.25	68.89	10403.14	10403.14	2024-03-31	Paid	0
137	ACC012	5	2024-05-01	11898.57	79.32	11977.89	11977.89	2024-05-01	Paid	0
138	ACC012	6	2024-05-31	10219.74	68.13	10287.87	10287.87	2024-05-31	Paid	0
139	ACC012	7	2024-07-01	13734.85	91.57	13826.41	13826.41	\N	Paid	22
140	ACC012	8	2024-07-31	11508.73	76.72	11585.46	11585.46	\N	Paid	24
141	ACC012	9	2024-08-31	9534.66	63.56	9598.22	9598.22	\N	Paid	0
142	ACC012	10	2024-10-01	12711.93	84.75	12796.68	12796.68	\N	Paid	26
143	ACC012	11	2024-10-31	14756.27	98.38	14854.65	14854.65	\N	Paid	30
144	ACC012	12	2024-12-02	7043.31	46.96	7090.27	7090.27	\N	Pending	18
145	ACC013	1	2024-01-01	13064.44	87.10	13151.53	13151.53	2024-01-01	Paid	0
146	ACC013	2	2024-02-01	13190.03	87.93	13277.97	13277.97	2024-02-01	Paid	0
147	ACC013	3	2024-03-03	5352.44	35.68	5388.13	5388.13	2024-03-03	Paid	0
148	ACC013	4	2024-03-31	14090.49	93.94	14184.43	14184.43	2024-03-31	Paid	0
149	ACC013	5	2024-05-01	14916.23	99.44	15015.67	15015.67	2024-05-01	Paid	0
150	ACC013	6	2024-05-31	7767.37	51.78	7819.16	7819.16	2024-05-31	Paid	0
151	ACC013	7	2024-07-01	6576.45	43.84	6620.29	6620.29	\N	Paid	0
152	ACC013	8	2024-07-31	10844.13	72.29	10916.43	10916.43	\N	Paid	0
153	ACC013	9	2024-08-31	7067.18	47.11	7114.29	7114.29	\N	Pending	42
154	ACC013	10	2024-10-01	9417.17	62.78	9479.95	0.00	\N	Paid	0
155	ACC013	11	2024-10-31	5808.36	38.72	5847.08	0.00	\N	Paid	28
156	ACC013	12	2024-12-02	7987.85	53.25	8041.10	8041.10	\N	Paid	12
157	ACC014	1	2024-01-01	10216.58	68.11	10284.69	10284.69	2024-01-01	Paid	0
158	ACC014	2	2024-02-01	6971.50	46.48	7017.97	7017.97	2024-02-01	Paid	0
159	ACC014	3	2024-03-03	12578.25	83.85	12662.10	12662.10	2024-03-03	Paid	0
160	ACC014	4	2024-03-31	14428.04	96.19	14524.23	14524.23	2024-03-31	Paid	0
161	ACC014	5	2024-05-01	12992.14	86.61	13078.75	13078.75	2024-05-01	Paid	0
162	ACC014	6	2024-05-31	13767.12	91.78	13858.90	13858.90	2024-05-31	Paid	0
163	ACC014	7	2024-07-01	14491.67	96.61	14588.28	0.00	\N	Paid	59
164	ACC014	8	2024-07-31	10562.42	70.42	10632.83	10632.83	\N	Paid	62
165	ACC014	9	2024-08-31	7352.95	49.02	7401.97	7401.97	\N	Paid	5
166	ACC014	10	2024-10-01	11604.15	77.36	11681.51	0.00	\N	Paid	79
167	ACC014	11	2024-10-31	10597.58	70.65	10668.23	10668.23	\N	Paid	58
168	ACC014	12	2024-12-02	10773.23	71.82	10845.05	10845.05	\N	Paid	87
169	ACC015	1	2024-01-01	12538.38	83.59	12621.97	12621.97	2024-01-01	Paid	0
170	ACC015	2	2024-02-01	9748.88	64.99	9813.87	9813.87	2024-02-01	Paid	0
171	ACC015	3	2024-03-03	10014.31	66.76	10081.08	10081.08	2024-03-03	Paid	0
172	ACC015	4	2024-03-31	8214.77	54.77	8269.53	8269.53	2024-03-31	Paid	0
173	ACC015	5	2024-05-01	10100.91	67.34	10168.25	10168.25	2024-05-01	Paid	0
174	ACC015	6	2024-05-31	6196.41	41.31	6237.72	6237.72	2024-05-31	Paid	0
175	ACC015	7	2024-07-01	12490.27	83.27	12573.54	0.00	\N	Pending	84
176	ACC015	8	2024-07-31	5492.22	36.61	5528.83	5528.83	\N	Pending	71
177	ACC015	9	2024-08-31	8362.48	55.75	8418.23	8418.23	\N	Pending	10
178	ACC015	10	2024-10-01	8194.39	54.63	8249.02	0.00	\N	Paid	0
179	ACC015	11	2024-10-31	11051.36	73.68	11125.03	11125.03	\N	Pending	65
180	ACC015	12	2024-12-02	14679.84	97.87	14777.71	14777.71	\N	Paid	0
181	ACC016	1	2024-01-01	13242.67	88.28	13330.96	13330.96	2024-01-01	Paid	0
182	ACC016	2	2024-02-01	11817.40	78.78	11896.18	11896.18	2024-02-01	Paid	0
183	ACC016	3	2024-03-03	7084.81	47.23	7132.04	7132.04	2024-03-03	Paid	0
184	ACC016	4	2024-03-31	14117.93	94.12	14212.05	14212.05	2024-03-31	Paid	0
185	ACC016	5	2024-05-01	9385.13	62.57	9447.69	9447.69	2024-05-01	Paid	0
186	ACC016	6	2024-05-31	5384.55	35.90	5420.44	5420.44	2024-05-31	Paid	0
187	ACC016	7	2024-07-01	14651.36	97.68	14749.04	14749.04	\N	Pending	79
188	ACC016	8	2024-07-31	7901.24	52.67	7953.91	0.00	\N	Paid	0
189	ACC016	9	2024-08-31	14131.02	94.21	14225.23	0.00	\N	Pending	45
190	ACC016	10	2024-10-01	9448.68	62.99	9511.67	9511.67	\N	Paid	87
191	ACC016	11	2024-10-31	12805.99	85.37	12891.36	12891.36	\N	Paid	0
192	ACC016	12	2024-12-02	12966.23	86.44	13052.67	13052.67	\N	Pending	6
193	ACC017	1	2024-01-01	11264.29	75.10	11339.38	11339.38	2024-01-01	Paid	0
194	ACC017	2	2024-02-01	10248.38	68.32	10316.70	10316.70	2024-02-01	Paid	0
195	ACC017	3	2024-03-03	9213.35	61.42	9274.77	9274.77	2024-03-03	Paid	0
196	ACC017	4	2024-03-31	8632.01	57.55	8689.56	8689.56	2024-03-31	Paid	0
197	ACC017	5	2024-05-01	14111.45	94.08	14205.53	14205.53	2024-05-01	Paid	0
198	ACC017	6	2024-05-31	6244.72	41.63	6286.36	6286.36	2024-05-31	Paid	0
199	ACC017	7	2024-07-01	10251.18	68.34	10319.52	10319.52	\N	Paid	77
200	ACC017	8	2024-07-31	12242.06	81.61	12323.67	0.00	\N	Paid	67
201	ACC017	9	2024-08-31	10585.68	70.57	10656.25	10656.25	\N	Paid	48
202	ACC017	10	2024-10-01	10885.82	72.57	10958.39	10958.39	\N	Paid	0
203	ACC017	11	2024-10-31	8602.85	57.35	8660.20	8660.20	\N	Pending	0
204	ACC017	12	2024-12-02	5079.66	33.86	5113.53	5113.53	\N	Pending	18
205	ACC018	1	2024-01-01	9073.13	60.49	9133.62	9133.62	2024-01-01	Paid	0
206	ACC018	2	2024-02-01	8229.06	54.86	8283.92	8283.92	2024-02-01	Paid	0
207	ACC018	3	2024-03-03	8214.30	54.76	8269.06	8269.06	2024-03-03	Paid	0
208	ACC018	4	2024-03-31	6197.33	41.32	6238.64	6238.64	2024-03-31	Paid	0
209	ACC018	5	2024-05-01	14828.96	98.86	14927.82	14927.82	2024-05-01	Paid	0
210	ACC018	6	2024-05-31	13212.78	88.09	13300.86	13300.86	2024-05-31	Paid	0
211	ACC018	7	2024-07-01	10169.56	67.80	10237.36	10237.36	\N	Pending	52
212	ACC018	8	2024-07-31	9538.79	63.59	9602.38	0.00	\N	Pending	2
213	ACC018	9	2024-08-31	5816.31	38.78	5855.09	5855.09	\N	Paid	34
214	ACC018	10	2024-10-01	10366.08	69.11	10435.19	10435.19	\N	Paid	10
215	ACC018	11	2024-10-31	11366.17	75.77	11441.94	11441.94	\N	Paid	3
216	ACC018	12	2024-12-02	14033.07	93.55	14126.62	0.00	\N	Paid	64
217	ACC019	1	2024-01-01	11073.44	73.82	11147.26	11147.26	2024-01-01	Paid	0
218	ACC019	2	2024-02-01	5228.50	34.86	5263.35	5263.35	2024-02-01	Paid	0
219	ACC019	3	2024-03-03	12638.42	84.26	12722.68	12722.68	2024-03-03	Paid	0
220	ACC019	4	2024-03-31	9996.82	66.65	10063.47	10063.47	2024-03-31	Paid	0
221	ACC019	5	2024-05-01	7030.74	46.87	7077.62	7077.62	2024-05-01	Paid	0
222	ACC019	6	2024-05-31	13507.69	90.05	13597.74	13597.74	2024-05-31	Paid	0
223	ACC019	7	2024-07-01	12305.91	82.04	12387.95	12387.95	\N	Paid	63
224	ACC019	8	2024-07-31	10082.08	67.21	10149.30	10149.30	\N	Paid	0
225	ACC019	9	2024-08-31	8203.65	54.69	8258.34	0.00	\N	Pending	11
226	ACC019	10	2024-10-01	5548.78	36.99	5585.77	0.00	\N	Paid	29
227	ACC019	11	2024-10-31	5440.92	36.27	5477.19	0.00	\N	Pending	45
228	ACC019	12	2024-12-02	5290.80	35.27	5326.07	5326.07	\N	Paid	50
229	ACC020	1	2024-01-01	5844.80	38.97	5883.77	5883.77	2024-01-01	Paid	0
230	ACC020	2	2024-02-01	9350.52	62.34	9412.86	9412.86	2024-02-01	Paid	0
231	ACC020	3	2024-03-03	9300.93	62.01	9362.94	9362.94	2024-03-03	Paid	0
232	ACC020	4	2024-03-31	8383.26	55.89	8439.14	8439.14	2024-03-31	Paid	0
233	ACC020	5	2024-05-01	7264.54	48.43	7312.97	7312.97	2024-05-01	Paid	0
234	ACC020	6	2024-05-31	7744.28	51.63	7795.90	7795.90	2024-05-31	Paid	0
235	ACC020	7	2024-07-01	14841.70	98.94	14940.65	14940.65	\N	Pending	0
236	ACC020	8	2024-07-31	9062.86	60.42	9123.28	0.00	\N	Pending	0
237	ACC020	9	2024-08-31	10960.95	73.07	11034.03	11034.03	\N	Pending	6
238	ACC020	10	2024-10-01	10683.07	71.22	10754.29	0.00	\N	Pending	32
239	ACC020	11	2024-10-31	11264.32	75.10	11339.42	0.00	\N	Paid	47
240	ACC020	12	2024-12-02	14884.54	99.23	14983.77	0.00	\N	Pending	0
241	ACC021	1	2024-01-01	11406.04	76.04	11482.08	11482.08	2024-01-01	Paid	0
242	ACC021	2	2024-02-01	12903.83	86.03	12989.86	12989.86	2024-02-01	Paid	0
243	ACC021	3	2024-03-03	6510.32	43.40	6553.72	6553.72	2024-03-03	Paid	0
244	ACC021	4	2024-03-31	5479.08	36.53	5515.61	5515.61	2024-03-31	Paid	0
245	ACC021	5	2024-05-01	14264.10	95.09	14359.19	14359.19	2024-05-01	Paid	0
246	ACC021	6	2024-05-31	12612.56	84.08	12696.64	12696.64	2024-05-31	Paid	0
247	ACC021	7	2024-07-01	9702.64	64.68	9767.32	9767.32	\N	Paid	72
248	ACC021	8	2024-07-31	14762.50	98.42	14860.91	14860.91	\N	Pending	84
249	ACC021	9	2024-08-31	10585.59	70.57	10656.16	10656.16	\N	Paid	54
250	ACC021	10	2024-10-01	9613.17	64.09	9677.26	9677.26	\N	Paid	0
251	ACC021	11	2024-10-31	7993.78	53.29	8047.07	8047.07	\N	Paid	0
252	ACC021	12	2024-12-02	12832.17	85.55	12917.72	0.00	\N	Paid	14
253	ACC022	1	2024-01-01	14195.31	94.64	14289.94	14289.94	2024-01-01	Paid	0
254	ACC022	2	2024-02-01	13548.62	90.32	13638.94	13638.94	2024-02-01	Paid	0
255	ACC022	3	2024-03-03	6545.13	43.63	6588.76	6588.76	2024-03-03	Paid	0
256	ACC022	4	2024-03-31	7113.13	47.42	7160.55	7160.55	2024-03-31	Paid	0
257	ACC022	5	2024-05-01	9076.22	60.51	9136.72	9136.72	2024-05-01	Paid	0
258	ACC022	6	2024-05-31	11040.78	73.61	11114.38	11114.38	2024-05-31	Paid	0
259	ACC022	7	2024-07-01	13621.91	90.81	13712.72	13712.72	\N	Paid	0
260	ACC022	8	2024-07-31	9439.71	62.93	9502.64	9502.64	\N	Paid	0
261	ACC022	9	2024-08-31	7716.84	51.45	7768.29	7768.29	\N	Paid	25
262	ACC022	10	2024-10-01	14483.10	96.55	14579.66	14579.66	\N	Paid	0
263	ACC022	11	2024-10-31	10848.97	72.33	10921.29	0.00	\N	Paid	74
264	ACC022	12	2024-12-02	12553.59	83.69	12637.28	12637.28	\N	Pending	40
265	ACC023	1	2024-01-01	10665.48	71.10	10736.58	10736.58	2024-01-01	Paid	0
266	ACC023	2	2024-02-01	11137.02	74.25	11211.27	11211.27	2024-02-01	Paid	0
267	ACC023	3	2024-03-03	13580.74	90.54	13671.27	13671.27	2024-03-03	Paid	0
268	ACC023	4	2024-03-31	5557.13	37.05	5594.17	5594.17	2024-03-31	Paid	0
269	ACC023	5	2024-05-01	12758.05	85.05	12843.11	12843.11	2024-05-01	Paid	0
270	ACC023	6	2024-05-31	10512.21	70.08	10582.29	10582.29	2024-05-31	Paid	0
271	ACC023	7	2024-07-01	13533.70	90.22	13623.93	13623.93	\N	Paid	0
272	ACC023	8	2024-07-31	9810.63	65.40	9876.03	0.00	\N	Pending	87
273	ACC023	9	2024-08-31	9493.19	63.29	9556.48	9556.48	\N	Paid	0
274	ACC023	10	2024-10-01	8273.62	55.16	8328.78	8328.78	\N	Paid	9
275	ACC023	11	2024-10-31	14964.13	99.76	15063.89	15063.89	\N	Pending	64
276	ACC023	12	2024-12-02	11630.95	77.54	11708.49	0.00	\N	Paid	0
277	ACC024	1	2024-01-01	12797.39	85.32	12882.70	12882.70	2024-01-01	Paid	0
278	ACC024	2	2024-02-01	9680.21	64.53	9744.75	9744.75	2024-02-01	Paid	0
279	ACC024	3	2024-03-03	9927.71	66.18	9993.89	9993.89	2024-03-03	Paid	0
280	ACC024	4	2024-03-31	12907.05	86.05	12993.09	12993.09	2024-03-31	Paid	0
281	ACC024	5	2024-05-01	5161.73	34.41	5196.15	5196.15	2024-05-01	Paid	0
282	ACC024	6	2024-05-31	8461.89	56.41	8518.30	8518.30	2024-05-31	Paid	0
283	ACC024	7	2024-07-01	5256.03	35.04	5291.07	5291.07	\N	Pending	61
284	ACC024	8	2024-07-31	10819.14	72.13	10891.26	10891.26	\N	Pending	46
285	ACC024	9	2024-08-31	12885.09	85.90	12970.99	0.00	\N	Paid	50
286	ACC024	10	2024-10-01	5579.56	37.20	5616.76	0.00	\N	Paid	0
287	ACC024	11	2024-10-31	6189.54	41.26	6230.80	0.00	\N	Paid	2
288	ACC024	12	2024-12-02	12991.72	86.61	13078.33	13078.33	\N	Paid	76
289	ACC025	1	2024-01-01	13694.08	91.29	13785.37	13785.37	2024-01-01	Paid	0
290	ACC025	2	2024-02-01	8024.55	53.50	8078.05	8078.05	2024-02-01	Paid	0
291	ACC025	3	2024-03-03	6040.86	40.27	6081.13	6081.13	2024-03-03	Paid	0
292	ACC025	4	2024-03-31	7363.53	49.09	7412.62	7412.62	2024-03-31	Paid	0
293	ACC025	5	2024-05-01	12459.35	83.06	12542.41	12542.41	2024-05-01	Paid	0
294	ACC025	6	2024-05-31	9492.67	63.28	9555.95	9555.95	2024-05-31	Paid	0
295	ACC025	7	2024-07-01	7856.08	52.37	7908.45	0.00	\N	Paid	0
296	ACC025	8	2024-07-31	11424.66	76.16	11500.82	11500.82	\N	Paid	35
297	ACC025	9	2024-08-31	9772.61	65.15	9837.76	9837.76	\N	Pending	55
298	ACC025	10	2024-10-01	9681.04	64.54	9745.58	9745.58	\N	Pending	0
299	ACC025	11	2024-10-31	11897.99	79.32	11977.31	11977.31	\N	Paid	51
300	ACC025	12	2024-12-02	14405.03	96.03	14501.06	0.00	\N	Paid	16
301	ACC026	1	2024-01-01	7611.31	50.74	7662.05	7662.05	2024-01-01	Paid	0
302	ACC026	2	2024-02-01	9829.91	65.53	9895.45	9895.45	2024-02-01	Paid	0
303	ACC026	3	2024-03-03	14976.05	99.84	15075.89	15075.89	2024-03-03	Paid	0
304	ACC026	4	2024-03-31	12361.90	82.41	12444.32	12444.32	2024-03-31	Paid	0
305	ACC026	5	2024-05-01	7542.77	50.29	7593.05	7593.05	2024-05-01	Paid	0
306	ACC026	6	2024-05-31	10902.18	72.68	10974.86	10974.86	2024-05-31	Paid	0
307	ACC026	7	2024-07-01	6262.80	41.75	6304.55	6304.55	\N	Paid	62
308	ACC026	8	2024-07-31	11864.67	79.10	11943.77	11943.77	\N	Paid	46
309	ACC026	9	2024-08-31	6049.83	40.33	6090.17	0.00	\N	Pending	3
310	ACC026	10	2024-10-01	14628.83	97.53	14726.35	14726.35	\N	Paid	18
311	ACC026	11	2024-10-31	7667.39	51.12	7718.51	7718.51	\N	Pending	0
312	ACC026	12	2024-12-02	14258.33	95.06	14353.38	14353.38	\N	Pending	9
313	ACC027	1	2024-01-01	5217.49	34.78	5252.27	5252.27	2024-01-01	Paid	0
314	ACC027	2	2024-02-01	14632.99	97.55	14730.54	14730.54	2024-02-01	Paid	0
315	ACC027	3	2024-03-03	9439.74	62.93	9502.67	9502.67	2024-03-03	Paid	0
316	ACC027	4	2024-03-31	6082.97	40.55	6123.52	6123.52	2024-03-31	Paid	0
317	ACC027	5	2024-05-01	7119.48	47.46	7166.94	7166.94	2024-05-01	Paid	0
318	ACC027	6	2024-05-31	13630.05	90.87	13720.92	13720.92	2024-05-31	Paid	0
319	ACC027	7	2024-07-01	9128.25	60.85	9189.10	0.00	\N	Paid	30
320	ACC027	8	2024-07-31	14734.54	98.23	14832.77	0.00	\N	Paid	19
321	ACC027	9	2024-08-31	8003.33	53.36	8056.69	8056.69	\N	Pending	0
322	ACC027	10	2024-10-01	7804.80	52.03	7856.83	7856.83	\N	Pending	12
323	ACC027	11	2024-10-31	11933.30	79.56	12012.86	0.00	\N	Paid	11
324	ACC027	12	2024-12-02	7188.11	47.92	7236.03	7236.03	\N	Pending	0
325	ACC028	1	2024-01-01	11254.28	75.03	11329.31	11329.31	2024-01-01	Paid	0
326	ACC028	2	2024-02-01	14775.43	98.50	14873.93	14873.93	2024-02-01	Paid	0
327	ACC028	3	2024-03-03	10616.20	70.77	10686.98	10686.98	2024-03-03	Paid	0
328	ACC028	4	2024-03-31	5443.27	36.29	5479.56	5479.56	2024-03-31	Paid	0
329	ACC028	5	2024-05-01	7024.53	46.83	7071.36	7071.36	2024-05-01	Paid	0
330	ACC028	6	2024-05-31	5347.96	35.65	5383.62	5383.62	2024-05-31	Paid	0
331	ACC028	7	2024-07-01	12628.90	84.19	12713.09	12713.09	\N	Paid	0
332	ACC028	8	2024-07-31	8841.51	58.94	8900.45	8900.45	\N	Paid	81
333	ACC028	9	2024-08-31	8022.54	53.48	8076.02	8076.02	\N	Paid	76
334	ACC028	10	2024-10-01	6903.95	46.03	6949.98	6949.98	\N	Paid	0
335	ACC028	11	2024-10-31	11151.60	74.34	11225.95	11225.95	\N	Paid	51
336	ACC028	12	2024-12-02	9805.47	65.37	9870.84	9870.84	\N	Paid	5
337	ACC029	1	2024-01-01	8583.71	57.22	8640.93	8640.93	2024-01-01	Paid	0
338	ACC029	2	2024-02-01	10412.22	69.41	10481.63	10481.63	2024-02-01	Paid	0
339	ACC029	3	2024-03-03	12918.88	86.13	13005.01	13005.01	2024-03-03	Paid	0
340	ACC029	4	2024-03-31	10661.15	71.07	10732.23	10732.23	2024-03-31	Paid	0
341	ACC029	5	2024-05-01	13520.90	90.14	13611.04	13611.04	2024-05-01	Paid	0
342	ACC029	6	2024-05-31	14444.87	96.30	14541.17	14541.17	2024-05-31	Paid	0
343	ACC029	7	2024-07-01	5313.59	35.42	5349.01	0.00	\N	Pending	65
344	ACC029	8	2024-07-31	10571.71	70.48	10642.19	10642.19	\N	Paid	63
345	ACC029	9	2024-08-31	12643.52	84.29	12727.81	12727.81	\N	Paid	0
346	ACC029	10	2024-10-01	9795.83	65.31	9861.14	9861.14	\N	Paid	43
347	ACC029	11	2024-10-31	13963.48	93.09	14056.57	14056.57	\N	Paid	86
348	ACC029	12	2024-12-02	9352.54	62.35	9414.89	9414.89	\N	Pending	89
349	ACC030	1	2024-01-01	9021.15	60.14	9081.29	9081.29	2024-01-01	Paid	0
350	ACC030	2	2024-02-01	9132.39	60.88	9193.27	9193.27	2024-02-01	Paid	0
351	ACC030	3	2024-03-03	8691.81	57.95	8749.75	8749.75	2024-03-03	Paid	0
352	ACC030	4	2024-03-31	13822.70	92.15	13914.85	13914.85	2024-03-31	Paid	0
353	ACC030	5	2024-05-01	9481.57	63.21	9544.78	9544.78	2024-05-01	Paid	0
354	ACC030	6	2024-05-31	7674.88	51.17	7726.04	7726.04	2024-05-31	Paid	0
355	ACC030	7	2024-07-01	13076.05	87.17	13163.22	13163.22	\N	Paid	70
356	ACC030	8	2024-07-31	13440.49	89.60	13530.09	13530.09	\N	Paid	72
357	ACC030	9	2024-08-31	9295.06	61.97	9357.03	9357.03	\N	Paid	0
358	ACC030	10	2024-10-01	14907.57	99.38	15006.95	15006.95	\N	Pending	11
359	ACC030	11	2024-10-31	8159.01	54.39	8213.40	8213.40	\N	Paid	42
360	ACC030	12	2024-12-02	14215.52	94.77	14310.29	14310.29	\N	Paid	36
\.


--
-- Data for Name: payment_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_transactions (transaction_id, account_id, customer_id, payment_date, payment_amount, payment_method, payment_channel, receipt_number, collected_by, allocation_type, principal_paid, profit_paid, late_fee_paid, transaction_status, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:12.645897+00
2	ACC049	CUST044	2025-02-03	3812.71	Bank Transfer	Mobile App	RCP17532028902391	COL006	Mixed	3050.17	571.91	190.64	Cancelled	2025-07-22 16:48:10.667531+00
3	ACC050	CUST050	2025-01-31	15418.74	Online Payment	Branch	RCP17532028902392	COL003	Principal	12334.99	2312.81	770.94	Completed	2025-07-22 16:48:10.667531+00
4	ACC003	CUST017	2025-03-29	18095.61	Online Payment	Branch	RCP17532028902393	COL002	Principal	14476.49	2714.34	904.78	Pending	2025-07-22 16:48:10.667531+00
5	ACC025	CUST050	2025-05-16	16470.53	Direct Debit	Mobile App	RCP17532028902394	COL010	Profit	13176.42	2470.58	823.53	Completed	2025-07-22 16:48:10.667531+00
6	ACC049	CUST006	2025-06-03	24340.33	Direct Debit	Online	RCP17532028902395	COL004	Mixed	19472.26	3651.05	1217.02	Failed	2025-07-22 16:48:10.667531+00
7	ACC039	CUST026	2025-05-23	10991.63	Direct Debit	Mobile App	RCP17532028902396	COL008	Principal	8793.30	1648.74	549.58	Pending	2025-07-22 16:48:10.667531+00
8	ACC014	CUST032	2025-02-25	17813.11	Check	Branch	RCP17532028902397	COL004	Profit	14250.49	2671.97	890.66	Failed	2025-07-22 16:48:10.667531+00
9	ACC043	CUST024	2025-02-11	17550.92	Direct Debit	Branch	RCP17532028902398	COL010	Late Fee	14040.74	2632.64	877.55	Completed	2025-07-22 16:48:10.667531+00
10	ACC037	CUST035	2025-07-21	13396.07	Online Payment	Branch	RCP17532028902399	COL002	Profit	10716.86	2009.41	669.80	Failed	2025-07-22 16:48:10.667531+00
11	ACC028	CUST033	2025-02-14	14619.55	Bank Transfer	Mobile App	RCP175320289023910	COL006	Profit	11695.64	2192.93	730.98	Cancelled	2025-07-22 16:48:10.667531+00
12	ACC016	CUST050	2025-02-15	25991.23	Direct Debit	Call Center	RCP175320289023911	COL007	Mixed	20792.98	3898.68	1299.56	Cancelled	2025-07-22 16:48:10.667531+00
13	ACC035	CUST033	2025-04-18	10891.28	Bank Transfer	Mobile App	RCP175320289023912	COL002	Late Fee	8713.02	1633.69	544.56	Completed	2025-07-22 16:48:10.667531+00
14	ACC022	CUST013	2025-07-09	4511.54	Online Payment	ATM	RCP175320289023913	COL003	Mixed	3609.23	676.73	225.58	Failed	2025-07-22 16:48:10.667531+00
15	ACC011	CUST016	2025-06-22	12361.21	Cash	Call Center	RCP175320289023914	COL004	Profit	9888.97	1854.18	618.06	Completed	2025-07-22 16:48:10.667531+00
16	ACC043	CUST021	2025-04-03	4955.84	Bank Transfer	Call Center	RCP175320289024015	COL006	Profit	3964.67	743.38	247.79	Cancelled	2025-07-22 16:48:10.667531+00
17	ACC045	CUST017	2025-02-12	21337.05	Direct Debit	ATM	RCP175320289024016	COL010	Late Fee	17069.64	3200.56	1066.85	Completed	2025-07-22 16:48:10.667531+00
18	ACC029	CUST002	2025-03-01	8651.66	Online Payment	ATM	RCP175320289024017	COL008	Profit	6921.33	1297.75	432.58	Cancelled	2025-07-22 16:48:10.667531+00
19	ACC037	CUST001	2025-02-23	3235.91	Check	Mobile App	RCP175320289024018	COL001	Principal	2588.73	485.39	161.80	Cancelled	2025-07-22 16:48:10.667531+00
20	ACC043	CUST038	2025-05-06	19620.64	Check	Mobile App	RCP175320289024019	COL008	Profit	15696.51	2943.10	981.03	Failed	2025-07-22 16:48:10.667531+00
21	ACC005	CUST023	2025-06-03	20914.94	Direct Debit	ATM	RCP175320289024020	COL006	Late Fee	16731.95	3137.24	1045.75	Cancelled	2025-07-22 16:48:10.667531+00
22	ACC014	CUST024	2025-06-13	20165.74	Direct Debit	Branch	RCP175320289024021	COL009	Mixed	16132.59	3024.86	1008.29	Completed	2025-07-22 16:48:10.667531+00
23	ACC048	CUST032	2025-03-01	11910.34	Check	ATM	RCP175320289024022	COL003	Mixed	9528.27	1786.55	595.52	Pending	2025-07-22 16:48:10.667531+00
24	ACC033	CUST009	2025-02-27	3605.38	Direct Debit	Online	RCP175320289024023	COL009	Late Fee	2884.30	540.81	180.27	Completed	2025-07-22 16:48:10.667531+00
25	ACC029	CUST008	2025-06-03	11614.18	Direct Debit	Branch	RCP175320289024024	COL008	Late Fee	9291.34	1742.13	580.71	Failed	2025-07-22 16:48:10.667531+00
26	ACC011	CUST036	2025-02-01	4587.90	Direct Debit	Online	RCP175320289024025	COL010	Late Fee	3670.32	688.19	229.40	Completed	2025-07-22 16:48:10.667531+00
27	ACC043	CUST047	2025-02-28	19897.22	Online Payment	Branch	RCP175320289024026	COL006	Principal	15917.78	2984.58	994.86	Pending	2025-07-22 16:48:10.667531+00
28	ACC044	CUST010	2025-01-26	17224.30	Bank Transfer	Online	RCP175320289024027	COL003	Mixed	13779.44	2583.65	861.22	Pending	2025-07-22 16:48:10.667531+00
29	ACC023	CUST034	2025-07-03	5064.93	Online Payment	Branch	RCP175320289024028	COL008	Profit	4051.94	759.74	253.25	Failed	2025-07-22 16:48:10.667531+00
30	ACC038	CUST010	2025-02-21	22106.39	Bank Transfer	Mobile App	RCP175320289024029	COL001	Late Fee	17685.11	3315.96	1105.32	Completed	2025-07-22 16:48:10.667531+00
31	ACC049	CUST040	2025-05-03	9572.59	Cash	Branch	RCP175320289024030	COL008	Profit	7658.07	1435.89	478.63	Failed	2025-07-22 16:48:10.667531+00
32	ACC016	CUST012	2025-03-08	3014.05	Check	Online	RCP175320289024031	COL006	Mixed	2411.24	452.11	150.70	Pending	2025-07-22 16:48:10.667531+00
33	ACC001	CUST048	2025-04-29	21965.18	Check	Branch	RCP175320289024032	COL006	Late Fee	17572.14	3294.78	1098.26	Cancelled	2025-07-22 16:48:10.667531+00
34	ACC015	CUST048	2025-02-28	18940.40	Check	ATM	RCP175320289024033	COL009	Late Fee	15152.32	2841.06	947.02	Completed	2025-07-22 16:48:10.667531+00
35	ACC032	CUST012	2025-06-27	13493.75	Online Payment	Online	RCP175320289024034	COL001	Mixed	10795.00	2024.06	674.69	Cancelled	2025-07-22 16:48:10.667531+00
36	ACC031	CUST009	2025-03-20	1087.26	Bank Transfer	ATM	RCP175320289024035	COL007	Principal	869.81	163.09	54.36	Completed	2025-07-22 16:48:10.667531+00
37	ACC049	CUST026	2025-05-05	13978.42	Cash	Branch	RCP175320289024036	COL006	Principal	11182.74	2096.76	698.92	Failed	2025-07-22 16:48:10.667531+00
38	ACC014	CUST003	2025-02-22	8655.29	Online Payment	Call Center	RCP175320289024037	COL010	Mixed	6924.23	1298.29	432.76	Pending	2025-07-22 16:48:10.667531+00
39	ACC017	CUST008	2025-07-05	6739.02	Direct Debit	Mobile App	RCP175320289024038	COL007	Profit	5391.22	1010.85	336.95	Cancelled	2025-07-22 16:48:10.667531+00
40	ACC029	CUST009	2025-06-21	10920.05	Online Payment	Online	RCP175320289024039	COL007	Late Fee	8736.04	1638.01	546.00	Cancelled	2025-07-22 16:48:10.667531+00
41	ACC049	CUST033	2025-04-30	18859.43	Cash	Mobile App	RCP175320289024040	COL004	Profit	15087.54	2828.91	942.97	Failed	2025-07-22 16:48:10.667531+00
42	ACC003	CUST011	2025-03-20	1909.13	Check	Branch	RCP175320289024041	COL003	Profit	1527.30	286.37	95.46	Completed	2025-07-22 16:48:10.667531+00
43	ACC026	CUST047	2025-03-27	5080.51	Bank Transfer	Online	RCP175320289024042	COL007	Principal	4064.41	762.08	254.03	Failed	2025-07-22 16:48:10.667531+00
44	ACC029	CUST018	2025-07-01	17277.13	Bank Transfer	Branch	RCP175320289024043	COL010	Mixed	13821.70	2591.57	863.86	Cancelled	2025-07-22 16:48:10.667531+00
45	ACC026	CUST011	2025-07-18	8347.81	Bank Transfer	Mobile App	RCP175320289024044	COL010	Mixed	6678.25	1252.17	417.39	Completed	2025-07-22 16:48:10.667531+00
46	ACC019	CUST050	2025-04-10	15513.97	Check	Mobile App	RCP175320289024045	COL004	Principal	12411.18	2327.10	775.70	Pending	2025-07-22 16:48:10.667531+00
47	ACC021	CUST009	2025-04-03	10056.98	Direct Debit	Call Center	RCP175320289024046	COL003	Late Fee	8045.58	1508.55	502.85	Pending	2025-07-22 16:48:10.667531+00
48	ACC013	CUST006	2025-02-16	17034.37	Bank Transfer	Call Center	RCP175320289024047	COL005	Late Fee	13627.50	2555.16	851.72	Cancelled	2025-07-22 16:48:10.667531+00
49	ACC021	CUST006	2025-06-12	20826.28	Bank Transfer	ATM	RCP175320289024048	COL009	Principal	16661.02	3123.94	1041.31	Pending	2025-07-22 16:48:10.667531+00
50	ACC048	CUST013	2025-05-03	8272.68	Online Payment	Branch	RCP175320289024049	COL005	Mixed	6618.14	1240.90	413.63	Pending	2025-07-22 16:48:10.667531+00
51	ACC021	CUST032	2025-07-14	2017.10	Cash	Branch	RCP175320289024050	COL001	Profit	1613.68	302.57	100.86	Pending	2025-07-22 16:48:10.667531+00
52	ACC010	CUST018	2025-04-15	5964.60	Bank Transfer	Online	RCP175320289024051	COL001	Late Fee	4771.68	894.69	298.23	Cancelled	2025-07-22 16:48:10.667531+00
53	ACC010	CUST008	2025-07-11	12633.50	Direct Debit	Call Center	RCP175320289024052	COL003	Mixed	10106.80	1895.03	631.68	Pending	2025-07-22 16:48:10.667531+00
54	ACC049	CUST042	2025-02-13	25153.08	Online Payment	Mobile App	RCP175320289024053	COL006	Principal	20122.46	3772.96	1257.65	Completed	2025-07-22 16:48:10.667531+00
55	ACC021	CUST027	2025-05-19	25879.11	Cash	ATM	RCP175320289024054	COL009	Mixed	20703.29	3881.87	1293.96	Completed	2025-07-22 16:48:10.667531+00
56	ACC049	CUST039	2025-05-03	5620.43	Direct Debit	ATM	RCP175320289024055	COL003	Late Fee	4496.34	843.06	281.02	Pending	2025-07-22 16:48:10.667531+00
57	ACC025	CUST002	2025-02-13	13170.98	Online Payment	Mobile App	RCP175320289024056	COL006	Mixed	10536.78	1975.65	658.55	Pending	2025-07-22 16:48:10.667531+00
58	ACC028	CUST016	2025-02-09	20134.71	Online Payment	Call Center	RCP175320289024057	COL009	Profit	16107.77	3020.21	1006.74	Completed	2025-07-22 16:48:10.667531+00
59	ACC003	CUST021	2025-05-26	12634.93	Direct Debit	Branch	RCP175320289024058	COL010	Principal	10107.94	1895.24	631.75	Completed	2025-07-22 16:48:10.667531+00
60	ACC018	CUST005	2025-05-10	18735.08	Online Payment	Branch	RCP175320289024059	COL010	Late Fee	14988.06	2810.26	936.75	Failed	2025-07-22 16:48:10.667531+00
61	ACC028	CUST031	2025-03-07	24592.07	Direct Debit	Call Center	RCP175320289024060	COL001	Profit	19673.66	3688.81	1229.60	Cancelled	2025-07-22 16:48:10.667531+00
62	ACC011	CUST036	2025-05-10	7366.41	Online Payment	Call Center	RCP175320289024061	COL007	Mixed	5893.13	1104.96	368.32	Cancelled	2025-07-22 16:48:10.667531+00
63	ACC037	CUST029	2025-01-27	21047.94	Direct Debit	Mobile App	RCP175320289024062	COL005	Principal	16838.35	3157.19	1052.40	Cancelled	2025-07-22 16:48:10.667531+00
64	ACC033	CUST034	2025-05-01	20694.43	Direct Debit	Call Center	RCP175320289024063	COL005	Late Fee	16555.54	3104.16	1034.72	Pending	2025-07-22 16:48:10.667531+00
65	ACC043	CUST041	2025-05-26	1218.64	Check	Call Center	RCP175320289024064	COL010	Mixed	974.91	182.80	60.93	Failed	2025-07-22 16:48:10.667531+00
66	ACC032	CUST023	2025-02-17	10997.66	Check	Online	RCP175320289024065	COL004	Principal	8798.13	1649.65	549.88	Failed	2025-07-22 16:48:10.667531+00
67	ACC005	CUST008	2025-06-20	13458.97	Direct Debit	ATM	RCP175320289024066	COL003	Profit	10767.18	2018.85	672.95	Pending	2025-07-22 16:48:10.667531+00
68	ACC039	CUST004	2025-06-25	5032.57	Bank Transfer	Mobile App	RCP175320289024067	COL004	Principal	4026.06	754.89	251.63	Pending	2025-07-22 16:48:10.667531+00
69	ACC017	CUST035	2025-05-24	12926.55	Direct Debit	ATM	RCP175320289024068	COL003	Profit	10341.24	1938.98	646.33	Completed	2025-07-22 16:48:10.667531+00
70	ACC026	CUST015	2025-02-10	10725.24	Direct Debit	Branch	RCP175320289024069	COL008	Mixed	8580.19	1608.79	536.26	Completed	2025-07-22 16:48:10.667531+00
71	ACC047	CUST019	2025-05-31	22768.59	Cash	Branch	RCP175320289024070	COL003	Principal	18214.87	3415.29	1138.43	Failed	2025-07-22 16:48:10.667531+00
72	ACC025	CUST029	2025-04-26	6520.15	Cash	Mobile App	RCP175320289024071	COL004	Principal	5216.12	978.02	326.01	Cancelled	2025-07-22 16:48:10.667531+00
73	ACC034	CUST040	2025-05-03	11306.72	Check	Call Center	RCP175320289024072	COL001	Profit	9045.38	1696.01	565.34	Failed	2025-07-22 16:48:10.667531+00
74	ACC041	CUST029	2025-04-21	4756.71	Cash	Call Center	RCP175320289024073	COL007	Profit	3805.37	713.51	237.84	Pending	2025-07-22 16:48:10.667531+00
75	ACC013	CUST022	2025-07-02	20554.17	Online Payment	Mobile App	RCP175320289024074	COL010	Principal	16443.34	3083.13	1027.71	Failed	2025-07-22 16:48:10.667531+00
76	ACC014	CUST005	2025-04-17	25244.04	Check	Call Center	RCP175320289024075	COL002	Profit	20195.23	3786.61	1262.20	Cancelled	2025-07-22 16:48:10.667531+00
77	ACC042	CUST028	2025-03-25	18949.09	Online Payment	Call Center	RCP175320289024076	COL001	Late Fee	15159.27	2842.36	947.45	Failed	2025-07-22 16:48:10.667531+00
78	ACC008	CUST022	2025-06-16	11852.31	Cash	Branch	RCP175320289024077	COL005	Principal	9481.85	1777.85	592.62	Pending	2025-07-22 16:48:10.667531+00
79	ACC014	CUST033	2025-07-20	16882.83	Cash	Online	RCP175320289024078	COL001	Principal	13506.26	2532.42	844.14	Pending	2025-07-22 16:48:10.667531+00
80	ACC042	CUST033	2025-07-19	14906.21	Bank Transfer	ATM	RCP175320289024079	COL003	Late Fee	11924.97	2235.93	745.31	Pending	2025-07-22 16:48:10.667531+00
81	ACC035	CUST034	2025-05-13	21481.25	Direct Debit	Mobile App	RCP175320289024080	COL010	Profit	17185.00	3222.19	1074.06	Pending	2025-07-22 16:48:10.667531+00
82	ACC011	CUST047	2025-06-13	7092.75	Cash	ATM	RCP175320289024081	COL003	Profit	5674.20	1063.91	354.64	Failed	2025-07-22 16:48:10.667531+00
83	ACC003	CUST050	2025-04-17	1704.04	Online Payment	Online	RCP175320289024082	COL003	Profit	1363.23	255.61	85.20	Completed	2025-07-22 16:48:10.667531+00
84	ACC014	CUST050	2025-05-07	7302.84	Online Payment	Branch	RCP175320289024083	COL004	Principal	5842.27	1095.43	365.14	Completed	2025-07-22 16:48:10.667531+00
85	ACC045	CUST031	2025-06-07	7868.91	Direct Debit	Mobile App	RCP175320289024084	COL002	Principal	6295.13	1180.34	393.45	Pending	2025-07-22 16:48:10.667531+00
86	ACC018	CUST012	2025-03-31	18284.48	Direct Debit	Mobile App	RCP175320289024085	COL004	Profit	14627.58	2742.67	914.22	Cancelled	2025-07-22 16:48:10.667531+00
87	ACC029	CUST039	2025-01-26	19347.05	Direct Debit	Call Center	RCP175320289024086	COL003	Late Fee	15477.64	2902.06	967.35	Completed	2025-07-22 16:48:10.667531+00
88	ACC040	CUST007	2025-04-25	7891.31	Bank Transfer	Mobile App	RCP175320289024087	COL006	Mixed	6313.05	1183.70	394.57	Pending	2025-07-22 16:48:10.667531+00
89	ACC046	CUST047	2025-06-08	21597.02	Direct Debit	Online	RCP175320289024088	COL010	Profit	17277.62	3239.55	1079.85	Completed	2025-07-22 16:48:10.667531+00
90	ACC023	CUST012	2025-05-01	4520.52	Direct Debit	Mobile App	RCP175320289024089	COL009	Profit	3616.42	678.08	226.03	Cancelled	2025-07-22 16:48:10.667531+00
91	ACC007	CUST004	2025-02-24	19936.32	Online Payment	Mobile App	RCP175320289024090	COL008	Profit	15949.06	2990.45	996.82	Cancelled	2025-07-22 16:48:10.667531+00
92	ACC037	CUST044	2025-03-18	14516.49	Online Payment	Mobile App	RCP175320289024091	COL003	Profit	11613.19	2177.47	725.82	Completed	2025-07-22 16:48:10.667531+00
93	ACC046	CUST038	2025-06-19	19043.09	Check	Online	RCP175320289024092	COL009	Late Fee	15234.47	2856.46	952.15	Failed	2025-07-22 16:48:10.667531+00
94	ACC031	CUST006	2025-07-14	6189.58	Cash	Online	RCP175320289024093	COL003	Principal	4951.66	928.44	309.48	Pending	2025-07-22 16:48:10.667531+00
95	ACC045	CUST035	2025-06-22	12259.56	Direct Debit	Call Center	RCP175320289024094	COL007	Principal	9807.65	1838.93	612.98	Completed	2025-07-22 16:48:10.667531+00
96	ACC015	CUST003	2025-03-26	1253.69	Check	Call Center	RCP175320289024095	COL001	Principal	1002.95	188.05	62.68	Failed	2025-07-22 16:48:10.667531+00
97	ACC015	CUST034	2025-03-07	23850.64	Check	Online	RCP175320289024096	COL004	Profit	19080.51	3577.60	1192.53	Failed	2025-07-22 16:48:10.667531+00
98	ACC013	CUST049	2025-06-02	13293.42	Online Payment	Online	RCP175320289024097	COL007	Principal	10634.74	1994.01	664.67	Pending	2025-07-22 16:48:10.667531+00
99	ACC027	CUST046	2025-01-26	13713.84	Check	Branch	RCP175320289024098	COL004	Profit	10971.07	2057.08	685.69	Cancelled	2025-07-22 16:48:10.667531+00
100	ACC046	CUST043	2025-06-06	25034.00	Bank Transfer	Call Center	RCP175320289024099	COL009	Principal	20027.20	3755.10	1251.70	Cancelled	2025-07-22 16:48:10.667531+00
101	ACC007	CUST031	2025-07-09	19160.05	Cash	Branch	RCP1753202890240100	COL005	Profit	15328.04	2874.01	958.00	Pending	2025-07-22 16:48:10.667531+00
102	ACC029	CUST008	2025-07-16	4974.18	Bank Transfer	Branch	RCP1753202890240101	COL008	Mixed	3979.34	746.13	248.71	Pending	2025-07-22 16:48:10.667531+00
103	ACC025	CUST030	2025-06-20	12457.37	Direct Debit	Branch	RCP1753202890240102	COL003	Late Fee	9965.90	1868.61	622.87	Pending	2025-07-22 16:48:10.667531+00
104	ACC009	CUST050	2025-02-03	10979.63	Check	Call Center	RCP1753202890240103	COL005	Late Fee	8783.70	1646.94	548.98	Failed	2025-07-22 16:48:10.667531+00
105	ACC008	CUST007	2025-07-15	19242.33	Check	Call Center	RCP1753202890240104	COL004	Principal	15393.86	2886.35	962.12	Failed	2025-07-22 16:48:10.667531+00
106	ACC049	CUST038	2025-04-06	5631.62	Bank Transfer	Mobile App	RCP1753202890240105	COL005	Profit	4505.30	844.74	281.58	Failed	2025-07-22 16:48:10.667531+00
107	ACC037	CUST018	2025-03-23	7523.03	Check	Call Center	RCP1753202890240106	COL007	Late Fee	6018.42	1128.45	376.15	Pending	2025-07-22 16:48:10.667531+00
108	ACC028	CUST032	2025-07-13	10320.49	Online Payment	Call Center	RCP1753202890240107	COL002	Late Fee	8256.39	1548.07	516.02	Failed	2025-07-22 16:48:10.667531+00
109	ACC032	CUST030	2025-06-08	7619.16	Online Payment	Call Center	RCP1753202890240108	COL004	Mixed	6095.33	1142.87	380.96	Cancelled	2025-07-22 16:48:10.667531+00
110	ACC049	CUST043	2025-03-19	7053.17	Direct Debit	Online	RCP1753202890240109	COL009	Profit	5642.54	1057.98	352.66	Pending	2025-07-22 16:48:10.667531+00
111	ACC038	CUST001	2025-02-05	4206.37	Online Payment	Mobile App	RCP1753202890240110	COL005	Profit	3365.10	630.96	210.32	Completed	2025-07-22 16:48:10.667531+00
112	ACC031	CUST023	2025-07-12	8261.73	Check	Call Center	RCP1753202890240111	COL001	Late Fee	6609.38	1239.26	413.09	Pending	2025-07-22 16:48:10.667531+00
113	ACC007	CUST014	2025-05-22	16266.43	Online Payment	Mobile App	RCP1753202890240112	COL004	Mixed	13013.14	2439.96	813.32	Cancelled	2025-07-22 16:48:10.667531+00
114	ACC020	CUST024	2025-03-03	4084.51	Check	Branch	RCP1753202890240113	COL008	Late Fee	3267.61	612.68	204.23	Cancelled	2025-07-22 16:48:10.667531+00
115	ACC019	CUST032	2025-04-20	10624.61	Bank Transfer	Mobile App	RCP1753202890240114	COL004	Principal	8499.69	1593.69	531.23	Cancelled	2025-07-22 16:48:10.667531+00
116	ACC008	CUST006	2025-07-06	6367.37	Online Payment	Online	RCP1753202890240115	COL003	Mixed	5093.90	955.11	318.37	Pending	2025-07-22 16:48:10.667531+00
117	ACC021	CUST016	2025-05-14	4806.42	Online Payment	Online	RCP1753202890240116	COL001	Late Fee	3845.14	720.96	240.32	Failed	2025-07-22 16:48:10.667531+00
118	ACC007	CUST050	2025-06-09	20811.79	Direct Debit	Mobile App	RCP1753202890240117	COL008	Mixed	16649.43	3121.77	1040.59	Completed	2025-07-22 16:48:10.667531+00
119	ACC027	CUST025	2025-05-09	22945.94	Cash	ATM	RCP1753202890240118	COL006	Profit	18356.75	3441.89	1147.30	Completed	2025-07-22 16:48:10.667531+00
120	ACC014	CUST002	2025-03-26	23187.15	Cash	Mobile App	RCP1753202890240119	COL006	Principal	18549.72	3478.07	1159.36	Cancelled	2025-07-22 16:48:10.667531+00
121	ACC046	CUST037	2025-03-31	21843.02	Bank Transfer	ATM	RCP1753202890240120	COL001	Late Fee	17474.42	3276.45	1092.15	Completed	2025-07-22 16:48:10.667531+00
\.


--
-- Data for Name: promise_to_pay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promise_to_pay (ptp_id, case_id, account_id, customer_id, collector_id, promise_amount, promise_date, ptp_status, actual_payment_amount, actual_payment_date, kept_flag, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	Active	\N	\N	f	2025-07-22 16:46:12.364558+00
42	70	ACC010	CUST010	COL008	14614.44	2025-08-01	Renegotiated	14614.44	2025-08-01	t	2025-07-22 16:48:50.203294+00
43	90	ACC030	CUST030	COL003	8718.42	2025-08-01	Kept	8718.42	2025-08-01	t	2025-07-22 16:48:50.203294+00
44	88	ACC028	CUST028	COL008	30046.70	2025-08-11	Broken	30046.70	2025-08-11	t	2025-07-22 16:48:50.203294+00
45	96	ACC006	CUST006	COL004	26807.95	2025-08-10	Kept	26807.95	2025-08-10	t	2025-07-22 16:48:50.203294+00
46	70	ACC010	CUST010	COL008	33952.81	2025-08-01	Broken	33952.81	2025-08-01	t	2025-07-22 16:48:50.203294+00
47	146	ACC026	CUST026	COL009	18531.11	2025-08-15	Renegotiated	18531.11	2025-08-15	t	2025-07-22 16:48:50.203294+00
48	139	ACC019	CUST019	COL001	31117.96	2025-08-06	Renegotiated	31117.96	2025-08-06	t	2025-07-22 16:48:50.203294+00
49	63	ACC003	CUST003	COL008	34241.91	2025-08-08	Active	34241.91	2025-08-08	t	2025-07-22 16:48:50.203294+00
50	106	ACC016	CUST016	COL009	20766.51	2025-07-24	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
51	115	ACC025	CUST025	COL005	5345.41	2025-08-06	Kept	5345.41	2025-08-06	t	2025-07-22 16:48:50.203294+00
52	113	ACC023	CUST023	COL003	18442.30	2025-07-28	Broken	18442.30	2025-07-28	t	2025-07-22 16:48:50.203294+00
53	121	ACC001	CUST001	COL002	8589.31	2025-08-14	Active	8589.31	2025-08-14	t	2025-07-22 16:48:50.203294+00
54	62	ACC002	CUST002	COL004	34330.68	2025-08-15	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
55	134	ACC014	CUST014	COL004	28050.77	2025-07-30	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
56	136	ACC016	CUST016	COL002	23034.31	2025-08-02	Kept	\N	\N	f	2025-07-22 16:48:50.203294+00
57	136	ACC016	CUST016	COL007	22279.25	2025-08-16	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
58	85	ACC025	CUST025	COL003	22803.76	2025-08-15	Renegotiated	22803.76	2025-08-15	t	2025-07-22 16:48:50.203294+00
59	91	ACC001	CUST001	COL005	32048.46	2025-08-05	Active	32048.46	2025-08-05	t	2025-07-22 16:48:50.203294+00
60	106	ACC016	CUST016	COL003	18634.32	2025-08-14	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
61	99	ACC009	CUST009	COL005	11321.31	2025-08-03	Broken	\N	\N	f	2025-07-22 16:48:50.203294+00
62	138	ACC018	CUST018	COL001	31901.32	2025-08-06	Broken	31901.32	2025-08-06	t	2025-07-22 16:48:50.203294+00
63	80	ACC020	CUST020	COL004	7947.05	2025-07-29	Renegotiated	7947.05	2025-07-29	t	2025-07-22 16:48:50.203294+00
64	76	ACC016	CUST016	COL003	17124.69	2025-08-20	Kept	17124.69	2025-08-20	t	2025-07-22 16:48:50.203294+00
65	141	ACC021	CUST021	COL006	10966.29	2025-08-04	Kept	10966.29	2025-08-04	t	2025-07-22 16:48:50.203294+00
66	126	ACC006	CUST006	COL003	8872.46	2025-07-29	Broken	\N	\N	f	2025-07-22 16:48:50.203294+00
67	103	ACC013	CUST013	COL006	29845.42	2025-08-19	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
68	97	ACC007	CUST007	COL008	32348.99	2025-08-07	Renegotiated	\N	\N	f	2025-07-22 16:48:50.203294+00
69	132	ACC012	CUST012	COL002	17848.04	2025-07-26	Kept	\N	\N	f	2025-07-22 16:48:50.203294+00
70	72	ACC012	CUST012	COL006	6256.99	2025-07-26	Broken	6256.99	2025-07-26	t	2025-07-22 16:48:50.203294+00
71	106	ACC016	CUST016	COL002	33451.72	2025-08-06	Active	\N	\N	f	2025-07-22 16:48:50.203294+00
72	143	ACC023	CUST023	COL001	5399.35	2025-08-18	Renegotiated	5399.35	2025-08-18	t	2025-07-22 16:48:50.203294+00
73	127	ACC007	CUST007	COL007	8755.11	2025-07-25	Broken	8755.11	2025-07-25	t	2025-07-22 16:48:50.203294+00
74	86	ACC026	CUST026	COL006	16842.69	2025-08-18	Active	16842.69	2025-08-18	t	2025-07-22 16:48:50.203294+00
75	85	ACC025	CUST025	COL007	14494.72	2025-08-14	Broken	\N	\N	f	2025-07-22 16:48:50.203294+00
76	106	ACC016	CUST016	COL009	19585.34	2025-08-05	Broken	19585.34	2025-08-05	t	2025-07-22 16:48:50.203294+00
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settlements (settlement_id, account_id, customer_id, original_outstanding, settlement_amount, discount_amount, discount_percentage, approval_level, approved_by, approval_date, settlement_status, payment_plan, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:12.928218+00
2	ACC049	CUST041	16570.13	10345.76	6224.37	37.56	Manager	MGR002	2025-06-08	Completed	3 Months	2025-07-22 16:48:11.03232+00
3	ACC003	CUST021	59232.52	37846.68	21385.84	36.10	Manager	MGR003	2025-06-15	Approved	Lump Sum	2025-07-22 16:48:11.03232+00
4	ACC034	CUST009	37658.04	23724.47	13933.57	37.00	Manager	MGR003	2025-05-26	Rejected	Installments	2025-07-22 16:48:11.03232+00
5	ACC026	CUST041	47063.95	31687.39	15376.56	32.67	Director	MGR005	2025-07-21	Rejected	Installments	2025-07-22 16:48:11.03232+00
6	ACC032	CUST032	49941.54	38846.16	11095.39	22.22	Director	MGR001	2025-06-16	Approved	6 Months	2025-07-22 16:48:11.03232+00
7	ACC022	CUST019	37104.86	24772.06	12332.80	33.24	Senior Manager	MGR002	2025-06-06	Rejected	3 Months	2025-07-22 16:48:11.03232+00
8	ACC009	CUST049	29292.86	24733.79	4559.07	15.56	Manager	MGR001	2025-06-28	Proposed	Lump Sum	2025-07-22 16:48:11.03232+00
9	ACC030	CUST047	42107.83	29348.62	12759.21	30.30	Senior Manager	MGR005	2025-07-13	Rejected	6 Months	2025-07-22 16:48:11.03232+00
10	ACC015	CUST033	42956.37	26169.44	16786.93	39.08	Senior Manager	MGR004	2025-05-26	Rejected	3 Months	2025-07-22 16:48:11.03232+00
11	ACC003	CUST048	56939.02	43217.80	13721.22	24.10	Senior Manager	MGR002	2025-06-04	Approved	3 Months	2025-07-22 16:48:11.03232+00
12	ACC013	CUST027	53885.12	32870.88	21014.24	39.00	Director	MGR003	2025-07-04	Completed	3 Months	2025-07-22 16:48:11.03232+00
13	ACC015	CUST009	15009.56	10607.59	4401.98	29.33	Manager	MGR005	2025-06-24	Completed	6 Months	2025-07-22 16:48:11.03232+00
14	ACC016	CUST038	49601.67	30499.86	19101.82	38.51	Director	MGR001	2025-07-21	Rejected	Installments	2025-07-22 16:48:11.03232+00
15	ACC026	CUST020	20464.02	17089.79	3374.23	16.49	Senior Manager	MGR001	2025-06-18	Completed	3 Months	2025-07-22 16:48:11.03232+00
16	ACC037	CUST040	51841.98	33875.86	17966.11	34.66	Senior Manager	MGR001	2025-06-15	Rejected	Lump Sum	2025-07-22 16:48:11.03232+00
17	ACC045	CUST008	52552.38	42447.07	10105.31	19.23	Senior Manager	MGR001	2025-06-17	Completed	6 Months	2025-07-22 16:48:11.03232+00
18	ACC006	CUST038	54833.70	43384.35	11449.35	20.88	Senior Manager	MGR005	2025-07-22	Proposed	3 Months	2025-07-22 16:48:11.03232+00
19	ACC010	CUST002	10750.94	7294.29	3456.65	32.15	Director	MGR001	2025-06-15	Rejected	6 Months	2025-07-22 16:48:11.03232+00
20	ACC011	CUST017	49044.55	37989.60	11054.95	22.54	Manager	MGR003	2025-06-18	Approved	Installments	2025-07-22 16:48:11.03232+00
21	ACC020	CUST002	30723.46	22433.16	8290.30	26.98	Director	MGR003	2025-07-18	Rejected	Installments	2025-07-22 16:48:11.03232+00
\.


--
-- Data for Name: sharia_compliance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sharia_compliance (compliance_id, account_id, compliance_type, late_payment_charges, charity_amount, charity_paid_date, profit_purification, compliance_status, reviewed_by, review_date, notes, created_date) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-22 16:46:14.689615+00
2	ACC002	Documentation	1082.35	1204.15	\N	221.17	Compliant	Dr. Omar Al-Qureshi	2025-04-26	Sharia compliance review for account ACC002. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
3	ACC039	Collection Method	4178.77	410.06	2025-07-14	1030.41	Approved	Dr. Aisha Al-Sharif	2025-07-14	Sharia compliance review for account ACC039. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
4	ACC004	Profit Calculation	3730.13	422.62	\N	619.45	Approved	Dr. Omar Al-Qureshi	2025-06-26	Sharia compliance review for account ACC004. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
5	ACC030	Product Structure	3371.16	1532.45	\N	846.91	Approved	Dr. Omar Al-Qureshi	2025-04-28	Sharia compliance review for account ACC030. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
6	ACC021	Product Structure	3741.41	609.60	\N	532.82	Non-Compliant	Dr. Aisha Al-Sharif	2025-05-22	Sharia compliance review for account ACC021. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
7	ACC040	Profit Calculation	3891.17	201.89	\N	419.67	Under Review	Dr. Aisha Al-Sharif	2025-04-01	Sharia compliance review for account ACC040. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
8	ACC024	Product Structure	1844.26	698.26	\N	919.62	Approved	Dr. Aisha Al-Sharif	2025-04-24	Sharia compliance review for account ACC024. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
9	ACC029	Profit Calculation	3326.80	482.62	2025-06-16	856.96	Non-Compliant	Dr. Abdullah Al-Faqih	2025-06-16	Sharia compliance review for account ACC029. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
10	ACC047	Collection Method	1645.11	1289.37	\N	784.55	Approved	Dr. Omar Al-Qureshi	2025-02-14	Sharia compliance review for account ACC047. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
11	ACC025	Profit Calculation	3639.84	463.94	\N	596.86	Under Review	Dr. Omar Al-Qureshi	2025-06-09	Sharia compliance review for account ACC025. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
12	ACC033	Documentation	4850.82	1664.87	\N	1061.20	Under Review	Dr. Omar Al-Qureshi	2025-04-13	Sharia compliance review for account ACC033. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
13	ACC013	Profit Calculation	3946.44	1574.50	\N	492.03	Non-Compliant	Dr. Omar Al-Qureshi	2025-01-28	Sharia compliance review for account ACC013. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
14	ACC036	Product Structure	5491.42	2132.38	2025-06-17	393.80	Non-Compliant	Dr. Omar Al-Qureshi	2025-06-17	Sharia compliance review for account ACC036. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
15	ACC048	Documentation	3329.81	1765.97	2025-04-05	448.35	Under Review	Dr. Omar Al-Qureshi	2025-04-05	Sharia compliance review for account ACC048. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
16	ACC013	Product Structure	1812.49	619.71	2025-05-23	1017.57	Compliant	Dr. Aisha Al-Sharif	2025-05-23	Sharia compliance review for account ACC013. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
17	ACC038	Documentation	5389.68	1284.56	\N	416.49	Compliant	Dr. Aisha Al-Sharif	2025-03-30	Sharia compliance review for account ACC038. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
18	ACC034	Profit Calculation	3615.08	915.24	2025-04-17	265.93	Compliant	Dr. Omar Al-Qureshi	2025-04-17	Sharia compliance review for account ACC034. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
19	ACC032	Documentation	4229.99	705.88	2025-06-10	526.83	Approved	Dr. Abdullah Al-Faqih	2025-06-10	Sharia compliance review for account ACC032. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
20	ACC037	Profit Calculation	4154.99	458.76	\N	408.54	Under Review	Dr. Abdullah Al-Faqih	2025-05-25	Sharia compliance review for account ACC037. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
21	ACC011	Product Structure	5483.63	1559.46	2025-07-18	577.27	Approved	Dr. Abdullah Al-Faqih	2025-07-18	Sharia compliance review for account ACC011. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
22	ACC005	Profit Calculation	1310.13	683.87	2025-04-19	310.88	Non-Compliant	Dr. Omar Al-Qureshi	2025-04-19	Sharia compliance review for account ACC005. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
23	ACC011	Product Structure	2908.60	535.55	2025-02-16	713.31	Under Review	Dr. Abdullah Al-Faqih	2025-02-16	Sharia compliance review for account ACC011. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
24	ACC009	Collection Method	2877.51	1593.54	2025-06-12	954.68	Non-Compliant	Dr. Omar Al-Qureshi	2025-06-12	Sharia compliance review for account ACC009. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
25	ACC044	Collection Method	3834.42	1803.99	\N	231.87	Compliant	Dr. Abdullah Al-Faqih	2025-07-05	Sharia compliance review for account ACC044. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
26	ACC032	Profit Calculation	4081.54	2154.44	\N	841.70	Non-Compliant	Dr. Aisha Al-Sharif	2025-04-02	Sharia compliance review for account ACC032. All transactions reviewed for Islamic compliance.	2025-07-22 16:48:12.303914+00
\.


--
-- Data for Name: user_dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_dashboards (id, user_id, dashboard_name, is_default, layout_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, first_name, last_name, role, is_active, created_at, updated_at) FROM stdin;
5	admin@osoul.com	$2a$06$HP4hlfv3Q85FPshEjDLJs.Dy8gGqoRsvThTsFyehTsVNmiUl.YR1C	Admin	User	admin	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
6	manager@osoul.com	$2a$06$V0uK2/65wg2pN6dlZY33uu0qCHDg9SUDTTasLkSo5nroJ7odmequS	Manager	User	manager	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
7	collector1@osoul.com	$2a$06$G.YJa6hMqmzt1HQCpIPOA.NhpVThAMEC/RAf.SuOq2u9LsHpPyYZO	Ahmed	Ali	collector	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
8	collector2@osoul.com	$2a$06$bzcZsdl1/4EEC0u3dbshW.ouMEVhIhTWvkZWww3Pm0THSyGDtUoRS	Mohammed	Hassan	collector	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
9	viewer@osoul.com	$2a$06$2/pHIoFr71/9Z3Xcyz3FcemuChXVygCE5/q3pvG6y8FDfkYUw5J3i	Viewer	User	viewer	t	2025-07-22 15:17:05.673557	2025-07-22 15:17:05.673557
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-07-22 06:44:32
20211116045059	2025-07-22 06:44:33
20211116050929	2025-07-22 06:44:33
20211116051442	2025-07-22 06:44:34
20211116212300	2025-07-22 06:44:34
20211116213355	2025-07-22 06:44:35
20211116213934	2025-07-22 06:44:35
20211116214523	2025-07-22 06:44:36
20211122062447	2025-07-22 06:44:36
20211124070109	2025-07-22 06:44:37
20211202204204	2025-07-22 06:44:37
20211202204605	2025-07-22 06:44:37
20211210212804	2025-07-22 06:44:38
20211228014915	2025-07-22 06:44:39
20220107221237	2025-07-22 06:44:39
20220228202821	2025-07-22 06:44:40
20220312004840	2025-07-22 06:44:40
20220603231003	2025-07-22 06:44:41
20220603232444	2025-07-22 06:44:41
20220615214548	2025-07-22 06:44:42
20220712093339	2025-07-22 06:44:42
20220908172859	2025-07-22 06:44:43
20220916233421	2025-07-22 06:44:43
20230119133233	2025-07-22 06:44:44
20230128025114	2025-07-22 06:44:44
20230128025212	2025-07-22 06:44:45
20230227211149	2025-07-22 06:44:45
20230228184745	2025-07-22 06:44:45
20230308225145	2025-07-22 06:44:46
20230328144023	2025-07-22 06:44:46
20231018144023	2025-07-22 06:44:47
20231204144023	2025-07-22 06:44:47
20231204144024	2025-07-22 06:44:48
20231204144025	2025-07-22 06:44:48
20240108234812	2025-07-22 06:44:49
20240109165339	2025-07-22 06:44:49
20240227174441	2025-07-22 06:44:50
20240311171622	2025-07-22 06:44:50
20240321100241	2025-07-22 06:44:51
20240401105812	2025-07-22 06:44:52
20240418121054	2025-07-22 06:44:53
20240523004032	2025-07-22 06:44:54
20240618124746	2025-07-22 06:44:55
20240801235015	2025-07-22 06:44:55
20240805133720	2025-07-22 06:44:56
20240827160934	2025-07-22 06:44:56
20240919163303	2025-07-22 06:44:57
20240919163305	2025-07-22 06:44:57
20241019105805	2025-07-22 06:44:58
20241030150047	2025-07-22 06:44:59
20241108114728	2025-07-22 06:44:59
20241121104152	2025-07-22 06:45:00
20241130184212	2025-07-22 06:45:00
20241220035512	2025-07-22 06:45:01
20241220123912	2025-07-22 06:45:01
20241224161212	2025-07-22 06:45:02
20250107150512	2025-07-22 06:45:02
20250110162412	2025-07-22 06:45:03
20250123174212	2025-07-22 06:45:03
20250128220012	2025-07-22 06:45:03
20250506224012	2025-07-22 06:45:04
20250523164012	2025-07-22 06:45:04
20250714121412	2025-07-22 06:45:05
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-07-22 06:44:31.855931
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-07-22 06:44:31.86655
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-07-22 06:44:31.876125
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-07-22 06:44:31.893378
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-07-22 06:44:31.905081
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-07-22 06:44:31.913052
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-07-22 06:44:31.921775
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-07-22 06:44:31.930281
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-07-22 06:44:31.9381
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-07-22 06:44:31.946316
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-07-22 06:44:31.955796
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-07-22 06:44:31.96444
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-07-22 06:44:31.973284
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-07-22 06:44:31.981472
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-07-22 06:44:31.989833
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-07-22 06:44:32.009402
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-07-22 06:44:32.018074
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-07-22 06:44:32.027839
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-07-22 06:44:32.036425
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-07-22 06:44:32.045726
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-07-22 06:44:32.054028
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-07-22 06:44:32.063818
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-07-22 06:44:32.079226
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-07-22 06:44:32.092708
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-07-22 06:44:32.101454
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-07-22 06:44:32.112343
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: asset_recovery_recovery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asset_recovery_recovery_id_seq', 16, true);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branches_id_seq', 3, true);


--
-- Name: collection_activities_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_activities_activity_id_seq', 323, true);


--
-- Name: collection_cases_case_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_cases_case_id_seq', 150, true);


--
-- Name: collection_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_targets_id_seq', 1, false);


--
-- Name: collection_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_transactions_id_seq', 1, false);


--
-- Name: collector_performance_performance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collector_performance_performance_id_seq', 61, true);


--
-- Name: collectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collectors_id_seq', 1000, false);


--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_contacts_contact_id_seq', 63, true);


--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dashboard_widgets_id_seq', 1, false);


--
-- Name: legal_cases_legal_case_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legal_cases_legal_case_id_seq', 13, true);


--
-- Name: payment_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_schedule_schedule_id_seq', 360, true);


--
-- Name: payment_transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_transactions_transaction_id_seq', 121, true);


--
-- Name: promise_to_pay_ptp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promise_to_pay_ptp_id_seq', 76, true);


--
-- Name: settlements_settlement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settlements_settlement_id_seq', 21, true);


--
-- Name: sharia_compliance_compliance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sharia_compliance_compliance_id_seq', 26, true);


--
-- Name: user_dashboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_dashboards_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: asset_recovery asset_recovery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_recovery
    ADD CONSTRAINT asset_recovery_pkey PRIMARY KEY (recovery_id);


--
-- Name: branches branches_branch_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branch_code_key UNIQUE (branch_code);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: collection_activities collection_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_activities
    ADD CONSTRAINT collection_activities_pkey PRIMARY KEY (activity_id);


--
-- Name: collection_cases collection_cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_cases
    ADD CONSTRAINT collection_cases_pkey PRIMARY KEY (case_id);


--
-- Name: collection_targets collection_targets_branch_id_target_month_target_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_targets
    ADD CONSTRAINT collection_targets_branch_id_target_month_target_year_key UNIQUE (branch_id, target_month, target_year);


--
-- Name: collection_targets collection_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_targets
    ADD CONSTRAINT collection_targets_pkey PRIMARY KEY (id);


--
-- Name: collection_transactions collection_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_transactions
    ADD CONSTRAINT collection_transactions_pkey PRIMARY KEY (id);


--
-- Name: collection_transactions collection_transactions_reference_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_transactions
    ADD CONSTRAINT collection_transactions_reference_number_key UNIQUE (reference_number);


--
-- Name: collector_performance collector_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collector_performance
    ADD CONSTRAINT collector_performance_pkey PRIMARY KEY (performance_id);


--
-- Name: collectors collectors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collectors
    ADD CONSTRAINT collectors_pkey PRIMARY KEY (collector_id);


--
-- Name: customer_contacts customer_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contacts
    ADD CONSTRAINT customer_contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: customers customers_national_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_national_id_key UNIQUE (national_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: dashboard_widgets dashboard_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_pkey PRIMARY KEY (id);


--
-- Name: finance_accounts finance_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_accounts
    ADD CONSTRAINT finance_accounts_pkey PRIMARY KEY (account_id);


--
-- Name: legal_cases legal_cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_cases
    ADD CONSTRAINT legal_cases_pkey PRIMARY KEY (legal_case_id);


--
-- Name: payment_schedule payment_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_schedule
    ADD CONSTRAINT payment_schedule_pkey PRIMARY KEY (schedule_id);


--
-- Name: payment_transactions payment_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: promise_to_pay promise_to_pay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay
    ADD CONSTRAINT promise_to_pay_pkey PRIMARY KEY (ptp_id);


--
-- Name: settlements settlements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_pkey PRIMARY KEY (settlement_id);


--
-- Name: sharia_compliance sharia_compliance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharia_compliance
    ADD CONSTRAINT sharia_compliance_pkey PRIMARY KEY (compliance_id);


--
-- Name: user_dashboards user_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_dashboards
    ADD CONSTRAINT user_dashboards_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_account_status_dpd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_account_status_dpd ON public.finance_accounts USING btree (account_status, dpd);


--
-- Name: idx_activity_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_date ON public.collection_activities USING btree (activity_datetime);


--
-- Name: idx_activity_result; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_result ON public.collection_activities USING btree (activity_result);


--
-- Name: idx_branch_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_branch_code ON public.finance_accounts USING btree (branch_code);


--
-- Name: idx_case_collector; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_case_collector ON public.collection_cases USING btree (assigned_collector_id);


--
-- Name: idx_case_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_case_status ON public.collection_cases USING btree (case_status);


--
-- Name: idx_case_status_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_case_status_priority ON public.collection_cases USING btree (case_status, priority_level);


--
-- Name: idx_collection_targets_branch_period; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collection_targets_branch_period ON public.collection_targets USING btree (branch_id, target_year, target_month);


--
-- Name: idx_collection_transactions_branch_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collection_transactions_branch_date ON public.collection_transactions USING btree (branch_id, transaction_date);


--
-- Name: idx_collection_transactions_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collection_transactions_date ON public.collection_transactions USING btree (transaction_date);


--
-- Name: idx_collector_auth_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collector_auth_user ON public.collectors USING btree (auth_user_id);


--
-- Name: idx_collector_performance; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collector_performance ON public.collector_performance USING btree (collector_id, performance_date);


--
-- Name: idx_customer_national_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_national_id ON public.customers USING btree (national_id);


--
-- Name: idx_customer_risk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_risk ON public.customers USING btree (risk_category);


--
-- Name: idx_dashboard_widgets_dashboard; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboard_widgets_dashboard ON public.dashboard_widgets USING btree (dashboard_id);


--
-- Name: idx_due_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_due_date ON public.payment_schedule USING btree (due_date);


--
-- Name: idx_outstanding_amount; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_outstanding_amount ON public.finance_accounts USING btree (outstanding_amount);


--
-- Name: idx_payment_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_date ON public.payment_transactions USING btree (payment_date);


--
-- Name: idx_payment_method; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_method ON public.payment_transactions USING btree (payment_method);


--
-- Name: idx_payment_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_status ON public.payment_schedule USING btree (payment_status);


--
-- Name: idx_product_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_type ON public.finance_accounts USING btree (product_type);


--
-- Name: idx_promise_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_promise_date ON public.promise_to_pay USING btree (promise_date);


--
-- Name: idx_ptp_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ptp_status ON public.promise_to_pay USING btree (ptp_status);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_collector();


--
-- Name: customers set_updated_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_updated_date BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.update_updated_date();


--
-- Name: finance_accounts trg_update_bucket; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_bucket BEFORE INSERT OR UPDATE OF dpd ON public.finance_accounts FOR EACH ROW EXECUTE FUNCTION public.update_account_bucket();


--
-- Name: branches update_branches_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_branches_updated_at BEFORE UPDATE ON public.branches FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: collection_targets update_collection_targets_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_collection_targets_updated_at BEFORE UPDATE ON public.collection_targets FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: collection_transactions update_collection_transactions_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_collection_transactions_updated_at BEFORE UPDATE ON public.collection_transactions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: dashboard_widgets update_dashboard_widgets_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_dashboard_widgets_updated_at BEFORE UPDATE ON public.dashboard_widgets FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: user_dashboards update_user_dashboards_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_user_dashboards_updated_at BEFORE UPDATE ON public.user_dashboards FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_users_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: asset_recovery asset_recovery_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_recovery
    ADD CONSTRAINT asset_recovery_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: branches branches_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);


--
-- Name: collection_activities collection_activities_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_activities
    ADD CONSTRAINT collection_activities_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: collection_activities collection_activities_case_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_activities
    ADD CONSTRAINT collection_activities_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.collection_cases(case_id) ON DELETE CASCADE;


--
-- Name: collection_activities collection_activities_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_activities
    ADD CONSTRAINT collection_activities_collector_id_fkey FOREIGN KEY (collector_id) REFERENCES public.collectors(collector_id);


--
-- Name: collection_cases collection_cases_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_cases
    ADD CONSTRAINT collection_cases_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: collection_cases collection_cases_assigned_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_cases
    ADD CONSTRAINT collection_cases_assigned_collector_id_fkey FOREIGN KEY (assigned_collector_id) REFERENCES public.collectors(collector_id);


--
-- Name: collection_cases collection_cases_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_cases
    ADD CONSTRAINT collection_cases_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: collection_targets collection_targets_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_targets
    ADD CONSTRAINT collection_targets_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: collection_targets collection_targets_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_targets
    ADD CONSTRAINT collection_targets_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: collection_transactions collection_transactions_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_transactions
    ADD CONSTRAINT collection_transactions_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: collection_transactions collection_transactions_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_transactions
    ADD CONSTRAINT collection_transactions_collector_id_fkey FOREIGN KEY (collector_id) REFERENCES public.users(id);


--
-- Name: collector_performance collector_performance_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collector_performance
    ADD CONSTRAINT collector_performance_collector_id_fkey FOREIGN KEY (collector_id) REFERENCES public.collectors(collector_id) ON DELETE CASCADE;


--
-- Name: collectors collectors_auth_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collectors
    ADD CONSTRAINT collectors_auth_user_id_fkey FOREIGN KEY (auth_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: customer_contacts customer_contacts_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contacts
    ADD CONSTRAINT customer_contacts_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: dashboard_widgets dashboard_widgets_dashboard_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES public.user_dashboards(id) ON DELETE CASCADE;


--
-- Name: finance_accounts finance_accounts_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_accounts
    ADD CONSTRAINT finance_accounts_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: legal_cases legal_cases_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_cases
    ADD CONSTRAINT legal_cases_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: legal_cases legal_cases_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_cases
    ADD CONSTRAINT legal_cases_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: payment_schedule payment_schedule_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_schedule
    ADD CONSTRAINT payment_schedule_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE CASCADE;


--
-- Name: payment_transactions payment_transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: payment_transactions payment_transactions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: promise_to_pay promise_to_pay_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay
    ADD CONSTRAINT promise_to_pay_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: promise_to_pay promise_to_pay_case_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay
    ADD CONSTRAINT promise_to_pay_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.collection_cases(case_id) ON DELETE CASCADE;


--
-- Name: promise_to_pay promise_to_pay_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay
    ADD CONSTRAINT promise_to_pay_collector_id_fkey FOREIGN KEY (collector_id) REFERENCES public.collectors(collector_id);


--
-- Name: promise_to_pay promise_to_pay_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promise_to_pay
    ADD CONSTRAINT promise_to_pay_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: settlements settlements_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: settlements settlements_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE RESTRICT;


--
-- Name: sharia_compliance sharia_compliance_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sharia_compliance
    ADD CONSTRAINT sharia_compliance_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.finance_accounts(account_id) ON DELETE RESTRICT;


--
-- Name: user_dashboards user_dashboards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_dashboards
    ADD CONSTRAINT user_dashboards_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION calculate_dpd(due_date date, payment_date date); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calculate_dpd(due_date date, payment_date date) TO anon;
GRANT ALL ON FUNCTION public.calculate_dpd(due_date date, payment_date date) TO authenticated;
GRANT ALL ON FUNCTION public.calculate_dpd(due_date date, payment_date date) TO service_role;


--
-- Name: FUNCTION get_collector_by_auth_id(auth_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_collector_by_auth_id(auth_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_collector_by_auth_id(auth_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_collector_by_auth_id(auth_id uuid) TO service_role;


--
-- Name: FUNCTION get_collector_dashboard(collector_auth_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_collector_dashboard(collector_auth_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_collector_dashboard(collector_auth_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_collector_dashboard(collector_auth_id uuid) TO service_role;


--
-- Name: FUNCTION handle_new_collector(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_collector() TO anon;
GRANT ALL ON FUNCTION public.handle_new_collector() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_collector() TO service_role;


--
-- Name: FUNCTION update_account_bucket(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_account_bucket() TO anon;
GRANT ALL ON FUNCTION public.update_account_bucket() TO authenticated;
GRANT ALL ON FUNCTION public.update_account_bucket() TO service_role;


--
-- Name: FUNCTION update_ptp_status(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_ptp_status() TO anon;
GRANT ALL ON FUNCTION public.update_ptp_status() TO authenticated;
GRANT ALL ON FUNCTION public.update_ptp_status() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION update_updated_date(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_date() TO anon;
GRANT ALL ON FUNCTION public.update_updated_date() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_date() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE asset_recovery; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.asset_recovery TO anon;
GRANT ALL ON TABLE public.asset_recovery TO authenticated;
GRANT ALL ON TABLE public.asset_recovery TO service_role;


--
-- Name: SEQUENCE asset_recovery_recovery_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.asset_recovery_recovery_id_seq TO anon;
GRANT ALL ON SEQUENCE public.asset_recovery_recovery_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.asset_recovery_recovery_id_seq TO service_role;


--
-- Name: TABLE branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.branches TO anon;
GRANT ALL ON TABLE public.branches TO authenticated;
GRANT ALL ON TABLE public.branches TO service_role;


--
-- Name: SEQUENCE branches_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.branches_id_seq TO anon;
GRANT ALL ON SEQUENCE public.branches_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.branches_id_seq TO service_role;


--
-- Name: TABLE collection_activities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collection_activities TO anon;
GRANT ALL ON TABLE public.collection_activities TO authenticated;
GRANT ALL ON TABLE public.collection_activities TO service_role;


--
-- Name: SEQUENCE collection_activities_activity_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collection_activities_activity_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collection_activities_activity_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collection_activities_activity_id_seq TO service_role;


--
-- Name: TABLE collection_cases; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collection_cases TO anon;
GRANT ALL ON TABLE public.collection_cases TO authenticated;
GRANT ALL ON TABLE public.collection_cases TO service_role;


--
-- Name: SEQUENCE collection_cases_case_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collection_cases_case_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collection_cases_case_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collection_cases_case_id_seq TO service_role;


--
-- Name: TABLE collection_targets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collection_targets TO anon;
GRANT ALL ON TABLE public.collection_targets TO authenticated;
GRANT ALL ON TABLE public.collection_targets TO service_role;


--
-- Name: SEQUENCE collection_targets_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collection_targets_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collection_targets_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collection_targets_id_seq TO service_role;


--
-- Name: TABLE collection_transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collection_transactions TO anon;
GRANT ALL ON TABLE public.collection_transactions TO authenticated;
GRANT ALL ON TABLE public.collection_transactions TO service_role;


--
-- Name: SEQUENCE collection_transactions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collection_transactions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collection_transactions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collection_transactions_id_seq TO service_role;


--
-- Name: TABLE collector_performance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collector_performance TO anon;
GRANT ALL ON TABLE public.collector_performance TO authenticated;
GRANT ALL ON TABLE public.collector_performance TO service_role;


--
-- Name: SEQUENCE collector_performance_performance_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collector_performance_performance_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collector_performance_performance_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collector_performance_performance_id_seq TO service_role;


--
-- Name: TABLE collectors; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collectors TO anon;
GRANT ALL ON TABLE public.collectors TO authenticated;
GRANT ALL ON TABLE public.collectors TO service_role;


--
-- Name: SEQUENCE collectors_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.collectors_id_seq TO anon;
GRANT ALL ON SEQUENCE public.collectors_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.collectors_id_seq TO service_role;


--
-- Name: TABLE customer_contacts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_contacts TO anon;
GRANT ALL ON TABLE public.customer_contacts TO authenticated;
GRANT ALL ON TABLE public.customer_contacts TO service_role;


--
-- Name: SEQUENCE customer_contacts_contact_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.customer_contacts_contact_id_seq TO anon;
GRANT ALL ON SEQUENCE public.customer_contacts_contact_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.customer_contacts_contact_id_seq TO service_role;


--
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customers TO anon;
GRANT ALL ON TABLE public.customers TO authenticated;
GRANT ALL ON TABLE public.customers TO service_role;


--
-- Name: TABLE dashboard_widgets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.dashboard_widgets TO anon;
GRANT ALL ON TABLE public.dashboard_widgets TO authenticated;
GRANT ALL ON TABLE public.dashboard_widgets TO service_role;


--
-- Name: SEQUENCE dashboard_widgets_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.dashboard_widgets_id_seq TO anon;
GRANT ALL ON SEQUENCE public.dashboard_widgets_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.dashboard_widgets_id_seq TO service_role;


--
-- Name: TABLE finance_accounts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.finance_accounts TO anon;
GRANT ALL ON TABLE public.finance_accounts TO authenticated;
GRANT ALL ON TABLE public.finance_accounts TO service_role;


--
-- Name: TABLE legal_cases; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.legal_cases TO anon;
GRANT ALL ON TABLE public.legal_cases TO authenticated;
GRANT ALL ON TABLE public.legal_cases TO service_role;


--
-- Name: SEQUENCE legal_cases_legal_case_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.legal_cases_legal_case_id_seq TO anon;
GRANT ALL ON SEQUENCE public.legal_cases_legal_case_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.legal_cases_legal_case_id_seq TO service_role;


--
-- Name: TABLE monthly_collection_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.monthly_collection_summary TO anon;
GRANT ALL ON TABLE public.monthly_collection_summary TO authenticated;
GRANT ALL ON TABLE public.monthly_collection_summary TO service_role;


--
-- Name: TABLE payment_schedule; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payment_schedule TO anon;
GRANT ALL ON TABLE public.payment_schedule TO authenticated;
GRANT ALL ON TABLE public.payment_schedule TO service_role;


--
-- Name: SEQUENCE payment_schedule_schedule_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.payment_schedule_schedule_id_seq TO anon;
GRANT ALL ON SEQUENCE public.payment_schedule_schedule_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.payment_schedule_schedule_id_seq TO service_role;


--
-- Name: TABLE payment_transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payment_transactions TO anon;
GRANT ALL ON TABLE public.payment_transactions TO authenticated;
GRANT ALL ON TABLE public.payment_transactions TO service_role;


--
-- Name: SEQUENCE payment_transactions_transaction_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.payment_transactions_transaction_id_seq TO anon;
GRANT ALL ON SEQUENCE public.payment_transactions_transaction_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.payment_transactions_transaction_id_seq TO service_role;


--
-- Name: TABLE promise_to_pay; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.promise_to_pay TO anon;
GRANT ALL ON TABLE public.promise_to_pay TO authenticated;
GRANT ALL ON TABLE public.promise_to_pay TO service_role;


--
-- Name: SEQUENCE promise_to_pay_ptp_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.promise_to_pay_ptp_id_seq TO anon;
GRANT ALL ON SEQUENCE public.promise_to_pay_ptp_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.promise_to_pay_ptp_id_seq TO service_role;


--
-- Name: TABLE quarterly_collection_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.quarterly_collection_summary TO anon;
GRANT ALL ON TABLE public.quarterly_collection_summary TO authenticated;
GRANT ALL ON TABLE public.quarterly_collection_summary TO service_role;


--
-- Name: TABLE settlements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.settlements TO anon;
GRANT ALL ON TABLE public.settlements TO authenticated;
GRANT ALL ON TABLE public.settlements TO service_role;


--
-- Name: SEQUENCE settlements_settlement_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.settlements_settlement_id_seq TO anon;
GRANT ALL ON SEQUENCE public.settlements_settlement_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.settlements_settlement_id_seq TO service_role;


--
-- Name: TABLE sharia_compliance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sharia_compliance TO anon;
GRANT ALL ON TABLE public.sharia_compliance TO authenticated;
GRANT ALL ON TABLE public.sharia_compliance TO service_role;


--
-- Name: SEQUENCE sharia_compliance_compliance_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sharia_compliance_compliance_id_seq TO anon;
GRANT ALL ON SEQUENCE public.sharia_compliance_compliance_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.sharia_compliance_compliance_id_seq TO service_role;


--
-- Name: TABLE user_dashboards; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_dashboards TO anon;
GRANT ALL ON TABLE public.user_dashboards TO authenticated;
GRANT ALL ON TABLE public.user_dashboards TO service_role;


--
-- Name: SEQUENCE user_dashboards_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_dashboards_id_seq TO anon;
GRANT ALL ON SEQUENCE public.user_dashboards_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.user_dashboards_id_seq TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO anon;
GRANT ALL ON SEQUENCE public.users_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.users_id_seq TO service_role;


--
-- Name: TABLE v_collector_performance_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.v_collector_performance_summary TO anon;
GRANT ALL ON TABLE public.v_collector_performance_summary TO authenticated;
GRANT ALL ON TABLE public.v_collector_performance_summary TO service_role;


--
-- Name: TABLE v_daily_collection_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.v_daily_collection_summary TO anon;
GRANT ALL ON TABLE public.v_daily_collection_summary TO authenticated;
GRANT ALL ON TABLE public.v_daily_collection_summary TO service_role;


--
-- Name: TABLE v_npf_by_product; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.v_npf_by_product TO anon;
GRANT ALL ON TABLE public.v_npf_by_product TO authenticated;
GRANT ALL ON TABLE public.v_npf_by_product TO service_role;


--
-- Name: TABLE v_portfolio_aging; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.v_portfolio_aging TO anon;
GRANT ALL ON TABLE public.v_portfolio_aging TO authenticated;
GRANT ALL ON TABLE public.v_portfolio_aging TO service_role;


--
-- Name: TABLE v_ptp_success_rate; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.v_ptp_success_rate TO anon;
GRANT ALL ON TABLE public.v_ptp_success_rate TO authenticated;
GRANT ALL ON TABLE public.v_ptp_success_rate TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

