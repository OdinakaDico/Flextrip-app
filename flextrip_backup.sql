--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

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
-- Name: accommodations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accommodations (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    type character varying(50) NOT NULL,
    location character varying(200) NOT NULL,
    price_per_night double precision NOT NULL,
    contact_info character varying(120),
    website character varying(200),
    added_by_admin boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.accommodations OWNER TO postgres;

--
-- Name: accommodations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accommodations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accommodations_id_seq OWNER TO postgres;

--
-- Name: accommodations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accommodations_id_seq OWNED BY public.accommodations.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: emergency_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emergency_contacts (
    id integer NOT NULL,
    country character varying(100) NOT NULL,
    embassy_phone character varying(50),
    police character varying(50),
    ambulance character varying(50),
    fire character varying(50),
    hospital_address character varying(255),
    travel_advisory text,
    updated_at timestamp without time zone
);


ALTER TABLE public.emergency_contacts OWNER TO postgres;

--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emergency_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emergency_contacts_id_seq OWNER TO postgres;

--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emergency_contacts_id_seq OWNED BY public.emergency_contacts.id;


--
-- Name: oauth_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    access_token text NOT NULL,
    refresh_token text,
    token_type character varying(50),
    expires_at timestamp without time zone,
    scope character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE public.oauth_tokens OWNER TO postgres;

--
-- Name: oauth_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_tokens_id_seq OWNER TO postgres;

--
-- Name: oauth_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_tokens_id_seq OWNED BY public.oauth_tokens.id;


--
-- Name: points_of_interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.points_of_interest (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(255),
    rating double precision,
    price_level integer,
    lat double precision,
    lng double precision,
    created_at timestamp without time zone
);


ALTER TABLE public.points_of_interest OWNER TO postgres;

--
-- Name: points_of_interest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.points_of_interest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.points_of_interest_id_seq OWNER TO postgres;

--
-- Name: points_of_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.points_of_interest_id_seq OWNED BY public.points_of_interest.id;


--
-- Name: simulated_places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.simulated_places (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    location character varying(120) NOT NULL,
    description text,
    duration_minutes integer NOT NULL,
    price_range character varying(50),
    interests character varying(255) NOT NULL,
    estimated_cost double precision,
    category character varying(100)
);


ALTER TABLE public.simulated_places OWNER TO postgres;

--
-- Name: simulated_places_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.simulated_places_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simulated_places_id_seq OWNER TO postgres;

--
-- Name: simulated_places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.simulated_places_id_seq OWNED BY public.simulated_places.id;


--
-- Name: trips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trips (
    id integer NOT NULL,
    user_id integer NOT NULL,
    destination character varying(100) NOT NULL,
    budget double precision NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    travel_pace character varying(20) NOT NULL,
    interests character varying(255),
    itinerary_json text,
    created_at timestamp without time zone
);


ALTER TABLE public.trips OWNER TO postgres;

--
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trips_id_seq OWNER TO postgres;

--
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trips_id_seq OWNED BY public.trips.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(120) NOT NULL,
    username character varying(80) NOT NULL,
    password_hash character varying(512) NOT NULL,
    created_at timestamp without time zone
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


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: accommodations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accommodations ALTER COLUMN id SET DEFAULT nextval('public.accommodations_id_seq'::regclass);


--
-- Name: emergency_contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contacts ALTER COLUMN id SET DEFAULT nextval('public.emergency_contacts_id_seq'::regclass);


--
-- Name: oauth_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth_tokens_id_seq'::regclass);


--
-- Name: points_of_interest id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points_of_interest ALTER COLUMN id SET DEFAULT nextval('public.points_of_interest_id_seq'::regclass);


--
-- Name: simulated_places id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulated_places ALTER COLUMN id SET DEFAULT nextval('public.simulated_places_id_seq'::regclass);


--
-- Name: trips id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips ALTER COLUMN id SET DEFAULT nextval('public.trips_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: accommodations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accommodations (id, name, type, location, price_per_night, contact_info, website, added_by_admin, created_at) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
58a7defc1739
\.


--
-- Data for Name: emergency_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emergency_contacts (id, country, embassy_phone, police, ambulance, fire, hospital_address, travel_advisory, updated_at) FROM stdin;
\.


--
-- Data for Name: oauth_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_tokens (id, user_id, access_token, refresh_token, token_type, expires_at, scope, created_at) FROM stdin;
\.


--
-- Data for Name: points_of_interest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.points_of_interest (id, trip_id, name, address, rating, price_level, lat, lng, created_at) FROM stdin;
\.


--
-- Data for Name: simulated_places; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.simulated_places (id, name, location, description, duration_minutes, price_range, interests, estimated_cost, category) FROM stdin;
1	Viktualienmarkt	Munich	Bustling outdoor market with local Bavarian specialties	60	Γé¼Γé¼	general	\N	\N
2	Englischer Garten	Munich	One of the largest urban parks in the world with riverside paths and beer gardens	90	Γé¼	general	\N	\N
3	Deutsches Museum	Munich	Largest museum of science and technology in the world	120	Γé¼Γé¼	general	\N	\N
4	Salzburg Cathedral	Salzburg	Baroque architecture and historical significance in the city of Mozart	45	Γé¼	general	\N	\N
5	Augustiner Br├ñustuben	Munich	Traditional beer hall popular with locals	90	Γé¼Γé¼	general	\N	\N
6	Mirabell Gardens	Salzburg	Beautiful landscaped gardens featured in The Sound of Music	45	Free	general	\N	\N
8	Viktualienmarkt	Munich	Bustling outdoor market with local Bavarian specialties	60	Γé¼Γé¼	food	\N	food
9	Englischer Garten	Munich	One of the largest urban parks in the world with riverside paths and beer gardens	90	Γé¼	nature	\N	nature
10	Deutsches Museum	Munich	Largest museum of science and technology in the world	120	Γé¼Γé¼	history,science	\N	history
11	Salzburg Cathedral	Salzburg	Baroque architecture and historical significance in the city of Mozart	45	Γé¼	art,culture,history	\N	art
12	Augustiner Br├ñustuben	Munich	Traditional beer hall popular with locals	90	Γé¼Γé¼	nightlife,food	\N	nightlife
13	Mirabell Gardens	Salzburg	Beautiful landscaped gardens featured in The Sound of Music	45	Free	nature,romance	\N	nature
14	BMW Museum	Munich	Fascinating museum dedicated to the BMW brand and automotive history	90	Γé¼Γé¼	technology,history	\N	history
15	Pinakothek der Moderne	Munich	Modern art museum with contemporary exhibitions	60	Γé¼Γé¼	art,culture	\N	art
16	G├ñrtnerplatz Theatre	Munich	Historic venue offering musicals and operas	120	Γé¼Γé¼Γé¼	arts,culture,nightlife	\N	culture
17	Nymphenburg Palace	Munich	Lavish Baroque palace with beautiful parklands	90	Γé¼Γé¼	history,culture,nature	\N	history
18	Marienplatz	Munich	Central square in the heart of Munich.	60	Γé¼	history, culture	0	\N
19	Neues Rathaus	Munich	Gothic Revival city hall with famous Glockenspiel.	60	Γé¼	history, architecture	0	\N
20	Frauenkirche	Munich	Landmark cathedral with twin towers.	45	Γé¼	history, religion	0	\N
21	Englischer Garten	Munich	Large urban park with rivers and beer gardens.	120	Γé¼	nature	0	\N
22	Nymphenburg Palace	Munich	Baroque palace with gardens and museums.	90	Γé¼Γé¼	history, architecture	15	\N
23	Deutsches Museum	Munich	The world's largest museum of science and technology.	120	Γé¼Γé¼	science, culture	14	\N
24	BMW Museum	Munich	Automotive museum next to BMW headquarters.	90	Γé¼Γé¼	culture	10	\N
25	Olympiapark	Munich	Former Olympic site with stadiums and lake.	90	Γé¼	nature, history	0	\N
26	Viktualienmarkt	Munich	Daily food market with local specialties.	60	Γé¼Γé¼	food	10	\N
27	Residenz M├╝nchen	Munich	Former royal palace with art collections.	90	Γé¼Γé¼	history, culture	9	\N
28	Asamkirche	Munich	Small baroque church rich in decor.	30	Γé¼	art, religion	0	\N
29	St. Peter's Church	Munich	Oldest parish church in Munich.	45	Γé¼	religion, history	2	\N
30	Hofbr├ñuhaus M├╝nchen	Munich	Iconic beer hall with Bavarian cuisine.	90	Γé¼Γé¼	food, culture	20	\N
31	Allianz Arena	Munich	Football stadium of FC Bayern Munich.	90	Γé¼Γé¼	culture	15	\N
32	Lenbachhaus	Munich	Museum featuring art of the Blue Rider movement.	60	Γé¼Γé¼	art	10	\N
33	Pinakothek der Moderne	Munich	Modern art museum with 20th-century works.	90	Γé¼Γé¼	art	10	\N
34	Alte Pinakothek	Munich	European masterpieces from the 14thΓÇô18th centuries.	90	Γé¼Γé¼	art	10	\N
35	Neue Pinakothek	Munich	Art from the 18th and 19th centuries.	90	Γé¼Γé¼	art	10	\N
36	Glyptothek	Munich	Ancient sculpture museum on K├╢nigsplatz.	60	Γé¼	art, history	6	\N
37	K├╢nigsplatz	Munich	Neoclassical square with museums.	30	Γé¼	architecture, history	0	\N
38	Imperial Castle of Nuremberg	Nuremberg	A historic castle offering panoramic views of the city.	90	Γé¼	history, architecture	7	\N
39	Documentation Center Nazi Party Rally Grounds	Nuremberg	Museum documenting the history of the Nazi regime.	120	Γé¼	history, culture	6	\N
40	Nuremberg Zoo	Nuremberg	A large zoo with various animal exhibits and natural enclosures.	150	Γé¼Γé¼	nature, family	14	\N
41	Albrecht D├╝rer's House	Nuremberg	Museum dedicated to the life and works of the artist Albrecht D├╝rer.	60	Γé¼	art, history	6	\N
42	Nuremberg Toy Museum	Nuremberg	Exhibits showcasing toys from different eras and cultures.	60	Γé¼	culture, family	6	\N
43	Wei├ƒgerbergasse	Nuremberg	Historic street known for its charming timber-framed houses.	30	Γé¼	architecture, history	0	\N
44	Germanisches Nationalmuseum	Nuremberg	GermanyΓÇÖs largest museum of cultural history.	90	Γé¼Γé¼	culture, art	8	\N
45	Craftsmen's Courtyard (Handwerkerhof)	Nuremberg	Small medieval village offering crafts and local food.	60	Γé¼Γé¼	shopping, culture	10	\N
46	Bratwurst R├╢slein	Nuremberg	Famous traditional restaurant known for Nuremberg sausages.	60	Γé¼Γé¼	food	15	\N
47	Hauptmarkt	Nuremberg	Main square hosting markets and food vendors.	45	Γé¼	shopping, food	5	\N
48	Fuggerei	Augsburg	The worldΓÇÖs oldest social housing complex still in use.	60	Γé¼	history, culture	5	\N
49	Augsburg Cathedral	Augsburg	Medieval Roman Catholic cathedral with stained glass.	45	Γé¼	history, religion	0	\N
50	Perlachturm	Augsburg	Historic tower with panoramic city views.	30	Γé¼	history, architecture	2	\N
51	Maximilianstra├ƒe	Augsburg	Historic street with Renaissance buildings and shops.	60	Γé¼	architecture, shopping	0	\N
52	Augsburg Town Hall	Augsburg	Renaissance city hall with the Golden Hall.	60	Γé¼	history, architecture	3	\N
53	Botanical Garden Augsburg	Augsburg	Botanical gardens with themed areas and greenhouses.	90	Γé¼	nature	3	\N
54	Schaezlerpalais	Augsburg	Baroque palace housing an art museum.	60	Γé¼	art, culture	7	\N
55	Augsburg Puppet Theater Museum	Augsburg	Museum showcasing puppetry arts and traditions.	60	Γé¼	culture, family	4	\N
56	Ratskeller Augsburg	Augsburg	Historic cellar restaurant serving traditional Bavarian fare.	75	Γé¼Γé¼	food	20	\N
57	Kuhsee	Augsburg	Popular local lake for swimming, sunbathing, and walks.	90	Γé¼	nature, leisure	0	\N
58	Regensburg Cathedral	Regensburg	Gothic cathedral dedicated to St. Peter.	45	Γé¼	history, religion	0	\N
59	Stone Bridge	Regensburg	12th-century stone bridge over the Danube.	30	Γé¼	history, architecture	0	\N
60	Porta Praetoria	Regensburg	Ancient Roman gateway from the 2nd century.	20	Γé¼	history	0	\N
61	Old Town Hall	Regensburg	Medieval building that once hosted the Imperial Diet.	60	Γé¼	history, politics	5	\N
62	Thurn and Taxis Palace	Regensburg	Lavish palace home to the princely family.	90	Γé¼Γé¼	history, culture	10	\N
63	Wurstkuchl	Regensburg	Historic sausage kitchen by the Danube.	45	Γé¼	food	10	\N
64	Danube River Cruise	Regensburg	Scenic boat tours along the Danube River.	60	Γé¼Γé¼	nature	15	\N
65	Scots Monastery	Regensburg	Monastic church with Romanesque and Gothic elements.	45	Γé¼	religion, culture	0	\N
66	Museum of Bavarian History	Regensburg	Modern museum covering Bavarian history.	90	Γé¼Γé¼	history, culture	8	\N
67	St. Emmeram's Abbey	Regensburg	Historic abbey integrated into the Thurn and Taxis Palace.	60	Γé¼	history, religion	0	\N
68	W├╝rzburg Residence	Wurzburg	Baroque palace and UNESCO World Heritage Site.	90	Γé¼Γé¼	history, architecture	9	\N
69	Marienberg Fortress	Wurzburg	Historic fortress overlooking W├╝rzburg and the Main river.	90	Γé¼	history, architecture	5	\N
70	Old Main Bridge	Wurzburg	Famous bridge with statues and views over the Main river.	30	Γé¼	architecture, culture	0	\N
71	St. Kilian Cathedral	Wurzburg	Romanesque cathedral and major pilgrimage site.	45	Γé¼	religion, history	0	\N
72	Museum im Kulturspeicher	Wurzburg	Modern art museum in a historic granary.	60	Γé¼	art, culture	7	\N
73	Alte Mainm├╝hle	Wurzburg	Restaurant with local Franconian cuisine and river views.	75	Γé¼Γé¼	food, culture	20	\N
74	Weingut Juliusspital	Wurzburg	Historic wine estate and cellar tours.	60	Γé¼Γé¼	food, culture	10	\N
75	W├╝rzburg Court Gardens	Wurzburg	Beautiful gardens behind the W├╝rzburg Residence.	45	Γé¼	nature	0	\N
76	Market Square (Marktplatz)	Wurzburg	Central square with shops, cafes, and events.	45	Γé¼	shopping, culture	0	\N
77	R├╢ntgen Memorial Site	Wurzburg	Memorial to the discoverer of X-rays.	30	Γé¼	history, science	0	\N
78	Bamberg Cathedral	Bamberg	Romanesque cathedral with four towers and tombs.	60	Γé¼	history, religion	0	\N
79	Altes Rathaus	Bamberg	Town hall built on an island in the river.	30	Γé¼	architecture, history	0	\N
80	New Residence & Rose Garden	Bamberg	BishopΓÇÖs residence with scenic rose garden.	60	Γé¼	history, nature	5	\N
81	Little Venice	Bamberg	Picturesque fishermen's houses along the river Regnitz.	30	Γé¼	culture, leisure	0	\N
82	Michelsberg Monastery	Bamberg	Historic Benedictine monastery with hillside views.	45	Γé¼	history, religion	0	\N
83	Schlenkerla Brewery	Bamberg	Historic brewery known for its smoked beer.	60	Γé¼Γé¼	food, culture	12	\N
84	Brauerei Spezial	Bamberg	Brewery with traditional German fare.	75	Γé¼Γé¼	food, nightlife	15	\N
85	Altenburg Castle	Bamberg	Hilltop castle with views and a tavern.	60	Γé¼	history	3	\N
86	Historical Museum Bamberg	Bamberg	Museum showcasing regional history.	60	Γé¼	history, culture	5	\N
87	Bamberg Natural History Museum	Bamberg	Museum of local flora, fauna, and geology.	60	Γé¼	science, nature	4	\N
88	Audi Forum & Museum Mobile	Ingolstadt	Museum showcasing AudiΓÇÖs automotive history.	90	Γé¼	culture, technology	7	\N
89	Asam Church (Maria de Victoria)	Ingolstadt	Baroque church with a famous ceiling fresco.	45	Γé¼	art, religion	3	\N
90	New Castle (Neues Schloss)	Ingolstadt	Castle with museums and medieval exhibits.	60	Γé¼	history, architecture	5	\N
91	Kreuztor	Ingolstadt	Gothic city gate and historic landmark.	20	Γé¼	history, architecture	0	\N
92	Liebfrauenm├╝nster Church	Ingolstadt	Late Gothic church with impressive towers.	45	Γé¼	religion, history	0	\N
93	Ingolstadt Village	Ingolstadt	Designer outlet mall with luxury brands.	120	Γé¼Γé¼	shopping, culture	0	\N
94	Museum f├╝r Konkrete Kunst	Ingolstadt	Museum of Concrete Art and Design.	60	Γé¼	art	6	\N
95	City Theatre Ingolstadt	Ingolstadt	Theatre with a variety of modern and classic productions.	120	Γé¼Γé¼	arts, culture	20	\N
96	Lechner Museum	Ingolstadt	Contemporary art museum featuring steel sculptures.	60	Γé¼	art	5	\N
97	Danube River Promenade	Ingolstadt	Scenic walking paths along the Danube River.	60	Γé¼	nature	0	\N
98	St. Stephen's Cathedral	Passau	Home to the worldΓÇÖs largest cathedral organ.	60	Γé¼	history, religion	5	\N
99	Veste Oberhaus	Passau	Historic fortress overlooking the city.	90	Γé¼	history, architecture	5	\N
100	Old Town Hall	Passau	Renaissance town hall on the Danube river.	45	Γé¼	architecture, politics	0	\N
101	Glass Museum Passau	Passau	Museum of Bohemian glass art.	60	Γé¼	art, culture	8	\N
102	Museum of Modern Art	Passau	Contemporary art museum housed in a historic building.	60	Γé¼	art	6	\N
103	Three Rivers Confluence	Passau	Meeting point of the Danube, Inn, and Ilz rivers.	30	Γé¼	nature	0	\N
104	Innpromenade	Passau	Walkway along the Inn River offering scenic views.	60	Γé¼	nature	0	\N
105	Pilgrimage Church Mariahilf	Passau	Church and monastery on a hill with city views.	45	Γé¼	religion, history	0	\N
106	Donau Cycle Path	Passau	Famous long-distance cycling path along the Danube.	120	Γé¼	nature, recreation	0	\N
107	H├╢llgasse	Passau	Artists' alley with galleries and boutiques.	45	Γé¼	culture, shopping	0	\N
108	Trausnitz Castle	Landshut	Medieval castle with views over the city.	90	Γé¼	history, architecture	6	\N
109	St. Martin's Church	Landshut	Gothic church with the tallest brick tower in the world.	45	Γé¼	religion, history	0	\N
110	Landshut Residence	Landshut	Renaissance palace and art museum.	60	Γé¼	history, architecture	5	\N
111	City Hall Landshut	Landshut	Town hall with ceremonial rooms and events.	45	Γé¼	history, architecture	0	\N
112	Landshut Wedding Museum	Landshut	Museum showcasing the 1475 Landshut Wedding celebration.	60	Γé¼	history, culture	4	\N
113	Isar River Walks	Landshut	Scenic paths along the river Isar.	60	Γé¼	nature	0	\N
114	Hofgarten Park	Landshut	Public park with trails and panoramic city views.	60	Γé¼	nature	0	\N
115	Eisstadion am Gutenbergweg	Landshut	Home arena of EV Landshut ice hockey team.	120	Γé¼	sports, culture	10	\N
116	Landshut Theatre	Landshut	Performing arts theatre offering plays and concerts.	120	Γé¼Γé¼	arts, culture	18	\N
117	KOENIGmuseum	Landshut	Museum dedicated to the sculptor Fritz Koenig.	60	Γé¼	art	6	\N
118	Margravial Opera House	Bayreuth	UNESCO-listed Baroque opera house.	60	Γé¼	art, history	8	\N
119	Bayreuth Festival Theatre	Bayreuth	Opera house dedicated to Richard Wagner.	120	Γé¼Γé¼	arts, music	15	\N
120	New Palace Bayreuth	Bayreuth	18th-century palace with ornate rooms and a garden.	60	Γé¼	history, architecture	5	\N
121	Richard Wagner Museum	Bayreuth	Museum in WagnerΓÇÖs former home.	90	Γé¼	music, history	8	\N
122	Hermitage Palace	Bayreuth	Historic palace and landscaped gardens.	90	Γé¼	architecture, nature	6	\N
123	Iwalewa-Haus	Bayreuth	University museum showcasing African art.	60	Γé¼	culture, art	4	\N
124	Ecological-Botanical Garden	Bayreuth	Extensive university garden and greenhouses.	90	Γé¼	nature, science	0	\N
125	MaiselΓÇÖs Beer Experience World	Bayreuth	Beer museum with tastings and historic brewing.	90	Γé¼Γé¼	food, culture	10	\N
126	Bayreuth Catacombs	Bayreuth	Underground brewery tunnels from the 16th century.	60	Γé¼	history, adventure	7	\N
127	Tierpark R├╢hrensee	Bayreuth	Small zoo and lake ideal for walks and kids.	60	Γé¼	nature, family	0	\N
128	Deggendorf City Museum	Deggendorf	Museum covering local history and art.	60	Γé¼	history, culture	5	\N
129	Church of the Assumption	Deggendorf	Prominent church with medieval architecture.	45	Γé¼	religion, history	0	\N
130	Old Town Hall	Deggendorf	Historic town hall at the town square.	30	Γé¼	architecture, history	0	\N
131	Handwerksmuseum	Deggendorf	Crafts and trades museum.	45	Γé¼	culture	4	\N
132	Cultural Quarter Deggendorf	Deggendorf	Hub for exhibitions and performances.	90	Γé¼	arts, culture	8	\N
133	Danube River Promenade	Deggendorf	Riverwalk for walking, biking, and relaxing.	60	Γé¼	nature	0	\N
134	Geiersberg Park	Deggendorf	Scenic park with trails and views.	60	Γé¼	nature	0	\N
135	Elypso Leisure Center	Deggendorf	Swimming pools, saunas, and fitness center.	90	Γé¼Γé¼	leisure, family	12	\N
136	Deggendorf Golf Club	Deggendorf	Golfing with views of the Bavarian Forest.	120	Γé¼Γé¼	sports, nature	25	\N
137	Bavarian Forest National Park Access	Deggendorf	Gateway to Germany's first national park.	120	Γé¼	nature	0	\N
138	St. Nicholas Church	Eggenfelden	Central parish church in neo-Gothic style.	30	Γé¼	religion, history	0	\N
139	Eggenfelden Local History Museum	Eggenfelden	Museum showcasing the townΓÇÖs historical development.	60	Γé¼	history	3	\N
140	Theater an der Rott	Eggenfelden	Regional theatre hosting plays and concerts.	120	Γé¼Γé¼	arts, culture	18	\N
141	Old Town Center	Eggenfelden	Charming streets with shops and cafes.	60	Γé¼	culture	0	\N
142	Eggenfelden Art Gallery	Eggenfelden	Local gallery exhibiting regional artwork.	45	Γé¼	art	5	\N
143	Rott River Walks	Eggenfelden	Walking paths along the Rott river.	60	Γé¼	nature	0	\N
144	Eggenfelden Park	Eggenfelden	Public green space with paths and playgrounds.	45	Γé¼	nature	0	\N
145	Golfclub Rottal	Eggenfelden	18-hole golf course surrounded by countryside.	120	Γé¼Γé¼	sports, nature	30	\N
146	Eggenfelden Swimming Pool	Eggenfelden	Indoor and outdoor pools for all ages.	90	Γé¼	leisure	8	\N
147	Local Farmers' Market	Eggenfelden	Weekly market with fresh produce and local specialties.	60	Γé¼	food, culture	10	\N
148	Wallfahrtskirche Gartlberg	Pfarrkirchen	Baroque pilgrimage church on a hill.	45	Γé¼	religion, history	0	\N
149	Trabrennbahn Pfarrkirchen	Pfarrkirchen	Historic harness racing track with events.	90	Γé¼	sports, culture	10	\N
150	Evangelische Christuskirche	Pfarrkirchen	Protestant church known for its simple design.	30	Γé¼	religion, architecture	0	\N
151	Wimmer-Ro├ƒ	Pfarrkirchen	Traditional Bavarian restaurant and brewery.	75	Γé¼Γé¼	food	20	\N
152	Altes Rathaus	Pfarrkirchen	The old town hall with cultural exhibits.	30	Γé¼	history, architecture	0	\N
153	Schloss Reichenberg	Pfarrkirchen	Small castle surrounded by green landscape.	60	Γé¼	history, nature	3	\N
154	Erlebniswelt Voglsam	Pfarrkirchen	Adventure park with animals and tree-top paths.	90	Γé¼Γé¼	family, nature	12	\N
155	Bowling-Center Pfarrkirchen	Pfarrkirchen	Bowling alley with arcade and bar.	90	Γé¼	leisure	8	\N
156	Erlebnisbad Pfarrkirchen	Pfarrkirchen	Swimming and adventure pool.	90	Γé¼	leisure	6	\N
157	Wasserschloss Sch├╢nau	Pfarrkirchen	Moated castle near Pfarrkirchen.	60	Γé¼	history, nature	4	\N
158	Hohensalzburg Fortress	Salzburg	Massive fortress overlooking Salzburg.	90	Γé¼Γé¼	history, architecture	13	\N
159	Mozart's Birthplace	Salzburg	Museum in the house where Mozart was born.	60	Γé¼Γé¼	history, music	12	\N
160	Mirabell Palace & Gardens	Salzburg	Palace with stunning gardens and marble hall.	60	Γé¼	nature, culture	0	\N
161	Getreidegasse	Salzburg	Historic shopping street with ornate signs.	45	Γé¼	shopping, culture	0	\N
162	Hellbrunn Palace & Trick Fountains	Salzburg	Palace with whimsical fountains and gardens.	90	Γé¼Γé¼	architecture, leisure	10	\N
163	Salzburg Cathedral	Salzburg	Baroque cathedral with ornate interior.	45	Γé¼	religion, history	5	\N
164	St. Peter's Abbey	Salzburg	Ancient monastery and cemetery.	45	Γé¼	history, religion	0	\N
165	Residenzplatz	Salzburg	Central square with fountains and historic buildings.	30	Γé¼	architecture, history	0	\N
166	Mozartplatz	Salzburg	Square dedicated to Mozart with his statue.	30	Γé¼	culture, music	0	\N
167	Salzach River Cruise	Salzburg	Scenic cruise on the Salzach river.	60	Γé¼Γé¼	nature, leisure	15	\N
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trips (id, user_id, destination, budget, start_date, end_date, travel_pace, interests, itinerary_json, created_at) FROM stdin;
1	1	Pfarrkirchen	100	2025-05-26	2025-05-26	moderate	history	[]	2025-05-26 19:36:24.917695
2	1	Pfarrkirchen	100	2025-05-27	2025-05-27	moderate	food	[]	2025-05-26 21:08:57.001399
3	1	Pfarrkirchen	100	2025-05-27	2025-05-27	moderate	food	[]	2025-05-27 17:35:21.37711
4	1	Munich	100	2025-05-28	2025-05-28	moderate	food	[]	2025-05-28 22:12:14.664131
5	1	Pfarrkirchen	100	2025-05-29	2025-05-29	moderate	history	[]	2025-05-29 15:36:39.689842
6	1	Pfarrkirchen	100	2025-05-30	2025-05-30	moderate	history	[]	2025-05-30 12:03:25.265077
7	1	Pfarrkirchen	100	2025-05-30	2025-05-30	moderate	nature	[]	2025-05-30 12:03:25.265077
8	1	Pfarrkirchen	100	2025-05-30	2025-05-30	moderate	history	[]	2025-05-30 13:29:08.36618
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, username, password_hash, created_at) FROM stdin;
1	odinakaelias@gmail.com	Dico	scrypt:32768:8:1$F6MyGHQBFa4qfbAz$c7eae67411b959d8347b41ee6222854edff8212ffb41960e7f39df9099310fee8bc80d22a7a5aab1f3667b459c8a423ef505789b183786032d610295bb3448ae	2025-05-19 18:34:07.10125
\.


--
-- Name: accommodations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accommodations_id_seq', 1, false);


--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emergency_contacts_id_seq', 1, false);


--
-- Name: oauth_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_tokens_id_seq', 1, false);


--
-- Name: points_of_interest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.points_of_interest_id_seq', 1, false);


--
-- Name: simulated_places_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.simulated_places_id_seq', 167, true);


--
-- Name: trips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trips_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: accommodations accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: emergency_contacts emergency_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_pkey PRIMARY KEY (id);


--
-- Name: oauth_tokens oauth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_tokens oauth_tokens_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_user_id_key UNIQUE (user_id);


--
-- Name: points_of_interest points_of_interest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points_of_interest
    ADD CONSTRAINT points_of_interest_pkey PRIMARY KEY (id);


--
-- Name: simulated_places simulated_places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulated_places
    ADD CONSTRAINT simulated_places_pkey PRIMARY KEY (id);


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


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
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: oauth_tokens oauth_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: points_of_interest points_of_interest_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points_of_interest
    ADD CONSTRAINT points_of_interest_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id);


--
-- Name: trips trips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

