--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: pg_aggregate; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_aggregate (
    aggfnoid regproc NOT NULL,
    aggkind "char" NOT NULL,
    aggnumdirectargs smallint NOT NULL,
    aggtransfn regproc NOT NULL,
    aggfinalfn regproc NOT NULL,
    aggcombinefn regproc NOT NULL,
    aggserialfn regproc NOT NULL,
    aggdeserialfn regproc NOT NULL,
    aggmtransfn regproc NOT NULL,
    aggminvtransfn regproc NOT NULL,
    aggmfinalfn regproc NOT NULL,
    aggfinalextra boolean NOT NULL,
    aggmfinalextra boolean NOT NULL,
    aggfinalmodify "char" NOT NULL,
    aggmfinalmodify "char" NOT NULL,
    aggsortop oid NOT NULL,
    aggtranstype oid NOT NULL,
    aggtransspace integer NOT NULL,
    aggmtranstype oid NOT NULL,
    aggmtransspace integer NOT NULL,
    agginitval text COLLATE pg_catalog."C",
    aggminitval text COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_aggregate REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_aggregate OWNER TO postgres;

--
-- Name: pg_am; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_am (
    oid oid NOT NULL,
    amname name NOT NULL,
    amhandler regproc NOT NULL,
    amtype "char" NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_am REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_am OWNER TO postgres;

--
-- Name: pg_amop; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_amop (
    oid oid NOT NULL,
    amopfamily oid NOT NULL,
    amoplefttype oid NOT NULL,
    amoprighttype oid NOT NULL,
    amopstrategy smallint NOT NULL,
    amoppurpose "char" NOT NULL,
    amopopr oid NOT NULL,
    amopmethod oid NOT NULL,
    amopsortfamily oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_amop REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_amop OWNER TO postgres;

--
-- Name: pg_amproc; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_amproc (
    oid oid NOT NULL,
    amprocfamily oid NOT NULL,
    amproclefttype oid NOT NULL,
    amprocrighttype oid NOT NULL,
    amprocnum smallint NOT NULL,
    amproc regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_amproc REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_amproc OWNER TO postgres;

--
-- Name: pg_attrdef; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_attrdef (
    oid oid NOT NULL,
    adrelid oid NOT NULL,
    adnum smallint NOT NULL,
    adbin pg_node_tree NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_attrdef REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_attrdef OWNER TO postgres;

--
-- Name: pg_attribute; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_attribute (
    attrelid oid NOT NULL,
    attname name NOT NULL,
    atttypid oid NOT NULL,
    attlen smallint NOT NULL,
    attnum smallint NOT NULL,
    attcacheoff integer NOT NULL,
    atttypmod integer NOT NULL,
    attndims smallint NOT NULL,
    attbyval boolean NOT NULL,
    attalign "char" NOT NULL,
    attstorage "char" NOT NULL,
    attcompression "char" NOT NULL,
    attnotnull boolean NOT NULL,
    atthasdef boolean NOT NULL,
    atthasmissing boolean NOT NULL,
    attidentity "char" NOT NULL,
    attgenerated "char" NOT NULL,
    attisdropped boolean NOT NULL,
    attislocal boolean NOT NULL,
    attinhcount smallint NOT NULL,
    attstattarget smallint NOT NULL,
    attcollation oid NOT NULL,
    attacl aclitem[],
    attoptions text[] COLLATE pg_catalog."C",
    attfdwoptions text[] COLLATE pg_catalog."C",
    attmissingval anyarray
);

ALTER TABLE ONLY pg_catalog.pg_attribute REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_attribute OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_auth_members; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_auth_members (
    oid oid NOT NULL,
    roleid oid NOT NULL,
    member oid NOT NULL,
    grantor oid NOT NULL,
    admin_option boolean NOT NULL,
    inherit_option boolean NOT NULL,
    set_option boolean NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_auth_members REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_auth_members OWNER TO postgres;

--
-- Name: pg_authid; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_authid (
    oid oid NOT NULL,
    rolname name NOT NULL,
    rolsuper boolean NOT NULL,
    rolinherit boolean NOT NULL,
    rolcreaterole boolean NOT NULL,
    rolcreatedb boolean NOT NULL,
    rolcanlogin boolean NOT NULL,
    rolreplication boolean NOT NULL,
    rolbypassrls boolean NOT NULL,
    rolconnlimit integer NOT NULL,
    rolpassword text COLLATE pg_catalog."C",
    rolvaliduntil timestamp with time zone
);

ALTER TABLE ONLY pg_catalog.pg_authid REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_authid OWNER TO postgres;

--
-- Name: pg_available_extension_versions; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_available_extension_versions AS
 SELECT e.name,
    e.version,
    (x.extname IS NOT NULL) AS installed,
    e.superuser,
    e.trusted,
    e.relocatable,
    e.schema,
    e.requires,
    e.comment
   FROM (pg_available_extension_versions() e(name, version, superuser, trusted, relocatable, schema, requires, comment)
     LEFT JOIN pg_extension x ON (((e.name = x.extname) AND (e.version = x.extversion))));


ALTER VIEW pg_catalog.pg_available_extension_versions OWNER TO postgres;

--
-- Name: pg_available_extensions; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_available_extensions AS
 SELECT e.name,
    e.default_version,
    x.extversion AS installed_version,
    e.comment
   FROM (pg_available_extensions() e(name, default_version, comment)
     LEFT JOIN pg_extension x ON ((e.name = x.extname)));


ALTER VIEW pg_catalog.pg_available_extensions OWNER TO postgres;

--
-- Name: pg_backend_memory_contexts; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_backend_memory_contexts AS
 SELECT name,
    ident,
    parent,
    level,
    total_bytes,
    total_nblocks,
    free_bytes,
    free_chunks,
    used_bytes
   FROM pg_get_backend_memory_contexts() pg_get_backend_memory_contexts(name, ident, parent, level, total_bytes, total_nblocks, free_bytes, free_chunks, used_bytes);


ALTER VIEW pg_catalog.pg_backend_memory_contexts OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_cast; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_cast (
    oid oid NOT NULL,
    castsource oid NOT NULL,
    casttarget oid NOT NULL,
    castfunc oid NOT NULL,
    castcontext "char" NOT NULL,
    castmethod "char" NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_cast REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_cast OWNER TO postgres;

--
-- Name: pg_class; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_class (
    oid oid NOT NULL,
    relname name NOT NULL,
    relnamespace oid NOT NULL,
    reltype oid NOT NULL,
    reloftype oid NOT NULL,
    relowner oid NOT NULL,
    relam oid NOT NULL,
    relfilenode oid NOT NULL,
    reltablespace oid NOT NULL,
    relpages integer NOT NULL,
    reltuples real NOT NULL,
    relallvisible integer NOT NULL,
    reltoastrelid oid NOT NULL,
    relhasindex boolean NOT NULL,
    relisshared boolean NOT NULL,
    relpersistence "char" NOT NULL,
    relkind "char" NOT NULL,
    relnatts smallint NOT NULL,
    relchecks smallint NOT NULL,
    relhasrules boolean NOT NULL,
    relhastriggers boolean NOT NULL,
    relhassubclass boolean NOT NULL,
    relrowsecurity boolean NOT NULL,
    relforcerowsecurity boolean NOT NULL,
    relispopulated boolean NOT NULL,
    relreplident "char" NOT NULL,
    relispartition boolean NOT NULL,
    relrewrite oid NOT NULL,
    relfrozenxid xid NOT NULL,
    relminmxid xid NOT NULL,
    relacl aclitem[],
    reloptions text[] COLLATE pg_catalog."C",
    relpartbound pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_class REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_class OWNER TO postgres;

--
-- Name: pg_collation; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_collation (
    oid oid NOT NULL,
    collname name NOT NULL,
    collnamespace oid NOT NULL,
    collowner oid NOT NULL,
    collprovider "char" NOT NULL,
    collisdeterministic boolean NOT NULL,
    collencoding integer NOT NULL,
    collcollate text COLLATE pg_catalog."C",
    collctype text COLLATE pg_catalog."C",
    colliculocale text COLLATE pg_catalog."C",
    collicurules text COLLATE pg_catalog."C",
    collversion text COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_collation REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_collation OWNER TO postgres;

--
-- Name: pg_config; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_config AS
 SELECT name,
    setting
   FROM pg_config() pg_config(name, setting);


ALTER VIEW pg_catalog.pg_config OWNER TO postgres;

--
-- Name: pg_constraint; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_constraint (
    oid oid NOT NULL,
    conname name NOT NULL,
    connamespace oid NOT NULL,
    contype "char" NOT NULL,
    condeferrable boolean NOT NULL,
    condeferred boolean NOT NULL,
    convalidated boolean NOT NULL,
    conrelid oid NOT NULL,
    contypid oid NOT NULL,
    conindid oid NOT NULL,
    conparentid oid NOT NULL,
    confrelid oid NOT NULL,
    confupdtype "char" NOT NULL,
    confdeltype "char" NOT NULL,
    confmatchtype "char" NOT NULL,
    conislocal boolean NOT NULL,
    coninhcount smallint NOT NULL,
    connoinherit boolean NOT NULL,
    conkey smallint[],
    confkey smallint[],
    conpfeqop oid[],
    conppeqop oid[],
    conffeqop oid[],
    confdelsetcols smallint[],
    conexclop oid[],
    conbin pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_constraint REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_constraint OWNER TO postgres;

--
-- Name: pg_conversion; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_conversion (
    oid oid NOT NULL,
    conname name NOT NULL,
    connamespace oid NOT NULL,
    conowner oid NOT NULL,
    conforencoding integer NOT NULL,
    contoencoding integer NOT NULL,
    conproc regproc NOT NULL,
    condefault boolean NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_conversion REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_conversion OWNER TO postgres;

--
-- Name: pg_cursors; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_cursors AS
 SELECT name,
    statement,
    is_holdable,
    is_binary,
    is_scrollable,
    creation_time
   FROM pg_cursor() c(name, statement, is_holdable, is_binary, is_scrollable, creation_time);


ALTER VIEW pg_catalog.pg_cursors OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_database; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_database (
    oid oid NOT NULL,
    datname name NOT NULL,
    datdba oid NOT NULL,
    encoding integer NOT NULL,
    datlocprovider "char" NOT NULL,
    datistemplate boolean NOT NULL,
    datallowconn boolean NOT NULL,
    datconnlimit integer NOT NULL,
    datfrozenxid xid NOT NULL,
    datminmxid xid NOT NULL,
    dattablespace oid NOT NULL,
    datcollate text NOT NULL COLLATE pg_catalog."C",
    datctype text NOT NULL COLLATE pg_catalog."C",
    daticulocale text COLLATE pg_catalog."C",
    daticurules text COLLATE pg_catalog."C",
    datcollversion text COLLATE pg_catalog."C",
    datacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_database REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_database OWNER TO postgres;

--
-- Name: pg_db_role_setting; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_db_role_setting (
    setdatabase oid NOT NULL,
    setrole oid NOT NULL,
    setconfig text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_db_role_setting REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_db_role_setting OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_default_acl; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_default_acl (
    oid oid NOT NULL,
    defaclrole oid NOT NULL,
    defaclnamespace oid NOT NULL,
    defaclobjtype "char" NOT NULL,
    defaclacl aclitem[] NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_default_acl REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_default_acl OWNER TO postgres;

--
-- Name: pg_depend; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_depend (
    classid oid NOT NULL,
    objid oid NOT NULL,
    objsubid integer NOT NULL,
    refclassid oid NOT NULL,
    refobjid oid NOT NULL,
    refobjsubid integer NOT NULL,
    deptype "char" NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_depend REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_depend OWNER TO postgres;

--
-- Name: pg_description; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_description (
    objoid oid NOT NULL,
    classoid oid NOT NULL,
    objsubid integer NOT NULL,
    description text NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_description REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_description OWNER TO postgres;

--
-- Name: pg_enum; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_enum (
    oid oid NOT NULL,
    enumtypid oid NOT NULL,
    enumsortorder real NOT NULL,
    enumlabel name NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_enum REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_enum OWNER TO postgres;

--
-- Name: pg_event_trigger; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_event_trigger (
    oid oid NOT NULL,
    evtname name NOT NULL,
    evtevent name NOT NULL,
    evtowner oid NOT NULL,
    evtfoid oid NOT NULL,
    evtenabled "char" NOT NULL,
    evttags text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_event_trigger REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_event_trigger OWNER TO postgres;

--
-- Name: pg_extension; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_extension (
    oid oid NOT NULL,
    extname name NOT NULL,
    extowner oid NOT NULL,
    extnamespace oid NOT NULL,
    extrelocatable boolean NOT NULL,
    extversion text NOT NULL COLLATE pg_catalog."C",
    extconfig oid[],
    extcondition text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_extension REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_extension OWNER TO postgres;

--
-- Name: pg_file_settings; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_file_settings AS
 SELECT sourcefile,
    sourceline,
    seqno,
    name,
    setting,
    applied,
    error
   FROM pg_show_all_file_settings() a(sourcefile, sourceline, seqno, name, setting, applied, error);


ALTER VIEW pg_catalog.pg_file_settings OWNER TO postgres;

--
-- Name: pg_foreign_data_wrapper; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_foreign_data_wrapper (
    oid oid NOT NULL,
    fdwname name NOT NULL,
    fdwowner oid NOT NULL,
    fdwhandler oid NOT NULL,
    fdwvalidator oid NOT NULL,
    fdwacl aclitem[],
    fdwoptions text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_foreign_data_wrapper REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_foreign_data_wrapper OWNER TO postgres;

--
-- Name: pg_foreign_server; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_foreign_server (
    oid oid NOT NULL,
    srvname name NOT NULL,
    srvowner oid NOT NULL,
    srvfdw oid NOT NULL,
    srvtype text COLLATE pg_catalog."C",
    srvversion text COLLATE pg_catalog."C",
    srvacl aclitem[],
    srvoptions text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_foreign_server REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_foreign_server OWNER TO postgres;

--
-- Name: pg_foreign_table; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_foreign_table (
    ftrelid oid NOT NULL,
    ftserver oid NOT NULL,
    ftoptions text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_foreign_table REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_foreign_table OWNER TO postgres;

--
-- Name: pg_group; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_group AS
 SELECT rolname AS groname,
    oid AS grosysid,
    ARRAY( SELECT pg_auth_members.member
           FROM pg_auth_members
          WHERE (pg_auth_members.roleid = pg_authid.oid)) AS grolist
   FROM pg_authid
  WHERE (NOT rolcanlogin);


ALTER VIEW pg_catalog.pg_group OWNER TO postgres;

--
-- Name: pg_hba_file_rules; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_hba_file_rules AS
 SELECT rule_number,
    file_name,
    line_number,
    type,
    database,
    user_name,
    address,
    netmask,
    auth_method,
    options,
    error
   FROM pg_hba_file_rules() a(rule_number, file_name, line_number, type, database, user_name, address, netmask, auth_method, options, error);


ALTER VIEW pg_catalog.pg_hba_file_rules OWNER TO postgres;

--
-- Name: pg_ident_file_mappings; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_ident_file_mappings AS
 SELECT map_number,
    file_name,
    line_number,
    map_name,
    sys_name,
    pg_username,
    error
   FROM pg_ident_file_mappings() a(map_number, file_name, line_number, map_name, sys_name, pg_username, error);


ALTER VIEW pg_catalog.pg_ident_file_mappings OWNER TO postgres;

--
-- Name: pg_index; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_index (
    indexrelid oid NOT NULL,
    indrelid oid NOT NULL,
    indnatts smallint NOT NULL,
    indnkeyatts smallint NOT NULL,
    indisunique boolean NOT NULL,
    indnullsnotdistinct boolean NOT NULL,
    indisprimary boolean NOT NULL,
    indisexclusion boolean NOT NULL,
    indimmediate boolean NOT NULL,
    indisclustered boolean NOT NULL,
    indisvalid boolean NOT NULL,
    indcheckxmin boolean NOT NULL,
    indisready boolean NOT NULL,
    indislive boolean NOT NULL,
    indisreplident boolean NOT NULL,
    indkey int2vector NOT NULL,
    indcollation oidvector NOT NULL,
    indclass oidvector NOT NULL,
    indoption int2vector NOT NULL,
    indexprs pg_node_tree COLLATE pg_catalog."C",
    indpred pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_index REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_index OWNER TO postgres;

--
-- Name: pg_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_indexes AS
 SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    i.relname AS indexname,
    t.spcname AS tablespace,
    pg_get_indexdef(i.oid) AS indexdef
   FROM ((((pg_index x
     JOIN pg_class c ON ((c.oid = x.indrelid)))
     JOIN pg_class i ON ((i.oid = x.indexrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
     LEFT JOIN pg_tablespace t ON ((t.oid = i.reltablespace)))
  WHERE ((c.relkind = ANY (ARRAY['r'::"char", 'm'::"char", 'p'::"char"])) AND (i.relkind = ANY (ARRAY['i'::"char", 'I'::"char"])));


ALTER VIEW pg_catalog.pg_indexes OWNER TO postgres;

--
-- Name: pg_inherits; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_inherits (
    inhrelid oid NOT NULL,
    inhparent oid NOT NULL,
    inhseqno integer NOT NULL,
    inhdetachpending boolean NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_inherits REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_inherits OWNER TO postgres;

--
-- Name: pg_init_privs; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_init_privs (
    objoid oid NOT NULL,
    classoid oid NOT NULL,
    objsubid integer NOT NULL,
    privtype "char" NOT NULL,
    initprivs aclitem[] NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_init_privs REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_init_privs OWNER TO postgres;

--
-- Name: pg_language; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_language (
    oid oid NOT NULL,
    lanname name NOT NULL,
    lanowner oid NOT NULL,
    lanispl boolean NOT NULL,
    lanpltrusted boolean NOT NULL,
    lanplcallfoid oid NOT NULL,
    laninline oid NOT NULL,
    lanvalidator oid NOT NULL,
    lanacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_language REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_language OWNER TO postgres;

--
-- Name: pg_largeobject; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_largeobject (
    loid oid NOT NULL,
    pageno integer NOT NULL,
    data bytea NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_largeobject REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_largeobject OWNER TO postgres;

--
-- Name: pg_largeobject_metadata; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_largeobject_metadata (
    oid oid NOT NULL,
    lomowner oid NOT NULL,
    lomacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_largeobject_metadata REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_largeobject_metadata OWNER TO postgres;

--
-- Name: pg_locks; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_locks AS
 SELECT locktype,
    database,
    relation,
    page,
    tuple,
    virtualxid,
    transactionid,
    classid,
    objid,
    objsubid,
    virtualtransaction,
    pid,
    mode,
    granted,
    fastpath,
    waitstart
   FROM pg_lock_status() l(locktype, database, relation, page, tuple, virtualxid, transactionid, classid, objid, objsubid, virtualtransaction, pid, mode, granted, fastpath, waitstart);


ALTER VIEW pg_catalog.pg_locks OWNER TO postgres;

--
-- Name: pg_matviews; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_matviews AS
 SELECT n.nspname AS schemaname,
    c.relname AS matviewname,
    pg_get_userbyid(c.relowner) AS matviewowner,
    t.spcname AS tablespace,
    c.relhasindex AS hasindexes,
    c.relispopulated AS ispopulated,
    pg_get_viewdef(c.oid) AS definition
   FROM ((pg_class c
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
     LEFT JOIN pg_tablespace t ON ((t.oid = c.reltablespace)))
  WHERE (c.relkind = 'm'::"char");


ALTER VIEW pg_catalog.pg_matviews OWNER TO postgres;

--
-- Name: pg_namespace; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_namespace (
    oid oid NOT NULL,
    nspname name NOT NULL,
    nspowner oid NOT NULL,
    nspacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_namespace REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_namespace OWNER TO postgres;

--
-- Name: pg_opclass; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_opclass (
    oid oid NOT NULL,
    opcmethod oid NOT NULL,
    opcname name NOT NULL,
    opcnamespace oid NOT NULL,
    opcowner oid NOT NULL,
    opcfamily oid NOT NULL,
    opcintype oid NOT NULL,
    opcdefault boolean NOT NULL,
    opckeytype oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_opclass REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_opclass OWNER TO postgres;

--
-- Name: pg_operator; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_operator (
    oid oid NOT NULL,
    oprname name NOT NULL,
    oprnamespace oid NOT NULL,
    oprowner oid NOT NULL,
    oprkind "char" NOT NULL,
    oprcanmerge boolean NOT NULL,
    oprcanhash boolean NOT NULL,
    oprleft oid NOT NULL,
    oprright oid NOT NULL,
    oprresult oid NOT NULL,
    oprcom oid NOT NULL,
    oprnegate oid NOT NULL,
    oprcode regproc NOT NULL,
    oprrest regproc NOT NULL,
    oprjoin regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_operator REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_operator OWNER TO postgres;

--
-- Name: pg_opfamily; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_opfamily (
    oid oid NOT NULL,
    opfmethod oid NOT NULL,
    opfname name NOT NULL,
    opfnamespace oid NOT NULL,
    opfowner oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_opfamily REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_opfamily OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_parameter_acl; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_parameter_acl (
    oid oid NOT NULL,
    parname text NOT NULL COLLATE pg_catalog."C",
    paracl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_parameter_acl REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_parameter_acl OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_partitioned_table; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_partitioned_table (
    partrelid oid NOT NULL,
    partstrat "char" NOT NULL,
    partnatts smallint NOT NULL,
    partdefid oid NOT NULL,
    partattrs int2vector NOT NULL,
    partclass oidvector NOT NULL,
    partcollation oidvector NOT NULL,
    partexprs pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_partitioned_table REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_partitioned_table OWNER TO postgres;

--
-- Name: pg_policies; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_policies AS
 SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    pol.polname AS policyname,
        CASE
            WHEN pol.polpermissive THEN 'PERMISSIVE'::text
            ELSE 'RESTRICTIVE'::text
        END AS permissive,
        CASE
            WHEN (pol.polroles = '{0}'::oid[]) THEN (string_to_array('public'::text, ''::text))::name[]
            ELSE ARRAY( SELECT pg_authid.rolname
               FROM pg_authid
              WHERE (pg_authid.oid = ANY (pol.polroles))
              ORDER BY pg_authid.rolname)
        END AS roles,
        CASE pol.polcmd
            WHEN 'r'::"char" THEN 'SELECT'::text
            WHEN 'a'::"char" THEN 'INSERT'::text
            WHEN 'w'::"char" THEN 'UPDATE'::text
            WHEN 'd'::"char" THEN 'DELETE'::text
            WHEN '*'::"char" THEN 'ALL'::text
            ELSE NULL::text
        END AS cmd,
    pg_get_expr(pol.polqual, pol.polrelid) AS qual,
    pg_get_expr(pol.polwithcheck, pol.polrelid) AS with_check
   FROM ((pg_policy pol
     JOIN pg_class c ON ((c.oid = pol.polrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)));


ALTER VIEW pg_catalog.pg_policies OWNER TO postgres;

--
-- Name: pg_policy; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_policy (
    oid oid NOT NULL,
    polname name NOT NULL,
    polrelid oid NOT NULL,
    polcmd "char" NOT NULL,
    polpermissive boolean NOT NULL,
    polroles oid[] NOT NULL,
    polqual pg_node_tree COLLATE pg_catalog."C",
    polwithcheck pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_policy REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_policy OWNER TO postgres;

--
-- Name: pg_prepared_statements; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_prepared_statements AS
 SELECT name,
    statement,
    prepare_time,
    parameter_types,
    result_types,
    from_sql,
    generic_plans,
    custom_plans
   FROM pg_prepared_statement() p(name, statement, prepare_time, parameter_types, result_types, from_sql, generic_plans, custom_plans);


ALTER VIEW pg_catalog.pg_prepared_statements OWNER TO postgres;

--
-- Name: pg_prepared_xacts; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_prepared_xacts AS
 SELECT p.transaction,
    p.gid,
    p.prepared,
    u.rolname AS owner,
    d.datname AS database
   FROM ((pg_prepared_xact() p(transaction, gid, prepared, ownerid, dbid)
     LEFT JOIN pg_authid u ON ((p.ownerid = u.oid)))
     LEFT JOIN pg_database d ON ((p.dbid = d.oid)));


ALTER VIEW pg_catalog.pg_prepared_xacts OWNER TO postgres;

--
-- Name: pg_proc; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_proc (
    oid oid NOT NULL,
    proname name NOT NULL,
    pronamespace oid NOT NULL,
    proowner oid NOT NULL,
    prolang oid NOT NULL,
    procost real NOT NULL,
    prorows real NOT NULL,
    provariadic oid NOT NULL,
    prosupport regproc NOT NULL,
    prokind "char" NOT NULL,
    prosecdef boolean NOT NULL,
    proleakproof boolean NOT NULL,
    proisstrict boolean NOT NULL,
    proretset boolean NOT NULL,
    provolatile "char" NOT NULL,
    proparallel "char" NOT NULL,
    pronargs smallint NOT NULL,
    pronargdefaults smallint NOT NULL,
    prorettype oid NOT NULL,
    proargtypes oidvector NOT NULL,
    proallargtypes oid[],
    proargmodes "char"[],
    proargnames text[] COLLATE pg_catalog."C",
    proargdefaults pg_node_tree COLLATE pg_catalog."C",
    protrftypes oid[],
    prosrc text NOT NULL COLLATE pg_catalog."C",
    probin text COLLATE pg_catalog."C",
    prosqlbody pg_node_tree COLLATE pg_catalog."C",
    proconfig text[] COLLATE pg_catalog."C",
    proacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_proc REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_proc OWNER TO postgres;

--
-- Name: pg_publication; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_publication (
    oid oid NOT NULL,
    pubname name NOT NULL,
    pubowner oid NOT NULL,
    puballtables boolean NOT NULL,
    pubinsert boolean NOT NULL,
    pubupdate boolean NOT NULL,
    pubdelete boolean NOT NULL,
    pubtruncate boolean NOT NULL,
    pubviaroot boolean NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_publication REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_publication OWNER TO postgres;

--
-- Name: pg_publication_namespace; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_publication_namespace (
    oid oid NOT NULL,
    pnpubid oid NOT NULL,
    pnnspid oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_publication_namespace REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_publication_namespace OWNER TO postgres;

--
-- Name: pg_publication_rel; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_publication_rel (
    oid oid NOT NULL,
    prpubid oid NOT NULL,
    prrelid oid NOT NULL,
    prqual pg_node_tree COLLATE pg_catalog."C",
    prattrs int2vector
);

ALTER TABLE ONLY pg_catalog.pg_publication_rel REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_publication_rel OWNER TO postgres;

--
-- Name: pg_publication_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_publication_tables AS
 SELECT p.pubname,
    n.nspname AS schemaname,
    c.relname AS tablename,
    ( SELECT array_agg(a.attname ORDER BY a.attnum) AS array_agg
           FROM pg_attribute a
          WHERE ((a.attrelid = gpt.relid) AND (a.attnum = ANY ((gpt.attrs)::smallint[])))) AS attnames,
    pg_get_expr(gpt.qual, gpt.relid) AS rowfilter
   FROM pg_publication p,
    LATERAL pg_get_publication_tables(VARIADIC ARRAY[(p.pubname)::text]) gpt(pubid, relid, attrs, qual),
    (pg_class c
     JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.oid = gpt.relid);


ALTER VIEW pg_catalog.pg_publication_tables OWNER TO postgres;

--
-- Name: pg_range; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_range (
    rngtypid oid NOT NULL,
    rngsubtype oid NOT NULL,
    rngmultitypid oid NOT NULL,
    rngcollation oid NOT NULL,
    rngsubopc oid NOT NULL,
    rngcanonical regproc NOT NULL,
    rngsubdiff regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_range REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_range OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_replication_origin; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_replication_origin (
    roident oid NOT NULL,
    roname text NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_replication_origin REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_replication_origin OWNER TO postgres;

--
-- Name: pg_replication_origin_status; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_replication_origin_status AS
 SELECT local_id,
    external_id,
    remote_lsn,
    local_lsn
   FROM pg_show_replication_origin_status() pg_show_replication_origin_status(local_id, external_id, remote_lsn, local_lsn);


ALTER VIEW pg_catalog.pg_replication_origin_status OWNER TO postgres;

--
-- Name: pg_replication_slots; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_replication_slots AS
 SELECT l.slot_name,
    l.plugin,
    l.slot_type,
    l.datoid,
    d.datname AS database,
    l.temporary,
    l.active,
    l.active_pid,
    l.xmin,
    l.catalog_xmin,
    l.restart_lsn,
    l.confirmed_flush_lsn,
    l.wal_status,
    l.safe_wal_size,
    l.two_phase,
    l.conflicting
   FROM (pg_get_replication_slots() l(slot_name, plugin, slot_type, datoid, temporary, active, active_pid, xmin, catalog_xmin, restart_lsn, confirmed_flush_lsn, wal_status, safe_wal_size, two_phase, conflicting)
     LEFT JOIN pg_database d ON ((l.datoid = d.oid)));


ALTER VIEW pg_catalog.pg_replication_slots OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_rewrite; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_rewrite (
    oid oid NOT NULL,
    rulename name NOT NULL,
    ev_class oid NOT NULL,
    ev_type "char" NOT NULL,
    ev_enabled "char" NOT NULL,
    is_instead boolean NOT NULL,
    ev_qual pg_node_tree NOT NULL COLLATE pg_catalog."C",
    ev_action pg_node_tree NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_rewrite REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_rewrite OWNER TO postgres;

--
-- Name: pg_roles; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_roles AS
 SELECT pg_authid.rolname,
    pg_authid.rolsuper,
    pg_authid.rolinherit,
    pg_authid.rolcreaterole,
    pg_authid.rolcreatedb,
    pg_authid.rolcanlogin,
    pg_authid.rolreplication,
    pg_authid.rolconnlimit,
    '********'::text AS rolpassword,
    pg_authid.rolvaliduntil,
    pg_authid.rolbypassrls,
    s.setconfig AS rolconfig,
    pg_authid.oid
   FROM (pg_authid
     LEFT JOIN pg_db_role_setting s ON (((pg_authid.oid = s.setrole) AND (s.setdatabase = (0)::oid))));


ALTER VIEW pg_catalog.pg_roles OWNER TO postgres;

--
-- Name: pg_rules; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_rules AS
 SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    r.rulename,
    pg_get_ruledef(r.oid) AS definition
   FROM ((pg_rewrite r
     JOIN pg_class c ON ((c.oid = r.ev_class)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (r.rulename <> '_RETURN'::name);


ALTER VIEW pg_catalog.pg_rules OWNER TO postgres;

--
-- Name: pg_seclabel; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_seclabel (
    objoid oid NOT NULL,
    classoid oid NOT NULL,
    objsubid integer NOT NULL,
    provider text NOT NULL COLLATE pg_catalog."C",
    label text NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_seclabel REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_seclabel OWNER TO postgres;

--
-- Name: pg_seclabels; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_seclabels AS
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
        CASE
            WHEN (rel.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) THEN 'table'::text
            WHEN (rel.relkind = 'v'::"char") THEN 'view'::text
            WHEN (rel.relkind = 'm'::"char") THEN 'materialized view'::text
            WHEN (rel.relkind = 'S'::"char") THEN 'sequence'::text
            WHEN (rel.relkind = 'f'::"char") THEN 'foreign table'::text
            ELSE NULL::text
        END AS objtype,
    rel.relnamespace AS objnamespace,
        CASE
            WHEN pg_table_is_visible(rel.oid) THEN quote_ident((rel.relname)::text)
            ELSE ((quote_ident((nsp.nspname)::text) || '.'::text) || quote_ident((rel.relname)::text))
        END AS objname,
    l.provider,
    l.label
   FROM ((pg_seclabel l
     JOIN pg_class rel ON (((l.classoid = rel.tableoid) AND (l.objoid = rel.oid))))
     JOIN pg_namespace nsp ON ((rel.relnamespace = nsp.oid)))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'column'::text AS objtype,
    rel.relnamespace AS objnamespace,
    ((
        CASE
            WHEN pg_table_is_visible(rel.oid) THEN quote_ident((rel.relname)::text)
            ELSE ((quote_ident((nsp.nspname)::text) || '.'::text) || quote_ident((rel.relname)::text))
        END || '.'::text) || (att.attname)::text) AS objname,
    l.provider,
    l.label
   FROM (((pg_seclabel l
     JOIN pg_class rel ON (((l.classoid = rel.tableoid) AND (l.objoid = rel.oid))))
     JOIN pg_attribute att ON (((rel.oid = att.attrelid) AND (l.objsubid = att.attnum))))
     JOIN pg_namespace nsp ON ((rel.relnamespace = nsp.oid)))
  WHERE (l.objsubid <> 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
        CASE pro.prokind
            WHEN 'a'::"char" THEN 'aggregate'::text
            WHEN 'f'::"char" THEN 'function'::text
            WHEN 'p'::"char" THEN 'procedure'::text
            WHEN 'w'::"char" THEN 'window'::text
            ELSE NULL::text
        END AS objtype,
    pro.pronamespace AS objnamespace,
    (((
        CASE
            WHEN pg_function_is_visible(pro.oid) THEN quote_ident((pro.proname)::text)
            ELSE ((quote_ident((nsp.nspname)::text) || '.'::text) || quote_ident((pro.proname)::text))
        END || '('::text) || pg_get_function_arguments(pro.oid)) || ')'::text) AS objname,
    l.provider,
    l.label
   FROM ((pg_seclabel l
     JOIN pg_proc pro ON (((l.classoid = pro.tableoid) AND (l.objoid = pro.oid))))
     JOIN pg_namespace nsp ON ((pro.pronamespace = nsp.oid)))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
        CASE
            WHEN (typ.typtype = 'd'::"char") THEN 'domain'::text
            ELSE 'type'::text
        END AS objtype,
    typ.typnamespace AS objnamespace,
        CASE
            WHEN pg_type_is_visible(typ.oid) THEN quote_ident((typ.typname)::text)
            ELSE ((quote_ident((nsp.nspname)::text) || '.'::text) || quote_ident((typ.typname)::text))
        END AS objname,
    l.provider,
    l.label
   FROM ((pg_seclabel l
     JOIN pg_type typ ON (((l.classoid = typ.tableoid) AND (l.objoid = typ.oid))))
     JOIN pg_namespace nsp ON ((typ.typnamespace = nsp.oid)))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'large object'::text AS objtype,
    NULL::oid AS objnamespace,
    (l.objoid)::text AS objname,
    l.provider,
    l.label
   FROM (pg_seclabel l
     JOIN pg_largeobject_metadata lom ON ((l.objoid = lom.oid)))
  WHERE ((l.classoid = ('pg_largeobject'::regclass)::oid) AND (l.objsubid = 0))
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'language'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((lan.lanname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_seclabel l
     JOIN pg_language lan ON (((l.classoid = lan.tableoid) AND (l.objoid = lan.oid))))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'schema'::text AS objtype,
    nsp.oid AS objnamespace,
    quote_ident((nsp.nspname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_seclabel l
     JOIN pg_namespace nsp ON (((l.classoid = nsp.tableoid) AND (l.objoid = nsp.oid))))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'event trigger'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((evt.evtname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_seclabel l
     JOIN pg_event_trigger evt ON (((l.classoid = evt.tableoid) AND (l.objoid = evt.oid))))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    l.objsubid,
    'publication'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((p.pubname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_seclabel l
     JOIN pg_publication p ON (((l.classoid = p.tableoid) AND (l.objoid = p.oid))))
  WHERE (l.objsubid = 0)
UNION ALL
 SELECT l.objoid,
    l.classoid,
    0 AS objsubid,
    'subscription'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((s.subname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_shseclabel l
     JOIN pg_subscription s ON (((l.classoid = s.tableoid) AND (l.objoid = s.oid))))
UNION ALL
 SELECT l.objoid,
    l.classoid,
    0 AS objsubid,
    'database'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((dat.datname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_shseclabel l
     JOIN pg_database dat ON (((l.classoid = dat.tableoid) AND (l.objoid = dat.oid))))
UNION ALL
 SELECT l.objoid,
    l.classoid,
    0 AS objsubid,
    'tablespace'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((spc.spcname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_shseclabel l
     JOIN pg_tablespace spc ON (((l.classoid = spc.tableoid) AND (l.objoid = spc.oid))))
UNION ALL
 SELECT l.objoid,
    l.classoid,
    0 AS objsubid,
    'role'::text AS objtype,
    NULL::oid AS objnamespace,
    quote_ident((rol.rolname)::text) AS objname,
    l.provider,
    l.label
   FROM (pg_shseclabel l
     JOIN pg_authid rol ON (((l.classoid = rol.tableoid) AND (l.objoid = rol.oid))));


ALTER VIEW pg_catalog.pg_seclabels OWNER TO postgres;

--
-- Name: pg_sequence; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_sequence (
    seqrelid oid NOT NULL,
    seqtypid oid NOT NULL,
    seqstart bigint NOT NULL,
    seqincrement bigint NOT NULL,
    seqmax bigint NOT NULL,
    seqmin bigint NOT NULL,
    seqcache bigint NOT NULL,
    seqcycle boolean NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_sequence REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_sequence OWNER TO postgres;

--
-- Name: pg_sequences; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_sequences AS
 SELECT n.nspname AS schemaname,
    c.relname AS sequencename,
    pg_get_userbyid(c.relowner) AS sequenceowner,
    (s.seqtypid)::regtype AS data_type,
    s.seqstart AS start_value,
    s.seqmin AS min_value,
    s.seqmax AS max_value,
    s.seqincrement AS increment_by,
    s.seqcycle AS cycle,
    s.seqcache AS cache_size,
        CASE
            WHEN has_sequence_privilege(c.oid, 'SELECT,USAGE'::text) THEN pg_sequence_last_value((c.oid)::regclass)
            ELSE NULL::bigint
        END AS last_value
   FROM ((pg_sequence s
     JOIN pg_class c ON ((c.oid = s.seqrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE ((NOT pg_is_other_temp_schema(n.oid)) AND (c.relkind = 'S'::"char"));


ALTER VIEW pg_catalog.pg_sequences OWNER TO postgres;

--
-- Name: pg_settings; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_settings AS
 SELECT name,
    setting,
    unit,
    category,
    short_desc,
    extra_desc,
    context,
    vartype,
    source,
    min_val,
    max_val,
    enumvals,
    boot_val,
    reset_val,
    sourcefile,
    sourceline,
    pending_restart
   FROM pg_show_all_settings() a(name, setting, unit, category, short_desc, extra_desc, context, vartype, source, min_val, max_val, enumvals, boot_val, reset_val, sourcefile, sourceline, pending_restart);


ALTER VIEW pg_catalog.pg_settings OWNER TO postgres;

--
-- Name: pg_shadow; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_shadow AS
 SELECT pg_authid.rolname AS usename,
    pg_authid.oid AS usesysid,
    pg_authid.rolcreatedb AS usecreatedb,
    pg_authid.rolsuper AS usesuper,
    pg_authid.rolreplication AS userepl,
    pg_authid.rolbypassrls AS usebypassrls,
    pg_authid.rolpassword AS passwd,
    pg_authid.rolvaliduntil AS valuntil,
    s.setconfig AS useconfig
   FROM (pg_authid
     LEFT JOIN pg_db_role_setting s ON (((pg_authid.oid = s.setrole) AND (s.setdatabase = (0)::oid))))
  WHERE pg_authid.rolcanlogin;


ALTER VIEW pg_catalog.pg_shadow OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_shdepend; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_shdepend (
    dbid oid NOT NULL,
    classid oid NOT NULL,
    objid oid NOT NULL,
    objsubid integer NOT NULL,
    refclassid oid NOT NULL,
    refobjid oid NOT NULL,
    deptype "char" NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_shdepend REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_shdepend OWNER TO postgres;

--
-- Name: pg_shdescription; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_shdescription (
    objoid oid NOT NULL,
    classoid oid NOT NULL,
    description text NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_shdescription REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_shdescription OWNER TO postgres;

--
-- Name: pg_shmem_allocations; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_shmem_allocations AS
 SELECT name,
    off,
    size,
    allocated_size
   FROM pg_get_shmem_allocations() pg_get_shmem_allocations(name, off, size, allocated_size);


ALTER VIEW pg_catalog.pg_shmem_allocations OWNER TO postgres;

--
-- Name: pg_shseclabel; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_shseclabel (
    objoid oid NOT NULL,
    classoid oid NOT NULL,
    provider text NOT NULL COLLATE pg_catalog."C",
    label text NOT NULL COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_shseclabel REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_shseclabel OWNER TO postgres;

--
-- Name: pg_stat_activity; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_activity AS
 SELECT s.datid,
    d.datname,
    s.pid,
    s.leader_pid,
    s.usesysid,
    u.rolname AS usename,
    s.application_name,
    s.client_addr,
    s.client_hostname,
    s.client_port,
    s.backend_start,
    s.xact_start,
    s.query_start,
    s.state_change,
    s.wait_event_type,
    s.wait_event,
    s.state,
    s.backend_xid,
    s.backend_xmin,
    s.query_id,
    s.query,
    s.backend_type
   FROM ((pg_stat_get_activity(NULL::integer) s(datid, pid, usesysid, application_name, state, query, wait_event_type, wait_event, xact_start, query_start, backend_start, state_change, client_addr, client_hostname, client_port, backend_xid, backend_xmin, backend_type, ssl, sslversion, sslcipher, sslbits, ssl_client_dn, ssl_client_serial, ssl_issuer_dn, gss_auth, gss_princ, gss_enc, gss_delegation, leader_pid, query_id)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)))
     LEFT JOIN pg_authid u ON ((s.usesysid = u.oid)));


ALTER VIEW pg_catalog.pg_stat_activity OWNER TO postgres;

--
-- Name: pg_stat_all_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_all_indexes AS
 SELECT c.oid AS relid,
    i.oid AS indexrelid,
    n.nspname AS schemaname,
    c.relname,
    i.relname AS indexrelname,
    pg_stat_get_numscans(i.oid) AS idx_scan,
    pg_stat_get_lastscan(i.oid) AS last_idx_scan,
    pg_stat_get_tuples_returned(i.oid) AS idx_tup_read,
    pg_stat_get_tuples_fetched(i.oid) AS idx_tup_fetch
   FROM (((pg_class c
     JOIN pg_index x ON ((c.oid = x.indrelid)))
     JOIN pg_class i ON ((i.oid = x.indexrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 't'::"char", 'm'::"char"]));


ALTER VIEW pg_catalog.pg_stat_all_indexes OWNER TO postgres;

--
-- Name: pg_stat_all_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_all_tables AS
 SELECT c.oid AS relid,
    n.nspname AS schemaname,
    c.relname,
    pg_stat_get_numscans(c.oid) AS seq_scan,
    pg_stat_get_lastscan(c.oid) AS last_seq_scan,
    pg_stat_get_tuples_returned(c.oid) AS seq_tup_read,
    (sum(pg_stat_get_numscans(i.indexrelid)))::bigint AS idx_scan,
    max(pg_stat_get_lastscan(i.indexrelid)) AS last_idx_scan,
    ((sum(pg_stat_get_tuples_fetched(i.indexrelid)))::bigint + pg_stat_get_tuples_fetched(c.oid)) AS idx_tup_fetch,
    pg_stat_get_tuples_inserted(c.oid) AS n_tup_ins,
    pg_stat_get_tuples_updated(c.oid) AS n_tup_upd,
    pg_stat_get_tuples_deleted(c.oid) AS n_tup_del,
    pg_stat_get_tuples_hot_updated(c.oid) AS n_tup_hot_upd,
    pg_stat_get_tuples_newpage_updated(c.oid) AS n_tup_newpage_upd,
    pg_stat_get_live_tuples(c.oid) AS n_live_tup,
    pg_stat_get_dead_tuples(c.oid) AS n_dead_tup,
    pg_stat_get_mod_since_analyze(c.oid) AS n_mod_since_analyze,
    pg_stat_get_ins_since_vacuum(c.oid) AS n_ins_since_vacuum,
    pg_stat_get_last_vacuum_time(c.oid) AS last_vacuum,
    pg_stat_get_last_autovacuum_time(c.oid) AS last_autovacuum,
    pg_stat_get_last_analyze_time(c.oid) AS last_analyze,
    pg_stat_get_last_autoanalyze_time(c.oid) AS last_autoanalyze,
    pg_stat_get_vacuum_count(c.oid) AS vacuum_count,
    pg_stat_get_autovacuum_count(c.oid) AS autovacuum_count,
    pg_stat_get_analyze_count(c.oid) AS analyze_count,
    pg_stat_get_autoanalyze_count(c.oid) AS autoanalyze_count
   FROM ((pg_class c
     LEFT JOIN pg_index i ON ((c.oid = i.indrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 't'::"char", 'm'::"char", 'p'::"char"]))
  GROUP BY c.oid, n.nspname, c.relname;


ALTER VIEW pg_catalog.pg_stat_all_tables OWNER TO postgres;

--
-- Name: pg_stat_archiver; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_archiver AS
 SELECT archived_count,
    last_archived_wal,
    last_archived_time,
    failed_count,
    last_failed_wal,
    last_failed_time,
    stats_reset
   FROM pg_stat_get_archiver() s(archived_count, last_archived_wal, last_archived_time, failed_count, last_failed_wal, last_failed_time, stats_reset);


ALTER VIEW pg_catalog.pg_stat_archiver OWNER TO postgres;

--
-- Name: pg_stat_bgwriter; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_bgwriter AS
 SELECT pg_stat_get_bgwriter_timed_checkpoints() AS checkpoints_timed,
    pg_stat_get_bgwriter_requested_checkpoints() AS checkpoints_req,
    pg_stat_get_checkpoint_write_time() AS checkpoint_write_time,
    pg_stat_get_checkpoint_sync_time() AS checkpoint_sync_time,
    pg_stat_get_bgwriter_buf_written_checkpoints() AS buffers_checkpoint,
    pg_stat_get_bgwriter_buf_written_clean() AS buffers_clean,
    pg_stat_get_bgwriter_maxwritten_clean() AS maxwritten_clean,
    pg_stat_get_buf_written_backend() AS buffers_backend,
    pg_stat_get_buf_fsync_backend() AS buffers_backend_fsync,
    pg_stat_get_buf_alloc() AS buffers_alloc,
    pg_stat_get_bgwriter_stat_reset_time() AS stats_reset;


ALTER VIEW pg_catalog.pg_stat_bgwriter OWNER TO postgres;

--
-- Name: pg_stat_database; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_database AS
 SELECT oid AS datid,
    datname,
        CASE
            WHEN (oid = (0)::oid) THEN 0
            ELSE pg_stat_get_db_numbackends(oid)
        END AS numbackends,
    pg_stat_get_db_xact_commit(oid) AS xact_commit,
    pg_stat_get_db_xact_rollback(oid) AS xact_rollback,
    (pg_stat_get_db_blocks_fetched(oid) - pg_stat_get_db_blocks_hit(oid)) AS blks_read,
    pg_stat_get_db_blocks_hit(oid) AS blks_hit,
    pg_stat_get_db_tuples_returned(oid) AS tup_returned,
    pg_stat_get_db_tuples_fetched(oid) AS tup_fetched,
    pg_stat_get_db_tuples_inserted(oid) AS tup_inserted,
    pg_stat_get_db_tuples_updated(oid) AS tup_updated,
    pg_stat_get_db_tuples_deleted(oid) AS tup_deleted,
    pg_stat_get_db_conflict_all(oid) AS conflicts,
    pg_stat_get_db_temp_files(oid) AS temp_files,
    pg_stat_get_db_temp_bytes(oid) AS temp_bytes,
    pg_stat_get_db_deadlocks(oid) AS deadlocks,
    pg_stat_get_db_checksum_failures(oid) AS checksum_failures,
    pg_stat_get_db_checksum_last_failure(oid) AS checksum_last_failure,
    pg_stat_get_db_blk_read_time(oid) AS blk_read_time,
    pg_stat_get_db_blk_write_time(oid) AS blk_write_time,
    pg_stat_get_db_session_time(oid) AS session_time,
    pg_stat_get_db_active_time(oid) AS active_time,
    pg_stat_get_db_idle_in_transaction_time(oid) AS idle_in_transaction_time,
    pg_stat_get_db_sessions(oid) AS sessions,
    pg_stat_get_db_sessions_abandoned(oid) AS sessions_abandoned,
    pg_stat_get_db_sessions_fatal(oid) AS sessions_fatal,
    pg_stat_get_db_sessions_killed(oid) AS sessions_killed,
    pg_stat_get_db_stat_reset_time(oid) AS stats_reset
   FROM ( SELECT 0 AS oid,
            NULL::name AS datname
        UNION ALL
         SELECT pg_database.oid,
            pg_database.datname
           FROM pg_database) d;


ALTER VIEW pg_catalog.pg_stat_database OWNER TO postgres;

--
-- Name: pg_stat_database_conflicts; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_database_conflicts AS
 SELECT oid AS datid,
    datname,
    pg_stat_get_db_conflict_tablespace(oid) AS confl_tablespace,
    pg_stat_get_db_conflict_lock(oid) AS confl_lock,
    pg_stat_get_db_conflict_snapshot(oid) AS confl_snapshot,
    pg_stat_get_db_conflict_bufferpin(oid) AS confl_bufferpin,
    pg_stat_get_db_conflict_startup_deadlock(oid) AS confl_deadlock,
    pg_stat_get_db_conflict_logicalslot(oid) AS confl_active_logicalslot
   FROM pg_database d;


ALTER VIEW pg_catalog.pg_stat_database_conflicts OWNER TO postgres;

--
-- Name: pg_stat_gssapi; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_gssapi AS
 SELECT pid,
    gss_auth AS gss_authenticated,
    gss_princ AS principal,
    gss_enc AS encrypted,
    gss_delegation AS credentials_delegated
   FROM pg_stat_get_activity(NULL::integer) s(datid, pid, usesysid, application_name, state, query, wait_event_type, wait_event, xact_start, query_start, backend_start, state_change, client_addr, client_hostname, client_port, backend_xid, backend_xmin, backend_type, ssl, sslversion, sslcipher, sslbits, ssl_client_dn, ssl_client_serial, ssl_issuer_dn, gss_auth, gss_princ, gss_enc, gss_delegation, leader_pid, query_id)
  WHERE (client_port IS NOT NULL);


ALTER VIEW pg_catalog.pg_stat_gssapi OWNER TO postgres;

--
-- Name: pg_stat_io; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_io AS
 SELECT backend_type,
    object,
    context,
    reads,
    read_time,
    writes,
    write_time,
    writebacks,
    writeback_time,
    extends,
    extend_time,
    op_bytes,
    hits,
    evictions,
    reuses,
    fsyncs,
    fsync_time,
    stats_reset
   FROM pg_stat_get_io() b(backend_type, object, context, reads, read_time, writes, write_time, writebacks, writeback_time, extends, extend_time, op_bytes, hits, evictions, reuses, fsyncs, fsync_time, stats_reset);


ALTER VIEW pg_catalog.pg_stat_io OWNER TO postgres;

--
-- Name: pg_stat_progress_analyze; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_analyze AS
 SELECT s.pid,
    s.datid,
    d.datname,
    s.relid,
        CASE s.param1
            WHEN 0 THEN 'initializing'::text
            WHEN 1 THEN 'acquiring sample rows'::text
            WHEN 2 THEN 'acquiring inherited sample rows'::text
            WHEN 3 THEN 'computing statistics'::text
            WHEN 4 THEN 'computing extended statistics'::text
            WHEN 5 THEN 'finalizing analyze'::text
            ELSE NULL::text
        END AS phase,
    s.param2 AS sample_blks_total,
    s.param3 AS sample_blks_scanned,
    s.param4 AS ext_stats_total,
    s.param5 AS ext_stats_computed,
    s.param6 AS child_tables_total,
    s.param7 AS child_tables_done,
    (s.param8)::oid AS current_child_table_relid
   FROM (pg_stat_get_progress_info('ANALYZE'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)));


ALTER VIEW pg_catalog.pg_stat_progress_analyze OWNER TO postgres;

--
-- Name: pg_stat_progress_basebackup; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_basebackup AS
 SELECT pid,
        CASE param1
            WHEN 0 THEN 'initializing'::text
            WHEN 1 THEN 'waiting for checkpoint to finish'::text
            WHEN 2 THEN 'estimating backup size'::text
            WHEN 3 THEN 'streaming database files'::text
            WHEN 4 THEN 'waiting for wal archiving to finish'::text
            WHEN 5 THEN 'transferring wal files'::text
            ELSE NULL::text
        END AS phase,
        CASE param2
            WHEN '-1'::integer THEN NULL::bigint
            ELSE param2
        END AS backup_total,
    param3 AS backup_streamed,
    param4 AS tablespaces_total,
    param5 AS tablespaces_streamed
   FROM pg_stat_get_progress_info('BASEBACKUP'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20);


ALTER VIEW pg_catalog.pg_stat_progress_basebackup OWNER TO postgres;

--
-- Name: pg_stat_progress_cluster; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_cluster AS
 SELECT s.pid,
    s.datid,
    d.datname,
    s.relid,
        CASE s.param1
            WHEN 1 THEN 'CLUSTER'::text
            WHEN 2 THEN 'VACUUM FULL'::text
            ELSE NULL::text
        END AS command,
        CASE s.param2
            WHEN 0 THEN 'initializing'::text
            WHEN 1 THEN 'seq scanning heap'::text
            WHEN 2 THEN 'index scanning heap'::text
            WHEN 3 THEN 'sorting tuples'::text
            WHEN 4 THEN 'writing new heap'::text
            WHEN 5 THEN 'swapping relation files'::text
            WHEN 6 THEN 'rebuilding index'::text
            WHEN 7 THEN 'performing final cleanup'::text
            ELSE NULL::text
        END AS phase,
    (s.param3)::oid AS cluster_index_relid,
    s.param4 AS heap_tuples_scanned,
    s.param5 AS heap_tuples_written,
    s.param6 AS heap_blks_total,
    s.param7 AS heap_blks_scanned,
    s.param8 AS index_rebuild_count
   FROM (pg_stat_get_progress_info('CLUSTER'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)));


ALTER VIEW pg_catalog.pg_stat_progress_cluster OWNER TO postgres;

--
-- Name: pg_stat_progress_copy; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_copy AS
 SELECT s.pid,
    s.datid,
    d.datname,
    s.relid,
        CASE s.param5
            WHEN 1 THEN 'COPY FROM'::text
            WHEN 2 THEN 'COPY TO'::text
            ELSE NULL::text
        END AS command,
        CASE s.param6
            WHEN 1 THEN 'FILE'::text
            WHEN 2 THEN 'PROGRAM'::text
            WHEN 3 THEN 'PIPE'::text
            WHEN 4 THEN 'CALLBACK'::text
            ELSE NULL::text
        END AS type,
    s.param1 AS bytes_processed,
    s.param2 AS bytes_total,
    s.param3 AS tuples_processed,
    s.param4 AS tuples_excluded
   FROM (pg_stat_get_progress_info('COPY'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)));


ALTER VIEW pg_catalog.pg_stat_progress_copy OWNER TO postgres;

--
-- Name: pg_stat_progress_create_index; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_create_index AS
 SELECT s.pid,
    s.datid,
    d.datname,
    s.relid,
    (s.param7)::oid AS index_relid,
        CASE s.param1
            WHEN 1 THEN 'CREATE INDEX'::text
            WHEN 2 THEN 'CREATE INDEX CONCURRENTLY'::text
            WHEN 3 THEN 'REINDEX'::text
            WHEN 4 THEN 'REINDEX CONCURRENTLY'::text
            ELSE NULL::text
        END AS command,
        CASE s.param10
            WHEN 0 THEN 'initializing'::text
            WHEN 1 THEN 'waiting for writers before build'::text
            WHEN 2 THEN ('building index'::text || COALESCE((': '::text || pg_indexam_progress_phasename((s.param9)::oid, s.param11)), ''::text))
            WHEN 3 THEN 'waiting for writers before validation'::text
            WHEN 4 THEN 'index validation: scanning index'::text
            WHEN 5 THEN 'index validation: sorting tuples'::text
            WHEN 6 THEN 'index validation: scanning table'::text
            WHEN 7 THEN 'waiting for old snapshots'::text
            WHEN 8 THEN 'waiting for readers before marking dead'::text
            WHEN 9 THEN 'waiting for readers before dropping'::text
            ELSE NULL::text
        END AS phase,
    s.param4 AS lockers_total,
    s.param5 AS lockers_done,
    s.param6 AS current_locker_pid,
    s.param16 AS blocks_total,
    s.param17 AS blocks_done,
    s.param12 AS tuples_total,
    s.param13 AS tuples_done,
    s.param14 AS partitions_total,
    s.param15 AS partitions_done
   FROM (pg_stat_get_progress_info('CREATE INDEX'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)));


ALTER VIEW pg_catalog.pg_stat_progress_create_index OWNER TO postgres;

--
-- Name: pg_stat_progress_vacuum; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_progress_vacuum AS
 SELECT s.pid,
    s.datid,
    d.datname,
    s.relid,
        CASE s.param1
            WHEN 0 THEN 'initializing'::text
            WHEN 1 THEN 'scanning heap'::text
            WHEN 2 THEN 'vacuuming indexes'::text
            WHEN 3 THEN 'vacuuming heap'::text
            WHEN 4 THEN 'cleaning up indexes'::text
            WHEN 5 THEN 'truncating heap'::text
            WHEN 6 THEN 'performing final cleanup'::text
            ELSE NULL::text
        END AS phase,
    s.param2 AS heap_blks_total,
    s.param3 AS heap_blks_scanned,
    s.param4 AS heap_blks_vacuumed,
    s.param5 AS index_vacuum_count,
    s.param6 AS max_dead_tuples,
    s.param7 AS num_dead_tuples
   FROM (pg_stat_get_progress_info('VACUUM'::text) s(pid, datid, relid, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20)
     LEFT JOIN pg_database d ON ((s.datid = d.oid)));


ALTER VIEW pg_catalog.pg_stat_progress_vacuum OWNER TO postgres;

--
-- Name: pg_stat_recovery_prefetch; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_recovery_prefetch AS
 SELECT stats_reset,
    prefetch,
    hit,
    skip_init,
    skip_new,
    skip_fpw,
    skip_rep,
    wal_distance,
    block_distance,
    io_depth
   FROM pg_stat_get_recovery_prefetch() s(stats_reset, prefetch, hit, skip_init, skip_new, skip_fpw, skip_rep, wal_distance, block_distance, io_depth);


ALTER VIEW pg_catalog.pg_stat_recovery_prefetch OWNER TO postgres;

--
-- Name: pg_stat_replication; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_replication AS
 SELECT s.pid,
    s.usesysid,
    u.rolname AS usename,
    s.application_name,
    s.client_addr,
    s.client_hostname,
    s.client_port,
    s.backend_start,
    s.backend_xmin,
    w.state,
    w.sent_lsn,
    w.write_lsn,
    w.flush_lsn,
    w.replay_lsn,
    w.write_lag,
    w.flush_lag,
    w.replay_lag,
    w.sync_priority,
    w.sync_state,
    w.reply_time
   FROM ((pg_stat_get_activity(NULL::integer) s(datid, pid, usesysid, application_name, state, query, wait_event_type, wait_event, xact_start, query_start, backend_start, state_change, client_addr, client_hostname, client_port, backend_xid, backend_xmin, backend_type, ssl, sslversion, sslcipher, sslbits, ssl_client_dn, ssl_client_serial, ssl_issuer_dn, gss_auth, gss_princ, gss_enc, gss_delegation, leader_pid, query_id)
     JOIN pg_stat_get_wal_senders() w(pid, state, sent_lsn, write_lsn, flush_lsn, replay_lsn, write_lag, flush_lag, replay_lag, sync_priority, sync_state, reply_time) ON ((s.pid = w.pid)))
     LEFT JOIN pg_authid u ON ((s.usesysid = u.oid)));


ALTER VIEW pg_catalog.pg_stat_replication OWNER TO postgres;

--
-- Name: pg_stat_replication_slots; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_replication_slots AS
 SELECT s.slot_name,
    s.spill_txns,
    s.spill_count,
    s.spill_bytes,
    s.stream_txns,
    s.stream_count,
    s.stream_bytes,
    s.total_txns,
    s.total_bytes,
    s.stats_reset
   FROM pg_replication_slots r,
    LATERAL pg_stat_get_replication_slot((r.slot_name)::text) s(slot_name, spill_txns, spill_count, spill_bytes, stream_txns, stream_count, stream_bytes, total_txns, total_bytes, stats_reset)
  WHERE (r.datoid IS NOT NULL);


ALTER VIEW pg_catalog.pg_stat_replication_slots OWNER TO postgres;

--
-- Name: pg_stat_slru; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_slru AS
 SELECT name,
    blks_zeroed,
    blks_hit,
    blks_read,
    blks_written,
    blks_exists,
    flushes,
    truncates,
    stats_reset
   FROM pg_stat_get_slru() s(name, blks_zeroed, blks_hit, blks_read, blks_written, blks_exists, flushes, truncates, stats_reset);


ALTER VIEW pg_catalog.pg_stat_slru OWNER TO postgres;

--
-- Name: pg_stat_ssl; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_ssl AS
 SELECT pid,
    ssl,
    sslversion AS version,
    sslcipher AS cipher,
    sslbits AS bits,
    ssl_client_dn AS client_dn,
    ssl_client_serial AS client_serial,
    ssl_issuer_dn AS issuer_dn
   FROM pg_stat_get_activity(NULL::integer) s(datid, pid, usesysid, application_name, state, query, wait_event_type, wait_event, xact_start, query_start, backend_start, state_change, client_addr, client_hostname, client_port, backend_xid, backend_xmin, backend_type, ssl, sslversion, sslcipher, sslbits, ssl_client_dn, ssl_client_serial, ssl_issuer_dn, gss_auth, gss_princ, gss_enc, gss_delegation, leader_pid, query_id)
  WHERE (client_port IS NOT NULL);


ALTER VIEW pg_catalog.pg_stat_ssl OWNER TO postgres;

--
-- Name: pg_stat_subscription; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_subscription AS
 SELECT su.oid AS subid,
    su.subname,
    st.pid,
    st.leader_pid,
    st.relid,
    st.received_lsn,
    st.last_msg_send_time,
    st.last_msg_receipt_time,
    st.latest_end_lsn,
    st.latest_end_time
   FROM (pg_subscription su
     LEFT JOIN pg_stat_get_subscription(NULL::oid) st(subid, relid, pid, leader_pid, received_lsn, last_msg_send_time, last_msg_receipt_time, latest_end_lsn, latest_end_time) ON ((st.subid = su.oid)));


ALTER VIEW pg_catalog.pg_stat_subscription OWNER TO postgres;

--
-- Name: pg_stat_subscription_stats; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_subscription_stats AS
 SELECT ss.subid,
    s.subname,
    ss.apply_error_count,
    ss.sync_error_count,
    ss.stats_reset
   FROM pg_subscription s,
    LATERAL pg_stat_get_subscription_stats(s.oid) ss(subid, apply_error_count, sync_error_count, stats_reset);


ALTER VIEW pg_catalog.pg_stat_subscription_stats OWNER TO postgres;

--
-- Name: pg_stat_sys_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_sys_indexes AS
 SELECT relid,
    indexrelid,
    schemaname,
    relname,
    indexrelname,
    idx_scan,
    last_idx_scan,
    idx_tup_read,
    idx_tup_fetch
   FROM pg_stat_all_indexes
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_sys_indexes OWNER TO postgres;

--
-- Name: pg_stat_sys_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_sys_tables AS
 SELECT relid,
    schemaname,
    relname,
    seq_scan,
    last_seq_scan,
    seq_tup_read,
    idx_scan,
    last_idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_tup_newpage_upd,
    n_live_tup,
    n_dead_tup,
    n_mod_since_analyze,
    n_ins_since_vacuum,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze,
    vacuum_count,
    autovacuum_count,
    analyze_count,
    autoanalyze_count
   FROM pg_stat_all_tables
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_sys_tables OWNER TO postgres;

--
-- Name: pg_stat_user_functions; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_user_functions AS
 SELECT p.oid AS funcid,
    n.nspname AS schemaname,
    p.proname AS funcname,
    pg_stat_get_function_calls(p.oid) AS calls,
    pg_stat_get_function_total_time(p.oid) AS total_time,
    pg_stat_get_function_self_time(p.oid) AS self_time
   FROM (pg_proc p
     LEFT JOIN pg_namespace n ON ((n.oid = p.pronamespace)))
  WHERE ((p.prolang <> (12)::oid) AND (pg_stat_get_function_calls(p.oid) IS NOT NULL));


ALTER VIEW pg_catalog.pg_stat_user_functions OWNER TO postgres;

--
-- Name: pg_stat_user_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_user_indexes AS
 SELECT relid,
    indexrelid,
    schemaname,
    relname,
    indexrelname,
    idx_scan,
    last_idx_scan,
    idx_tup_read,
    idx_tup_fetch
   FROM pg_stat_all_indexes
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_user_indexes OWNER TO postgres;

--
-- Name: pg_stat_user_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_user_tables AS
 SELECT relid,
    schemaname,
    relname,
    seq_scan,
    last_seq_scan,
    seq_tup_read,
    idx_scan,
    last_idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_tup_newpage_upd,
    n_live_tup,
    n_dead_tup,
    n_mod_since_analyze,
    n_ins_since_vacuum,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze,
    vacuum_count,
    autovacuum_count,
    analyze_count,
    autoanalyze_count
   FROM pg_stat_all_tables
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_user_tables OWNER TO postgres;

--
-- Name: pg_stat_wal; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_wal AS
 SELECT wal_records,
    wal_fpi,
    wal_bytes,
    wal_buffers_full,
    wal_write,
    wal_sync,
    wal_write_time,
    wal_sync_time,
    stats_reset
   FROM pg_stat_get_wal() w(wal_records, wal_fpi, wal_bytes, wal_buffers_full, wal_write, wal_sync, wal_write_time, wal_sync_time, stats_reset);


ALTER VIEW pg_catalog.pg_stat_wal OWNER TO postgres;

--
-- Name: pg_stat_wal_receiver; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_wal_receiver AS
 SELECT pid,
    status,
    receive_start_lsn,
    receive_start_tli,
    written_lsn,
    flushed_lsn,
    received_tli,
    last_msg_send_time,
    last_msg_receipt_time,
    latest_end_lsn,
    latest_end_time,
    slot_name,
    sender_host,
    sender_port,
    conninfo
   FROM pg_stat_get_wal_receiver() s(pid, status, receive_start_lsn, receive_start_tli, written_lsn, flushed_lsn, received_tli, last_msg_send_time, last_msg_receipt_time, latest_end_lsn, latest_end_time, slot_name, sender_host, sender_port, conninfo)
  WHERE (pid IS NOT NULL);


ALTER VIEW pg_catalog.pg_stat_wal_receiver OWNER TO postgres;

--
-- Name: pg_stat_xact_all_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_xact_all_tables AS
 SELECT c.oid AS relid,
    n.nspname AS schemaname,
    c.relname,
    pg_stat_get_xact_numscans(c.oid) AS seq_scan,
    pg_stat_get_xact_tuples_returned(c.oid) AS seq_tup_read,
    (sum(pg_stat_get_xact_numscans(i.indexrelid)))::bigint AS idx_scan,
    ((sum(pg_stat_get_xact_tuples_fetched(i.indexrelid)))::bigint + pg_stat_get_xact_tuples_fetched(c.oid)) AS idx_tup_fetch,
    pg_stat_get_xact_tuples_inserted(c.oid) AS n_tup_ins,
    pg_stat_get_xact_tuples_updated(c.oid) AS n_tup_upd,
    pg_stat_get_xact_tuples_deleted(c.oid) AS n_tup_del,
    pg_stat_get_xact_tuples_hot_updated(c.oid) AS n_tup_hot_upd,
    pg_stat_get_xact_tuples_newpage_updated(c.oid) AS n_tup_newpage_upd
   FROM ((pg_class c
     LEFT JOIN pg_index i ON ((c.oid = i.indrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 't'::"char", 'm'::"char", 'p'::"char"]))
  GROUP BY c.oid, n.nspname, c.relname;


ALTER VIEW pg_catalog.pg_stat_xact_all_tables OWNER TO postgres;

--
-- Name: pg_stat_xact_sys_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_xact_sys_tables AS
 SELECT relid,
    schemaname,
    relname,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_tup_newpage_upd
   FROM pg_stat_xact_all_tables
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_xact_sys_tables OWNER TO postgres;

--
-- Name: pg_stat_xact_user_functions; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_xact_user_functions AS
 SELECT p.oid AS funcid,
    n.nspname AS schemaname,
    p.proname AS funcname,
    pg_stat_get_xact_function_calls(p.oid) AS calls,
    pg_stat_get_xact_function_total_time(p.oid) AS total_time,
    pg_stat_get_xact_function_self_time(p.oid) AS self_time
   FROM (pg_proc p
     LEFT JOIN pg_namespace n ON ((n.oid = p.pronamespace)))
  WHERE ((p.prolang <> (12)::oid) AND (pg_stat_get_xact_function_calls(p.oid) IS NOT NULL));


ALTER VIEW pg_catalog.pg_stat_xact_user_functions OWNER TO postgres;

--
-- Name: pg_stat_xact_user_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stat_xact_user_tables AS
 SELECT relid,
    schemaname,
    relname,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,
    n_tup_newpage_upd
   FROM pg_stat_xact_all_tables
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_stat_xact_user_tables OWNER TO postgres;

--
-- Name: pg_statio_all_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_all_indexes AS
 SELECT c.oid AS relid,
    i.oid AS indexrelid,
    n.nspname AS schemaname,
    c.relname,
    i.relname AS indexrelname,
    (pg_stat_get_blocks_fetched(i.oid) - pg_stat_get_blocks_hit(i.oid)) AS idx_blks_read,
    pg_stat_get_blocks_hit(i.oid) AS idx_blks_hit
   FROM (((pg_class c
     JOIN pg_index x ON ((c.oid = x.indrelid)))
     JOIN pg_class i ON ((i.oid = x.indexrelid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 't'::"char", 'm'::"char"]));


ALTER VIEW pg_catalog.pg_statio_all_indexes OWNER TO postgres;

--
-- Name: pg_statio_all_sequences; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_all_sequences AS
 SELECT c.oid AS relid,
    n.nspname AS schemaname,
    c.relname,
    (pg_stat_get_blocks_fetched(c.oid) - pg_stat_get_blocks_hit(c.oid)) AS blks_read,
    pg_stat_get_blocks_hit(c.oid) AS blks_hit
   FROM (pg_class c
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = 'S'::"char");


ALTER VIEW pg_catalog.pg_statio_all_sequences OWNER TO postgres;

--
-- Name: pg_statio_all_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_all_tables AS
 SELECT c.oid AS relid,
    n.nspname AS schemaname,
    c.relname,
    (pg_stat_get_blocks_fetched(c.oid) - pg_stat_get_blocks_hit(c.oid)) AS heap_blks_read,
    pg_stat_get_blocks_hit(c.oid) AS heap_blks_hit,
    i.idx_blks_read,
    i.idx_blks_hit,
    (pg_stat_get_blocks_fetched(t.oid) - pg_stat_get_blocks_hit(t.oid)) AS toast_blks_read,
    pg_stat_get_blocks_hit(t.oid) AS toast_blks_hit,
    x.idx_blks_read AS tidx_blks_read,
    x.idx_blks_hit AS tidx_blks_hit
   FROM ((((pg_class c
     LEFT JOIN pg_class t ON ((c.reltoastrelid = t.oid)))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
     LEFT JOIN LATERAL ( SELECT (sum((pg_stat_get_blocks_fetched(pg_index.indexrelid) - pg_stat_get_blocks_hit(pg_index.indexrelid))))::bigint AS idx_blks_read,
            (sum(pg_stat_get_blocks_hit(pg_index.indexrelid)))::bigint AS idx_blks_hit
           FROM pg_index
          WHERE (pg_index.indrelid = c.oid)) i ON (true))
     LEFT JOIN LATERAL ( SELECT (sum((pg_stat_get_blocks_fetched(pg_index.indexrelid) - pg_stat_get_blocks_hit(pg_index.indexrelid))))::bigint AS idx_blks_read,
            (sum(pg_stat_get_blocks_hit(pg_index.indexrelid)))::bigint AS idx_blks_hit
           FROM pg_index
          WHERE (pg_index.indrelid = t.oid)) x ON (true))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 't'::"char", 'm'::"char"]));


ALTER VIEW pg_catalog.pg_statio_all_tables OWNER TO postgres;

--
-- Name: pg_statio_sys_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_sys_indexes AS
 SELECT relid,
    indexrelid,
    schemaname,
    relname,
    indexrelname,
    idx_blks_read,
    idx_blks_hit
   FROM pg_statio_all_indexes
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_sys_indexes OWNER TO postgres;

--
-- Name: pg_statio_sys_sequences; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_sys_sequences AS
 SELECT relid,
    schemaname,
    relname,
    blks_read,
    blks_hit
   FROM pg_statio_all_sequences
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_sys_sequences OWNER TO postgres;

--
-- Name: pg_statio_sys_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_sys_tables AS
 SELECT relid,
    schemaname,
    relname,
    heap_blks_read,
    heap_blks_hit,
    idx_blks_read,
    idx_blks_hit,
    toast_blks_read,
    toast_blks_hit,
    tidx_blks_read,
    tidx_blks_hit
   FROM pg_statio_all_tables
  WHERE ((schemaname = ANY (ARRAY['pg_catalog'::name, 'information_schema'::name])) OR (schemaname ~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_sys_tables OWNER TO postgres;

--
-- Name: pg_statio_user_indexes; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_user_indexes AS
 SELECT relid,
    indexrelid,
    schemaname,
    relname,
    indexrelname,
    idx_blks_read,
    idx_blks_hit
   FROM pg_statio_all_indexes
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_user_indexes OWNER TO postgres;

--
-- Name: pg_statio_user_sequences; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_user_sequences AS
 SELECT relid,
    schemaname,
    relname,
    blks_read,
    blks_hit
   FROM pg_statio_all_sequences
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_user_sequences OWNER TO postgres;

--
-- Name: pg_statio_user_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_statio_user_tables AS
 SELECT relid,
    schemaname,
    relname,
    heap_blks_read,
    heap_blks_hit,
    idx_blks_read,
    idx_blks_hit,
    toast_blks_read,
    toast_blks_hit,
    tidx_blks_read,
    tidx_blks_hit
   FROM pg_statio_all_tables
  WHERE ((schemaname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (schemaname !~ '^pg_toast'::text));


ALTER VIEW pg_catalog.pg_statio_user_tables OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_statistic; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_statistic (
    starelid oid NOT NULL,
    staattnum smallint NOT NULL,
    stainherit boolean NOT NULL,
    stanullfrac real NOT NULL,
    stawidth integer NOT NULL,
    stadistinct real NOT NULL,
    stakind1 smallint NOT NULL,
    stakind2 smallint NOT NULL,
    stakind3 smallint NOT NULL,
    stakind4 smallint NOT NULL,
    stakind5 smallint NOT NULL,
    staop1 oid NOT NULL,
    staop2 oid NOT NULL,
    staop3 oid NOT NULL,
    staop4 oid NOT NULL,
    staop5 oid NOT NULL,
    stacoll1 oid NOT NULL,
    stacoll2 oid NOT NULL,
    stacoll3 oid NOT NULL,
    stacoll4 oid NOT NULL,
    stacoll5 oid NOT NULL,
    stanumbers1 real[],
    stanumbers2 real[],
    stanumbers3 real[],
    stanumbers4 real[],
    stanumbers5 real[],
    stavalues1 anyarray,
    stavalues2 anyarray,
    stavalues3 anyarray,
    stavalues4 anyarray,
    stavalues5 anyarray
);

ALTER TABLE ONLY pg_catalog.pg_statistic REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_statistic OWNER TO postgres;

--
-- Name: pg_statistic_ext; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_statistic_ext (
    oid oid NOT NULL,
    stxrelid oid NOT NULL,
    stxname name NOT NULL,
    stxnamespace oid NOT NULL,
    stxowner oid NOT NULL,
    stxstattarget integer NOT NULL,
    stxkeys int2vector NOT NULL,
    stxkind "char"[] NOT NULL,
    stxexprs pg_node_tree COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_statistic_ext REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_statistic_ext OWNER TO postgres;

--
-- Name: pg_statistic_ext_data; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_statistic_ext_data (
    stxoid oid NOT NULL,
    stxdinherit boolean NOT NULL,
    stxdndistinct pg_ndistinct COLLATE pg_catalog."C",
    stxddependencies pg_dependencies COLLATE pg_catalog."C",
    stxdmcv pg_mcv_list COLLATE pg_catalog."C",
    stxdexpr pg_statistic[]
);

ALTER TABLE ONLY pg_catalog.pg_statistic_ext_data REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_statistic_ext_data OWNER TO postgres;

--
-- Name: pg_stats; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stats WITH (security_barrier='true') AS
 SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    a.attname,
    s.stainherit AS inherited,
    s.stanullfrac AS null_frac,
    s.stawidth AS avg_width,
    s.stadistinct AS n_distinct,
        CASE
            WHEN (s.stakind1 = 1) THEN s.stavalues1
            WHEN (s.stakind2 = 1) THEN s.stavalues2
            WHEN (s.stakind3 = 1) THEN s.stavalues3
            WHEN (s.stakind4 = 1) THEN s.stavalues4
            WHEN (s.stakind5 = 1) THEN s.stavalues5
            ELSE NULL::anyarray
        END AS most_common_vals,
        CASE
            WHEN (s.stakind1 = 1) THEN s.stanumbers1
            WHEN (s.stakind2 = 1) THEN s.stanumbers2
            WHEN (s.stakind3 = 1) THEN s.stanumbers3
            WHEN (s.stakind4 = 1) THEN s.stanumbers4
            WHEN (s.stakind5 = 1) THEN s.stanumbers5
            ELSE NULL::real[]
        END AS most_common_freqs,
        CASE
            WHEN (s.stakind1 = 2) THEN s.stavalues1
            WHEN (s.stakind2 = 2) THEN s.stavalues2
            WHEN (s.stakind3 = 2) THEN s.stavalues3
            WHEN (s.stakind4 = 2) THEN s.stavalues4
            WHEN (s.stakind5 = 2) THEN s.stavalues5
            ELSE NULL::anyarray
        END AS histogram_bounds,
        CASE
            WHEN (s.stakind1 = 3) THEN s.stanumbers1[1]
            WHEN (s.stakind2 = 3) THEN s.stanumbers2[1]
            WHEN (s.stakind3 = 3) THEN s.stanumbers3[1]
            WHEN (s.stakind4 = 3) THEN s.stanumbers4[1]
            WHEN (s.stakind5 = 3) THEN s.stanumbers5[1]
            ELSE NULL::real
        END AS correlation,
        CASE
            WHEN (s.stakind1 = 4) THEN s.stavalues1
            WHEN (s.stakind2 = 4) THEN s.stavalues2
            WHEN (s.stakind3 = 4) THEN s.stavalues3
            WHEN (s.stakind4 = 4) THEN s.stavalues4
            WHEN (s.stakind5 = 4) THEN s.stavalues5
            ELSE NULL::anyarray
        END AS most_common_elems,
        CASE
            WHEN (s.stakind1 = 4) THEN s.stanumbers1
            WHEN (s.stakind2 = 4) THEN s.stanumbers2
            WHEN (s.stakind3 = 4) THEN s.stanumbers3
            WHEN (s.stakind4 = 4) THEN s.stanumbers4
            WHEN (s.stakind5 = 4) THEN s.stanumbers5
            ELSE NULL::real[]
        END AS most_common_elem_freqs,
        CASE
            WHEN (s.stakind1 = 5) THEN s.stanumbers1
            WHEN (s.stakind2 = 5) THEN s.stanumbers2
            WHEN (s.stakind3 = 5) THEN s.stanumbers3
            WHEN (s.stakind4 = 5) THEN s.stanumbers4
            WHEN (s.stakind5 = 5) THEN s.stanumbers5
            ELSE NULL::real[]
        END AS elem_count_histogram
   FROM (((pg_statistic s
     JOIN pg_class c ON ((c.oid = s.starelid)))
     JOIN pg_attribute a ON (((c.oid = a.attrelid) AND (a.attnum = s.staattnum))))
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE ((NOT a.attisdropped) AND has_column_privilege(c.oid, a.attnum, 'select'::text) AND ((c.relrowsecurity = false) OR (NOT row_security_active(c.oid))));


ALTER VIEW pg_catalog.pg_stats OWNER TO postgres;

--
-- Name: pg_stats_ext; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stats_ext WITH (security_barrier='true') AS
 SELECT cn.nspname AS schemaname,
    c.relname AS tablename,
    sn.nspname AS statistics_schemaname,
    s.stxname AS statistics_name,
    pg_get_userbyid(s.stxowner) AS statistics_owner,
    ( SELECT array_agg(a.attname ORDER BY a.attnum) AS array_agg
           FROM (unnest(s.stxkeys) k(k)
             JOIN pg_attribute a ON (((a.attrelid = s.stxrelid) AND (a.attnum = k.k))))) AS attnames,
    pg_get_statisticsobjdef_expressions(s.oid) AS exprs,
    s.stxkind AS kinds,
    sd.stxdinherit AS inherited,
    sd.stxdndistinct AS n_distinct,
    sd.stxddependencies AS dependencies,
    m.most_common_vals,
    m.most_common_val_nulls,
    m.most_common_freqs,
    m.most_common_base_freqs
   FROM (((((pg_statistic_ext s
     JOIN pg_class c ON ((c.oid = s.stxrelid)))
     JOIN pg_statistic_ext_data sd ON ((s.oid = sd.stxoid)))
     LEFT JOIN pg_namespace cn ON ((cn.oid = c.relnamespace)))
     LEFT JOIN pg_namespace sn ON ((sn.oid = s.stxnamespace)))
     LEFT JOIN LATERAL ( SELECT array_agg(pg_mcv_list_items."values") AS most_common_vals,
            array_agg(pg_mcv_list_items.nulls) AS most_common_val_nulls,
            array_agg(pg_mcv_list_items.frequency) AS most_common_freqs,
            array_agg(pg_mcv_list_items.base_frequency) AS most_common_base_freqs
           FROM pg_mcv_list_items(sd.stxdmcv) pg_mcv_list_items(index, "values", nulls, frequency, base_frequency)) m ON ((sd.stxdmcv IS NOT NULL)))
  WHERE ((NOT (EXISTS ( SELECT 1
           FROM (unnest(s.stxkeys) k(k)
             JOIN pg_attribute a ON (((a.attrelid = s.stxrelid) AND (a.attnum = k.k))))
          WHERE (NOT has_column_privilege(c.oid, a.attnum, 'select'::text))))) AND ((c.relrowsecurity = false) OR (NOT row_security_active(c.oid))));


ALTER VIEW pg_catalog.pg_stats_ext OWNER TO postgres;

--
-- Name: pg_stats_ext_exprs; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_stats_ext_exprs WITH (security_barrier='true') AS
 SELECT cn.nspname AS schemaname,
    c.relname AS tablename,
    sn.nspname AS statistics_schemaname,
    s.stxname AS statistics_name,
    pg_get_userbyid(s.stxowner) AS statistics_owner,
    stat.expr,
    sd.stxdinherit AS inherited,
    (stat.a).stanullfrac AS null_frac,
    (stat.a).stawidth AS avg_width,
    (stat.a).stadistinct AS n_distinct,
        CASE
            WHEN ((stat.a).stakind1 = 1) THEN (stat.a).stavalues1
            WHEN ((stat.a).stakind2 = 1) THEN (stat.a).stavalues2
            WHEN ((stat.a).stakind3 = 1) THEN (stat.a).stavalues3
            WHEN ((stat.a).stakind4 = 1) THEN (stat.a).stavalues4
            WHEN ((stat.a).stakind5 = 1) THEN (stat.a).stavalues5
            ELSE NULL::anyarray
        END AS most_common_vals,
        CASE
            WHEN ((stat.a).stakind1 = 1) THEN (stat.a).stanumbers1
            WHEN ((stat.a).stakind2 = 1) THEN (stat.a).stanumbers2
            WHEN ((stat.a).stakind3 = 1) THEN (stat.a).stanumbers3
            WHEN ((stat.a).stakind4 = 1) THEN (stat.a).stanumbers4
            WHEN ((stat.a).stakind5 = 1) THEN (stat.a).stanumbers5
            ELSE NULL::real[]
        END AS most_common_freqs,
        CASE
            WHEN ((stat.a).stakind1 = 2) THEN (stat.a).stavalues1
            WHEN ((stat.a).stakind2 = 2) THEN (stat.a).stavalues2
            WHEN ((stat.a).stakind3 = 2) THEN (stat.a).stavalues3
            WHEN ((stat.a).stakind4 = 2) THEN (stat.a).stavalues4
            WHEN ((stat.a).stakind5 = 2) THEN (stat.a).stavalues5
            ELSE NULL::anyarray
        END AS histogram_bounds,
        CASE
            WHEN ((stat.a).stakind1 = 3) THEN (stat.a).stanumbers1[1]
            WHEN ((stat.a).stakind2 = 3) THEN (stat.a).stanumbers2[1]
            WHEN ((stat.a).stakind3 = 3) THEN (stat.a).stanumbers3[1]
            WHEN ((stat.a).stakind4 = 3) THEN (stat.a).stanumbers4[1]
            WHEN ((stat.a).stakind5 = 3) THEN (stat.a).stanumbers5[1]
            ELSE NULL::real
        END AS correlation,
        CASE
            WHEN ((stat.a).stakind1 = 4) THEN (stat.a).stavalues1
            WHEN ((stat.a).stakind2 = 4) THEN (stat.a).stavalues2
            WHEN ((stat.a).stakind3 = 4) THEN (stat.a).stavalues3
            WHEN ((stat.a).stakind4 = 4) THEN (stat.a).stavalues4
            WHEN ((stat.a).stakind5 = 4) THEN (stat.a).stavalues5
            ELSE NULL::anyarray
        END AS most_common_elems,
        CASE
            WHEN ((stat.a).stakind1 = 4) THEN (stat.a).stanumbers1
            WHEN ((stat.a).stakind2 = 4) THEN (stat.a).stanumbers2
            WHEN ((stat.a).stakind3 = 4) THEN (stat.a).stanumbers3
            WHEN ((stat.a).stakind4 = 4) THEN (stat.a).stanumbers4
            WHEN ((stat.a).stakind5 = 4) THEN (stat.a).stanumbers5
            ELSE NULL::real[]
        END AS most_common_elem_freqs,
        CASE
            WHEN ((stat.a).stakind1 = 5) THEN (stat.a).stanumbers1
            WHEN ((stat.a).stakind2 = 5) THEN (stat.a).stanumbers2
            WHEN ((stat.a).stakind3 = 5) THEN (stat.a).stanumbers3
            WHEN ((stat.a).stakind4 = 5) THEN (stat.a).stanumbers4
            WHEN ((stat.a).stakind5 = 5) THEN (stat.a).stanumbers5
            ELSE NULL::real[]
        END AS elem_count_histogram
   FROM (((((pg_statistic_ext s
     JOIN pg_class c ON ((c.oid = s.stxrelid)))
     LEFT JOIN pg_statistic_ext_data sd ON ((s.oid = sd.stxoid)))
     LEFT JOIN pg_namespace cn ON ((cn.oid = c.relnamespace)))
     LEFT JOIN pg_namespace sn ON ((sn.oid = s.stxnamespace)))
     JOIN LATERAL ( SELECT unnest(pg_get_statisticsobjdef_expressions(s.oid)) AS expr,
            unnest(sd.stxdexpr) AS a) stat ON ((stat.expr IS NOT NULL)));


ALTER VIEW pg_catalog.pg_stats_ext_exprs OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_subscription; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_subscription (
    oid oid NOT NULL,
    subdbid oid NOT NULL,
    subskiplsn pg_lsn NOT NULL,
    subname name NOT NULL,
    subowner oid NOT NULL,
    subenabled boolean NOT NULL,
    subbinary boolean NOT NULL,
    substream "char" NOT NULL,
    subtwophasestate "char" NOT NULL,
    subdisableonerr boolean NOT NULL,
    subpasswordrequired boolean NOT NULL,
    subrunasowner boolean NOT NULL,
    subconninfo text NOT NULL COLLATE pg_catalog."C",
    subslotname name,
    subsynccommit text NOT NULL COLLATE pg_catalog."C",
    subpublications text[] NOT NULL COLLATE pg_catalog."C",
    suborigin text COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_subscription REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_subscription OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_subscription_rel; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_subscription_rel (
    srsubid oid NOT NULL,
    srrelid oid NOT NULL,
    srsubstate "char" NOT NULL,
    srsublsn pg_lsn
);

ALTER TABLE ONLY pg_catalog.pg_subscription_rel REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_subscription_rel OWNER TO postgres;

--
-- Name: pg_tables; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_tables AS
 SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    pg_get_userbyid(c.relowner) AS tableowner,
    t.spcname AS tablespace,
    c.relhasindex AS hasindexes,
    c.relhasrules AS hasrules,
    c.relhastriggers AS hastriggers,
    c.relrowsecurity AS rowsecurity
   FROM ((pg_class c
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
     LEFT JOIN pg_tablespace t ON ((t.oid = c.reltablespace)))
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"]));


ALTER VIEW pg_catalog.pg_tables OWNER TO postgres;

SET default_tablespace = pg_global;

--
-- Name: pg_tablespace; Type: TABLE; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE TABLE pg_catalog.pg_tablespace (
    oid oid NOT NULL,
    spcname name NOT NULL,
    spcowner oid NOT NULL,
    spcacl aclitem[],
    spcoptions text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_tablespace REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_tablespace OWNER TO postgres;

--
-- Name: pg_timezone_abbrevs; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_timezone_abbrevs AS
 SELECT abbrev,
    utc_offset,
    is_dst
   FROM pg_timezone_abbrevs() pg_timezone_abbrevs(abbrev, utc_offset, is_dst);


ALTER VIEW pg_catalog.pg_timezone_abbrevs OWNER TO postgres;

--
-- Name: pg_timezone_names; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_timezone_names AS
 SELECT name,
    abbrev,
    utc_offset,
    is_dst
   FROM pg_timezone_names() pg_timezone_names(name, abbrev, utc_offset, is_dst);


ALTER VIEW pg_catalog.pg_timezone_names OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: pg_transform; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_transform (
    oid oid NOT NULL,
    trftype oid NOT NULL,
    trflang oid NOT NULL,
    trffromsql regproc NOT NULL,
    trftosql regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_transform REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_transform OWNER TO postgres;

--
-- Name: pg_trigger; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_trigger (
    oid oid NOT NULL,
    tgrelid oid NOT NULL,
    tgparentid oid NOT NULL,
    tgname name NOT NULL,
    tgfoid oid NOT NULL,
    tgtype smallint NOT NULL,
    tgenabled "char" NOT NULL,
    tgisinternal boolean NOT NULL,
    tgconstrrelid oid NOT NULL,
    tgconstrindid oid NOT NULL,
    tgconstraint oid NOT NULL,
    tgdeferrable boolean NOT NULL,
    tginitdeferred boolean NOT NULL,
    tgnargs smallint NOT NULL,
    tgattr int2vector NOT NULL,
    tgargs bytea NOT NULL,
    tgqual pg_node_tree COLLATE pg_catalog."C",
    tgoldtable name,
    tgnewtable name
);

ALTER TABLE ONLY pg_catalog.pg_trigger REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_trigger OWNER TO postgres;

--
-- Name: pg_ts_config; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_ts_config (
    oid oid NOT NULL,
    cfgname name NOT NULL,
    cfgnamespace oid NOT NULL,
    cfgowner oid NOT NULL,
    cfgparser oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_ts_config REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_ts_config OWNER TO postgres;

--
-- Name: pg_ts_config_map; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_ts_config_map (
    mapcfg oid NOT NULL,
    maptokentype integer NOT NULL,
    mapseqno integer NOT NULL,
    mapdict oid NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_ts_config_map REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_ts_config_map OWNER TO postgres;

--
-- Name: pg_ts_dict; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_ts_dict (
    oid oid NOT NULL,
    dictname name NOT NULL,
    dictnamespace oid NOT NULL,
    dictowner oid NOT NULL,
    dicttemplate oid NOT NULL,
    dictinitoption text COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_ts_dict REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_ts_dict OWNER TO postgres;

--
-- Name: pg_ts_parser; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_ts_parser (
    oid oid NOT NULL,
    prsname name NOT NULL,
    prsnamespace oid NOT NULL,
    prsstart regproc NOT NULL,
    prstoken regproc NOT NULL,
    prsend regproc NOT NULL,
    prsheadline regproc NOT NULL,
    prslextype regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_ts_parser REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_ts_parser OWNER TO postgres;

--
-- Name: pg_ts_template; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_ts_template (
    oid oid NOT NULL,
    tmplname name NOT NULL,
    tmplnamespace oid NOT NULL,
    tmplinit regproc NOT NULL,
    tmpllexize regproc NOT NULL
);

ALTER TABLE ONLY pg_catalog.pg_ts_template REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_ts_template OWNER TO postgres;

--
-- Name: pg_type; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_type (
    oid oid NOT NULL,
    typname name NOT NULL,
    typnamespace oid NOT NULL,
    typowner oid NOT NULL,
    typlen smallint NOT NULL,
    typbyval boolean NOT NULL,
    typtype "char" NOT NULL,
    typcategory "char" NOT NULL,
    typispreferred boolean NOT NULL,
    typisdefined boolean NOT NULL,
    typdelim "char" NOT NULL,
    typrelid oid NOT NULL,
    typsubscript regproc NOT NULL,
    typelem oid NOT NULL,
    typarray oid NOT NULL,
    typinput regproc NOT NULL,
    typoutput regproc NOT NULL,
    typreceive regproc NOT NULL,
    typsend regproc NOT NULL,
    typmodin regproc NOT NULL,
    typmodout regproc NOT NULL,
    typanalyze regproc NOT NULL,
    typalign "char" NOT NULL,
    typstorage "char" NOT NULL,
    typnotnull boolean NOT NULL,
    typbasetype oid NOT NULL,
    typtypmod integer NOT NULL,
    typndims integer NOT NULL,
    typcollation oid NOT NULL,
    typdefaultbin pg_node_tree COLLATE pg_catalog."C",
    typdefault text COLLATE pg_catalog."C",
    typacl aclitem[]
);

ALTER TABLE ONLY pg_catalog.pg_type REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_type OWNER TO postgres;

--
-- Name: pg_user; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_user AS
 SELECT usename,
    usesysid,
    usecreatedb,
    usesuper,
    userepl,
    usebypassrls,
    '********'::text AS passwd,
    valuntil,
    useconfig
   FROM pg_shadow;


ALTER VIEW pg_catalog.pg_user OWNER TO postgres;

--
-- Name: pg_user_mapping; Type: TABLE; Schema: pg_catalog; Owner: postgres
--

CREATE TABLE pg_catalog.pg_user_mapping (
    oid oid NOT NULL,
    umuser oid NOT NULL,
    umserver oid NOT NULL,
    umoptions text[] COLLATE pg_catalog."C"
);

ALTER TABLE ONLY pg_catalog.pg_user_mapping REPLICA IDENTITY NOTHING;


ALTER TABLE pg_catalog.pg_user_mapping OWNER TO postgres;

--
-- Name: pg_user_mappings; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_user_mappings AS
 SELECT u.oid AS umid,
    s.oid AS srvid,
    s.srvname,
    u.umuser,
        CASE
            WHEN (u.umuser = (0)::oid) THEN 'public'::name
            ELSE a.rolname
        END AS usename,
        CASE
            WHEN (((u.umuser <> (0)::oid) AND (a.rolname = CURRENT_USER) AND (pg_has_role(s.srvowner, 'USAGE'::text) OR has_server_privilege(s.oid, 'USAGE'::text))) OR ((u.umuser = (0)::oid) AND pg_has_role(s.srvowner, 'USAGE'::text)) OR ( SELECT pg_authid.rolsuper
               FROM pg_authid
              WHERE (pg_authid.rolname = CURRENT_USER))) THEN u.umoptions
            ELSE NULL::text[]
        END AS umoptions
   FROM ((pg_user_mapping u
     JOIN pg_foreign_server s ON ((u.umserver = s.oid)))
     LEFT JOIN pg_authid a ON ((a.oid = u.umuser)));


ALTER VIEW pg_catalog.pg_user_mappings OWNER TO postgres;

--
-- Name: pg_views; Type: VIEW; Schema: pg_catalog; Owner: postgres
--

CREATE VIEW pg_catalog.pg_views AS
 SELECT n.nspname AS schemaname,
    c.relname AS viewname,
    pg_get_userbyid(c.relowner) AS viewowner,
    pg_get_viewdef(c.oid) AS definition
   FROM (pg_class c
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (c.relkind = 'v'::"char");


ALTER VIEW pg_catalog.pg_views OWNER TO postgres;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "bookId" integer NOT NULL,
    "borrowedAt" timestamp with time zone NOT NULL,
    "returnedAt" timestamp with time zone,
    score double precision,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
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
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: pg_aggregate pg_aggregate_fnoid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_aggregate
    ADD CONSTRAINT pg_aggregate_fnoid_index PRIMARY KEY (aggfnoid);


--
-- Name: pg_am pg_am_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_am
    ADD CONSTRAINT pg_am_name_index UNIQUE (amname);


--
-- Name: pg_am pg_am_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_am
    ADD CONSTRAINT pg_am_oid_index PRIMARY KEY (oid);


--
-- Name: pg_amop pg_amop_fam_strat_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_amop
    ADD CONSTRAINT pg_amop_fam_strat_index UNIQUE (amopfamily, amoplefttype, amoprighttype, amopstrategy);


--
-- Name: pg_amop pg_amop_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_amop
    ADD CONSTRAINT pg_amop_oid_index PRIMARY KEY (oid);


--
-- Name: pg_amop pg_amop_opr_fam_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_amop
    ADD CONSTRAINT pg_amop_opr_fam_index UNIQUE (amopopr, amoppurpose, amopfamily);


--
-- Name: pg_amproc pg_amproc_fam_proc_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_amproc
    ADD CONSTRAINT pg_amproc_fam_proc_index UNIQUE (amprocfamily, amproclefttype, amprocrighttype, amprocnum);


--
-- Name: pg_amproc pg_amproc_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_amproc
    ADD CONSTRAINT pg_amproc_oid_index PRIMARY KEY (oid);


--
-- Name: pg_attrdef pg_attrdef_adrelid_adnum_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_attrdef
    ADD CONSTRAINT pg_attrdef_adrelid_adnum_index UNIQUE (adrelid, adnum);


--
-- Name: pg_attrdef pg_attrdef_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_attrdef
    ADD CONSTRAINT pg_attrdef_oid_index PRIMARY KEY (oid);


--
-- Name: pg_attribute pg_attribute_relid_attnam_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_attribute
    ADD CONSTRAINT pg_attribute_relid_attnam_index UNIQUE (attrelid, attname);


--
-- Name: pg_attribute pg_attribute_relid_attnum_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_attribute
    ADD CONSTRAINT pg_attribute_relid_attnum_index PRIMARY KEY (attrelid, attnum);


SET default_tablespace = pg_global;

--
-- Name: pg_auth_members pg_auth_members_member_role_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_auth_members
    ADD CONSTRAINT pg_auth_members_member_role_index UNIQUE (member, roleid, grantor);


--
-- Name: pg_auth_members pg_auth_members_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_auth_members
    ADD CONSTRAINT pg_auth_members_oid_index PRIMARY KEY (oid);


--
-- Name: pg_auth_members pg_auth_members_role_member_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_auth_members
    ADD CONSTRAINT pg_auth_members_role_member_index UNIQUE (roleid, member, grantor);


--
-- Name: pg_authid pg_authid_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_authid
    ADD CONSTRAINT pg_authid_oid_index PRIMARY KEY (oid);


--
-- Name: pg_authid pg_authid_rolname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_authid
    ADD CONSTRAINT pg_authid_rolname_index UNIQUE (rolname);


SET default_tablespace = '';

--
-- Name: pg_cast pg_cast_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_cast
    ADD CONSTRAINT pg_cast_oid_index PRIMARY KEY (oid);


--
-- Name: pg_cast pg_cast_source_target_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_cast
    ADD CONSTRAINT pg_cast_source_target_index UNIQUE (castsource, casttarget);


--
-- Name: pg_class pg_class_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_class
    ADD CONSTRAINT pg_class_oid_index PRIMARY KEY (oid);


--
-- Name: pg_class pg_class_relname_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_class
    ADD CONSTRAINT pg_class_relname_nsp_index UNIQUE (relname, relnamespace);


--
-- Name: pg_collation pg_collation_name_enc_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_collation
    ADD CONSTRAINT pg_collation_name_enc_nsp_index UNIQUE (collname, collencoding, collnamespace);


--
-- Name: pg_collation pg_collation_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_collation
    ADD CONSTRAINT pg_collation_oid_index PRIMARY KEY (oid);


--
-- Name: pg_constraint pg_constraint_conrelid_contypid_conname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_constraint
    ADD CONSTRAINT pg_constraint_conrelid_contypid_conname_index UNIQUE (conrelid, contypid, conname);


--
-- Name: pg_constraint pg_constraint_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_constraint
    ADD CONSTRAINT pg_constraint_oid_index PRIMARY KEY (oid);


--
-- Name: pg_conversion pg_conversion_default_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_conversion
    ADD CONSTRAINT pg_conversion_default_index UNIQUE (connamespace, conforencoding, contoencoding, oid);


--
-- Name: pg_conversion pg_conversion_name_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_conversion
    ADD CONSTRAINT pg_conversion_name_nsp_index UNIQUE (conname, connamespace);


--
-- Name: pg_conversion pg_conversion_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_conversion
    ADD CONSTRAINT pg_conversion_oid_index PRIMARY KEY (oid);


SET default_tablespace = pg_global;

--
-- Name: pg_database pg_database_datname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_database
    ADD CONSTRAINT pg_database_datname_index UNIQUE (datname);


--
-- Name: pg_database pg_database_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_database
    ADD CONSTRAINT pg_database_oid_index PRIMARY KEY (oid);


--
-- Name: pg_db_role_setting pg_db_role_setting_databaseid_rol_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_db_role_setting
    ADD CONSTRAINT pg_db_role_setting_databaseid_rol_index PRIMARY KEY (setdatabase, setrole);


SET default_tablespace = '';

--
-- Name: pg_default_acl pg_default_acl_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_default_acl
    ADD CONSTRAINT pg_default_acl_oid_index PRIMARY KEY (oid);


--
-- Name: pg_default_acl pg_default_acl_role_nsp_obj_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_default_acl
    ADD CONSTRAINT pg_default_acl_role_nsp_obj_index UNIQUE (defaclrole, defaclnamespace, defaclobjtype);


--
-- Name: pg_description pg_description_o_c_o_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_description
    ADD CONSTRAINT pg_description_o_c_o_index PRIMARY KEY (objoid, classoid, objsubid);


--
-- Name: pg_enum pg_enum_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_enum
    ADD CONSTRAINT pg_enum_oid_index PRIMARY KEY (oid);


--
-- Name: pg_enum pg_enum_typid_label_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_enum
    ADD CONSTRAINT pg_enum_typid_label_index UNIQUE (enumtypid, enumlabel);


--
-- Name: pg_enum pg_enum_typid_sortorder_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_enum
    ADD CONSTRAINT pg_enum_typid_sortorder_index UNIQUE (enumtypid, enumsortorder);


--
-- Name: pg_event_trigger pg_event_trigger_evtname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_event_trigger
    ADD CONSTRAINT pg_event_trigger_evtname_index UNIQUE (evtname);


--
-- Name: pg_event_trigger pg_event_trigger_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_event_trigger
    ADD CONSTRAINT pg_event_trigger_oid_index PRIMARY KEY (oid);


--
-- Name: pg_extension pg_extension_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_extension
    ADD CONSTRAINT pg_extension_name_index UNIQUE (extname);


--
-- Name: pg_extension pg_extension_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_extension
    ADD CONSTRAINT pg_extension_oid_index PRIMARY KEY (oid);


--
-- Name: pg_foreign_data_wrapper pg_foreign_data_wrapper_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_foreign_data_wrapper
    ADD CONSTRAINT pg_foreign_data_wrapper_name_index UNIQUE (fdwname);


--
-- Name: pg_foreign_data_wrapper pg_foreign_data_wrapper_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_foreign_data_wrapper
    ADD CONSTRAINT pg_foreign_data_wrapper_oid_index PRIMARY KEY (oid);


--
-- Name: pg_foreign_server pg_foreign_server_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_foreign_server
    ADD CONSTRAINT pg_foreign_server_name_index UNIQUE (srvname);


--
-- Name: pg_foreign_server pg_foreign_server_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_foreign_server
    ADD CONSTRAINT pg_foreign_server_oid_index PRIMARY KEY (oid);


--
-- Name: pg_foreign_table pg_foreign_table_relid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_foreign_table
    ADD CONSTRAINT pg_foreign_table_relid_index PRIMARY KEY (ftrelid);


--
-- Name: pg_index pg_index_indexrelid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_index
    ADD CONSTRAINT pg_index_indexrelid_index PRIMARY KEY (indexrelid);


--
-- Name: pg_inherits pg_inherits_relid_seqno_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_inherits
    ADD CONSTRAINT pg_inherits_relid_seqno_index PRIMARY KEY (inhrelid, inhseqno);


--
-- Name: pg_init_privs pg_init_privs_o_c_o_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_init_privs
    ADD CONSTRAINT pg_init_privs_o_c_o_index PRIMARY KEY (objoid, classoid, objsubid);


--
-- Name: pg_language pg_language_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_language
    ADD CONSTRAINT pg_language_name_index UNIQUE (lanname);


--
-- Name: pg_language pg_language_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_language
    ADD CONSTRAINT pg_language_oid_index PRIMARY KEY (oid);


--
-- Name: pg_largeobject pg_largeobject_loid_pn_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_largeobject
    ADD CONSTRAINT pg_largeobject_loid_pn_index PRIMARY KEY (loid, pageno);


--
-- Name: pg_largeobject_metadata pg_largeobject_metadata_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_largeobject_metadata
    ADD CONSTRAINT pg_largeobject_metadata_oid_index PRIMARY KEY (oid);


--
-- Name: pg_namespace pg_namespace_nspname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_namespace
    ADD CONSTRAINT pg_namespace_nspname_index UNIQUE (nspname);


--
-- Name: pg_namespace pg_namespace_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_namespace
    ADD CONSTRAINT pg_namespace_oid_index PRIMARY KEY (oid);


--
-- Name: pg_opclass pg_opclass_am_name_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_opclass
    ADD CONSTRAINT pg_opclass_am_name_nsp_index UNIQUE (opcmethod, opcname, opcnamespace);


--
-- Name: pg_opclass pg_opclass_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_opclass
    ADD CONSTRAINT pg_opclass_oid_index PRIMARY KEY (oid);


--
-- Name: pg_operator pg_operator_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_operator
    ADD CONSTRAINT pg_operator_oid_index PRIMARY KEY (oid);


--
-- Name: pg_operator pg_operator_oprname_l_r_n_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_operator
    ADD CONSTRAINT pg_operator_oprname_l_r_n_index UNIQUE (oprname, oprleft, oprright, oprnamespace);


--
-- Name: pg_opfamily pg_opfamily_am_name_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_opfamily
    ADD CONSTRAINT pg_opfamily_am_name_nsp_index UNIQUE (opfmethod, opfname, opfnamespace);


--
-- Name: pg_opfamily pg_opfamily_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_opfamily
    ADD CONSTRAINT pg_opfamily_oid_index PRIMARY KEY (oid);


SET default_tablespace = pg_global;

--
-- Name: pg_parameter_acl pg_parameter_acl_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_parameter_acl
    ADD CONSTRAINT pg_parameter_acl_oid_index PRIMARY KEY (oid);


--
-- Name: pg_parameter_acl pg_parameter_acl_parname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_parameter_acl
    ADD CONSTRAINT pg_parameter_acl_parname_index UNIQUE (parname);


SET default_tablespace = '';

--
-- Name: pg_partitioned_table pg_partitioned_table_partrelid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_partitioned_table
    ADD CONSTRAINT pg_partitioned_table_partrelid_index PRIMARY KEY (partrelid);


--
-- Name: pg_policy pg_policy_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_policy
    ADD CONSTRAINT pg_policy_oid_index PRIMARY KEY (oid);


--
-- Name: pg_policy pg_policy_polrelid_polname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_policy
    ADD CONSTRAINT pg_policy_polrelid_polname_index UNIQUE (polrelid, polname);


--
-- Name: pg_proc pg_proc_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_proc
    ADD CONSTRAINT pg_proc_oid_index PRIMARY KEY (oid);


--
-- Name: pg_proc pg_proc_proname_args_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_proc
    ADD CONSTRAINT pg_proc_proname_args_nsp_index UNIQUE (proname, proargtypes, pronamespace);


--
-- Name: pg_publication_namespace pg_publication_namespace_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication_namespace
    ADD CONSTRAINT pg_publication_namespace_oid_index PRIMARY KEY (oid);


--
-- Name: pg_publication_namespace pg_publication_namespace_pnnspid_pnpubid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication_namespace
    ADD CONSTRAINT pg_publication_namespace_pnnspid_pnpubid_index UNIQUE (pnnspid, pnpubid);


--
-- Name: pg_publication pg_publication_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication
    ADD CONSTRAINT pg_publication_oid_index PRIMARY KEY (oid);


--
-- Name: pg_publication pg_publication_pubname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication
    ADD CONSTRAINT pg_publication_pubname_index UNIQUE (pubname);


--
-- Name: pg_publication_rel pg_publication_rel_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication_rel
    ADD CONSTRAINT pg_publication_rel_oid_index PRIMARY KEY (oid);


--
-- Name: pg_publication_rel pg_publication_rel_prrelid_prpubid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_publication_rel
    ADD CONSTRAINT pg_publication_rel_prrelid_prpubid_index UNIQUE (prrelid, prpubid);


--
-- Name: pg_range pg_range_rngmultitypid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_range
    ADD CONSTRAINT pg_range_rngmultitypid_index UNIQUE (rngmultitypid);


--
-- Name: pg_range pg_range_rngtypid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_range
    ADD CONSTRAINT pg_range_rngtypid_index PRIMARY KEY (rngtypid);


SET default_tablespace = pg_global;

--
-- Name: pg_replication_origin pg_replication_origin_roiident_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_replication_origin
    ADD CONSTRAINT pg_replication_origin_roiident_index PRIMARY KEY (roident);


--
-- Name: pg_replication_origin pg_replication_origin_roname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_replication_origin
    ADD CONSTRAINT pg_replication_origin_roname_index UNIQUE (roname);


SET default_tablespace = '';

--
-- Name: pg_rewrite pg_rewrite_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_rewrite
    ADD CONSTRAINT pg_rewrite_oid_index PRIMARY KEY (oid);


--
-- Name: pg_rewrite pg_rewrite_rel_rulename_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_rewrite
    ADD CONSTRAINT pg_rewrite_rel_rulename_index UNIQUE (ev_class, rulename);


--
-- Name: pg_seclabel pg_seclabel_object_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_seclabel
    ADD CONSTRAINT pg_seclabel_object_index PRIMARY KEY (objoid, classoid, objsubid, provider);


--
-- Name: pg_sequence pg_sequence_seqrelid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_sequence
    ADD CONSTRAINT pg_sequence_seqrelid_index PRIMARY KEY (seqrelid);


SET default_tablespace = pg_global;

--
-- Name: pg_shdescription pg_shdescription_o_c_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_shdescription
    ADD CONSTRAINT pg_shdescription_o_c_index PRIMARY KEY (objoid, classoid);


--
-- Name: pg_shseclabel pg_shseclabel_object_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_shseclabel
    ADD CONSTRAINT pg_shseclabel_object_index PRIMARY KEY (objoid, classoid, provider);


SET default_tablespace = '';

--
-- Name: pg_statistic_ext_data pg_statistic_ext_data_stxoid_inh_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_statistic_ext_data
    ADD CONSTRAINT pg_statistic_ext_data_stxoid_inh_index PRIMARY KEY (stxoid, stxdinherit);


--
-- Name: pg_statistic_ext pg_statistic_ext_name_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_statistic_ext
    ADD CONSTRAINT pg_statistic_ext_name_index UNIQUE (stxname, stxnamespace);


--
-- Name: pg_statistic_ext pg_statistic_ext_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_statistic_ext
    ADD CONSTRAINT pg_statistic_ext_oid_index PRIMARY KEY (oid);


--
-- Name: pg_statistic pg_statistic_relid_att_inh_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_statistic
    ADD CONSTRAINT pg_statistic_relid_att_inh_index PRIMARY KEY (starelid, staattnum, stainherit);


SET default_tablespace = pg_global;

--
-- Name: pg_subscription pg_subscription_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_subscription
    ADD CONSTRAINT pg_subscription_oid_index PRIMARY KEY (oid);


SET default_tablespace = '';

--
-- Name: pg_subscription_rel pg_subscription_rel_srrelid_srsubid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_subscription_rel
    ADD CONSTRAINT pg_subscription_rel_srrelid_srsubid_index PRIMARY KEY (srrelid, srsubid);


SET default_tablespace = pg_global;

--
-- Name: pg_subscription pg_subscription_subname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_subscription
    ADD CONSTRAINT pg_subscription_subname_index UNIQUE (subdbid, subname);


--
-- Name: pg_tablespace pg_tablespace_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_tablespace
    ADD CONSTRAINT pg_tablespace_oid_index PRIMARY KEY (oid);


--
-- Name: pg_tablespace pg_tablespace_spcname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

ALTER TABLE ONLY pg_catalog.pg_tablespace
    ADD CONSTRAINT pg_tablespace_spcname_index UNIQUE (spcname);


SET default_tablespace = '';

--
-- Name: pg_transform pg_transform_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_transform
    ADD CONSTRAINT pg_transform_oid_index PRIMARY KEY (oid);


--
-- Name: pg_transform pg_transform_type_lang_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_transform
    ADD CONSTRAINT pg_transform_type_lang_index UNIQUE (trftype, trflang);


--
-- Name: pg_trigger pg_trigger_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_trigger
    ADD CONSTRAINT pg_trigger_oid_index PRIMARY KEY (oid);


--
-- Name: pg_trigger pg_trigger_tgrelid_tgname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_trigger
    ADD CONSTRAINT pg_trigger_tgrelid_tgname_index UNIQUE (tgrelid, tgname);


--
-- Name: pg_ts_config pg_ts_config_cfgname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_config
    ADD CONSTRAINT pg_ts_config_cfgname_index UNIQUE (cfgname, cfgnamespace);


--
-- Name: pg_ts_config_map pg_ts_config_map_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_config_map
    ADD CONSTRAINT pg_ts_config_map_index PRIMARY KEY (mapcfg, maptokentype, mapseqno);


--
-- Name: pg_ts_config pg_ts_config_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_config
    ADD CONSTRAINT pg_ts_config_oid_index PRIMARY KEY (oid);


--
-- Name: pg_ts_dict pg_ts_dict_dictname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_dict
    ADD CONSTRAINT pg_ts_dict_dictname_index UNIQUE (dictname, dictnamespace);


--
-- Name: pg_ts_dict pg_ts_dict_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_dict
    ADD CONSTRAINT pg_ts_dict_oid_index PRIMARY KEY (oid);


--
-- Name: pg_ts_parser pg_ts_parser_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_parser
    ADD CONSTRAINT pg_ts_parser_oid_index PRIMARY KEY (oid);


--
-- Name: pg_ts_parser pg_ts_parser_prsname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_parser
    ADD CONSTRAINT pg_ts_parser_prsname_index UNIQUE (prsname, prsnamespace);


--
-- Name: pg_ts_template pg_ts_template_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_template
    ADD CONSTRAINT pg_ts_template_oid_index PRIMARY KEY (oid);


--
-- Name: pg_ts_template pg_ts_template_tmplname_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_ts_template
    ADD CONSTRAINT pg_ts_template_tmplname_index UNIQUE (tmplname, tmplnamespace);


--
-- Name: pg_type pg_type_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_type
    ADD CONSTRAINT pg_type_oid_index PRIMARY KEY (oid);


--
-- Name: pg_type pg_type_typname_nsp_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_type
    ADD CONSTRAINT pg_type_typname_nsp_index UNIQUE (typname, typnamespace);


--
-- Name: pg_user_mapping pg_user_mapping_oid_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_user_mapping
    ADD CONSTRAINT pg_user_mapping_oid_index PRIMARY KEY (oid);


--
-- Name: pg_user_mapping pg_user_mapping_user_server_index; Type: CONSTRAINT; Schema: pg_catalog; Owner: postgres
--

ALTER TABLE ONLY pg_catalog.pg_user_mapping
    ADD CONSTRAINT pg_user_mapping_user_server_index UNIQUE (umuser, umserver);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET default_tablespace = pg_global;

--
-- Name: pg_auth_members_grantor_index; Type: INDEX; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE INDEX pg_auth_members_grantor_index ON pg_catalog.pg_auth_members USING btree (grantor);


SET default_tablespace = '';

--
-- Name: pg_class_tblspc_relfilenode_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_class_tblspc_relfilenode_index ON pg_catalog.pg_class USING btree (reltablespace, relfilenode);


--
-- Name: pg_constraint_conname_nsp_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_constraint_conname_nsp_index ON pg_catalog.pg_constraint USING btree (conname, connamespace);


--
-- Name: pg_constraint_conparentid_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_constraint_conparentid_index ON pg_catalog.pg_constraint USING btree (conparentid);


--
-- Name: pg_constraint_contypid_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_constraint_contypid_index ON pg_catalog.pg_constraint USING btree (contypid);


--
-- Name: pg_depend_depender_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_depend_depender_index ON pg_catalog.pg_depend USING btree (classid, objid, objsubid);


--
-- Name: pg_depend_reference_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_depend_reference_index ON pg_catalog.pg_depend USING btree (refclassid, refobjid, refobjsubid);


--
-- Name: pg_index_indrelid_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_index_indrelid_index ON pg_catalog.pg_index USING btree (indrelid);


--
-- Name: pg_inherits_parent_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_inherits_parent_index ON pg_catalog.pg_inherits USING btree (inhparent);


--
-- Name: pg_publication_rel_prpubid_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_publication_rel_prpubid_index ON pg_catalog.pg_publication_rel USING btree (prpubid);


SET default_tablespace = pg_global;

--
-- Name: pg_shdepend_depender_index; Type: INDEX; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE INDEX pg_shdepend_depender_index ON pg_catalog.pg_shdepend USING btree (dbid, classid, objid, objsubid);


--
-- Name: pg_shdepend_reference_index; Type: INDEX; Schema: pg_catalog; Owner: postgres; Tablespace: pg_global
--

CREATE INDEX pg_shdepend_reference_index ON pg_catalog.pg_shdepend USING btree (refclassid, refobjid);


SET default_tablespace = '';

--
-- Name: pg_statistic_ext_relid_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_statistic_ext_relid_index ON pg_catalog.pg_statistic_ext USING btree (stxrelid);


--
-- Name: pg_trigger_tgconstraint_index; Type: INDEX; Schema: pg_catalog; Owner: postgres
--

CREATE INDEX pg_trigger_tgconstraint_index ON pg_catalog.pg_trigger USING btree (tgconstraint);


--
-- Name: pg_settings pg_settings_n; Type: RULE; Schema: pg_catalog; Owner: postgres
--

CREATE RULE pg_settings_n AS
    ON UPDATE TO pg_catalog.pg_settings DO INSTEAD NOTHING;


--
-- Name: pg_settings pg_settings_u; Type: RULE; Schema: pg_catalog; Owner: postgres
--

CREATE RULE pg_settings_u AS
    ON UPDATE TO pg_catalog.pg_settings
   WHERE (new.name = old.name) DO  SELECT set_config(old.name, new.setting, false) AS set_config;


--
-- Name: transactions transactions_bookId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES public.books(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

