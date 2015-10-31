--
-- kittnQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2015-10-27 21:16:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 192 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

SET search_path = public, pg_catalog;

--
-- TOC entry 544 (class 1247 OID 24847)
-- Name: pubtype; Type: TYPE; Schema: public; Owner: kittn
--

CREATE TYPE pubtype AS ENUM (
    'article',
    'proceedings',
    'inproceedings',
    'book',
    'incollection'
);


ALTER TYPE pubtype OWNER TO kittn;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 24873)
-- Name: Area; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Area" (
    "ID" integer NOT NULL,
    "Name" text NOT NULL
);


ALTER TABLE "Area" OWNER TO kittn;

--
-- TOC entry 188 (class 1259 OID 25053)
-- Name: Article; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Article" (
    "PubID" integer NOT NULL,
    "JournalID" integer NOT NULL,
    "Pages" text
);


ALTER TABLE "Article" OWNER TO kittn;

--
-- TOC entry 177 (class 1259 OID 24897)
-- Name: Author; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Author" (
    "ID" integer NOT NULL,
    "Name" text NOT NULL
);


ALTER TABLE "Author" OWNER TO kittn;

--
-- TOC entry 191 (class 1259 OID 25070)
-- Name: Author_ID_seq; Type: SEQUENCE; Schema: public; Owner: kittn
--

CREATE SEQUENCE "Author_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Author_ID_seq" OWNER TO kittn;

--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 191
-- Name: Author_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kittn
--

ALTER SEQUENCE "Author_ID_seq" OWNED BY "Author"."ID";


--
-- TOC entry 179 (class 1259 OID 24913)
-- Name: Book; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Book" (
    "PubID" integer NOT NULL,
    "Volume" text
);


ALTER TABLE "Book" OWNER TO kittn;

--
-- TOC entry 180 (class 1259 OID 24926)
-- Name: Conference; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Conference" (
    "ID" integer NOT NULL,
    "Title" text NOT NULL,
    "Volume" text
);


ALTER TABLE "Conference" OWNER TO kittn;

--
-- TOC entry 185 (class 1259 OID 25016)
-- Name: Incollection; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Incollection" (
    "PubID" integer NOT NULL,
    "Crossref" integer NOT NULL,
    "Pages" text
);


ALTER TABLE "Incollection" OWNER TO kittn;

--
-- TOC entry 186 (class 1259 OID 25029)
-- Name: Inproceedings; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Inproceedings" (
    "PubID" integer NOT NULL,
    "Crossref" integer NOT NULL,
    "Pages" text
);


ALTER TABLE "Inproceedings" OWNER TO kittn;

--
-- TOC entry 181 (class 1259 OID 24934)
-- Name: InstAuthPub; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "InstAuthPub" (
    "PubID" integer NOT NULL,
    "InstID" integer,
    "Author" text NOT NULL
);


ALTER TABLE "InstAuthPub" OWNER TO kittn;

--
-- TOC entry 178 (class 1259 OID 24905)
-- Name: Institution; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Institution" (
    "ID" integer NOT NULL,
    "Title" text NOT NULL
);


ALTER TABLE "Institution" OWNER TO kittn;

--
-- TOC entry 173 (class 1259 OID 24865)
-- Name: Journal; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Journal" (
    "ID" integer NOT NULL,
    "Title" text NOT NULL,
    "Volume" text,
    "Number" text,
    "Name" text
);


ALTER TABLE "Journal" OWNER TO kittn;

--
-- TOC entry 190 (class 1259 OID 25068)
-- Name: Journal_ID_seq; Type: SEQUENCE; Schema: public; Owner: kittn
--

CREATE SEQUENCE "Journal_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Journal_ID_seq" OWNER TO kittn;

--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 190
-- Name: Journal_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kittn
--

ALTER SEQUENCE "Journal_ID_seq" OWNED BY "Journal"."ID";


--
-- TOC entry 175 (class 1259 OID 24881)
-- Name: Keyword; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Keyword" (
    "ID" integer NOT NULL,
    "Word" text NOT NULL
);


ALTER TABLE "Keyword" OWNER TO kittn;

--
-- TOC entry 187 (class 1259 OID 25043)
-- Name: Proceedings; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Proceedings" (
    "PubID" integer NOT NULL,
    "ConferenceID" integer NOT NULL
);


ALTER TABLE "Proceedings" OWNER TO kittn;

--
-- TOC entry 182 (class 1259 OID 24954)
-- Name: PubArea; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "PubArea" (
    "PubID" integer NOT NULL,
    "AreaID" integer NOT NULL
);


ALTER TABLE "PubArea" OWNER TO kittn;

--
-- TOC entry 183 (class 1259 OID 24969)
-- Name: PubKeyword; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "PubKeyword" (
    "PubID" integer NOT NULL,
    "KeywordID" integer NOT NULL
);


ALTER TABLE "PubKeyword" OWNER TO kittn;

--
-- TOC entry 172 (class 1259 OID 24857)
-- Name: Publication; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Publication" (
    "ID" integer NOT NULL,
    "Title" text NOT NULL,
    "Year" integer NOT NULL,
    "Type" pubtype NOT NULL
);


ALTER TABLE "Publication" OWNER TO kittn;

--
-- TOC entry 189 (class 1259 OID 25066)
-- Name: Publication_ID_seq; Type: SEQUENCE; Schema: public; Owner: kittn
--

CREATE SEQUENCE "Publication_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Publication_ID_seq" OWNER TO kittn;

--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 189
-- Name: Publication_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kittn
--

ALTER SEQUENCE "Publication_ID_seq" OWNED BY "Publication"."ID";


--
-- TOC entry 184 (class 1259 OID 24984)
-- Name: Published; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Published" (
    "PublicationID" integer NOT NULL,
    "PublisherID" integer NOT NULL
);


ALTER TABLE "Published" OWNER TO kittn;

--
-- TOC entry 176 (class 1259 OID 24889)
-- Name: Publisher; Type: TABLE; Schema: public; Owner: kittn; Tablespace: 
--

CREATE TABLE "Publisher" (
    "ID" integer NOT NULL,
    "Name" text NOT NULL
);


ALTER TABLE "Publisher" OWNER TO kittn;

--
-- TOC entry 1967 (class 2604 OID 25072)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Author" ALTER COLUMN "ID" SET DEFAULT nextval('"Author_ID_seq"'::regclass);


--
-- TOC entry 1966 (class 2604 OID 25074)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Journal" ALTER COLUMN "ID" SET DEFAULT nextval('"Journal_ID_seq"'::regclass);


--
-- TOC entry 1965 (class 2604 OID 25073)
-- Name: ID; Type: DEFAULT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Publication" ALTER COLUMN "ID" SET DEFAULT nextval('"Publication_ID_seq"'::regclass);


--
-- TOC entry 2127 (class 0 OID 24873)
-- Dependencies: 174
-- Data for Name: Area; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2141 (class 0 OID 25053)
-- Dependencies: 188
-- Data for Name: Article; Type: TABLE DATA; Schema: public; Owner: kittn
--

INSERT INTO "Article" VALUES (1, 1, '607-619');
INSERT INTO "Article" VALUES (2, 1, '707-737');
INSERT INTO "Article" VALUES (3, 1, '131-152');
INSERT INTO "Article" VALUES (4, 1, '255-275');
INSERT INTO "Article" VALUES (5, 1, '297-315');
INSERT INTO "Article" VALUES (6, 1, '511-522');
INSERT INTO "Article" VALUES (7, 1, '687-706');
INSERT INTO "Article" VALUES (8, 1, '387-408');
INSERT INTO "Article" VALUES (9, 1, '1-20');
INSERT INTO "Article" VALUES (10, 1, '421-456');
INSERT INTO "Article" VALUES (11, 1, '177-202');
INSERT INTO "Article" VALUES (12, 1, '523-546');
INSERT INTO "Article" VALUES (13, 1, '547-557');
INSERT INTO "Article" VALUES (14, 1, '559-569');
INSERT INTO "Article" VALUES (15, 1, '277-280');
INSERT INTO "Article" VALUES (16, 1, '233-254');
INSERT INTO "Article" VALUES (17, 1, '781-797');
INSERT INTO "Article" VALUES (18, 1, '641-667');
INSERT INTO "Article" VALUES (19, 1, '759-780');
INSERT INTO "Article" VALUES (20, 1, '409-420');
INSERT INTO "Article" VALUES (21, 1, '621-630');
INSERT INTO "Article" VALUES (22, 1, '351-385');
INSERT INTO "Article" VALUES (23, 1, '203-231');
INSERT INTO "Article" VALUES (24, 1, '595-606');
INSERT INTO "Article" VALUES (25, 1, '739-757');
INSERT INTO "Article" VALUES (26, 1, '21-68');
INSERT INTO "Article" VALUES (27, 1, '281-296');
INSERT INTO "Article" VALUES (28, 1, '317-350');
INSERT INTO "Article" VALUES (29, 2, '227-248');
INSERT INTO "Article" VALUES (30, 2, '171-178');
INSERT INTO "Article" VALUES (31, 2, '197-206');
INSERT INTO "Article" VALUES (32, 2, '249-260');
INSERT INTO "Article" VALUES (33, 2, '371-389');
INSERT INTO "Article" VALUES (34, 2, '113-120');
INSERT INTO "Article" VALUES (35, 2, '1-33');
INSERT INTO "Article" VALUES (36, 2, '261-281');
INSERT INTO "Article" VALUES (37, 2, '301-313');
INSERT INTO "Article" VALUES (38, 2, '35-57');
INSERT INTO "Article" VALUES (39, 2, '59-101');
INSERT INTO "Article" VALUES (40, 2, '133-142');
INSERT INTO "Article" VALUES (41, 2, '159-170');
INSERT INTO "Article" VALUES (42, 2, '283-300');
INSERT INTO "Article" VALUES (43, 2, '329-344');
INSERT INTO "Article" VALUES (44, 2, '143-158');
INSERT INTO "Article" VALUES (45, 2, '207-226');
INSERT INTO "Article" VALUES (46, 2, '179-196');
INSERT INTO "Article" VALUES (47, 2, '345-369');
INSERT INTO "Article" VALUES (48, 3, '425-433');
INSERT INTO "Article" VALUES (49, 3, '477-485');
INSERT INTO "Article" VALUES (50, 3, '451-476');
INSERT INTO "Article" VALUES (51, 3, '287-310');
INSERT INTO "Article" VALUES (52, 3, '349-364');
INSERT INTO "Article" VALUES (53, 3, '365-397');
INSERT INTO "Article" VALUES (54, 3, '193-213');
INSERT INTO "Article" VALUES (55, 3, '43-61');
INSERT INTO "Article" VALUES (56, 3, '1-20');
INSERT INTO "Article" VALUES (57, 3, '267-285');
INSERT INTO "Article" VALUES (58, 3, '31-41');
INSERT INTO "Article" VALUES (59, 3, '245-265');
INSERT INTO "Article" VALUES (60, 3, '143-155');
INSERT INTO "Article" VALUES (61, 3, '63-67');
INSERT INTO "Article" VALUES (62, 3, '327-348');
INSERT INTO "Article" VALUES (63, 3, '185-192');
INSERT INTO "Article" VALUES (64, 3, '215-219');
INSERT INTO "Article" VALUES (65, 3, '399-409');
INSERT INTO "Article" VALUES (66, 3, '411-423');
INSERT INTO "Article" VALUES (67, 4, '395-398');
INSERT INTO "Article" VALUES (68, 4, '183-195');
INSERT INTO "Article" VALUES (69, 4, '111-121');
INSERT INTO "Article" VALUES (70, 4, '197-216');
INSERT INTO "Article" VALUES (71, 4, '305-317');
INSERT INTO "Article" VALUES (72, 4, '137-152');
INSERT INTO "Article" VALUES (73, 4, '399-413');
INSERT INTO "Article" VALUES (74, 4, '319-323');
INSERT INTO "Article" VALUES (75, 4, '15-34');
INSERT INTO "Article" VALUES (76, 4, '357-360');
INSERT INTO "Article" VALUES (77, 4, '249-268');
INSERT INTO "Article" VALUES (78, 4, '95-107');
INSERT INTO "Article" VALUES (79, 4, '325');
INSERT INTO "Article" VALUES (80, 4, '227-247');
INSERT INTO "Article" VALUES (81, 4, '35-60');
INSERT INTO "Article" VALUES (82, 4, '61-73');
INSERT INTO "Article" VALUES (83, 4, '1-13');
INSERT INTO "Article" VALUES (84, 4, '75-93');
INSERT INTO "Article" VALUES (85, 4, '153-166');
INSERT INTO "Article" VALUES (86, 4, '361-394');
INSERT INTO "Article" VALUES (87, 5, '19-24');
INSERT INTO "Article" VALUES (88, 5, '243-269');
INSERT INTO "Article" VALUES (89, 5, '1-18');
INSERT INTO "Article" VALUES (90, 5, '165-189');
INSERT INTO "Article" VALUES (91, 5, '417-426');
INSERT INTO "Article" VALUES (92, 5, '51-66');
INSERT INTO "Article" VALUES (93, 5, '363-396');
INSERT INTO "Article" VALUES (94, 5, '43-50');
INSERT INTO "Article" VALUES (95, 5, '213-242');
INSERT INTO "Article" VALUES (96, 5, '271-290');
INSERT INTO "Article" VALUES (97, 5, '25-41');
INSERT INTO "Article" VALUES (98, 5, '149-163');
INSERT INTO "Article" VALUES (99, 5, '397-408');
INSERT INTO "Article" VALUES (100, 5, '97-147');
INSERT INTO "Article" VALUES (101, 6, '595-632');
INSERT INTO "Article" VALUES (102, 6, '277-298');
INSERT INTO "Article" VALUES (103, 6, '1-31');
INSERT INTO "Article" VALUES (104, 6, '555-564');
INSERT INTO "Article" VALUES (105, 6, '157-171');
INSERT INTO "Article" VALUES (106, 6, '145-156');
INSERT INTO "Article" VALUES (107, 6, '525-553');
INSERT INTO "Article" VALUES (108, 6, '353-362');
INSERT INTO "Article" VALUES (109, 6, '79-91');
INSERT INTO "Article" VALUES (110, 6, '461-474');
INSERT INTO "Article" VALUES (111, 6, '491-511');
INSERT INTO "Article" VALUES (112, 6, '93-104');
INSERT INTO "Article" VALUES (113, 6, '475-489');
INSERT INTO "Article" VALUES (114, 6, '653-678');
INSERT INTO "Article" VALUES (115, 6, '239-276');
INSERT INTO "Article" VALUES (116, 6, '33-55');
INSERT INTO "Article" VALUES (117, 6, '679-694');
INSERT INTO "Article" VALUES (118, 6, '363-380');
INSERT INTO "Article" VALUES (119, 6, '173-190');
INSERT INTO "Article" VALUES (120, 6, '191-209');
INSERT INTO "Article" VALUES (121, 6, '105-119');
INSERT INTO "Article" VALUES (122, 6, '417-432');
INSERT INTO "Article" VALUES (123, 6, '395-415');
INSERT INTO "Article" VALUES (124, 6, '57-77');
INSERT INTO "Article" VALUES (125, 6, '565-582');
INSERT INTO "Article" VALUES (126, 7, '15-36');
INSERT INTO "Article" VALUES (127, 7, '497-514');
INSERT INTO "Article" VALUES (128, 7, '203-231');
INSERT INTO "Article" VALUES (129, 7, '305-332');
INSERT INTO "Article" VALUES (130, 7, '85-109');
INSERT INTO "Article" VALUES (131, 7, '233-281');
INSERT INTO "Article" VALUES (132, 7, '111-153');
INSERT INTO "Article" VALUES (133, 7, '537-571');
INSERT INTO "Article" VALUES (134, 7, '625-661');
INSERT INTO "Article" VALUES (135, 7, '663-676');
INSERT INTO "Article" VALUES (136, 7, '333-354');
INSERT INTO "Article" VALUES (137, 7, '593-624');
INSERT INTO "Article" VALUES (138, 7, '425-438');
INSERT INTO "Article" VALUES (139, 7, '155-178');
INSERT INTO "Article" VALUES (140, 7, '475-496');
INSERT INTO "Article" VALUES (141, 7, '515-535');
INSERT INTO "Article" VALUES (142, 7, '37-54');
INSERT INTO "Article" VALUES (143, 7, '573-591');
INSERT INTO "Article" VALUES (144, 7, '691-711');
INSERT INTO "Article" VALUES (145, 8, '297-305');
INSERT INTO "Article" VALUES (146, 8, '229-243');
INSERT INTO "Article" VALUES (147, 8, '67-78');
INSERT INTO "Article" VALUES (148, 8, '105-109');
INSERT INTO "Article" VALUES (149, 8, '265-272');
INSERT INTO "Article" VALUES (150, 8, '323-339');
INSERT INTO "Article" VALUES (151, 8, '175-201');
INSERT INTO "Article" VALUES (152, 8, '157-167');
INSERT INTO "Article" VALUES (153, 8, '203-208');
INSERT INTO "Article" VALUES (154, 8, '85-94');
INSERT INTO "Article" VALUES (155, 8, '341-367');
INSERT INTO "Article" VALUES (156, 8, '307-321');
INSERT INTO "Article" VALUES (157, 8, '369-390');
INSERT INTO "Article" VALUES (158, 8, '169-173');
INSERT INTO "Article" VALUES (159, 8, '79-84');
INSERT INTO "Article" VALUES (160, 8, '27-52');
INSERT INTO "Article" VALUES (161, 9, '29-52');
INSERT INTO "Article" VALUES (162, 9, '139-172');
INSERT INTO "Article" VALUES (163, 9, '485-491');
INSERT INTO "Article" VALUES (164, 9, '313-341');
INSERT INTO "Article" VALUES (165, 9, '413-436');
INSERT INTO "Article" VALUES (166, 9, '1-14');
INSERT INTO "Article" VALUES (167, 9, '105-115');
INSERT INTO "Article" VALUES (168, 9, '381-394');
INSERT INTO "Article" VALUES (169, 9, '225-248');
INSERT INTO "Article" VALUES (170, 9, '203-224');
INSERT INTO "Article" VALUES (171, 9, '15-28');
INSERT INTO "Article" VALUES (172, 9, '295-312');
INSERT INTO "Article" VALUES (173, 9, '395-412');
INSERT INTO "Article" VALUES (174, 9, '53-54');
INSERT INTO "Article" VALUES (175, 9, '281-293');
INSERT INTO "Article" VALUES (176, 9, '55-68');
INSERT INTO "Article" VALUES (177, 10, '307-330');
INSERT INTO "Article" VALUES (178, 10, '131-145');
INSERT INTO "Article" VALUES (179, 10, '395-417');
INSERT INTO "Article" VALUES (180, 10, '535-594');
INSERT INTO "Article" VALUES (181, 10, '293-306');
INSERT INTO "Article" VALUES (182, 10, '265-292');
INSERT INTO "Article" VALUES (183, 10, '223-242');
INSERT INTO "Article" VALUES (184, 10, '45-71');
INSERT INTO "Article" VALUES (185, 10, '195-222');
INSERT INTO "Article" VALUES (186, 10, '521-533');
INSERT INTO "Article" VALUES (187, 10, '477-500');
INSERT INTO "Article" VALUES (188, 10, '165-171');
INSERT INTO "Article" VALUES (189, 10, '147-164');
INSERT INTO "Article" VALUES (190, 10, '1-43');
INSERT INTO "Article" VALUES (191, 10, '243-264');
INSERT INTO "Article" VALUES (192, 10, '451-476');
INSERT INTO "Article" VALUES (193, 10, '371-393');
INSERT INTO "Article" VALUES (194, 10, '73-130');
INSERT INTO "Article" VALUES (195, 10, '341-370');
INSERT INTO "Article" VALUES (196, 11, '199-228');
INSERT INTO "Article" VALUES (197, 11, '229-255');
INSERT INTO "Article" VALUES (198, 11, '297-329');
INSERT INTO "Article" VALUES (199, 11, '77-122');
INSERT INTO "Article" VALUES (200, 11, '331-341');
INSERT INTO "Article" VALUES (201, 11, '15-39');
INSERT INTO "Article" VALUES (202, 11, '257-287');
INSERT INTO "Article" VALUES (203, 11, '123-156');
INSERT INTO "Article" VALUES (204, 11, '157-173');
INSERT INTO "Article" VALUES (205, 11, '289-295');
INSERT INTO "Article" VALUES (206, 11, '381-402');
INSERT INTO "Article" VALUES (207, 11, '359-380');
INSERT INTO "Article" VALUES (208, 11, '403-436');
INSERT INTO "Article" VALUES (209, 11, '175-197');
INSERT INTO "Article" VALUES (210, 11, '1-14');
INSERT INTO "Article" VALUES (211, 12, '447-452');
INSERT INTO "Article" VALUES (212, 12, '231-264');
INSERT INTO "Article" VALUES (213, 12, '733-754');
INSERT INTO "Article" VALUES (214, 12, '611-629');
INSERT INTO "Article" VALUES (215, 12, '121-163');
INSERT INTO "Article" VALUES (216, 12, '559-574');
INSERT INTO "Article" VALUES (217, 12, '631-656');
INSERT INTO "Article" VALUES (218, 12, '43-81');
INSERT INTO "Article" VALUES (219, 12, '713-732');
INSERT INTO "Article" VALUES (220, 12, '477-510');
INSERT INTO "Article" VALUES (221, 12, '351-363');
INSERT INTO "Article" VALUES (222, 12, '603-605');
INSERT INTO "Article" VALUES (223, 12, '539-558');
INSERT INTO "Article" VALUES (224, 12, '575-591');
INSERT INTO "Article" VALUES (225, 12, '165-178');
INSERT INTO "Article" VALUES (226, 12, '463-476');
INSERT INTO "Article" VALUES (227, 12, '95-119');
INSERT INTO "Article" VALUES (228, 12, '83-94');
INSERT INTO "Article" VALUES (229, 12, '777-779');
INSERT INTO "Article" VALUES (230, 12, '1-6');
INSERT INTO "Article" VALUES (231, 12, '755-775');
INSERT INTO "Article" VALUES (232, 12, '297-309');
INSERT INTO "Article" VALUES (233, 12, '657-680');
INSERT INTO "Article" VALUES (234, 12, '311-350');
INSERT INTO "Article" VALUES (235, 12, '7-41');
INSERT INTO "Article" VALUES (236, 12, '703-712');
INSERT INTO "Article" VALUES (237, 12, '409-410');
INSERT INTO "Article" VALUES (238, 13, '1-30');
INSERT INTO "Article" VALUES (239, 13, '149-168');
INSERT INTO "Article" VALUES (240, 13, '211-221');
INSERT INTO "Article" VALUES (241, 13, '373-386');
INSERT INTO "Article" VALUES (242, 13, '341-362');
INSERT INTO "Article" VALUES (243, 13, '287-304');
INSERT INTO "Article" VALUES (244, 13, '177-193');
INSERT INTO "Article" VALUES (245, 13, '103-117');
INSERT INTO "Article" VALUES (246, 13, '305-340');
INSERT INTO "Article" VALUES (247, 13, '57-60');
INSERT INTO "Article" VALUES (248, 13, '363-372');
INSERT INTO "Article" VALUES (249, 13, '223-232');
INSERT INTO "Article" VALUES (250, 13, '259-285');
INSERT INTO "Article" VALUES (251, 13, '31-55');
INSERT INTO "Article" VALUES (252, 13, '241-258');
INSERT INTO "Article" VALUES (253, 13, '61-77');
INSERT INTO "Article" VALUES (254, 13, '195-210');
INSERT INTO "Article" VALUES (255, 13, '169-176');
INSERT INTO "Article" VALUES (256, 13, '80-101');
INSERT INTO "Article" VALUES (257, 14, '255-266');
INSERT INTO "Article" VALUES (258, 14, '545-565');
INSERT INTO "Article" VALUES (259, 14, '689-696');
INSERT INTO "Article" VALUES (260, 14, '149-162');
INSERT INTO "Article" VALUES (261, 14, '597-605');
INSERT INTO "Article" VALUES (262, 14, '217-221');
INSERT INTO "Article" VALUES (263, 14, '267-288');
INSERT INTO "Article" VALUES (264, 14, '111-117');
INSERT INTO "Article" VALUES (265, 14, '567-583');
INSERT INTO "Article" VALUES (266, 14, '67-98');
INSERT INTO "Article" VALUES (267, 14, '311-323');
INSERT INTO "Article" VALUES (268, 14, '177-192');
INSERT INTO "Article" VALUES (269, 14, '361-392');
INSERT INTO "Article" VALUES (270, 14, '289-309');
INSERT INTO "Article" VALUES (271, 14, '487-505');
INSERT INTO "Article" VALUES (272, 14, '507-527');
INSERT INTO "Article" VALUES (273, 14, '245-253');
INSERT INTO "Article" VALUES (274, 14, '325-356');
INSERT INTO "Article" VALUES (275, 14, '119-125');
INSERT INTO "Article" VALUES (276, 14, '529-544');
INSERT INTO "Article" VALUES (277, 14, '621-642');
INSERT INTO "Article" VALUES (278, 14, '657-678');
INSERT INTO "Article" VALUES (279, 15, '793-811');
INSERT INTO "Article" VALUES (280, 15, '531-564');
INSERT INTO "Article" VALUES (281, 15, '565-586');
INSERT INTO "Article" VALUES (282, 15, '721-734');
INSERT INTO "Article" VALUES (283, 15, '235-259');
INSERT INTO "Article" VALUES (284, 15, '89-116');
INSERT INTO "Article" VALUES (285, 15, '131-153');
INSERT INTO "Article" VALUES (286, 15, '45-88');
INSERT INTO "Article" VALUES (287, 15, '673-693');
INSERT INTO "Article" VALUES (288, 15, '847-858');
INSERT INTO "Article" VALUES (289, 15, '325-342');
INSERT INTO "Article" VALUES (290, 15, '367-408');
INSERT INTO "Article" VALUES (291, 15, '649-671');
INSERT INTO "Article" VALUES (292, 15, '621-648');
INSERT INTO "Article" VALUES (293, 15, '155-234');
INSERT INTO "Article" VALUES (294, 15, '813-838');
INSERT INTO "Article" VALUES (295, 15, '261-276');
INSERT INTO "Article" VALUES (296, 15, '489-529');
INSERT INTO "Article" VALUES (297, 15, '839-845');
INSERT INTO "Article" VALUES (298, 16, '499-552');
INSERT INTO "Article" VALUES (299, 16, '165-192');
INSERT INTO "Article" VALUES (300, 16, '61-106');
INSERT INTO "Article" VALUES (301, 16, '553-569');
INSERT INTO "Article" VALUES (302, 16, '107-125');
INSERT INTO "Article" VALUES (303, 16, '327-337');
INSERT INTO "Article" VALUES (304, 16, '193-220');
INSERT INTO "Article" VALUES (305, 16, '449-471');
INSERT INTO "Article" VALUES (306, 16, '221-260');
INSERT INTO "Article" VALUES (307, 16, '51-60');
INSERT INTO "Article" VALUES (308, 16, '261-295');
INSERT INTO "Article" VALUES (309, 16, '419-447');
INSERT INTO "Article" VALUES (310, 16, '25-49');
INSERT INTO "Article" VALUES (311, 16, '129-163');
INSERT INTO "Article" VALUES (312, 16, '339-346');
INSERT INTO "Article" VALUES (313, 17, '307-310');
INSERT INTO "Article" VALUES (314, 17, '64-78');
INSERT INTO "Article" VALUES (315, 17, '190-199');
INSERT INTO "Article" VALUES (316, 17, '35-63');
INSERT INTO "Article" VALUES (317, 17, '253-269');
INSERT INTO "Article" VALUES (318, 17, '79-110');
INSERT INTO "Article" VALUES (319, 17, '336-344');
INSERT INTO "Article" VALUES (320, 17, '320-335');
INSERT INTO "Article" VALUES (321, 17, '145-158');
INSERT INTO "Article" VALUES (322, 17, '159-172');
INSERT INTO "Article" VALUES (323, 17, '111-114');
INSERT INTO "Article" VALUES (324, 17, '200-213');
INSERT INTO "Article" VALUES (325, 17, '360-374');
INSERT INTO "Article" VALUES (326, 17, '139-144');
INSERT INTO "Article" VALUES (327, 17, '26-34');
INSERT INTO "Article" VALUES (328, 17, '1-13');
INSERT INTO "Article" VALUES (329, 17, '311-319');
INSERT INTO "Article" VALUES (330, 17, '14-25');
INSERT INTO "Article" VALUES (331, 17, '242-252');
INSERT INTO "Article" VALUES (332, 18, '187-209');
INSERT INTO "Article" VALUES (333, 18, '153-169');
INSERT INTO "Article" VALUES (334, 18, '77-88');
INSERT INTO "Article" VALUES (335, 18, '297-316');
INSERT INTO "Article" VALUES (336, 18, '407-415');
INSERT INTO "Article" VALUES (337, 18, '341-355');
INSERT INTO "Article" VALUES (338, 18, '89-94');
INSERT INTO "Article" VALUES (339, 18, '365-386');
INSERT INTO "Article" VALUES (340, 18, '357-359');
INSERT INTO "Article" VALUES (341, 18, '387-395');
INSERT INTO "Article" VALUES (342, 18, '227-249');
INSERT INTO "Article" VALUES (343, 18, '251-275');
INSERT INTO "Article" VALUES (344, 18, '95-108');
INSERT INTO "Article" VALUES (345, 18, '277-296');
INSERT INTO "Article" VALUES (346, 18, '361-364');
INSERT INTO "Article" VALUES (347, 18, '133-151');
INSERT INTO "Article" VALUES (348, 19, '299-312');
INSERT INTO "Article" VALUES (349, 19, '415-458');
INSERT INTO "Article" VALUES (350, 19, '545-596');
INSERT INTO "Article" VALUES (351, 19, '27-29');
INSERT INTO "Article" VALUES (352, 19, '459-476');
INSERT INTO "Article" VALUES (353, 19, '375-393');
INSERT INTO "Article" VALUES (354, 19, '647-679');
INSERT INTO "Article" VALUES (355, 19, '255-270');
INSERT INTO "Article" VALUES (356, 19, '79-92');
INSERT INTO "Article" VALUES (357, 19, '61-78');
INSERT INTO "Article" VALUES (358, 19, '705-778');
INSERT INTO "Article" VALUES (359, 19, '155-170');
INSERT INTO "Article" VALUES (360, 19, '1-26');
INSERT INTO "Article" VALUES (361, 19, '509-543');
INSERT INTO "Article" VALUES (362, 19, '145-153');
INSERT INTO "Article" VALUES (363, 19, '117-144');
INSERT INTO "Article" VALUES (364, 19, '779-792');
INSERT INTO "Article" VALUES (365, 19, '209-270');
INSERT INTO "Article" VALUES (366, 19, '681-703');
INSERT INTO "Article" VALUES (367, 19, '627-645');
INSERT INTO "Article" VALUES (368, 19, '93-115');
INSERT INTO "Article" VALUES (369, 19, '477-489');
INSERT INTO "Article" VALUES (370, 19, '491-507');
INSERT INTO "Article" VALUES (371, 19, '597-609');
INSERT INTO "Article" VALUES (372, 19, '285-298');
INSERT INTO "Article" VALUES (373, 20, '761-803');
INSERT INTO "Article" VALUES (374, 20, '913-926');
INSERT INTO "Article" VALUES (375, 20, '617-663');
INSERT INTO "Article" VALUES (376, 20, '545-590');
INSERT INTO "Article" VALUES (377, 20, '817-835');
INSERT INTO "Article" VALUES (378, 20, '295-334');
INSERT INTO "Article" VALUES (379, 20, '1-65');
INSERT INTO "Article" VALUES (380, 20, '673-692');
INSERT INTO "Article" VALUES (381, 20, '425-446');
INSERT INTO "Article" VALUES (382, 20, '665-672');
INSERT INTO "Article" VALUES (383, 20, '489-510');
INSERT INTO "Article" VALUES (384, 20, '591-616');
INSERT INTO "Article" VALUES (385, 20, '1007-1029');
INSERT INTO "Article" VALUES (386, 20, '233-256');
INSERT INTO "Article" VALUES (387, 20, '511-544');
INSERT INTO "Article" VALUES (388, 20, '721-734');
INSERT INTO "Article" VALUES (389, 20, '693-719');
INSERT INTO "Article" VALUES (390, 20, '927-982');
INSERT INTO "Article" VALUES (391, 20, '463-487');
INSERT INTO "Article" VALUES (392, 20, '805-815');
INSERT INTO "Article" VALUES (393, 20, '173-213');
INSERT INTO "Article" VALUES (394, 20, '97-141');
INSERT INTO "Article" VALUES (395, 20, '335-374');
INSERT INTO "Article" VALUES (396, 20, '267-286');
INSERT INTO "Article" VALUES (397, 20, '67-96');
INSERT INTO "Article" VALUES (398, 20, '983-1006');
INSERT INTO "Article" VALUES (399, 20, '257-266');
INSERT INTO "Article" VALUES (400, 21, '87-137');
INSERT INTO "Article" VALUES (401, 21, '433-474');
INSERT INTO "Article" VALUES (402, 21, '561-590');
INSERT INTO "Article" VALUES (403, 21, '285-295');
INSERT INTO "Article" VALUES (404, 21, '533-547');
INSERT INTO "Article" VALUES (405, 21, '255-284');
INSERT INTO "Article" VALUES (406, 21, '209-235');
INSERT INTO "Article" VALUES (407, 21, '591-607');
INSERT INTO "Article" VALUES (408, 21, '1-28');
INSERT INTO "Article" VALUES (409, 21, '57-72');
INSERT INTO "Article" VALUES (410, 21, '43-55');
INSERT INTO "Article" VALUES (411, 21, '403-432');
INSERT INTO "Article" VALUES (412, 21, '169-191');
INSERT INTO "Article" VALUES (413, 21, '139-154');
INSERT INTO "Article" VALUES (414, 21, '29-42');
INSERT INTO "Article" VALUES (415, 21, '331-360');
INSERT INTO "Article" VALUES (416, 21, '237-254');
INSERT INTO "Article" VALUES (417, 21, '193-207');
INSERT INTO "Article" VALUES (418, 21, '375-401');
INSERT INTO "Article" VALUES (419, 21, '297-330');
INSERT INTO "Article" VALUES (420, 22, '167-191');
INSERT INTO "Article" VALUES (421, 22, '309-318');
INSERT INTO "Article" VALUES (422, 22, '1-2');
INSERT INTO "Article" VALUES (423, 22, '281-302');
INSERT INTO "Article" VALUES (424, 22, '209-217');
INSERT INTO "Article" VALUES (425, 22, '3-17');
INSERT INTO "Article" VALUES (426, 22, '129-139');
INSERT INTO "Article" VALUES (427, 22, '219-232');
INSERT INTO "Article" VALUES (428, 22, '19-66');
INSERT INTO "Article" VALUES (429, 22, '115-127');
INSERT INTO "Article" VALUES (430, 22, '83-98');
INSERT INTO "Article" VALUES (431, 22, '447-470');
INSERT INTO "Article" VALUES (432, 22, '303-307');
INSERT INTO "Article" VALUES (433, 22, '347-363');
INSERT INTO "Article" VALUES (434, 22, '67-81');
INSERT INTO "Article" VALUES (435, 22, '147-152');
INSERT INTO "Article" VALUES (436, 22, '251-263');
INSERT INTO "Article" VALUES (437, 22, '141-145');
INSERT INTO "Article" VALUES (438, 23, '279-320');
INSERT INTO "Article" VALUES (439, 23, '441-465');
INSERT INTO "Article" VALUES (440, 23, '211-236');
INSERT INTO "Article" VALUES (441, 23, '33-42');
INSERT INTO "Article" VALUES (442, 23, '131-154');
INSERT INTO "Article" VALUES (443, 23, '177-191');
INSERT INTO "Article" VALUES (444, 23, '1-31');
INSERT INTO "Article" VALUES (445, 23, '467-477');
INSERT INTO "Article" VALUES (446, 23, '403-439');
INSERT INTO "Article" VALUES (447, 23, '565-591');
INSERT INTO "Article" VALUES (448, 23, '93-130');
INSERT INTO "Article" VALUES (449, 23, '593-608');
INSERT INTO "Article" VALUES (450, 23, '155-175');
INSERT INTO "Article" VALUES (451, 23, '193-210');
INSERT INTO "Article" VALUES (452, 23, '321-382');
INSERT INTO "Article" VALUES (453, 23, '383-402');
INSERT INTO "Article" VALUES (454, 24, '113-123');
INSERT INTO "Article" VALUES (455, 24, '1-20');
INSERT INTO "Article" VALUES (456, 24, '61-73');
INSERT INTO "Article" VALUES (457, 24, '145-152');
INSERT INTO "Article" VALUES (458, 24, '325-334');
INSERT INTO "Article" VALUES (459, 24, '125-144');
INSERT INTO "Article" VALUES (460, 24, '335-340');
INSERT INTO "Article" VALUES (461, 24, '75-96');
INSERT INTO "Article" VALUES (462, 24, '193-199');
INSERT INTO "Article" VALUES (463, 24, '243-266');
INSERT INTO "Article" VALUES (464, 24, '221-242');
INSERT INTO "Article" VALUES (465, 24, '303-314');
INSERT INTO "Article" VALUES (466, 24, '177-192');
INSERT INTO "Article" VALUES (467, 24, '267-283');
INSERT INTO "Article" VALUES (468, 24, '37-59');
INSERT INTO "Article" VALUES (469, 24, '371-382');
INSERT INTO "Article" VALUES (470, 24, '21-36');
INSERT INTO "Article" VALUES (471, 24, '315-324');
INSERT INTO "Article" VALUES (472, 24, '97-112');
INSERT INTO "Article" VALUES (473, 25, '265-283');
INSERT INTO "Article" VALUES (474, 25, '155-170');
INSERT INTO "Article" VALUES (475, 25, '293-295');
INSERT INTO "Article" VALUES (476, 25, '321-345');
INSERT INTO "Article" VALUES (477, 25, '347-355');
INSERT INTO "Article" VALUES (478, 25, '1-23');
INSERT INTO "Article" VALUES (479, 25, '385-397');
INSERT INTO "Article" VALUES (480, 25, '43-45');
INSERT INTO "Article" VALUES (481, 25, '243-263');
INSERT INTO "Article" VALUES (482, 25, '171-186');
INSERT INTO "Article" VALUES (483, 25, '365-383');
INSERT INTO "Article" VALUES (484, 25, '25-35');
INSERT INTO "Article" VALUES (485, 25, '47-57');
INSERT INTO "Article" VALUES (486, 25, '37-41');
INSERT INTO "Article" VALUES (487, 25, '101-122');
INSERT INTO "Article" VALUES (488, 25, '297-319');
INSERT INTO "Article" VALUES (489, 25, '59-73');
INSERT INTO "Article" VALUES (490, 25, '203-216');
INSERT INTO "Article" VALUES (491, 25, '123-133');
INSERT INTO "Article" VALUES (492, 26, '295-298');
INSERT INTO "Article" VALUES (493, 26, '371-389');
INSERT INTO "Article" VALUES (494, 26, '119-133');
INSERT INTO "Article" VALUES (495, 26, '271-294');
INSERT INTO "Article" VALUES (496, 26, '1-20');
INSERT INTO "Article" VALUES (497, 26, '21-37');
INSERT INTO "Article" VALUES (498, 26, '243-255');
INSERT INTO "Article" VALUES (499, 26, '359-369');
INSERT INTO "Article" VALUES (500, 26, '63-86');
INSERT INTO "Article" VALUES (501, 26, '87-106');
INSERT INTO "Article" VALUES (502, 26, '195-220');
INSERT INTO "Article" VALUES (503, 26, '39-62');
INSERT INTO "Article" VALUES (504, 26, '391-403');
INSERT INTO "Article" VALUES (505, 26, '299-315');
INSERT INTO "Article" VALUES (506, 26, '135-155');
INSERT INTO "Article" VALUES (507, 26, '221-242');
INSERT INTO "Article" VALUES (508, 26, '107-117');
INSERT INTO "Article" VALUES (509, 27, '643-655');
INSERT INTO "Article" VALUES (510, 27, '559-576');
INSERT INTO "Article" VALUES (511, 27, '213-239');
INSERT INTO "Article" VALUES (512, 27, '131-192');
INSERT INTO "Article" VALUES (513, 27, '349-362');
INSERT INTO "Article" VALUES (514, 27, '287-308');
INSERT INTO "Article" VALUES (515, 27, '577-595');
INSERT INTO "Article" VALUES (516, 27, '285');
INSERT INTO "Article" VALUES (517, 27, '241-267');
INSERT INTO "Article" VALUES (518, 27, '381-407');
INSERT INTO "Article" VALUES (519, 27, '279-284');
INSERT INTO "Article" VALUES (520, 27, '543-557');
INSERT INTO "Article" VALUES (521, 27, '25-57');
INSERT INTO "Article" VALUES (522, 27, '309-332');
INSERT INTO "Article" VALUES (523, 27, '485-499');
INSERT INTO "Article" VALUES (524, 27, '711-740');
INSERT INTO "Article" VALUES (525, 27, '473-484');
INSERT INTO "Article" VALUES (526, 27, '527-542');
INSERT INTO "Article" VALUES (527, 27, '439-471');
INSERT INTO "Article" VALUES (528, 27, '503-525');
INSERT INTO "Article" VALUES (529, 27, '771-785');
INSERT INTO "Article" VALUES (530, 27, '1-17');
INSERT INTO "Article" VALUES (531, 27, '787');
INSERT INTO "Article" VALUES (532, 27, '657-677');
INSERT INTO "Article" VALUES (533, 27, '741-748');
INSERT INTO "Article" VALUES (534, 27, '749-769');
INSERT INTO "Article" VALUES (535, 27, '421-438');
INSERT INTO "Article" VALUES (536, 27, '123-130');
INSERT INTO "Article" VALUES (537, 27, '269-277');
INSERT INTO "Article" VALUES (538, 27, '363-379');
INSERT INTO "Article" VALUES (539, 28, '3-4');
INSERT INTO "Article" VALUES (540, 28, '133-152');
INSERT INTO "Article" VALUES (541, 28, '305-336');
INSERT INTO "Article" VALUES (542, 28, '443-482');
INSERT INTO "Article" VALUES (543, 28, '207-234');
INSERT INTO "Article" VALUES (544, 28, '483-495');
INSERT INTO "Article" VALUES (545, 28, '497-524');
INSERT INTO "Article" VALUES (546, 28, '1-2');
INSERT INTO "Article" VALUES (547, 28, '299-301');
INSERT INTO "Article" VALUES (548, 28, '109-132');
INSERT INTO "Article" VALUES (549, 28, '175-205');
INSERT INTO "Article" VALUES (550, 28, '559-571');
INSERT INTO "Article" VALUES (551, 28, '393-442');
INSERT INTO "Article" VALUES (552, 28, '573-592');
INSERT INTO "Article" VALUES (553, 28, '525-557');
INSERT INTO "Article" VALUES (554, 28, '153-174');
INSERT INTO "Article" VALUES (555, 28, '35-60');
INSERT INTO "Article" VALUES (556, 29, '379-395');
INSERT INTO "Article" VALUES (557, 29, '595-627');
INSERT INTO "Article" VALUES (558, 29, '579-588');
INSERT INTO "Article" VALUES (559, 29, '67-83');
INSERT INTO "Article" VALUES (560, 29, '85-100');
INSERT INTO "Article" VALUES (561, 29, '35-45');
INSERT INTO "Article" VALUES (562, 29, '475-498');
INSERT INTO "Article" VALUES (563, 29, '171-186');
INSERT INTO "Article" VALUES (564, 29, '253-275');
INSERT INTO "Article" VALUES (565, 29, '433-449');
INSERT INTO "Article" VALUES (566, 29, '347-377');
INSERT INTO "Article" VALUES (567, 29, '699-707');
INSERT INTO "Article" VALUES (568, 29, '203-227');
INSERT INTO "Article" VALUES (569, 29, '499-536');
INSERT INTO "Article" VALUES (570, 29, '47-66');
INSERT INTO "Article" VALUES (571, 29, '229-240');
INSERT INTO "Article" VALUES (572, 29, '277-310');
INSERT INTO "Article" VALUES (573, 29, '537-578');
INSERT INTO "Article" VALUES (574, 29, '115-123');
INSERT INTO "Article" VALUES (575, 29, '125-138');
INSERT INTO "Article" VALUES (576, 29, '589-594');
INSERT INTO "Article" VALUES (577, 29, '1-14');
INSERT INTO "Article" VALUES (578, 29, '149-169');
INSERT INTO "Article" VALUES (579, 29, '663-678');
INSERT INTO "Article" VALUES (580, 29, '187-201');
INSERT INTO "Article" VALUES (581, 29, '15-33');
INSERT INTO "Article" VALUES (582, 29, '241-251');
INSERT INTO "Article" VALUES (583, 29, '139-148');
INSERT INTO "Article" VALUES (584, 29, '421-432');
INSERT INTO "Article" VALUES (585, 30, '31-45');
INSERT INTO "Article" VALUES (586, 30, '335-344');
INSERT INTO "Article" VALUES (587, 30, '393-409');
INSERT INTO "Article" VALUES (588, 30, '17-30');
INSERT INTO "Article" VALUES (589, 30, '227-253');
INSERT INTO "Article" VALUES (590, 30, '345-359');
INSERT INTO "Article" VALUES (591, 30, '207-225');
INSERT INTO "Article" VALUES (592, 30, '289-298');
INSERT INTO "Article" VALUES (593, 30, '319-334');
INSERT INTO "Article" VALUES (594, 30, '135-147');
INSERT INTO "Article" VALUES (595, 30, '361-376');
INSERT INTO "Article" VALUES (596, 30, '149-169');
INSERT INTO "Article" VALUES (597, 30, '431-448');
INSERT INTO "Article" VALUES (598, 30, '1-15');
INSERT INTO "Article" VALUES (599, 30, '449-466');
INSERT INTO "Article" VALUES (600, 30, '181-206');
INSERT INTO "Article" VALUES (601, 30, '377-392');
INSERT INTO "Article" VALUES (602, 30, '171-179');
INSERT INTO "Article" VALUES (603, 31, '363-370');
INSERT INTO "Article" VALUES (604, 31, '45-56');
INSERT INTO "Article" VALUES (605, 31, '199-217');
INSERT INTO "Article" VALUES (606, 31, '63-85');
INSERT INTO "Article" VALUES (607, 31, '87-91');
INSERT INTO "Article" VALUES (608, 31, '347-362');
INSERT INTO "Article" VALUES (609, 31, '125-138');
INSERT INTO "Article" VALUES (610, 31, '427-464');
INSERT INTO "Article" VALUES (611, 31, '1-13');
INSERT INTO "Article" VALUES (612, 31, '161-197');
INSERT INTO "Article" VALUES (613, 31, '303-308');
INSERT INTO "Article" VALUES (614, 31, '275-302');
INSERT INTO "Article" VALUES (615, 31, '57-62');
INSERT INTO "Article" VALUES (616, 31, '371-426');
INSERT INTO "Article" VALUES (617, 31, '15-30');
INSERT INTO "Article" VALUES (618, 31, '237-252');
INSERT INTO "Article" VALUES (619, 32, '203-213');
INSERT INTO "Article" VALUES (620, 32, '351-367');
INSERT INTO "Article" VALUES (621, 32, '503-535');
INSERT INTO "Article" VALUES (622, 32, '609-678');
INSERT INTO "Article" VALUES (623, 32, '103-129');
INSERT INTO "Article" VALUES (624, 32, '303-350');
INSERT INTO "Article" VALUES (625, 32, '61-87');
INSERT INTO "Article" VALUES (626, 32, '441-457');
INSERT INTO "Article" VALUES (627, 32, '181-202');
INSERT INTO "Article" VALUES (628, 32, '679-700');
INSERT INTO "Article" VALUES (629, 32, '459-466');
INSERT INTO "Article" VALUES (630, 32, '467-487');
INSERT INTO "Article" VALUES (631, 32, '773-785');
INSERT INTO "Article" VALUES (632, 32, '385-395');
INSERT INTO "Article" VALUES (633, 32, '369-384');
INSERT INTO "Article" VALUES (634, 32, '409-423');
INSERT INTO "Article" VALUES (635, 32, '397-403');
INSERT INTO "Article" VALUES (636, 32, '701-739');
INSERT INTO "Article" VALUES (637, 32, '279-302');
INSERT INTO "Article" VALUES (638, 32, '147-180');
INSERT INTO "Article" VALUES (639, 33, '347-366');
INSERT INTO "Article" VALUES (640, 33, '337-346');
INSERT INTO "Article" VALUES (641, 33, '773-803');
INSERT INTO "Article" VALUES (642, 33, '805-835');
INSERT INTO "Article" VALUES (643, 33, '109-133');
INSERT INTO "Article" VALUES (644, 33, '217-230');
INSERT INTO "Article" VALUES (645, 33, '167-189');
INSERT INTO "Article" VALUES (646, 33, '151-166');
INSERT INTO "Article" VALUES (647, 33, '837-857');
INSERT INTO "Article" VALUES (648, 33, '653-665');
INSERT INTO "Article" VALUES (649, 33, '389-410');
INSERT INTO "Article" VALUES (650, 33, '667-686');
INSERT INTO "Article" VALUES (651, 33, '191-209');
INSERT INTO "Article" VALUES (652, 33, '85-107');
INSERT INTO "Article" VALUES (653, 33, '267-289');
INSERT INTO "Article" VALUES (654, 33, '1-22');
INSERT INTO "Article" VALUES (655, 33, '411-428');
INSERT INTO "Article" VALUES (656, 33, '557-578');
INSERT INTO "Article" VALUES (657, 33, '491-541');
INSERT INTO "Article" VALUES (658, 33, '367-388');
INSERT INTO "Article" VALUES (659, 33, '859-879');
INSERT INTO "Article" VALUES (660, 33, '579-595');
INSERT INTO "Article" VALUES (661, 33, '291-324');
INSERT INTO "Article" VALUES (662, 34, '293-307');
INSERT INTO "Article" VALUES (663, 34, '31-59');
INSERT INTO "Article" VALUES (664, 34, '273-292');
INSERT INTO "Article" VALUES (665, 34, '195-216');
INSERT INTO "Article" VALUES (666, 34, '243-261');
INSERT INTO "Article" VALUES (667, 34, '1-21');
INSERT INTO "Article" VALUES (668, 34, '183-193');
INSERT INTO "Article" VALUES (669, 34, '331-343');
INSERT INTO "Article" VALUES (670, 34, '23-29');
INSERT INTO "Article" VALUES (671, 34, '377-390');
INSERT INTO "Article" VALUES (672, 34, '105-119');
INSERT INTO "Article" VALUES (673, 34, '133-157');
INSERT INTO "Article" VALUES (674, 34, '171-181');
INSERT INTO "Article" VALUES (675, 34, '355-376');
INSERT INTO "Article" VALUES (676, 34, '121-132');
INSERT INTO "Article" VALUES (677, 34, '309-329');
INSERT INTO "Article" VALUES (678, 34, '61-71');
INSERT INTO "Article" VALUES (679, 35, '237-255');
INSERT INTO "Article" VALUES (680, 35, '353-375');
INSERT INTO "Article" VALUES (681, 35, '257-271');
INSERT INTO "Article" VALUES (682, 35, '387-394');
INSERT INTO "Article" VALUES (683, 35, '297-332');
INSERT INTO "Article" VALUES (684, 36, '249-252');
INSERT INTO "Article" VALUES (685, 36, '253-282');
INSERT INTO "Article" VALUES (686, 36, '180-188');
INSERT INTO "Article" VALUES (687, 36, '311-333');
INSERT INTO "Article" VALUES (688, 36, '283-291');
INSERT INTO "Article" VALUES (689, 36, '189-190');
INSERT INTO "Article" VALUES (690, 36, '191-213');
INSERT INTO "Article" VALUES (691, 36, '214-248');
INSERT INTO "Article" VALUES (692, 36, '293-309');
INSERT INTO "Article" VALUES (693, 36, '50-63');
INSERT INTO "Article" VALUES (694, 36, '162-171');
INSERT INTO "Article" VALUES (695, 36, '383-393');
INSERT INTO "Article" VALUES (696, 36, '172-179');
INSERT INTO "Article" VALUES (697, 36, '1-11');
INSERT INTO "Article" VALUES (698, 36, '143-161');
INSERT INTO "Article" VALUES (699, 36, '12-39');
INSERT INTO "Article" VALUES (700, 36, '97-109');
INSERT INTO "Article" VALUES (701, 36, '40-49');
INSERT INTO "Article" VALUES (702, 37, '329-340');
INSERT INTO "Article" VALUES (703, 37, '341-378');
INSERT INTO "Article" VALUES (704, 37, '513-524');
INSERT INTO "Article" VALUES (705, 37, '651-671');
INSERT INTO "Article" VALUES (706, 37, '105-135');
INSERT INTO "Article" VALUES (707, 37, '697-718');
INSERT INTO "Article" VALUES (708, 37, '719-728');
INSERT INTO "Article" VALUES (709, 37, '137-160');
INSERT INTO "Article" VALUES (710, 37, '559-571');
INSERT INTO "Article" VALUES (711, 37, '573-600');
INSERT INTO "Article" VALUES (712, 37, '431-477');
INSERT INTO "Article" VALUES (713, 37, '235-260');
INSERT INTO "Article" VALUES (714, 37, '629-650');
INSERT INTO "Article" VALUES (715, 37, '379-397');
INSERT INTO "Article" VALUES (716, 37, '161-206');
INSERT INTO "Article" VALUES (717, 37, '1-3');
INSERT INTO "Article" VALUES (718, 37, '479-502');
INSERT INTO "Article" VALUES (719, 37, '503-512');
INSERT INTO "Article" VALUES (720, 37, '55-80');
INSERT INTO "Article" VALUES (721, 37, '539-557');
INSERT INTO "Article" VALUES (722, 37, '729-740');
INSERT INTO "Article" VALUES (723, 37, '775-792');
INSERT INTO "Article" VALUES (724, 37, '601-627');
INSERT INTO "Article" VALUES (725, 37, '5-26');
INSERT INTO "Article" VALUES (726, 37, '301-313');
INSERT INTO "Article" VALUES (727, 37, '741-760');
INSERT INTO "Article" VALUES (728, 38, '109-158');
INSERT INTO "Article" VALUES (729, 38, '305-320');
INSERT INTO "Article" VALUES (730, 38, '1-31');
INSERT INTO "Article" VALUES (731, 38, '227-243');
INSERT INTO "Article" VALUES (732, 38, '245-284');
INSERT INTO "Article" VALUES (733, 38, '339-369');
INSERT INTO "Article" VALUES (734, 38, '377-400');
INSERT INTO "Article" VALUES (735, 38, '95-108');
INSERT INTO "Article" VALUES (736, 38, '371-375');
INSERT INTO "Article" VALUES (737, 38, '33-61');
INSERT INTO "Article" VALUES (738, 38, '177-185');
INSERT INTO "Article" VALUES (739, 38, '159-175');
INSERT INTO "Article" VALUES (740, 38, '73-94');
INSERT INTO "Article" VALUES (741, 39, '1-15');
INSERT INTO "Article" VALUES (742, 39, '737-760');
INSERT INTO "Article" VALUES (743, 39, '761-778');
INSERT INTO "Article" VALUES (744, 39, '623-643');
INSERT INTO "Article" VALUES (745, 39, '779-791');
INSERT INTO "Article" VALUES (746, 39, '383-394');
INSERT INTO "Article" VALUES (747, 39, '63-94');
INSERT INTO "Article" VALUES (748, 39, '645-662');
INSERT INTO "Article" VALUES (749, 39, '109-120');
INSERT INTO "Article" VALUES (750, 39, '281-302');
INSERT INTO "Article" VALUES (751, 39, '335-373');
INSERT INTO "Article" VALUES (752, 39, '545-554');
INSERT INTO "Article" VALUES (753, 39, '499-522');
INSERT INTO "Article" VALUES (754, 39, '375-382');
INSERT INTO "Article" VALUES (755, 39, '461-481');
INSERT INTO "Article" VALUES (756, 39, '663-687');
INSERT INTO "Article" VALUES (757, 39, '241-265');
INSERT INTO "Article" VALUES (758, 39, '555-578');
INSERT INTO "Article" VALUES (759, 39, '17-31');
INSERT INTO "Article" VALUES (760, 39, '523-543');
INSERT INTO "Article" VALUES (761, 39, '395-414');
INSERT INTO "Article" VALUES (762, 39, '161-210');
INSERT INTO "Article" VALUES (763, 39, '267-280');
INSERT INTO "Article" VALUES (764, 39, '303-334');
INSERT INTO "Article" VALUES (765, 39, '443-460');
INSERT INTO "Article" VALUES (766, 39, '121-160');
INSERT INTO "Article" VALUES (767, 39, '595-621');
INSERT INTO "Article" VALUES (768, 39, '689-736');
INSERT INTO "Article" VALUES (769, 39, '95-107');
INSERT INTO "Article" VALUES (770, 40, '1-9');
INSERT INTO "Article" VALUES (771, 40, '271-292');
INSERT INTO "Article" VALUES (772, 40, '107-116');
INSERT INTO "Article" VALUES (773, 40, '87-106');
INSERT INTO "Article" VALUES (774, 40, '11-47');
INSERT INTO "Article" VALUES (775, 40, '293-298');
INSERT INTO "Article" VALUES (776, 40, '311-319');
INSERT INTO "Article" VALUES (777, 40, '193-200');
INSERT INTO "Article" VALUES (778, 40, '243-269');
INSERT INTO "Article" VALUES (779, 40, '373-386');
INSERT INTO "Article" VALUES (780, 40, '183-192');
INSERT INTO "Article" VALUES (781, 40, '201-211');
INSERT INTO "Article" VALUES (782, 40, '145-182');
INSERT INTO "Article" VALUES (783, 40, '49-53');
INSERT INTO "Article" VALUES (784, 40, '299-310');
INSERT INTO "Article" VALUES (785, 40, '231-243');
INSERT INTO "Article" VALUES (786, 40, '77-85');
INSERT INTO "Article" VALUES (787, 40, '359-371');
INSERT INTO "Article" VALUES (788, 41, '297-304');
INSERT INTO "Article" VALUES (789, 41, '151-166');
INSERT INTO "Article" VALUES (790, 41, '221-233');
INSERT INTO "Article" VALUES (791, 41, '35-55');
INSERT INTO "Article" VALUES (792, 41, '57-84');
INSERT INTO "Article" VALUES (793, 41, '385-395');
INSERT INTO "Article" VALUES (794, 41, '325-338');
INSERT INTO "Article" VALUES (795, 41, '85-96');
INSERT INTO "Article" VALUES (796, 41, '377-384');
INSERT INTO "Article" VALUES (797, 41, '97-113');
INSERT INTO "Article" VALUES (798, 41, '1-11');
INSERT INTO "Article" VALUES (799, 41, '13-33');
INSERT INTO "Article" VALUES (800, 41, '357-367');
INSERT INTO "Article" VALUES (801, 41, '183-194');
INSERT INTO "Article" VALUES (802, 41, '115-150');
INSERT INTO "Article" VALUES (803, 41, '397-407');
INSERT INTO "Article" VALUES (804, 41, '305-324');
INSERT INTO "Article" VALUES (805, 42, '21-37');
INSERT INTO "Article" VALUES (806, 42, '59-66');
INSERT INTO "Article" VALUES (807, 42, '53-58');
INSERT INTO "Article" VALUES (808, 42, '383-408');
INSERT INTO "Article" VALUES (809, 42, '67-86');
INSERT INTO "Article" VALUES (810, 42, '141-154');
INSERT INTO "Article" VALUES (811, 42, '155-168');
INSERT INTO "Article" VALUES (812, 42, '365-378');
INSERT INTO "Article" VALUES (813, 42, '115-139');
INSERT INTO "Article" VALUES (814, 42, '229-256');
INSERT INTO "Article" VALUES (815, 42, '205-224');
INSERT INTO "Article" VALUES (816, 42, '287-298');
INSERT INTO "Article" VALUES (817, 42, '39-52');
INSERT INTO "Article" VALUES (818, 42, '199-204');
INSERT INTO "Article" VALUES (819, 42, '325-346');
INSERT INTO "Article" VALUES (820, 42, '257-268');
INSERT INTO "Article" VALUES (821, 42, '299-324');
INSERT INTO "Article" VALUES (822, 42, '109-114');
INSERT INTO "Article" VALUES (823, 42, '269-285');
INSERT INTO "Article" VALUES (824, 43, '209-219');
INSERT INTO "Article" VALUES (825, 43, '375-389');
INSERT INTO "Article" VALUES (826, 43, '33-66');
INSERT INTO "Article" VALUES (827, 43, '133-146');
INSERT INTO "Article" VALUES (828, 43, '221-250');
INSERT INTO "Article" VALUES (829, 43, '251-277');
INSERT INTO "Article" VALUES (830, 43, '391-412');
INSERT INTO "Article" VALUES (831, 43, '1-31');
INSERT INTO "Article" VALUES (832, 43, '325-345');
INSERT INTO "Article" VALUES (833, 43, '313-323');
INSERT INTO "Article" VALUES (834, 44, '463-508');
INSERT INTO "Article" VALUES (835, 44, '191-205');
INSERT INTO "Article" VALUES (836, 44, '289-321');
INSERT INTO "Article" VALUES (837, 44, '571-590');
INSERT INTO "Article" VALUES (838, 44, '525-569');
INSERT INTO "Article" VALUES (839, 44, '323-344');
INSERT INTO "Article" VALUES (840, 44, '73');
INSERT INTO "Article" VALUES (841, 44, '377-425');
INSERT INTO "Article" VALUES (842, 44, '509-523');
INSERT INTO "Article" VALUES (843, 44, '23-39');
INSERT INTO "Article" VALUES (844, 44, '123-151');
INSERT INTO "Article" VALUES (845, 44, '1-21');
INSERT INTO "Article" VALUES (846, 44, '75-90');
INSERT INTO "Article" VALUES (847, 45, '21-42');
INSERT INTO "Article" VALUES (848, 45, '291-347');
INSERT INTO "Article" VALUES (849, 45, '553-581');
INSERT INTO "Article" VALUES (850, 45, '57-78');
INSERT INTO "Article" VALUES (851, 45, '389-418');
INSERT INTO "Article" VALUES (852, 45, '191-225');
INSERT INTO "Article" VALUES (853, 45, '83-141');
INSERT INTO "Article" VALUES (854, 45, '583-602');
INSERT INTO "Article" VALUES (855, 45, '603-616');
INSERT INTO "Article" VALUES (856, 45, '541-552');
INSERT INTO "Article" VALUES (857, 45, '501-514');
INSERT INTO "Article" VALUES (858, 45, '227-290');
INSERT INTO "Article" VALUES (859, 45, '143-190');
INSERT INTO "Article" VALUES (860, 45, '419-428');
INSERT INTO "Article" VALUES (861, 45, '639-671');
INSERT INTO "Article" VALUES (862, 46, '505-539');
INSERT INTO "Article" VALUES (863, 46, '813-857');
INSERT INTO "Article" VALUES (864, 46, '673-688');
INSERT INTO "Article" VALUES (865, 46, '1075-1096');
INSERT INTO "Article" VALUES (866, 46, '91-129');
INSERT INTO "Article" VALUES (867, 46, '211-243');
INSERT INTO "Article" VALUES (868, 46, '911-919');
INSERT INTO "Article" VALUES (869, 46, '625-636');
INSERT INTO "Article" VALUES (870, 46, '457-504');
INSERT INTO "Article" VALUES (871, 46, '709-727');
INSERT INTO "Article" VALUES (872, 46, '1-15');
INSERT INTO "Article" VALUES (873, 46, '775-793');
INSERT INTO "Article" VALUES (874, 46, '689-707');
INSERT INTO "Article" VALUES (875, 46, '595-624');
INSERT INTO "Article" VALUES (876, 46, '353-400');
INSERT INTO "Article" VALUES (877, 46, '181-210');
INSERT INTO "Article" VALUES (878, 46, '637-643');
INSERT INTO "Article" VALUES (879, 46, '645-664');
INSERT INTO "Article" VALUES (880, 46, '1007-1036');
INSERT INTO "Article" VALUES (881, 46, '293-327');
INSERT INTO "Article" VALUES (882, 46, '1037-1073');
INSERT INTO "Article" VALUES (883, 46, '859-874');
INSERT INTO "Article" VALUES (884, 46, '245-267');
INSERT INTO "Article" VALUES (885, 46, '795-811');
INSERT INTO "Article" VALUES (886, 46, '329-352');
INSERT INTO "Article" VALUES (887, 46, '131-165');
INSERT INTO "Article" VALUES (888, 47, '727-742');
INSERT INTO "Article" VALUES (889, 47, '329-354');
INSERT INTO "Article" VALUES (890, 47, '619-632');
INSERT INTO "Article" VALUES (891, 47, '449-465');
INSERT INTO "Article" VALUES (892, 47, '765-780');
INSERT INTO "Article" VALUES (893, 47, '511-540');
INSERT INTO "Article" VALUES (894, 47, '743-763');
INSERT INTO "Article" VALUES (895, 47, '653-670');
INSERT INTO "Article" VALUES (896, 47, '21-43');
INSERT INTO "Article" VALUES (897, 47, '831-879');
INSERT INTO "Article" VALUES (898, 47, '227-228');
INSERT INTO "Article" VALUES (899, 47, '121-144');
INSERT INTO "Article" VALUES (900, 47, '213-225');
INSERT INTO "Article" VALUES (901, 47, '45-81');
INSERT INTO "Article" VALUES (902, 47, '229-327');
INSERT INTO "Article" VALUES (903, 47, '563-595');
INSERT INTO "Article" VALUES (904, 47, '881-919');
INSERT INTO "Article" VALUES (905, 47, '355-383');
INSERT INTO "Article" VALUES (906, 47, '193-211');
INSERT INTO "Article" VALUES (907, 47, '1-19');
INSERT INTO "Article" VALUES (908, 47, '633-651');
INSERT INTO "Article" VALUES (909, 48, '481-503');
INSERT INTO "Article" VALUES (910, 48, '423-452');
INSERT INTO "Article" VALUES (911, 48, '73-80');
INSERT INTO "Article" VALUES (912, 48, '665-683');
INSERT INTO "Article" VALUES (913, 48, '369-380');
INSERT INTO "Article" VALUES (914, 48, '247-286');
INSERT INTO "Article" VALUES (915, 48, '453-480');
INSERT INTO "Article" VALUES (916, 48, '381-397');
INSERT INTO "Article" VALUES (917, 48, '725-747');
INSERT INTO "Article" VALUES (918, 48, '157-177');
INSERT INTO "Article" VALUES (919, 48, '195-215');
INSERT INTO "Article" VALUES (920, 48, '41-59');
INSERT INTO "Article" VALUES (921, 48, '125-156');
INSERT INTO "Article" VALUES (922, 48, '1-40');
INSERT INTO "Article" VALUES (923, 48, '179-191');
INSERT INTO "Article" VALUES (924, 48, '519-531');
INSERT INTO "Article" VALUES (925, 48, '583-625');
INSERT INTO "Article" VALUES (926, 48, '193-194');
INSERT INTO "Article" VALUES (927, 48, '685-696');
INSERT INTO "Article" VALUES (928, 48, '749-780');
INSERT INTO "Article" VALUES (929, 48, '505-517');
INSERT INTO "Article" VALUES (930, 48, '781-786');
INSERT INTO "Article" VALUES (931, 48, '97-124');
INSERT INTO "Article" VALUES (932, 48, '697-724');
INSERT INTO "Article" VALUES (933, 49, '31-70');
INSERT INTO "Article" VALUES (934, 49, '119-140');
INSERT INTO "Article" VALUES (935, 49, '579-595');
INSERT INTO "Article" VALUES (936, 49, '307-314');
INSERT INTO "Article" VALUES (937, 49, '1-29');
INSERT INTO "Article" VALUES (938, 49, '531-577');
INSERT INTO "Article" VALUES (939, 49, '97-117');
INSERT INTO "Article" VALUES (940, 49, '211-231');
INSERT INTO "Article" VALUES (941, 49, '451-468');
INSERT INTO "Article" VALUES (942, 49, '71-96');
INSERT INTO "Article" VALUES (943, 49, '315-389');
INSERT INTO "Article" VALUES (944, 49, '597-612');
INSERT INTO "Article" VALUES (945, 49, '143-209');
INSERT INTO "Article" VALUES (946, 49, '391-449');
INSERT INTO "Article" VALUES (947, 49, '273-305');
INSERT INTO "Article" VALUES (948, 50, '271-291');
INSERT INTO "Article" VALUES (949, 50, '485-500');
INSERT INTO "Article" VALUES (950, 50, '171-181');
INSERT INTO "Article" VALUES (951, 50, '393-407');
INSERT INTO "Article" VALUES (952, 50, '61-88');
INSERT INTO "Article" VALUES (953, 50, '229-237');
INSERT INTO "Article" VALUES (954, 50, '29-45');
INSERT INTO "Article" VALUES (955, 50, '521-540');
INSERT INTO "Article" VALUES (956, 50, '417-441');
INSERT INTO "Article" VALUES (957, 50, '1-28');
INSERT INTO "Article" VALUES (958, 50, '541-557');
INSERT INTO "Article" VALUES (959, 50, '101-112');
INSERT INTO "Article" VALUES (960, 50, '501-519');
INSERT INTO "Article" VALUES (961, 50, '193-207');
INSERT INTO "Article" VALUES (962, 50, '47-60');
INSERT INTO "Article" VALUES (963, 50, '585-598');
INSERT INTO "Article" VALUES (964, 50, '239-250');
INSERT INTO "Article" VALUES (965, 50, '89-100');
INSERT INTO "Article" VALUES (966, 50, '375-391');
INSERT INTO "Article" VALUES (967, 50, '443-472');
INSERT INTO "Article" VALUES (968, 50, '321-338');
INSERT INTO "Article" VALUES (969, 50, '251-269');
INSERT INTO "Article" VALUES (970, 50, '113-123');
INSERT INTO "Article" VALUES (971, 51, '415-434');
INSERT INTO "Article" VALUES (972, 51, '273-291');
INSERT INTO "Article" VALUES (973, 51, '341-365');
INSERT INTO "Article" VALUES (974, 51, '83-97');
INSERT INTO "Article" VALUES (975, 51, '315-340');
INSERT INTO "Article" VALUES (976, 51, '181-220');
INSERT INTO "Article" VALUES (977, 51, '63');
INSERT INTO "Article" VALUES (978, 51, '1-18');
INSERT INTO "Article" VALUES (979, 51, '221-255');
INSERT INTO "Article" VALUES (980, 51, '595-606');
INSERT INTO "Article" VALUES (981, 51, '257-272');
INSERT INTO "Article" VALUES (982, 51, '475-524');
INSERT INTO "Article" VALUES (983, 51, '525-593');
INSERT INTO "Article" VALUES (984, 51, '383-414');
INSERT INTO "Article" VALUES (985, 51, '111-144');
INSERT INTO "Article" VALUES (986, 51, '99-110');
INSERT INTO "Article" VALUES (987, 51, '19-61');
INSERT INTO "Article" VALUES (988, 52, '385-430');
INSERT INTO "Article" VALUES (989, 52, '119-157');
INSERT INTO "Article" VALUES (990, 52, '459-489');
INSERT INTO "Article" VALUES (991, 52, '657-674');
INSERT INTO "Article" VALUES (992, 52, '637-655');
INSERT INTO "Article" VALUES (993, 52, '317-347');
INSERT INTO "Article" VALUES (994, 52, '95-118');
INSERT INTO "Article" VALUES (995, 52, '609-636');
INSERT INTO "Article" VALUES (996, 52, '491-527');
INSERT INTO "Article" VALUES (997, 52, '159-210');
INSERT INTO "Article" VALUES (998, 52, '235-263');
INSERT INTO "Article" VALUES (999, 52, '37-79');
INSERT INTO "Article" VALUES (1000, 52, '211-233');
INSERT INTO "Article" VALUES (1001, 52, '367-383');


--
-- TOC entry 2130 (class 0 OID 24897)
-- Dependencies: 177
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: kittn
--

INSERT INTO "Author" VALUES (1, 'Sanjeev Saxena');
INSERT INTO "Author" VALUES (2, 'Hans-Ulrich Simon');
INSERT INTO "Author" VALUES (3, 'Nathan Goodman');
INSERT INTO "Author" VALUES (4, 'Oded Shmueli');
INSERT INTO "Author" VALUES (5, 'Norbert Blum');
INSERT INTO "Author" VALUES (6, 'Arnold Schönhage');
INSERT INTO "Author" VALUES (7, 'Juha Honkala');
INSERT INTO "Author" VALUES (8, 'Chua-Huang Huang');
INSERT INTO "Author" VALUES (9, 'Christian Lengauer');
INSERT INTO "Author" VALUES (10, 'Alain Finkel');
INSERT INTO "Author" VALUES (11, 'Annie Choquet');
INSERT INTO "Author" VALUES (12, 'Joachim Biskup');
INSERT INTO "Author" VALUES (13, 'Symeon Bozapalidis');
INSERT INTO "Author" VALUES (14, 'Zoltán Fülöp 0001');
INSERT INTO "Author" VALUES (15, 'George Rahonis');
INSERT INTO "Author" VALUES (16, 'Victor Khomenko');
INSERT INTO "Author" VALUES (17, 'Alex Kondratyev');
INSERT INTO "Author" VALUES (18, 'Maciej Koutny');
INSERT INTO "Author" VALUES (19, 'Walter Vogler');
INSERT INTO "Author" VALUES (20, 'Wim H. Hesselink');
INSERT INTO "Author" VALUES (21, 'Christian Ronse');
INSERT INTO "Author" VALUES (22, 'Carol Critchlow');
INSERT INTO "Author" VALUES (23, 'Prakash Panangaden');
INSERT INTO "Author" VALUES (24, 'Robin Milner');
INSERT INTO "Author" VALUES (25, 'John Darlington');
INSERT INTO "Author" VALUES (26, 'Maria Calzarossa');
INSERT INTO "Author" VALUES (27, 'M. Italiani');
INSERT INTO "Author" VALUES (28, 'Giuseppe Serazzi');
INSERT INTO "Author" VALUES (29, 'Vincent Vajnovszki');
INSERT INTO "Author" VALUES (30, 'Christian Stahl');
INSERT INTO "Author" VALUES (31, 'Richard Müller 0001');
INSERT INTO "Author" VALUES (32, 'Luc Devroye');
INSERT INTO "Author" VALUES (33, 'T. C. Hu');
INSERT INTO "Author" VALUES (34, 'K. C. Tan');
INSERT INTO "Author" VALUES (35, 'William R. Franta');
INSERT INTO "Author" VALUES (36, 'Ekkart Kindler');
INSERT INTO "Author" VALUES (37, 'Demetres D. Kouvatsos');
INSERT INTO "Author" VALUES (38, 'Sergei Gorlatch');
INSERT INTO "Author" VALUES (39, 'Roland Meyer');
INSERT INTO "Author" VALUES (40, 'Stefan Reisch');
INSERT INTO "Author" VALUES (41, 'Erzsébet Csuhaj-Varjú');
INSERT INTO "Author" VALUES (42, 'Victor Mitrana');
INSERT INTO "Author" VALUES (43, 'Ryszard Janicki');
INSERT INTO "Author" VALUES (44, 'Bruce Russell');
INSERT INTO "Author" VALUES (45, 'Andrzej Ehrenfeucht');
INSERT INTO "Author" VALUES (46, 'Grzegorz Rozenberg');
INSERT INTO "Author" VALUES (47, 'Rainer Kemp');
INSERT INTO "Author" VALUES (48, 'Yijie Han');
INSERT INTO "Author" VALUES (49, 'Yoshihide Igarashi');
INSERT INTO "Author" VALUES (50, 'Ian F. Akyildiz');
INSERT INTO "Author" VALUES (51, 'Horst von Brand');
INSERT INTO "Author" VALUES (52, 'X. J. Chen');
INSERT INTO "Author" VALUES (53, 'Carlo Montangero');
INSERT INTO "Author" VALUES (54, 'Rob J. van Glabbeek');
INSERT INTO "Author" VALUES (55, 'Ursula Goltz');
INSERT INTO "Author" VALUES (56, 'Ernst-Rüdiger Olderog');
INSERT INTO "Author" VALUES (57, 'Antonella Santone');
INSERT INTO "Author" VALUES (58, 'Eric C. R. Hehner');
INSERT INTO "Author" VALUES (59, 'Moon-Jung Chung');
INSERT INTO "Author" VALUES (60, 'Michael Evangelist');
INSERT INTO "Author" VALUES (61, 'Ivan Hal Sudborough');
INSERT INTO "Author" VALUES (62, 'Peter E. Bulychev');
INSERT INTO "Author" VALUES (63, 'Alexandre David');
INSERT INTO "Author" VALUES (64, 'Kim G. Larsen');
INSERT INTO "Author" VALUES (65, 'Guangyuan Li');
INSERT INTO "Author" VALUES (66, 'Timothy A. Budd');
INSERT INTO "Author" VALUES (67, 'Dana Angluin');
INSERT INTO "Author" VALUES (68, 'George Markowsky');
INSERT INTO "Author" VALUES (69, 'Manfred P. Stadel');
INSERT INTO "Author" VALUES (70, 'David A. Watt');
INSERT INTO "Author" VALUES (71, 'Paul S. Amerins');
INSERT INTO "Author" VALUES (72, 'Ricardo A. Baeza-Yates');
INSERT INTO "Author" VALUES (73, 'Derick Wood');
INSERT INTO "Author" VALUES (74, 'Ernst W. Mayr');
INSERT INTO "Author" VALUES (75, 'Karel Culik II');
INSERT INTO "Author" VALUES (76, 'Simant Dube');
INSERT INTO "Author" VALUES (77, 'Armin B. Cremers');
INSERT INTO "Author" VALUES (78, 'Thomas N. Hibbard');
INSERT INTO "Author" VALUES (79, 'William P. R. Mitchell');
INSERT INTO "Author" VALUES (80, 'Patrick Cousot');
INSERT INTO "Author" VALUES (81, 'Radhia Cousot');
INSERT INTO "Author" VALUES (82, 'Isi Mitrani');
INSERT INTO "Author" VALUES (83, 'J. H. Hine');
INSERT INTO "Author" VALUES (84, 'Joseph M. Morris');
INSERT INTO "Author" VALUES (85, 'Malcolm Tyrrell');
INSERT INTO "Author" VALUES (86, 'Jürgen Nehmer');
INSERT INTO "Author" VALUES (87, 'Walter J. Savitch');
INSERT INTO "Author" VALUES (88, 'Karl Meinke');
INSERT INTO "Author" VALUES (89, 'Joost Engelfriet');
INSERT INTO "Author" VALUES (90, 'Linda Heyker');
INSERT INTO "Author" VALUES (91, 'George Leih');
INSERT INTO "Author" VALUES (92, 'Shyamal K. Chowdhury');
INSERT INTO "Author" VALUES (93, 'Pradip K. Srimani');
INSERT INTO "Author" VALUES (94, 'Ugo Montanari');
INSERT INTO "Author" VALUES (95, 'Francesca Rossi');
INSERT INTO "Author" VALUES (96, 'Peter E. Lauer');
INSERT INTO "Author" VALUES (97, 'Piero R. Torrigiani');
INSERT INTO "Author" VALUES (98, 'M. W. Shields');
INSERT INTO "Author" VALUES (99, 'Rudolf Berghammer');
INSERT INTO "Author" VALUES (100, 'David Pager');
INSERT INTO "Author" VALUES (101, 'Peter Lipps');
INSERT INTO "Author" VALUES (102, 'Ulrich Möncke');
INSERT INTO "Author" VALUES (103, 'Matthias Olk');
INSERT INTO "Author" VALUES (104, 'Reinhard Wilhelm');
INSERT INTO "Author" VALUES (105, 'Sanguthevar Rajasekaran');
INSERT INTO "Author" VALUES (106, 'Sandeep Sen');
INSERT INTO "Author" VALUES (107, 'Richard Hull');
INSERT INTO "Author" VALUES (108, 'Jianwen Su');
INSERT INTO "Author" VALUES (109, 'John K. Lee');
INSERT INTO "Author" VALUES (110, 'Alan Fekete');
INSERT INTO "Author" VALUES (111, 'Teuvo Laurinolli');
INSERT INTO "Author" VALUES (112, 'Gary T. Leavens');
INSERT INTO "Author" VALUES (113, 'Don Pigozzi');
INSERT INTO "Author" VALUES (114, 'Y. Daniel Liang');
INSERT INTO "Author" VALUES (115, 'Maw-Shang Chang');
INSERT INTO "Author" VALUES (116, 'Gilles Bernot');
INSERT INTO "Author" VALUES (117, 'Michel Bidoit');
INSERT INTO "Author" VALUES (118, 'Teodor Knapik');
INSERT INTO "Author" VALUES (119, 'Jan A. Bergstra');
INSERT INTO "Author" VALUES (120, 'C. A. Middelburg');
INSERT INTO "Author" VALUES (121, 'Wlodzimierz Drabent');
INSERT INTO "Author" VALUES (122, 'Mark Schäfer');
INSERT INTO "Author" VALUES (123, 'Ralf Wollowski');
INSERT INTO "Author" VALUES (124, 'Raphael A. Finkel');
INSERT INTO "Author" VALUES (125, 'Jon Louis Bentley');
INSERT INTO "Author" VALUES (126, 'Alfred Schmitt');
INSERT INTO "Author" VALUES (127, 'Jacques Labetoulle');
INSERT INTO "Author" VALUES (128, 'Guy Pujolle');
INSERT INTO "Author" VALUES (129, 'Paul Pritchard');
INSERT INTO "Author" VALUES (130, 'Robert T. Moenck');
INSERT INTO "Author" VALUES (131, 'Philip Heidelberger');
INSERT INTO "Author" VALUES (132, 'Siegfried Bublitz');
INSERT INTO "Author" VALUES (133, 'Benedek Nagy');
INSERT INTO "Author" VALUES (134, 'Friedrich Otto');
INSERT INTO "Author" VALUES (135, 'Gheorghe Paun');
INSERT INTO "Author" VALUES (136, 'P. F. Schuler');
INSERT INTO "Author" VALUES (137, 'George W. Ernst');
INSERT INTO "Author" VALUES (138, 'Günther E. Pfaff');
INSERT INTO "Author" VALUES (139, 'Heiko Vogler');
INSERT INTO "Author" VALUES (140, 'Chen-Ming Fan');
INSERT INTO "Author" VALUES (141, 'Cheng-Chih Huang');
INSERT INTO "Author" VALUES (142, 'Huei-Jan Shyr');
INSERT INTO "Author" VALUES (143, 'Kuo-Hsiang Chen');
INSERT INTO "Author" VALUES (144, 'Linqiang Pan');
INSERT INTO "Author" VALUES (145, 'Artiom Alhazov');
INSERT INTO "Author" VALUES (146, 'Akhil Kumar 0001');
INSERT INTO "Author" VALUES (147, 'Kavindra Malik');
INSERT INTO "Author" VALUES (148, 'Serge Haddad');
INSERT INTO "Author" VALUES (149, 'Denis Poitrenaud');
INSERT INTO "Author" VALUES (150, 'Donald P. Gaver');
INSERT INTO "Author" VALUES (151, 'George Humfeld');
INSERT INTO "Author" VALUES (152, 'J.-P. Lévy');
INSERT INTO "Author" VALUES (153, 'Stavros Konstantinidis');
INSERT INTO "Author" VALUES (154, 'Nicolae Santean');
INSERT INTO "Author" VALUES (155, 'Sheng Yu');
INSERT INTO "Author" VALUES (156, 'Eike Best');
INSERT INTO "Author" VALUES (157, 'Raymond R. Devillers');
INSERT INTO "Author" VALUES (158, 'Astrid Kiehn');
INSERT INTO "Author" VALUES (159, 'Lucia Pomello');
INSERT INTO "Author" VALUES (160, 'Markus Büttner');
INSERT INTO "Author" VALUES (161, 'Hendrik Jan Hoogeboom');
INSERT INTO "Author" VALUES (162, 'Eric Lilin');
INSERT INTO "Author" VALUES (163, 'Andreas Maletti');
INSERT INTO "Author" VALUES (164, 'Andrzej Blikle');
INSERT INTO "Author" VALUES (165, 'Fred Kröger');
INSERT INTO "Author" VALUES (166, 'Zoltán Ésik');
INSERT INTO "Author" VALUES (167, 'Michael Bertol');
INSERT INTO "Author" VALUES (168, 'Rob van Stee');
INSERT INTO "Author" VALUES (169, 'Johannes A. La Poutré');
INSERT INTO "Author" VALUES (170, 'Carroll Morgan');
INSERT INTO "Author" VALUES (171, 'Paul H. B. Gardiner');
INSERT INTO "Author" VALUES (172, 'Ambuj K. Singh');
INSERT INTO "Author" VALUES (173, 'Paul Caspi');
INSERT INTO "Author" VALUES (174, 'Nicolas Halbwachs');
INSERT INTO "Author" VALUES (175, 'Wojciech Fraczak');
INSERT INTO "Author" VALUES (176, 'Richard P. Hopkins');
INSERT INTO "Author" VALUES (177, 'Hanna Klaudel');
INSERT INTO "Author" VALUES (178, 'Elisabeth Pelz');
INSERT INTO "Author" VALUES (179, 'Wuu Yang');
INSERT INTO "Author" VALUES (180, 'Kamilla Klonowska');
INSERT INTO "Author" VALUES (181, 'Lars Lundberg');
INSERT INTO "Author" VALUES (182, 'Håkan Lennerstad');
INSERT INTO "Author" VALUES (183, 'Arnold L. Rosenberg');
INSERT INTO "Author" VALUES (184, 'Zvi Galil');
INSERT INTO "Author" VALUES (185, 'Volker Claus');
INSERT INTO "Author" VALUES (186, 'Naoki Kobayashi 0001');
INSERT INTO "Author" VALUES (187, 'Jean Berstel');
INSERT INTO "Author" VALUES (188, 'B. Bartsch');
INSERT INTO "Author" VALUES (189, 'Gunter Bolch');
INSERT INTO "Author" VALUES (190, 'Jan Joris Vereijken');
INSERT INTO "Author" VALUES (191, 'Teruo Hikita');
INSERT INTO "Author" VALUES (192, 'Yuri Breitbart');
INSERT INTO "Author" VALUES (193, 'Allen Reiter');
INSERT INTO "Author" VALUES (194, 'Per Brinch Hansen');
INSERT INTO "Author" VALUES (195, 'Karsten Schmidt 0004');
INSERT INTO "Author" VALUES (196, 'Mogens Nielsen');
INSERT INTO "Author" VALUES (197, 'Arto Salomaa');
INSERT INTO "Author" VALUES (198, 'Sven Skyum');
INSERT INTO "Author" VALUES (199, 'Antonios Kalampakas');
INSERT INTO "Author" VALUES (200, 'Jörg Desel');
INSERT INTO "Author" VALUES (201, 'Wolfgang Reisig');
INSERT INTO "Author" VALUES (202, 'Wolfgang Merzenich');
INSERT INTO "Author" VALUES (203, 'Eleni Mandrali');
INSERT INTO "Author" VALUES (204, 'Dirk Janssens');
INSERT INTO "Author" VALUES (205, 'Annabelle McIver');
INSERT INTO "Author" VALUES (206, 'S. Arun-Kumar');
INSERT INTO "Author" VALUES (207, 'Matthew Hennessy');
INSERT INTO "Author" VALUES (208, 'Benedetto Intrigila');
INSERT INTO "Author" VALUES (209, 'Stefano Varricchio');
INSERT INTO "Author" VALUES (210, 'Emanuela Fachini');
INSERT INTO "Author" VALUES (211, 'Angelo Monti');
INSERT INTO "Author" VALUES (212, 'Margherita Napoli');
INSERT INTO "Author" VALUES (213, 'Domenico Parente');
INSERT INTO "Author" VALUES (214, 'Giuseppe Della Penna');
INSERT INTO "Author" VALUES (215, 'Enrico Tronci');
INSERT INTO "Author" VALUES (216, 'Marisa Venturini Zilli');
INSERT INTO "Author" VALUES (217, 'Jan Janousek');
INSERT INTO "Author" VALUES (218, 'Borivoj Melichar');
INSERT INTO "Author" VALUES (219, 'Xinxin Liu');
INSERT INTO "Author" VALUES (220, 'Mark H. Overmars');
INSERT INTO "Author" VALUES (221, 'Michiel H. M. Smid');
INSERT INTO "Author" VALUES (222, 'Mark de Berg');
INSERT INTO "Author" VALUES (223, 'Marc J. van Kreveld');
INSERT INTO "Author" VALUES (224, 'Michael Brand');
INSERT INTO "Author" VALUES (225, 'Ralph-Johan Back');
INSERT INTO "Author" VALUES (226, 'Joakim von Wright');
INSERT INTO "Author" VALUES (227, 'Alexandre Brandwajn');
INSERT INTO "Author" VALUES (228, 'Eric Badouel');
INSERT INTO "Author" VALUES (229, 'Philippe Darondeau');
INSERT INTO "Author" VALUES (230, 'Leonidas J. Guibas');
INSERT INTO "Author" VALUES (231, 'Ralf Hartmut Güting');
INSERT INTO "Author" VALUES (232, 'Clement H. C. Leung');
INSERT INTO "Author" VALUES (233, 'Qui Hoon Choo');
INSERT INTO "Author" VALUES (234, 'Stephan Heilbrunner');
INSERT INTO "Author" VALUES (235, 'Steffen Hölldobler');
INSERT INTO "Author" VALUES (236, 'Niklaus Wirth');
INSERT INTO "Author" VALUES (237, 'Achim D. Brucker');
INSERT INTO "Author" VALUES (238, 'Burkhart Wolff');
INSERT INTO "Author" VALUES (239, 'Hermann K.-G. Walter');
INSERT INTO "Author" VALUES (240, 'Martin Kutrib');
INSERT INTO "Author" VALUES (241, 'Andreas Malcher');
INSERT INTO "Author" VALUES (242, 'Matthias Wendlandt');
INSERT INTO "Author" VALUES (243, 'Bernhard Mescheder');
INSERT INTO "Author" VALUES (244, 'Antonín Kucera');
INSERT INTO "Author" VALUES (245, 'Jan Strejcek');
INSERT INTO "Author" VALUES (246, 'Thomas P. Murtagh');
INSERT INTO "Author" VALUES (247, 'Adam L. Buchsbaum');
INSERT INTO "Author" VALUES (248, 'Rajamani Sundar');
INSERT INTO "Author" VALUES (249, 'Robert Endre Tarjan');
INSERT INTO "Author" VALUES (250, 'Yuxi Fu');
INSERT INTO "Author" VALUES (251, 'Norbert Ramsperger');
INSERT INTO "Author" VALUES (252, 'Kim S. Larsen');
INSERT INTO "Author" VALUES (253, 'Ikuo Nakata');
INSERT INTO "Author" VALUES (254, 'Masataka Sassa');
INSERT INTO "Author" VALUES (255, 'Tien Van Do');
INSERT INTO "Author" VALUES (256, 'Ram Chakka');
INSERT INTO "Author" VALUES (257, 'Nam H. Do');
INSERT INTO "Author" VALUES (258, 'László Pap');
INSERT INTO "Author" VALUES (259, 'Hsu-Chun Yen');
INSERT INTO "Author" VALUES (260, 'Vijay K. Vaishnavi');
INSERT INTO "Author" VALUES (261, 'Hans-Peter Kriegel');
INSERT INTO "Author" VALUES (262, 'Martin Seysen');
INSERT INTO "Author" VALUES (263, 'Ramachandran Vaidyanathan');
INSERT INTO "Author" VALUES (264, 'Carlos R. P. Hartmann');
INSERT INTO "Author" VALUES (265, 'Pramod K. Varshney');
INSERT INTO "Author" VALUES (266, 'Ján Gaso');
INSERT INTO "Author" VALUES (267, 'Martin Nehéz');
INSERT INTO "Author" VALUES (268, 'Andrzej Duda');
INSERT INTO "Author" VALUES (269, 'Tadeusz Czachórski');
INSERT INTO "Author" VALUES (270, 'Zheng-Zhu Li');
INSERT INTO "Author" VALUES (271, 'Y. S. Tsai');
INSERT INTO "Author" VALUES (272, 'Jozef Gruska');
INSERT INTO "Author" VALUES (273, 'Tjalling Gelsema');
INSERT INTO "Author" VALUES (274, 'Peter J. Denning');
INSERT INTO "Author" VALUES (275, 'Kevin C. Kahn');
INSERT INTO "Author" VALUES (276, 'Jacques Leroudier');
INSERT INTO "Author" VALUES (277, 'Dominique Potier');
INSERT INTO "Author" VALUES (278, 'Rajan Suri');
INSERT INTO "Author" VALUES (279, 'Andrea Maggiolo-Schettini');
INSERT INTO "Author" VALUES (280, 'Davide Sangiorgi');
INSERT INTO "Author" VALUES (281, 'Christian Choffrut');
INSERT INTO "Author" VALUES (282, 'Michael Schenke');
INSERT INTO "Author" VALUES (283, 'Flavio Corradini');
INSERT INTO "Author" VALUES (284, 'Roberto Gorrieri');
INSERT INTO "Author" VALUES (285, 'Marco Roccetti');
INSERT INTO "Author" VALUES (286, 'Anton Nijholt');
INSERT INTO "Author" VALUES (287, 'Kung-Kiu Lau');
INSERT INTO "Author" VALUES (288, 'Maria Rita Di Berardini');
INSERT INTO "Author" VALUES (289, 'Peter R. J. Asveld');
INSERT INTO "Author" VALUES (290, 'J. V. Tucker');
INSERT INTO "Author" VALUES (291, 'Zohar Manna');
INSERT INTO "Author" VALUES (292, 'Amir Pnueli');
INSERT INTO "Author" VALUES (293, 'Ann E. Kelley Sobel');
INSERT INTO "Author" VALUES (294, 'Neelam Soundararajan');
INSERT INTO "Author" VALUES (295, 'Giora Slutzki');
INSERT INTO "Author" VALUES (296, 'Thomas Klingler');
INSERT INTO "Author" VALUES (297, 'Frank Drewes');
INSERT INTO "Author" VALUES (298, 'Johanna Högberg');
INSERT INTO "Author" VALUES (299, 'Lars Jacobsen');
INSERT INTO "Author" VALUES (300, 'Jörg H. Siekmann');
INSERT INTO "Author" VALUES (301, 'Graham Wrightson');
INSERT INTO "Author" VALUES (302, 'Nissim Francez');
INSERT INTO "Author" VALUES (303, 'Boris Klebansky');
INSERT INTO "Author" VALUES (304, 'Charles N. Fischer');
INSERT INTO "Author" VALUES (305, 'D. R. Milton');
INSERT INTO "Author" VALUES (306, 'S. B. Quiring');
INSERT INTO "Author" VALUES (307, 'Axel van Lamsweerde');
INSERT INTO "Author" VALUES (308, 'Michel Sintzoff');
INSERT INTO "Author" VALUES (309, 'Hermann A. Maurer');
INSERT INTO "Author" VALUES (310, 'Inman P. de Guzmán');
INSERT INTO "Author" VALUES (311, 'Manuel Ojeda-Aciego');
INSERT INTO "Author" VALUES (312, 'Agustín Valverde');
INSERT INTO "Author" VALUES (313, 'John B. Kam');
INSERT INTO "Author" VALUES (314, 'Jeffrey D. Ullman');
INSERT INTO "Author" VALUES (315, 'Mikkel Thorup');
INSERT INTO "Author" VALUES (316, 'José M. Amigó');
INSERT INTO "Author" VALUES (317, 'Gerth Stølting Brodal');
INSERT INTO "Author" VALUES (318, 'Erik D. Demaine');
INSERT INTO "Author" VALUES (319, 'J. Ian Munro');
INSERT INTO "Author" VALUES (320, 'S. Kiran Kumar');
INSERT INTO "Author" VALUES (321, 'C. Pandu Rangan');
INSERT INTO "Author" VALUES (322, 'Mila E. Majster-Cederbaum');
INSERT INTO "Author" VALUES (323, 'Jinzhao Wu');
INSERT INTO "Author" VALUES (324, 'Houguang Yue');
INSERT INTO "Author" VALUES (325, 'Changwook Kim');
INSERT INTO "Author" VALUES (326, 'A. Michael Berman');
INSERT INTO "Author" VALUES (327, 'Marvin C. Paull');
INSERT INTO "Author" VALUES (328, 'Barbara G. Ryder');
INSERT INTO "Author" VALUES (329, 'Peter Kandzia');
INSERT INTO "Author" VALUES (330, 'Beverly A. Sanders');
INSERT INTO "Author" VALUES (331, 'Pedro V. Silva');
INSERT INTO "Author" VALUES (332, 'K. V. S. Ramarao');
INSERT INTO "Author" VALUES (333, 'Amr Elmasry');
INSERT INTO "Author" VALUES (334, 'Michael L. Fredman');
INSERT INTO "Author" VALUES (335, 'Lorene E. Gupta');
INSERT INTO "Author" VALUES (336, 'Andrew J. Malton');
INSERT INTO "Author" VALUES (337, 'Rodney W. Topor');
INSERT INTO "Author" VALUES (338, 'Juhani Karhumäki');
INSERT INTO "Author" VALUES (339, 'Thomas Eiter');
INSERT INTO "Author" VALUES (340, 'Heikki Mannila');
INSERT INTO "Author" VALUES (341, 'Raúl J. Ramírez');
INSERT INTO "Author" VALUES (342, 'Frank Wm. Tompa');
INSERT INTO "Author" VALUES (343, 'Erol Gelenbe');
INSERT INTO "Author" VALUES (344, 'Jacques Lenfant');
INSERT INTO "Author" VALUES (345, 'Ferucio Laurentiu Tiplea');
INSERT INTO "Author" VALUES (346, 'Erkki Mäkinen');
INSERT INTO "Author" VALUES (347, 'Corina Apachite');
INSERT INTO "Author" VALUES (348, 'Friedrich L. Bauer');
INSERT INTO "Author" VALUES (349, 'Andrei P. Ershov');
INSERT INTO "Author" VALUES (350, 'Manfred Paul');
INSERT INTO "Author" VALUES (351, 'Alan J. Perlis');
INSERT INTO "Author" VALUES (352, 'Wayne A. Babich');
INSERT INTO "Author" VALUES (353, 'Mehdi Jazayeri');
INSERT INTO "Author" VALUES (354, 'Robert H. Sloan');
INSERT INTO "Author" VALUES (355, 'Ugo A. Buy');
INSERT INTO "Author" VALUES (356, 'Oded Goldreich');
INSERT INTO "Author" VALUES (357, 'Liuba Shrira');
INSERT INTO "Author" VALUES (358, 'Josep Díaz');
INSERT INTO "Author" VALUES (359, 'Maria J. Serna');
INSERT INTO "Author" VALUES (360, 'Jacobo Torán');
INSERT INTO "Author" VALUES (361, 'Lorenzo Bettini');
INSERT INTO "Author" VALUES (362, 'Ferruccio Damiani');
INSERT INTO "Author" VALUES (363, 'Ina Schaefer');
INSERT INTO "Author" VALUES (364, 'T. C. Edwin Cheng');
INSERT INTO "Author" VALUES (365, 'Qing Ding');
INSERT INTO "Author" VALUES (366, 'François Baccelli');
INSERT INTO "Author" VALUES (367, 'Thierry Fleury');
INSERT INTO "Author" VALUES (368, 'Adrian Atanasiu');
INSERT INTO "Author" VALUES (369, 'Charlie Svahnberg');
INSERT INTO "Author" VALUES (370, 'Klaus H. Hinrichs');
INSERT INTO "Author" VALUES (371, 'Jürg Nievergelt');
INSERT INTO "Author" VALUES (372, 'Peter Schorn');
INSERT INTO "Author" VALUES (373, 'Gerald Lüttgen');
INSERT INTO "Author" VALUES (374, 'Sascha Fendrich');
INSERT INTO "Author" VALUES (375, 'Ismo Hakala');
INSERT INTO "Author" VALUES (376, 'Juha Kortelainen');
INSERT INTO "Author" VALUES (377, 'Robert Meersman');
INSERT INTO "Author" VALUES (378, 'Amit Chakrabarti');
INSERT INTO "Author" VALUES (379, 'Venkatesan Guruswami');
INSERT INTO "Author" VALUES (380, 'Andrew Wirth');
INSERT INTO "Author" VALUES (381, 'Anthony Wirth');
INSERT INTO "Author" VALUES (382, 'N. P. Chapman');
INSERT INTO "Author" VALUES (383, 'Hans Jürgen Schneider');
INSERT INTO "Author" VALUES (384, 'Hartmut Ehrig');
INSERT INTO "Author" VALUES (385, 'Wenceslas Fernandez de la Vega');
INSERT INTO "Author" VALUES (386, 'Vangelis Th. Paschos');
INSERT INTO "Author" VALUES (387, 'Andreas Stafylopatis');
INSERT INTO "Author" VALUES (388, 'Kim Marriott');
INSERT INTO "Author" VALUES (389, 'Thomas Lehmann');
INSERT INTO "Author" VALUES (390, 'Jacques Loeckx');
INSERT INTO "Author" VALUES (391, 'M. R. Garey');
INSERT INTO "Author" VALUES (392, 'Ronald L. Graham');
INSERT INTO "Author" VALUES (393, 'G. Marque-Pucheu');
INSERT INTO "Author" VALUES (394, 'Maurice Nivat');
INSERT INTO "Author" VALUES (395, 'Reidar Conradi');
INSERT INTO "Author" VALUES (396, 'Mahadevan Ganapathi');
INSERT INTO "Author" VALUES (397, 'Aviezri S. Fraenkel');
INSERT INTO "Author" VALUES (398, 'Moshe Mor');
INSERT INTO "Author" VALUES (399, 'Yehoshua Perl');
INSERT INTO "Author" VALUES (400, 'Johannes Röhrich');
INSERT INTO "Author" VALUES (401, 'Uwe Kastens');
INSERT INTO "Author" VALUES (402, 'Arnaud Carayol');
INSERT INTO "Author" VALUES (403, 'Antoine Meyer');
INSERT INTO "Author" VALUES (404, 'Luc Boasson');
INSERT INTO "Author" VALUES (405, 'Oscar H. Ibarra');
INSERT INTO "Author" VALUES (406, 'Chul E. Kim');
INSERT INTO "Author" VALUES (407, 'William E. Weihl');
INSERT INTO "Author" VALUES (408, 'Francesco Ranzato');
INSERT INTO "Author" VALUES (409, 'Vesa Halava');
INSERT INTO "Author" VALUES (410, 'Mika Hirvensalo');
INSERT INTO "Author" VALUES (411, 'Hans-Anton Rollik');
INSERT INTO "Author" VALUES (412, 'John Almond');
INSERT INTO "Author" VALUES (413, 'Alexander Grigoriev');
INSERT INTO "Author" VALUES (414, 'Gerhard J. Woeginger');
INSERT INTO "Author" VALUES (415, 'Donald Sannella');
INSERT INTO "Author" VALUES (416, 'Andrzej Tarlecki');
INSERT INTO "Author" VALUES (417, 'Henning Bordihn');
INSERT INTO "Author" VALUES (418, 'Markus Holzer');
INSERT INTO "Author" VALUES (419, 'Paul M. Zislis');
INSERT INTO "Author" VALUES (420, 'Gary Levin');
INSERT INTO "Author" VALUES (421, 'David Gries');
INSERT INTO "Author" VALUES (422, 'Tero Harju');
INSERT INTO "Author" VALUES (423, 'Jan Ramon');
INSERT INTO "Author" VALUES (424, 'Maurice Bruynooghe');
INSERT INTO "Author" VALUES (425, 'Michel Latteux');
INSERT INTO "Author" VALUES (426, 'B. Leguy');
INSERT INTO "Author" VALUES (427, 'B. Ratoandromanana');
INSERT INTO "Author" VALUES (428, 'Lila Kari');
INSERT INTO "Author" VALUES (429, 'Elena Losseva');
INSERT INTO "Author" VALUES (430, 'Geoff Wozniak');
INSERT INTO "Author" VALUES (431, 'Reinhold Franck');
INSERT INTO "Author" VALUES (432, 'Md. Enamul Kabir');
INSERT INTO "Author" VALUES (433, 'Hua Wang');
INSERT INTO "Author" VALUES (434, 'Elisa Bertino');
INSERT INTO "Author" VALUES (435, 'Thomas Giammo');
INSERT INTO "Author" VALUES (436, 'Elizabeth Scott');
INSERT INTO "Author" VALUES (437, 'Adrian Johnstone');
INSERT INTO "Author" VALUES (438, 'Tomás Brázdil');
INSERT INTO "Author" VALUES (439, 'Oldrich Strazovský');
INSERT INTO "Author" VALUES (440, 'Gigliola Vaglini');
INSERT INTO "Author" VALUES (441, 'Joachim Klein 0001');
INSERT INTO "Author" VALUES (442, 'Christel Baier');
INSERT INTO "Author" VALUES (443, 'Sascha Klüppelholz');
INSERT INTO "Author" VALUES (444, 'Edward G. Belaga');
INSERT INTO "Author" VALUES (445, 'John P. Kearns');
INSERT INTO "Author" VALUES (446, 'Mary Lou Soffa');
INSERT INTO "Author" VALUES (447, 'Hsien-Kuei Hwang');
INSERT INTO "Author" VALUES (448, 'Jean-Marie Nicolas');
INSERT INTO "Author" VALUES (449, 'Juan Ignacio Perna');
INSERT INTO "Author" VALUES (450, 'Jim Woodcock');
INSERT INTO "Author" VALUES (451, 'Augusto Sampaio');
INSERT INTO "Author" VALUES (452, 'Juliano Iyoda');
INSERT INTO "Author" VALUES (453, 'Hans Langmaack');
INSERT INTO "Author" VALUES (454, 'Róbert Szelepcsényi');
INSERT INTO "Author" VALUES (455, 'G. Bauer');
INSERT INTO "Author" VALUES (456, 'Lucian Ilie');
INSERT INTO "Author" VALUES (457, 'Hisao Kameda');
INSERT INTO "Author" VALUES (458, 'Dirk Hauschildt');
INSERT INTO "Author" VALUES (459, 'Matthias Jantzen');
INSERT INTO "Author" VALUES (460, 'Dean Jacobs');
INSERT INTO "Author" VALUES (461, 'Jan van Leeuwen');
INSERT INTO "Author" VALUES (462, 'Thomas Ottmann');
INSERT INTO "Author" VALUES (463, 'Michael Schrapp');
INSERT INTO "Author" VALUES (464, 'Martin Wirsing');
INSERT INTO "Author" VALUES (465, 'Alan J. Demers');
INSERT INTO "Author" VALUES (466, 'C. Keleman');
INSERT INTO "Author" VALUES (467, 'Bernd Reusch');
INSERT INTO "Author" VALUES (468, 'Beate Commentz-Walter');
INSERT INTO "Author" VALUES (469, 'Lawrence T. Kou');
INSERT INTO "Author" VALUES (470, 'Alexander Meduna');
INSERT INTO "Author" VALUES (471, 'Henning Fernau');
INSERT INTO "Author" VALUES (472, 'M. Kempf');
INSERT INTO "Author" VALUES (473, 'Rudolf Bayer');
INSERT INTO "Author" VALUES (474, 'Ulrich Güntzer');
INSERT INTO "Author" VALUES (475, 'Eljas Soisalon-Soininen');
INSERT INTO "Author" VALUES (476, 'Yennun Huang');
INSERT INTO "Author" VALUES (477, 'Pankaj Jalote');
INSERT INTO "Author" VALUES (478, 'Yiwei Jiang');
INSERT INTO "Author" VALUES (479, 'Yong He');
INSERT INTO "Author" VALUES (480, 'Iain A. Stewart');
INSERT INTO "Author" VALUES (481, 'Klaus Küspert');
INSERT INTO "Author" VALUES (482, 'Foto N. Afrati');
INSERT INTO "Author" VALUES (483, 'Rada Chirkova');
INSERT INTO "Author" VALUES (484, 'Manolis Gergatsoulis');
INSERT INTO "Author" VALUES (485, 'Vassia Pavlaki');
INSERT INTO "Author" VALUES (486, 'Didier Y. Hinz');
INSERT INTO "Author" VALUES (487, 'Jesús N. Ravelo');
INSERT INTO "Author" VALUES (488, 'Shmuel Sagiv');
INSERT INTO "Author" VALUES (489, 'Michael Rodeh');
INSERT INTO "Author" VALUES (490, 'Jean-François Perrot');
INSERT INTO "Author" VALUES (491, 'Gaston H. Gonnet');
INSERT INTO "Author" VALUES (492, 'Lawrence D. Rogers');
INSERT INTO "Author" VALUES (493, 'J. Alan George');
INSERT INTO "Author" VALUES (494, 'Antti Valmari');
INSERT INTO "Author" VALUES (495, 'Arturo Carpi');
INSERT INTO "Author" VALUES (496, 'Flavio D''Alessandro');
INSERT INTO "Author" VALUES (497, 'Gadi Taubenfeld');
INSERT INTO "Author" VALUES (498, 'Shlomo Moran');
INSERT INTO "Author" VALUES (499, 'Dominic Duggan');
INSERT INTO "Author" VALUES (500, 'Hans-Dieter Ehrich');
INSERT INTO "Author" VALUES (501, 'Carlos Caleiro');
INSERT INTO "Author" VALUES (502, 'Mike Paterson');
INSERT INTO "Author" VALUES (503, 'Ingo Wegener');
INSERT INTO "Author" VALUES (504, 'Jürgen Dingel');
INSERT INTO "Author" VALUES (505, 'Laurent Alonso');
INSERT INTO "Author" VALUES (506, 'René Schott');
INSERT INTO "Author" VALUES (507, 'Petr Zemek');
INSERT INTO "Author" VALUES (508, 'Neal A. Harman');
INSERT INTO "Author" VALUES (509, 'Terrence W. Pratt');
INSERT INTO "Author" VALUES (510, 'Stéphane Coulondre');
INSERT INTO "Author" VALUES (511, 'Toshiro Araki');
INSERT INTO "Author" VALUES (512, 'Nobuki Tokura');
INSERT INTO "Author" VALUES (513, 'Sibsankar Haldar');
INSERT INTO "Author" VALUES (514, 'K. Vidyasankar');
INSERT INTO "Author" VALUES (515, 'Donna J. Brown');
INSERT INTO "Author" VALUES (516, 'Brenda S. Baker');
INSERT INTO "Author" VALUES (517, 'Howard P. Katseff');
INSERT INTO "Author" VALUES (518, 'Nasreddine Tabet-Aouel');
INSERT INTO "Author" VALUES (519, 'Józef Winkowski');
INSERT INTO "Author" VALUES (520, 'Simon J. Gay');
INSERT INTO "Author" VALUES (521, 'Malcolm Hole');
INSERT INTO "Author" VALUES (522, 'Gerardo Costa');
INSERT INTO "Author" VALUES (523, 'Colin Stirling');
INSERT INTO "Author" VALUES (524, 'Madhu Mutyam');
INSERT INTO "Author" VALUES (525, 'Kamala Krithivasan');
INSERT INTO "Author" VALUES (526, 'Werner Pohlmann');
INSERT INTO "Author" VALUES (527, 'Aart Middeldorp');
INSERT INTO "Author" VALUES (528, 'Hitoshi Ohsaki');
INSERT INTO "Author" VALUES (529, 'Laura Bozzelli');
INSERT INTO "Author" VALUES (530, 'Mojmír Kretínský');
INSERT INTO "Author" VALUES (531, 'Vojtech Rehák');
INSERT INTO "Author" VALUES (532, 'J. W. Cohen');
INSERT INTO "Author" VALUES (533, 'Richard N. Taylor');
INSERT INTO "Author" VALUES (534, 'William E. Wright');
INSERT INTO "Author" VALUES (535, 'Catherine Mongenet');
INSERT INTO "Author" VALUES (536, 'Philippe Clauss');
INSERT INTO "Author" VALUES (537, 'Guy-René Perrin');
INSERT INTO "Author" VALUES (538, 'Lefteris M. Kirousis');
INSERT INTO "Author" VALUES (539, 'Andreas G. Veneris');
INSERT INTO "Author" VALUES (540, 'Tarja Systä');
INSERT INTO "Author" VALUES (541, 'J. W. de Bakker');
INSERT INTO "Author" VALUES (542, 'John-Jules Ch. Meyer');
INSERT INTO "Author" VALUES (543, 'Levent V. Orman');
INSERT INTO "Author" VALUES (544, 'Fred B. Schneider');
INSERT INTO "Author" VALUES (545, 'Richard Conway 0003');
INSERT INTO "Author" VALUES (546, 'Dale Skeen');
INSERT INTO "Author" VALUES (547, 'Leo Marcus');
INSERT INTO "Author" VALUES (548, 'Telis Menas');
INSERT INTO "Author" VALUES (549, 'Thomas J. Marlowe');
INSERT INTO "Author" VALUES (550, 'Gennadi Falin');
INSERT INTO "Author" VALUES (551, 'M. Martìn Dìaz');
INSERT INTO "Author" VALUES (552, 'Jesus R. Artalejo');
INSERT INTO "Author" VALUES (553, 'Donald E. Knuth');
INSERT INTO "Author" VALUES (554, 'Peter Schlichtiger');
INSERT INTO "Author" VALUES (555, 'Shyr-Shen Yu');
INSERT INTO "Author" VALUES (556, 'S. O. Anderson');
INSERT INTO "Author" VALUES (557, 'Roland Carl Backhouse');
INSERT INTO "Author" VALUES (558, 'Leah Epstein');
INSERT INTO "Author" VALUES (559, 'Tamir Tassa');
INSERT INTO "Author" VALUES (560, 'Peter G. Harrison');
INSERT INTO "Author" VALUES (561, 'Vincent D. Blondel');
INSERT INTO "Author" VALUES (562, 'Jarkko Kari');
INSERT INTO "Author" VALUES (563, 'Thomas J. Ostrand');
INSERT INTO "Author" VALUES (564, 'Elaine J. Weyuker');
INSERT INTO "Author" VALUES (565, 'Ivana Cerná');
INSERT INTO "Author" VALUES (566, 'Jon Mauney');
INSERT INTO "Author" VALUES (567, 'Martin Berger');
INSERT INTO "Author" VALUES (568, 'Kohei Honda');
INSERT INTO "Author" VALUES (569, 'Nobuko Yoshida');
INSERT INTO "Author" VALUES (570, 'Pascal Caron');
INSERT INTO "Author" VALUES (571, 'Jean-Marc Champarnaud');
INSERT INTO "Author" VALUES (572, 'Ludovic Mignot');
INSERT INTO "Author" VALUES (573, 'Hosam M. Mahmoud');
INSERT INTO "Author" VALUES (574, 'Roderick Bloem');
INSERT INTO "Author" VALUES (575, 'Krishnendu Chatterjee');
INSERT INTO "Author" VALUES (576, 'Karin Greimel');
INSERT INTO "Author" VALUES (577, 'Thomas A. Henzinger');
INSERT INTO "Author" VALUES (578, 'Georg Hofferek');
INSERT INTO "Author" VALUES (579, 'Barbara Jobstmann');
INSERT INTO "Author" VALUES (580, 'Bettina Könighofer');
INSERT INTO "Author" VALUES (581, 'Robert Könighofer');
INSERT INTO "Author" VALUES (582, 'Steven Delvaux');
INSERT INTO "Author" VALUES (583, 'Leon Horsten');
INSERT INTO "Author" VALUES (584, 'Paolo Tiberio');
INSERT INTO "Author" VALUES (585, 'J. C. A. Boekhorst');
INSERT INTO "Author" VALUES (586, 'Peter Pepper');
INSERT INTO "Author" VALUES (587, 'Helmuth Partsch');
INSERT INTO "Author" VALUES (588, 'Walter Dosch');
INSERT INTO "Author" VALUES (589, 'Riccardo Torlone');
INSERT INTO "Author" VALUES (590, 'Masahiro Miyakawa');
INSERT INTO "Author" VALUES (591, 'Jörg-Rüdiger Sack');
INSERT INTO "Author" VALUES (592, 'Thomas Strothotte');
INSERT INTO "Author" VALUES (593, 'Balakrishnan Krishnamurthy');
INSERT INTO "Author" VALUES (594, 'Leslie Lamport');
INSERT INTO "Author" VALUES (595, 'Flaviu Cristian');
INSERT INTO "Author" VALUES (596, 'Mario Schkolnick');
INSERT INTO "Author" VALUES (597, 'Otto Nurmi');
INSERT INTO "Author" VALUES (598, 'Markku Tamminen');
INSERT INTO "Author" VALUES (599, 'W. K. Luk');
INSERT INTO "Author" VALUES (600, 'Paolo Sipala');
INSERT INTO "Author" VALUES (601, 'Lin S. Woo');
INSERT INTO "Author" VALUES (602, 'C. K. Wong');
INSERT INTO "Author" VALUES (603, 'Amir M. Ben-Amram');
INSERT INTO "Author" VALUES (604, 'Roberto Barbuti');
INSERT INTO "Author" VALUES (605, 'Luca Tesei');
INSERT INTO "Author" VALUES (606, 'Jean-Michel Autebert');
INSERT INTO "Author" VALUES (607, 'Joffroy Beauquier');
INSERT INTO "Author" VALUES (608, 'Edward A. Bender');
INSERT INTO "Author" VALUES (609, 'Cheryl E. Praeger');
INSERT INTO "Author" VALUES (610, 'Nicholas C. Wormald');
INSERT INTO "Author" VALUES (611, 'Edward G. Coffman Jr.');
INSERT INTO "Author" VALUES (612, 'Dariusz Dereniowski');
INSERT INTO "Author" VALUES (613, 'Wieslaw Kubiak');
INSERT INTO "Author" VALUES (614, 'José Luiz Fiadeiro');
INSERT INTO "Author" VALUES (615, 'Amílcar Sernadas');
INSERT INTO "Author" VALUES (616, 'John E. Shore');
INSERT INTO "Author" VALUES (617, 'Peter Klein');
INSERT INTO "Author" VALUES (618, 'Friedhelm Meyer auf der Heide');
INSERT INTO "Author" VALUES (619, 'Michael G. Lamoureux');
INSERT INTO "Author" VALUES (620, 'Bradford G. Nickerson');
INSERT INTO "Author" VALUES (621, 'Alistair Moffat');
INSERT INTO "Author" VALUES (622, 'Ola Petersson');
INSERT INTO "Author" VALUES (623, 'Ashok K. Agrawala');
INSERT INTO "Author" VALUES (624, 'Satish K. Tripathi');
INSERT INTO "Author" VALUES (625, 'Lutz Eichner');
INSERT INTO "Author" VALUES (626, 'Peter Deussen');
INSERT INTO "Author" VALUES (627, 'Meurig Beynon');
INSERT INTO "Author" VALUES (628, 'Daniela Musto');
INSERT INTO "Author" VALUES (629, 'Jürgen Avenhaus');
INSERT INTO "Author" VALUES (630, 'Klaus Madlener');
INSERT INTO "Author" VALUES (631, 'M. W. Du');
INSERT INTO "Author" VALUES (632, 'S. C. Chang');
INSERT INTO "Author" VALUES (633, 'Ichiro Suzuki');
INSERT INTO "Author" VALUES (634, 'Tadao Kasami');
INSERT INTO "Author" VALUES (635, 'Desh Ranjan');
INSERT INTO "Author" VALUES (636, 'Enrico Pontelli');
INSERT INTO "Author" VALUES (637, 'Gopal Gupta');
INSERT INTO "Author" VALUES (638, 'Egidio Astesiano');
INSERT INTO "Author" VALUES (639, 'Gianna Reggio');
INSERT INTO "Author" VALUES (640, 'Anthony E. Krzesinski');
INSERT INTO "Author" VALUES (641, 'Peter Teunissen');
INSERT INTO "Author" VALUES (642, 'Rza Bashirov');
INSERT INTO "Author" VALUES (643, 'Fabrice Kordon');
INSERT INTO "Author" VALUES (644, 'Hüseyin Lort');
INSERT INTO "Author" VALUES (645, 'Aris M. Ouksel');
INSERT INTO "Author" VALUES (646, 'Otto Mayer');
INSERT INTO "Author" VALUES (647, 'Robert E. Shostak');
INSERT INTO "Author" VALUES (648, 'H. C. M. Kleijn');
INSERT INTO "Author" VALUES (649, 'Jetty Kleijn');
INSERT INTO "Author" VALUES (650, 'Marta Pietkiewicz-Koutny');
INSERT INTO "Author" VALUES (651, 'Anthony J. Bonner');
INSERT INTO "Author" VALUES (652, 'Giansalvatore Mecca');
INSERT INTO "Author" VALUES (653, 'Karl Unterauer');
INSERT INTO "Author" VALUES (654, 'Manfred Broy');
INSERT INTO "Author" VALUES (655, 'Juris Hartmanis');
INSERT INTO "Author" VALUES (656, 'Johannes Reichardt');
INSERT INTO "Author" VALUES (657, 'Danny Dubé');
INSERT INTO "Author" VALUES (658, 'Marc Feeley');
INSERT INTO "Author" VALUES (659, 'Dongfeng Chen');
INSERT INTO "Author" VALUES (660, 'Fereidoon Sadri');
INSERT INTO "Author" VALUES (661, 'Tiia J. Salo');
INSERT INTO "Author" VALUES (662, 'Xiaolei Qian');
INSERT INTO "Author" VALUES (663, 'Hessam Khoshnevisan');
INSERT INTO "Author" VALUES (664, 'Kurt Mehlhorn');
INSERT INTO "Author" VALUES (665, 'Bennett L. Fox');
INSERT INTO "Author" VALUES (666, 'Werner Kuich');
INSERT INTO "Author" VALUES (667, 'Pratul Dublish');
INSERT INTO "Author" VALUES (668, 'Yehoshua Sagiv');
INSERT INTO "Author" VALUES (669, 'James D. Currie');
INSERT INTO "Author" VALUES (670, 'Terry I. Visentin');
INSERT INTO "Author" VALUES (671, 'Salvatore La Torre');
INSERT INTO "Author" VALUES (672, 'Susan Horwitz');
INSERT INTO "Author" VALUES (673, 'Thomas W. Reps');
INSERT INTO "Author" VALUES (674, 'Cristina Tîrnauca');
INSERT INTO "Author" VALUES (675, 'Alexandru Mateescu');
INSERT INTO "Author" VALUES (676, 'A. J. Kfoury');
INSERT INTO "Author" VALUES (677, 'Pawel Urzyczyn');
INSERT INTO "Author" VALUES (678, 'Sheldon Shen');
INSERT INTO "Author" VALUES (679, 'Aivars Lorencs');
INSERT INTO "Author" VALUES (680, 'Detlef Wotschke');
INSERT INTO "Author" VALUES (681, 'Gerd Kaufholz');
INSERT INTO "Author" VALUES (682, 'Rance Cleaveland');
INSERT INTO "Author" VALUES (683, 'John H. Reif');
INSERT INTO "Author" VALUES (684, 'Scott A. Smolka');
INSERT INTO "Author" VALUES (685, 'Paolo Zuliani');
INSERT INTO "Author" VALUES (686, 'Henk Alblas');
INSERT INTO "Author" VALUES (687, 'Wuxu Peng');
INSERT INTO "Author" VALUES (688, 'S. Purushothaman');
INSERT INTO "Author" VALUES (689, 'Ladislav Vagner');
INSERT INTO "Author" VALUES (690, 'Krzysztof R. Apt');
INSERT INTO "Author" VALUES (691, 'Petr A. Golovach');
INSERT INTO "Author" VALUES (692, 'Bernard Lidický');
INSERT INTO "Author" VALUES (693, 'Barnaby Martin');
INSERT INTO "Author" VALUES (694, 'Daniël Paulusma');
INSERT INTO "Author" VALUES (695, 'Piotr Rudnicki');
INSERT INTO "Author" VALUES (696, 'Lynn Robert Carter');
INSERT INTO "Author" VALUES (697, 'Tsutomu Kamimura');
INSERT INTO "Author" VALUES (698, 'Zdenek Sawa');
INSERT INTO "Author" VALUES (699, 'Petr Jancar');
INSERT INTO "Author" VALUES (700, 'Luc Duponcheel');
INSERT INTO "Author" VALUES (701, 'M. Duponcheel');
INSERT INTO "Author" VALUES (702, 'Erica Moodie');
INSERT INTO "Author" VALUES (703, 'Vernon Rego');
INSERT INTO "Author" VALUES (704, 'Tomasz Kowaltowski');
INSERT INTO "Author" VALUES (705, 'Xavier Nicollin');
INSERT INTO "Author" VALUES (706, 'Joseph Sifakis');
INSERT INTO "Author" VALUES (707, 'Sergio Yovine');
INSERT INTO "Author" VALUES (708, 'Vladimir G. Deineko');
INSERT INTO "Author" VALUES (709, 'Rüdiger Rudolf');
INSERT INTO "Author" VALUES (710, 'Jürgen Dassow');
INSERT INTO "Author" VALUES (711, 'Gabriel Thierrin');
INSERT INTO "Author" VALUES (712, 'Carlo Mereghetti');
INSERT INTO "Author" VALUES (713, 'Beatrice Palano');
INSERT INTO "Author" VALUES (714, 'Srecko Brlek');
INSERT INTO "Author" VALUES (715, 'Elisa Pergola');
INSERT INTO "Author" VALUES (716, 'Olivier Roques');
INSERT INTO "Author" VALUES (717, 'Wen-Jing Hsu');
INSERT INTO "Author" VALUES (718, 'Carl V. Page');
INSERT INTO "Author" VALUES (719, 'Aristid Lindenmayer');
INSERT INTO "Author" VALUES (720, 'Shlomi Dolev');
INSERT INTO "Author" VALUES (721, 'Elad Schiller');
INSERT INTO "Author" VALUES (722, 'Artem Polyvyanyy');
INSERT INTO "Author" VALUES (723, 'Matthias Weidlich');
INSERT INTO "Author" VALUES (724, 'Mathias Weske');
INSERT INTO "Author" VALUES (725, 'Michael Domaratzki');
INSERT INTO "Author" VALUES (726, 'Armin Kühnemann');
INSERT INTO "Author" VALUES (727, 'Ole Eriksen');
INSERT INTO "Author" VALUES (728, 'Jørgen Staunstrup');
INSERT INTO "Author" VALUES (729, 'Marcus Größer');
INSERT INTO "Author" VALUES (730, 'D. T. Lee');
INSERT INTO "Author" VALUES (731, 'Jay Earley');
INSERT INTO "Author" VALUES (732, 'Athanasios K. Tsakalidis');
INSERT INTO "Author" VALUES (733, 'Jainendra K. Navlakha');
INSERT INTO "Author" VALUES (734, 'William F. Ogden');
INSERT INTO "Author" VALUES (735, 'Peter J. L. Wallis');
INSERT INTO "Author" VALUES (736, 'Betty Salzberg');
INSERT INTO "Author" VALUES (737, 'Ali Mili');
INSERT INTO "Author" VALUES (738, 'Jules Desharnais');
INSERT INTO "Author" VALUES (739, 'Jean-Raymond Gagné');
INSERT INTO "Author" VALUES (740, 'Hing Leung');
INSERT INTO "Author" VALUES (741, 'Jen-Tse Wang');
INSERT INTO "Author" VALUES (742, 'L. J. Steggles');
INSERT INTO "Author" VALUES (743, 'Stefan Hertel');
INSERT INTO "Author" VALUES (744, 'Martti Mäntylä');
INSERT INTO "Author" VALUES (745, 'Joseph A. Bannister');
INSERT INTO "Author" VALUES (746, 'Kishor S. Trivedi');
INSERT INTO "Author" VALUES (747, 'Ulf R. Schmerl');
INSERT INTO "Author" VALUES (748, 'Gunnar Forst');
INSERT INTO "Author" VALUES (749, 'Anders Thorup');
INSERT INTO "Author" VALUES (750, 'Marek J. Lao');
INSERT INTO "Author" VALUES (751, 'Jacques Cohen');
INSERT INTO "Author" VALUES (752, 'Martin S. Roth');
INSERT INTO "Author" VALUES (753, 'Chung-Yee Lee');
INSERT INTO "Author" VALUES (754, 'Surya Danusaputro Liman');
INSERT INTO "Author" VALUES (755, 'Stefan Kahrs');
INSERT INTO "Author" VALUES (756, 'Wolfgang J. Paul');
INSERT INTO "Author" VALUES (757, 'Ernst J. Prauß');
INSERT INTO "Author" VALUES (758, 'Rüdiger Reischuk');
INSERT INTO "Author" VALUES (759, 'Jean-Pierre Banâtre');
INSERT INTO "Author" VALUES (760, 'Patrice Frison');
INSERT INTO "Author" VALUES (761, 'Patrice Quinton');
INSERT INTO "Author" VALUES (762, 'Wilf R. LaLonde');
INSERT INTO "Author" VALUES (763, 'Manuel Sorge');
INSERT INTO "Author" VALUES (764, 'Hannes Moser');
INSERT INTO "Author" VALUES (765, 'Rolf Niedermeier');
INSERT INTO "Author" VALUES (766, 'Mathias Weller');
INSERT INTO "Author" VALUES (767, 'Nike van Vugt');
INSERT INTO "Author" VALUES (768, 'Hirokazu Nishimura');
INSERT INTO "Author" VALUES (769, 'Paulo Tabuada');
INSERT INTO "Author" VALUES (770, 'James E. Donahue');
INSERT INTO "Author" VALUES (771, 'Wolfgang K. Giloi');
INSERT INTO "Author" VALUES (772, 'José L. Encarnação');
INSERT INTO "Author" VALUES (773, 'S. Savitt');
INSERT INTO "Author" VALUES (774, 'Anthony J. Fisher');
INSERT INTO "Author" VALUES (775, 'Wladimir Fridman');
INSERT INTO "Author" VALUES (776, 'Bernd Puchala');
INSERT INTO "Author" VALUES (777, 'Louxin Zhang');
INSERT INTO "Author" VALUES (778, 'Suo Ping Li');
INSERT INTO "Author" VALUES (779, 'Yong Qiang Zhou');
INSERT INTO "Author" VALUES (780, 'Yong Zhou');
INSERT INTO "Author" VALUES (781, 'Andreas Weber');
INSERT INTO "Author" VALUES (782, 'Alexander Tuzhilin');
INSERT INTO "Author" VALUES (783, 'Dirk Nowotka');
INSERT INTO "Author" VALUES (784, 'Michele Boreale');
INSERT INTO "Author" VALUES (785, 'Carlos Martín-Vide');
INSERT INTO "Author" VALUES (786, 'Volker Strassen');
INSERT INTO "Author" VALUES (787, 'Frank K. Hwang');
INSERT INTO "Author" VALUES (788, 'Shen Lin 0005');
INSERT INTO "Author" VALUES (789, 'Gunnar Stålmarck');
INSERT INTO "Author" VALUES (790, 'Rachele Fuzzati');
INSERT INTO "Author" VALUES (791, 'Massimo Merro');
INSERT INTO "Author" VALUES (792, 'Uwe Nestmann');
INSERT INTO "Author" VALUES (793, 'J. Eve');
INSERT INTO "Author" VALUES (794, 'Reino Kurki-Suonio');
INSERT INTO "Author" VALUES (795, 'Alain J. Martin');
INSERT INTO "Author" VALUES (796, 'Colin Adams');
INSERT INTO "Author" VALUES (797, 'Jean Vicard');
INSERT INTO "Author" VALUES (798, 'Ronald V. Book');
INSERT INTO "Author" VALUES (799, 'Ashok K. Chandra');
INSERT INTO "Author" VALUES (800, 'Peter J. Downey');
INSERT INTO "Author" VALUES (801, 'Peter M. Winkler');
INSERT INTO "Author" VALUES (802, 'Amrinder Arora');
INSERT INTO "Author" VALUES (803, 'Fanchun Jin');
INSERT INTO "Author" VALUES (804, 'Gokhan Sahin');
INSERT INTO "Author" VALUES (805, 'Hosam Mahmoud');
INSERT INTO "Author" VALUES (806, 'Hyeong-Ah Choi');
INSERT INTO "Author" VALUES (807, 'Tamás Gergely');
INSERT INTO "Author" VALUES (808, 'László Úry');
INSERT INTO "Author" VALUES (809, 'Paul E. S. Dunne');
INSERT INTO "Author" VALUES (810, 'Sam M. Kim');
INSERT INTO "Author" VALUES (811, 'Elvira Locuratolo');
INSERT INTO "Author" VALUES (812, 'Fausto Rabitti');
INSERT INTO "Author" VALUES (813, 'Jakob Gonczarowski');
INSERT INTO "Author" VALUES (814, 'Yoshiki Kinoshita');
INSERT INTO "Author" VALUES (815, 'John Power');
INSERT INTO "Author" VALUES (816, 'P. Bouchet');
INSERT INTO "Author" VALUES (817, 'Frank Tip');
INSERT INTO "Author" VALUES (818, 'Peter F. Sweeney');
INSERT INTO "Author" VALUES (819, 'Maurice Clint');
INSERT INTO "Author" VALUES (820, 'Jan Van den Bussche');
INSERT INTO "Author" VALUES (821, 'Luca Cabibbo');
INSERT INTO "Author" VALUES (822, 'Karel Culík');
INSERT INTO "Author" VALUES (823, 'Michael A. Arbib');
INSERT INTO "Author" VALUES (824, 'Zvi M. Kedem');
INSERT INTO "Author" VALUES (825, 'Abraham Silberschatz');
INSERT INTO "Author" VALUES (826, 'Robert B. K. Dewar');
INSERT INTO "Author" VALUES (827, 'Susan M. Merritt');
INSERT INTO "Author" VALUES (828, 'Micha Sharir');
INSERT INTO "Author" VALUES (829, 'Dominique Perrin');
INSERT INTO "Author" VALUES (830, 'J. P. Crestin');
INSERT INTO "Author" VALUES (831, 'Philippe Nain');
INSERT INTO "Author" VALUES (832, 'Carl Langenhop');
INSERT INTO "Author" VALUES (833, 'Mark Levene');
INSERT INTO "Author" VALUES (834, 'George Loizou');
INSERT INTO "Author" VALUES (835, 'Esko Ukkonen');
INSERT INTO "Author" VALUES (836, 'Ingo Schmitt');
INSERT INTO "Author" VALUES (837, 'Gunter Saake');
INSERT INTO "Author" VALUES (838, 'Mirko Krivánek');
INSERT INTO "Author" VALUES (839, 'Jaroslav Morávek');
INSERT INTO "Author" VALUES (840, 'Jifeng He');
INSERT INTO "Author" VALUES (841, 'Klaus Ecker');
INSERT INTO "Author" VALUES (842, 'Helmut Ratschek');
INSERT INTO "Author" VALUES (843, 'Shigeru Igarashi');
INSERT INTO "Author" VALUES (844, 'Ralph L. London');
INSERT INTO "Author" VALUES (845, 'David C. Luckham');
INSERT INTO "Author" VALUES (846, 'Paul Helman');
INSERT INTO "Author" VALUES (847, 'Béatrice Bérard');
INSERT INTO "Author" VALUES (848, 'Claudine Picaronny');
INSERT INTO "Author" VALUES (849, 'Onno J. Boxma');
INSERT INTO "Author" VALUES (850, 'Alan G. Konheim');
INSERT INTO "Author" VALUES (851, 'Carlton J. Maxson');
INSERT INTO "Author" VALUES (852, 'Paul Walton Purdom Jr.');
INSERT INTO "Author" VALUES (853, 'Cynthia A. Brown');
INSERT INTO "Author" VALUES (854, 'C. Samuel Hsieh');
INSERT INTO "Author" VALUES (855, 'Brian Johnson');
INSERT INTO "Author" VALUES (856, 'Stefano Bilotta');
INSERT INTO "Author" VALUES (857, 'Elisabetta Grazzini');
INSERT INTO "Author" VALUES (858, 'Renzo Pinzani');
INSERT INTO "Author" VALUES (859, 'Berthold Hoffmann');
INSERT INTO "Author" VALUES (860, 'Bernhard Möller');
INSERT INTO "Author" VALUES (861, 'Kenichi Morita');
INSERT INTO "Author" VALUES (862, 'Noritaka Nishihara');
INSERT INTO "Author" VALUES (863, 'Yasunori Yamamoto');
INSERT INTO "Author" VALUES (864, 'Zhiguo Zhang');
INSERT INTO "Author" VALUES (865, 'Patrick E. O''Neil');
INSERT INTO "Author" VALUES (866, 'Fatma Mili');
INSERT INTO "Author" VALUES (867, 'Edsger W. Dijkstra');
INSERT INTO "Author" VALUES (868, 'Kazuo Iwama');
INSERT INTO "Author" VALUES (869, 'Giuliano Pacini');
INSERT INTO "Author" VALUES (870, 'Maria Simi');
INSERT INTO "Author" VALUES (871, 'Franco Turini');
INSERT INTO "Author" VALUES (872, 'Gerda Schott');
INSERT INTO "Author" VALUES (873, 'Vijay K. Garg');
INSERT INTO "Author" VALUES (874, 'Alexander I. Tomlinson');
INSERT INTO "Author" VALUES (875, 'Guy Fayolle');
INSERT INTO "Author" VALUES (876, 'D. Bastin');
INSERT INTO "Author" VALUES (877, 'R. M. Wharton');
INSERT INTO "Author" VALUES (878, 'Klaus Indermark');
INSERT INTO "Author" VALUES (879, 'Thomas Noll');
INSERT INTO "Author" VALUES (880, 'Mohammad Mahdi Jaghoori');
INSERT INTO "Author" VALUES (881, 'Marjan Sirjani');
INSERT INTO "Author" VALUES (882, 'Mohammad Reza Mousavi');
INSERT INTO "Author" VALUES (883, 'Ehsan Khamespanah');
INSERT INTO "Author" VALUES (884, 'Ali Movaghar');
INSERT INTO "Author" VALUES (885, 'Maurice Schlumberger');
INSERT INTO "Author" VALUES (886, 'Jean Vuillemin');
INSERT INTO "Author" VALUES (887, 'K. Narayan Kumar');
INSERT INTO "Author" VALUES (888, 'Paritosh K. Pandya');
INSERT INTO "Author" VALUES (889, 'Catherine Rosenberg');
INSERT INTO "Author" VALUES (890, 'Carla Schlatter Ellis');
INSERT INTO "Author" VALUES (891, 'William M. Waite');
INSERT INTO "Author" VALUES (892, 'Mingsheng Ying');
INSERT INTO "Author" VALUES (893, 'Yunhe Wang');
INSERT INTO "Author" VALUES (894, 'Li Jiao');
INSERT INTO "Author" VALUES (895, 'Burkhard Monien');
INSERT INTO "Author" VALUES (896, 'Ewald Speckenmeyer');
INSERT INTO "Author" VALUES (897, 'Remco Loos');
INSERT INTO "Author" VALUES (898, 'Florin Manea');
INSERT INTO "Author" VALUES (899, 'Bing-Chao Huang');
INSERT INTO "Author" VALUES (900, 'Michael A. Langston');
INSERT INTO "Author" VALUES (901, 'Tim Teitelbaum');
INSERT INTO "Author" VALUES (902, 'Chandra M. R. Kintala');
INSERT INTO "Author" VALUES (903, 'Wilfred J. Hansen');
INSERT INTO "Author" VALUES (904, 'Hendrik Boom');
INSERT INTO "Author" VALUES (905, 'Augusto Celentano');
INSERT INTO "Author" VALUES (906, 'Bastian Katz');
INSERT INTO "Author" VALUES (907, 'Ignaz Rutter');
INSERT INTO "Author" VALUES (908, 'Vince Bárány');
INSERT INTO "Author" VALUES (909, 'Ferri Abolhassan');
INSERT INTO "Author" VALUES (910, 'Jörg Keller 0001');
INSERT INTO "Author" VALUES (911, 'Rafik Aguech');
INSERT INTO "Author" VALUES (912, 'Nabil Lasmar');
INSERT INTO "Author" VALUES (913, 'Julian Rathke');
INSERT INTO "Author" VALUES (914, 'C. L. Liu');
INSERT INTO "Author" VALUES (915, 'Jane W.-S. Liu');
INSERT INTO "Author" VALUES (916, 'Arthur L. Liestman');
INSERT INTO "Author" VALUES (917, 'Pierpaolo Degano');
INSERT INTO "Author" VALUES (918, 'José Meseguer');
INSERT INTO "Author" VALUES (919, 'Andrzej Biela');
INSERT INTO "Author" VALUES (920, 'Jakub Borowczyk');
INSERT INTO "Author" VALUES (921, 'Alfredo Burrieza');
INSERT INTO "Author" VALUES (922, 'Arne Andersson');
INSERT INTO "Author" VALUES (923, 'Christian Icking');
INSERT INTO "Author" VALUES (924, 'Rolf Klein');
INSERT INTO "Author" VALUES (925, 'Helmut Seidl');
INSERT INTO "Author" VALUES (926, 'Naomi Nishimura');
INSERT INTO "Author" VALUES (927, 'Prabhakar Ragde');
INSERT INTO "Author" VALUES (928, 'Stefan Szeider');
INSERT INTO "Author" VALUES (929, 'Joel I. Seiferas');
INSERT INTO "Author" VALUES (930, 'Tian-Shyr Dai');
INSERT INTO "Author" VALUES (931, 'Yuh-Dauh Lyuu');
INSERT INTO "Author" VALUES (932, 'Bernd Becker');
INSERT INTO "Author" VALUES (933, 'A. Nico Habermann');
INSERT INTO "Author" VALUES (934, 'Daniel M. Berry');
INSERT INTO "Author" VALUES (935, 'P. S. Thiagarajan');
INSERT INTO "Author" VALUES (936, 'Claus-Peter Schnorr');
INSERT INTO "Author" VALUES (937, 'Benny Godlin');
INSERT INTO "Author" VALUES (938, 'Ofer Strichman');
INSERT INTO "Author" VALUES (939, 'Nicole Lesley');
INSERT INTO "Author" VALUES (940, 'Mark B. Josephs');
INSERT INTO "Author" VALUES (941, 'Roy H. Campbell');
INSERT INTO "Author" VALUES (942, 'Sebastian Link');
INSERT INTO "Author" VALUES (943, 'Juraj Hromkovic');
INSERT INTO "Author" VALUES (944, 'Piotr Wyrostek');
INSERT INTO "Author" VALUES (945, 'J. Terlouw');
INSERT INTO "Author" VALUES (946, 'Dirk Taubner');
INSERT INTO "Author" VALUES (947, 'Betti Venneri');
INSERT INTO "Author" VALUES (948, 'Viviana Bono');
INSERT INTO "Author" VALUES (949, 'Ernst-Erich Doberkat');
INSERT INTO "Author" VALUES (950, 'Danièle Beauquier');
INSERT INTO "Author" VALUES (951, 'Anatol Slissenko');
INSERT INTO "Author" VALUES (952, 'Werner Damm');
INSERT INTO "Author" VALUES (953, 'Bernhard Josko');
INSERT INTO "Author" VALUES (954, 'Frantisek Mráz');
INSERT INTO "Author" VALUES (955, 'Martin Plátek');
INSERT INTO "Author" VALUES (956, 'Laurent Pierre');
INSERT INTO "Author" VALUES (957, 'Sylviane R. Schwer');
INSERT INTO "Author" VALUES (958, 'A. Nahapetian');
INSERT INTO "Author" VALUES (959, 'Lex Bijlsma');
INSERT INTO "Author" VALUES (960, 'Rob Nederpelt');
INSERT INTO "Author" VALUES (961, 'Matteo Magnani');
INSERT INTO "Author" VALUES (962, 'Danilo Montesi');
INSERT INTO "Author" VALUES (963, 'Sridhar Vasudevan');
INSERT INTO "Author" VALUES (964, 'Leslie M. Goldschlager');
INSERT INTO "Author" VALUES (965, 'Peter D. Welch');
INSERT INTO "Author" VALUES (966, 'Walter Bucher');
INSERT INTO "Author" VALUES (967, 'Luc Moreau');
INSERT INTO "Author" VALUES (968, 'Jean Duprat');
INSERT INTO "Author" VALUES (969, 'T. Betteridge');
INSERT INTO "Author" VALUES (970, 'Janet A. Walz');
INSERT INTO "Author" VALUES (971, 'Gregory F. Johnson');
INSERT INTO "Author" VALUES (972, 'Wladyslaw M. Turski');
INSERT INTO "Author" VALUES (973, 'Brian Randell');
INSERT INTO "Author" VALUES (974, 'Uli Fahrenberg');
INSERT INTO "Author" VALUES (975, 'Axel Legay');
INSERT INTO "Author" VALUES (976, 'Jirí Techet');
INSERT INTO "Author" VALUES (977, 'Chuzo Iwamoto');
INSERT INTO "Author" VALUES (978, 'Katsuyuki Tateishi');
INSERT INTO "Author" VALUES (979, 'Katsunobu Imai');
INSERT INTO "Author" VALUES (980, 'Daowen Qiu');
INSERT INTO "Author" VALUES (981, 'Lvzhou Li');
INSERT INTO "Author" VALUES (982, 'Xiangfu Zou');
INSERT INTO "Author" VALUES (983, 'Paulo Mateus');
INSERT INTO "Author" VALUES (984, 'H. T. Kung');
INSERT INTO "Author" VALUES (985, 'Christos H. Papadimitriou');
INSERT INTO "Author" VALUES (986, 'Takao Tsuda');
INSERT INTO "Author" VALUES (987, 'Takashi Sato');
INSERT INTO "Author" VALUES (988, 'Chongkye Rhee');
INSERT INTO "Author" VALUES (989, 'Satoru Miyano');
INSERT INTO "Author" VALUES (990, 'Arash Farzan');
INSERT INTO "Author" VALUES (991, 'John Iacono');
INSERT INTO "Author" VALUES (992, 'Clelia De Felice');
INSERT INTO "Author" VALUES (993, 'Reiner Kolla');
INSERT INTO "Author" VALUES (994, 'Bernd Serf');
INSERT INTO "Author" VALUES (995, 'Keijo Ruohonen');
INSERT INTO "Author" VALUES (996, 'Baudouin Le Charlier');
INSERT INTO "Author" VALUES (997, 'Pascal Van Hentenryck');
INSERT INTO "Author" VALUES (998, 'Jeremy Dick');
INSERT INTO "Author" VALUES (999, 'John Kalmus');
INSERT INTO "Author" VALUES (1000, 'Ursula Martin');
INSERT INTO "Author" VALUES (1001, 'Lawrence Snyder');
INSERT INTO "Author" VALUES (1002, 'Alfs T. Berztiss');
INSERT INTO "Author" VALUES (1003, 'Reiner Philipp');
INSERT INTO "Author" VALUES (1004, 'Ernst-Jürgen Prauß');
INSERT INTO "Author" VALUES (1005, 'Takehiro Tokuda');
INSERT INTO "Author" VALUES (1006, 'Teodor Rus');
INSERT INTO "Author" VALUES (1007, 'Sriram V. Pemmaraju');
INSERT INTO "Author" VALUES (1008, 'John Buckle');
INSERT INTO "Author" VALUES (1009, 'Eugene Asarin');
INSERT INTO "Author" VALUES (1010, 'Thao Dang');
INSERT INTO "Author" VALUES (1011, 'Antoine Girard');
INSERT INTO "Author" VALUES (1012, 'Edward P. F. Chan');
INSERT INTO "Author" VALUES (1013, 'Héctor J. Hernández');
INSERT INTO "Author" VALUES (1014, 'Jixue Liu');
INSERT INTO "Author" VALUES (1015, 'Millist W. Vincent');
INSERT INTO "Author" VALUES (1016, 'A. C. McKellar');
INSERT INTO "Author" VALUES (1017, 'Javier Esparza');
INSERT INTO "Author" VALUES (1018, 'Walter Cazzola');
INSERT INTO "Author" VALUES (1019, 'Edoardo Vacchi');
INSERT INTO "Author" VALUES (1020, 'Francine Blanchet-Sadri');
INSERT INTO "Author" VALUES (1021, 'Robert Mercas');
INSERT INTO "Author" VALUES (1022, 'Sean Simmons');
INSERT INTO "Author" VALUES (1023, 'Eric Weissenstein');
INSERT INTO "Author" VALUES (1024, 'Foued Ameur');
INSERT INTO "Author" VALUES (1025, 'Paul Fischer');
INSERT INTO "Author" VALUES (1026, 'Klaus-Uwe Höffgen');
INSERT INTO "Author" VALUES (1027, 'Julien Cassaigne');
INSERT INTO "Author" VALUES (1028, 'César Sánchez');
INSERT INTO "Author" VALUES (1029, 'Andrea Walther');
INSERT INTO "Author" VALUES (1030, 'Kari-Jouko Räihä');
INSERT INTO "Author" VALUES (1031, 'Mikko Saarinen');
INSERT INTO "Author" VALUES (1032, 'Edward Cheng');
INSERT INTO "Author" VALUES (1033, 'Dieter Gawlick');
INSERT INTO "Author" VALUES (1034, 'Elizabeth J. O''Neil');
INSERT INTO "Author" VALUES (1035, 'Jayme Luiz Szwarcfiter');
INSERT INTO "Author" VALUES (1036, 'Fabienne Lagnier');
INSERT INTO "Author" VALUES (1037, 'Christophe Ratel');
INSERT INTO "Author" VALUES (1038, 'Davide Bresolin');
INSERT INTO "Author" VALUES (1039, 'Angelo Montanari');
INSERT INTO "Author" VALUES (1040, 'Gabriele Puppis');
INSERT INTO "Author" VALUES (1041, 'Carlo Meghini');
INSERT INTO "Author" VALUES (1042, 'Costantino Thanos');
INSERT INTO "Author" VALUES (1043, 'Gilberto Filé');
INSERT INTO "Author" VALUES (1044, 'Dana S. Richards');
INSERT INTO "Author" VALUES (1045, 'Jeffrey S. Salowe');
INSERT INTO "Author" VALUES (1046, 'Richard R. Muntz');
INSERT INTO "Author" VALUES (1047, 'Astrid R. Rühl');
INSERT INTO "Author" VALUES (1048, 'Daniel M. Yellin');
INSERT INTO "Author" VALUES (1049, 'Leopold Flatto');
INSERT INTO "Author" VALUES (1050, 'Alexander Y. Kreinin');
INSERT INTO "Author" VALUES (1051, 'Stal O. Anderaa');
INSERT INTO "Author" VALUES (1052, 'Egon Börger');
INSERT INTO "Author" VALUES (1053, 'Han-Hing Dang');
INSERT INTO "Author" VALUES (1054, 'Peter Rajcáni');
INSERT INTO "Author" VALUES (1055, 'Jan Kratochvíl');
INSERT INTO "Author" VALUES (1056, 'Emo Welzl');
INSERT INTO "Author" VALUES (1057, 'Peter Höfner');
INSERT INTO "Author" VALUES (1058, 'Wojciech Szpankowski');
INSERT INTO "Author" VALUES (1059, 'Donald L. Iglehart');
INSERT INTO "Author" VALUES (1060, 'Gerald S. Shedler');
INSERT INTO "Author" VALUES (1061, 'Henry S. Warren Jr.');
INSERT INTO "Author" VALUES (1062, 'Mario Coppo');
INSERT INTO "Author" VALUES (1063, 'Chris Giannella');
INSERT INTO "Author" VALUES (1064, 'Dirk Van Gucht');
INSERT INTO "Author" VALUES (1065, 'Paolo Atzeni');
INSERT INTO "Author" VALUES (1066, 'Cristian Ioan Vasile');
INSERT INTO "Author" VALUES (1067, 'Ana Brândusa Pavel');
INSERT INTO "Author" VALUES (1068, 'Ioan Dumitrache');
INSERT INTO "Author" VALUES (1069, 'Robert Gold');
INSERT INTO "Author" VALUES (1070, 'Alexander Moshe Rabinovich');
INSERT INTO "Author" VALUES (1071, 'Asaf Levin');
INSERT INTO "Author" VALUES (1072, 'Norihisa Suzuki');
INSERT INTO "Author" VALUES (1073, 'Lawrence A. Harris');
INSERT INTO "Author" VALUES (1074, 'Wim Janssen');
INSERT INTO "Author" VALUES (1075, 'Alexandr Korlyukov');
INSERT INTO "Author" VALUES (1076, 'Rolf Schassberger');
INSERT INTO "Author" VALUES (1077, 'Hans Albrecht Schmid');
INSERT INTO "Author" VALUES (1078, 'Ute Schürfeld');
INSERT INTO "Author" VALUES (1079, 'Yuan Feng');
INSERT INTO "Author" VALUES (1080, 'Gérard P. Huet');
INSERT INTO "Author" VALUES (1081, 'Bernard Lang');
INSERT INTO "Author" VALUES (1082, 'Svante Carlsson');
INSERT INTO "Author" VALUES (1083, 'Jingsen Chen');
INSERT INTO "Author" VALUES (1084, 'Jeongbong Seo');
INSERT INTO "Author" VALUES (1085, 'Sungwoo Park');
INSERT INTO "Author" VALUES (1086, 'Claus H. Correl');
INSERT INTO "Author" VALUES (1087, 'Mark Benedict Bilodeau');
INSERT INTO "Author" VALUES (1088, 'Pál Dömösi');
INSERT INTO "Author" VALUES (1089, 'György Maróti');
INSERT INTO "Author" VALUES (1090, 'Robert D. Tennent');
INSERT INTO "Author" VALUES (1091, 'Marisela Hernández');
INSERT INTO "Author" VALUES (1092, 'Susanne Graf');
INSERT INTO "Author" VALUES (1093, 'Joaquin Aguado');
INSERT INTO "Author" VALUES (1094, 'Michael Mendler');
INSERT INTO "Author" VALUES (1095, 'Reinhard von Hanxleden');
INSERT INTO "Author" VALUES (1096, 'Insa Fuhrmann');
INSERT INTO "Author" VALUES (1097, 'Marina C. Chen');
INSERT INTO "Author" VALUES (1098, 'Martin Rem');
INSERT INTO "Author" VALUES (1099, 'Fernando Rosa-Velardo');
INSERT INTO "Author" VALUES (1100, 'Yifeng Chen');
INSERT INTO "Author" VALUES (1101, 'Jeff W. Sanders');
INSERT INTO "Author" VALUES (1102, 'Pavel Pudlák');
INSERT INTO "Author" VALUES (1103, 'Vojtech Rödl');
INSERT INTO "Author" VALUES (1104, 'Petr Savický');
INSERT INTO "Author" VALUES (1105, 'Johannes G. G. van de Vorst');
INSERT INTO "Author" VALUES (1106, 'Volker Diekert');
INSERT INTO "Author" VALUES (1107, 'Anca Muscholl');
INSERT INTO "Author" VALUES (1108, 'Antonio Bernini');
INSERT INTO "Author" VALUES (1109, 'Ahmad Sabri');
INSERT INTO "Author" VALUES (1110, 'Rudolph Sommerhalder');
INSERT INTO "Author" VALUES (1111, 'S. Christian van Westrhenen');
INSERT INTO "Author" VALUES (1112, 'Jos C. M. Baeten');
INSERT INTO "Author" VALUES (1113, 'Frits W. Vaandrager');
INSERT INTO "Author" VALUES (1114, 'Jay Sethuraman');
INSERT INTO "Author" VALUES (1115, 'Vadim G. Timkovsky');
INSERT INTO "Author" VALUES (1116, 'Paulien ten Pas');
INSERT INTO "Author" VALUES (1117, 'M. R. K. Krishna Rao');
INSERT INTO "Author" VALUES (1118, 'Donald W. Gillies');
INSERT INTO "Author" VALUES (1119, 'Pierre-Jacques Courtois');
INSERT INTO "Author" VALUES (1120, 'Hendrik Vantilborgh');
INSERT INTO "Author" VALUES (1121, 'Philippe Chanzy');
INSERT INTO "Author" VALUES (1122, 'Carlos Zamora-Cura');
INSERT INTO "Author" VALUES (1123, 'Walter Cunto');
INSERT INTO "Author" VALUES (1124, 'J. Xu');
INSERT INTO "Author" VALUES (1125, 'Claus Jensen');
INSERT INTO "Author" VALUES (1126, 'Jyrki Katajainen');
INSERT INTO "Author" VALUES (1127, 'Larissa Meinicke');
INSERT INTO "Author" VALUES (1128, 'Ian J. Hayes');
INSERT INTO "Author" VALUES (1129, 'Wei-Ngan Chin');
INSERT INTO "Author" VALUES (1130, 'Masami Hagiya');
INSERT INTO "Author" VALUES (1131, 'Marco A. Casanova');
INSERT INTO "Author" VALUES (1132, 'Philip A. Bernstein');
INSERT INTO "Author" VALUES (1133, 'James H. Anderson');
INSERT INTO "Author" VALUES (1134, 'Mohamed G. Gouda');
INSERT INTO "Author" VALUES (1135, 'Ole Lehrmann Madsen');
INSERT INTO "Author" VALUES (1136, 'Bent Bruun Kristensen');
INSERT INTO "Author" VALUES (1137, 'José M. Bernabéu-Aubán');
INSERT INTO "Author" VALUES (1138, 'Mustaque Ahamad');
INSERT INTO "Author" VALUES (1139, 'Mostafa H. Ammar');
INSERT INTO "Author" VALUES (1140, 'Alon Itai');
INSERT INTO "Author" VALUES (1141, 'Arnd Rußmann');
INSERT INTO "Author" VALUES (1142, 'Bartek Kiepuszewski');
INSERT INTO "Author" VALUES (1143, 'Arthur H. M. ter Hofstede');
INSERT INTO "Author" VALUES (1144, 'Wil M. P. van der Aalst');
INSERT INTO "Author" VALUES (1145, 'Li Layuan');
INSERT INTO "Author" VALUES (1146, 'Li Chunlin');
INSERT INTO "Author" VALUES (1147, 'Mickael Randour');
INSERT INTO "Author" VALUES (1148, 'Jean-François Raskin');
INSERT INTO "Author" VALUES (1149, 'Brigitte Plateau');
INSERT INTO "Author" VALUES (1150, 'Ke Wang');
INSERT INTO "Author" VALUES (1151, 'Weining Zhang');
INSERT INTO "Author" VALUES (1152, 'Siu-Cheung Chau');
INSERT INTO "Author" VALUES (1153, 'Cezar Câmpeanu');
INSERT INTO "Author" VALUES (1154, 'Klaus W. Wagner');
INSERT INTO "Author" VALUES (1155, 'Tatsuie Tsukiji');
INSERT INTO "Author" VALUES (1156, 'Søren Lauesen');
INSERT INTO "Author" VALUES (1157, 'Warren Burton');
INSERT INTO "Author" VALUES (1158, 'S. A. Bengelloun');
INSERT INTO "Author" VALUES (1159, 'Dana S. Scott');
INSERT INTO "Author" VALUES (1160, 'Richard S. Bird');
INSERT INTO "Author" VALUES (1161, 'Arend Rensink');
INSERT INTO "Author" VALUES (1162, 'Heike Wehrheim');
INSERT INTO "Author" VALUES (1163, 'Klaus Voss');
INSERT INTO "Author" VALUES (1164, 'Annegret Habel');
INSERT INTO "Author" VALUES (1165, 'Hans-Jörg Kreowski');
INSERT INTO "Author" VALUES (1166, 'Alejandro Sánchez');
INSERT INTO "Author" VALUES (1167, 'Michael Bechtold');
INSERT INTO "Author" VALUES (1168, 'Otto Spaniol');
INSERT INTO "Author" VALUES (1169, 'C. C. Gotlieb');
INSERT INTO "Author" VALUES (1170, 'Bo-Ting Yang');
INSERT INTO "Author" VALUES (1171, 'Paul Gillard');
INSERT INTO "Author" VALUES (1172, 'Jean Néraud');
INSERT INTO "Author" VALUES (1173, 'Hartmann J. Genrich');
INSERT INTO "Author" VALUES (1174, 'Kurt Lautenbach');
INSERT INTO "Author" VALUES (1175, 'Nicoletta De Francesco');
INSERT INTO "Author" VALUES (1176, 'Jim Cunningham');
INSERT INTO "Author" VALUES (1177, 'A. J. J. Dick');
INSERT INTO "Author" VALUES (1178, 'R. Zuczek');
INSERT INTO "Author" VALUES (1179, 'Joseph G. Peters');
INSERT INTO "Author" VALUES (1180, 'Larry Rudolph');
INSERT INTO "Author" VALUES (1181, 'Deepak Kapur');
INSERT INTO "Author" VALUES (1182, 'Paliath Narendran');
INSERT INTO "Author" VALUES (1183, 'Daniel J. Rosenkrantz');
INSERT INTO "Author" VALUES (1184, 'Hantao Zhang');
INSERT INTO "Author" VALUES (1185, 'Pierre Deransart');
INSERT INTO "Author" VALUES (1186, 'Martin Jourdan');
INSERT INTO "Author" VALUES (1187, 'Bernard Lorho');
INSERT INTO "Author" VALUES (1188, 'Inge Bethke');
INSERT INTO "Author" VALUES (1189, 'Alban Ponse');
INSERT INTO "Author" VALUES (1190, 'Graham Farr');
INSERT INTO "Author" VALUES (1191, 'Georg Trogemann');
INSERT INTO "Author" VALUES (1192, 'Matthias Gente');
INSERT INTO "Author" VALUES (1193, 'Michael Drmota');
INSERT INTO "Author" VALUES (1194, 'Richard J. Waldinger');
INSERT INTO "Author" VALUES (1195, 'Görkem Kilinç');
INSERT INTO "Author" VALUES (1196, 'Gordon V. Cormack');
INSERT INTO "Author" VALUES (1197, 'John Ophel');
INSERT INTO "Author" VALUES (1198, 'Klaus-Dieter Schewe');
INSERT INTO "Author" VALUES (1199, 'Bernhard Thalheim');
INSERT INTO "Author" VALUES (1200, 'Tamar Aizikowitz');
INSERT INTO "Author" VALUES (1201, 'Michael Kaminski');
INSERT INTO "Author" VALUES (1202, 'Celia Wrathall');
INSERT INTO "Author" VALUES (1203, 'Christine Chifen Tseng');
INSERT INTO "Author" VALUES (1204, 'Helmut Alt');
INSERT INTO "Author" VALUES (1205, 'Fernando Arroyo');
INSERT INTO "Author" VALUES (1206, 'Juan Castellanos');
INSERT INTO "Author" VALUES (1207, 'José-Ramón Sánchez-Couso');
INSERT INTO "Author" VALUES (1208, 'Mordechai Ben-Ari');
INSERT INTO "Author" VALUES (1209, 'Corrado Priami');
INSERT INTO "Author" VALUES (1210, 'Lone Leth');
INSERT INTO "Author" VALUES (1211, 'Bent Thomsen');
INSERT INTO "Author" VALUES (1212, 'Paola Inverardi');
INSERT INTO "Author" VALUES (1213, 'Christian Dax');
INSERT INTO "Author" VALUES (1214, 'Felix Klaedtke');
INSERT INTO "Author" VALUES (1215, 'Martin Lange');
INSERT INTO "Author" VALUES (1216, 'Kamal Lodaya');
INSERT INTO "Author" VALUES (1217, 'R. K. Shyamasundar');
INSERT INTO "Author" VALUES (1218, 'Alberto Pettorossi');
INSERT INTO "Author" VALUES (1219, 'Rod M. Burstall');
INSERT INTO "Author" VALUES (1220, 'C. C. Lee');
INSERT INTO "Author" VALUES (1221, 'Joseph JáJá');
INSERT INTO "Author" VALUES (1222, 'Janos Simon');
INSERT INTO "Author" VALUES (1223, 'Masato Takeichi');
INSERT INTO "Author" VALUES (1224, 'Hartmut Messerschmidt');
INSERT INTO "Author" VALUES (1225, 'Robert Geist');
INSERT INTO "Author" VALUES (1226, 'Mark Smotherman');
INSERT INTO "Author" VALUES (1227, 'Joanne Bechta Dugan');
INSERT INTO "Author" VALUES (1228, 'Roni Khardon');
INSERT INTO "Author" VALUES (1229, 'Dan Roth');
INSERT INTO "Author" VALUES (1230, 'Thomas P. Whaley');
INSERT INTO "Author" VALUES (1231, 'Leonard M. Adleman');
INSERT INTO "Author" VALUES (1232, 'Kellogg S. Booth');
INSERT INTO "Author" VALUES (1233, 'Franco P. Preparata');
INSERT INTO "Author" VALUES (1234, 'Walter L. Ruzzo');
INSERT INTO "Author" VALUES (1235, 'Hans Daduna');
INSERT INTO "Author" VALUES (1236, 'C. A. R. Hoare');
INSERT INTO "Author" VALUES (1237, 'Miguel R. Penabad');
INSERT INTO "Author" VALUES (1238, 'Nieves R. Brisaboa');
INSERT INTO "Author" VALUES (1239, 'José R. Paramá');
INSERT INTO "Author" VALUES (1240, 'Oliver Schoett');
INSERT INTO "Author" VALUES (1241, 'Youichi Kobuchi');
INSERT INTO "Author" VALUES (1242, 'Takashi Saito');
INSERT INTO "Author" VALUES (1243, 'Hidenobu Nunome');
INSERT INTO "Author" VALUES (1244, 'Bernard Chazelle');
INSERT INTO "Author" VALUES (1245, 'Helmut Jürgensen');
INSERT INTO "Author" VALUES (1246, 'Ludwig Staiger');
INSERT INTO "Author" VALUES (1247, 'Derek Coleman');
INSERT INTO "Author" VALUES (1248, 'Jane W. Hughes');
INSERT INTO "Author" VALUES (1249, 'Kenneth J. Supowit');
INSERT INTO "Author" VALUES (1250, 'Edward M. Reingold');
INSERT INTO "Author" VALUES (1251, 'Sumit Sur');
INSERT INTO "Author" VALUES (1252, 'Arunabha Sen');
INSERT INTO "Author" VALUES (1253, 'Géraud Sénizergues');
INSERT INTO "Author" VALUES (1254, 'Olivier Lecarme');
INSERT INTO "Author" VALUES (1255, 'Pierre Desjardins');
INSERT INTO "Author" VALUES (1256, 'Joaquim Gabarró');
INSERT INTO "Author" VALUES (1257, 'Luca Aceto');
INSERT INTO "Author" VALUES (1258, 'David Murphy');
INSERT INTO "Author" VALUES (1259, 'Aldo de Luca');
INSERT INTO "Author" VALUES (1260, 'David J. Kuck');
INSERT INTO "Author" VALUES (1261, 'Yoichi Muraoka');
INSERT INTO "Author" VALUES (1262, 'Torsten Polle');
INSERT INTO "Author" VALUES (1263, 'David Spuler');
INSERT INTO "Author" VALUES (1264, 'Reiji Nakajima');
INSERT INTO "Author" VALUES (1265, 'Michio Honda');
INSERT INTO "Author" VALUES (1266, 'Hayao Nakahara');
INSERT INTO "Author" VALUES (1267, 'Chunhua Cao');
INSERT INTO "Author" VALUES (1268, 'Shuang Yang');
INSERT INTO "Author" VALUES (1269, 'Di Yang');
INSERT INTO "Author" VALUES (1270, 'Carl E. Landwehr');
INSERT INTO "Author" VALUES (1271, 'Norishige Chiba');
INSERT INTO "Author" VALUES (1272, 'Kazunori Onoguchi');
INSERT INTO "Author" VALUES (1273, 'Takao Nishizeki');
INSERT INTO "Author" VALUES (1274, 'Peter Habermehl');
INSERT INTO "Author" VALUES (1275, 'Radu Iosif');
INSERT INTO "Author" VALUES (1276, 'Tomás Vojnar');
INSERT INTO "Author" VALUES (1277, 'Hans Kleine Büning');
INSERT INTO "Author" VALUES (1278, 'Lutz Priese');
INSERT INTO "Author" VALUES (1279, 'Jeffrey H. Kingston');
INSERT INTO "Author" VALUES (1280, 'John V. Guttag');
INSERT INTO "Author" VALUES (1281, 'James J. Horning');
INSERT INTO "Author" VALUES (1282, 'Moshe Y. Vardi');
INSERT INTO "Author" VALUES (1283, 'Peter Kirschenhofer');
INSERT INTO "Author" VALUES (1284, 'Helmut Prodinger');
INSERT INTO "Author" VALUES (1285, 'Edward Y. C. Cheng');
INSERT INTO "Author" VALUES (1286, 'Dorit S. Hochbaum');
INSERT INTO "Author" VALUES (1287, 'Jean-Jacques Pansiot');
INSERT INTO "Author" VALUES (1288, 'Bin Zhang 0004');
INSERT INTO "Author" VALUES (1289, 'Meichun Hsu');
INSERT INTO "Author" VALUES (1290, 'John Aycock');
INSERT INTO "Author" VALUES (1291, 'R. Nigel Horspool');
INSERT INTO "Author" VALUES (1292, 'Stefan Sokolowski');
INSERT INTO "Author" VALUES (1293, 'Bogdan Rembowski');
INSERT INTO "Author" VALUES (1294, 'Howard Barringer');
INSERT INTO "Author" VALUES (1295, 'J. H. Cheng');
INSERT INTO "Author" VALUES (1296, 'Cliff B. Jones');
INSERT INTO "Author" VALUES (1297, 'Ángeles S. Places');
INSERT INTO "Author" VALUES (1298, 'José Félix Costa');
INSERT INTO "Author" VALUES (1299, 'Cristina Sernadas');
INSERT INTO "Author" VALUES (1300, 'Shou-Hsuan Stephen Huang');
INSERT INTO "Author" VALUES (1301, 'T. Anderson');
INSERT INTO "Author" VALUES (1302, 'Harald Søndergaard');
INSERT INTO "Author" VALUES (1303, 'Peter Sestoft');
INSERT INTO "Author" VALUES (1304, 'Robert Brijder');
INSERT INTO "Author" VALUES (1305, 'Eric Sanlaville');
INSERT INTO "Author" VALUES (1306, 'Günter Schmidt');
INSERT INTO "Author" VALUES (1307, 'Philippe Flajolet');
INSERT INTO "Author" VALUES (1308, 'Peter Roth');
INSERT INTO "Author" VALUES (1309, 'Iiro S. Honkala');
INSERT INTO "Author" VALUES (1310, 'Antoine Lobstein');
INSERT INTO "Author" VALUES (1311, 'Nir Tzachar');
INSERT INTO "Author" VALUES (1312, 'Ana Cavalcanti');
INSERT INTO "Author" VALUES (1313, 'Marie-Claude Gaudel');
INSERT INTO "Author" VALUES (1314, 'Leonard Berman');
INSERT INTO "Author" VALUES (1315, 'John L. Bruno');
INSERT INTO "Author" VALUES (1316, 'Nabil A. Khabbaz');
INSERT INTO "Author" VALUES (1317, 'Constantin Enea');
INSERT INTO "Author" VALUES (1318, 'Kenichi Taniguchi');
INSERT INTO "Author" VALUES (1319, 'Rodney R. Howell');
INSERT INTO "Author" VALUES (1320, 'Louis E. Rosier');
INSERT INTO "Author" VALUES (1321, 'Tomi Pasanen');
INSERT INTO "Author" VALUES (1322, 'Thomas Buchholz');
INSERT INTO "Author" VALUES (1323, 'J. Cantor');
INSERT INTO "Author" VALUES (1324, 'Anthony Ephremides');
INSERT INTO "Author" VALUES (1325, 'D. Horton');
INSERT INTO "Author" VALUES (1326, 'José Enrique Armendáriz-Iñigo');
INSERT INTO "Author" VALUES (1327, 'José Ramón González de Mendívil');
INSERT INTO "Author" VALUES (1328, 'José Ramón Garitagoitia');
INSERT INTO "Author" VALUES (1329, 'Francesc D. Muñoz-Escoí');
INSERT INTO "Author" VALUES (1330, 'Marisa Navarro');
INSERT INTO "Author" VALUES (1331, 'Fernando Orejas');
INSERT INTO "Author" VALUES (1332, 'Jean-Luc Remy');
INSERT INTO "Author" VALUES (1333, 'Sheila A. Greibach');
INSERT INTO "Author" VALUES (1334, 'Robert Stephens');
INSERT INTO "Author" VALUES (1335, 'Narao Nakatsu');
INSERT INTO "Author" VALUES (1336, 'Yahiko Kambayashi');
INSERT INTO "Author" VALUES (1337, 'Shuzo Yajima');
INSERT INTO "Author" VALUES (1338, 'Qiwen Xu');
INSERT INTO "Author" VALUES (1339, 'Michael Karr');
INSERT INTO "Author" VALUES (1340, 'Lane A. Hemaspaandra');
INSERT INTO "Author" VALUES (1341, 'Jörg Rothe');
INSERT INTO "Author" VALUES (1342, 'Gerd Wechsung');
INSERT INTO "Author" VALUES (1343, 'Donal T. MacVeigh');
INSERT INTO "Author" VALUES (1344, 'Christian Ferdinand');
INSERT INTO "Author" VALUES (1345, 'Giorgio Levi');
INSERT INTO "Author" VALUES (1346, 'Catuscia Palamidessi');
INSERT INTO "Author" VALUES (1347, 'Dung T. Huynh');
INSERT INTO "Author" VALUES (1348, 'Christos Levcopoulos');
INSERT INTO "Author" VALUES (1349, 'Johannes Köbler');
INSERT INTO "Author" VALUES (1350, 'Uwe Schöning');
INSERT INTO "Author" VALUES (1351, 'Allan G. Bromley');
INSERT INTO "Author" VALUES (1352, 'Jørgen Steensgaard-Madsen');
INSERT INTO "Author" VALUES (1353, 'Chi-Chung Hui');
INSERT INTO "Author" VALUES (1354, 'Samuel T. Chanson');
INSERT INTO "Author" VALUES (1355, 'Trevor I. Fenner');
INSERT INTO "Author" VALUES (1356, 'Rocco De Nicola');
INSERT INTO "Author" VALUES (1357, 'Ellis Horowitz');
INSERT INTO "Author" VALUES (1358, 'Guido Proietti');


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 191
-- Name: Author_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: kittn
--

SELECT pg_catalog.setval('"Author_ID_seq"', 1358, true);


--
-- TOC entry 2132 (class 0 OID 24913)
-- Dependencies: 179
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2133 (class 0 OID 24926)
-- Dependencies: 180
-- Data for Name: Conference; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2138 (class 0 OID 25016)
-- Dependencies: 185
-- Data for Name: Incollection; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2139 (class 0 OID 25029)
-- Dependencies: 186
-- Data for Name: Inproceedings; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2134 (class 0 OID 24934)
-- Dependencies: 181
-- Data for Name: InstAuthPub; Type: TABLE DATA; Schema: public; Owner: kittn
--

INSERT INTO "InstAuthPub" VALUES (1, NULL, 'Sanjeev Saxena');
INSERT INTO "InstAuthPub" VALUES (2, NULL, 'Robin Milner');
INSERT INTO "InstAuthPub" VALUES (3, NULL, 'John K. Lee');
INSERT INTO "InstAuthPub" VALUES (3, NULL, 'Alan Fekete');
INSERT INTO "InstAuthPub" VALUES (4, NULL, 'Akhil Kumar 0001');
INSERT INTO "InstAuthPub" VALUES (4, NULL, 'Kavindra Malik');
INSERT INTO "InstAuthPub" VALUES (5, NULL, 'Jörg Desel');
INSERT INTO "InstAuthPub" VALUES (5, NULL, 'Wolfgang Reisig');
INSERT INTO "InstAuthPub" VALUES (6, NULL, 'Mikkel Thorup');
INSERT INTO "InstAuthPub" VALUES (7, NULL, 'Robert H. Sloan');
INSERT INTO "InstAuthPub" VALUES (7, NULL, 'Ugo A. Buy');
INSERT INTO "InstAuthPub" VALUES (8, NULL, 'Josep Díaz');
INSERT INTO "InstAuthPub" VALUES (8, NULL, 'Maria J. Serna');
INSERT INTO "InstAuthPub" VALUES (8, NULL, 'Jacobo Torán');
INSERT INTO "InstAuthPub" VALUES (9, NULL, 'Gadi Taubenfeld');
INSERT INTO "InstAuthPub" VALUES (9, NULL, 'Shlomo Moran');
INSERT INTO "InstAuthPub" VALUES (10, NULL, 'Neal A. Harman');
INSERT INTO "InstAuthPub" VALUES (10, NULL, 'J. V. Tucker');
INSERT INTO "InstAuthPub" VALUES (11, NULL, 'Sibsankar Haldar');
INSERT INTO "InstAuthPub" VALUES (11, NULL, 'K. Vidyasankar');
INSERT INTO "InstAuthPub" VALUES (12, NULL, 'Andrea Maggiolo-Schettini');
INSERT INTO "InstAuthPub" VALUES (12, NULL, 'Józef Winkowski');
INSERT INTO "InstAuthPub" VALUES (13, NULL, 'Otto Nurmi');
INSERT INTO "InstAuthPub" VALUES (13, NULL, 'Eljas Soisalon-Soininen');
INSERT INTO "InstAuthPub" VALUES (14, NULL, 'Vladimir G. Deineko');
INSERT INTO "InstAuthPub" VALUES (14, NULL, 'Rüdiger Rudolf');
INSERT INTO "InstAuthPub" VALUES (14, NULL, 'Gerhard J. Woeginger');
INSERT INTO "InstAuthPub" VALUES (15, NULL, 'Gunnar Stålmarck');
INSERT INTO "InstAuthPub" VALUES (16, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (17, NULL, 'Stephan Heilbrunner');
INSERT INTO "InstAuthPub" VALUES (18, NULL, 'Pierpaolo Degano');
INSERT INTO "InstAuthPub" VALUES (18, NULL, 'José Meseguer');
INSERT INTO "InstAuthPub" VALUES (18, NULL, 'Ugo Montanari');
INSERT INTO "InstAuthPub" VALUES (19, NULL, 'Andrzej Biela');
INSERT INTO "InstAuthPub" VALUES (19, NULL, 'Jakub Borowczyk');
INSERT INTO "InstAuthPub" VALUES (20, NULL, 'Petr Jancar');
INSERT INTO "InstAuthPub" VALUES (20, NULL, 'Frantisek Mráz');
INSERT INTO "InstAuthPub" VALUES (20, NULL, 'Martin Plátek');
INSERT INTO "InstAuthPub" VALUES (21, NULL, 'Foued Ameur');
INSERT INTO "InstAuthPub" VALUES (21, NULL, 'Paul Fischer');
INSERT INTO "InstAuthPub" VALUES (21, NULL, 'Klaus-Uwe Höffgen');
INSERT INTO "InstAuthPub" VALUES (21, NULL, 'Friedhelm Meyer auf der Heide');
INSERT INTO "InstAuthPub" VALUES (22, NULL, 'Patrick E. O''Neil');
INSERT INTO "InstAuthPub" VALUES (22, NULL, 'Edward Cheng');
INSERT INTO "InstAuthPub" VALUES (22, NULL, 'Dieter Gawlick');
INSERT INTO "InstAuthPub" VALUES (22, NULL, 'Elizabeth J. O''Neil');
INSERT INTO "InstAuthPub" VALUES (23, NULL, 'Alexander Tuzhilin');
INSERT INTO "InstAuthPub" VALUES (23, NULL, 'Zvi M. Kedem');
INSERT INTO "InstAuthPub" VALUES (24, NULL, 'M. R. K. Krishna Rao');
INSERT INTO "InstAuthPub" VALUES (25, NULL, 'Thomas W. Reps');
INSERT INTO "InstAuthPub" VALUES (26, NULL, 'Dominic Duggan');
INSERT INTO "InstAuthPub" VALUES (26, NULL, 'Gordon V. Cormack');
INSERT INTO "InstAuthPub" VALUES (26, NULL, 'John Ophel');
INSERT INTO "InstAuthPub" VALUES (27, NULL, 'Géraud Sénizergues');
INSERT INTO "InstAuthPub" VALUES (28, NULL, 'Luca Aceto');
INSERT INTO "InstAuthPub" VALUES (28, NULL, 'David Murphy');
INSERT INTO "InstAuthPub" VALUES (29, NULL, 'Hans-Ulrich Simon');
INSERT INTO "InstAuthPub" VALUES (30, NULL, 'Nathan Goodman');
INSERT INTO "InstAuthPub" VALUES (30, NULL, 'Oded Shmueli');
INSERT INTO "InstAuthPub" VALUES (31, NULL, 'Christian Ronse');
INSERT INTO "InstAuthPub" VALUES (32, NULL, 'G. Marque-Pucheu');
INSERT INTO "InstAuthPub" VALUES (33, NULL, 'Aviezri S. Fraenkel');
INSERT INTO "InstAuthPub" VALUES (33, NULL, 'Moshe Mor');
INSERT INTO "InstAuthPub" VALUES (33, NULL, 'Yehoshua Perl');
INSERT INTO "InstAuthPub" VALUES (34, NULL, 'Hisao Kameda');
INSERT INTO "InstAuthPub" VALUES (35, NULL, 'Martin Wirsing');
INSERT INTO "InstAuthPub" VALUES (35, NULL, 'Peter Pepper');
INSERT INTO "InstAuthPub" VALUES (35, NULL, 'Helmuth Partsch');
INSERT INTO "InstAuthPub" VALUES (35, NULL, 'Walter Dosch');
INSERT INTO "InstAuthPub" VALUES (36, NULL, 'Joseph A. Bannister');
INSERT INTO "InstAuthPub" VALUES (36, NULL, 'Kishor S. Trivedi');
INSERT INTO "InstAuthPub" VALUES (37, NULL, 'Alain J. Martin');
INSERT INTO "InstAuthPub" VALUES (38, NULL, 'Jifeng He');
INSERT INTO "InstAuthPub" VALUES (39, NULL, 'Werner Damm');
INSERT INTO "InstAuthPub" VALUES (39, NULL, 'Bernhard Josko');
INSERT INTO "InstAuthPub" VALUES (40, NULL, 'Walter Bucher');
INSERT INTO "InstAuthPub" VALUES (41, NULL, 'Mario Coppo');
INSERT INTO "InstAuthPub" VALUES (42, NULL, 'Werner Pohlmann');
INSERT INTO "InstAuthPub" VALUES (43, NULL, 'Nissim Francez');
INSERT INTO "InstAuthPub" VALUES (44, NULL, 'Heikki Mannila');
INSERT INTO "InstAuthPub" VALUES (44, NULL, 'Kari-Jouko Räihä');
INSERT INTO "InstAuthPub" VALUES (45, NULL, 'Mordechai Ben-Ari');
INSERT INTO "InstAuthPub" VALUES (45, NULL, 'Amir Pnueli');
INSERT INTO "InstAuthPub" VALUES (45, NULL, 'Zohar Manna');
INSERT INTO "InstAuthPub" VALUES (46, NULL, 'Jean-Jacques Pansiot');
INSERT INTO "InstAuthPub" VALUES (47, NULL, 'Philippe Flajolet');
INSERT INTO "InstAuthPub" VALUES (48, NULL, 'Norbert Blum');
INSERT INTO "InstAuthPub" VALUES (49, NULL, 'Paul Pritchard');
INSERT INTO "InstAuthPub" VALUES (50, NULL, 'Peter R. J. Asveld');
INSERT INTO "InstAuthPub" VALUES (50, NULL, 'J. V. Tucker');
INSERT INTO "InstAuthPub" VALUES (51, NULL, 'François Baccelli');
INSERT INTO "InstAuthPub" VALUES (51, NULL, 'Thierry Fleury');
INSERT INTO "InstAuthPub" VALUES (52, NULL, 'Alan J. Demers');
INSERT INTO "InstAuthPub" VALUES (52, NULL, 'C. Keleman');
INSERT INTO "InstAuthPub" VALUES (52, NULL, 'Bernd Reusch');
INSERT INTO "InstAuthPub" VALUES (53, NULL, 'Flaviu Cristian');
INSERT INTO "InstAuthPub" VALUES (54, NULL, 'Jean-Michel Autebert');
INSERT INTO "InstAuthPub" VALUES (54, NULL, 'Joffroy Beauquier');
INSERT INTO "InstAuthPub" VALUES (54, NULL, 'Luc Boasson');
INSERT INTO "InstAuthPub" VALUES (55, NULL, 'John E. Shore');
INSERT INTO "InstAuthPub" VALUES (56, NULL, 'Tamás Gergely');
INSERT INTO "InstAuthPub" VALUES (56, NULL, 'László Úry');
INSERT INTO "InstAuthPub" VALUES (57, NULL, 'Mark H. Overmars');
INSERT INTO "InstAuthPub" VALUES (57, NULL, 'Jan van Leeuwen');
INSERT INTO "InstAuthPub" VALUES (58, NULL, 'C. L. Liu');
INSERT INTO "InstAuthPub" VALUES (58, NULL, 'Jane W.-S. Liu');
INSERT INTO "InstAuthPub" VALUES (58, NULL, 'Arthur L. Liestman');
INSERT INTO "InstAuthPub" VALUES (59, NULL, 'Ernst-Erich Doberkat');
INSERT INTO "InstAuthPub" VALUES (60, NULL, 'Sridhar Vasudevan');
INSERT INTO "InstAuthPub" VALUES (61, NULL, 'Satoru Miyano');
INSERT INTO "InstAuthPub" VALUES (62, NULL, 'Lawrence Snyder');
INSERT INTO "InstAuthPub" VALUES (63, NULL, 'Kari-Jouko Räihä');
INSERT INTO "InstAuthPub" VALUES (63, NULL, 'Mikko Saarinen');
INSERT INTO "InstAuthPub" VALUES (64, NULL, 'Alon Itai');
INSERT INTO "InstAuthPub" VALUES (64, NULL, 'Michael Rodeh');
INSERT INTO "InstAuthPub" VALUES (65, NULL, 'Clement H. C. Leung');
INSERT INTO "InstAuthPub" VALUES (65, NULL, 'Qui Hoon Choo');
INSERT INTO "InstAuthPub" VALUES (66, NULL, 'Joseph JáJá');
INSERT INTO "InstAuthPub" VALUES (66, NULL, 'Janos Simon');
INSERT INTO "InstAuthPub" VALUES (67, NULL, 'Arnold Schönhage');
INSERT INTO "InstAuthPub" VALUES (68, NULL, 'Jacques Labetoulle');
INSERT INTO "InstAuthPub" VALUES (68, NULL, 'Guy Pujolle');
INSERT INTO "InstAuthPub" VALUES (69, NULL, 'Donald P. Gaver');
INSERT INTO "InstAuthPub" VALUES (69, NULL, 'George Humfeld');
INSERT INTO "InstAuthPub" VALUES (70, NULL, 'Peter J. Denning');
INSERT INTO "InstAuthPub" VALUES (70, NULL, 'Kevin C. Kahn');
INSERT INTO "InstAuthPub" VALUES (70, NULL, 'Jacques Leroudier');
INSERT INTO "InstAuthPub" VALUES (70, NULL, 'Dominique Potier');
INSERT INTO "InstAuthPub" VALUES (70, NULL, 'Rajan Suri');
INSERT INTO "InstAuthPub" VALUES (71, NULL, 'John B. Kam');
INSERT INTO "InstAuthPub" VALUES (71, NULL, 'Jeffrey D. Ullman');
INSERT INTO "InstAuthPub" VALUES (72, NULL, 'Thomas Giammo');
INSERT INTO "InstAuthPub" VALUES (73, NULL, 'Jean-François Perrot');
INSERT INTO "InstAuthPub" VALUES (74, NULL, 'Robert E. Shostak');
INSERT INTO "InstAuthPub" VALUES (75, NULL, 'Leslie Lamport');
INSERT INTO "InstAuthPub" VALUES (76, NULL, 'Tomasz Kowaltowski');
INSERT INTO "InstAuthPub" VALUES (77, NULL, 'David Pager');
INSERT INTO "InstAuthPub" VALUES (78, NULL, 'Claus-Peter Schnorr');
INSERT INTO "InstAuthPub" VALUES (79, NULL, 'Peter E. Lauer');
INSERT INTO "InstAuthPub" VALUES (79, NULL, 'Roy H. Campbell');
INSERT INTO "InstAuthPub" VALUES (80, NULL, 'Peter D. Welch');
INSERT INTO "InstAuthPub" VALUES (81, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (81, NULL, 'Richard R. Muntz');
INSERT INTO "InstAuthPub" VALUES (82, NULL, 'Ole Lehrmann Madsen');
INSERT INTO "InstAuthPub" VALUES (82, NULL, 'Bent Bruun Kristensen');
INSERT INTO "InstAuthPub" VALUES (83, NULL, 'R. Zuczek');
INSERT INTO "InstAuthPub" VALUES (84, NULL, 'Hermann K.-G. Walter');
INSERT INTO "InstAuthPub" VALUES (85, NULL, 'Carl E. Landwehr');
INSERT INTO "InstAuthPub" VALUES (86, NULL, 'Donal T. MacVeigh');
INSERT INTO "InstAuthPub" VALUES (87, NULL, 'Juha Honkala');
INSERT INTO "InstAuthPub" VALUES (88, NULL, 'Tien Van Do');
INSERT INTO "InstAuthPub" VALUES (88, NULL, 'Ram Chakka');
INSERT INTO "InstAuthPub" VALUES (88, NULL, 'Nam H. Do');
INSERT INTO "InstAuthPub" VALUES (88, NULL, 'László Pap');
INSERT INTO "InstAuthPub" VALUES (89, NULL, 'Zheng-Zhu Li');
INSERT INTO "InstAuthPub" VALUES (89, NULL, 'Y. S. Tsai');
INSERT INTO "InstAuthPub" VALUES (90, NULL, 'Frank Drewes');
INSERT INTO "InstAuthPub" VALUES (90, NULL, 'Johanna Högberg');
INSERT INTO "InstAuthPub" VALUES (90, NULL, 'Andreas Maletti');
INSERT INTO "InstAuthPub" VALUES (91, NULL, 'Amit Chakrabarti');
INSERT INTO "InstAuthPub" VALUES (91, NULL, 'Venkatesan Guruswami');
INSERT INTO "InstAuthPub" VALUES (91, NULL, 'Andrew Wirth');
INSERT INTO "InstAuthPub" VALUES (91, NULL, 'Anthony Wirth');
INSERT INTO "InstAuthPub" VALUES (92, NULL, 'Md. Enamul Kabir');
INSERT INTO "InstAuthPub" VALUES (92, NULL, 'Hua Wang');
INSERT INTO "InstAuthPub" VALUES (92, NULL, 'Elisa Bertino');
INSERT INTO "InstAuthPub" VALUES (93, NULL, 'Juan Ignacio Perna');
INSERT INTO "InstAuthPub" VALUES (93, NULL, 'Jim Woodcock');
INSERT INTO "InstAuthPub" VALUES (93, NULL, 'Augusto Sampaio');
INSERT INTO "InstAuthPub" VALUES (93, NULL, 'Juliano Iyoda');
INSERT INTO "InstAuthPub" VALUES (94, NULL, 'Victor Mitrana');
INSERT INTO "InstAuthPub" VALUES (94, NULL, 'Cristina Tîrnauca');
INSERT INTO "InstAuthPub" VALUES (95, NULL, 'Artem Polyvyanyy');
INSERT INTO "InstAuthPub" VALUES (95, NULL, 'Matthias Weidlich');
INSERT INTO "InstAuthPub" VALUES (95, NULL, 'Mathias Weske');
INSERT INTO "InstAuthPub" VALUES (96, NULL, 'Daowen Qiu');
INSERT INTO "InstAuthPub" VALUES (96, NULL, 'Lvzhou Li');
INSERT INTO "InstAuthPub" VALUES (96, NULL, 'Xiangfu Zou');
INSERT INTO "InstAuthPub" VALUES (96, NULL, 'Paulo Mateus');
INSERT INTO "InstAuthPub" VALUES (96, NULL, 'Jozef Gruska');
INSERT INTO "InstAuthPub" VALUES (97, NULL, 'Francine Blanchet-Sadri');
INSERT INTO "InstAuthPub" VALUES (97, NULL, 'Robert Mercas');
INSERT INTO "InstAuthPub" VALUES (97, NULL, 'Sean Simmons');
INSERT INTO "InstAuthPub" VALUES (97, NULL, 'Eric Weissenstein');
INSERT INTO "InstAuthPub" VALUES (98, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (98, NULL, 'Petr Zemek');
INSERT INTO "InstAuthPub" VALUES (99, NULL, 'Pál Dömösi');
INSERT INTO "InstAuthPub" VALUES (99, NULL, 'György Maróti');
INSERT INTO "InstAuthPub" VALUES (100, NULL, 'Ana Cavalcanti');
INSERT INTO "InstAuthPub" VALUES (100, NULL, 'Marie-Claude Gaudel');
INSERT INTO "InstAuthPub" VALUES (101, NULL, 'Chua-Huang Huang');
INSERT INTO "InstAuthPub" VALUES (101, NULL, 'Christian Lengauer');
INSERT INTO "InstAuthPub" VALUES (102, NULL, 'Luc Devroye');
INSERT INTO "InstAuthPub" VALUES (103, NULL, 'Patrick Cousot');
INSERT INTO "InstAuthPub" VALUES (103, NULL, 'Radhia Cousot');
INSERT INTO "InstAuthPub" VALUES (104, NULL, 'Shyamal K. Chowdhury');
INSERT INTO "InstAuthPub" VALUES (104, NULL, 'Pradip K. Srimani');
INSERT INTO "InstAuthPub" VALUES (105, NULL, 'Stephan Heilbrunner');
INSERT INTO "InstAuthPub" VALUES (105, NULL, 'Steffen Hölldobler');
INSERT INTO "InstAuthPub" VALUES (106, NULL, 'Thomas P. Murtagh');
INSERT INTO "InstAuthPub" VALUES (107, NULL, 'Andrzej Duda');
INSERT INTO "InstAuthPub" VALUES (107, NULL, 'Tadeusz Czachórski');
INSERT INTO "InstAuthPub" VALUES (108, NULL, 'S. Kiran Kumar');
INSERT INTO "InstAuthPub" VALUES (108, NULL, 'C. Pandu Rangan');
INSERT INTO "InstAuthPub" VALUES (109, NULL, 'Oded Goldreich');
INSERT INTO "InstAuthPub" VALUES (109, NULL, 'Liuba Shrira');
INSERT INTO "InstAuthPub" VALUES (110, NULL, 'M. Kempf');
INSERT INTO "InstAuthPub" VALUES (110, NULL, 'Rudolf Bayer');
INSERT INTO "InstAuthPub" VALUES (110, NULL, 'Ulrich Güntzer');
INSERT INTO "InstAuthPub" VALUES (111, NULL, 'J. W. de Bakker');
INSERT INTO "InstAuthPub" VALUES (111, NULL, 'John-Jules Ch. Meyer');
INSERT INTO "InstAuthPub" VALUES (112, NULL, 'Clement H. C. Leung');
INSERT INTO "InstAuthPub" VALUES (113, NULL, 'Edward A. Bender');
INSERT INTO "InstAuthPub" VALUES (113, NULL, 'Cheryl E. Praeger');
INSERT INTO "InstAuthPub" VALUES (113, NULL, 'Nicholas C. Wormald');
INSERT INTO "InstAuthPub" VALUES (114, NULL, 'Marek J. Lao');
INSERT INTO "InstAuthPub" VALUES (115, NULL, 'Ali Mili');
INSERT INTO "InstAuthPub" VALUES (115, NULL, 'Jules Desharnais');
INSERT INTO "InstAuthPub" VALUES (115, NULL, 'Fatma Mili');
INSERT INTO "InstAuthPub" VALUES (116, NULL, 'Ryszard Janicki');
INSERT INTO "InstAuthPub" VALUES (117, NULL, 'Susan Horwitz');
INSERT INTO "InstAuthPub" VALUES (117, NULL, 'Alan J. Demers');
INSERT INTO "InstAuthPub" VALUES (117, NULL, 'Tim Teitelbaum');
INSERT INTO "InstAuthPub" VALUES (118, NULL, 'Bernd Becker');
INSERT INTO "InstAuthPub" VALUES (119, NULL, 'Wojciech Szpankowski');
INSERT INTO "InstAuthPub" VALUES (120, NULL, 'Lawrence A. Harris');
INSERT INTO "InstAuthPub" VALUES (121, NULL, 'K. Vidyasankar');
INSERT INTO "InstAuthPub" VALUES (122, NULL, 'Joseph G. Peters');
INSERT INTO "InstAuthPub" VALUES (122, NULL, 'Larry Rudolph');
INSERT INTO "InstAuthPub" VALUES (123, NULL, 'Deepak Kapur');
INSERT INTO "InstAuthPub" VALUES (123, NULL, 'Paliath Narendran');
INSERT INTO "InstAuthPub" VALUES (123, NULL, 'Hantao Zhang');
INSERT INTO "InstAuthPub" VALUES (124, NULL, 'Masato Takeichi');
INSERT INTO "InstAuthPub" VALUES (125, NULL, 'Bernard Chazelle');
INSERT INTO "InstAuthPub" VALUES (126, NULL, 'Alain Finkel');
INSERT INTO "InstAuthPub" VALUES (126, NULL, 'Annie Choquet');
INSERT INTO "InstAuthPub" VALUES (127, NULL, 'William P. R. Mitchell');
INSERT INTO "InstAuthPub" VALUES (128, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (128, NULL, 'Hendrik Jan Hoogeboom');
INSERT INTO "InstAuthPub" VALUES (128, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (129, NULL, 'Ann E. Kelley Sobel');
INSERT INTO "InstAuthPub" VALUES (129, NULL, 'Neelam Soundararajan');
INSERT INTO "InstAuthPub" VALUES (130, NULL, 'Mahadevan Ganapathi');
INSERT INTO "InstAuthPub" VALUES (130, NULL, 'Charles N. Fischer');
INSERT INTO "InstAuthPub" VALUES (131, NULL, 'Donald Sannella');
INSERT INTO "InstAuthPub" VALUES (131, NULL, 'Andrzej Tarlecki');
INSERT INTO "InstAuthPub" VALUES (132, NULL, 'Friedrich L. Bauer');
INSERT INTO "InstAuthPub" VALUES (132, NULL, 'Martin Wirsing');
INSERT INTO "InstAuthPub" VALUES (133, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (133, NULL, 'George Leih');
INSERT INTO "InstAuthPub" VALUES (133, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (134, NULL, 'José Luiz Fiadeiro');
INSERT INTO "InstAuthPub" VALUES (134, NULL, 'Amílcar Sernadas');
INSERT INTO "InstAuthPub" VALUES (135, NULL, 'Sheldon Shen');
INSERT INTO "InstAuthPub" VALUES (136, NULL, 'John H. Reif');
INSERT INTO "InstAuthPub" VALUES (136, NULL, 'Scott A. Smolka');
INSERT INTO "InstAuthPub" VALUES (137, NULL, 'Ralph-Johan Back');
INSERT INTO "InstAuthPub" VALUES (138, NULL, 'Ulf R. Schmerl');
INSERT INTO "InstAuthPub" VALUES (139, NULL, 'Thomas W. Reps');
INSERT INTO "InstAuthPub" VALUES (140, NULL, 'Edward P. F. Chan');
INSERT INTO "InstAuthPub" VALUES (140, NULL, 'Héctor J. Hernández');
INSERT INTO "InstAuthPub" VALUES (141, NULL, 'Pavel Pudlák');
INSERT INTO "InstAuthPub" VALUES (141, NULL, 'Vojtech Rödl');
INSERT INTO "InstAuthPub" VALUES (141, NULL, 'Petr Savický');
INSERT INTO "InstAuthPub" VALUES (142, NULL, 'Athanasios K. Tsakalidis');
INSERT INTO "InstAuthPub" VALUES (143, NULL, 'Paliath Narendran');
INSERT INTO "InstAuthPub" VALUES (143, NULL, 'Friedrich Otto');
INSERT INTO "InstAuthPub" VALUES (144, NULL, 'Giorgio Levi');
INSERT INTO "InstAuthPub" VALUES (144, NULL, 'Catuscia Palamidessi');
INSERT INTO "InstAuthPub" VALUES (145, NULL, 'Joachim Biskup');
INSERT INTO "InstAuthPub" VALUES (146, NULL, 'Eric C. R. Hehner');
INSERT INTO "InstAuthPub" VALUES (147, NULL, 'Teuvo Laurinolli');
INSERT INTO "InstAuthPub" VALUES (148, NULL, 'B. Bartsch');
INSERT INTO "InstAuthPub" VALUES (148, NULL, 'Gunter Bolch');
INSERT INTO "InstAuthPub" VALUES (149, NULL, 'Wayne A. Babich');
INSERT INTO "InstAuthPub" VALUES (149, NULL, 'Mehdi Jazayeri');
INSERT INTO "InstAuthPub" VALUES (150, NULL, 'Robert Meersman');
INSERT INTO "InstAuthPub" VALUES (150, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (151, NULL, 'Reinhold Franck');
INSERT INTO "InstAuthPub" VALUES (152, NULL, 'Peter J. L. Wallis');
INSERT INTO "InstAuthPub" VALUES (153, NULL, 'Carlton J. Maxson');
INSERT INTO "InstAuthPub" VALUES (154, NULL, 'Carlo Montangero');
INSERT INTO "InstAuthPub" VALUES (154, NULL, 'Giuliano Pacini');
INSERT INTO "InstAuthPub" VALUES (154, NULL, 'Maria Simi');
INSERT INTO "InstAuthPub" VALUES (154, NULL, 'Franco Turini');
INSERT INTO "InstAuthPub" VALUES (155, NULL, 'Lutz Eichner');
INSERT INTO "InstAuthPub" VALUES (156, NULL, 'Augusto Celentano');
INSERT INTO "InstAuthPub" VALUES (157, NULL, 'Lutz Eichner');
INSERT INTO "InstAuthPub" VALUES (158, NULL, 'Detlef Wotschke');
INSERT INTO "InstAuthPub" VALUES (158, NULL, 'Celia Wrathall');
INSERT INTO "InstAuthPub" VALUES (159, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (160, NULL, 'John V. Guttag');
INSERT INTO "InstAuthPub" VALUES (160, NULL, 'James J. Horning');
INSERT INTO "InstAuthPub" VALUES (161, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (161, NULL, 'Zoltán Fülöp 0001');
INSERT INTO "InstAuthPub" VALUES (161, NULL, 'George Rahonis');
INSERT INTO "InstAuthPub" VALUES (162, NULL, 'Jan A. Bergstra');
INSERT INTO "InstAuthPub" VALUES (162, NULL, 'C. A. Middelburg');
INSERT INTO "InstAuthPub" VALUES (163, NULL, 'Michael Brand');
INSERT INTO "InstAuthPub" VALUES (164, NULL, 'Antonella Santone');
INSERT INTO "InstAuthPub" VALUES (164, NULL, 'Gigliola Vaglini');
INSERT INTO "InstAuthPub" VALUES (165, NULL, 'Pascal Caron');
INSERT INTO "InstAuthPub" VALUES (165, NULL, 'Jean-Marc Champarnaud');
INSERT INTO "InstAuthPub" VALUES (165, NULL, 'Ludovic Mignot');
INSERT INTO "InstAuthPub" VALUES (166, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (166, NULL, 'Dariusz Dereniowski');
INSERT INTO "InstAuthPub" VALUES (166, NULL, 'Wieslaw Kubiak');
INSERT INTO "InstAuthPub" VALUES (167, NULL, 'Aivars Lorencs');
INSERT INTO "InstAuthPub" VALUES (168, NULL, 'Petr A. Golovach');
INSERT INTO "InstAuthPub" VALUES (168, NULL, 'Bernard Lidický');
INSERT INTO "InstAuthPub" VALUES (168, NULL, 'Barnaby Martin');
INSERT INTO "InstAuthPub" VALUES (168, NULL, 'Daniël Paulusma');
INSERT INTO "InstAuthPub" VALUES (169, NULL, 'Christian Choffrut');
INSERT INTO "InstAuthPub" VALUES (169, NULL, 'Andreas Malcher');
INSERT INTO "InstAuthPub" VALUES (169, NULL, 'Carlo Mereghetti');
INSERT INTO "InstAuthPub" VALUES (169, NULL, 'Beatrice Palano');
INSERT INTO "InstAuthPub" VALUES (170, NULL, 'Christel Baier');
INSERT INTO "InstAuthPub" VALUES (170, NULL, 'Tomás Brázdil');
INSERT INTO "InstAuthPub" VALUES (170, NULL, 'Marcus Größer');
INSERT INTO "InstAuthPub" VALUES (170, NULL, 'Antonín Kucera');
INSERT INTO "InstAuthPub" VALUES (171, NULL, 'Yunhe Wang');
INSERT INTO "InstAuthPub" VALUES (171, NULL, 'Li Jiao');
INSERT INTO "InstAuthPub" VALUES (172, NULL, 'Bastian Katz');
INSERT INTO "InstAuthPub" VALUES (172, NULL, 'Ignaz Rutter');
INSERT INTO "InstAuthPub" VALUES (172, NULL, 'Gerhard J. Woeginger');
INSERT INTO "InstAuthPub" VALUES (173, NULL, 'Cristian Ioan Vasile');
INSERT INTO "InstAuthPub" VALUES (173, NULL, 'Ana Brândusa Pavel');
INSERT INTO "InstAuthPub" VALUES (173, NULL, 'Ioan Dumitrache');
INSERT INTO "InstAuthPub" VALUES (173, NULL, 'Gheorghe Paun');
INSERT INTO "InstAuthPub" VALUES (174, NULL, 'Francine Blanchet-Sadri');
INSERT INTO "InstAuthPub" VALUES (174, NULL, 'Robert Mercas');
INSERT INTO "InstAuthPub" VALUES (174, NULL, 'Sean Simmons');
INSERT INTO "InstAuthPub" VALUES (174, NULL, 'Eric Weissenstein');
INSERT INTO "InstAuthPub" VALUES (175, NULL, 'Chen-Ming Fan');
INSERT INTO "InstAuthPub" VALUES (175, NULL, 'Cheng-Chih Huang');
INSERT INTO "InstAuthPub" VALUES (175, NULL, 'Christine Chifen Tseng');
INSERT INTO "InstAuthPub" VALUES (175, NULL, 'Jen-Tse Wang');
INSERT INTO "InstAuthPub" VALUES (176, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (176, NULL, 'Petr Zemek');
INSERT INTO "InstAuthPub" VALUES (177, NULL, 'Victor Khomenko');
INSERT INTO "InstAuthPub" VALUES (177, NULL, 'Alex Kondratyev');
INSERT INTO "InstAuthPub" VALUES (177, NULL, 'Maciej Koutny');
INSERT INTO "InstAuthPub" VALUES (177, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (178, NULL, 'Linqiang Pan');
INSERT INTO "InstAuthPub" VALUES (178, NULL, 'Artiom Alhazov');
INSERT INTO "InstAuthPub" VALUES (179, NULL, 'Stavros Konstantinidis');
INSERT INTO "InstAuthPub" VALUES (179, NULL, 'Nicolae Santean');
INSERT INTO "InstAuthPub" VALUES (179, NULL, 'Sheng Yu');
INSERT INTO "InstAuthPub" VALUES (180, NULL, 'Yuxi Fu');
INSERT INTO "InstAuthPub" VALUES (181, NULL, 'José M. Amigó');
INSERT INTO "InstAuthPub" VALUES (182, NULL, 'Arnaud Carayol');
INSERT INTO "InstAuthPub" VALUES (182, NULL, 'Antoine Meyer');
INSERT INTO "InstAuthPub" VALUES (183, NULL, 'Henning Bordihn');
INSERT INTO "InstAuthPub" VALUES (183, NULL, 'Markus Holzer');
INSERT INTO "InstAuthPub" VALUES (184, NULL, 'Jürgen Dingel');
INSERT INTO "InstAuthPub" VALUES (185, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (186, NULL, 'James D. Currie');
INSERT INTO "InstAuthPub" VALUES (186, NULL, 'Terry I. Visentin');
INSERT INTO "InstAuthPub" VALUES (187, NULL, 'Paulo Tabuada');
INSERT INTO "InstAuthPub" VALUES (188, NULL, 'Tero Harju');
INSERT INTO "InstAuthPub" VALUES (188, NULL, 'Dirk Nowotka');
INSERT INTO "InstAuthPub" VALUES (189, NULL, 'Amrinder Arora');
INSERT INTO "InstAuthPub" VALUES (189, NULL, 'Fanchun Jin');
INSERT INTO "InstAuthPub" VALUES (189, NULL, 'Gokhan Sahin');
INSERT INTO "InstAuthPub" VALUES (189, NULL, 'Hosam Mahmoud');
INSERT INTO "InstAuthPub" VALUES (189, NULL, 'Hyeong-Ah Choi');
INSERT INTO "InstAuthPub" VALUES (190, NULL, 'Klaus Indermark');
INSERT INTO "InstAuthPub" VALUES (190, NULL, 'Thomas Noll');
INSERT INTO "InstAuthPub" VALUES (191, NULL, 'Rafik Aguech');
INSERT INTO "InstAuthPub" VALUES (191, NULL, 'Nabil Lasmar');
INSERT INTO "InstAuthPub" VALUES (191, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (192, NULL, 'Eugene Asarin');
INSERT INTO "InstAuthPub" VALUES (192, NULL, 'Thao Dang');
INSERT INTO "InstAuthPub" VALUES (192, NULL, 'Antoine Girard');
INSERT INTO "InstAuthPub" VALUES (193, NULL, 'Wim Janssen');
INSERT INTO "InstAuthPub" VALUES (193, NULL, 'Alexandr Korlyukov');
INSERT INTO "InstAuthPub" VALUES (193, NULL, 'Jan Van den Bussche');
INSERT INTO "InstAuthPub" VALUES (194, NULL, 'Flavio Corradini');
INSERT INTO "InstAuthPub" VALUES (194, NULL, 'Maria Rita Di Berardini');
INSERT INTO "InstAuthPub" VALUES (194, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (195, NULL, 'José R. Paramá');
INSERT INTO "InstAuthPub" VALUES (195, NULL, 'Nieves R. Brisaboa');
INSERT INTO "InstAuthPub" VALUES (195, NULL, 'Miguel R. Penabad');
INSERT INTO "InstAuthPub" VALUES (195, NULL, 'Ángeles S. Places');
INSERT INTO "InstAuthPub" VALUES (196, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (197, NULL, 'Benedek Nagy');
INSERT INTO "InstAuthPub" VALUES (197, NULL, 'Friedrich Otto');
INSERT INTO "InstAuthPub" VALUES (198, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (199, NULL, 'Lorenzo Bettini');
INSERT INTO "InstAuthPub" VALUES (199, NULL, 'Ferruccio Damiani');
INSERT INTO "InstAuthPub" VALUES (199, NULL, 'Ina Schaefer');
INSERT INTO "InstAuthPub" VALUES (200, NULL, 'Vesa Halava');
INSERT INTO "InstAuthPub" VALUES (200, NULL, 'Tero Harju');
INSERT INTO "InstAuthPub" VALUES (201, NULL, 'Jetty Kleijn');
INSERT INTO "InstAuthPub" VALUES (201, NULL, 'Maciej Koutny');
INSERT INTO "InstAuthPub" VALUES (201, NULL, 'Marta Pietkiewicz-Koutny');
INSERT INTO "InstAuthPub" VALUES (201, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (202, NULL, 'Dongfeng Chen');
INSERT INTO "InstAuthPub" VALUES (202, NULL, 'Rada Chirkova');
INSERT INTO "InstAuthPub" VALUES (202, NULL, 'Fereidoon Sadri');
INSERT INTO "InstAuthPub" VALUES (202, NULL, 'Tiia J. Salo');
INSERT INTO "InstAuthPub" VALUES (203, NULL, 'Stefan Kahrs');
INSERT INTO "InstAuthPub" VALUES (204, NULL, 'Stefano Bilotta');
INSERT INTO "InstAuthPub" VALUES (204, NULL, 'Elisabetta Grazzini');
INSERT INTO "InstAuthPub" VALUES (204, NULL, 'Elisa Pergola');
INSERT INTO "InstAuthPub" VALUES (204, NULL, 'Renzo Pinzani');
INSERT INTO "InstAuthPub" VALUES (205, NULL, 'Amr Elmasry');
INSERT INTO "InstAuthPub" VALUES (205, NULL, 'Arash Farzan');
INSERT INTO "InstAuthPub" VALUES (205, NULL, 'John Iacono');
INSERT INTO "InstAuthPub" VALUES (206, NULL, 'Clelia De Felice');
INSERT INTO "InstAuthPub" VALUES (207, NULL, 'Jeongbong Seo');
INSERT INTO "InstAuthPub" VALUES (207, NULL, 'Sungwoo Park');
INSERT INTO "InstAuthPub" VALUES (208, NULL, 'Fernando Rosa-Velardo');
INSERT INTO "InstAuthPub" VALUES (209, NULL, 'Tamar Aizikowitz');
INSERT INTO "InstAuthPub" VALUES (209, NULL, 'Michael Kaminski');
INSERT INTO "InstAuthPub" VALUES (210, NULL, 'Fernando Arroyo');
INSERT INTO "InstAuthPub" VALUES (210, NULL, 'Juan Castellanos');
INSERT INTO "InstAuthPub" VALUES (210, NULL, 'Jürgen Dassow');
INSERT INTO "InstAuthPub" VALUES (210, NULL, 'Victor Mitrana');
INSERT INTO "InstAuthPub" VALUES (210, NULL, 'José-Ramón Sánchez-Couso');
INSERT INTO "InstAuthPub" VALUES (211, NULL, 'Carol Critchlow');
INSERT INTO "InstAuthPub" VALUES (211, NULL, 'Prakash Panangaden');
INSERT INTO "InstAuthPub" VALUES (212, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (212, NULL, 'Raymond R. Devillers');
INSERT INTO "InstAuthPub" VALUES (212, NULL, 'Astrid Kiehn');
INSERT INTO "InstAuthPub" VALUES (212, NULL, 'Lucia Pomello');
INSERT INTO "InstAuthPub" VALUES (213, NULL, 'Paul Pritchard');
INSERT INTO "InstAuthPub" VALUES (214, NULL, 'Werner Pohlmann');
INSERT INTO "InstAuthPub" VALUES (215, NULL, 'Thomas J. Marlowe');
INSERT INTO "InstAuthPub" VALUES (215, NULL, 'Barbara G. Ryder');
INSERT INTO "InstAuthPub" VALUES (216, NULL, 'Peter G. Harrison');
INSERT INTO "InstAuthPub" VALUES (217, NULL, 'Xiaolei Qian');
INSERT INTO "InstAuthPub" VALUES (218, NULL, 'Hessam Khoshnevisan');
INSERT INTO "InstAuthPub" VALUES (219, NULL, 'Susan Horwitz');
INSERT INTO "InstAuthPub" VALUES (219, NULL, 'Thomas W. Reps');
INSERT INTO "InstAuthPub" VALUES (220, NULL, 'Friedrich Otto');
INSERT INTO "InstAuthPub" VALUES (220, NULL, 'Louxin Zhang');
INSERT INTO "InstAuthPub" VALUES (221, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (222, NULL, 'Mark Levene');
INSERT INTO "InstAuthPub" VALUES (222, NULL, 'George Loizou');
INSERT INTO "InstAuthPub" VALUES (223, NULL, 'Uwe Kastens');
INSERT INTO "InstAuthPub" VALUES (223, NULL, 'William M. Waite');
INSERT INTO "InstAuthPub" VALUES (224, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (225, NULL, 'Arne Andersson');
INSERT INTO "InstAuthPub" VALUES (225, NULL, 'Christian Icking');
INSERT INTO "InstAuthPub" VALUES (225, NULL, 'Rolf Klein');
INSERT INTO "InstAuthPub" VALUES (225, NULL, 'Thomas Ottmann');
INSERT INTO "InstAuthPub" VALUES (226, NULL, 'Reiner Kolla');
INSERT INTO "InstAuthPub" VALUES (226, NULL, 'Bernd Serf');
INSERT INTO "InstAuthPub" VALUES (227, NULL, 'Jeremy Dick');
INSERT INTO "InstAuthPub" VALUES (227, NULL, 'John Kalmus');
INSERT INTO "InstAuthPub" VALUES (227, NULL, 'Ursula Martin');
INSERT INTO "InstAuthPub" VALUES (228, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (228, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (229, NULL, 'Paolo Atzeni');
INSERT INTO "InstAuthPub" VALUES (229, NULL, 'Edward P. F. Chan');
INSERT INTO "InstAuthPub" VALUES (230, NULL, 'Donald E. Knuth');
INSERT INTO "InstAuthPub" VALUES (231, NULL, 'Donald W. Gillies');
INSERT INTO "InstAuthPub" VALUES (231, NULL, 'Jane W.-S. Liu');
INSERT INTO "InstAuthPub" VALUES (232, NULL, 'James H. Anderson');
INSERT INTO "InstAuthPub" VALUES (232, NULL, 'Mohamed G. Gouda');
INSERT INTO "InstAuthPub" VALUES (233, NULL, 'José M. Bernabéu-Aubán');
INSERT INTO "InstAuthPub" VALUES (233, NULL, 'Mustaque Ahamad');
INSERT INTO "InstAuthPub" VALUES (233, NULL, 'Mostafa H. Ammar');
INSERT INTO "InstAuthPub" VALUES (234, NULL, 'Deepak Kapur');
INSERT INTO "InstAuthPub" VALUES (234, NULL, 'Paliath Narendran');
INSERT INTO "InstAuthPub" VALUES (234, NULL, 'Daniel J. Rosenkrantz');
INSERT INTO "InstAuthPub" VALUES (234, NULL, 'Hantao Zhang');
INSERT INTO "InstAuthPub" VALUES (235, NULL, 'Kamal Lodaya');
INSERT INTO "InstAuthPub" VALUES (235, NULL, 'R. K. Shyamasundar');
INSERT INTO "InstAuthPub" VALUES (236, NULL, 'Thomas P. Whaley');
INSERT INTO "InstAuthPub" VALUES (237, NULL, 'A. Nico Habermann');
INSERT INTO "InstAuthPub" VALUES (238, NULL, 'John Darlington');
INSERT INTO "InstAuthPub" VALUES (239, NULL, 'Wolfgang Merzenich');
INSERT INTO "InstAuthPub" VALUES (240, NULL, 'Rodney W. Topor');
INSERT INTO "InstAuthPub" VALUES (241, NULL, 'Jan van Leeuwen');
INSERT INTO "InstAuthPub" VALUES (242, NULL, 'Karl Unterauer');
INSERT INTO "InstAuthPub" VALUES (243, NULL, 'Eric C. R. Hehner');
INSERT INTO "InstAuthPub" VALUES (244, NULL, 'Wilf R. LaLonde');
INSERT INTO "InstAuthPub" VALUES (245, NULL, 'Colin Adams');
INSERT INTO "InstAuthPub" VALUES (245, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (245, NULL, 'Jean Vicard');
INSERT INTO "InstAuthPub" VALUES (246, NULL, 'P. Bouchet');
INSERT INTO "InstAuthPub" VALUES (247, NULL, 'Abraham Silberschatz');
INSERT INTO "InstAuthPub" VALUES (247, NULL, 'Brian Johnson');
INSERT INTO "InstAuthPub" VALUES (248, NULL, 'Rainer Kemp');
INSERT INTO "InstAuthPub" VALUES (249, NULL, 'David Gries');
INSERT INTO "InstAuthPub" VALUES (250, NULL, 'Peter R. J. Asveld');
INSERT INTO "InstAuthPub" VALUES (250, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (251, NULL, 'Gérard P. Huet');
INSERT INTO "InstAuthPub" VALUES (251, NULL, 'Bernard Lang');
INSERT INTO "InstAuthPub" VALUES (252, NULL, 'Jean-Michel Autebert');
INSERT INTO "InstAuthPub" VALUES (253, NULL, 'Leonard M. Adleman');
INSERT INTO "InstAuthPub" VALUES (253, NULL, 'Kellogg S. Booth');
INSERT INTO "InstAuthPub" VALUES (253, NULL, 'Franco P. Preparata');
INSERT INTO "InstAuthPub" VALUES (253, NULL, 'Walter L. Ruzzo');
INSERT INTO "InstAuthPub" VALUES (254, NULL, 'Derek Coleman');
INSERT INTO "InstAuthPub" VALUES (254, NULL, 'Jane W. Hughes');
INSERT INTO "InstAuthPub" VALUES (255, NULL, 'Stephan Heilbrunner');
INSERT INTO "InstAuthPub" VALUES (256, NULL, 'Sheila A. Greibach');
INSERT INTO "InstAuthPub" VALUES (257, NULL, 'Maria Calzarossa');
INSERT INTO "InstAuthPub" VALUES (257, NULL, 'M. Italiani');
INSERT INTO "InstAuthPub" VALUES (257, NULL, 'Giuseppe Serazzi');
INSERT INTO "InstAuthPub" VALUES (258, NULL, 'Demetres D. Kouvatsos');
INSERT INTO "InstAuthPub" VALUES (259, NULL, 'Siegfried Bublitz');
INSERT INTO "InstAuthPub" VALUES (260, NULL, 'Ikuo Nakata');
INSERT INTO "InstAuthPub" VALUES (260, NULL, 'Masataka Sassa');
INSERT INTO "InstAuthPub" VALUES (261, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (261, NULL, 'Juhani Karhumäki');
INSERT INTO "InstAuthPub" VALUES (262, NULL, 'Mike Paterson');
INSERT INTO "InstAuthPub" VALUES (262, NULL, 'Ingo Wegener');
INSERT INTO "InstAuthPub" VALUES (263, NULL, 'Markku Tamminen');
INSERT INTO "InstAuthPub" VALUES (263, NULL, 'W. K. Luk');
INSERT INTO "InstAuthPub" VALUES (263, NULL, 'Paolo Sipala');
INSERT INTO "InstAuthPub" VALUES (263, NULL, 'Lin S. Woo');
INSERT INTO "InstAuthPub" VALUES (263, NULL, 'C. K. Wong');
INSERT INTO "InstAuthPub" VALUES (264, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (265, NULL, 'Johannes Reichardt');
INSERT INTO "InstAuthPub" VALUES (266, NULL, 'Luc Duponcheel');
INSERT INTO "InstAuthPub" VALUES (266, NULL, 'M. Duponcheel');
INSERT INTO "InstAuthPub" VALUES (267, NULL, 'Mirko Krivánek');
INSERT INTO "InstAuthPub" VALUES (267, NULL, 'Jaroslav Morávek');
INSERT INTO "InstAuthPub" VALUES (268, NULL, 'Catherine Rosenberg');
INSERT INTO "InstAuthPub" VALUES (269, NULL, 'Piotr Wyrostek');
INSERT INTO "InstAuthPub" VALUES (270, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (270, NULL, 'Emo Welzl');
INSERT INTO "InstAuthPub" VALUES (271, NULL, 'Eric C. R. Hehner');
INSERT INTO "InstAuthPub" VALUES (271, NULL, 'Lorene E. Gupta');
INSERT INTO "InstAuthPub" VALUES (271, NULL, 'Andrew J. Malton');
INSERT INTO "InstAuthPub" VALUES (272, NULL, 'Susanne Graf');
INSERT INTO "InstAuthPub" VALUES (272, NULL, 'Joseph Sifakis');
INSERT INTO "InstAuthPub" VALUES (273, NULL, 'Walter Bucher');
INSERT INTO "InstAuthPub" VALUES (274, NULL, 'Klaus W. Wagner');
INSERT INTO "InstAuthPub" VALUES (275, NULL, 'S. A. Bengelloun');
INSERT INTO "InstAuthPub" VALUES (276, NULL, 'C. C. Lee');
INSERT INTO "InstAuthPub" VALUES (276, NULL, 'D. T. Lee');
INSERT INTO "InstAuthPub" VALUES (276, NULL, 'C. K. Wong');
INSERT INTO "InstAuthPub" VALUES (277, NULL, 'Robert Geist');
INSERT INTO "InstAuthPub" VALUES (277, NULL, 'Mark Smotherman');
INSERT INTO "InstAuthPub" VALUES (277, NULL, 'Kishor S. Trivedi');
INSERT INTO "InstAuthPub" VALUES (277, NULL, 'Joanne Bechta Dugan');
INSERT INTO "InstAuthPub" VALUES (278, NULL, 'J. Cantor');
INSERT INTO "InstAuthPub" VALUES (278, NULL, 'Anthony Ephremides');
INSERT INTO "InstAuthPub" VALUES (278, NULL, 'D. Horton');
INSERT INTO "InstAuthPub" VALUES (279, NULL, 'Vincent Vajnovszki');
INSERT INTO "InstAuthPub" VALUES (280, NULL, 'Antonella Santone');
INSERT INTO "InstAuthPub" VALUES (281, NULL, 'Kim S. Larsen');
INSERT INTO "InstAuthPub" VALUES (282, NULL, 'Madhu Mutyam');
INSERT INTO "InstAuthPub" VALUES (282, NULL, 'Kamala Krithivasan');
INSERT INTO "InstAuthPub" VALUES (283, NULL, 'Erkki Mäkinen');
INSERT INTO "InstAuthPub" VALUES (283, NULL, 'Tarja Systä');
INSERT INTO "InstAuthPub" VALUES (284, NULL, 'Salvatore La Torre');
INSERT INTO "InstAuthPub" VALUES (284, NULL, 'Margherita Napoli');
INSERT INTO "InstAuthPub" VALUES (285, NULL, 'Jürgen Dassow');
INSERT INTO "InstAuthPub" VALUES (285, NULL, 'Gheorghe Paun');
INSERT INTO "InstAuthPub" VALUES (285, NULL, 'Gabriel Thierrin');
INSERT INTO "InstAuthPub" VALUES (285, NULL, 'Sheng Yu');
INSERT INTO "InstAuthPub" VALUES (286, NULL, 'Karl Meinke');
INSERT INTO "InstAuthPub" VALUES (286, NULL, 'L. J. Steggles');
INSERT INTO "InstAuthPub" VALUES (287, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (287, NULL, 'Peter J. Downey');
INSERT INTO "InstAuthPub" VALUES (287, NULL, 'Peter M. Winkler');
INSERT INTO "InstAuthPub" VALUES (288, NULL, 'Chuzo Iwamoto');
INSERT INTO "InstAuthPub" VALUES (288, NULL, 'Katsuyuki Tateishi');
INSERT INTO "InstAuthPub" VALUES (288, NULL, 'Kenichi Morita');
INSERT INTO "InstAuthPub" VALUES (288, NULL, 'Katsunobu Imai');
INSERT INTO "InstAuthPub" VALUES (289, NULL, 'Jixue Liu');
INSERT INTO "InstAuthPub" VALUES (289, NULL, 'Millist W. Vincent');
INSERT INTO "InstAuthPub" VALUES (290, NULL, 'Dominic Duggan');
INSERT INTO "InstAuthPub" VALUES (291, NULL, 'Jean Berstel');
INSERT INTO "InstAuthPub" VALUES (291, NULL, 'Luc Boasson');
INSERT INTO "InstAuthPub" VALUES (292, NULL, 'Chris Giannella');
INSERT INTO "InstAuthPub" VALUES (292, NULL, 'Dirk Van Gucht');
INSERT INTO "InstAuthPub" VALUES (293, NULL, 'Arend Rensink');
INSERT INTO "InstAuthPub" VALUES (293, NULL, 'Heike Wehrheim');
INSERT INTO "InstAuthPub" VALUES (294, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (295, NULL, 'Michael Drmota');
INSERT INTO "InstAuthPub" VALUES (296, NULL, 'Miguel R. Penabad');
INSERT INTO "InstAuthPub" VALUES (296, NULL, 'Nieves R. Brisaboa');
INSERT INTO "InstAuthPub" VALUES (296, NULL, 'Héctor J. Hernández');
INSERT INTO "InstAuthPub" VALUES (296, NULL, 'José R. Paramá');
INSERT INTO "InstAuthPub" VALUES (297, NULL, 'Iiro S. Honkala');
INSERT INTO "InstAuthPub" VALUES (297, NULL, 'Antoine Lobstein');
INSERT INTO "InstAuthPub" VALUES (298, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (298, NULL, 'Christian Stahl');
INSERT INTO "InstAuthPub" VALUES (298, NULL, 'Richard Müller 0001');
INSERT INTO "InstAuthPub" VALUES (299, NULL, 'Peter E. Bulychev');
INSERT INTO "InstAuthPub" VALUES (299, NULL, 'Alexandre David');
INSERT INTO "InstAuthPub" VALUES (299, NULL, 'Kim G. Larsen');
INSERT INTO "InstAuthPub" VALUES (299, NULL, 'Guangyuan Li');
INSERT INTO "InstAuthPub" VALUES (300, NULL, 'Eleni Mandrali');
INSERT INTO "InstAuthPub" VALUES (300, NULL, 'George Rahonis');
INSERT INTO "InstAuthPub" VALUES (301, NULL, 'Martin Kutrib');
INSERT INTO "InstAuthPub" VALUES (301, NULL, 'Andreas Malcher');
INSERT INTO "InstAuthPub" VALUES (301, NULL, 'Matthias Wendlandt');
INSERT INTO "InstAuthPub" VALUES (302, NULL, 'Francesco Ranzato');
INSERT INTO "InstAuthPub" VALUES (303, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (303, NULL, 'Petr Zemek');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Roderick Bloem');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Krishnendu Chatterjee');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Karin Greimel');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Thomas A. Henzinger');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Georg Hofferek');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Barbara Jobstmann');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Bettina Könighofer');
INSERT INTO "InstAuthPub" VALUES (304, NULL, 'Robert Könighofer');
INSERT INTO "InstAuthPub" VALUES (305, NULL, 'Manuel Sorge');
INSERT INTO "InstAuthPub" VALUES (305, NULL, 'Hannes Moser');
INSERT INTO "InstAuthPub" VALUES (305, NULL, 'Rolf Niedermeier');
INSERT INTO "InstAuthPub" VALUES (305, NULL, 'Mathias Weller');
INSERT INTO "InstAuthPub" VALUES (306, NULL, 'Wladimir Fridman');
INSERT INTO "InstAuthPub" VALUES (306, NULL, 'Bernd Puchala');
INSERT INTO "InstAuthPub" VALUES (307, NULL, 'Suo Ping Li');
INSERT INTO "InstAuthPub" VALUES (307, NULL, 'Yong Qiang Zhou');
INSERT INTO "InstAuthPub" VALUES (307, NULL, 'Yong Zhou');
INSERT INTO "InstAuthPub" VALUES (308, NULL, 'Uli Fahrenberg');
INSERT INTO "InstAuthPub" VALUES (308, NULL, 'Axel Legay');
INSERT INTO "InstAuthPub" VALUES (309, NULL, 'Walter Cazzola');
INSERT INTO "InstAuthPub" VALUES (309, NULL, 'Edoardo Vacchi');
INSERT INTO "InstAuthPub" VALUES (310, NULL, 'Laura Bozzelli');
INSERT INTO "InstAuthPub" VALUES (310, NULL, 'César Sánchez');
INSERT INTO "InstAuthPub" VALUES (311, NULL, 'Krishnendu Chatterjee');
INSERT INTO "InstAuthPub" VALUES (311, NULL, 'Mickael Randour');
INSERT INTO "InstAuthPub" VALUES (311, NULL, 'Jean-François Raskin');
INSERT INTO "InstAuthPub" VALUES (312, NULL, 'Chunhua Cao');
INSERT INTO "InstAuthPub" VALUES (312, NULL, 'Shuang Yang');
INSERT INTO "InstAuthPub" VALUES (312, NULL, 'Di Yang');
INSERT INTO "InstAuthPub" VALUES (313, NULL, 'T. C. Hu');
INSERT INTO "InstAuthPub" VALUES (313, NULL, 'K. C. Tan');
INSERT INTO "InstAuthPub" VALUES (314, NULL, 'Volker Claus');
INSERT INTO "InstAuthPub" VALUES (315, NULL, 'Per Brinch Hansen');
INSERT INTO "InstAuthPub" VALUES (316, NULL, 'Niklaus Wirth');
INSERT INTO "InstAuthPub" VALUES (317, NULL, 'Hermann K.-G. Walter');
INSERT INTO "InstAuthPub" VALUES (318, NULL, 'Donald E. Knuth');
INSERT INTO "InstAuthPub" VALUES (319, NULL, 'Juris Hartmanis');
INSERT INTO "InstAuthPub" VALUES (320, NULL, 'Volker Strassen');
INSERT INTO "InstAuthPub" VALUES (321, NULL, 'Frank K. Hwang');
INSERT INTO "InstAuthPub" VALUES (321, NULL, 'Shen Lin 0005');
INSERT INTO "InstAuthPub" VALUES (322, NULL, 'Dominique Perrin');
INSERT INTO "InstAuthPub" VALUES (322, NULL, 'Jean-François Perrot');
INSERT INTO "InstAuthPub" VALUES (323, NULL, 'Hans Langmaack');
INSERT INTO "InstAuthPub" VALUES (324, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (324, NULL, 'Ronald L. Graham');
INSERT INTO "InstAuthPub" VALUES (325, NULL, 'Gerda Schott');
INSERT INTO "InstAuthPub" VALUES (326, NULL, 'Arnold Schönhage');
INSERT INTO "InstAuthPub" VALUES (327, NULL, 'Wladyslaw M. Turski');
INSERT INTO "InstAuthPub" VALUES (328, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (328, NULL, 'Brian Randell');
INSERT INTO "InstAuthPub" VALUES (329, NULL, 'A. C. McKellar');
INSERT INTO "InstAuthPub" VALUES (329, NULL, 'C. K. Wong');
INSERT INTO "InstAuthPub" VALUES (330, NULL, 'Donald E. Knuth');
INSERT INTO "InstAuthPub" VALUES (331, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (332, NULL, 'William R. Franta');
INSERT INTO "InstAuthPub" VALUES (333, NULL, 'Robert T. Moenck');
INSERT INTO "InstAuthPub" VALUES (334, NULL, 'Zvi Galil');
INSERT INTO "InstAuthPub" VALUES (335, NULL, 'Hans Jürgen Schneider');
INSERT INTO "InstAuthPub" VALUES (335, NULL, 'Hartmut Ehrig');
INSERT INTO "InstAuthPub" VALUES (336, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (336, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (337, NULL, 'Jacques Cohen');
INSERT INTO "InstAuthPub" VALUES (337, NULL, 'Martin S. Roth');
INSERT INTO "InstAuthPub" VALUES (338, NULL, 'Ronald V. Book');
INSERT INTO "InstAuthPub" VALUES (338, NULL, 'Ashok K. Chandra');
INSERT INTO "InstAuthPub" VALUES (339, NULL, 'Alexandre Brandwajn');
INSERT INTO "InstAuthPub" VALUES (340, NULL, 'Edsger W. Dijkstra');
INSERT INTO "InstAuthPub" VALUES (341, NULL, 'R. M. Wharton');
INSERT INTO "InstAuthPub" VALUES (342, NULL, 'Hans Albrecht Schmid');
INSERT INTO "InstAuthPub" VALUES (343, NULL, 'Pierre-Jacques Courtois');
INSERT INTO "InstAuthPub" VALUES (343, NULL, 'Hendrik Vantilborgh');
INSERT INTO "InstAuthPub" VALUES (344, NULL, 'Burkhard Monien');
INSERT INTO "InstAuthPub" VALUES (345, NULL, 'Roland Carl Backhouse');
INSERT INTO "InstAuthPub" VALUES (346, NULL, 'Kenichi Taniguchi');
INSERT INTO "InstAuthPub" VALUES (346, NULL, 'Tadao Kasami');
INSERT INTO "InstAuthPub" VALUES (347, NULL, 'Michael Karr');
INSERT INTO "InstAuthPub" VALUES (348, NULL, 'Ekkart Kindler');
INSERT INTO "InstAuthPub" VALUES (349, NULL, 'X. J. Chen');
INSERT INTO "InstAuthPub" VALUES (349, NULL, 'Carlo Montangero');
INSERT INTO "InstAuthPub" VALUES (350, NULL, 'Ugo Montanari');
INSERT INTO "InstAuthPub" VALUES (350, NULL, 'Francesca Rossi');
INSERT INTO "InstAuthPub" VALUES (351, NULL, 'Wlodzimierz Drabent');
INSERT INTO "InstAuthPub" VALUES (352, NULL, 'Wuu Yang');
INSERT INTO "InstAuthPub" VALUES (353, NULL, 'Matthew Hennessy');
INSERT INTO "InstAuthPub" VALUES (353, NULL, 'Xinxin Liu');
INSERT INTO "InstAuthPub" VALUES (354, NULL, 'Eric Badouel');
INSERT INTO "InstAuthPub" VALUES (354, NULL, 'Philippe Darondeau');
INSERT INTO "InstAuthPub" VALUES (355, NULL, 'Adam L. Buchsbaum');
INSERT INTO "InstAuthPub" VALUES (355, NULL, 'Rajamani Sundar');
INSERT INTO "InstAuthPub" VALUES (355, NULL, 'Robert Endre Tarjan');
INSERT INTO "InstAuthPub" VALUES (356, NULL, 'Ramachandran Vaidyanathan');
INSERT INTO "InstAuthPub" VALUES (356, NULL, 'Carlos R. P. Hartmann');
INSERT INTO "InstAuthPub" VALUES (356, NULL, 'Pramod K. Varshney');
INSERT INTO "InstAuthPub" VALUES (357, NULL, 'Inman P. de Guzmán');
INSERT INTO "InstAuthPub" VALUES (357, NULL, 'Manuel Ojeda-Aciego');
INSERT INTO "InstAuthPub" VALUES (357, NULL, 'Agustín Valverde');
INSERT INTO "InstAuthPub" VALUES (358, NULL, 'Gary T. Leavens');
INSERT INTO "InstAuthPub" VALUES (358, NULL, 'William E. Weihl');
INSERT INTO "InstAuthPub" VALUES (359, NULL, 'Lefteris M. Kirousis');
INSERT INTO "InstAuthPub" VALUES (359, NULL, 'Andreas G. Veneris');
INSERT INTO "InstAuthPub" VALUES (360, NULL, 'Joachim Biskup');
INSERT INTO "InstAuthPub" VALUES (360, NULL, 'Pratul Dublish');
INSERT INTO "InstAuthPub" VALUES (360, NULL, 'Yehoshua Sagiv');
INSERT INTO "InstAuthPub" VALUES (361, NULL, 'Matthew Hennessy');
INSERT INTO "InstAuthPub" VALUES (362, NULL, 'Wen-Jing Hsu');
INSERT INTO "InstAuthPub" VALUES (362, NULL, 'Carl V. Page');
INSERT INTO "InstAuthPub" VALUES (363, NULL, 'Janet A. Walz');
INSERT INTO "InstAuthPub" VALUES (363, NULL, 'Gregory F. Johnson');
INSERT INTO "InstAuthPub" VALUES (364, NULL, 'Chongkye Rhee');
INSERT INTO "InstAuthPub" VALUES (364, NULL, 'Y. Daniel Liang');
INSERT INTO "InstAuthPub" VALUES (365, NULL, 'Baudouin Le Charlier');
INSERT INTO "InstAuthPub" VALUES (365, NULL, 'Pascal Van Hentenryck');
INSERT INTO "InstAuthPub" VALUES (366, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (366, NULL, 'Peter Rajcáni');
INSERT INTO "InstAuthPub" VALUES (367, NULL, 'Robert Gold');
INSERT INTO "InstAuthPub" VALUES (368, NULL, 'Wei-Ngan Chin');
INSERT INTO "InstAuthPub" VALUES (368, NULL, 'Masami Hagiya');
INSERT INTO "InstAuthPub" VALUES (369, NULL, 'Jean Néraud');
INSERT INTO "InstAuthPub" VALUES (370, NULL, 'Helmut Jürgensen');
INSERT INTO "InstAuthPub" VALUES (370, NULL, 'Ludwig Staiger');
INSERT INTO "InstAuthPub" VALUES (371, NULL, 'Sumit Sur');
INSERT INTO "InstAuthPub" VALUES (371, NULL, 'Pradip K. Srimani');
INSERT INTO "InstAuthPub" VALUES (372, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (373, NULL, 'Sergei Gorlatch');
INSERT INTO "InstAuthPub" VALUES (373, NULL, 'Christian Lengauer');
INSERT INTO "InstAuthPub" VALUES (374, NULL, 'Erzsébet Csuhaj-Varjú');
INSERT INTO "InstAuthPub" VALUES (374, NULL, 'Victor Mitrana');
INSERT INTO "InstAuthPub" VALUES (375, NULL, 'Gary T. Leavens');
INSERT INTO "InstAuthPub" VALUES (375, NULL, 'Don Pigozzi');
INSERT INTO "InstAuthPub" VALUES (376, NULL, 'Karsten Schmidt 0004');
INSERT INTO "InstAuthPub" VALUES (377, NULL, 'Benedetto Intrigila');
INSERT INTO "InstAuthPub" VALUES (377, NULL, 'Stefano Varricchio');
INSERT INTO "InstAuthPub" VALUES (378, NULL, 'Ralph-Johan Back');
INSERT INTO "InstAuthPub" VALUES (378, NULL, 'Joakim von Wright');
INSERT INTO "InstAuthPub" VALUES (379, NULL, 'Michael Schenke');
INSERT INTO "InstAuthPub" VALUES (379, NULL, 'Ernst-Rüdiger Olderog');
INSERT INTO "InstAuthPub" VALUES (380, NULL, 'T. C. Edwin Cheng');
INSERT INTO "InstAuthPub" VALUES (380, NULL, 'Qing Ding');
INSERT INTO "InstAuthPub" VALUES (381, NULL, 'Lars Lundberg');
INSERT INTO "InstAuthPub" VALUES (381, NULL, 'Håkan Lennerstad');
INSERT INTO "InstAuthPub" VALUES (382, NULL, 'Lucian Ilie');
INSERT INTO "InstAuthPub" VALUES (382, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (383, NULL, 'Jesús N. Ravelo');
INSERT INTO "InstAuthPub" VALUES (384, NULL, 'Hans-Dieter Ehrich');
INSERT INTO "InstAuthPub" VALUES (384, NULL, 'Carlos Caleiro');
INSERT INTO "InstAuthPub" VALUES (385, NULL, 'Aart Middeldorp');
INSERT INTO "InstAuthPub" VALUES (385, NULL, 'Hitoshi Ohsaki');
INSERT INTO "InstAuthPub" VALUES (386, NULL, 'Ivana Cerná');
INSERT INTO "InstAuthPub" VALUES (386, NULL, 'Mojmír Kretínský');
INSERT INTO "InstAuthPub" VALUES (386, NULL, 'Antonín Kucera');
INSERT INTO "InstAuthPub" VALUES (387, NULL, 'Anthony J. Bonner');
INSERT INTO "InstAuthPub" VALUES (387, NULL, 'Giansalvatore Mecca');
INSERT INTO "InstAuthPub" VALUES (388, NULL, 'Gunnar Forst');
INSERT INTO "InstAuthPub" VALUES (388, NULL, 'Anders Thorup');
INSERT INTO "InstAuthPub" VALUES (389, NULL, 'Yoshiki Kinoshita');
INSERT INTO "InstAuthPub" VALUES (389, NULL, 'John Power');
INSERT INTO "InstAuthPub" VALUES (390, NULL, 'Frank Tip');
INSERT INTO "InstAuthPub" VALUES (390, NULL, 'Peter F. Sweeney');
INSERT INTO "InstAuthPub" VALUES (391, NULL, 'Ferri Abolhassan');
INSERT INTO "InstAuthPub" VALUES (391, NULL, 'Jörg Keller 0001');
INSERT INTO "InstAuthPub" VALUES (391, NULL, 'Wolfgang J. Paul');
INSERT INTO "InstAuthPub" VALUES (392, NULL, 'Juha Honkala');
INSERT INTO "InstAuthPub" VALUES (393, NULL, 'Millist W. Vincent');
INSERT INTO "InstAuthPub" VALUES (394, NULL, 'Klaus-Dieter Schewe');
INSERT INTO "InstAuthPub" VALUES (394, NULL, 'Bernhard Thalheim');
INSERT INTO "InstAuthPub" VALUES (395, NULL, 'Pierpaolo Degano');
INSERT INTO "InstAuthPub" VALUES (395, NULL, 'Corrado Priami');
INSERT INTO "InstAuthPub" VALUES (395, NULL, 'Lone Leth');
INSERT INTO "InstAuthPub" VALUES (395, NULL, 'Bent Thomsen');
INSERT INTO "InstAuthPub" VALUES (396, NULL, 'Roni Khardon');
INSERT INTO "InstAuthPub" VALUES (396, NULL, 'Heikki Mannila');
INSERT INTO "InstAuthPub" VALUES (396, NULL, 'Dan Roth');
INSERT INTO "InstAuthPub" VALUES (397, NULL, 'Michael Schenke');
INSERT INTO "InstAuthPub" VALUES (398, NULL, 'Arturo Carpi');
INSERT INTO "InstAuthPub" VALUES (398, NULL, 'Aldo de Luca');
INSERT INTO "InstAuthPub" VALUES (399, NULL, 'Guido Proietti');
INSERT INTO "InstAuthPub" VALUES (400, NULL, 'Roland Meyer');
INSERT INTO "InstAuthPub" VALUES (401, NULL, 'Victor Khomenko');
INSERT INTO "InstAuthPub" VALUES (401, NULL, 'Mark Schäfer');
INSERT INTO "InstAuthPub" VALUES (401, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (401, NULL, 'Ralf Wollowski');
INSERT INTO "InstAuthPub" VALUES (402, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (402, NULL, 'Eric Lilin');
INSERT INTO "InstAuthPub" VALUES (402, NULL, 'Andreas Maletti');
INSERT INTO "InstAuthPub" VALUES (403, NULL, 'Kamilla Klonowska');
INSERT INTO "InstAuthPub" VALUES (403, NULL, 'Lars Lundberg');
INSERT INTO "InstAuthPub" VALUES (403, NULL, 'Håkan Lennerstad');
INSERT INTO "InstAuthPub" VALUES (404, NULL, 'Jan Janousek');
INSERT INTO "InstAuthPub" VALUES (404, NULL, 'Borivoj Melichar');
INSERT INTO "InstAuthPub" VALUES (405, NULL, 'Achim D. Brucker');
INSERT INTO "InstAuthPub" VALUES (405, NULL, 'Burkhart Wolff');
INSERT INTO "InstAuthPub" VALUES (406, NULL, 'Flavio Corradini');
INSERT INTO "InstAuthPub" VALUES (406, NULL, 'Maria Rita Di Berardini');
INSERT INTO "InstAuthPub" VALUES (406, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (407, NULL, 'Arturo Carpi');
INSERT INTO "InstAuthPub" VALUES (407, NULL, 'Flavio D''Alessandro');
INSERT INTO "InstAuthPub" VALUES (408, NULL, 'Laura Bozzelli');
INSERT INTO "InstAuthPub" VALUES (408, NULL, 'Mojmír Kretínský');
INSERT INTO "InstAuthPub" VALUES (408, NULL, 'Vojtech Rehák');
INSERT INTO "InstAuthPub" VALUES (408, NULL, 'Jan Strejcek');
INSERT INTO "InstAuthPub" VALUES (409, NULL, 'Amir M. Ben-Amram');
INSERT INTO "InstAuthPub" VALUES (410, NULL, 'Rza Bashirov');
INSERT INTO "InstAuthPub" VALUES (410, NULL, 'Fabrice Kordon');
INSERT INTO "InstAuthPub" VALUES (410, NULL, 'Hüseyin Lort');
INSERT INTO "InstAuthPub" VALUES (411, NULL, 'Paolo Zuliani');
INSERT INTO "InstAuthPub" VALUES (412, NULL, 'Zdenek Sawa');
INSERT INTO "InstAuthPub" VALUES (412, NULL, 'Petr Jancar');
INSERT INTO "InstAuthPub" VALUES (413, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (414, NULL, 'Vince Bárány');
INSERT INTO "InstAuthPub" VALUES (415, NULL, 'Davide Bresolin');
INSERT INTO "InstAuthPub" VALUES (415, NULL, 'Angelo Montanari');
INSERT INTO "InstAuthPub" VALUES (415, NULL, 'Gabriele Puppis');
INSERT INTO "InstAuthPub" VALUES (416, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (416, NULL, 'Philippe Darondeau');
INSERT INTO "InstAuthPub" VALUES (417, NULL, 'Cezar Câmpeanu');
INSERT INTO "InstAuthPub" VALUES (417, NULL, 'Nicolae Santean');
INSERT INTO "InstAuthPub" VALUES (418, NULL, 'Jan A. Bergstra');
INSERT INTO "InstAuthPub" VALUES (418, NULL, 'C. A. Middelburg');
INSERT INTO "InstAuthPub" VALUES (419, NULL, 'José Enrique Armendáriz-Iñigo');
INSERT INTO "InstAuthPub" VALUES (419, NULL, 'José Ramón González de Mendívil');
INSERT INTO "InstAuthPub" VALUES (419, NULL, 'José Ramón Garitagoitia');
INSERT INTO "InstAuthPub" VALUES (419, NULL, 'Francesc D. Muñoz-Escoí');
INSERT INTO "InstAuthPub" VALUES (420, NULL, 'Stefan Reisch');
INSERT INTO "InstAuthPub" VALUES (421, NULL, 'Ernst W. Mayr');
INSERT INTO "InstAuthPub" VALUES (422, NULL, 'Friedrich L. Bauer');
INSERT INTO "InstAuthPub" VALUES (422, NULL, 'Andrei P. Ershov');
INSERT INTO "InstAuthPub" VALUES (422, NULL, 'Manfred Paul');
INSERT INTO "InstAuthPub" VALUES (422, NULL, 'Alan J. Perlis');
INSERT INTO "InstAuthPub" VALUES (423, NULL, 'Gary Levin');
INSERT INTO "InstAuthPub" VALUES (423, NULL, 'David Gries');
INSERT INTO "InstAuthPub" VALUES (424, NULL, 'Toshiro Araki');
INSERT INTO "InstAuthPub" VALUES (424, NULL, 'Nobuki Tokura');
INSERT INTO "InstAuthPub" VALUES (425, NULL, 'William E. Wright');
INSERT INTO "InstAuthPub" VALUES (426, NULL, 'Werner Kuich');
INSERT INTO "InstAuthPub" VALUES (427, NULL, 'Krzysztof R. Apt');
INSERT INTO "InstAuthPub" VALUES (428, NULL, 'Onno J. Boxma');
INSERT INTO "InstAuthPub" VALUES (428, NULL, 'Alan G. Konheim');
INSERT INTO "InstAuthPub" VALUES (429, NULL, 'Paul Walton Purdom Jr.');
INSERT INTO "InstAuthPub" VALUES (429, NULL, 'Cynthia A. Brown');
INSERT INTO "InstAuthPub" VALUES (430, NULL, 'Daniel M. Berry');
INSERT INTO "InstAuthPub" VALUES (431, NULL, 'Takehiro Tokuda');
INSERT INTO "InstAuthPub" VALUES (432, NULL, 'Stal O. Anderaa');
INSERT INTO "InstAuthPub" VALUES (432, NULL, 'Egon Börger');
INSERT INTO "InstAuthPub" VALUES (433, NULL, 'Donald L. Iglehart');
INSERT INTO "InstAuthPub" VALUES (433, NULL, 'Gerald S. Shedler');
INSERT INTO "InstAuthPub" VALUES (434, NULL, 'François Baccelli');
INSERT INTO "InstAuthPub" VALUES (435, NULL, 'Ingo Wegener');
INSERT INTO "InstAuthPub" VALUES (436, NULL, 'Hans Daduna');
INSERT INTO "InstAuthPub" VALUES (436, NULL, 'Rolf Schassberger');
INSERT INTO "InstAuthPub" VALUES (437, NULL, 'Lawrence T. Kou');
INSERT INTO "InstAuthPub" VALUES (437, NULL, 'George Markowsky');
INSERT INTO "InstAuthPub" VALUES (437, NULL, 'Leonard Berman');
INSERT INTO "InstAuthPub" VALUES (438, NULL, 'Ryszard Janicki');
INSERT INTO "InstAuthPub" VALUES (439, NULL, 'Joseph M. Morris');
INSERT INTO "InstAuthPub" VALUES (439, NULL, 'Malcolm Tyrrell');
INSERT INTO "InstAuthPub" VALUES (440, NULL, 'Rudolf Berghammer');
INSERT INTO "InstAuthPub" VALUES (441, NULL, 'Amr Elmasry');
INSERT INTO "InstAuthPub" VALUES (441, NULL, 'Michael L. Fredman');
INSERT INTO "InstAuthPub" VALUES (442, NULL, 'Tomás Brázdil');
INSERT INTO "InstAuthPub" VALUES (442, NULL, 'Antonín Kucera');
INSERT INTO "InstAuthPub" VALUES (442, NULL, 'Oldrich Strazovský');
INSERT INTO "InstAuthPub" VALUES (443, NULL, 'Martin Kutrib');
INSERT INTO "InstAuthPub" VALUES (443, NULL, 'Andreas Malcher');
INSERT INTO "InstAuthPub" VALUES (443, NULL, 'Detlef Wotschke');
INSERT INTO "InstAuthPub" VALUES (444, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (445, NULL, 'Chen-Ming Fan');
INSERT INTO "InstAuthPub" VALUES (445, NULL, 'Cheng-Chih Huang');
INSERT INTO "InstAuthPub" VALUES (445, NULL, 'Huei-Jan Shyr');
INSERT INTO "InstAuthPub" VALUES (446, NULL, 'Benny Godlin');
INSERT INTO "InstAuthPub" VALUES (446, NULL, 'Ofer Strichman');
INSERT INTO "InstAuthPub" VALUES (447, NULL, 'Sebastian Link');
INSERT INTO "InstAuthPub" VALUES (448, NULL, 'Matteo Magnani');
INSERT INTO "InstAuthPub" VALUES (448, NULL, 'Danilo Montesi');
INSERT INTO "InstAuthPub" VALUES (449, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (449, NULL, 'Jirí Techet');
INSERT INTO "InstAuthPub" VALUES (450, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (450, NULL, 'Asaf Levin');
INSERT INTO "InstAuthPub" VALUES (450, NULL, 'Rob van Stee');
INSERT INTO "InstAuthPub" VALUES (451, NULL, 'Amr Elmasry');
INSERT INTO "InstAuthPub" VALUES (451, NULL, 'Claus Jensen');
INSERT INTO "InstAuthPub" VALUES (451, NULL, 'Jyrki Katajainen');
INSERT INTO "InstAuthPub" VALUES (452, NULL, 'Larissa Meinicke');
INSERT INTO "InstAuthPub" VALUES (452, NULL, 'Ian J. Hayes');
INSERT INTO "InstAuthPub" VALUES (453, NULL, 'Robert Brijder');
INSERT INTO "InstAuthPub" VALUES (453, NULL, 'Hendrik Jan Hoogeboom');
INSERT INTO "InstAuthPub" VALUES (454, NULL, 'Bruce Russell');
INSERT INTO "InstAuthPub" VALUES (455, NULL, 'David A. Watt');
INSERT INTO "InstAuthPub" VALUES (456, NULL, 'Isi Mitrani');
INSERT INTO "InstAuthPub" VALUES (456, NULL, 'J. H. Hine');
INSERT INTO "InstAuthPub" VALUES (457, NULL, 'George W. Ernst');
INSERT INTO "InstAuthPub" VALUES (458, NULL, 'Norbert Ramsperger');
INSERT INTO "InstAuthPub" VALUES (459, NULL, 'Nissim Francez');
INSERT INTO "InstAuthPub" VALUES (459, NULL, 'Boris Klebansky');
INSERT INTO "InstAuthPub" VALUES (459, NULL, 'Amir Pnueli');
INSERT INTO "InstAuthPub" VALUES (460, NULL, 'Reidar Conradi');
INSERT INTO "InstAuthPub" VALUES (461, NULL, 'Hermann A. Maurer');
INSERT INTO "InstAuthPub" VALUES (461, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (461, NULL, 'Derick Wood');
INSERT INTO "InstAuthPub" VALUES (462, NULL, 'Peter Deussen');
INSERT INTO "InstAuthPub" VALUES (462, NULL, 'Kurt Mehlhorn');
INSERT INTO "InstAuthPub" VALUES (463, NULL, 'Fred Kröger');
INSERT INTO "InstAuthPub" VALUES (464, NULL, 'James E. Donahue');
INSERT INTO "InstAuthPub" VALUES (465, NULL, 'J. Eve');
INSERT INTO "InstAuthPub" VALUES (465, NULL, 'Reino Kurki-Suonio');
INSERT INTO "InstAuthPub" VALUES (466, NULL, 'Joel I. Seiferas');
INSERT INTO "InstAuthPub" VALUES (467, NULL, 'Yoshihide Igarashi');
INSERT INTO "InstAuthPub" VALUES (468, NULL, 'Mila E. Majster-Cederbaum');
INSERT INTO "InstAuthPub" VALUES (469, NULL, 'Burkhard Monien');
INSERT INTO "InstAuthPub" VALUES (470, NULL, 'David C. Luckham');
INSERT INTO "InstAuthPub" VALUES (470, NULL, 'Norihisa Suzuki');
INSERT INTO "InstAuthPub" VALUES (471, NULL, 'Robert D. Tennent');
INSERT INTO "InstAuthPub" VALUES (472, NULL, 'Robert D. Tennent');
INSERT INTO "InstAuthPub" VALUES (473, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (473, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (474, NULL, 'P. F. Schuler');
INSERT INTO "InstAuthPub" VALUES (475, NULL, 'Jean Berstel');
INSERT INTO "InstAuthPub" VALUES (476, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (476, NULL, 'Jacques Lenfant');
INSERT INTO "InstAuthPub" VALUES (476, NULL, 'Dominique Potier');
INSERT INTO "InstAuthPub" VALUES (477, NULL, 'M. R. Garey');
INSERT INTO "InstAuthPub" VALUES (477, NULL, 'Ronald L. Graham');
INSERT INTO "InstAuthPub" VALUES (478, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (478, NULL, 'Paolo Tiberio');
INSERT INTO "InstAuthPub" VALUES (478, NULL, 'J. C. A. Boekhorst');
INSERT INTO "InstAuthPub" VALUES (479, NULL, 'Lutz Eichner');
INSERT INTO "InstAuthPub" VALUES (480, NULL, 'Bennett L. Fox');
INSERT INTO "InstAuthPub" VALUES (481, NULL, 'Zohar Manna');
INSERT INTO "InstAuthPub" VALUES (481, NULL, 'Amir Pnueli');
INSERT INTO "InstAuthPub" VALUES (482, NULL, 'Gerd Kaufholz');
INSERT INTO "InstAuthPub" VALUES (483, NULL, 'Klaus Ecker');
INSERT INTO "InstAuthPub" VALUES (483, NULL, 'Helmut Ratschek');
INSERT INTO "InstAuthPub" VALUES (484, NULL, 'Maurice Schlumberger');
INSERT INTO "InstAuthPub" VALUES (484, NULL, 'Jean Vuillemin');
INSERT INTO "InstAuthPub" VALUES (485, NULL, 'A. Nico Habermann');
INSERT INTO "InstAuthPub" VALUES (486, NULL, 'A. Nahapetian');
INSERT INTO "InstAuthPub" VALUES (487, NULL, 'T. Betteridge');
INSERT INTO "InstAuthPub" VALUES (488, NULL, 'C. C. Gotlieb');
INSERT INTO "InstAuthPub" VALUES (488, NULL, 'Frank Wm. Tompa');
INSERT INTO "InstAuthPub" VALUES (489, NULL, 'Armin B. Cremers');
INSERT INTO "InstAuthPub" VALUES (490, NULL, 'David J. Kuck');
INSERT INTO "InstAuthPub" VALUES (490, NULL, 'Yoichi Muraoka');
INSERT INTO "InstAuthPub" VALUES (491, NULL, 'Ellis Horowitz');
INSERT INTO "InstAuthPub" VALUES (492, NULL, 'Rainer Kemp');
INSERT INTO "InstAuthPub" VALUES (493, NULL, 'Fred Kröger');
INSERT INTO "InstAuthPub" VALUES (494, NULL, 'Vijay K. Vaishnavi');
INSERT INTO "InstAuthPub" VALUES (494, NULL, 'Hans-Peter Kriegel');
INSERT INTO "InstAuthPub" VALUES (494, NULL, 'Derick Wood');
INSERT INTO "InstAuthPub" VALUES (495, NULL, 'Anton Nijholt');
INSERT INTO "InstAuthPub" VALUES (496, NULL, 'Bruce Russell');
INSERT INTO "InstAuthPub" VALUES (497, NULL, 'Leslie Lamport');
INSERT INTO "InstAuthPub" VALUES (498, NULL, 'Wolfgang J. Paul');
INSERT INTO "InstAuthPub" VALUES (498, NULL, 'Ernst J. Prauß');
INSERT INTO "InstAuthPub" VALUES (498, NULL, 'Rüdiger Reischuk');
INSERT INTO "InstAuthPub" VALUES (499, NULL, 'Hirokazu Nishimura');
INSERT INTO "InstAuthPub" VALUES (500, NULL, 'Carla Schlatter Ellis');
INSERT INTO "InstAuthPub" VALUES (501, NULL, 'Reiner Philipp');
INSERT INTO "InstAuthPub" VALUES (501, NULL, 'Ernst-Jürgen Prauß');
INSERT INTO "InstAuthPub" VALUES (502, NULL, 'Marco A. Casanova');
INSERT INTO "InstAuthPub" VALUES (502, NULL, 'Philip A. Bernstein');
INSERT INTO "InstAuthPub" VALUES (503, NULL, 'Brigitte Plateau');
INSERT INTO "InstAuthPub" VALUES (504, NULL, 'Wolfgang J. Paul');
INSERT INTO "InstAuthPub" VALUES (504, NULL, 'Rüdiger Reischuk');
INSERT INTO "InstAuthPub" VALUES (505, NULL, 'Paul Walton Purdom Jr.');
INSERT INTO "InstAuthPub" VALUES (505, NULL, 'Cynthia A. Brown');
INSERT INTO "InstAuthPub" VALUES (506, NULL, 'Reiji Nakajima');
INSERT INTO "InstAuthPub" VALUES (506, NULL, 'Michio Honda');
INSERT INTO "InstAuthPub" VALUES (506, NULL, 'Hayao Nakahara');
INSERT INTO "InstAuthPub" VALUES (507, NULL, 'Zvi Galil');
INSERT INTO "InstAuthPub" VALUES (508, NULL, 'Allan G. Bromley');
INSERT INTO "InstAuthPub" VALUES (509, NULL, 'Yijie Han');
INSERT INTO "InstAuthPub" VALUES (509, NULL, 'Yoshihide Igarashi');
INSERT INTO "InstAuthPub" VALUES (510, NULL, 'Ian F. Akyildiz');
INSERT INTO "InstAuthPub" VALUES (510, NULL, 'Horst von Brand');
INSERT INTO "InstAuthPub" VALUES (511, NULL, 'Peter Lipps');
INSERT INTO "InstAuthPub" VALUES (511, NULL, 'Ulrich Möncke');
INSERT INTO "InstAuthPub" VALUES (511, NULL, 'Matthias Olk');
INSERT INTO "InstAuthPub" VALUES (511, NULL, 'Reinhard Wilhelm');
INSERT INTO "InstAuthPub" VALUES (512, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (512, NULL, 'Heiko Vogler');
INSERT INTO "InstAuthPub" VALUES (513, NULL, 'Ricardo A. Baeza-Yates');
INSERT INTO "InstAuthPub" VALUES (514, NULL, 'Joseph M. Morris');
INSERT INTO "InstAuthPub" VALUES (515, NULL, 'K. V. S. Ramarao');
INSERT INTO "InstAuthPub" VALUES (516, NULL, 'Eric C. R. Hehner');
INSERT INTO "InstAuthPub" VALUES (516, NULL, 'Lorene E. Gupta');
INSERT INTO "InstAuthPub" VALUES (516, NULL, 'Andrew J. Malton');
INSERT INTO "InstAuthPub" VALUES (517, NULL, 'Demetres D. Kouvatsos');
INSERT INTO "InstAuthPub" VALUES (517, NULL, 'John Almond');
INSERT INTO "InstAuthPub" VALUES (518, NULL, 'Edward G. Belaga');
INSERT INTO "InstAuthPub" VALUES (519, NULL, 'Róbert Szelepcsényi');
INSERT INTO "InstAuthPub" VALUES (520, NULL, 'Yennun Huang');
INSERT INTO "InstAuthPub" VALUES (520, NULL, 'Pankaj Jalote');
INSERT INTO "InstAuthPub" VALUES (521, NULL, 'Elisa Bertino');
INSERT INTO "InstAuthPub" VALUES (521, NULL, 'Daniela Musto');
INSERT INTO "InstAuthPub" VALUES (522, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (523, NULL, 'Paul Helman');
INSERT INTO "InstAuthPub" VALUES (524, NULL, 'Rainer Kemp');
INSERT INTO "InstAuthPub" VALUES (525, NULL, 'Bing-Chao Huang');
INSERT INTO "InstAuthPub" VALUES (525, NULL, 'Michael A. Langston');
INSERT INTO "InstAuthPub" VALUES (526, NULL, 'Helmut Seidl');
INSERT INTO "InstAuthPub" VALUES (527, NULL, 'Ricardo A. Baeza-Yates');
INSERT INTO "InstAuthPub" VALUES (528, NULL, 'Laurent Pierre');
INSERT INTO "InstAuthPub" VALUES (528, NULL, 'Sylviane R. Schwer');
INSERT INTO "InstAuthPub" VALUES (529, NULL, 'Hans-Ulrich Simon');
INSERT INTO "InstAuthPub" VALUES (530, NULL, 'Johannes G. G. van de Vorst');
INSERT INTO "InstAuthPub" VALUES (531, NULL, 'Demetres D. Kouvatsos');
INSERT INTO "InstAuthPub" VALUES (531, NULL, 'John Almond');
INSERT INTO "InstAuthPub" VALUES (532, NULL, 'Annegret Habel');
INSERT INTO "InstAuthPub" VALUES (532, NULL, 'Hans-Jörg Kreowski');
INSERT INTO "InstAuthPub" VALUES (532, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (533, NULL, 'Arunabha Sen');
INSERT INTO "InstAuthPub" VALUES (534, NULL, 'Jean-Michel Autebert');
INSERT INTO "InstAuthPub" VALUES (534, NULL, 'Joaquim Gabarró');
INSERT INTO "InstAuthPub" VALUES (535, NULL, 'Bin Zhang 0004');
INSERT INTO "InstAuthPub" VALUES (535, NULL, 'Meichun Hsu');
INSERT INTO "InstAuthPub" VALUES (536, NULL, 'Luc Devroye');
INSERT INTO "InstAuthPub" VALUES (537, NULL, 'Christos Levcopoulos');
INSERT INTO "InstAuthPub" VALUES (537, NULL, 'Mark H. Overmars');
INSERT INTO "InstAuthPub" VALUES (538, NULL, 'Johannes Köbler');
INSERT INTO "InstAuthPub" VALUES (538, NULL, 'Uwe Schöning');
INSERT INTO "InstAuthPub" VALUES (538, NULL, 'Jacobo Torán');
INSERT INTO "InstAuthPub" VALUES (539, NULL, 'Rob J. van Glabbeek');
INSERT INTO "InstAuthPub" VALUES (539, NULL, 'Ursula Goltz');
INSERT INTO "InstAuthPub" VALUES (539, NULL, 'Ernst-Rüdiger Olderog');
INSERT INTO "InstAuthPub" VALUES (540, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (540, NULL, 'Raymond R. Devillers');
INSERT INTO "InstAuthPub" VALUES (541, NULL, 'Gerald Lüttgen');
INSERT INTO "InstAuthPub" VALUES (541, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (541, NULL, 'Sascha Fendrich');
INSERT INTO "InstAuthPub" VALUES (542, NULL, 'Joachim Klein 0001');
INSERT INTO "InstAuthPub" VALUES (542, NULL, 'Christel Baier');
INSERT INTO "InstAuthPub" VALUES (542, NULL, 'Sascha Klüppelholz');
INSERT INTO "InstAuthPub" VALUES (543, NULL, 'Antti Valmari');
INSERT INTO "InstAuthPub" VALUES (544, NULL, 'Chen-Ming Fan');
INSERT INTO "InstAuthPub" VALUES (544, NULL, 'Jen-Tse Wang');
INSERT INTO "InstAuthPub" VALUES (544, NULL, 'Cheng-Chih Huang');
INSERT INTO "InstAuthPub" VALUES (545, NULL, 'Frank Drewes');
INSERT INTO "InstAuthPub" VALUES (545, NULL, 'Berthold Hoffmann');
INSERT INTO "InstAuthPub" VALUES (546, NULL, 'Ernst-Rüdiger Olderog');
INSERT INTO "InstAuthPub" VALUES (547, NULL, 'Manfred Broy');
INSERT INTO "InstAuthPub" VALUES (548, NULL, 'Han-Hing Dang');
INSERT INTO "InstAuthPub" VALUES (548, NULL, 'Bernhard Möller');
INSERT INTO "InstAuthPub" VALUES (549, NULL, 'Rob J. van Glabbeek');
INSERT INTO "InstAuthPub" VALUES (549, NULL, 'Peter Höfner');
INSERT INTO "InstAuthPub" VALUES (550, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (551, NULL, 'Joaquin Aguado');
INSERT INTO "InstAuthPub" VALUES (551, NULL, 'Michael Mendler');
INSERT INTO "InstAuthPub" VALUES (551, NULL, 'Reinhard von Hanxleden');
INSERT INTO "InstAuthPub" VALUES (551, NULL, 'Insa Fuhrmann');
INSERT INTO "InstAuthPub" VALUES (552, NULL, 'Antonio Bernini');
INSERT INTO "InstAuthPub" VALUES (552, NULL, 'Stefano Bilotta');
INSERT INTO "InstAuthPub" VALUES (552, NULL, 'Renzo Pinzani');
INSERT INTO "InstAuthPub" VALUES (552, NULL, 'Ahmad Sabri');
INSERT INTO "InstAuthPub" VALUES (552, NULL, 'Vincent Vajnovszki');
INSERT INTO "InstAuthPub" VALUES (553, NULL, 'Alejandro Sánchez');
INSERT INTO "InstAuthPub" VALUES (553, NULL, 'César Sánchez');
INSERT INTO "InstAuthPub" VALUES (554, NULL, 'Jörg Desel');
INSERT INTO "InstAuthPub" VALUES (554, NULL, 'Görkem Kilinç');
INSERT INTO "InstAuthPub" VALUES (555, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (555, NULL, 'Raymond R. Devillers');
INSERT INTO "InstAuthPub" VALUES (556, NULL, 'Moon-Jung Chung');
INSERT INTO "InstAuthPub" VALUES (556, NULL, 'Michael Evangelist');
INSERT INTO "InstAuthPub" VALUES (556, NULL, 'Ivan Hal Sudborough');
INSERT INTO "InstAuthPub" VALUES (557, NULL, 'Paul Caspi');
INSERT INTO "InstAuthPub" VALUES (557, NULL, 'Nicolas Halbwachs');
INSERT INTO "InstAuthPub" VALUES (558, NULL, 'Michel Latteux');
INSERT INTO "InstAuthPub" VALUES (558, NULL, 'B. Leguy');
INSERT INTO "InstAuthPub" VALUES (558, NULL, 'B. Ratoandromanana');
INSERT INTO "InstAuthPub" VALUES (559, NULL, 'Dean Jacobs');
INSERT INTO "InstAuthPub" VALUES (559, NULL, 'David Gries');
INSERT INTO "InstAuthPub" VALUES (560, NULL, 'Thomas Ottmann');
INSERT INTO "InstAuthPub" VALUES (560, NULL, 'Michael Schrapp');
INSERT INTO "InstAuthPub" VALUES (560, NULL, 'Derick Wood');
INSERT INTO "InstAuthPub" VALUES (561, NULL, 'Fred B. Schneider');
INSERT INTO "InstAuthPub" VALUES (561, NULL, 'Richard Conway 0003');
INSERT INTO "InstAuthPub" VALUES (561, NULL, 'Dale Skeen');
INSERT INTO "InstAuthPub" VALUES (562, NULL, 'Masahiro Miyakawa');
INSERT INTO "InstAuthPub" VALUES (563, NULL, 'Jörg-Rüdiger Sack');
INSERT INTO "InstAuthPub" VALUES (563, NULL, 'Thomas Strothotte');
INSERT INTO "InstAuthPub" VALUES (564, NULL, 'Balakrishnan Krishnamurthy');
INSERT INTO "InstAuthPub" VALUES (565, NULL, 'Meurig Beynon');
INSERT INTO "InstAuthPub" VALUES (566, NULL, 'A. J. Kfoury');
INSERT INTO "InstAuthPub" VALUES (566, NULL, 'Pawel Urzyczyn');
INSERT INTO "InstAuthPub" VALUES (567, NULL, 'Piotr Rudnicki');
INSERT INTO "InstAuthPub" VALUES (567, NULL, 'Wlodzimierz Drabent');
INSERT INTO "InstAuthPub" VALUES (568, NULL, 'Tsutomu Kamimura');
INSERT INTO "InstAuthPub" VALUES (569, NULL, 'Stephan Heilbrunner');
INSERT INTO "InstAuthPub" VALUES (570, NULL, 'Ali Mili');
INSERT INTO "InstAuthPub" VALUES (570, NULL, 'Jules Desharnais');
INSERT INTO "InstAuthPub" VALUES (570, NULL, 'Jean-Raymond Gagné');
INSERT INTO "InstAuthPub" VALUES (571, NULL, 'Paul E. S. Dunne');
INSERT INTO "InstAuthPub" VALUES (572, NULL, 'Jakob Gonczarowski');
INSERT INTO "InstAuthPub" VALUES (573, NULL, 'Bernhard Möller');
INSERT INTO "InstAuthPub" VALUES (574, NULL, 'Burkhard Monien');
INSERT INTO "InstAuthPub" VALUES (574, NULL, 'Ewald Speckenmeyer');
INSERT INTO "InstAuthPub" VALUES (575, NULL, 'Carlo Meghini');
INSERT INTO "InstAuthPub" VALUES (575, NULL, 'Costantino Thanos');
INSERT INTO "InstAuthPub" VALUES (576, NULL, 'Juraj Hromkovic');
INSERT INTO "InstAuthPub" VALUES (577, NULL, 'Michael Bechtold');
INSERT INTO "InstAuthPub" VALUES (577, NULL, 'Guy Pujolle');
INSERT INTO "InstAuthPub" VALUES (577, NULL, 'Otto Spaniol');
INSERT INTO "InstAuthPub" VALUES (578, NULL, 'Jim Cunningham');
INSERT INTO "InstAuthPub" VALUES (578, NULL, 'A. J. J. Dick');
INSERT INTO "InstAuthPub" VALUES (579, NULL, 'Bernd Reusch');
INSERT INTO "InstAuthPub" VALUES (579, NULL, 'Wolfgang Merzenich');
INSERT INTO "InstAuthPub" VALUES (580, NULL, 'Norishige Chiba');
INSERT INTO "InstAuthPub" VALUES (580, NULL, 'Kazunori Onoguchi');
INSERT INTO "InstAuthPub" VALUES (580, NULL, 'Takao Nishizeki');
INSERT INTO "InstAuthPub" VALUES (581, NULL, 'Jeffrey H. Kingston');
INSERT INTO "InstAuthPub" VALUES (582, NULL, 'Bogdan Rembowski');
INSERT INTO "InstAuthPub" VALUES (583, NULL, 'John L. Bruno');
INSERT INTO "InstAuthPub" VALUES (584, NULL, 'Dung T. Huynh');
INSERT INTO "InstAuthPub" VALUES (585, NULL, 'Timothy A. Budd');
INSERT INTO "InstAuthPub" VALUES (585, NULL, 'Dana Angluin');
INSERT INTO "InstAuthPub" VALUES (586, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (586, NULL, 'Jozef Gruska');
INSERT INTO "InstAuthPub" VALUES (586, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (587, NULL, 'Giora Slutzki');
INSERT INTO "InstAuthPub" VALUES (588, NULL, 'Raúl J. Ramírez');
INSERT INTO "InstAuthPub" VALUES (588, NULL, 'Frank Wm. Tompa');
INSERT INTO "InstAuthPub" VALUES (588, NULL, 'J. Ian Munro');
INSERT INTO "InstAuthPub" VALUES (589, NULL, 'Jean-Marie Nicolas');
INSERT INTO "InstAuthPub" VALUES (590, NULL, 'Jan van Leeuwen');
INSERT INTO "InstAuthPub" VALUES (590, NULL, 'Mark H. Overmars');
INSERT INTO "InstAuthPub" VALUES (591, NULL, 'Donna J. Brown');
INSERT INTO "InstAuthPub" VALUES (591, NULL, 'Brenda S. Baker');
INSERT INTO "InstAuthPub" VALUES (591, NULL, 'Howard P. Katseff');
INSERT INTO "InstAuthPub" VALUES (592, NULL, 'S. O. Anderson');
INSERT INTO "InstAuthPub" VALUES (592, NULL, 'Roland Carl Backhouse');
INSERT INTO "InstAuthPub" VALUES (593, NULL, 'Ashok K. Agrawala');
INSERT INTO "InstAuthPub" VALUES (593, NULL, 'Satish K. Tripathi');
INSERT INTO "InstAuthPub" VALUES (594, NULL, 'Lynn Robert Carter');
INSERT INTO "InstAuthPub" VALUES (595, NULL, 'Ole Eriksen');
INSERT INTO "InstAuthPub" VALUES (595, NULL, 'Jørgen Staunstrup');
INSERT INTO "InstAuthPub" VALUES (596, NULL, 'George W. Ernst');
INSERT INTO "InstAuthPub" VALUES (596, NULL, 'Jainendra K. Navlakha');
INSERT INTO "InstAuthPub" VALUES (596, NULL, 'William F. Ogden');
INSERT INTO "InstAuthPub" VALUES (597, NULL, 'Jean-Pierre Banâtre');
INSERT INTO "InstAuthPub" VALUES (597, NULL, 'Patrice Frison');
INSERT INTO "InstAuthPub" VALUES (597, NULL, 'Patrice Quinton');
INSERT INTO "InstAuthPub" VALUES (598, NULL, 'Robert B. K. Dewar');
INSERT INTO "InstAuthPub" VALUES (598, NULL, 'Susan M. Merritt');
INSERT INTO "InstAuthPub" VALUES (598, NULL, 'Micha Sharir');
INSERT INTO "InstAuthPub" VALUES (599, NULL, 'Philippe Nain');
INSERT INTO "InstAuthPub" VALUES (600, NULL, 'Alberto Pettorossi');
INSERT INTO "InstAuthPub" VALUES (600, NULL, 'Rod M. Burstall');
INSERT INTO "InstAuthPub" VALUES (601, NULL, 'Kenneth J. Supowit');
INSERT INTO "InstAuthPub" VALUES (601, NULL, 'Edward M. Reingold');
INSERT INTO "InstAuthPub" VALUES (602, NULL, 'Narao Nakatsu');
INSERT INTO "InstAuthPub" VALUES (602, NULL, 'Yahiko Kambayashi');
INSERT INTO "InstAuthPub" VALUES (602, NULL, 'Shuzo Yajima');
INSERT INTO "InstAuthPub" VALUES (603, NULL, 'George Markowsky');
INSERT INTO "InstAuthPub" VALUES (604, NULL, 'Manfred P. Stadel');
INSERT INTO "InstAuthPub" VALUES (605, NULL, 'Andrzej Blikle');
INSERT INTO "InstAuthPub" VALUES (606, NULL, 'Dirk Janssens');
INSERT INTO "InstAuthPub" VALUES (606, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (607, NULL, 'Paul Pritchard');
INSERT INTO "InstAuthPub" VALUES (608, NULL, 'Thomas Klingler');
INSERT INTO "InstAuthPub" VALUES (608, NULL, 'Stefan Reisch');
INSERT INTO "InstAuthPub" VALUES (609, NULL, 'Thomas J. Ostrand');
INSERT INTO "InstAuthPub" VALUES (609, NULL, 'Marvin C. Paull');
INSERT INTO "InstAuthPub" VALUES (609, NULL, 'Elaine J. Weyuker');
INSERT INTO "InstAuthPub" VALUES (610, NULL, 'Henk Alblas');
INSERT INTO "InstAuthPub" VALUES (611, NULL, 'Zvi M. Kedem');
INSERT INTO "InstAuthPub" VALUES (611, NULL, 'Abraham Silberschatz');
INSERT INTO "InstAuthPub" VALUES (612, NULL, 'Ernst-Rüdiger Olderog');
INSERT INTO "InstAuthPub" VALUES (613, NULL, 'Leslie M. Goldschlager');
INSERT INTO "InstAuthPub" VALUES (614, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (614, NULL, 'Gilberto Filé');
INSERT INTO "InstAuthPub" VALUES (615, NULL, 'Rolf Schassberger');
INSERT INTO "InstAuthPub" VALUES (616, NULL, 'Zohar Manna');
INSERT INTO "InstAuthPub" VALUES (616, NULL, 'Richard J. Waldinger');
INSERT INTO "InstAuthPub" VALUES (617, NULL, 'Maurice Clint');
INSERT INTO "InstAuthPub" VALUES (618, NULL, 'Trevor I. Fenner');
INSERT INTO "InstAuthPub" VALUES (618, NULL, 'George Loizou');
INSERT INTO "InstAuthPub" VALUES (619, NULL, 'Paul S. Amerins');
INSERT INTO "InstAuthPub" VALUES (619, NULL, 'Ricardo A. Baeza-Yates');
INSERT INTO "InstAuthPub" VALUES (619, NULL, 'Derick Wood');
INSERT INTO "InstAuthPub" VALUES (620, NULL, 'Gheorghe Paun');
INSERT INTO "InstAuthPub" VALUES (621, NULL, 'Ambuj K. Singh');
INSERT INTO "InstAuthPub" VALUES (622, NULL, 'Zohar Manna');
INSERT INTO "InstAuthPub" VALUES (622, NULL, 'Amir Pnueli');
INSERT INTO "InstAuthPub" VALUES (623, NULL, 'Kim Marriott');
INSERT INTO "InstAuthPub" VALUES (624, NULL, 'Thomas Lehmann');
INSERT INTO "InstAuthPub" VALUES (624, NULL, 'Jacques Loeckx');
INSERT INTO "InstAuthPub" VALUES (625, NULL, 'Iain A. Stewart');
INSERT INTO "InstAuthPub" VALUES (626, NULL, 'Alexandru Mateescu');
INSERT INTO "InstAuthPub" VALUES (626, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (627, NULL, 'Xavier Nicollin');
INSERT INTO "InstAuthPub" VALUES (627, NULL, 'Joseph Sifakis');
INSERT INTO "InstAuthPub" VALUES (627, NULL, 'Sergio Yovine');
INSERT INTO "InstAuthPub" VALUES (628, NULL, 'Alexander Tuzhilin');
INSERT INTO "InstAuthPub" VALUES (629, NULL, 'Luc Devroye');
INSERT INTO "InstAuthPub" VALUES (630, NULL, 'K. Narayan Kumar');
INSERT INTO "InstAuthPub" VALUES (630, NULL, 'Paritosh K. Pandya');
INSERT INTO "InstAuthPub" VALUES (631, NULL, 'John Buckle');
INSERT INTO "InstAuthPub" VALUES (632, NULL, 'Julien Cassaigne');
INSERT INTO "InstAuthPub" VALUES (633, NULL, 'Daniel M. Yellin');
INSERT INTO "InstAuthPub" VALUES (634, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (634, NULL, 'Leopold Flatto');
INSERT INTO "InstAuthPub" VALUES (634, NULL, 'Alexander Y. Kreinin');
INSERT INTO "InstAuthPub" VALUES (635, NULL, 'Jan Kratochvíl');
INSERT INTO "InstAuthPub" VALUES (635, NULL, 'Mirko Krivánek');
INSERT INTO "InstAuthPub" VALUES (636, NULL, 'C. A. R. Hoare');
INSERT INTO "InstAuthPub" VALUES (636, NULL, 'Jifeng He');
INSERT INTO "InstAuthPub" VALUES (636, NULL, 'Augusto Sampaio');
INSERT INTO "InstAuthPub" VALUES (637, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (637, NULL, 'Simant Dube');
INSERT INTO "InstAuthPub" VALUES (638, NULL, 'Marisa Navarro');
INSERT INTO "InstAuthPub" VALUES (638, NULL, 'Fernando Orejas');
INSERT INTO "InstAuthPub" VALUES (638, NULL, 'Jean-Luc Remy');
INSERT INTO "InstAuthPub" VALUES (639, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (639, NULL, 'Simant Dube');
INSERT INTO "InstAuthPub" VALUES (640, NULL, 'Y. Daniel Liang');
INSERT INTO "InstAuthPub" VALUES (640, NULL, 'Maw-Shang Chang');
INSERT INTO "InstAuthPub" VALUES (641, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (641, NULL, 'Jan Joris Vereijken');
INSERT INTO "InstAuthPub" VALUES (642, NULL, 'Flavio Corradini');
INSERT INTO "InstAuthPub" VALUES (642, NULL, 'Roberto Gorrieri');
INSERT INTO "InstAuthPub" VALUES (642, NULL, 'Marco Roccetti');
INSERT INTO "InstAuthPub" VALUES (643, NULL, 'Thomas Eiter');
INSERT INTO "InstAuthPub" VALUES (643, NULL, 'Heikki Mannila');
INSERT INTO "InstAuthPub" VALUES (644, NULL, 'Ismo Hakala');
INSERT INTO "InstAuthPub" VALUES (644, NULL, 'Juha Kortelainen');
INSERT INTO "InstAuthPub" VALUES (645, NULL, 'Levent V. Orman');
INSERT INTO "InstAuthPub" VALUES (646, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (646, NULL, 'Jarkko Kari');
INSERT INTO "InstAuthPub" VALUES (647, NULL, 'Henning Fernau');
INSERT INTO "InstAuthPub" VALUES (648, NULL, 'C. Samuel Hsieh');
INSERT INTO "InstAuthPub" VALUES (649, NULL, 'Kenichi Morita');
INSERT INTO "InstAuthPub" VALUES (649, NULL, 'Noritaka Nishihara');
INSERT INTO "InstAuthPub" VALUES (649, NULL, 'Yasunori Yamamoto');
INSERT INTO "InstAuthPub" VALUES (649, NULL, 'Zhiguo Zhang');
INSERT INTO "InstAuthPub" VALUES (650, NULL, 'Vijay K. Garg');
INSERT INTO "InstAuthPub" VALUES (650, NULL, 'Alexander I. Tomlinson');
INSERT INTO "InstAuthPub" VALUES (651, NULL, 'Teodor Rus');
INSERT INTO "InstAuthPub" VALUES (651, NULL, 'Sriram V. Pemmaraju');
INSERT INTO "InstAuthPub" VALUES (652, NULL, 'Javier Esparza');
INSERT INTO "InstAuthPub" VALUES (653, NULL, 'Arnd Rußmann');
INSERT INTO "InstAuthPub" VALUES (654, NULL, 'Ke Wang');
INSERT INTO "InstAuthPub" VALUES (654, NULL, 'Weining Zhang');
INSERT INTO "InstAuthPub" VALUES (654, NULL, 'Siu-Cheung Chau');
INSERT INTO "InstAuthPub" VALUES (655, NULL, 'Georg Trogemann');
INSERT INTO "InstAuthPub" VALUES (655, NULL, 'Matthias Gente');
INSERT INTO "InstAuthPub" VALUES (656, NULL, 'Nieves R. Brisaboa');
INSERT INTO "InstAuthPub" VALUES (656, NULL, 'Héctor J. Hernández');
INSERT INTO "InstAuthPub" VALUES (657, NULL, 'Robert Stephens');
INSERT INTO "InstAuthPub" VALUES (658, NULL, 'Ryszard Janicki');
INSERT INTO "InstAuthPub" VALUES (658, NULL, 'Maciej Koutny');
INSERT INTO "InstAuthPub" VALUES (659, NULL, 'Lane A. Hemaspaandra');
INSERT INTO "InstAuthPub" VALUES (659, NULL, 'Jörg Rothe');
INSERT INTO "InstAuthPub" VALUES (659, NULL, 'Gerd Wechsung');
INSERT INTO "InstAuthPub" VALUES (660, NULL, 'Chi-Chung Hui');
INSERT INTO "InstAuthPub" VALUES (660, NULL, 'Samuel T. Chanson');
INSERT INTO "InstAuthPub" VALUES (661, NULL, 'Flavio Corradini');
INSERT INTO "InstAuthPub" VALUES (661, NULL, 'Rocco De Nicola');
INSERT INTO "InstAuthPub" VALUES (662, NULL, 'Armin B. Cremers');
INSERT INTO "InstAuthPub" VALUES (662, NULL, 'Thomas N. Hibbard');
INSERT INTO "InstAuthPub" VALUES (663, NULL, 'David Pager');
INSERT INTO "InstAuthPub" VALUES (664, NULL, 'Arnold L. Rosenberg');
INSERT INTO "InstAuthPub" VALUES (665, NULL, 'Terrence W. Pratt');
INSERT INTO "InstAuthPub" VALUES (666, NULL, 'Armin B. Cremers');
INSERT INTO "InstAuthPub" VALUES (666, NULL, 'Thomas N. Hibbard');
INSERT INTO "InstAuthPub" VALUES (667, NULL, 'Rudolf Bayer');
INSERT INTO "InstAuthPub" VALUES (667, NULL, 'Mario Schkolnick');
INSERT INTO "InstAuthPub" VALUES (668, NULL, 'Jürgen Avenhaus');
INSERT INTO "InstAuthPub" VALUES (668, NULL, 'Klaus Madlener');
INSERT INTO "InstAuthPub" VALUES (669, NULL, 'Anthony E. Krzesinski');
INSERT INTO "InstAuthPub" VALUES (669, NULL, 'Peter Teunissen');
INSERT INTO "InstAuthPub" VALUES (670, NULL, 'D. T. Lee');
INSERT INTO "InstAuthPub" VALUES (670, NULL, 'C. K. Wong');
INSERT INTO "InstAuthPub" VALUES (671, NULL, 'Peter Deussen');
INSERT INTO "InstAuthPub" VALUES (672, NULL, 'Wilfred J. Hansen');
INSERT INTO "InstAuthPub" VALUES (672, NULL, 'Hendrik Boom');
INSERT INTO "InstAuthPub" VALUES (673, NULL, 'Nissim Francez');
INSERT INTO "InstAuthPub" VALUES (673, NULL, 'Amir Pnueli');
INSERT INTO "InstAuthPub" VALUES (674, NULL, 'Ronald V. Book');
INSERT INTO "InstAuthPub" VALUES (675, NULL, 'Henry S. Warren Jr.');
INSERT INTO "InstAuthPub" VALUES (676, NULL, 'Claus H. Correl');
INSERT INTO "InstAuthPub" VALUES (677, NULL, 'Manfred P. Stadel');
INSERT INTO "InstAuthPub" VALUES (678, NULL, 'Stefan Sokolowski');
INSERT INTO "InstAuthPub" VALUES (679, NULL, 'Jürgen Nehmer');
INSERT INTO "InstAuthPub" VALUES (680, NULL, 'Peter Deussen');
INSERT INTO "InstAuthPub" VALUES (681, NULL, 'Wolfgang K. Giloi');
INSERT INTO "InstAuthPub" VALUES (681, NULL, 'José L. Encarnação');
INSERT INTO "InstAuthPub" VALUES (681, NULL, 'S. Savitt');
INSERT INTO "InstAuthPub" VALUES (682, NULL, 'P. F. Schuler');
INSERT INTO "InstAuthPub" VALUES (683, NULL, 'Peter E. Lauer');
INSERT INTO "InstAuthPub" VALUES (683, NULL, 'Roy H. Campbell');
INSERT INTO "InstAuthPub" VALUES (684, NULL, 'Walter J. Savitch');
INSERT INTO "InstAuthPub" VALUES (685, NULL, 'Peter Kandzia');
INSERT INTO "InstAuthPub" VALUES (686, NULL, 'Luc Boasson');
INSERT INTO "InstAuthPub" VALUES (686, NULL, 'Maurice Nivat');
INSERT INTO "InstAuthPub" VALUES (687, NULL, 'Hans Langmaack');
INSERT INTO "InstAuthPub" VALUES (688, NULL, 'Volker Claus');
INSERT INTO "InstAuthPub" VALUES (689, NULL, 'Per Brinch Hansen');
INSERT INTO "InstAuthPub" VALUES (690, NULL, 'Jeffrey D. Ullman');
INSERT INTO "InstAuthPub" VALUES (691, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (691, NULL, 'Aristid Lindenmayer');
INSERT INTO "InstAuthPub" VALUES (692, NULL, 'Jay Earley');
INSERT INTO "InstAuthPub" VALUES (693, NULL, 'Maurice Clint');
INSERT INTO "InstAuthPub" VALUES (694, NULL, 'Karel Culík');
INSERT INTO "InstAuthPub" VALUES (694, NULL, 'Michael A. Arbib');
INSERT INTO "InstAuthPub" VALUES (695, NULL, 'Luc Boasson');
INSERT INTO "InstAuthPub" VALUES (695, NULL, 'J. P. Crestin');
INSERT INTO "InstAuthPub" VALUES (695, NULL, 'Maurice Nivat');
INSERT INTO "InstAuthPub" VALUES (696, NULL, 'Hans-Dieter Ehrich');
INSERT INTO "InstAuthPub" VALUES (697, NULL, 'Søren Lauesen');
INSERT INTO "InstAuthPub" VALUES (698, NULL, 'Hartmann J. Genrich');
INSERT INTO "InstAuthPub" VALUES (698, NULL, 'Kurt Lautenbach');
INSERT INTO "InstAuthPub" VALUES (699, NULL, 'T. Anderson');
INSERT INTO "InstAuthPub" VALUES (699, NULL, 'J. Eve');
INSERT INTO "InstAuthPub" VALUES (699, NULL, 'James J. Horning');
INSERT INTO "InstAuthPub" VALUES (700, NULL, 'David Gries');
INSERT INTO "InstAuthPub" VALUES (701, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (702, NULL, 'Karl Meinke');
INSERT INTO "InstAuthPub" VALUES (703, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (703, NULL, 'Linda Heyker');
INSERT INTO "InstAuthPub" VALUES (703, NULL, 'George Leih');
INSERT INTO "InstAuthPub" VALUES (704, NULL, 'Richard Hull');
INSERT INTO "InstAuthPub" VALUES (704, NULL, 'Jianwen Su');
INSERT INTO "InstAuthPub" VALUES (705, NULL, 'Gilles Bernot');
INSERT INTO "InstAuthPub" VALUES (705, NULL, 'Michel Bidoit');
INSERT INTO "InstAuthPub" VALUES (705, NULL, 'Teodor Knapik');
INSERT INTO "InstAuthPub" VALUES (706, NULL, 'Joakim von Wright');
INSERT INTO "InstAuthPub" VALUES (707, NULL, 'Astrid Kiehn');
INSERT INTO "InstAuthPub" VALUES (708, NULL, 'Dirk Hauschildt');
INSERT INTO "InstAuthPub" VALUES (708, NULL, 'Matthias Jantzen');
INSERT INTO "InstAuthPub" VALUES (709, NULL, 'Catherine Mongenet');
INSERT INTO "InstAuthPub" VALUES (709, NULL, 'Philippe Clauss');
INSERT INTO "InstAuthPub" VALUES (709, NULL, 'Guy-René Perrin');
INSERT INTO "InstAuthPub" VALUES (710, NULL, 'Gennadi Falin');
INSERT INTO "InstAuthPub" VALUES (710, NULL, 'M. Martìn Dìaz');
INSERT INTO "InstAuthPub" VALUES (710, NULL, 'Jesus R. Artalejo');
INSERT INTO "InstAuthPub" VALUES (711, NULL, 'Riccardo Torlone');
INSERT INTO "InstAuthPub" VALUES (712, NULL, 'Armin Kühnemann');
INSERT INTO "InstAuthPub" VALUES (712, NULL, 'Heiko Vogler');
INSERT INTO "InstAuthPub" VALUES (713, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (713, NULL, 'George Rahonis');
INSERT INTO "InstAuthPub" VALUES (714, NULL, 'Astrid R. Rühl');
INSERT INTO "InstAuthPub" VALUES (715, NULL, 'Volker Diekert');
INSERT INTO "InstAuthPub" VALUES (715, NULL, 'Anca Muscholl');
INSERT INTO "InstAuthPub" VALUES (716, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (716, NULL, 'Paulien ten Pas');
INSERT INTO "InstAuthPub" VALUES (716, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (717, NULL, 'Dana S. Scott');
INSERT INTO "InstAuthPub" VALUES (718, NULL, 'Graham Farr');
INSERT INTO "InstAuthPub" VALUES (719, NULL, 'Gerhard J. Woeginger');
INSERT INTO "InstAuthPub" VALUES (720, NULL, 'Nicoletta De Francesco');
INSERT INTO "InstAuthPub" VALUES (720, NULL, 'Paola Inverardi');
INSERT INTO "InstAuthPub" VALUES (721, NULL, 'Aldo de Luca');
INSERT INTO "InstAuthPub" VALUES (721, NULL, 'Stefano Varricchio');
INSERT INTO "InstAuthPub" VALUES (722, NULL, 'David Spuler');
INSERT INTO "InstAuthPub" VALUES (723, NULL, 'Peter Kirschenhofer');
INSERT INTO "InstAuthPub" VALUES (723, NULL, 'Helmut Prodinger');
INSERT INTO "InstAuthPub" VALUES (724, NULL, 'Uwe Kastens');
INSERT INTO "InstAuthPub" VALUES (724, NULL, 'William M. Waite');
INSERT INTO "InstAuthPub" VALUES (725, NULL, 'José Félix Costa');
INSERT INTO "InstAuthPub" VALUES (725, NULL, 'Amílcar Sernadas');
INSERT INTO "InstAuthPub" VALUES (725, NULL, 'Cristina Sernadas');
INSERT INTO "InstAuthPub" VALUES (726, NULL, 'Jyrki Katajainen');
INSERT INTO "InstAuthPub" VALUES (726, NULL, 'Tomi Pasanen');
INSERT INTO "InstAuthPub" VALUES (727, NULL, 'Christian Ferdinand');
INSERT INTO "InstAuthPub" VALUES (727, NULL, 'Helmut Seidl');
INSERT INTO "InstAuthPub" VALUES (727, NULL, 'Reinhard Wilhelm');
INSERT INTO "InstAuthPub" VALUES (728, NULL, 'Peter E. Lauer');
INSERT INTO "InstAuthPub" VALUES (728, NULL, 'Piero R. Torrigiani');
INSERT INTO "InstAuthPub" VALUES (728, NULL, 'M. W. Shields');
INSERT INTO "InstAuthPub" VALUES (729, NULL, 'Teruo Hikita');
INSERT INTO "InstAuthPub" VALUES (730, NULL, 'Axel van Lamsweerde');
INSERT INTO "InstAuthPub" VALUES (730, NULL, 'Michel Sintzoff');
INSERT INTO "InstAuthPub" VALUES (731, NULL, 'Beate Commentz-Walter');
INSERT INTO "InstAuthPub" VALUES (732, NULL, 'J. W. Cohen');
INSERT INTO "InstAuthPub" VALUES (733, NULL, 'Eljas Soisalon-Soininen');
INSERT INTO "InstAuthPub" VALUES (733, NULL, 'Esko Ukkonen');
INSERT INTO "InstAuthPub" VALUES (734, NULL, 'Hirokazu Nishimura');
INSERT INTO "InstAuthPub" VALUES (735, NULL, 'Warren Burton');
INSERT INTO "InstAuthPub" VALUES (736, NULL, 'Kurt Mehlhorn');
INSERT INTO "InstAuthPub" VALUES (737, NULL, 'Helmut Alt');
INSERT INTO "InstAuthPub" VALUES (738, NULL, 'Ronald V. Book');
INSERT INTO "InstAuthPub" VALUES (739, NULL, 'Donald L. Iglehart');
INSERT INTO "InstAuthPub" VALUES (739, NULL, 'Gerald S. Shedler');
INSERT INTO "InstAuthPub" VALUES (740, NULL, 'Jørgen Steensgaard-Madsen');
INSERT INTO "InstAuthPub" VALUES (741, NULL, 'Sanguthevar Rajasekaran');
INSERT INTO "InstAuthPub" VALUES (741, NULL, 'Sandeep Sen');
INSERT INTO "InstAuthPub" VALUES (742, NULL, 'S. Arun-Kumar');
INSERT INTO "InstAuthPub" VALUES (742, NULL, 'Matthew Hennessy');
INSERT INTO "InstAuthPub" VALUES (743, NULL, 'Emanuela Fachini');
INSERT INTO "InstAuthPub" VALUES (743, NULL, 'Angelo Monti');
INSERT INTO "InstAuthPub" VALUES (743, NULL, 'Margherita Napoli');
INSERT INTO "InstAuthPub" VALUES (743, NULL, 'Domenico Parente');
INSERT INTO "InstAuthPub" VALUES (744, NULL, 'Emanuela Fachini');
INSERT INTO "InstAuthPub" VALUES (744, NULL, 'Andrea Maggiolo-Schettini');
INSERT INTO "InstAuthPub" VALUES (744, NULL, 'Davide Sangiorgi');
INSERT INTO "InstAuthPub" VALUES (745, NULL, 'Adrian Atanasiu');
INSERT INTO "InstAuthPub" VALUES (746, NULL, 'Klaus H. Hinrichs');
INSERT INTO "InstAuthPub" VALUES (746, NULL, 'Jürg Nievergelt');
INSERT INTO "InstAuthPub" VALUES (746, NULL, 'Peter Schorn');
INSERT INTO "InstAuthPub" VALUES (747, NULL, 'Didier Y. Hinz');
INSERT INTO "InstAuthPub" VALUES (748, NULL, 'Leo Marcus');
INSERT INTO "InstAuthPub" VALUES (748, NULL, 'Telis Menas');
INSERT INTO "InstAuthPub" VALUES (749, NULL, 'Charles N. Fischer');
INSERT INTO "InstAuthPub" VALUES (749, NULL, 'Jon Mauney');
INSERT INTO "InstAuthPub" VALUES (750, NULL, 'M. W. Du');
INSERT INTO "InstAuthPub" VALUES (750, NULL, 'S. C. Chang');
INSERT INTO "InstAuthPub" VALUES (751, NULL, 'Aris M. Ouksel');
INSERT INTO "InstAuthPub" VALUES (751, NULL, 'Otto Mayer');
INSERT INTO "InstAuthPub" VALUES (752, NULL, 'Tero Harju');
INSERT INTO "InstAuthPub" VALUES (752, NULL, 'H. C. M. Kleijn');
INSERT INTO "InstAuthPub" VALUES (752, NULL, 'Michel Latteux');
INSERT INTO "InstAuthPub" VALUES (753, NULL, 'Wuxu Peng');
INSERT INTO "InstAuthPub" VALUES (753, NULL, 'S. Purushothaman');
INSERT INTO "InstAuthPub" VALUES (754, NULL, 'Chung-Yee Lee');
INSERT INTO "InstAuthPub" VALUES (754, NULL, 'Surya Danusaputro Liman');
INSERT INTO "InstAuthPub" VALUES (755, NULL, 'Anthony J. Fisher');
INSERT INTO "InstAuthPub" VALUES (756, NULL, 'Andreas Weber');
INSERT INTO "InstAuthPub" VALUES (757, NULL, 'Patrick E. O''Neil');
INSERT INTO "InstAuthPub" VALUES (758, NULL, 'Mogens Nielsen');
INSERT INTO "InstAuthPub" VALUES (758, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (758, NULL, 'P. S. Thiagarajan');
INSERT INTO "InstAuthPub" VALUES (759, NULL, 'Mark B. Josephs');
INSERT INTO "InstAuthPub" VALUES (760, NULL, 'Nicolas Halbwachs');
INSERT INTO "InstAuthPub" VALUES (760, NULL, 'Fabienne Lagnier');
INSERT INTO "InstAuthPub" VALUES (760, NULL, 'Christophe Ratel');
INSERT INTO "InstAuthPub" VALUES (761, NULL, 'Dana S. Richards');
INSERT INTO "InstAuthPub" VALUES (761, NULL, 'Jeffrey S. Salowe');
INSERT INTO "InstAuthPub" VALUES (762, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (762, NULL, 'Linda Heyker');
INSERT INTO "InstAuthPub" VALUES (763, NULL, 'Svante Carlsson');
INSERT INTO "InstAuthPub" VALUES (763, NULL, 'Jingsen Chen');
INSERT INTO "InstAuthPub" VALUES (764, NULL, 'Jos C. M. Baeten');
INSERT INTO "InstAuthPub" VALUES (764, NULL, 'Frits W. Vaandrager');
INSERT INTO "InstAuthPub" VALUES (765, NULL, 'Ricardo A. Baeza-Yates');
INSERT INTO "InstAuthPub" VALUES (765, NULL, 'Walter Cunto');
INSERT INTO "InstAuthPub" VALUES (766, NULL, 'J. Xu');
INSERT INTO "InstAuthPub" VALUES (767, NULL, 'Oliver Schoett');
INSERT INTO "InstAuthPub" VALUES (768, NULL, 'Donald Sannella');
INSERT INTO "InstAuthPub" VALUES (768, NULL, 'Stefan Sokolowski');
INSERT INTO "InstAuthPub" VALUES (768, NULL, 'Andrzej Tarlecki');
INSERT INTO "InstAuthPub" VALUES (769, NULL, 'Peter Roth');
INSERT INTO "InstAuthPub" VALUES (770, NULL, 'Raphael A. Finkel');
INSERT INTO "InstAuthPub" VALUES (770, NULL, 'Jon Louis Bentley');
INSERT INTO "InstAuthPub" VALUES (771, NULL, 'J.-P. Lévy');
INSERT INTO "InstAuthPub" VALUES (772, NULL, 'Yuri Breitbart');
INSERT INTO "InstAuthPub" VALUES (772, NULL, 'Allen Reiter');
INSERT INTO "InstAuthPub" VALUES (773, NULL, 'Mogens Nielsen');
INSERT INTO "InstAuthPub" VALUES (773, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (773, NULL, 'Arto Salomaa');
INSERT INTO "InstAuthPub" VALUES (773, NULL, 'Sven Skyum');
INSERT INTO "InstAuthPub" VALUES (774, NULL, 'Alexandre Brandwajn');
INSERT INTO "InstAuthPub" VALUES (775, NULL, 'Leonidas J. Guibas');
INSERT INTO "InstAuthPub" VALUES (776, NULL, 'Yuri Breitbart');
INSERT INTO "InstAuthPub" VALUES (776, NULL, 'Allen Reiter');
INSERT INTO "InstAuthPub" VALUES (777, NULL, 'Oscar H. Ibarra');
INSERT INTO "InstAuthPub" VALUES (777, NULL, 'Chul E. Kim');
INSERT INTO "InstAuthPub" VALUES (778, NULL, 'Paul M. Zislis');
INSERT INTO "InstAuthPub" VALUES (779, NULL, 'Mogens Nielsen');
INSERT INTO "InstAuthPub" VALUES (780, NULL, 'Jay Earley');
INSERT INTO "InstAuthPub" VALUES (781, NULL, 'Hans-Dieter Ehrich');
INSERT INTO "InstAuthPub" VALUES (782, NULL, 'Shigeru Igarashi');
INSERT INTO "InstAuthPub" VALUES (782, NULL, 'Ralph L. London');
INSERT INTO "InstAuthPub" VALUES (782, NULL, 'David C. Luckham');
INSERT INTO "InstAuthPub" VALUES (783, NULL, 'Guy Fayolle');
INSERT INTO "InstAuthPub" VALUES (783, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (783, NULL, 'Jacques Labetoulle');
INSERT INTO "InstAuthPub" VALUES (783, NULL, 'D. Bastin');
INSERT INTO "InstAuthPub" VALUES (784, NULL, 'Hans-Dieter Ehrich');
INSERT INTO "InstAuthPub" VALUES (785, NULL, 'Olivier Lecarme');
INSERT INTO "InstAuthPub" VALUES (785, NULL, 'Pierre Desjardins');
INSERT INTO "InstAuthPub" VALUES (786, NULL, 'Nabil A. Khabbaz');
INSERT INTO "InstAuthPub" VALUES (787, NULL, 'P. F. Schuler');
INSERT INTO "InstAuthPub" VALUES (788, NULL, 'Alfred Schmitt');
INSERT INTO "InstAuthPub" VALUES (789, NULL, 'Günther E. Pfaff');
INSERT INTO "InstAuthPub" VALUES (790, NULL, 'John P. Kearns');
INSERT INTO "InstAuthPub" VALUES (790, NULL, 'Mary Lou Soffa');
INSERT INTO "InstAuthPub" VALUES (791, NULL, 'Klaus Küspert');
INSERT INTO "InstAuthPub" VALUES (792, NULL, 'Richard N. Taylor');
INSERT INTO "InstAuthPub" VALUES (793, NULL, 'Peter Klein');
INSERT INTO "InstAuthPub" VALUES (793, NULL, 'Friedhelm Meyer auf der Heide');
INSERT INTO "InstAuthPub" VALUES (794, NULL, 'Ichiro Suzuki');
INSERT INTO "InstAuthPub" VALUES (794, NULL, 'Tadao Kasami');
INSERT INTO "InstAuthPub" VALUES (795, NULL, 'Kazuo Iwama');
INSERT INTO "InstAuthPub" VALUES (796, NULL, 'Juraj Hromkovic');
INSERT INTO "InstAuthPub" VALUES (797, NULL, 'Jan A. Bergstra');
INSERT INTO "InstAuthPub" VALUES (797, NULL, 'J. Terlouw');
INSERT INTO "InstAuthPub" VALUES (798, NULL, 'H. T. Kung');
INSERT INTO "InstAuthPub" VALUES (798, NULL, 'Christos H. Papadimitriou');
INSERT INTO "InstAuthPub" VALUES (799, NULL, 'Takao Tsuda');
INSERT INTO "InstAuthPub" VALUES (799, NULL, 'Takashi Sato');
INSERT INTO "InstAuthPub" VALUES (800, NULL, 'Keijo Ruohonen');
INSERT INTO "InstAuthPub" VALUES (801, NULL, 'Ute Schürfeld');
INSERT INTO "InstAuthPub" VALUES (802, NULL, 'Gilberto Filé');
INSERT INTO "InstAuthPub" VALUES (803, NULL, 'Rudolph Sommerhalder');
INSERT INTO "InstAuthPub" VALUES (803, NULL, 'S. Christian van Westrhenen');
INSERT INTO "InstAuthPub" VALUES (804, NULL, 'Moshe Y. Vardi');
INSERT INTO "InstAuthPub" VALUES (805, NULL, 'Philip Heidelberger');
INSERT INTO "InstAuthPub" VALUES (806, NULL, 'Stefan Reisch');
INSERT INTO "InstAuthPub" VALUES (807, NULL, 'Zvi Galil');
INSERT INTO "InstAuthPub" VALUES (808, NULL, 'Bernhard Mescheder');
INSERT INTO "InstAuthPub" VALUES (809, NULL, 'Jörg H. Siekmann');
INSERT INTO "InstAuthPub" VALUES (809, NULL, 'Graham Wrightson');
INSERT INTO "InstAuthPub" VALUES (810, NULL, 'Charles N. Fischer');
INSERT INTO "InstAuthPub" VALUES (810, NULL, 'D. R. Milton');
INSERT INTO "InstAuthPub" VALUES (810, NULL, 'S. B. Quiring');
INSERT INTO "InstAuthPub" VALUES (811, NULL, 'Jon Louis Bentley');
INSERT INTO "InstAuthPub" VALUES (811, NULL, 'Hermann A. Maurer');
INSERT INTO "InstAuthPub" VALUES (812, NULL, 'Hermann A. Maurer');
INSERT INTO "InstAuthPub" VALUES (812, NULL, 'Maurice Nivat');
INSERT INTO "InstAuthPub" VALUES (813, NULL, 'Johannes Röhrich');
INSERT INTO "InstAuthPub" VALUES (814, NULL, 'Uwe Kastens');
INSERT INTO "InstAuthPub" VALUES (815, NULL, 'Frank Wm. Tompa');
INSERT INTO "InstAuthPub" VALUES (816, NULL, 'Hans-Anton Rollik');
INSERT INTO "InstAuthPub" VALUES (817, NULL, 'Gaston H. Gonnet');
INSERT INTO "InstAuthPub" VALUES (817, NULL, 'Lawrence D. Rogers');
INSERT INTO "InstAuthPub" VALUES (817, NULL, 'J. Alan George');
INSERT INTO "InstAuthPub" VALUES (818, NULL, 'Chandra M. R. Kintala');
INSERT INTO "InstAuthPub" VALUES (818, NULL, 'Detlef Wotschke');
INSERT INTO "InstAuthPub" VALUES (819, NULL, 'Alfs T. Berztiss');
INSERT INTO "InstAuthPub" VALUES (820, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (820, NULL, 'Derick Wood');
INSERT INTO "InstAuthPub" VALUES (821, NULL, 'William R. Franta');
INSERT INTO "InstAuthPub" VALUES (821, NULL, 'Mark Benedict Bilodeau');
INSERT INTO "InstAuthPub" VALUES (822, NULL, 'Ingo Wegener');
INSERT INTO "InstAuthPub" VALUES (823, NULL, 'Hans Kleine Büning');
INSERT INTO "InstAuthPub" VALUES (823, NULL, 'Lutz Priese');
INSERT INTO "InstAuthPub" VALUES (824, NULL, 'Chen-Ming Fan');
INSERT INTO "InstAuthPub" VALUES (824, NULL, 'Cheng-Chih Huang');
INSERT INTO "InstAuthPub" VALUES (824, NULL, 'Huei-Jan Shyr');
INSERT INTO "InstAuthPub" VALUES (824, NULL, 'Kuo-Hsiang Chen');
INSERT INTO "InstAuthPub" VALUES (825, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (826, NULL, 'Mohammad Mahdi Jaghoori');
INSERT INTO "InstAuthPub" VALUES (826, NULL, 'Marjan Sirjani');
INSERT INTO "InstAuthPub" VALUES (826, NULL, 'Mohammad Reza Mousavi');
INSERT INTO "InstAuthPub" VALUES (826, NULL, 'Ehsan Khamespanah');
INSERT INTO "InstAuthPub" VALUES (826, NULL, 'Ali Movaghar');
INSERT INTO "InstAuthPub" VALUES (827, NULL, 'Remco Loos');
INSERT INTO "InstAuthPub" VALUES (827, NULL, 'Florin Manea');
INSERT INTO "InstAuthPub" VALUES (827, NULL, 'Victor Mitrana');
INSERT INTO "InstAuthPub" VALUES (828, NULL, 'Mingsheng Ying');
INSERT INTO "InstAuthPub" VALUES (828, NULL, 'Yuan Feng');
INSERT INTO "InstAuthPub" VALUES (829, NULL, 'Christian Dax');
INSERT INTO "InstAuthPub" VALUES (829, NULL, 'Felix Klaedtke');
INSERT INTO "InstAuthPub" VALUES (829, NULL, 'Martin Lange');
INSERT INTO "InstAuthPub" VALUES (830, NULL, 'Martin Kutrib');
INSERT INTO "InstAuthPub" VALUES (830, NULL, 'Hartmut Messerschmidt');
INSERT INTO "InstAuthPub" VALUES (830, NULL, 'Friedrich Otto');
INSERT INTO "InstAuthPub" VALUES (831, NULL, 'Peter Habermehl');
INSERT INTO "InstAuthPub" VALUES (831, NULL, 'Radu Iosif');
INSERT INTO "InstAuthPub" VALUES (831, NULL, 'Tomás Vojnar');
INSERT INTO "InstAuthPub" VALUES (832, NULL, 'Dorit S. Hochbaum');
INSERT INTO "InstAuthPub" VALUES (832, NULL, 'Asaf Levin');
INSERT INTO "InstAuthPub" VALUES (833, NULL, 'Shlomi Dolev');
INSERT INTO "InstAuthPub" VALUES (833, NULL, 'Nir Tzachar');
INSERT INTO "InstAuthPub" VALUES (834, NULL, 'Serge Haddad');
INSERT INTO "InstAuthPub" VALUES (834, NULL, 'Denis Poitrenaud');
INSERT INTO "InstAuthPub" VALUES (835, NULL, 'Vesa Halava');
INSERT INTO "InstAuthPub" VALUES (835, NULL, 'Mika Hirvensalo');
INSERT INTO "InstAuthPub" VALUES (836, NULL, 'Foto N. Afrati');
INSERT INTO "InstAuthPub" VALUES (836, NULL, 'Rada Chirkova');
INSERT INTO "InstAuthPub" VALUES (836, NULL, 'Manolis Gergatsoulis');
INSERT INTO "InstAuthPub" VALUES (836, NULL, 'Vassia Pavlaki');
INSERT INTO "InstAuthPub" VALUES (837, NULL, 'Yiwei Jiang');
INSERT INTO "InstAuthPub" VALUES (837, NULL, 'Yong He');
INSERT INTO "InstAuthPub" VALUES (838, NULL, 'Jan A. Bergstra');
INSERT INTO "InstAuthPub" VALUES (838, NULL, 'C. A. Middelburg');
INSERT INTO "InstAuthPub" VALUES (839, NULL, 'Joseph M. Morris');
INSERT INTO "InstAuthPub" VALUES (839, NULL, 'Malcolm Tyrrell');
INSERT INTO "InstAuthPub" VALUES (840, NULL, 'Ladislav Vagner');
INSERT INTO "InstAuthPub" VALUES (840, NULL, 'Borivoj Melichar');
INSERT INTO "InstAuthPub" VALUES (841, NULL, 'Rachele Fuzzati');
INSERT INTO "InstAuthPub" VALUES (841, NULL, 'Massimo Merro');
INSERT INTO "InstAuthPub" VALUES (841, NULL, 'Uwe Nestmann');
INSERT INTO "InstAuthPub" VALUES (842, NULL, 'Naomi Nishimura');
INSERT INTO "InstAuthPub" VALUES (842, NULL, 'Prabhakar Ragde');
INSERT INTO "InstAuthPub" VALUES (842, NULL, 'Stefan Szeider');
INSERT INTO "InstAuthPub" VALUES (843, NULL, 'Tian-Shyr Dai');
INSERT INTO "InstAuthPub" VALUES (843, NULL, 'Yuh-Dauh Lyuu');
INSERT INTO "InstAuthPub" VALUES (844, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (845, NULL, 'Ladislav Vagner');
INSERT INTO "InstAuthPub" VALUES (845, NULL, 'Borivoj Melichar');
INSERT INTO "InstAuthPub" VALUES (846, NULL, 'Jan A. Bergstra');
INSERT INTO "InstAuthPub" VALUES (846, NULL, 'Inge Bethke');
INSERT INTO "InstAuthPub" VALUES (846, NULL, 'Alban Ponse');
INSERT INTO "InstAuthPub" VALUES (847, NULL, 'Markus Büttner');
INSERT INTO "InstAuthPub" VALUES (848, NULL, 'Naoki Kobayashi 0001');
INSERT INTO "InstAuthPub" VALUES (849, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (849, NULL, 'Antonios Kalampakas');
INSERT INTO "InstAuthPub" VALUES (850, NULL, 'Lars Jacobsen');
INSERT INTO "InstAuthPub" VALUES (850, NULL, 'Kim S. Larsen');
INSERT INTO "InstAuthPub" VALUES (851, NULL, 'Mila E. Majster-Cederbaum');
INSERT INTO "InstAuthPub" VALUES (851, NULL, 'Jinzhao Wu');
INSERT INTO "InstAuthPub" VALUES (851, NULL, 'Houguang Yue');
INSERT INTO "InstAuthPub" VALUES (852, NULL, 'Simon J. Gay');
INSERT INTO "InstAuthPub" VALUES (852, NULL, 'Malcolm Hole');
INSERT INTO "InstAuthPub" VALUES (853, NULL, 'Martin Berger');
INSERT INTO "InstAuthPub" VALUES (853, NULL, 'Kohei Honda');
INSERT INTO "InstAuthPub" VALUES (853, NULL, 'Nobuko Yoshida');
INSERT INTO "InstAuthPub" VALUES (854, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (855, NULL, 'Srecko Brlek');
INSERT INTO "InstAuthPub" VALUES (855, NULL, 'Elisa Pergola');
INSERT INTO "InstAuthPub" VALUES (855, NULL, 'Olivier Roques');
INSERT INTO "InstAuthPub" VALUES (856, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (857, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (857, NULL, 'Tamir Tassa');
INSERT INTO "InstAuthPub" VALUES (858, NULL, 'Matthew Hennessy');
INSERT INTO "InstAuthPub" VALUES (858, NULL, 'Julian Rathke');
INSERT INTO "InstAuthPub" VALUES (858, NULL, 'Nobuko Yoshida');
INSERT INTO "InstAuthPub" VALUES (859, NULL, 'Lorenzo Bettini');
INSERT INTO "InstAuthPub" VALUES (859, NULL, 'Betti Venneri');
INSERT INTO "InstAuthPub" VALUES (859, NULL, 'Viviana Bono');
INSERT INTO "InstAuthPub" VALUES (860, NULL, 'Andrzej Ehrenfeucht');
INSERT INTO "InstAuthPub" VALUES (860, NULL, 'Tero Harju');
INSERT INTO "InstAuthPub" VALUES (860, NULL, 'Grzegorz Rozenberg');
INSERT INTO "InstAuthPub" VALUES (861, NULL, 'Ferucio Laurentiu Tiplea');
INSERT INTO "InstAuthPub" VALUES (861, NULL, 'Constantin Enea');
INSERT INTO "InstAuthPub" VALUES (862, NULL, 'Zoltán Ésik');
INSERT INTO "InstAuthPub" VALUES (862, NULL, 'Michael Bertol');
INSERT INTO "InstAuthPub" VALUES (863, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (863, NULL, 'Wojciech Fraczak');
INSERT INTO "InstAuthPub" VALUES (863, NULL, 'Richard P. Hopkins');
INSERT INTO "InstAuthPub" VALUES (863, NULL, 'Hanna Klaudel');
INSERT INTO "InstAuthPub" VALUES (863, NULL, 'Elisabeth Pelz');
INSERT INTO "InstAuthPub" VALUES (864, NULL, 'Hsu-Chun Yen');
INSERT INTO "InstAuthPub" VALUES (865, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (865, NULL, 'Tjalling Gelsema');
INSERT INTO "InstAuthPub" VALUES (866, NULL, 'Beverly A. Sanders');
INSERT INTO "InstAuthPub" VALUES (867, NULL, 'Wenceslas Fernandez de la Vega');
INSERT INTO "InstAuthPub" VALUES (867, NULL, 'Vangelis Th. Paschos');
INSERT INTO "InstAuthPub" VALUES (867, NULL, 'Andreas Stafylopatis');
INSERT INTO "InstAuthPub" VALUES (868, NULL, 'Hsien-Kuei Hwang');
INSERT INTO "InstAuthPub" VALUES (869, NULL, 'Juha Honkala');
INSERT INTO "InstAuthPub" VALUES (870, NULL, 'Shmuel Sagiv');
INSERT INTO "InstAuthPub" VALUES (870, NULL, 'Nissim Francez');
INSERT INTO "InstAuthPub" VALUES (870, NULL, 'Michael Rodeh');
INSERT INTO "InstAuthPub" VALUES (870, NULL, 'Reinhard Wilhelm');
INSERT INTO "InstAuthPub" VALUES (871, NULL, 'Chen-Ming Fan');
INSERT INTO "InstAuthPub" VALUES (871, NULL, 'Huei-Jan Shyr');
INSERT INTO "InstAuthPub" VALUES (871, NULL, 'Shyr-Shen Yu');
INSERT INTO "InstAuthPub" VALUES (872, NULL, 'Vincent D. Blondel');
INSERT INTO "InstAuthPub" VALUES (873, NULL, 'Alistair Moffat');
INSERT INTO "InstAuthPub" VALUES (873, NULL, 'Ola Petersson');
INSERT INTO "InstAuthPub" VALUES (873, NULL, 'Nicholas C. Wormald');
INSERT INTO "InstAuthPub" VALUES (874, NULL, 'Huei-Jan Shyr');
INSERT INTO "InstAuthPub" VALUES (874, NULL, 'Shyr-Shen Yu');
INSERT INTO "InstAuthPub" VALUES (875, NULL, 'Hing Leung');
INSERT INTO "InstAuthPub" VALUES (876, NULL, 'Michele Boreale');
INSERT INTO "InstAuthPub" VALUES (876, NULL, 'Davide Sangiorgi');
INSERT INTO "InstAuthPub" VALUES (877, NULL, 'Elvira Locuratolo');
INSERT INTO "InstAuthPub" VALUES (877, NULL, 'Fausto Rabitti');
INSERT INTO "InstAuthPub" VALUES (878, NULL, 'Jan Van den Bussche');
INSERT INTO "InstAuthPub" VALUES (878, NULL, 'Luca Cabibbo');
INSERT INTO "InstAuthPub" VALUES (879, NULL, 'Danièle Beauquier');
INSERT INTO "InstAuthPub" VALUES (879, NULL, 'Anatol Slissenko');
INSERT INTO "InstAuthPub" VALUES (880, NULL, 'Lex Bijlsma');
INSERT INTO "InstAuthPub" VALUES (880, NULL, 'Rob Nederpelt');
INSERT INTO "InstAuthPub" VALUES (881, NULL, 'Alexander Moshe Rabinovich');
INSERT INTO "InstAuthPub" VALUES (882, NULL, 'Nicoletta De Francesco');
INSERT INTO "InstAuthPub" VALUES (882, NULL, 'Antonella Santone');
INSERT INTO "InstAuthPub" VALUES (883, NULL, 'Kim S. Larsen');
INSERT INTO "InstAuthPub" VALUES (884, NULL, 'Edward Y. C. Cheng');
INSERT INTO "InstAuthPub" VALUES (884, NULL, 'Michael Kaminski');
INSERT INTO "InstAuthPub" VALUES (885, NULL, 'Eric Sanlaville');
INSERT INTO "InstAuthPub" VALUES (885, NULL, 'Günter Schmidt');
INSERT INTO "InstAuthPub" VALUES (886, NULL, 'Thomas Buchholz');
INSERT INTO "InstAuthPub" VALUES (886, NULL, 'Martin Kutrib');
INSERT INTO "InstAuthPub" VALUES (887, NULL, 'Ralph-Johan Back');
INSERT INTO "InstAuthPub" VALUES (887, NULL, 'Qiwen Xu');
INSERT INTO "InstAuthPub" VALUES (888, NULL, 'Rob van Stee');
INSERT INTO "InstAuthPub" VALUES (888, NULL, 'Johannes A. La Poutré');
INSERT INTO "InstAuthPub" VALUES (889, NULL, 'Annabelle McIver');
INSERT INTO "InstAuthPub" VALUES (889, NULL, 'Carroll Morgan');
INSERT INTO "InstAuthPub" VALUES (890, NULL, 'Changwook Kim');
INSERT INTO "InstAuthPub" VALUES (891, NULL, 'Ferucio Laurentiu Tiplea');
INSERT INTO "InstAuthPub" VALUES (891, NULL, 'Erkki Mäkinen');
INSERT INTO "InstAuthPub" VALUES (891, NULL, 'Corina Apachite');
INSERT INTO "InstAuthPub" VALUES (892, NULL, 'Jan Ramon');
INSERT INTO "InstAuthPub" VALUES (892, NULL, 'Maurice Bruynooghe');
INSERT INTO "InstAuthPub" VALUES (893, NULL, 'Henning Fernau');
INSERT INTO "InstAuthPub" VALUES (894, NULL, 'Kim S. Larsen');
INSERT INTO "InstAuthPub" VALUES (894, NULL, 'Thomas Ottmann');
INSERT INTO "InstAuthPub" VALUES (894, NULL, 'Eljas Soisalon-Soininen');
INSERT INTO "InstAuthPub" VALUES (895, NULL, 'Laurent Alonso');
INSERT INTO "InstAuthPub" VALUES (895, NULL, 'René Schott');
INSERT INTO "InstAuthPub" VALUES (896, NULL, 'Desh Ranjan');
INSERT INTO "InstAuthPub" VALUES (896, NULL, 'Enrico Pontelli');
INSERT INTO "InstAuthPub" VALUES (896, NULL, 'Gopal Gupta');
INSERT INTO "InstAuthPub" VALUES (897, NULL, 'Egidio Astesiano');
INSERT INTO "InstAuthPub" VALUES (897, NULL, 'Gianna Reggio');
INSERT INTO "InstAuthPub" VALUES (898, NULL, 'Manfred Broy');
INSERT INTO "InstAuthPub" VALUES (899, NULL, 'Danny Dubé');
INSERT INTO "InstAuthPub" VALUES (899, NULL, 'Marc Feeley');
INSERT INTO "InstAuthPub" VALUES (900, NULL, 'Hendrik Jan Hoogeboom');
INSERT INTO "InstAuthPub" VALUES (900, NULL, 'Nike van Vugt');
INSERT INTO "InstAuthPub" VALUES (901, NULL, 'Béatrice Bérard');
INSERT INTO "InstAuthPub" VALUES (901, NULL, 'Claudine Picaronny');
INSERT INTO "InstAuthPub" VALUES (902, NULL, 'Rob J. van Glabbeek');
INSERT INTO "InstAuthPub" VALUES (902, NULL, 'Ursula Goltz');
INSERT INTO "InstAuthPub" VALUES (903, NULL, 'Luc Moreau');
INSERT INTO "InstAuthPub" VALUES (903, NULL, 'Jean Duprat');
INSERT INTO "InstAuthPub" VALUES (904, NULL, 'Ram Chakka');
INSERT INTO "InstAuthPub" VALUES (904, NULL, 'Peter G. Harrison');
INSERT INTO "InstAuthPub" VALUES (905, NULL, 'Philippe Chanzy');
INSERT INTO "InstAuthPub" VALUES (905, NULL, 'Luc Devroye');
INSERT INTO "InstAuthPub" VALUES (905, NULL, 'Carlos Zamora-Cura');
INSERT INTO "InstAuthPub" VALUES (906, NULL, 'Bo-Ting Yang');
INSERT INTO "InstAuthPub" VALUES (906, NULL, 'Paul Gillard');
INSERT INTO "InstAuthPub" VALUES (907, NULL, 'Youichi Kobuchi');
INSERT INTO "InstAuthPub" VALUES (907, NULL, 'Takashi Saito');
INSERT INTO "InstAuthPub" VALUES (907, NULL, 'Hidenobu Nunome');
INSERT INTO "InstAuthPub" VALUES (908, NULL, 'John Aycock');
INSERT INTO "InstAuthPub" VALUES (908, NULL, 'R. Nigel Horspool');
INSERT INTO "InstAuthPub" VALUES (908, NULL, 'Jan Janousek');
INSERT INTO "InstAuthPub" VALUES (908, NULL, 'Borivoj Melichar');
INSERT INTO "InstAuthPub" VALUES (909, NULL, 'Carroll Morgan');
INSERT INTO "InstAuthPub" VALUES (909, NULL, 'Paul H. B. Gardiner');
INSERT INTO "InstAuthPub" VALUES (910, NULL, 'Mark H. Overmars');
INSERT INTO "InstAuthPub" VALUES (910, NULL, 'Michiel H. M. Smid');
INSERT INTO "InstAuthPub" VALUES (910, NULL, 'Mark de Berg');
INSERT INTO "InstAuthPub" VALUES (910, NULL, 'Marc J. van Kreveld');
INSERT INTO "InstAuthPub" VALUES (911, NULL, 'Kung-Kiu Lau');
INSERT INTO "InstAuthPub" VALUES (912, NULL, 'A. Michael Berman');
INSERT INTO "InstAuthPub" VALUES (912, NULL, 'Marvin C. Paull');
INSERT INTO "InstAuthPub" VALUES (912, NULL, 'Barbara G. Ryder');
INSERT INTO "InstAuthPub" VALUES (913, NULL, 'Lawrence T. Kou');
INSERT INTO "InstAuthPub" VALUES (914, NULL, 'Demetres D. Kouvatsos');
INSERT INTO "InstAuthPub" VALUES (914, NULL, 'Nasreddine Tabet-Aouel');
INSERT INTO "InstAuthPub" VALUES (915, NULL, 'Michiel H. M. Smid');
INSERT INTO "InstAuthPub" VALUES (915, NULL, 'Mark H. Overmars');
INSERT INTO "InstAuthPub" VALUES (916, NULL, 'John-Jules Ch. Meyer');
INSERT INTO "InstAuthPub" VALUES (916, NULL, 'Ernst-Rüdiger Olderog');
INSERT INTO "InstAuthPub" VALUES (917, NULL, 'Rance Cleaveland');
INSERT INTO "InstAuthPub" VALUES (918, NULL, 'Vernon Rego');
INSERT INTO "InstAuthPub" VALUES (919, NULL, 'Betty Salzberg');
INSERT INTO "InstAuthPub" VALUES (920, NULL, 'Carl Langenhop');
INSERT INTO "InstAuthPub" VALUES (920, NULL, 'William E. Wright');
INSERT INTO "InstAuthPub" VALUES (921, NULL, 'Dirk Taubner');
INSERT INTO "InstAuthPub" VALUES (921, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (922, NULL, 'Henk Alblas');
INSERT INTO "InstAuthPub" VALUES (923, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (923, NULL, 'Juhani Karhumäki');
INSERT INTO "InstAuthPub" VALUES (924, NULL, 'Erol Gelenbe');
INSERT INTO "InstAuthPub" VALUES (924, NULL, 'Marisela Hernández');
INSERT INTO "InstAuthPub" VALUES (925, NULL, 'Ralph-Johan Back');
INSERT INTO "InstAuthPub" VALUES (925, NULL, 'Joakim von Wright');
INSERT INTO "InstAuthPub" VALUES (926, NULL, 'Friedrich L. Bauer');
INSERT INTO "InstAuthPub" VALUES (927, NULL, 'Wladyslaw M. Turski');
INSERT INTO "InstAuthPub" VALUES (928, NULL, 'Andreas Weber');
INSERT INTO "InstAuthPub" VALUES (929, NULL, 'Harald Søndergaard');
INSERT INTO "InstAuthPub" VALUES (929, NULL, 'Peter Sestoft');
INSERT INTO "InstAuthPub" VALUES (930, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (931, NULL, 'Chua-Huang Huang');
INSERT INTO "InstAuthPub" VALUES (931, NULL, 'Christian Lengauer');
INSERT INTO "InstAuthPub" VALUES (932, NULL, 'Mohamed G. Gouda');
INSERT INTO "InstAuthPub" VALUES (932, NULL, 'Rodney R. Howell');
INSERT INTO "InstAuthPub" VALUES (932, NULL, 'Louis E. Rosier');
INSERT INTO "InstAuthPub" VALUES (933, NULL, 'Giuseppe Della Penna');
INSERT INTO "InstAuthPub" VALUES (933, NULL, 'Benedetto Intrigila');
INSERT INTO "InstAuthPub" VALUES (933, NULL, 'Enrico Tronci');
INSERT INTO "InstAuthPub" VALUES (933, NULL, 'Marisa Venturini Zilli');
INSERT INTO "InstAuthPub" VALUES (934, NULL, 'Ján Gaso');
INSERT INTO "InstAuthPub" VALUES (934, NULL, 'Martin Nehéz');
INSERT INTO "InstAuthPub" VALUES (935, NULL, 'Pedro V. Silva');
INSERT INTO "InstAuthPub" VALUES (936, NULL, 'Alexander Meduna');
INSERT INTO "InstAuthPub" VALUES (937, NULL, 'Stéphane Coulondre');
INSERT INTO "InstAuthPub" VALUES (938, NULL, 'Mila E. Majster-Cederbaum');
INSERT INTO "InstAuthPub" VALUES (938, NULL, 'Jinzhao Wu');
INSERT INTO "InstAuthPub" VALUES (939, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (940, NULL, 'Wim H. Hesselink');
INSERT INTO "InstAuthPub" VALUES (941, NULL, 'James D. Currie');
INSERT INTO "InstAuthPub" VALUES (941, NULL, 'Erica Moodie');
INSERT INTO "InstAuthPub" VALUES (942, NULL, 'Alfredo Burrieza');
INSERT INTO "InstAuthPub" VALUES (942, NULL, 'Inman P. de Guzmán');
INSERT INTO "InstAuthPub" VALUES (943, NULL, 'Mingsheng Ying');
INSERT INTO "InstAuthPub" VALUES (944, NULL, 'Edward G. Coffman Jr.');
INSERT INTO "InstAuthPub" VALUES (944, NULL, 'Jay Sethuraman');
INSERT INTO "InstAuthPub" VALUES (944, NULL, 'Vadim G. Timkovsky');
INSERT INTO "InstAuthPub" VALUES (945, NULL, 'Bartek Kiepuszewski');
INSERT INTO "InstAuthPub" VALUES (945, NULL, 'Arthur H. M. ter Hofstede');
INSERT INTO "InstAuthPub" VALUES (945, NULL, 'Wil M. P. van der Aalst');
INSERT INTO "InstAuthPub" VALUES (946, NULL, 'Joachim Biskup');
INSERT INTO "InstAuthPub" VALUES (946, NULL, 'Torsten Polle');
INSERT INTO "InstAuthPub" VALUES (947, NULL, 'Wolfgang Reisig');
INSERT INTO "InstAuthPub" VALUES (948, NULL, 'Ralf Hartmut Güting');
INSERT INTO "InstAuthPub" VALUES (949, NULL, 'Clement H. C. Leung');
INSERT INTO "InstAuthPub" VALUES (949, NULL, 'Qui Hoon Choo');
INSERT INTO "InstAuthPub" VALUES (950, NULL, 'Norbert Blum');
INSERT INTO "InstAuthPub" VALUES (950, NULL, 'Martin Seysen');
INSERT INTO "InstAuthPub" VALUES (951, NULL, 'Christian Choffrut');
INSERT INTO "InstAuthPub" VALUES (951, NULL, 'Karel Culik II');
INSERT INTO "InstAuthPub" VALUES (952, NULL, 'Matthew Hennessy');
INSERT INTO "InstAuthPub" VALUES (953, NULL, 'Luc Devroye');
INSERT INTO "InstAuthPub" VALUES (954, NULL, 'N. P. Chapman');
INSERT INTO "InstAuthPub" VALUES (955, NULL, 'G. Bauer');
INSERT INTO "InstAuthPub" VALUES (955, NULL, 'Friedrich Otto');
INSERT INTO "InstAuthPub" VALUES (956, NULL, 'Gerardo Costa');
INSERT INTO "InstAuthPub" VALUES (956, NULL, 'Colin Stirling');
INSERT INTO "InstAuthPub" VALUES (957, NULL, 'Rudolf Bayer');
INSERT INTO "InstAuthPub" VALUES (957, NULL, 'Peter Schlichtiger');
INSERT INTO "InstAuthPub" VALUES (958, NULL, 'William E. Wright');
INSERT INTO "InstAuthPub" VALUES (959, NULL, 'Athanasios K. Tsakalidis');
INSERT INTO "InstAuthPub" VALUES (960, NULL, 'Stefan Hertel');
INSERT INTO "InstAuthPub" VALUES (960, NULL, 'Martti Mäntylä');
INSERT INTO "InstAuthPub" VALUES (960, NULL, 'Kurt Mehlhorn');
INSERT INTO "InstAuthPub" VALUES (960, NULL, 'Jürg Nievergelt');
INSERT INTO "InstAuthPub" VALUES (961, NULL, 'Oscar H. Ibarra');
INSERT INTO "InstAuthPub" VALUES (961, NULL, 'Sam M. Kim');
INSERT INTO "InstAuthPub" VALUES (962, NULL, 'Jayme Luiz Szwarcfiter');
INSERT INTO "InstAuthPub" VALUES (963, NULL, 'Marina C. Chen');
INSERT INTO "InstAuthPub" VALUES (963, NULL, 'Martin Rem');
INSERT INTO "InstAuthPub" VALUES (964, NULL, 'Richard S. Bird');
INSERT INTO "InstAuthPub" VALUES (965, NULL, 'Eike Best');
INSERT INTO "InstAuthPub" VALUES (965, NULL, 'Klaus Voss');
INSERT INTO "InstAuthPub" VALUES (966, NULL, 'Pierre Deransart');
INSERT INTO "InstAuthPub" VALUES (966, NULL, 'Martin Jourdan');
INSERT INTO "InstAuthPub" VALUES (966, NULL, 'Bernard Lorho');
INSERT INTO "InstAuthPub" VALUES (967, NULL, 'Donald Sannella');
INSERT INTO "InstAuthPub" VALUES (968, NULL, 'Donald L. Iglehart');
INSERT INTO "InstAuthPub" VALUES (968, NULL, 'Gerald S. Shedler');
INSERT INTO "InstAuthPub" VALUES (969, NULL, 'Howard Barringer');
INSERT INTO "InstAuthPub" VALUES (969, NULL, 'J. H. Cheng');
INSERT INTO "InstAuthPub" VALUES (969, NULL, 'Cliff B. Jones');
INSERT INTO "InstAuthPub" VALUES (970, NULL, 'Shou-Hsuan Stephen Huang');
INSERT INTO "InstAuthPub" VALUES (970, NULL, 'C. K. Wong');
INSERT INTO "InstAuthPub" VALUES (971, NULL, 'Antonín Kucera');
INSERT INTO "InstAuthPub" VALUES (971, NULL, 'Jan Strejcek');
INSERT INTO "InstAuthPub" VALUES (972, NULL, 'Gerth Stølting Brodal');
INSERT INTO "InstAuthPub" VALUES (972, NULL, 'Erik D. Demaine');
INSERT INTO "InstAuthPub" VALUES (972, NULL, 'J. Ian Munro');
INSERT INTO "InstAuthPub" VALUES (973, NULL, 'Kamilla Klonowska');
INSERT INTO "InstAuthPub" VALUES (973, NULL, 'Håkan Lennerstad');
INSERT INTO "InstAuthPub" VALUES (973, NULL, 'Lars Lundberg');
INSERT INTO "InstAuthPub" VALUES (973, NULL, 'Charlie Svahnberg');
INSERT INTO "InstAuthPub" VALUES (974, NULL, 'Alexander Grigoriev');
INSERT INTO "InstAuthPub" VALUES (974, NULL, 'Gerhard J. Woeginger');
INSERT INTO "InstAuthPub" VALUES (975, NULL, 'Yiwei Jiang');
INSERT INTO "InstAuthPub" VALUES (975, NULL, 'Yong He');
INSERT INTO "InstAuthPub" VALUES (976, NULL, 'Dominic Duggan');
INSERT INTO "InstAuthPub" VALUES (977, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (978, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (979, NULL, 'Michael G. Lamoureux');
INSERT INTO "InstAuthPub" VALUES (979, NULL, 'Bradford G. Nickerson');
INSERT INTO "InstAuthPub" VALUES (980, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (980, NULL, 'Rob van Stee');
INSERT INTO "InstAuthPub" VALUES (981, NULL, 'Erzsébet Csuhaj-Varjú');
INSERT INTO "InstAuthPub" VALUES (981, NULL, 'Carlos Martín-Vide');
INSERT INTO "InstAuthPub" VALUES (981, NULL, 'Victor Mitrana');
INSERT INTO "InstAuthPub" VALUES (982, NULL, 'Ingo Schmitt');
INSERT INTO "InstAuthPub" VALUES (982, NULL, 'Gunter Saake');
INSERT INTO "InstAuthPub" VALUES (983, NULL, 'Mingsheng Ying');
INSERT INTO "InstAuthPub" VALUES (984, NULL, 'Yifeng Chen');
INSERT INTO "InstAuthPub" VALUES (984, NULL, 'Jeff W. Sanders');
INSERT INTO "InstAuthPub" VALUES (985, NULL, 'Artiom Alhazov');
INSERT INTO "InstAuthPub" VALUES (985, NULL, 'Linqiang Pan');
INSERT INTO "InstAuthPub" VALUES (985, NULL, 'Gheorghe Paun');
INSERT INTO "InstAuthPub" VALUES (986, NULL, 'Hosam M. Mahmoud');
INSERT INTO "InstAuthPub" VALUES (986, NULL, 'Tatsuie Tsukiji');
INSERT INTO "InstAuthPub" VALUES (987, NULL, 'Symeon Bozapalidis');
INSERT INTO "InstAuthPub" VALUES (987, NULL, 'Antonios Kalampakas');
INSERT INTO "InstAuthPub" VALUES (988, NULL, 'Joost Engelfriet');
INSERT INTO "InstAuthPub" VALUES (988, NULL, 'Tjalling Gelsema');
INSERT INTO "InstAuthPub" VALUES (989, NULL, 'Lila Kari');
INSERT INTO "InstAuthPub" VALUES (989, NULL, 'Stavros Konstantinidis');
INSERT INTO "InstAuthPub" VALUES (989, NULL, 'Elena Losseva');
INSERT INTO "InstAuthPub" VALUES (989, NULL, 'Geoff Wozniak');
INSERT INTO "InstAuthPub" VALUES (990, NULL, 'Elizabeth Scott');
INSERT INTO "InstAuthPub" VALUES (990, NULL, 'Adrian Johnstone');
INSERT INTO "InstAuthPub" VALUES (991, NULL, 'Leah Epstein');
INSERT INTO "InstAuthPub" VALUES (991, NULL, 'Tamir Tassa');
INSERT INTO "InstAuthPub" VALUES (992, NULL, 'Steven Delvaux');
INSERT INTO "InstAuthPub" VALUES (992, NULL, 'Leon Horsten');
INSERT INTO "InstAuthPub" VALUES (993, NULL, 'Roberto Barbuti');
INSERT INTO "InstAuthPub" VALUES (993, NULL, 'Luca Tesei');
INSERT INTO "InstAuthPub" VALUES (994, NULL, 'Victor Khomenko');
INSERT INTO "InstAuthPub" VALUES (994, NULL, 'Maciej Koutny');
INSERT INTO "InstAuthPub" VALUES (994, NULL, 'Walter Vogler');
INSERT INTO "InstAuthPub" VALUES (995, NULL, 'Shlomi Dolev');
INSERT INTO "InstAuthPub" VALUES (995, NULL, 'Elad Schiller');
INSERT INTO "InstAuthPub" VALUES (996, NULL, 'Michael Domaratzki');
INSERT INTO "InstAuthPub" VALUES (997, NULL, 'Nicole Lesley');
INSERT INTO "InstAuthPub" VALUES (997, NULL, 'Alan Fekete');
INSERT INTO "InstAuthPub" VALUES (998, NULL, 'Andrea Walther');
INSERT INTO "InstAuthPub" VALUES (999, NULL, 'Ernst-Erich Doberkat');
INSERT INTO "InstAuthPub" VALUES (1000, NULL, 'Li Layuan');
INSERT INTO "InstAuthPub" VALUES (1000, NULL, 'Li Chunlin');
INSERT INTO "InstAuthPub" VALUES (1001, NULL, 'Yong He');
INSERT INTO "InstAuthPub" VALUES (1001, NULL, 'Yiwei Jiang');


--
-- TOC entry 2131 (class 0 OID 24905)
-- Dependencies: 178
-- Data for Name: Institution; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2126 (class 0 OID 24865)
-- Dependencies: 173
-- Data for Name: Journal; Type: TABLE DATA; Schema: public; Owner: kittn
--

INSERT INTO "Journal" VALUES (1, 'Acta Inf.', '33', '7', NULL);
INSERT INTO "Journal" VALUES (2, 'Acta Inf.', '20', NULL, NULL);
INSERT INTO "Journal" VALUES (3, 'Acta Inf.', '17', NULL, NULL);
INSERT INTO "Journal" VALUES (4, 'Acta Inf.', '7', NULL, NULL);
INSERT INTO "Journal" VALUES (5, 'Acta Inf.', '48', '1', NULL);
INSERT INTO "Journal" VALUES (6, 'Acta Inf.', '24', '6', NULL);
INSERT INTO "Journal" VALUES (7, 'Acta Inf.', '25', '1', NULL);
INSERT INTO "Journal" VALUES (8, 'Acta Inf.', '10', NULL, NULL);
INSERT INTO "Journal" VALUES (9, 'Acta Inf.', '49', '1', NULL);
INSERT INTO "Journal" VALUES (10, 'Acta Inf.', '43', '5', NULL);
INSERT INTO "Journal" VALUES (11, 'Acta Inf.', '50', '3', NULL);
INSERT INTO "Journal" VALUES (12, 'Acta Inf.', '28', '5', NULL);
INSERT INTO "Journal" VALUES (13, 'Acta Inf.', '11', NULL, NULL);
INSERT INTO "Journal" VALUES (14, 'Acta Inf.', '23', '3', NULL);
INSERT INTO "Journal" VALUES (15, 'Acta Inf.', '38', '11/12', NULL);
INSERT INTO "Journal" VALUES (16, 'Acta Inf.', '51', '8', NULL);
INSERT INTO "Journal" VALUES (17, 'Acta Inf.', '1', NULL, NULL);
INSERT INTO "Journal" VALUES (18, 'Acta Inf.', '6', NULL, NULL);
INSERT INTO "Journal" VALUES (19, 'Acta Inf.', '32', '4', NULL);
INSERT INTO "Journal" VALUES (20, 'Acta Inf.', '36', '9/10', NULL);
INSERT INTO "Journal" VALUES (21, 'Acta Inf.', '46', '2', NULL);
INSERT INTO "Journal" VALUES (22, 'Acta Inf.', '15', NULL, NULL);
INSERT INTO "Journal" VALUES (23, 'Acta Inf.', '45', '4', NULL);
INSERT INTO "Journal" VALUES (24, 'Acta Inf.', '8', NULL, NULL);
INSERT INTO "Journal" VALUES (25, 'Acta Inf.', '3', NULL, NULL);
INSERT INTO "Journal" VALUES (26, 'Acta Inf.', '14', NULL, NULL);
INSERT INTO "Journal" VALUES (27, 'Acta Inf.', '26', '7', NULL);
INSERT INTO "Journal" VALUES (28, 'Acta Inf.', '52', '1', NULL);
INSERT INTO "Journal" VALUES (29, 'Acta Inf.', '22', '4', NULL);
INSERT INTO "Journal" VALUES (30, 'Acta Inf.', '18', NULL, NULL);
INSERT INTO "Journal" VALUES (31, 'Acta Inf.', '16', NULL, NULL);
INSERT INTO "Journal" VALUES (32, 'Acta Inf.', '30', '3', NULL);
INSERT INTO "Journal" VALUES (33, 'Acta Inf.', '34', '5', NULL);
INSERT INTO "Journal" VALUES (34, 'Acta Inf.', '9', NULL, NULL);
INSERT INTO "Journal" VALUES (35, 'Acta Inf.', '5', NULL, NULL);
INSERT INTO "Journal" VALUES (36, 'Acta Inf.', '2', NULL, NULL);
INSERT INTO "Journal" VALUES (37, 'Acta Inf.', '31', '4', NULL);
INSERT INTO "Journal" VALUES (38, 'Acta Inf.', '12', NULL, NULL);
INSERT INTO "Journal" VALUES (39, 'Acta Inf.', '29', '1', NULL);
INSERT INTO "Journal" VALUES (40, 'Acta Inf.', '4', NULL, NULL);
INSERT INTO "Journal" VALUES (41, 'Acta Inf.', '19', NULL, NULL);
INSERT INTO "Journal" VALUES (42, 'Acta Inf.', '13', NULL, NULL);
INSERT INTO "Journal" VALUES (43, 'Acta Inf.', '47', '4', NULL);
INSERT INTO "Journal" VALUES (44, 'Acta Inf.', '44', '7-8', NULL);
INSERT INTO "Journal" VALUES (45, 'Acta Inf.', '42', '1', NULL);
INSERT INTO "Journal" VALUES (46, 'Acta Inf.', '35', '6', NULL);
INSERT INTO "Journal" VALUES (47, 'Acta Inf.', '37', '10', NULL);
INSERT INTO "Journal" VALUES (48, 'Acta Inf.', '27', '6', NULL);
INSERT INTO "Journal" VALUES (49, 'Acta Inf.', '39', '1', NULL);
INSERT INTO "Journal" VALUES (50, 'Acta Inf.', '21', NULL, NULL);
INSERT INTO "Journal" VALUES (51, 'Acta Inf.', '41', '7-8', NULL);
INSERT INTO "Journal" VALUES (52, 'Acta Inf.', '40', '6-7', NULL);


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 190
-- Name: Journal_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: kittn
--

SELECT pg_catalog.setval('"Journal_ID_seq"', 52, true);


--
-- TOC entry 2128 (class 0 OID 24881)
-- Dependencies: 175
-- Data for Name: Keyword; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2140 (class 0 OID 25043)
-- Dependencies: 187
-- Data for Name: Proceedings; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2135 (class 0 OID 24954)
-- Dependencies: 182
-- Data for Name: PubArea; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2136 (class 0 OID 24969)
-- Dependencies: 183
-- Data for Name: PubKeyword; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2125 (class 0 OID 24857)
-- Dependencies: 172
-- Data for Name: Publication; Type: TABLE DATA; Schema: public; Owner: kittn
--

INSERT INTO "Publication" VALUES (1, 'Parallel Integer Sorting and Simulation Amongst CRCW Models.', 1996, 'article');
INSERT INTO "Publication" VALUES (2, 'Calculi for Interaction.', 1996, 'article');
INSERT INTO "Publication" VALUES (3, 'Multi-Granularity Locking for Nested Transactions: A Proof Using a Possibilities Mapping.', 1996, 'article');
INSERT INTO "Publication" VALUES (4, 'Optimizing the Costs of Hierarchical Quorum Consensus.', 1996, 'article');
INSERT INTO "Publication" VALUES (5, 'The Synthesis Problem of Petri Nets.', 1996, 'article');
INSERT INTO "Publication" VALUES (6, 'Disambiguating Grammars by Exclusion of Sub-Parse Trees.', 1996, 'article');
INSERT INTO "Publication" VALUES (7, 'Reduction Rules for Time Petri Nets.', 1996, 'article');
INSERT INTO "Publication" VALUES (8, 'Parallel Approximation Schemes for Problems on Planar Graphs.', 1996, 'article');
INSERT INTO "Publication" VALUES (9, 'Possibility and Impossibility Results in a Shared Memory Environment.', 1996, 'article');
INSERT INTO "Publication" VALUES (10, 'Algebraic Models of Microprocessors: Architecture and Organisation.', 1996, 'article');
INSERT INTO "Publication" VALUES (11, 'Simple Extensions of 1-writer Atomic Variable Constructions to Multiwriter Ones.', 1996, 'article');
INSERT INTO "Publication" VALUES (12, 'A Kernel Language for Programmed Rewriting of (Hyper)graphs.', 1996, 'article');
INSERT INTO "Publication" VALUES (13, 'Chromatic Binary Search Trees. A Structure for Concurrent Rebalancing.', 1996, 'article');
INSERT INTO "Publication" VALUES (14, 'On the Recognition of Permuted Supnick and Incomplete Monge Matrices.', 1996, 'article');
INSERT INTO "Publication" VALUES (15, 'Short Resolution Proofs for a Sequence of Tricky Formulas.', 1996, 'article');
INSERT INTO "Publication" VALUES (16, 'Bounded Delay for a Free Address.', 1996, 'article');
INSERT INTO "Publication" VALUES (17, 'A Direct Complement Construction for LR(1) Grammars.', 1996, 'article');
INSERT INTO "Publication" VALUES (18, 'Axiomatizing the Algebra of Net Computations and Processes.', 1996, 'article');
INSERT INTO "Publication" VALUES (19, 'RETRPROV, A System that Looks for Axioms.', 1996, 'article');
INSERT INTO "Publication" VALUES (20, 'Forgetting Automata and Context-Free Languages.', 1996, 'article');
INSERT INTO "Publication" VALUES (21, 'Trial and Error. A New Approach to Space-Bounded Learning.', 1996, 'article');
INSERT INTO "Publication" VALUES (22, 'The Log-Structured Merge-Tree (LSM-Tree).', 1996, 'article');
INSERT INTO "Publication" VALUES (23, 'Modeling Data-Intensive Reactive Systems with Relational Transition Systems.', 1996, 'article');
INSERT INTO "Publication" VALUES (24, 'Relating Confluence, Innermost-Confluence and Outermost-Confluence Properties of Term Rewriting Systems.', 1996, 'article');
INSERT INTO "Publication" VALUES (25, 'On the Sequential Nature of Interprocedural Program-Analysis Problems.', 1996, 'article');
INSERT INTO "Publication" VALUES (26, 'Kinded Type Inference for Parametric Overloading.', 1996, 'article');
INSERT INTO "Publication" VALUES (27, 'On the Rational Subsets of the Free Group.', 1996, 'article');
INSERT INTO "Publication" VALUES (28, 'Timing and Causality in Process Algebra.', 1996, 'article');
INSERT INTO "Publication" VALUES (29, 'Pattern Matching in Trees and Nets.', 1983, 'article');
INSERT INTO "Publication" VALUES (30, 'NP-complete Problems Simplified on Tree Schemas.', 1983, 'article');
INSERT INTO "Publication" VALUES (31, 'A Three-Stage Construction for Multiconnection Networks.', 1983, 'article');
INSERT INTO "Publication" VALUES (32, 'Rational Set of Trees and the Algebraic Semantics of Logic Programming.', 1983, 'article');
INSERT INTO "Publication" VALUES (33, 'Is Text Compression by Prefixes and Suffixes Practical?', 1983, 'article');
INSERT INTO "Publication" VALUES (34, 'A Note on Multi-queue Scheduling of Two Tasks.', 1983, 'article');
INSERT INTO "Publication" VALUES (35, 'On Hierarchies of Abstract Data Types.', 1983, 'article');
INSERT INTO "Publication" VALUES (36, 'Task Allocation in Fault-Tolerant Distributed Systems.', 1983, 'article');
INSERT INTO "Publication" VALUES (37, 'A General Proof Rule for Procedures in Predicate Transformer Semantics.', 1983, 'article');
INSERT INTO "Publication" VALUES (38, 'General Predicate Transformer and the Semantics of a Programming Language With Go To Statement.', 1983, 'article');
INSERT INTO "Publication" VALUES (39, 'A Sound and Relatively * Complete Hoare-Logic for a Language With Higher Type Procedures.', 1983, 'article');
INSERT INTO "Publication" VALUES (40, 'Two-Symbol DOS Systems Generating Regular Languages.', 1983, 'article');
INSERT INTO "Publication" VALUES (41, 'On the Semantics of Polymorphism.', 1983, 'article');
INSERT INTO "Publication" VALUES (42, 'LR Parsing for Affix Grammars.', 1983, 'article');
INSERT INTO "Publication" VALUES (43, 'Product Properties and Their Direct Verification.', 1983, 'article');
INSERT INTO "Publication" VALUES (44, 'On the Relationship of Minimum and Optimum Covers for a Set of Functional Dependencies.', 1983, 'article');
INSERT INTO "Publication" VALUES (45, 'The Temporal Logic of Branching Time.', 1983, 'article');
INSERT INTO "Publication" VALUES (46, 'Hiérarchie et fermeture de certaines classes de tag-systèmes.', 1983, 'article');
INSERT INTO "Publication" VALUES (47, 'On the Performance Evaluation of Extendible Hashing and Trie Searching.', 1983, 'article');
INSERT INTO "Publication" VALUES (48, 'On the Power of Chain Rules in Context Free Grammars.', 1982, 'article');
INSERT INTO "Publication" VALUES (49, 'Explaining the Wheel Sieve.', 1982, 'article');
INSERT INTO "Publication" VALUES (50, 'Complexity Theory and the Operational Structure of Algebraic Programming Systems.', 1982, 'article');
INSERT INTO "Publication" VALUES (51, 'On Parsing Arithmetic Expressions in a Multiprocessing Environment.', 1982, 'article');
INSERT INTO "Publication" VALUES (52, 'On Some Decidable Properties of Finite State Translations.', 1982, 'article');
INSERT INTO "Publication" VALUES (53, 'Robust Data Types.', 1982, 'article');
INSERT INTO "Publication" VALUES (54, 'Formes de langages et de grammaires.', 1982, 'article');
INSERT INTO "Publication" VALUES (55, 'Information Theoretic Approximations for  M/G/  1 und  G/G/  1 Queuing Systems.', 1982, 'article');
INSERT INTO "Publication" VALUES (56, 'A Theory of Interactive Programming.', 1982, 'article');
INSERT INTO "Publication" VALUES (57, 'Dynamic Multi-Dimensional Data Structures Based on Quad- and  K - D  Trees.', 1982, 'article');
INSERT INTO "Publication" VALUES (58, 'Scheduling with Slack Time.', 1982, 'article');
INSERT INTO "Publication" VALUES (59, 'Deleting the Root of a Heap.', 1982, 'article');
INSERT INTO "Publication" VALUES (60, 'Inner Loops in Flowgraphs and Code Optimization.', 1982, 'article');
INSERT INTO "Publication" VALUES (61, 'A Hierarchy Theorem for Multihead Stack-Counter Automata.', 1982, 'article');
INSERT INTO "Publication" VALUES (62, 'Recognition and Selection of Idioms for Code Optimization.', 1982, 'article');
INSERT INTO "Publication" VALUES (63, 'Testing Attribute Grammars for Circularity.', 1982, 'article');
INSERT INTO "Publication" VALUES (64, 'Representation of Graphs.', 1982, 'article');
INSERT INTO "Publication" VALUES (65, 'The Effect of Fixed-Length Record Implementation on File System Response.', 1982, 'article');
INSERT INTO "Publication" VALUES (66, 'Space Efficient Algorithms for Some Graph Theoretical Problems.', 1982, 'article');
INSERT INTO "Publication" VALUES (67, 'Schnelle Multiplikation von Polynomen über Körpern der Charakteristik 2.', 1977, 'article');
INSERT INTO "Publication" VALUES (68, 'A Study of Queueing Networks with Deterministic Service and Application to Computer Networks.', 1976, 'article');
INSERT INTO "Publication" VALUES (69, 'Multitype Multiprogramming Models.', 1976, 'article');
INSERT INTO "Publication" VALUES (70, 'Optimal Multiprogramming.', 1976, 'article');
INSERT INTO "Publication" VALUES (71, 'Monotone Data Flow Analysis Frameworks.', 1977, 'article');
INSERT INTO "Publication" VALUES (72, 'Validation of a Computer Performance Model of the Exponential Queuing Network Family.', 1976, 'article');
INSERT INTO "Publication" VALUES (73, 'Monoïdes syntactiques des langages algébriques.', 1977, 'article');
INSERT INTO "Publication" VALUES (74, 'On the Role of Unification in Mechanical Theorem Proving.', 1977, 'article');
INSERT INTO "Publication" VALUES (75, 'The Synchronization of Independent Processes.', 1976, 'article');
INSERT INTO "Publication" VALUES (76, 'Axiomatic Approach to Side Effects and General Jumps.', 1977, 'article');
INSERT INTO "Publication" VALUES (77, 'A Practical General Method for Constructing LR(k) Parsers.', 1977, 'article');
INSERT INTO "Publication" VALUES (78, 'The Network Complexity and the Turing Machine Complexity of Finite Functions.', 1976, 'article');
INSERT INTO "Publication" VALUES (79, 'Addenda and Corrigenda: Formal Semantics of a Class of High-Level Primitives for Coordinating Concurrent Processes', 1977, 'article');
INSERT INTO "Publication" VALUES (80, 'On the Self Contained Modelling of DB/DC Systems.', 1976, 'article');
INSERT INTO "Publication" VALUES (81, 'Probabilistic Models of Computer Systems - Part I (Exact Results).', 1976, 'article');
INSERT INTO "Publication" VALUES (82, 'LR-Parsing of Extended Context Free Grammars.', 1976, 'article');
INSERT INTO "Publication" VALUES (83, 'A New Approach to Parallel Computing.', 1976, 'article');
INSERT INTO "Publication" VALUES (84, 'Grammarforms and Grammarhomomorphisms.', 1976, 'article');
INSERT INTO "Publication" VALUES (85, 'An Endogenous Priority Model for Load Control in Combined Batch-Interactive Computer Systems.', 1976, 'article');
INSERT INTO "Publication" VALUES (86, 'Effect of Data Representation on Cost of Sparse Matrix Operations.', 1977, 'article');
INSERT INTO "Publication" VALUES (87, 'A characterization of rational D0L power series.', 2011, 'article');
INSERT INTO "Publication" VALUES (88, 'A Markovian queue with varying number of servers and applications to the performance comparison of HSDPA user equipment.', 2011, 'article');
INSERT INTO "Publication" VALUES (89, 'Some properties of the disjunctive languages contained in Q.', 2011, 'article');
INSERT INTO "Publication" VALUES (90, 'MAT learners for tree series: an abstract data type and two realizations.', 2011, 'article');
INSERT INTO "Publication" VALUES (91, 'The query complexity of estimating weighted averages.', 2011, 'article');
INSERT INTO "Publication" VALUES (92, 'Efficient systematic clustering method for k-anonymization.', 2011, 'article');
INSERT INTO "Publication" VALUES (93, 'Correct hardware synthesis - An algebraic approach.', 2011, 'article');
INSERT INTO "Publication" VALUES (94, 'New bounds for the query complexity of an algorithm that learns DFAs with correction and equivalence queries.', 2011, 'article');
INSERT INTO "Publication" VALUES (95, 'Connectivity of workflow nets: the foundations of stepwise verification.', 2011, 'article');
INSERT INTO "Publication" VALUES (96, 'Multi-letter quantum finite automata: decidability of the equivalence and minimization of states.', 2011, 'article');
INSERT INTO "Publication" VALUES (97, 'Avoidable binary patterns in partial words.', 2011, 'article');
INSERT INTO "Publication" VALUES (98, 'One-sided random context grammars.', 2011, 'article');
INSERT INTO "Publication" VALUES (99, 'On α 2 - ν 2-products of automata.', 2011, 'article');
INSERT INTO "Publication" VALUES (100, 'Testing for refinement in Circus.', 2011, 'article');
INSERT INTO "Publication" VALUES (101, 'The Derivation of Systolic Implementations of Programs.', 1987, 'article');
INSERT INTO "Publication" VALUES (102, 'Branching Processes in the Analysis of the Heights of Trees.', 1987, 'article');
INSERT INTO "Publication" VALUES (103, 'Sometime = Always + Recursion = Always on the Equivalence of the Intermittent and Invariant Assertions Methods for Proving Inevitability Properties of Programs.', 1987, 'article');
INSERT INTO "Publication" VALUES (104, 'Worst Case Performance of Weighted Buddy Systems.', 1987, 'article');
INSERT INTO "Publication" VALUES (105, 'The Undecidability of the Unification and Matching Problem for Canonical Theories.', 1987, 'article');
INSERT INTO "Publication" VALUES (106, 'Redundant Proofs of Non-Interference in Levin-Gries CSP Program Proofs.', 1987, 'article');
INSERT INTO "Publication" VALUES (107, 'Performance Evaluation of Fork and Join Synchronization Primitives.', 1987, 'article');
INSERT INTO "Publication" VALUES (108, 'A Linear Space Algorithm for the LCS Problem.', 1987, 'article');
INSERT INTO "Publication" VALUES (109, 'Electing a Leader in a Ring with Link Failures.', 1987, 'article');
INSERT INTO "Publication" VALUES (110, 'Time Optimal Left to Right Construction of Position Trees.', 1987, 'article');
INSERT INTO "Publication" VALUES (111, 'Order and Metric in the Stream Semantics of Elemental Concurrency.', 1987, 'article');
INSERT INTO "Publication" VALUES (112, 'Analysis of Space Allocation in a Generally Fragmented Linear Store.', 1987, 'article');
INSERT INTO "Publication" VALUES (113, 'Optimal Worst Case Trees.', 1987, 'article');
INSERT INTO "Publication" VALUES (114, 'Combinator-Based Compilation of Recursive Functions with Different Parameter Passing Modes.', 1987, 'article');
INSERT INTO "Publication" VALUES (115, 'Relational Heuristics for the Design of Deterministic Programs.', 1987, 'article');
INSERT INTO "Publication" VALUES (116, 'A Formal Semantics for Concurrent Systems with a Priority Relation.', 1987, 'article');
INSERT INTO "Publication" VALUES (117, 'An Efficient General Iterative Algorithm for Dataflow Analysis.', 1987, 'article');
INSERT INTO "Publication" VALUES (118, 'An Easily Testable Optimal-Time VLSI-Multiplier.', 1987, 'article');
INSERT INTO "Publication" VALUES (119, 'An Analysis of a Contention Resolution Algorithm: Another Approach.', 1987, 'article');
INSERT INTO "Publication" VALUES (120, 'SLR(1) and LALR(1) Parsing for Unrestricted Grammars.', 1987, 'article');
INSERT INTO "Publication" VALUES (121, 'Generalized Theory of Serializability.', 1987, 'article');
INSERT INTO "Publication" VALUES (122, 'Parallel Approximation Schemes for Subset Sum and Knapsack Problems.', 1987, 'article');
INSERT INTO "Publication" VALUES (123, 'On Sufficient-Completeness and Related Properties of Term Rewriting Systems.', 1987, 'article');
INSERT INTO "Publication" VALUES (124, 'Partial Parametrization Eliminates Multiple Traversals of Data Structures.', 1987, 'article');
INSERT INTO "Publication" VALUES (125, 'Some Techniques for Geometric Searching with Implicit Set Representations.', 1987, 'article');
INSERT INTO "Publication" VALUES (126, 'Fifo Nets Without Order Deadlock.', 1988, 'article');
INSERT INTO "Publication" VALUES (127, 'Inductive Completion with Retracts.', 1988, 'article');
INSERT INTO "Publication" VALUES (128, 'Recording the Use of Memory in Right-Boundary Grammars and Push-Down Automata.', 1988, 'article');
INSERT INTO "Publication" VALUES (129, 'A Proof System for Distributed Processes.', 1988, 'article');
INSERT INTO "Publication" VALUES (130, 'Integrating Code Generation and Peephole Optimization.', 1988, 'article');
INSERT INTO "Publication" VALUES (131, 'Toward Formal Development of Programs from Algebraic Specifications: Implementations Revisited.', 1988, 'article');
INSERT INTO "Publication" VALUES (132, 'Crypt-Equivalent Algebraic Specifications.', 1988, 'article');
INSERT INTO "Publication" VALUES (133, 'Apex Graph Grammars and Attribute Grammars.', 1988, 'article');
INSERT INTO "Publication" VALUES (134, 'Specification and Verification of Database Dynamics.', 1988, 'article');
INSERT INTO "Publication" VALUES (135, 'Cooperative Distributed Dynamic Load Balancing.', 1988, 'article');
INSERT INTO "Publication" VALUES (136, 'The Complexity of Reachability in Distributed Communicating Processes.', 1988, 'article');
INSERT INTO "Publication" VALUES (137, 'A Calculus of Refinements for Program Derivations.', 1988, 'article');
INSERT INTO "Publication" VALUES (138, 'Resolution on Formula-Trees.', 1988, 'article');
INSERT INTO "Publication" VALUES (139, 'Incremental Evaluation for Attribute Grammars with Unrestricted Movement Between Tree Modifications.', 1988, 'article');
INSERT INTO "Publication" VALUES (140, 'On Generating Database Schemes Bounded or Constant-time-maintainable by Extensibility.', 1988, 'article');
INSERT INTO "Publication" VALUES (141, 'Graph Complexity.', 1988, 'article');
INSERT INTO "Publication" VALUES (142, 'The Nearest Common Ancestor in a Dynamic Tree.', 1988, 'article');
INSERT INTO "Publication" VALUES (143, 'Elements of Finite Order for Finite Weight-Reducing and Confluent Thue Systems.', 1988, 'article');
INSERT INTO "Publication" VALUES (144, 'Contributions to the Semantics of Logic Perpetual Processes.', 1988, 'article');
INSERT INTO "Publication" VALUES (145, 'On the Complementation Rule for Multivalued Dependencies in Database Relations.', 1978, 'article');
INSERT INTO "Publication" VALUES (146, 'On Removing the Machine from the Language.', 1978, 'article');
INSERT INTO "Publication" VALUES (147, 'Bounded Quantification and Relations Recognizable by Finite Automata.', 1978, 'article');
INSERT INTO "Publication" VALUES (148, 'A Conservation Law for G/G/m Queueing Systems.', 1978, 'article');
INSERT INTO "Publication" VALUES (149, 'The Method of Attributes for Data Flow Analysis: Part II. Demand Analysis.', 1978, 'article');
INSERT INTO "Publication" VALUES (150, 'Two-Level Meta-Controlled Substitution Grammars.', 1978, 'article');
INSERT INTO "Publication" VALUES (151, 'A Class of Linearly Parsable Graph Grammars.', 1978, 'article');
INSERT INTO "Publication" VALUES (152, 'The Design of a Portable Programming Language.', 1978, 'article');
INSERT INTO "Publication" VALUES (153, 'Linear Regular Sets.', 1978, 'article');
INSERT INTO "Publication" VALUES (154, 'Information Management in Context Trees.', 1978, 'article');
INSERT INTO "Publication" VALUES (155, 'The Semigroups of Linearly Realizable Finite Automata I.', 1978, 'article');
INSERT INTO "Publication" VALUES (156, 'Incremental LR Parers.', 1978, 'article');
INSERT INTO "Publication" VALUES (157, 'The Semigroups of Linearly Realizable Finite Automata II.', 1978, 'article');
INSERT INTO "Publication" VALUES (158, 'A Note on Classes of Complements and the LBA Problem.', 1978, 'article');
INSERT INTO "Publication" VALUES (159, 'The Ultimate Equivalence Problem for DOL Systems.', 1978, 'article');
INSERT INTO "Publication" VALUES (160, 'The Algebraic Specification of Abstract Data Types.', 1978, 'article');
INSERT INTO "Publication" VALUES (161, 'Equational weighted tree transformations.', 2012, 'article');
INSERT INTO "Publication" VALUES (162, 'Instruction sequence processing operators.', 2012, 'article');
INSERT INTO "Publication" VALUES (163, 'Does indirect addressing matter? - A note.', 2012, 'article');
INSERT INTO "Publication" VALUES (164, 'Abstract reduction in directed model checking CCS processes.', 2012, 'article');
INSERT INTO "Publication" VALUES (165, 'Multi-tilde-bar expressions and their automata.', 2012, 'article');
INSERT INTO "Publication" VALUES (166, 'An efficient algorithm for finding ideal schedules.', 2012, 'article');
INSERT INTO "Publication" VALUES (167, 'The identity problem of finitely generated bi-ideals.', 2012, 'article');
INSERT INTO "Publication" VALUES (168, 'Finding vertex-surjective graph homomorphisms.', 2012, 'article');
INSERT INTO "Publication" VALUES (169, 'First-order logics: some characterizations and closure properties.', 2012, 'article');
INSERT INTO "Publication" VALUES (170, 'Stochastic game logic.', 2012, 'article');
INSERT INTO "Publication" VALUES (171, 'Using transition set sequences to partition behaviors of petri nets.', 2012, 'article');
INSERT INTO "Publication" VALUES (172, 'An algorithmic study of switch graphs.', 2012, 'article');
INSERT INTO "Publication" VALUES (173, 'On the power of enzymatic numerical P systems.', 2012, 'article');
INSERT INTO "Publication" VALUES (174, 'Erratum to: Avoidable binary patterns in partial words.', 2012, 'article');
INSERT INTO "Publication" VALUES (175, 'Prefix-primitive annihilators of languages under some operations.', 2012, 'article');
INSERT INTO "Publication" VALUES (176, 'Nonterminal complexity of one-sided random context grammars.', 2012, 'article');
INSERT INTO "Publication" VALUES (177, 'Merged processes: a new condensed representation of Petri net behaviour.', 2006, 'article');
INSERT INTO "Publication" VALUES (178, 'Solving HPP and SAT by P Systems with Active Membranes and Separation Rules.', 2006, 'article');
INSERT INTO "Publication" VALUES (179, 'Representation and uniformization of algebraic transductions.', 2007, 'article');
INSERT INTO "Publication" VALUES (180, 'Fair ambients.', 2007, 'article');
INSERT INTO "Publication" VALUES (181, 'Representing the integers with powers of 2 and 3.', 2006, 'article');
INSERT INTO "Publication" VALUES (182, 'Linearly bounded infinite graphs.', 2006, 'article');
INSERT INTO "Publication" VALUES (183, 'Programmed grammars and their relation to the LBA problem.', 2006, 'article');
INSERT INTO "Publication" VALUES (184, 'Compositional Analysis of C/C++ Programs with VeriSoft.', 2006, 'article');
INSERT INTO "Publication" VALUES (185, 'Refinement verification of the lazy caching algorithm.', 2006, 'article');
INSERT INTO "Publication" VALUES (186, 'On Abelian 2-avoidable binary patterns.', 2007, 'article');
INSERT INTO "Publication" VALUES (187, 'Symbolic models for control systems.', 2007, 'article');
INSERT INTO "Publication" VALUES (188, 'Periods in Extensions of Words.', 2006, 'article');
INSERT INTO "Publication" VALUES (189, 'Throughput analysis in wireless networks with multiple users and multiple channels.', 2006, 'article');
INSERT INTO "Publication" VALUES (190, 'Algebraic Correctness Proofs for Compiling Recursive Function Definitions with Strictness Information.', 2006, 'article');
INSERT INTO "Publication" VALUES (191, 'Distances in random digital search trees.', 2006, 'article');
INSERT INTO "Publication" VALUES (192, 'Hybridization methods for the analysis of nonlinear systems.', 2007, 'article');
INSERT INTO "Publication" VALUES (193, 'On the tree-transformation power of XSLT.', 2007, 'article');
INSERT INTO "Publication" VALUES (194, 'Fairness of Actions in System Computations.', 2006, 'article');
INSERT INTO "Publication" VALUES (195, 'A semantic approach to optimize linear datalog programs.', 2006, 'article');
INSERT INTO "Publication" VALUES (196, 'Verifying a simplification of mutual exclusion by Lycklama-Hadzilacos.', 2013, 'article');
INSERT INTO "Publication" VALUES (197, 'Deterministic pushdown-CD-systems of stateless deterministic R(1)-automata.', 2013, 'article');
INSERT INTO "Publication" VALUES (198, 'A distributed resource allocation algorithm for many processes.', 2013, 'article');
INSERT INTO "Publication" VALUES (199, 'Compositional type checking of delta-oriented software product lines.', 2013, 'article');
INSERT INTO "Publication" VALUES (200, 'New proof for the undecidability of the circular PCP.', 2013, 'article');
INSERT INTO "Publication" VALUES (201, 'Step semantics of boolean nets.', 2013, 'article');
INSERT INTO "Publication" VALUES (202, 'Query optimization in information integration.', 2013, 'article');
INSERT INTO "Publication" VALUES (203, 'Infinitary rewriting: closure operators, equivalences and models.', 2013, 'article');
INSERT INTO "Publication" VALUES (204, 'Avoiding cross-bifix-free binary words.', 2013, 'article');
INSERT INTO "Publication" VALUES (205, 'On the hierarchy of distribution-sensitive properties for data structures.', 2013, 'article');
INSERT INTO "Publication" VALUES (206, 'A note on the factorization conjecture.', 2013, 'article');
INSERT INTO "Publication" VALUES (207, 'Judgmental subtyping systems with intersection types and modal types.', 2013, 'article');
INSERT INTO "Publication" VALUES (208, 'Petri nets with name creation for transient secure association.', 2013, 'article');
INSERT INTO "Publication" VALUES (209, 'Conjunctive grammars and alternating pushdown automata.', 2013, 'article');
INSERT INTO "Publication" VALUES (210, 'Accepting splicing systems with permitting and forbidding words.', 2013, 'article');
INSERT INTO "Publication" VALUES (211, 'The Expressive Power of Delay Operators in SCCS.', 1991, 'article');
INSERT INTO "Publication" VALUES (212, 'Concurrent Bisimulations in Petri Nets.', 1991, 'article');
INSERT INTO "Publication" VALUES (213, 'Opportunistic Algorithms for Eliminating Supersets.', 1991, 'article');
INSERT INTO "Publication" VALUES (214, 'A Fixed Point Approach to Parallel Discrete Event Simulation.', 1991, 'article');
INSERT INTO "Publication" VALUES (215, 'Properties of Data Flow Frameworks.', 1990, 'article');
INSERT INTO "Publication" VALUES (216, 'On the Expansion of Non-Linear Functions.', 1991, 'article');
INSERT INTO "Publication" VALUES (217, 'The Expressive Power of the Bounded-Iteration Construct.', 1991, 'article');
INSERT INTO "Publication" VALUES (218, 'Efficient Memo-Table Management Strategies.', 1990, 'article');
INSERT INTO "Publication" VALUES (219, 'Efficient Comparison of Program Slices.', 1991, 'article');
INSERT INTO "Publication" VALUES (220, 'Decision Problems for Finite Special String-Rewriting Systems that are Confluent on Some Congruence Class.', 1991, 'article');
INSERT INTO "Publication" VALUES (221, 'Effective Construction of the Syntactic Algebra of a Recognizable Series on Trees.', 1991, 'article');
INSERT INTO "Publication" VALUES (222, 'Correction to Null Values in Nested Relational Databases by Mark A. Roth, H. F. Korth, and A. Silberschatz.', 1991, 'article');
INSERT INTO "Publication" VALUES (223, 'An Abstract Data Type for Name Analysis.', 1991, 'article');
INSERT INTO "Publication" VALUES (224, 'Branching Processes of Petri Nets.', 1991, 'article');
INSERT INTO "Publication" VALUES (225, 'Binary Search Trees of Almost Optimal Height.', 1990, 'article');
INSERT INTO "Publication" VALUES (226, 'The Virtual Feedback Problem in Hierarchical Representations of Combinational Circuits.', 1991, 'article');
INSERT INTO "Publication" VALUES (227, 'Automating the Knuth Bendix Ordering.', 1990, 'article');
INSERT INTO "Publication" VALUES (228, 'A Characterization of Set Representable Labeled Partial 2-Structures Through Decompositions.', 1990, 'article');
INSERT INTO "Publication" VALUES (229, 'Independent Database Schemes under Functional and Inclusion Dependencies.', 1991, 'article');
INSERT INTO "Publication" VALUES (230, 'Nested Satisfiability.', 1990, 'article');
INSERT INTO "Publication" VALUES (231, 'Greed in Resource Scheduling.', 1991, 'article');
INSERT INTO "Publication" VALUES (232, 'A New Explanation of the Glitch Phenomenon.', 1991, 'article');
INSERT INTO "Publication" VALUES (233, 'Resource Finding in Store-and-Forward Networks.', 1991, 'article');
INSERT INTO "Publication" VALUES (234, 'Sufficient-Completeness, Ground-Reducibility and their Complexity.', 1991, 'article');
INSERT INTO "Publication" VALUES (235, 'Proof Theory for Exception Handling in a Tasking Environment.', 1990, 'article');
INSERT INTO "Publication" VALUES (236, 'Postorder Trees and Eulerian Numbers.', 1991, 'article');
INSERT INTO "Publication" VALUES (237, 'Alan J. Perlis 1922-1990.', 1991, 'article');
INSERT INTO "Publication" VALUES (238, 'A Synthesis of Several Sorting Algorithms.', 1978, 'article');
INSERT INTO "Publication" VALUES (239, 'A Binary Operation on Trees and an Initial Algebra Characterization for Finite Tree Types.', 1979, 'article');
INSERT INTO "Publication" VALUES (240, 'The Correctness of the Schorr-Waite List Marking Algorithm.', 1979, 'article');
INSERT INTO "Publication" VALUES (241, 'A Useful Lemma for Context-Free Programmed Grammars.', 1979, 'article');
INSERT INTO "Publication" VALUES (242, 'Dynamic Weighted Binary Search Trees.', 1979, 'article');
INSERT INTO "Publication" VALUES (243, 'do Considered od: A Contribution to the Programming Calculus.', 1979, 'article');
INSERT INTO "Publication" VALUES (244, 'Constructing LR Parsers for Regular Right Part Grammars.', 1979, 'article');
INSERT INTO "Publication" VALUES (245, 'An Experimentally Validated Model of the Paging Drum.', 1979, 'article');
INSERT INTO "Publication" VALUES (246, 'Procédures de reprise dans les systèmes de gestion de base de données réparties.', 1979, 'article');
INSERT INTO "Publication" VALUES (247, 'Remarks on "Some Comments on Concurrent Readers and Writers" by Reidar Conradi.', 1978, 'article');
INSERT INTO "Publication" VALUES (248, 'The Average Number of Registers Needed to Evaluate a Binary Tree Optimally.', 1979, 'article');
INSERT INTO "Publication" VALUES (249, 'The Schorr-Waite Graph Marking Algorithm.', 1979, 'article');
INSERT INTO "Publication" VALUES (250, 'Extended Linear Macro Grammars, Iteration Grammars, and Register Programs.', 1979, 'article');
INSERT INTO "Publication" VALUES (251, 'Proving and Applying Program Transformations Expressed with Second-Order Patterns.', 1978, 'article');
INSERT INTO "Publication" VALUES (252, 'Opérations de Cylindre et applications séquentielles gauches inverses.', 1979, 'article');
INSERT INTO "Publication" VALUES (253, 'Improved Time and Space Bounds for Boolean Matrix Multiplication.', 1978, 'article');
INSERT INTO "Publication" VALUES (254, 'The Clean Termination of Pascal Programs.', 1979, 'article');
INSERT INTO "Publication" VALUES (255, 'On the Definition of ELR(k) and ELL(k) Grammars.', 1979, 'article');
INSERT INTO "Publication" VALUES (256, 'Hierarchy Theorems for Two-Way Finite State Transducers.', 1978, 'article');
INSERT INTO "Publication" VALUES (257, 'A Workload Model Representative of Static and Dynamic Characteristics.', 1986, 'article');
INSERT INTO "Publication" VALUES (258, 'Maximum Entropy and the  G/G/1/N  Queue.', 1986, 'article');
INSERT INTO "Publication" VALUES (259, 'Decomposition of Graphs and Monotone Formula Size of Homogeneous Functions.', 1986, 'article');
INSERT INTO "Publication" VALUES (260, 'Generation of Efficient  LALR  Parsers for Regular Right Part Grammars.', 1986, 'article');
INSERT INTO "Publication" VALUES (261, 'Synchronizable Deterministic Pushdown Automata and the Decidability of their Equivalence.', 1986, 'article');
INSERT INTO "Publication" VALUES (262, 'Nearly Optimal Hierarchies for Network and Formula Size.', 1986, 'article');
INSERT INTO "Publication" VALUES (263, 'Constructing Maximal Slicings from Geometry.', 1986, 'article');
INSERT INTO "Publication" VALUES (264, 'On the Average Internal Path Length of  m  -ary Search Trees.', 1986, 'article');
INSERT INTO "Publication" VALUES (265, 'Deterministic Grammars and Grammar Morphisms.', 1986, 'article');
INSERT INTO "Publication" VALUES (266, 'Acceptable Functional Programming Systems.', 1986, 'article');
INSERT INTO "Publication" VALUES (267, ' NP  -Hard Problems in Hierarchical-Tree Clustering.', 1986, 'article');
INSERT INTO "Publication" VALUES (268, 'Files d''attente exponentielles ayant des parametres non-stationnaires dans le temps.', 1986, 'article');
INSERT INTO "Publication" VALUES (269, 'Precedence Technique is not Worse than SLR(1).', 1986, 'article');
INSERT INTO "Publication" VALUES (270, 'Graph Theoretic Closure Properties of the Family of Boundary NLC Graph Languages.', 1986, 'article');
INSERT INTO "Publication" VALUES (271, 'Predicative Methodology.', 1986, 'article');
INSERT INTO "Publication" VALUES (272, 'A Logic for the Specification and Proof of Regular Controllable Processes of CCS.', 1986, 'article');
INSERT INTO "Publication" VALUES (273, 'A Regularity Test for Dual Bordered  OS  Systems.', 1986, 'article');
INSERT INTO "Publication" VALUES (274, 'The Complexity of Combinatorial Problems with Succinct Input Representation.', 1986, 'article');
INSERT INTO "Publication" VALUES (275, 'An Incremental Primal Sieve.', 1986, 'article');
INSERT INTO "Publication" VALUES (276, 'Generating Binary Trees of Bounded Height.', 1986, 'article');
INSERT INTO "Publication" VALUES (277, 'The Reliability of Life-Critical Computer Systems.', 1986, 'article');
INSERT INTO "Publication" VALUES (278, 'Information Theoretic Analysis for a General Queueing System at Equilibrium with Application to Queues in Tandem.', 1986, 'article');
INSERT INTO "Publication" VALUES (279, 'Gray visiting Motzkins.', 2002, 'article');
INSERT INTO "Publication" VALUES (280, 'Automatic verification of concurrent systems using a formula-based compositional approach.', 2002, 'article');
INSERT INTO "Publication" VALUES (281, 'Relaxed red-black trees with group updates.', 2002, 'article');
INSERT INTO "Publication" VALUES (282, 'Generalized normal form for rewriting P systems.', 2002, 'article');
INSERT INTO "Publication" VALUES (283, 'Minimally adequate teacher synthesizes statechart diagrams.', 2002, 'article');
INSERT INTO "Publication" VALUES (284, 'Timed tree automata with an application to temporal logic.', 2001, 'article');
INSERT INTO "Publication" VALUES (285, 'Tree-systems of morphisms.', 2001, 'article');
INSERT INTO "Publication" VALUES (286, 'Correctness of dataflow and systolic algorithms using algebras of streams.', 2001, 'article');
INSERT INTO "Publication" VALUES (287, 'Packing rectangles in a strip.', 2002, 'article');
INSERT INTO "Publication" VALUES (288, 'A quadratic speedup theorem for iterative arrays.', 2002, 'article');
INSERT INTO "Publication" VALUES (289, 'Containment and disjointedness in partitioned normal form relations.', 2002, 'article');
INSERT INTO "Publication" VALUES (290, 'Object type constructors.', 2002, 'article');
INSERT INTO "Publication" VALUES (291, 'Formal properties of XML grammars and languages.', 2002, 'article');
INSERT INTO "Publication" VALUES (292, 'Adding a path connectedness operator to FO+poly (linear).', 2002, 'article');
INSERT INTO "Publication" VALUES (293, 'Process algebra with action dependencies.', 2001, 'article');
INSERT INTO "Publication" VALUES (294, 'The size of random bucket trees via urn models.', 2002, 'article');
INSERT INTO "Publication" VALUES (295, 'The variance of the height of digital search trees.', 2002, 'article');
INSERT INTO "Publication" VALUES (296, 'A general procedure to check conjunctive query containment.', 2002, 'article');
INSERT INTO "Publication" VALUES (297, 'On the complexity of the identification problem in Hamming spaces.', 2002, 'article');
INSERT INTO "Publication" VALUES (298, 'Trace- and failure-based semantics for responsiveness.', 2014, 'article');
INSERT INTO "Publication" VALUES (299, 'Efficient controller synthesis for a fragment of MTL0,∞.', 2014, 'article');
INSERT INTO "Publication" VALUES (300, 'On weighted first-order logics with discounting.', 2014, 'article');
INSERT INTO "Publication" VALUES (301, 'Head and state hierarchies for unary multi-head finite automata.', 2014, 'article');
INSERT INTO "Publication" VALUES (302, 'An efficient simulation algorithm on Kripke structures.', 2014, 'article');
INSERT INTO "Publication" VALUES (303, 'Controlled finite automata.', 2014, 'article');
INSERT INTO "Publication" VALUES (304, 'Synthesizing robust systems.', 2014, 'article');
INSERT INTO "Publication" VALUES (305, 'Exploiting a hypergraph model for finding Golomb rulers.', 2014, 'article');
INSERT INTO "Publication" VALUES (306, 'Distributed synthesis for regular and contextfree specifications.', 2014, 'article');
INSERT INTO "Publication" VALUES (307, 'Delay and energy efficiency analysis of multicast cooperative ARQ over wireless networks.', 2014, 'article');
INSERT INTO "Publication" VALUES (308, 'General quantitative specification theories with modal transition systems.', 2014, 'article');
INSERT INTO "Publication" VALUES (309, 'On the incremental growth and shrinkage of LR goto-graphs.', 2014, 'article');
INSERT INTO "Publication" VALUES (310, 'Visibly rational expressions.', 2014, 'article');
INSERT INTO "Publication" VALUES (311, 'Strategy synthesis for multi-dimensional quantitative objectives.', 2014, 'article');
INSERT INTO "Publication" VALUES (312, 'Some kinds of primitive and non-primitive words.', 2014, 'article');
INSERT INTO "Publication" VALUES (313, 'Least Upper Bound on the Cost of Optimum Binary Search Trees.', 1972, 'article');
INSERT INTO "Publication" VALUES (314, 'Ein Vollständigkeitssatz für Programme und Schaltkreise.', 1971, 'article');
INSERT INTO "Publication" VALUES (315, 'A Comparison of Two Synchronizing Concepts.', 1972, 'article');
INSERT INTO "Publication" VALUES (316, 'The Programming Language Pascal.', 1971, 'article');
INSERT INTO "Publication" VALUES (317, 'Inhibitionsfelder.', 1972, 'article');
INSERT INTO "Publication" VALUES (318, 'Top-Down Syntax Analysis.', 1971, 'article');
INSERT INTO "Publication" VALUES (319, 'On Non-Determinancy in Simple Computing Devices.', 1972, 'article');
INSERT INTO "Publication" VALUES (320, 'Berechnung und Programm. I.', 1972, 'article');
INSERT INTO "Publication" VALUES (321, 'Optimal Merging of 2 Elements with n Elements.', 1971, 'article');
INSERT INTO "Publication" VALUES (322, 'Congruences et Automorphismes des Automates Finis.', 1971, 'article');
INSERT INTO "Publication" VALUES (323, 'Application of Regular Canonical Systems to Grammars Translatable from Left to Right.', 1971, 'article');
INSERT INTO "Publication" VALUES (324, 'Optimal Scheduling for Two-Processor Systems.', 1972, 'article');
INSERT INTO "Publication" VALUES (325, 'Automatic Analysis of Inflectional Morphems in German Nouns.', 1972, 'article');
INSERT INTO "Publication" VALUES (326, 'Schnelle Berechnung von Kettenbruchentwicklungen.', 1971, 'article');
INSERT INTO "Publication" VALUES (327, 'A Model for Data Structures and Its Applications. I.', 1971, 'article');
INSERT INTO "Publication" VALUES (328, 'Performance Predictions for Extended Paged Memories.', 1971, 'article');
INSERT INTO "Publication" VALUES (329, 'Bounds on Algorithms for String Generation.', 1972, 'article');
INSERT INTO "Publication" VALUES (330, 'Optimum Binary Search Trees.', 1971, 'article');
INSERT INTO "Publication" VALUES (331, 'Direction Controlled Programmed Grammars.', 1972, 'article');
INSERT INTO "Publication" VALUES (332, 'The Mathematical Analysis of the Computer System Modeled as a Two Stage Cyclic Queue.', 1976, 'article');
INSERT INTO "Publication" VALUES (333, 'Another Polynomial Homomorphism.', 1976, 'article');
INSERT INTO "Publication" VALUES (334, 'Hierarchies of Complete Problems.', 1976, 'article');
INSERT INTO "Publication" VALUES (335, 'Grammars on Partial Graphs.', 1976, 'article');
INSERT INTO "Publication" VALUES (336, 'On Proving that Certain Languages are not ETOL.', 1976, 'article');
INSERT INTO "Publication" VALUES (337, 'On the Implementation of Strassen''s Fast Multiplication Algorithm.', 1976, 'article');
INSERT INTO "Publication" VALUES (338, 'Inherently Nonplanar Automata.', 1976, 'article');
INSERT INTO "Publication" VALUES (339, 'A Model of a Virtual Memory System.', 1976, 'article');
INSERT INTO "Publication" VALUES (340, 'On a Gauntlet Thrown by David Gries.', 1976, 'article');
INSERT INTO "Publication" VALUES (341, 'Resolution of Ambiguity in Parsing.', 1976, 'article');
INSERT INTO "Publication" VALUES (342, 'On the Efficient Implementation of Conditional Critical Regions and the Construction of Monitors.', 1976, 'article');
INSERT INTO "Publication" VALUES (343, 'A Decomposable Model of Program Paging Behaviour.', 1976, 'article');
INSERT INTO "Publication" VALUES (344, 'Transformational Methods and their Application to Complexity Problems.', 1976, 'article');
INSERT INTO "Publication" VALUES (345, 'An Alternative Approach to the Improvement of LR(k) Parsers.', 1976, 'article');
INSERT INTO "Publication" VALUES (346, 'An O(n) Algorithm for Computing the Set of Available Expressions of D-Charts.', 1976, 'article');
INSERT INTO "Publication" VALUES (347, 'Affine Relationships Among Variables of a Program.', 1976, 'article');
INSERT INTO "Publication" VALUES (348, 'Invariants, Composition, and Substitution.', 1995, 'article');
INSERT INTO "Publication" VALUES (349, 'Compositional Refinements in Multiple Blackboard Systems.', 1995, 'article');
INSERT INTO "Publication" VALUES (350, 'Contextual Nets.', 1995, 'article');
INSERT INTO "Publication" VALUES (351, 'What is Failure? An Approach to Constructive Negation.', 1995, 'article');
INSERT INTO "Publication" VALUES (352, 'On the Look-Ahead Problem in Lexical Analysis.', 1995, 'article');
INSERT INTO "Publication" VALUES (353, 'A Modal Logic for Message Passing Processes.', 1995, 'article');
INSERT INTO "Publication" VALUES (354, 'Trace Nets and Process Automata.', 1995, 'article');
INSERT INTO "Publication" VALUES (355, 'Lazy Structure Sharing for Query Optimization.', 1995, 'article');
INSERT INTO "Publication" VALUES (356, 'Parallel Integer Sorting Using Small Operations.', 1995, 'article');
INSERT INTO "Publication" VALUES (357, 'A Formal Identification between Tuples and Lists with an Application to List-Arithmetic Categories.', 1995, 'article');
INSERT INTO "Publication" VALUES (358, 'Specification and Verification of Object-Oriented Programs Using Supertype Abstraction.', 1995, 'article');
INSERT INTO "Publication" VALUES (359, 'Efficient Algorithms for Checking the Atomicity of a Run of Read and Write Operations.', 1995, 'article');
INSERT INTO "Publication" VALUES (360, 'Optimization of a Subclass of Conjunctive Queries.', 1995, 'article');
INSERT INTO "Publication" VALUES (361, 'Concurrent Testing of Processes.', 1995, 'article');
INSERT INTO "Publication" VALUES (362, 'Parallel Tree Contraction and Prefix Computations on a Large Family of Interconnection Topologies.', 1995, 'article');
INSERT INTO "Publication" VALUES (363, 'Inductive Attribute Grammars: A Basis for Incremental Program Execution.', 1995, 'article');
INSERT INTO "Publication" VALUES (364, 'Finding a Maximum Matching in a Permutation Graph.', 1995, 'article');
INSERT INTO "Publication" VALUES (365, 'Reexecution in Abstract Interpretation of Prolog.', 1995, 'article');
INSERT INTO "Publication" VALUES (366, 'Iterative Weighted Finite Transductions.', 1995, 'article');
INSERT INTO "Publication" VALUES (367, 'A Compositional Dataflow Semantics for Petri Nets.', 1995, 'article');
INSERT INTO "Publication" VALUES (368, 'A Transformation Method for Dynamic-Sized Tabulation.', 1995, 'article');
INSERT INTO "Publication" VALUES (369, 'Detecting Morphic Images of a Word on the Rank of a Pattern.', 1995, 'article');
INSERT INTO "Publication" VALUES (370, 'Local Hausdorff Dimension.', 1995, 'article');
INSERT INTO "Publication" VALUES (371, 'IEH Graphs. A Novel Generalization of Hypercube Graphs.', 1995, 'article');
INSERT INTO "Publication" VALUES (372, 'Syntactic Complexity of Scattered Context Grammars.', 1995, 'article');
INSERT INTO "Publication" VALUES (373, 'Abstraction and Performance in the Design of Parallel Programs: An Overview of the SAT Approach.', 2000, 'article');
INSERT INTO "Publication" VALUES (374, 'Evolutionary Systems: A Language Generating Device Inspired by Evolving Communities of Cells.', 2000, 'article');
INSERT INTO "Publication" VALUES (375, 'A Complete Algebraic Characterization of Behavioral Subtyping.', 2000, 'article');
INSERT INTO "Publication" VALUES (376, 'How to Calculate Symmetries of Petri Nets.', 2000, 'article');
INSERT INTO "Publication" VALUES (377, 'On the Generalization of Higman and Kruskal''s Theorems to Regular Languages and Rational Trees.', 2000, 'article');
INSERT INTO "Publication" VALUES (378, 'Reasoning Algebraically about Loops.', 1999, 'article');
INSERT INTO "Publication" VALUES (379, 'Transformational Design of Real-Time Systems Part I: From Requirements to Program Specifications.', 1999, 'article');
INSERT INTO "Publication" VALUES (380, 'Single Machine Scheduling with Deadlines and Increasing Rates of Processing Times.', 2000, 'article');
INSERT INTO "Publication" VALUES (381, 'Optimal Bounds on the Gain of Permitting Dynamic Allocation of Communication Channels in Distributed Computing.', 1999, 'article');
INSERT INTO "Publication" VALUES (382, 'On the Expressiveness of Subset-Sum Representations.', 2000, 'article');
INSERT INTO "Publication" VALUES (383, 'Two Graph Algorithms Derived.', 1999, 'article');
INSERT INTO "Publication" VALUES (384, 'Specifying Communication in Distributed Information Systems.', 2000, 'article');
INSERT INTO "Publication" VALUES (385, 'Type Introduction for Equational Rewriting.', 2000, 'article');
INSERT INTO "Publication" VALUES (386, 'Comparing Expressibility of Normed BPA and Normed BPP Processes.', 1999, 'article');
INSERT INTO "Publication" VALUES (387, 'Querying Sequence Databases with Transducers.', 2000, 'article');
INSERT INTO "Publication" VALUES (388, 'Minimal Huffman Trees.', 2000, 'article');
INSERT INTO "Publication" VALUES (389, 'Data Refinement and Algebraic Structure.', 2000, 'article');
INSERT INTO "Publication" VALUES (390, 'Class Hierarchy Specialization.', 2000, 'article');
INSERT INTO "Publication" VALUES (391, 'On the Cost-Effectiveness of PRAMs.', 1999, 'article');
INSERT INTO "Publication" VALUES (392, 'On Slender 0L Languages over the Binary Alphabet.', 2000, 'article');
INSERT INTO "Publication" VALUES (393, 'Semantic Foundations of 4NF in Relational Database Design.', 1999, 'article');
INSERT INTO "Publication" VALUES (394, 'Towards a Theory of Consistency Enforcement.', 1999, 'article');
INSERT INTO "Publication" VALUES (395, 'Causality for Debugging Mobile Agents.', 1999, 'article');
INSERT INTO "Publication" VALUES (396, 'Reasoning with Examples: Propositional Formulae and Database Dependencies.', 1999, 'article');
INSERT INTO "Publication" VALUES (397, 'Transformational Design of Real-Time Systems. Part II: From Program Specifications to Programs.', 1999, 'article');
INSERT INTO "Publication" VALUES (398, 'Special Factors, Periodicity, and an Application to Sturmian Words.', 2000, 'article');
INSERT INTO "Publication" VALUES (399, 'An Optimal Algorithm for Decomposing a Window into Maximal Quadtree Blocks.', 1999, 'article');
INSERT INTO "Publication" VALUES (400, 'A theory of structural stationarity in the pi -Calculus.', 2009, 'article');
INSERT INTO "Publication" VALUES (401, 'STG decomposition strategies in combination with unfolding.', 2009, 'article');
INSERT INTO "Publication" VALUES (402, 'Extended multi bottom-up tree transducers.', 2009, 'article');
INSERT INTO "Publication" VALUES (403, 'The maximum gain of increasing the number of preemptions in multiprocessor scheduling.', 2009, 'article');
INSERT INTO "Publication" VALUES (404, 'On regular tree languages and deterministic pushdown automata.', 2009, 'article');
INSERT INTO "Publication" VALUES (405, 'Semantics, calculi, and analysis for object-oriented specifications.', 2009, 'article');
INSERT INTO "Publication" VALUES (406, 'Liveness of a mutex algorithm in a fair process algebra.', 2009, 'article');
INSERT INTO "Publication" VALUES (407, 'Strongly transitive automata and the Cerný conjecture.', 2009, 'article');
INSERT INTO "Publication" VALUES (408, 'On decidability of LTL model checking for process rewrite systems.', 2009, 'article');
INSERT INTO "Publication" VALUES (409, 'A complexity tradeoff in ranking-function termination proofs.', 2009, 'article');
INSERT INTO "Publication" VALUES (410, 'Exploiting colored Petri nets to decide on permutation admissibility.', 2009, 'article');
INSERT INTO "Publication" VALUES (411, 'Reasoning about faulty quantum programs.', 2009, 'article');
INSERT INTO "Publication" VALUES (412, 'Hardness of equivalence checking for composed finite-state systems.', 2009, 'article');
INSERT INTO "Publication" VALUES (413, 'The time complexity of typechecking tree-walking tree transducers.', 2009, 'article');
INSERT INTO "Publication" VALUES (414, 'Semi-synchronous transductions.', 2009, 'article');
INSERT INTO "Publication" VALUES (415, 'A theory of ultimately periodic languages and automata with an application to time granularity.', 2009, 'article');
INSERT INTO "Publication" VALUES (416, 'A decomposition theorem for finite persistent transition systems.', 2009, 'article');
INSERT INTO "Publication" VALUES (417, 'On the closure of pattern expressions languages under intersection with regular languages.', 2009, 'article');
INSERT INTO "Publication" VALUES (418, 'Machine structure oriented control code logic.', 2009, 'article');
INSERT INTO "Publication" VALUES (419, 'Correctness proof of a database replication protocol under the perspective of the I/O automaton model.', 2009, 'article');
INSERT INTO "Publication" VALUES (420, 'Hex ist PSPACE-vollständig.', 1981, 'article');
INSERT INTO "Publication" VALUES (421, 'Persistence of Vector Replacement Systems is Decidable.', 1981, 'article');
INSERT INTO "Publication" VALUES (422, 'Klaus Samelson.', 1981, 'article');
INSERT INTO "Publication" VALUES (423, 'A Proof Technique for Communicating Sequential Processes.', 1981, 'article');
INSERT INTO "Publication" VALUES (424, 'Flow Languages Equal Recursively Enumerable Languages.', 1981, 'article');
INSERT INTO "Publication" VALUES (425, 'Binary Search Trees in Secondary Memory.', 1981, 'article');
INSERT INTO "Publication" VALUES (426, 'The Characterization of Parallel Ultralinear Grammars by Rational Power Series.', 1981, 'article');
INSERT INTO "Publication" VALUES (427, 'Recursive Assertions and Parallel Programs.', 1981, 'article');
INSERT INTO "Publication" VALUES (428, 'Approximate Analysis of Exponential Queueing Systems with Blocking.', 1981, 'article');
INSERT INTO "Publication" VALUES (429, 'Parsing Extended  LR(k)  Grammars.', 1981, 'article');
INSERT INTO "Publication" VALUES (430, 'Remarks on R. D. Tennent''s Language Design Methods Based on Semantic Principles: Algol 68, A Language Designed Using Semantic Principles.', 1981, 'article');
INSERT INTO "Publication" VALUES (431, 'Eliminating Unit Reductions from  LR(k)  Parsers Using Minimum Contexts.', 1981, 'article');
INSERT INTO "Publication" VALUES (432, 'The Equivalence of Horn and Network Complexity for Boolean Functions.', 1981, 'article');
INSERT INTO "Publication" VALUES (433, 'Regenerative Simulation of Response Times in Networks of Queues: Statistical Efficiency.', 1981, 'article');
INSERT INTO "Publication" VALUES (434, 'Analysis of a Service Facility with Periodic Checkpointing.', 1981, 'article');
INSERT INTO "Publication" VALUES (435, 'An Improved Complexity Hierarchy on the Depth of Boolean Functions.', 1981, 'article');
INSERT INTO "Publication" VALUES (436, 'A Discrete-Time Round-Robin Queue with Bernoulli Input and General Arithmetic Service Time Distributions.', 1981, 'article');
INSERT INTO "Publication" VALUES (437, 'A Fast Algorithm for Steiner Trees.', 1981, 'article');
INSERT INTO "Publication" VALUES (438, 'Relational structures model of concurrency.', 2008, 'article');
INSERT INTO "Publication" VALUES (439, 'Modelling higher-order dual nondeterminacy.', 2008, 'article');
INSERT INTO "Publication" VALUES (440, 'Applying relation algebra and Rel View to solve problems on orders and lattices.', 2008, 'article');
INSERT INTO "Publication" VALUES (441, 'Adaptive sorting: an information theoretic perspective.', 2008, 'article');
INSERT INTO "Publication" VALUES (442, 'Deciding probabilistic bisimilarity over infinite-state probabilistic systems.', 2008, 'article');
INSERT INTO "Publication" VALUES (443, 'The Boolean closure of linear context-free languages.', 2008, 'article');
INSERT INTO "Publication" VALUES (444, 'Picture deformation.', 2008, 'article');
INSERT INTO "Publication" VALUES (445, 'Regular autodense languages.', 2008, 'article');
INSERT INTO "Publication" VALUES (446, 'Inference rules for proving the equivalence of recursive procedures.', 2008, 'article');
INSERT INTO "Publication" VALUES (447, 'Charting the completeness frontier of inference systems for multivalued dependencies.', 2008, 'article');
INSERT INTO "Publication" VALUES (448, 'Management of interval probabilistic data.', 2008, 'article');
INSERT INTO "Publication" VALUES (449, 'Scattered context grammars that erase nonterminals in a generalized k -limited way.', 2008, 'article');
INSERT INTO "Publication" VALUES (450, 'Two-dimensional packing with conflicts.', 2008, 'article');
INSERT INTO "Publication" VALUES (451, 'Two-tier relaxed heaps.', 2008, 'article');
INSERT INTO "Publication" VALUES (452, 'Algebraic reasoning for probabilistic action systems and while-loops.', 2008, 'article');
INSERT INTO "Publication" VALUES (453, 'The fibers and range of reduction graphs in ciliates.', 2008, 'article');
INSERT INTO "Publication" VALUES (454, 'On an Equivalence between Continuation and Stack Semantics.', 1977, 'article');
INSERT INTO "Publication" VALUES (455, 'The Parsing Problem for Affix Grammars.', 1977, 'article');
INSERT INTO "Publication" VALUES (456, 'Complete Parameterized Families of Job Scheduling Strategies.', 1977, 'article');
INSERT INTO "Publication" VALUES (457, 'Rules of Inference for Procedure Calls.', 1977, 'article');
INSERT INTO "Publication" VALUES (458, 'Concurrent Access to Data.', 1977, 'article');
INSERT INTO "Publication" VALUES (459, 'Backtracking in Recursive Computations.', 1977, 'article');
INSERT INTO "Publication" VALUES (460, 'Some Comments on "Concurrent Readers and Writers".', 1977, 'article');
INSERT INTO "Publication" VALUES (461, 'EOL Forms.', 1977, 'article');
INSERT INTO "Publication" VALUES (462, 'Van Wijngaarden Grammars and Space Complexity Classs EXSPACE.', 1977, 'article');
INSERT INTO "Publication" VALUES (463, 'LAR: A Logic of Algorithmic Reasoning.', 1977, 'article');
INSERT INTO "Publication" VALUES (464, 'Locations Considered Unnecessary.', 1977, 'article');
INSERT INTO "Publication" VALUES (465, 'On Computing the Transitive Closure of a Relation.', 1977, 'article');
INSERT INTO "Publication" VALUES (466, 'Iterative Arrays with Direct Central Control.', 1977, 'article');
INSERT INTO "Publication" VALUES (467, 'General Properties of Derivational Complexity.', 1977, 'article');
INSERT INTO "Publication" VALUES (468, 'Extended Directed Graphs, a Formalism for Structured Data and Data Structures.', 1977, 'article');
INSERT INTO "Publication" VALUES (469, 'The LBA-Problem and the Deterministic Tape Complexity of Two-Way One-Counter Languages over a One-Letter Alphabet.', 1977, 'article');
INSERT INTO "Publication" VALUES (470, 'Proof of Termination within a Weak Logic of Programs.', 1977, 'article');
INSERT INTO "Publication" VALUES (471, 'On a New Approach to Representation Independent Data Classes.', 1977, 'article');
INSERT INTO "Publication" VALUES (472, 'Language Design Methods Based on Semantic Principles.', 1977, 'article');
INSERT INTO "Publication" VALUES (473, 'Nonterminals Versus Homomorphisms in Defining Languages for Some Classes of Rewriting Systems.', 1974, 'article');
INSERT INTO "Publication" VALUES (474, 'Weakly Context-Sensitive Languages as Model for Programming Languages.', 1974, 'article');
INSERT INTO "Publication" VALUES (475, 'Sur une Conjecture de S. Greibach.', 1974, 'article');
INSERT INTO "Publication" VALUES (476, 'Analyse d''un algorithme de gestion simultanée Mémoire centrale - Disque de pagination.', 1974, 'article');
INSERT INTO "Publication" VALUES (477, 'Performance Bounds on the Splitting Algorithm for Binary Testing.', 1974, 'article');
INSERT INTO "Publication" VALUES (478, 'Page Size in Demand-Paging Systems.', 1973, 'article');
INSERT INTO "Publication" VALUES (479, 'Total lineare Realisierbarkeit endlicher Automaten.', 1974, 'article');
INSERT INTO "Publication" VALUES (480, 'Reducing the Number of Multiplikations in Iterative Processes.', 1973, 'article');
INSERT INTO "Publication" VALUES (481, 'Axiomatic Approach to Total Correctness of Programs.', 1974, 'article');
INSERT INTO "Publication" VALUES (482, 'Über die Vernetzungsstruktur von Maschinen.', 1974, 'article');
INSERT INTO "Publication" VALUES (483, 'Eigenschaften der von linearen Automaten erkennbaren Worte.', 1974, 'article');
INSERT INTO "Publication" VALUES (484, 'Optimal Disk Merge Patterns.', 1973, 'article');
INSERT INTO "Publication" VALUES (485, 'Critical Comments on the Programming Language Pascal.', 1973, 'article');
INSERT INTO "Publication" VALUES (486, 'Node Flows in Graphs with Conservative Flow.', 1973, 'article');
INSERT INTO "Publication" VALUES (487, 'An Analytic Storage Allocation Model.', 1974, 'article');
INSERT INTO "Publication" VALUES (488, 'Choosing a Storage Schema.', 1974, 'article');
INSERT INTO "Publication" VALUES (489, 'Normal Forms for Context-Sensitive Grammars.', 1973, 'article');
INSERT INTO "Publication" VALUES (490, 'Bounds on the Parallel Evaluation of Arithmetic Expressions Using Associativity and Commutativity.', 1974, 'article');
INSERT INTO "Publication" VALUES (491, 'A Unified View of the Complexity of Evaluation and Interpolation.', 1974, 'article');
INSERT INTO "Publication" VALUES (492, 'A Note on the Density of Inherently Ambiguous Context-free Languages.', 1980, 'article');
INSERT INTO "Publication" VALUES (493, 'Infinite Proof Rules for Loops.', 1980, 'article');
INSERT INTO "Publication" VALUES (494, 'Optimum Multiway Search Trees.', 1980, 'article');
INSERT INTO "Publication" VALUES (495, 'A Survey of Normal Form Covers for Context Free Grammars.', 1980, 'article');
INSERT INTO "Publication" VALUES (496, 'Correctness of the Compiling Process Based on Axiomatic Semantics.', 1980, 'article');
INSERT INTO "Publication" VALUES (497, 'The `Hoare Logic'' of Concurrent Programs.', 1980, 'article');
INSERT INTO "Publication" VALUES (498, 'On Alternation.', 1980, 'article');
INSERT INTO "Publication" VALUES (499, 'Descriptively Complete Process Logic.', 1980, 'article');
INSERT INTO "Publication" VALUES (500, 'Concurrent Search and Insertion in 2-3 Trees.', 1980, 'article');
INSERT INTO "Publication" VALUES (501, 'Über Separatoren in planaren Graphen.', 1980, 'article');
INSERT INTO "Publication" VALUES (502, 'General Purpose Schedulers for Database Systems.', 1980, 'article');
INSERT INTO "Publication" VALUES (503, 'Evaluation des Performances d''un Algorithme de Controle de la Cohérence d''une Base de Données Répartie.', 1980, 'article');
INSERT INTO "Publication" VALUES (504, 'On Alternation II. A Graph Theoretic Approach to Determinism Versus Nondeterminism.', 1980, 'article');
INSERT INTO "Publication" VALUES (505, 'Semantic Routines and  LR(k)  Parsers.', 1980, 'article');
INSERT INTO "Publication" VALUES (506, 'Hierarchical Program Specification and Verification - a Many-sorted Logical Approach.', 1980, 'article');
INSERT INTO "Publication" VALUES (507, 'An  O(V5/3 E2/3)  Algorithm for the Maximal Flow Problem.', 1980, 'article');
INSERT INTO "Publication" VALUES (508, 'Memory Fragmentation in Buddy Methods for Dynamic Storage Allocation.', 1980, 'article');
INSERT INTO "Publication" VALUES (509, 'Time Lower Bounds for Parallel Sorting on a Mesh-Conected Processor Array.', 1989, 'article');
INSERT INTO "Publication" VALUES (510, 'Computational Algorithms for Networks of Queues with Rejection Blocking.', 1989, 'article');
INSERT INTO "Publication" VALUES (511, 'Attribute (Re)evaluation in OPTRAN.', 1988, 'article');
INSERT INTO "Publication" VALUES (512, 'High Level Tree Transducers and Iterated Pushdown Tree Transducers.', 1988, 'article');
INSERT INTO "Publication" VALUES (513, 'Modeling Splits in File Structures.', 1989, 'article');
INSERT INTO "Publication" VALUES (514, 'Laws of Data Refinement.', 1989, 'article');
INSERT INTO "Publication" VALUES (515, 'Complexity of Distributed Commit Protocols.', 1989, 'article');
INSERT INTO "Publication" VALUES (516, 'Erratum: Predicative Methodology.', 1988, 'article');
INSERT INTO "Publication" VALUES (517, 'Maximum Entropy Two-Station Cyclic Queues with Multiple General Servers.', 1988, 'article');
INSERT INTO "Publication" VALUES (518, 'Through the Mincing Machine with a Boolean Layer Cake.', 1989, 'article');
INSERT INTO "Publication" VALUES (519, 'The Method of Forced Enumeration for Nondeterministic Automata.', 1988, 'article');
INSERT INTO "Publication" VALUES (520, 'Analytic Models for the Primary Site Approach to Fault-Tolerance.', 1989, 'article');
INSERT INTO "Publication" VALUES (521, 'Correctness of Semantic Integrity Checking in Database Management Systems.', 1988, 'article');
INSERT INTO "Publication" VALUES (522, 'Predicate-Transformer Semantics of General Recursion.', 1989, 'article');
INSERT INTO "Publication" VALUES (523, 'A Family of NP-Complete Data Aggregation Problems.', 1989, 'article');
INSERT INTO "Publication" VALUES (524, 'The Expected Additive Weight of Trees.', 1989, 'article');
INSERT INTO "Publication" VALUES (525, 'Stable Duplicate-Key Extraction with Optimal Time and Space Bounds.', 1989, 'article');
INSERT INTO "Publication" VALUES (526, 'On the Finite Degree of Ambiguity of Finite Tree Automata.', 1989, 'article');
INSERT INTO "Publication" VALUES (527, 'The Expected Behaviour of B+-Trees.', 1989, 'article');
INSERT INTO "Publication" VALUES (528, 'Rational Index of Vector Addition Systems Languages.', 1989, 'article');
INSERT INTO "Publication" VALUES (529, 'Continuous Reductions Among Combinatorial Optimization Problems.', 1989, 'article');
INSERT INTO "Publication" VALUES (530, 'The Formal Development of a Parallel Program Performing LU-Decomposition.', 1988, 'article');
INSERT INTO "Publication" VALUES (531, 'Erratum: Maximum Entropy Two-Station Cyclic Queues with Multiple General Servers.', 1989, 'article');
INSERT INTO "Publication" VALUES (532, 'Metatheorems for Decision Problems on Hyperedge Replacement Graph Languages.', 1989, 'article');
INSERT INTO "Publication" VALUES (533, 'Supercube: An Optimally Fault Tolerant Network Architecture.', 1989, 'article');
INSERT INTO "Publication" VALUES (534, 'Iterated GSMs and Co-CFL.', 1989, 'article');
INSERT INTO "Publication" VALUES (535, 'Unsafe Operations in B-Trees.', 1989, 'article');
INSERT INTO "Publication" VALUES (536, 'Applications of the Theory of Records in the Study of Random Trees.', 1988, 'article');
INSERT INTO "Publication" VALUES (537, 'A Balanced Search Tree with  O  (1) Worst-case Update Time.', 1988, 'article');
INSERT INTO "Publication" VALUES (538, 'On Counting and Approximation.', 1989, 'article');
INSERT INTO "Publication" VALUES (539, 'Special issue on "Combining Compositionality and Concurrency": part 1.', 2015, 'article');
INSERT INTO "Publication" VALUES (540, 'State space axioms for T-systems.', 2015, 'article');
INSERT INTO "Publication" VALUES (541, 'Richer interface automata with optimistic and pessimistic compatibility.', 2015, 'article');
INSERT INTO "Publication" VALUES (542, 'Compositional construction of most general controllers.', 2015, 'article');
INSERT INTO "Publication" VALUES (543, 'On constructibility and unconstructibility of LTS operators from other LTS operators.', 2015, 'article');
INSERT INTO "Publication" VALUES (544, 'Some properties of involution binary relations.', 2015, 'article');
INSERT INTO "Publication" VALUES (545, 'Contextual hyperedge replacement.', 2015, 'article');
INSERT INTO "Publication" VALUES (546, 'Letter from the Managing Editor.', 2015, 'article');
INSERT INTO "Publication" VALUES (547, 'A life dedicated to informatics: an obituary for Prof. Friedrich L. Bauer.', 2015, 'article');
INSERT INTO "Publication" VALUES (548, 'Modal algebra and Petri nets.', 2015, 'article');
INSERT INTO "Publication" VALUES (549, 'CCS: It''s not fair! - Fair schedulers cannot be implemented in CCS-like languages even under progress and certain fairness assumptions.', 2015, 'article');
INSERT INTO "Publication" VALUES (550, 'Two-way pebble transducers for partial functions and their composition.', 2015, 'article');
INSERT INTO "Publication" VALUES (551, 'Denotational fixed-point semantics for constructive scheduling of synchronous concurrency.', 2015, 'article');
INSERT INTO "Publication" VALUES (552, 'Gray code orders for q-ary words avoiding a given factor.', 2015, 'article');
INSERT INTO "Publication" VALUES (553, 'Parametrized invariance for infinite state processes.', 2015, 'article');
INSERT INTO "Publication" VALUES (554, 'Observable liveness of Petri nets.', 2015, 'article');
INSERT INTO "Publication" VALUES (555, 'Synthesis and reengineering of persistent systems.', 2015, 'article');
INSERT INTO "Publication" VALUES (556, 'Complete Problems for Space Bounded Subclasses of NP.', 1985, 'article');
INSERT INTO "Publication" VALUES (557, 'A Functional Model for Describing and Reasoning About Time Behaviour of Computing Systems.', 1986, 'article');
INSERT INTO "Publication" VALUES (558, 'The Family of One-Counter Languages is Closed Under Quotient.', 1985, 'article');
INSERT INTO "Publication" VALUES (559, 'General Correctness: A Unification of Partial and Total Correctness.', 1985, 'article');
INSERT INTO "Publication" VALUES (560, 'Purely Top-Down Updating Algorithms for Stratified Search Trees.', 1985, 'article');
INSERT INTO "Publication" VALUES (561, 'Thrifty Execution of Task Pipelines.', 1985, 'article');
INSERT INTO "Publication" VALUES (562, 'Optimum Decision Trees - An Optimal Variable Theorem and its Related Applications.', 1985, 'article');
INSERT INTO "Publication" VALUES (563, 'An Algorithm for Merging Heaps.', 1985, 'article');
INSERT INTO "Publication" VALUES (564, 'Short Proofs for Tricky Formulas.', 1985, 'article');
INSERT INTO "Publication" VALUES (565, 'Replaceability and Computational Equivalence for Monotone Boolean Functions.', 1985, 'article');
INSERT INTO "Publication" VALUES (566, 'Necessary and Sufficient Conditions for the Universality of Programming Formalisms.', 1985, 'article');
INSERT INTO "Publication" VALUES (567, 'Erratum: Proving Properties of Pascal Programs in MIZAR 2.', 1986, 'article');
INSERT INTO "Publication" VALUES (568, 'An Effectively Given Initial Semigroup.', 1985, 'article');
INSERT INTO "Publication" VALUES (569, 'Truly Prefix-Correct Chain-Free  LR  (1) Parsers.', 1985, 'article');
INSERT INTO "Publication" VALUES (570, 'Strongest Invariant Functions: Their Use in the Systematic Analysis of While Statements.', 1985, 'article');
INSERT INTO "Publication" VALUES (571, 'A 2.5n Lower Bound on the Monotone Network Complexity of T_3^n.', 1985, 'article');
INSERT INTO "Publication" VALUES (572, 'Decidable Properties of Monadic Recursive Schemas With a Depth Parameter.', 1985, 'article');
INSERT INTO "Publication" VALUES (573, 'On the Algebraic Specification of Infinite Objects - Ordered and Continuous Models of Algebraic Types.', 1985, 'article');
INSERT INTO "Publication" VALUES (574, 'Ramsey Numbers and an Approximation Algorithm for the Vertex Cover Problem.', 1985, 'article');
INSERT INTO "Publication" VALUES (575, 'Querying Fragmented Relations in a Distributed Database.', 1985, 'article');
INSERT INTO "Publication" VALUES (576, 'Fooling a Two-Way Nondeterministic Multihead Automaton with Reversal Number Restriction.', 1985, 'article');
INSERT INTO "Publication" VALUES (577, 'Throughput of a Satellite Channel Communication.', 1985, 'article');
INSERT INTO "Publication" VALUES (578, 'Rewrite Systems on a Lattice of Types.', 1985, 'article');
INSERT INTO "Publication" VALUES (579, 'Minimal Coverings for Incompletely Specified Sequential Machines.', 1986, 'article');
INSERT INTO "Publication" VALUES (580, 'Drawing Plane Graphs Nicely.', 1985, 'article');
INSERT INTO "Publication" VALUES (581, 'Analysis of Tree Algorithms for the Simulation Event List.', 1985, 'article');
INSERT INTO "Publication" VALUES (582, 'A Priority Queue With Interruptions of Service Permitted After a Time Quantum.', 1985, 'article');
INSERT INTO "Publication" VALUES (583, 'On Scheduling Tasks with Exponential Service Times and In-Tree Precedence Constraints.', 1985, 'article');
INSERT INTO "Publication" VALUES (584, 'Complexity of the Word Problem for Commutative Semigroups of Fixed Dimension.', 1985, 'article');
INSERT INTO "Publication" VALUES (585, 'Two Notions of Correctness and Their Relation to Testing.', 1982, 'article');
INSERT INTO "Publication" VALUES (586, 'Systolic Automata for VLSI on Balanced Trees.', 1982, 'article');
INSERT INTO "Publication" VALUES (587, 'Finite State Relational Programs.', 1982, 'article');
INSERT INTO "Publication" VALUES (588, 'Optimum Reorganization Points for Arbitrary Database Costs.', 1982, 'article');
INSERT INTO "Publication" VALUES (589, 'Logic for Improving Integrity Checking in Relational Data Bases.', 1982, 'article');
INSERT INTO "Publication" VALUES (590, 'Stratified Balanced Search Trees.', 1982, 'article');
INSERT INTO "Publication" VALUES (591, 'Lower Bounds for On-Line Two-Dimensional Packing Algorithms.', 1982, 'article');
INSERT INTO "Publication" VALUES (592, 'An Alternative Implementation of an Insertion-Only Recovery Technique.', 1982, 'article');
INSERT INTO "Publication" VALUES (593, 'On an Exponential Server with General Cyclic Arrivals.', 1982, 'article');
INSERT INTO "Publication" VALUES (594, 'Further Analysis of Code Generation for a Single Register Machine.', 1982, 'article');
INSERT INTO "Publication" VALUES (595, 'Concurrent Algorithms for Root Searching.', 1982, 'article');
INSERT INTO "Publication" VALUES (596, 'Verification of Programs with Procedure-Type Parameter.', 1982, 'article');
INSERT INTO "Publication" VALUES (597, 'A Network for the Detection of Words in Continuous Speech.', 1982, 'article');
INSERT INTO "Publication" VALUES (598, 'Some Modified Algorithms for Dijkstra''s Longest Upsequence Problem.', 1982, 'article');
INSERT INTO "Publication" VALUES (599, 'Partage de tâches entre processeurs homogenes.', 1982, 'article');
INSERT INTO "Publication" VALUES (600, 'Deriving very Efficient Algorithms for Evaluating Linear Recurrence Relations Using the Program Transformation Technique.', 1982, 'article');
INSERT INTO "Publication" VALUES (601, 'The Complexity of Drawing Trees Nicely.', 1982, 'article');
INSERT INTO "Publication" VALUES (602, 'A Longest Common Subsequence Algorithm Suitable for Similar Text Strings.', 1982, 'article');
INSERT INTO "Publication" VALUES (603, 'Best Huffman Trees.', 1981, 'article');
INSERT INTO "Publication" VALUES (604, 'Behandlung verschiedener INTEGER-Darstellungen durch optimierende Compiler.', 1981, 'article');
INSERT INTO "Publication" VALUES (605, 'The Clean Termination of Iterative Programs.', 1981, 'article');
INSERT INTO "Publication" VALUES (606, 'A Characterization of Context-free String Languages by Directed Node-label Controlled Graph Grammars.', 1981, 'article');
INSERT INTO "Publication" VALUES (607, 'Another Look at the "Longest Ascending Subsequence" Problem.', 1981, 'article');
INSERT INTO "Publication" VALUES (608, 'A Gap Between the Actual Complexity of Permutations and Their Entropy Defined by Stoß.', 1981, 'article');
INSERT INTO "Publication" VALUES (609, 'Parsing Regular Grammars with Finite Lookahead.', 1981, 'article');
INSERT INTO "Publication" VALUES (610, 'A Characterization of Attribute Evaluation in Passes.', 1981, 'article');
INSERT INTO "Publication" VALUES (611, 'A Characterization of Database Graphs Admitting a Simple Locking Protocol.', 1981, 'article');
INSERT INTO "Publication" VALUES (612, 'Sound and Complete Hoare-like Calculi Based on Copy Rules.', 1981, 'article');
INSERT INTO "Publication" VALUES (613, 'Varepsilon-Productions in Context-Free Grammars.', 1981, 'article');
INSERT INTO "Publication" VALUES (614, 'The Formal Power of One-Visit Attribute Grammars.', 1981, 'article');
INSERT INTO "Publication" VALUES (615, 'On the Response Time Distribution in a Discrete Round-Robin Queue.', 1981, 'article');
INSERT INTO "Publication" VALUES (616, 'Problematic Features of Programming Languages: A Situational-Calculus Approach.', 1981, 'article');
INSERT INTO "Publication" VALUES (617, 'On the Use of History Variables.', 1981, 'article');
INSERT INTO "Publication" VALUES (618, 'An Analysis of two Related Loop-free Algorithms for Generating Integer Partitions.', 1981, 'article');
INSERT INTO "Publication" VALUES (619, 'On Efficient Entreeings.', 1993, 'article');
INSERT INTO "Publication" VALUES (620, 'On the Synchronization in Parallel Communicating Grammar Systems.', 1993, 'article');
INSERT INTO "Publication" VALUES (621, 'Program Refinement in Fair Transition Systems.', 1993, 'article');
INSERT INTO "Publication" VALUES (622, 'Models for Reactivity.', 1993, 'article');
INSERT INTO "Publication" VALUES (623, 'Frameworks for Abstract Interpretation.', 1993, 'article');
INSERT INTO "Publication" VALUES (624, 'OBSCURE: A Specification Language for Abstract Data Types.', 1993, 'article');
INSERT INTO "Publication" VALUES (625, 'Logical and Schematic Characterization of Complexity Classes.', 1993, 'article');
INSERT INTO "Publication" VALUES (626, 'On Simplest Possible Solutions for Post Correspondence Problems.', 1993, 'article');
INSERT INTO "Publication" VALUES (627, 'From ATP to Timed Graphs and Hybrid Systems.', 1993, 'article');
INSERT INTO "Publication" VALUES (628, 'Querying Datalog Programs with Temporal Logic.', 1993, 'article');
INSERT INTO "Publication" VALUES (629, 'On the Expected Height of Fringe-Balanced Trees.', 1993, 'article');
INSERT INTO "Publication" VALUES (630, 'Infinitary Parallelism without Unbounded Nondeterminism in CSP.', 1993, 'article');
INSERT INTO "Publication" VALUES (631, 'A Characterisation of Meet and Join Respecting Pre-Orders and Congruences on Finite Lattices.', 1993, 'article');
INSERT INTO "Publication" VALUES (632, 'Unavoidable Binary Patterns.', 1993, 'article');
INSERT INTO "Publication" VALUES (633, 'Speeding up Dynamic Transitive Closure for Bounded Degree Graphs.', 1993, 'article');
INSERT INTO "Publication" VALUES (634, 'Scheduling Saves in Fault-Tolerant Computations.', 1993, 'article');
INSERT INTO "Publication" VALUES (635, 'Satisfiability of Co-Nested Formulas.', 1993, 'article');
INSERT INTO "Publication" VALUES (636, 'Normal Form Approach to Compiler Design.', 1993, 'article');
INSERT INTO "Publication" VALUES (637, 'L-Systems and Mutually Resurcive Function Systems.', 1993, 'article');
INSERT INTO "Publication" VALUES (638, 'Contextual Rewriting as a Sound and Complete Proof Method for Conditional LOG-Specifications.', 1993, 'article');
INSERT INTO "Publication" VALUES (639, 'Implementing Daubechies Wavelet Transform with Weighted Finite Automata.', 1997, 'article');
INSERT INTO "Publication" VALUES (640, 'Minimum Feedback Vertex Sets in Cocomparability Graphs and Convex Bipartite Graphs.', 1997, 'article');
INSERT INTO "Publication" VALUES (641, 'Context-Free Graph Grammars and Concatenation of Graphs.', 1997, 'article');
INSERT INTO "Publication" VALUES (642, 'Performance Preorder and Competitive Equivalence.', 1997, 'article');
INSERT INTO "Publication" VALUES (643, 'Distance Measures for Point Sets and their Computation.', 1997, 'article');
INSERT INTO "Publication" VALUES (644, 'On the System of word equations x^i_1 x^i_2 ... x^i_m = y^i_1 y^i_2 ...y^i_n (i=1, 2, ...) in a Free Monoid.', 1997, 'article');
INSERT INTO "Publication" VALUES (645, 'Relational Database Constraints as Counterexamples.', 1997, 'article');
INSERT INTO "Publication" VALUES (646, 'Computational Fractal Geometry with WFA.', 1997, 'article');
INSERT INTO "Publication" VALUES (647, 'Unconditional Transfer in Regulated Rewriting.', 1997, 'article');
INSERT INTO "Publication" VALUES (648, 'A Fine-Grained Data-Flow Analysis Framework.', 1997, 'article');
INSERT INTO "Publication" VALUES (649, 'A Hierarchy of Uniquely Parsable Grammar Classes and Deterministic Acceptors.', 1997, 'article');
INSERT INTO "Publication" VALUES (650, 'Using the Causal Domain to Specify and verify Distributed Programs.', 1997, 'article');
INSERT INTO "Publication" VALUES (651, 'Using Graph Coloring in an Algebraic Compiler.', 1997, 'article');
INSERT INTO "Publication" VALUES (652, 'Decidability of Model Checking for Infinite-State Concurrent Systems.', 1997, 'article');
INSERT INTO "Publication" VALUES (653, 'Dynamic LL(k) Parsing.', 1997, 'article');
INSERT INTO "Publication" VALUES (654, 'Weakly Independent Database Schemes.', 1997, 'article');
INSERT INTO "Publication" VALUES (655, 'Performance Analysis of Parallel Programs Based on Directed Acyclic Graphs.', 1997, 'article');
INSERT INTO "Publication" VALUES (656, 'Testing Bag-Containment of Conjunctive Queries.', 1997, 'article');
INSERT INTO "Publication" VALUES (657, 'A Survey of Stream Processing.', 1997, 'article');
INSERT INTO "Publication" VALUES (658, 'Fundamentals of Modelling Concurrency Using Discrete Relational Structures.', 1997, 'article');
INSERT INTO "Publication" VALUES (659, 'Easy Sets and Hard Certificate Schemes.', 1997, 'article');
INSERT INTO "Publication" VALUES (660, 'Minimal Communication Cost Software Construction in the Internet Environment.', 1997, 'article');
INSERT INTO "Publication" VALUES (661, 'Locality Based Semantics for Process Algebras.', 1997, 'article');
INSERT INTO "Publication" VALUES (662, 'Functional Behavior in Data Spaces.', 1978, 'article');
INSERT INTO "Publication" VALUES (663, 'Eliminating Unit Productions from LR Parsers.', 1977, 'article');
INSERT INTO "Publication" VALUES (664, 'Data Encodings and Their Costs.', 1978, 'article');
INSERT INTO "Publication" VALUES (665, 'Program Analysis and Optimization through Kernel-Control Decomposition.', 1978, 'article');
INSERT INTO "Publication" VALUES (666, 'Orthogonality of Information Structures.', 1978, 'article');
INSERT INTO "Publication" VALUES (667, 'Concurrency of Operations on  B-Trees.', 1977, 'article');
INSERT INTO "Publication" VALUES (668, 'Subrekursive Komplexität bei Gruppen: II. Der Einbettungssatz von Higman für entscheidbare Gruppen.', 1978, 'article');
INSERT INTO "Publication" VALUES (669, 'A Multiclass Networt Model of a Demand Paging Computer System.', 1978, 'article');
INSERT INTO "Publication" VALUES (670, 'Worst-Case Analysis for Region and Partial Region Searches in Multidimensional Binary Search Trees and Balanced Quad Trees.', 1977, 'article');
INSERT INTO "Publication" VALUES (671, 'A Unified Approach to the Generation and the Acception of Formal Languages.', 1978, 'article');
INSERT INTO "Publication" VALUES (672, 'The Report on the Standard Hardware Representation for ALGOL 68.', 1978, 'article');
INSERT INTO "Publication" VALUES (673, 'A Proof Method for Cyclic Programs.', 1978, 'article');
INSERT INTO "Publication" VALUES (674, 'On the Complexity of Formal Grammars.', 1978, 'article');
INSERT INTO "Publication" VALUES (675, 'Static Main Storage Packing Problems.', 1978, 'article');
INSERT INTO "Publication" VALUES (676, 'Proving Programs Correct through Refinement.', 1978, 'article');
INSERT INTO "Publication" VALUES (677, 'Die Zeitkomplexität des Normalisierungsproblems bei kontextsensitiven Grammatiken.', 1978, 'article');
INSERT INTO "Publication" VALUES (678, 'Axioms for Total Correctness.', 1977, 'article');
INSERT INTO "Publication" VALUES (679, 'Dispatcher Primitives for the Construction of Operating System Kernels.', 1975, 'article');
INSERT INTO "Publication" VALUES (680, 'A Decidability Criterion for van Wijngaarden Grammars.', 1975, 'article');
INSERT INTO "Publication" VALUES (681, 'Interactaive Graphics on Intelligent Terminals in a Time-Sharing Environment.', 1975, 'article');
INSERT INTO "Publication" VALUES (682, 'A Note on Degrees of Context-Sensitivity.', 1975, 'article');
INSERT INTO "Publication" VALUES (683, 'Formal Semantics of a Class of High-Level Primitives for Coordinating Concurrent Processes', 1975, 'article');
INSERT INTO "Publication" VALUES (684, 'A Note on Multihead Automata and Context-Sensitive Languages', 1973, 'article');
INSERT INTO "Publication" VALUES (685, 'Zur Theorie der Partiell-linearen Realisierungen endlicher Automaten', 1973, 'article');
INSERT INTO "Publication" VALUES (686, 'Sur diverses familles de langages fermées par transductions rationelle', 1973, 'article');
INSERT INTO "Publication" VALUES (687, 'On Procedures as Open Subroutines. I', 1973, 'article');
INSERT INTO "Publication" VALUES (688, 'Die mittlere Additionsdauer eines Paralleladdierwerks', 1973, 'article');
INSERT INTO "Publication" VALUES (689, 'A Reply to Comments on "A Comparison of Two Synchronizing Concepts"', 1973, 'article');
INSERT INTO "Publication" VALUES (690, 'Fast Algorithms for the Elimination of Common Subexpressions', 1973, 'article');
INSERT INTO "Publication" VALUES (691, 'Developmental Systems with Locally Catenative Formulas', 1973, 'article');
INSERT INTO "Publication" VALUES (692, 'Relational Level Data Structures for Programming Languages', 1973, 'article');
INSERT INTO "Publication" VALUES (693, 'Program Proving: Coroutines.', 1973, 'article');
INSERT INTO "Publication" VALUES (694, 'Sequential and Jumping Machines and their Relation to Computers', 1973, 'article');
INSERT INTO "Publication" VALUES (695, 'Familles de langages translatables et fermées par crochet', 1973, 'article');
INSERT INTO "Publication" VALUES (696, 'Minimale und m-minimale Variablenmengen für partielle Boole''sche Funktionen', 1973, 'article');
INSERT INTO "Publication" VALUES (697, 'Job Scheduling Guaranteeing Reasonable Turn-Around Times.', 1973, 'article');
INSERT INTO "Publication" VALUES (698, 'Synchronisationsgraphen', 1973, 'article');
INSERT INTO "Publication" VALUES (699, 'Efficient LR(1) Parsers.', 1973, 'article');
INSERT INTO "Publication" VALUES (700, 'Describing an Algorithm by Hopcroft', 1973, 'article');
INSERT INTO "Publication" VALUES (701, 'On Sentential Forms of Context-Free Grammars.', 1973, 'article');
INSERT INTO "Publication" VALUES (702, 'A Recursive Second Order Initial Algebra Specification of Primitive Recursion.', 1994, 'article');
INSERT INTO "Publication" VALUES (703, 'Context-Free Graph Languages of Bounded Degree are Generated by Apex Graph Grammars.', 1994, 'article');
INSERT INTO "Publication" VALUES (704, 'Domain Independence and the Relational Calculus.', 1994, 'article');
INSERT INTO "Publication" VALUES (705, 'Behavioural Approaches to Algebraic Specifications: A Comparative Study.', 1994, 'article');
INSERT INTO "Publication" VALUES (706, 'The Lattice of Data Refinement.', 1994, 'article');
INSERT INTO "Publication" VALUES (707, 'Comparing Locality and Causality Based Equivalences.', 1994, 'article');
INSERT INTO "Publication" VALUES (708, 'Petri Net Algorithms in the Theory of Matrix Grammars.', 1994, 'article');
INSERT INTO "Publication" VALUES (709, 'Geometrical Tools to Map Systems of Affine Recurrence Equations on Regular Arrays.', 1994, 'article');
INSERT INTO "Publication" VALUES (710, 'Information Theoretic Approximations for the  M/G/  1 Retrial Queue.', 1994, 'article');
INSERT INTO "Publication" VALUES (711, 'Update Operations in Deductive Databases with Functional Dependencies.', 1994, 'article');
INSERT INTO "Publication" VALUES (712, 'Synthesized and Inherited Functions. A new Computational Model for Syntax-Directed Semantic.', 1994, 'article');
INSERT INTO "Publication" VALUES (713, 'On two Families of Forests.', 1994, 'article');
INSERT INTO "Publication" VALUES (714, 'On Bounds of Response Time Performance Achievable by Multiclass Single-Server Queues.', 1994, 'article');
INSERT INTO "Publication" VALUES (715, 'Deterministic Asynchronous Automata for Infinite Traces.', 1994, 'article');
INSERT INTO "Publication" VALUES (716, 'Context-free Text Grammars.', 1994, 'article');
INSERT INTO "Publication" VALUES (717, 'A. Nico Habermann 1932-1993.', 1994, 'article');
INSERT INTO "Publication" VALUES (718, 'On Problems with Short Certificates.', 1994, 'article');
INSERT INTO "Publication" VALUES (719, 'Heuristics for Parallel Machine Scheduling with Delivery Times.', 1994, 'article');
INSERT INTO "Publication" VALUES (720, 'Proving Finiteness of CCS Processes by Non-Standard Semantics.', 1994, 'article');
INSERT INTO "Publication" VALUES (721, 'Well Quasi-Orders and Regular Languages.', 1994, 'article');
INSERT INTO "Publication" VALUES (722, 'Optimal Search Trees Using Two-Way Key Comparisons.', 1994, 'article');
INSERT INTO "Publication" VALUES (723, 'The Path Length of Random Skip Lists.', 1994, 'article');
INSERT INTO "Publication" VALUES (724, 'Modularity and Reusability in Attribute Grammars.', 1994, 'article');
INSERT INTO "Publication" VALUES (725, 'Object Inheritance Beyond Subtyping.', 1994, 'article');
INSERT INTO "Publication" VALUES (726, 'Sorting Multisets Stably in Minimum Space.', 1994, 'article');
INSERT INTO "Publication" VALUES (727, 'Tree Automata for Code Selection.', 1994, 'article');
INSERT INTO "Publication" VALUES (728, 'COSY - A System Specification Language Based on Paths and Processes.', 1979, 'article');
INSERT INTO "Publication" VALUES (729, 'On a Class of Recursive Procedures and Equivalent Iterative Ones.', 1979, 'article');
INSERT INTO "Publication" VALUES (730, 'Formal Derivation of Strongly Correct Concurrent Programs.', 1979, 'article');
INSERT INTO "Publication" VALUES (731, 'Size-Depth Tradeoff in Monotone Boolean Formulae.', 1979, 'article');
INSERT INTO "Publication" VALUES (732, 'The Multiple Phase Service Network with Generalized Processor Sharing.', 1979, 'article');
INSERT INTO "Publication" VALUES (733, 'A Method for Transforming Grammars into LL(k) Form.', 1979, 'article');
INSERT INTO "Publication" VALUES (734, 'Sequential Method in Propositional Dynamic Logic.', 1979, 'article');
INSERT INTO "Publication" VALUES (735, 'Generalized Recursive Data Structures.', 1979, 'article');
INSERT INTO "Publication" VALUES (736, 'Some Remarks on Boolean Sums.', 1979, 'article');
INSERT INTO "Publication" VALUES (737, 'Lower Bounds on Space Complexity for Contextfree Recognition.', 1979, 'article');
INSERT INTO "Publication" VALUES (738, 'On Languages Accepted by Space-Bounded Oracle Machines.', 1979, 'article');
INSERT INTO "Publication" VALUES (739, 'Regenerative Simulation of Response Times in Networks of Queues with Multiple Job Types.', 1979, 'article');
INSERT INTO "Publication" VALUES (740, 'Pascal-Clarifications and Recommended Extensions.', 1979, 'article');
INSERT INTO "Publication" VALUES (741, 'On Parallel Integer Sorting.', 1992, 'article');
INSERT INTO "Publication" VALUES (742, 'An Efficiency Preorder for Processes.', 1992, 'article');
INSERT INTO "Publication" VALUES (743, 'Languages Accepted by Systolic Y-Tree Automata: Structural Characterizations.', 1992, 'article');
INSERT INTO "Publication" VALUES (744, 'Classes of Systolic Y-Tree Automata and a Comparison with Systolic Trellis Automata.', 1992, 'article');
INSERT INTO "Publication" VALUES (745, 'A Class of Coders Based on GSM.', 1992, 'article');
INSERT INTO "Publication" VALUES (746, 'An All-Round Sweep Algorithm for 2-Dimensional Nearest-Neighbor Problems.', 1992, 'article');
INSERT INTO "Publication" VALUES (747, 'A Run-Time Load Balancing Strategy for Highly Parallel Systems.', 1992, 'article');
INSERT INTO "Publication" VALUES (748, 'Expressibility of Output Equals Input.', 1992, 'article');
INSERT INTO "Publication" VALUES (749, 'A Simple, Fast, and Effective LL(1) Error Repair Algorithm.', 1992, 'article');
INSERT INTO "Publication" VALUES (750, 'A Model and a Fast Algorithm for Multiple Errors Spelling Correction.', 1992, 'article');
INSERT INTO "Publication" VALUES (751, 'A Robust and Efficient Spatial Data Structure.', 1992, 'article');
INSERT INTO "Publication" VALUES (752, 'Deterministic Sequential Functions.', 1992, 'article');
INSERT INTO "Publication" VALUES (753, 'Analysis of a Class of Communicating Finite State Machines.', 1992, 'article');
INSERT INTO "Publication" VALUES (754, 'Single Machine Flow-Time Scheduling with Scheduled Maintenance.', 1992, 'article');
INSERT INTO "Publication" VALUES (755, 'A "Yo-Yo" Parsing Algorithm for a Large Class of van Wijngaarden Grammars.', 1992, 'article');
INSERT INTO "Publication" VALUES (756, 'On the Lengths of Values in a Finite Transducer.', 1992, 'article');
INSERT INTO "Publication" VALUES (757, 'The SB-Tree: An Index-Sequential Structure for High-Performance Sequential Access.', 1992, 'article');
INSERT INTO "Publication" VALUES (758, 'Elementary Transition Systems and Refinement.', 1992, 'article');
INSERT INTO "Publication" VALUES (759, 'Receptive Process Theory.', 1992, 'article');
INSERT INTO "Publication" VALUES (760, 'An Experience in Proving Regular Networks of Processes by Modular Model Checking.', 1992, 'article');
INSERT INTO "Publication" VALUES (761, 'Stacks, Queues, and Deques with Order-Statistic Operations.', 1992, 'article');
INSERT INTO "Publication" VALUES (762, 'Context-Free Hypergraph Grammars have the Same Term-Generating Power as Attribute Grammars.', 1992, 'article');
INSERT INTO "Publication" VALUES (763, 'On Partitions and Presortedness of Sequences.', 1992, 'article');
INSERT INTO "Publication" VALUES (764, 'An Algebra for Process Creation.', 1992, 'article');
INSERT INTO "Publication" VALUES (765, 'Unbalanced Multiway Trees Improved by Partial Expansions.', 1992, 'article');
INSERT INTO "Publication" VALUES (766, 'On-Line Multiversion Database Concurrency Control.', 1992, 'article');
INSERT INTO "Publication" VALUES (767, 'Two Impossibility Theorems on Behaviour Specification of Abstract Data Types.', 1992, 'article');
INSERT INTO "Publication" VALUES (768, 'Toward Formal Development of Programs from Algebraic Specifications: Parameterisation Revisited.', 1992, 'article');
INSERT INTO "Publication" VALUES (769, 'Every Binary Pattern of Length Six is Avoidable on the Two-Letter Alphabet.', 1992, 'article');
INSERT INTO "Publication" VALUES (770, 'Quad Trees: A Data Structure for Retrieval on Composite Keys.', 1974, 'article');
INSERT INTO "Publication" VALUES (771, 'Automatic Correction of Syntax-Errors in Programming Languages.', 1974, 'article');
INSERT INTO "Publication" VALUES (772, 'Algorithms for Fast Evaluation of Boolean Expressions.', 1975, 'article');
INSERT INTO "Publication" VALUES (773, 'Nonterminals, Homomorphisms and Codings in Different Variations of OL-Systems.  I. Deterministic Systems.', 1974, 'article');
INSERT INTO "Publication" VALUES (774, 'A Model of a Time Sharing Virtual Memory System Solved Using Equivalence and Decomposition Methods.', 1974, 'article');
INSERT INTO "Publication" VALUES (775, 'A Principle of Independence for Binary Tree Searching.', 1974, 'article');
INSERT INTO "Publication" VALUES (776, 'A Branch-and-Bound Algorithm to Obtain an Optimal Evaluation Tree for Monotonic Boolean Functions.', 1975, 'article');
INSERT INTO "Publication" VALUES (777, 'On 3-Head Versus 2-Head Finite Automata.', 1974, 'article');
INSERT INTO "Publication" VALUES (778, 'Semantic Decomposition of Computer Programs: An Aid to Program Testing.', 1974, 'article');
INSERT INTO "Publication" VALUES (779, 'EOL Systems with Control Devices.', 1974, 'article');
INSERT INTO "Publication" VALUES (780, 'Ambiguity and Precedence in Syntax Description.', 1974, 'article');
INSERT INTO "Publication" VALUES (781, 'Grundlagen einer Theorie der Datenstrukturen und Zugriffssysteme. Teil I: Datenstrukturen und Schemata.', 1974, 'article');
INSERT INTO "Publication" VALUES (782, 'Automatic Program Verification I: A Logical Basis and its Implementation.', 1974, 'article');
INSERT INTO "Publication" VALUES (783, 'The Stability Problem of Broadcast Packet Switching Computer Networks.', 1974, 'article');
INSERT INTO "Publication" VALUES (784, 'Grundlagen einer Theorie der Datenstrukturen und Zugriffssysteme. Teil II: Zugriffssysteme.', 1974, 'article');
INSERT INTO "Publication" VALUES (785, 'More Comments on the Programming Language Pascal.', 1974, 'article');
INSERT INTO "Publication" VALUES (786, 'Multipass Precedence Analysis.', 1974, 'article');
INSERT INTO "Publication" VALUES (787, 'WCS-Analysis of the Context-Sensitive.', 1974, 'article');
INSERT INTO "Publication" VALUES (788, 'On the Number of Relational Operators Necessary to Compute Certain Functions of Real Variables.', 1983, 'article');
INSERT INTO "Publication" VALUES (789, 'The Construction of Operator Interfaces Based on Logical Input Devices.', 1983, 'article');
INSERT INTO "Publication" VALUES (790, 'The Implementation of Retention in a Coroutine Environment.', 1983, 'article');
INSERT INTO "Publication" VALUES (791, 'Storage Utilization in B*-Trees with a Generalized Overflow Technique.', 1983, 'article');
INSERT INTO "Publication" VALUES (792, 'Complexity of Analyzing the Synchronization Structure of Concurrent Programs.', 1983, 'article');
INSERT INTO "Publication" VALUES (793, 'A Lower Time Bound for the Knapsack Problem on Random Access Machines.', 1983, 'article');
INSERT INTO "Publication" VALUES (794, 'Three Measures for Synchronic Dependence in Petri Nets.', 1983, 'article');
INSERT INTO "Publication" VALUES (795, 'The Universe Problem for Unrestricted Flow Languages.', 1983, 'article');
INSERT INTO "Publication" VALUES (796, 'On-Way Multihead Deterministic Finite Automata.', 1983, 'article');
INSERT INTO "Publication" VALUES (797, 'Standard Model Semantics for DSL A Data Type Specification Language.', 1983, 'article');
INSERT INTO "Publication" VALUES (798, 'An Optimality Theory of Concurrency Control for Databases.', 1983, 'article');
INSERT INTO "Publication" VALUES (799, 'Transposition of Large Tabular Data Structures with Applications to Physical Database Organization.', 1983, 'article');
INSERT INTO "Publication" VALUES (800, 'On Some Variants of Post''s Correspondence Problem.', 1983, 'article');
INSERT INTO "Publication" VALUES (801, 'New Lower Bounds on the Formula Size of Boolean Functions.', 1983, 'article');
INSERT INTO "Publication" VALUES (802, 'Interpretation and Reduction of Attribute Grammars.', 1983, 'article');
INSERT INTO "Publication" VALUES (803, 'Parallel Language Recognition in Constant Time by Cellular Automata.', 1983, 'article');
INSERT INTO "Publication" VALUES (804, 'Inferring Multivalued Dependencies From Functional and Join Dependencies.', 1983, 'article');
INSERT INTO "Publication" VALUES (805, 'Variance Reduction Techniques for the Simulation of Markov Process.', 1980, 'article');
INSERT INTO "Publication" VALUES (806, 'Gobang ist PSPACE-vollständig.', 1980, 'article');
INSERT INTO "Publication" VALUES (807, 'Applications of Efficient Mergeable Heaps for Optimization Problems on Trees.', 1980, 'article');
INSERT INTO "Publication" VALUES (808, 'On the Number of Active-Operations Needed to Compute the Discrete Fourier Transform.', 1980, 'article');
INSERT INTO "Publication" VALUES (809, 'Paramodulated Connection Graphs.', 1980, 'article');
INSERT INTO "Publication" VALUES (810, 'Efficient LL(1) Error Correction and Recovery Using Only Insertions.', 1980, 'article');
INSERT INTO "Publication" VALUES (811, 'Efficient Worst-Case Data Structures for Range Searching.', 1980, 'article');
INSERT INTO "Publication" VALUES (812, 'Rational Bijection of Rational Sets.', 1980, 'article');
INSERT INTO "Publication" VALUES (813, 'Methods for the Automatic Construction of Error Correcting Parsers.', 1980, 'article');
INSERT INTO "Publication" VALUES (814, 'Ordered Attributed Grammars.', 1980, 'article');
INSERT INTO "Publication" VALUES (815, 'A Practical Example of the Specification of Abstract Data Types.', 1980, 'article');
INSERT INTO "Publication" VALUES (816, 'Automaten in planaren Graphen.', 1980, 'article');
INSERT INTO "Publication" VALUES (817, 'An Algorithmic and Complexity Analysis of Interpolation Search.', 1980, 'article');
INSERT INTO "Publication" VALUES (818, 'Amounts of Nondeterminism in Finite Automata.', 1980, 'article');
INSERT INTO "Publication" VALUES (819, 'Depth-First K-Trees and Critical Path Analysis.', 1980, 'article');
INSERT INTO "Publication" VALUES (820, 'Context-Free Grammars With Selective Rewriting.', 1980, 'article');
INSERT INTO "Publication" VALUES (821, 'Analysis of a Prioritized CSMA Protocol Based on Staggered Delays.', 1980, 'article');
INSERT INTO "Publication" VALUES (822, 'A new Lower Bound on the Monotone Network Complexity of Boolean Sums.', 1980, 'article');
INSERT INTO "Publication" VALUES (823, 'Universal Asynchronous Iterative Arrays of Mealy Automata.', 1980, 'article');
INSERT INTO "Publication" VALUES (824, 'A note on autodense related languages.', 2010, 'article');
INSERT INTO "Publication" VALUES (825, 'Equilibria for two parallel links: the strong price of anarchy versus the price of anarchy.', 2010, 'article');
INSERT INTO "Publication" VALUES (826, 'Symmetry and partial order reduction techniques in model checking Rebeca.', 2010, 'article');
INSERT INTO "Publication" VALUES (827, 'Small universal accepting hybrid networks of evolutionary processors.', 2010, 'article');
INSERT INTO "Publication" VALUES (828, 'Quantum loop programs.', 2010, 'article');
INSERT INTO "Publication" VALUES (829, 'On regular temporal logics with past.', 2010, 'article');
INSERT INTO "Publication" VALUES (830, 'On stateless deterministic restarting automata.', 2010, 'article');
INSERT INTO "Publication" VALUES (831, 'Automata-based verification of programs with tree updates.', 2010, 'article');
INSERT INTO "Publication" VALUES (832, 'How to allocate review tasks for robust ranking.', 2010, 'article');
INSERT INTO "Publication" VALUES (833, 'Randomization adaptive self-stabilization.', 2010, 'article');
INSERT INTO "Publication" VALUES (834, 'Recursive Petri nets.', 2007, 'article');
INSERT INTO "Publication" VALUES (835, 'Improved matrix pair undecidability results.', 2007, 'article');
INSERT INTO "Publication" VALUES (836, 'View selection for real conjunctive queries.', 2007, 'article');
INSERT INTO "Publication" VALUES (837, 'Optimal semi-online algorithms for preemptive scheduling problems with inexact partial information.', 2007, 'article');
INSERT INTO "Publication" VALUES (838, 'Synchronous cooperation for explicit multi-threading.', 2007, 'article');
INSERT INTO "Publication" VALUES (839, 'Dual unbounded nondeterminacy, recursion, and fixpoints.', 2007, 'article');
INSERT INTO "Publication" VALUES (840, 'Parallel LL parsing.', 2007, 'article');
INSERT INTO "Publication" VALUES (841, 'Distributed Consensus, revisited.', 2007, 'article');
INSERT INTO "Publication" VALUES (842, 'Solving #SAT using vertex covers.', 2007, 'article');
INSERT INTO "Publication" VALUES (843, 'An exact subexponential-time lattice algorithm for Asian options.', 2007, 'article');
INSERT INTO "Publication" VALUES (844, 'A criterion for atomicity revisited.', 2007, 'article');
INSERT INTO "Publication" VALUES (845, 'Parallel LL parsing.', 2007, 'article');
INSERT INTO "Publication" VALUES (846, 'Decision problems for pushdown threads.', 2007, 'article');
INSERT INTO "Publication" VALUES (847, 'Enhanced prefetching and caching strategies for single- and multi-disk systems.', 2005, 'article');
INSERT INTO "Publication" VALUES (848, 'Type-based information flow analysis for the pi-calculus.', 2005, 'article');
INSERT INTO "Publication" VALUES (849, 'Recognizability of graph and pattern languages.', 2006, 'article');
INSERT INTO "Publication" VALUES (850, 'Exponentially decreasing number of operations in balanced trees.', 2005, 'article');
INSERT INTO "Publication" VALUES (851, 'Refinement of actions for real-time concurrent systems with causal ambiguity.', 2006, 'article');
INSERT INTO "Publication" VALUES (852, 'Subtyping for session types in the pi calculus.', 2005, 'article');
INSERT INTO "Publication" VALUES (853, 'Genericity and the pi-calculus.', 2005, 'article');
INSERT INTO "Publication" VALUES (854, 'Splitting forward simulations to copewith liveness.', 2006, 'article');
INSERT INTO "Publication" VALUES (855, 'Non uniform random generation of generalized Motzkin paths.', 2006, 'article');
INSERT INTO "Publication" VALUES (856, 'Deep pushdown automata.', 2006, 'article');
INSERT INTO "Publication" VALUES (857, 'Vector assignment schemes for asymmetric settings.', 2006, 'article');
INSERT INTO "Publication" VALUES (858, 'safeDpi: a language for controlling mobile code.', 2005, 'article');
INSERT INTO "Publication" VALUES (859, 'MOMI: a calculus for mobile mixins.', 2005, 'article');
INSERT INTO "Publication" VALUES (860, 'Embedding linear orders in grids.', 2006, 'article');
INSERT INTO "Publication" VALUES (861, 'Abstractions of data types.', 2006, 'article');
INSERT INTO "Publication" VALUES (862, 'Nonfinite Axiomatizability of the Equational Theory of Shuffle.', 1998, 'article');
INSERT INTO "Publication" VALUES (863, 'M-Nets: An Algebra of High-Level Petri Nets, with an Application to the Semantics of Concurrent Programming Languages.', 1998, 'article');
INSERT INTO "Publication" VALUES (864, 'Priority Conflict-Free Petri Nets.', 1998, 'article');
INSERT INTO "Publication" VALUES (865, 'Axioms for Generalized Graphs, Illustrated by a Cantor-Bernstein Proposition.', 1998, 'article');
INSERT INTO "Publication" VALUES (866, 'Data Refinement of Mixed Specifications.', 1998, 'article');
INSERT INTO "Publication" VALUES (867, 'Average-Case Complexity for the Execution of Recursive Definitions on Relational Databases.', 1998, 'article');
INSERT INTO "Publication" VALUES (868, 'Asymptotic Expansions of the Mergesort Recurrences.', 1998, 'article');
INSERT INTO "Publication" VALUES (869, 'Decision Problems Concerning Thinness and Slenderness of Formal Languages.', 1998, 'article');
INSERT INTO "Publication" VALUES (870, 'A Logic-Based Approach to Program Flow Analysis.', 1998, 'article');
INSERT INTO "Publication" VALUES (871, 'd-Words and d-Languages.', 1998, 'article');
INSERT INTO "Publication" VALUES (872, 'Structured Numbers: Properties of a Hierarchy of Operations on Binary Trees.', 1998, 'article');
INSERT INTO "Publication" VALUES (873, 'A Tree-Based Mergesort.', 1998, 'article');
INSERT INTO "Publication" VALUES (874, 'Bi-Catenation and Shuffle Product of Languages.', 1998, 'article');
INSERT INTO "Publication" VALUES (875, 'On Finite Automata with Limited Nondeterminism.', 1998, 'article');
INSERT INTO "Publication" VALUES (876, 'A Fully Abstract Semantics for Causality in the \pi-Calculus.', 1998, 'article');
INSERT INTO "Publication" VALUES (877, 'Conceptual Classes and System Classes in Object Databases.', 1998, 'article');
INSERT INTO "Publication" VALUES (878, 'Converting Untyped Formulas to Typed Ones.', 1998, 'article');
INSERT INTO "Publication" VALUES (879, 'Polytime Model Checking for Timed Probabilistic Computation Tree Logic.', 1998, 'article');
INSERT INTO "Publication" VALUES (880, 'Dijkstra-Scholten Predicate Calculus: Concepts and Misconceptions.', 1998, 'article');
INSERT INTO "Publication" VALUES (881, 'Modularity and Expressibility for Nets of Relations.', 1998, 'article');
INSERT INTO "Publication" VALUES (882, 'A Transformation System for Concurrent Processes.', 1998, 'article');
INSERT INTO "Publication" VALUES (883, 'Amortized Constant Relaxed Rebalancing Using Standard Rotations.', 1998, 'article');
INSERT INTO "Publication" VALUES (884, 'Context-Free Languages over Infinite Alphabets.', 1998, 'article');
INSERT INTO "Publication" VALUES (885, 'Machine Scheduling with Availability Constraints.', 1998, 'article');
INSERT INTO "Publication" VALUES (886, 'On Time Computability of Functions in One-Way Cellular Automata.', 1998, 'article');
INSERT INTO "Publication" VALUES (887, 'Refinement of Fair Action Systems.', 1998, 'article');
INSERT INTO "Publication" VALUES (888, 'Running a job on a collection of partly available machines, with on-line restarts.', 2001, 'article');
INSERT INTO "Publication" VALUES (889, 'Demonic, angelic and unbounded probabilistic choices in sequential programs.', 2001, 'article');
INSERT INTO "Publication" VALUES (890, 'Efficient recognition algorithms for boundary and linear eNCE graph languages.', 2001, 'article');
INSERT INTO "Publication" VALUES (891, 'Synchronized extension systems.', 2001, 'article');
INSERT INTO "Publication" VALUES (892, 'A polynomial time computable metric between point sets.', 2001, 'article');
INSERT INTO "Publication" VALUES (893, 'Parallel communicating grammar systems with terminal transmission.', 2001, 'article');
INSERT INTO "Publication" VALUES (894, 'Relaxed balance for search trees with local rebalancing.', 2001, 'article');
INSERT INTO "Publication" VALUES (895, 'On the tree inclusion problem.', 2001, 'article');
INSERT INTO "Publication" VALUES (896, 'Data structures for order-sensitive predicates in parallel nondeterministic systems.', 2000, 'article');
INSERT INTO "Publication" VALUES (897, 'Labelled transition logic: an outline.', 2001, 'article');
INSERT INTO "Publication" VALUES (898, 'Letter from the Editor.', 2001, 'article');
INSERT INTO "Publication" VALUES (899, 'Efficiently building a parse tree from a regular expression.', 2000, 'article');
INSERT INTO "Publication" VALUES (900, 'Fair sticker languages.', 2000, 'article');
INSERT INTO "Publication" VALUES (901, 'Accepting Zeno words: a way toward timed refinements.', 2000, 'article');
INSERT INTO "Publication" VALUES (902, 'Refinement of actions and equivalence notions for concurrent systems.', 2001, 'article');
INSERT INTO "Publication" VALUES (903, 'A construction of distributed reference counting.', 2001, 'article');
INSERT INTO "Publication" VALUES (904, 'A Markov modulated multi-server queue with negative customers - The MM CPP/GE/c/L G-queue.', 2001, 'article');
INSERT INTO "Publication" VALUES (905, 'Analysis of range search for random k-d trees.', 2001, 'article');
INSERT INTO "Publication" VALUES (906, 'The class Steiner minimal tree problem: a lower bound and test problem generation.', 2000, 'article');
INSERT INTO "Publication" VALUES (907, 'Semantics analysis through elementary meanings.', 2000, 'article');
INSERT INTO "Publication" VALUES (908, 'Even faster generalized LR parsing.', 2001, 'article');
INSERT INTO "Publication" VALUES (909, 'Data Refinement by Calculation.', 1990, 'article');
INSERT INTO "Publication" VALUES (910, 'Maintaining Range Trees in Secondary Memory. Part I: Partitions.', 1990, 'article');
INSERT INTO "Publication" VALUES (911, 'A Note on Synthesis and Classification of Sorting Algorithms.', 1989, 'article');
INSERT INTO "Publication" VALUES (912, 'Proving Relative Lower Bounds for Incremental Algorithms.', 1990, 'article');
INSERT INTO "Publication" VALUES (913, 'On Efficient Implementation of an Approximation Algorithm for the Steiner Tree Problem.', 1990, 'article');
INSERT INTO "Publication" VALUES (914, 'A Maximum Entropy Priority Approximation for a Stable  G/G/  1 Queue.', 1990, 'article');
INSERT INTO "Publication" VALUES (915, 'Maintaining Range Trees in Secondary Memory. Part II: Lower Bounds.', 1990, 'article');
INSERT INTO "Publication" VALUES (916, 'Hiding in Stream Semantics of Uniform Concurrency.', 1990, 'article');
INSERT INTO "Publication" VALUES (917, 'Tableau-Based Model Checking in the Propositional Mu-Calculus.', 1990, 'article');
INSERT INTO "Publication" VALUES (918, 'Some Efficient Computational Algorithms Related to Phase Models.', 1989, 'article');
INSERT INTO "Publication" VALUES (919, 'Merging Sorted Runs Using Large Main Memory.', 1990, 'article');
INSERT INTO "Publication" VALUES (920, 'A Model of the Dynamic Behavior of B-Trees.', 1989, 'article');
INSERT INTO "Publication" VALUES (921, 'Step Failures Semantics and a Complete Proof System.', 1989, 'article');
INSERT INTO "Publication" VALUES (922, 'Iteration of Transformation Passes over Attributed Program Trees.', 1989, 'article');
INSERT INTO "Publication" VALUES (923, 'HDTOL Matching of Computations of Multitape Automata.', 1989, 'article');
INSERT INTO "Publication" VALUES (924, 'Optimum Checkpoints with Age Dependent Failures.', 1990, 'article');
INSERT INTO "Publication" VALUES (925, 'Duality in Specification Languages: A Lattice-Theoretical Approach.', 1990, 'article');
INSERT INTO "Publication" VALUES (926, 'In Memoriam: Andrei Petrovich Ershov.', 1990, 'article');
INSERT INTO "Publication" VALUES (927, 'On Specification of Multiprocessor Computing.', 1990, 'article');
INSERT INTO "Publication" VALUES (928, 'On the Valuedness of Finite Transducers.', 1990, 'article');
INSERT INTO "Publication" VALUES (929, 'Referential Transparency, Definiteness and Unfoldability.', 1990, 'article');
INSERT INTO "Publication" VALUES (930, 'Context Free Derivations on Word Monoids.', 1990, 'article');
INSERT INTO "Publication" VALUES (931, 'An Incremental Mechanical Development of Systolic Solutions to the Algebraic Path Problem.', 1989, 'article');
INSERT INTO "Publication" VALUES (932, 'The Instability of Self-Stabilization.', 1990, 'article');
INSERT INTO "Publication" VALUES (933, 'Synchronized regular expressions.', 2003, 'article');
INSERT INTO "Publication" VALUES (934, 'Stochastic cooperative distributed grammar systems and random graphs.', 2003, 'article');
INSERT INTO "Publication" VALUES (935, 'A note on pure and p-pure languages.', 2003, 'article');
INSERT INTO "Publication" VALUES (936, 'Coincidental extension of scattered context languages.', 2003, 'article');
INSERT INTO "Publication" VALUES (937, 'A top-down proof procedure for generalized data dependencies.', 2003, 'article');
INSERT INTO "Publication" VALUES (938, 'Towards action refinement for true concurrent real time.', 2003, 'article');
INSERT INTO "Publication" VALUES (939, 'Bin stretching revisited.', 2003, 'article');
INSERT INTO "Publication" VALUES (940, 'Preference rankings in the face of uncertainty.', 2003, 'article');
INSERT INTO "Publication" VALUES (941, 'A word on 7 letters which is non-repetitive up to mod 5.', 2003, 'article');
INSERT INTO "Publication" VALUES (942, 'A functional approach for temporal × modal logics.', 2003, 'article');
INSERT INTO "Publication" VALUES (943, 'Reasoning about probabilistic sequential programs in a probabilistic logic.', 2003, 'article');
INSERT INTO "Publication" VALUES (944, 'Ideal preemptive schedules on two processors.', 2003, 'article');
INSERT INTO "Publication" VALUES (945, 'Fundamentals of control flow in workflows.', 2003, 'article');
INSERT INTO "Publication" VALUES (946, 'Adding inclusion dependencies to an object-oriented data model with uniqueness constraints.', 2003, 'article');
INSERT INTO "Publication" VALUES (947, 'On Gurevich''s theorem on sequential algorithms.', 2003, 'article');
INSERT INTO "Publication" VALUES (948, 'Optimal Divide-and-Conquer to Compute Measure and Contour for a Set of Iso-Rectangles.', 1984, 'article');
INSERT INTO "Publication" VALUES (949, 'The Paging Drum Queue: A Uniform Perspective and Further Results.', 1984, 'article');
INSERT INTO "Publication" VALUES (950, 'Characterization of all Optimal Networks for a Simultaneous Computation of AND and NOR.', 1984, 'article');
INSERT INTO "Publication" VALUES (951, 'On Real-Time Cellular Automata and Trellis Automata.', 1984, 'article');
INSERT INTO "Publication" VALUES (952, 'Axiomatising Finite Delay Operators.', 1984, 'article');
INSERT INTO "Publication" VALUES (953, 'A Probabilistic Analysis of the Height of Tries and of the Complexity of Triesort.', 1984, 'article');
INSERT INTO "Publication" VALUES (954, ' LALR  (1, 1) Parser Generation for Regular Right Part Grammars.', 1984, 'article');
INSERT INTO "Publication" VALUES (955, 'Finite Complete Rewriting Systems and the Complexity of the Word Problem.', 1984, 'article');
INSERT INTO "Publication" VALUES (956, 'A Fair Calculus of Communicating Systems.', 1984, 'article');
INSERT INTO "Publication" VALUES (957, 'Data Management Support for Database Management.', 1984, 'article');
INSERT INTO "Publication" VALUES (958, 'Some Average Performance Measures for the B-Tree.', 1985, 'article');
INSERT INTO "Publication" VALUES (959, 'Maintaining Order in a Generalized Linked List.', 1984, 'article');
INSERT INTO "Publication" VALUES (960, 'Space Sweep Solves Intersection of Convex Polyhedra.', 1984, 'article');
INSERT INTO "Publication" VALUES (961, 'A Characterization of Systolic Binary Tree Automata and Applications.', 1984, 'article');
INSERT INTO "Publication" VALUES (962, 'Optimal Multiway Search Trees for Variable Size Keys.', 1984, 'article');
INSERT INTO "Publication" VALUES (963, 'Deadlock-Freedom in Resource Contentions.', 1985, 'article');
INSERT INTO "Publication" VALUES (964, 'Using Circular Programs to Eliminate Multiple Traversals of Data.', 1984, 'article');
INSERT INTO "Publication" VALUES (965, 'Free Choice Systems Have Home States.', 1984, 'article');
INSERT INTO "Publication" VALUES (966, 'Speeding up Circularity Tests for Attribute Grammars.', 1984, 'article');
INSERT INTO "Publication" VALUES (967, 'A Set-Theoretic Semantics for Clear.', 1984, 'article');
INSERT INTO "Publication" VALUES (968, 'Simulation Output Analysis for Local Area Computer Networks.', 1984, 'article');
INSERT INTO "Publication" VALUES (969, 'A Logic Covering Undefinedness in Program Proofs.', 1984, 'article');
INSERT INTO "Publication" VALUES (970, 'Generalized Binary Split Trees.', 1984, 'article');
INSERT INTO "Publication" VALUES (971, 'The stuttering principle revisited.', 2005, 'article');
INSERT INTO "Publication" VALUES (972, 'Fast allocation and deallocation with an improved buddy system.', 2005, 'article');
INSERT INTO "Publication" VALUES (973, 'Optimal recovery schemes in fault tolerant distributed computing.', 2005, 'article');
INSERT INTO "Publication" VALUES (974, 'Project scheduling with irregular costs: complexity, approximability, and algorithms.', 2004, 'article');
INSERT INTO "Publication" VALUES (975, 'Preemptive online algorithms for scheduling with machine cost.', 2005, 'article');
INSERT INTO "Publication" VALUES (976, 'Type-based hot swapping of running modules.', 2005, 'article');
INSERT INTO "Publication" VALUES (977, 'Erratum: The size of random bucket trees via urn models.', 2004, 'article');
INSERT INTO "Publication" VALUES (978, 'Random sprouts as internet models, and Pólya processes.', 2004, 'article');
INSERT INTO "Publication" VALUES (979, 'A deterministic skip list for k-dimensional range search.', 2005, 'article');
INSERT INTO "Publication" VALUES (980, 'Online square and cube packing.', 2005, 'article');
INSERT INTO "Publication" VALUES (981, 'Hybrid networks of evolutionary processors are computationally complete.', 2005, 'article');
INSERT INTO "Publication" VALUES (982, 'A comprehensive database schema integration method based on the theory of formal concepts.', 2005, 'article');
INSERT INTO "Publication" VALUES (983, 'pi-calculus with noisy channels.', 2005, 'article');
INSERT INTO "Publication" VALUES (984, 'The weakest specifunction.', 2005, 'article');
INSERT INTO "Publication" VALUES (985, 'Trading polarizations for labels in P systems with active membranes.', 2004, 'article');
INSERT INTO "Publication" VALUES (986, 'Limit laws for terminal nodes in random circuits with restricted fan-out: a family of graphs generalizing binary search trees.', 2004, 'article');
INSERT INTO "Publication" VALUES (987, 'An axiomatization of graphs.', 2004, 'article');
INSERT INTO "Publication" VALUES (988, 'A new natural structural congruence in the pi-calculus with replication.', 2004, 'article');
INSERT INTO "Publication" VALUES (989, 'Sticky-free and overhang-free DNA languages.', 2003, 'article');
INSERT INTO "Publication" VALUES (990, 'Reducing non-determinism in right nulled GLR parsers.', 2004, 'article');
INSERT INTO "Publication" VALUES (991, 'Approximation schemes for the Min-Max Starting Time Problem.', 2004, 'article');
INSERT INTO "Publication" VALUES (992, 'On best transitive approximations to simple graphs.', 2004, 'article');
INSERT INTO "Publication" VALUES (993, 'Timed automata with urgent transitions.', 2004, 'article');
INSERT INTO "Publication" VALUES (994, 'Canonical prefixes of Petri net unfoldings.', 2003, 'article');
INSERT INTO "Publication" VALUES (995, 'Self-stabilizing group communication in directed networks.', 2004, 'article');
INSERT INTO "Publication" VALUES (996, 'Trajectory-based codes.', 2004, 'article');
INSERT INTO "Publication" VALUES (997, 'Providing view synchrony for group communication services.', 2003, 'article');
INSERT INTO "Publication" VALUES (998, 'Program reversals for evolutions with non-uniform step costs.', 2004, 'article');
INSERT INTO "Publication" VALUES (999, 'Pipelines: Modelling a software architecture through relations.', 2003, 'article');
INSERT INTO "Publication" VALUES (1000, 'A distributed QoS-Aware multicast routing protocol.', 2003, 'article');
INSERT INTO "Publication" VALUES (1001, 'Optimal algorithms for semi-online preemptive scheduling problems on two uniform machines.', 2004, 'article');


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 189
-- Name: Publication_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: kittn
--

SELECT pg_catalog.setval('"Publication_ID_seq"', 1001, true);


--
-- TOC entry 2137 (class 0 OID 24984)
-- Dependencies: 184
-- Data for Name: Published; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 2129 (class 0 OID 24889)
-- Dependencies: 176
-- Data for Name: Publisher; Type: TABLE DATA; Schema: public; Owner: kittn
--



--
-- TOC entry 1973 (class 2606 OID 24880)
-- Name: Area_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Area"
    ADD CONSTRAINT "Area_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2001 (class 2606 OID 25060)
-- Name: Article_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Article"
    ADD CONSTRAINT "Article_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1979 (class 2606 OID 25007)
-- Name: Author_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY ("Name");


--
-- TOC entry 1983 (class 2606 OID 24920)
-- Name: Book_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1985 (class 2606 OID 24933)
-- Name: Conference_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Conference"
    ADD CONSTRAINT "Conference_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 1995 (class 2606 OID 25023)
-- Name: Incollection_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Incollection"
    ADD CONSTRAINT "Incollection_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1997 (class 2606 OID 25036)
-- Name: Inproceedings_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Inproceedings"
    ADD CONSTRAINT "Inproceedings_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1987 (class 2606 OID 25078)
-- Name: InstAuthPub_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "InstAuthPub"
    ADD CONSTRAINT "InstAuthPub_pkey" PRIMARY KEY ("PubID", "Author");


--
-- TOC entry 1981 (class 2606 OID 24912)
-- Name: Institution_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Institution"
    ADD CONSTRAINT "Institution_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 1971 (class 2606 OID 24872)
-- Name: Journal_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Journal"
    ADD CONSTRAINT "Journal_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 1975 (class 2606 OID 24888)
-- Name: Keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Keyword"
    ADD CONSTRAINT "Keyword_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 1999 (class 2606 OID 25047)
-- Name: Proceedings_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Proceedings"
    ADD CONSTRAINT "Proceedings_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1989 (class 2606 OID 24958)
-- Name: PubArea_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "PubArea"
    ADD CONSTRAINT "PubArea_pkey" PRIMARY KEY ("PubID");


--
-- TOC entry 1991 (class 2606 OID 24973)
-- Name: PubKeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "PubKeyword"
    ADD CONSTRAINT "PubKeyword_pkey" PRIMARY KEY ("PubID", "KeywordID");


--
-- TOC entry 1969 (class 2606 OID 24864)
-- Name: Publication_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Publication"
    ADD CONSTRAINT "Publication_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 1993 (class 2606 OID 24988)
-- Name: Published_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Published"
    ADD CONSTRAINT "Published_pkey" PRIMARY KEY ("PublicationID");


--
-- TOC entry 1977 (class 2606 OID 24896)
-- Name: Publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: kittn; Tablespace: 
--

ALTER TABLE ONLY "Publisher"
    ADD CONSTRAINT "Publisher_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2015 (class 2606 OID 25061)
-- Name: Article_JournalID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Article"
    ADD CONSTRAINT "Article_JournalID_fkey" FOREIGN KEY ("JournalID") REFERENCES "Journal"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2002 (class 2606 OID 24921)
-- Name: Book_PubID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Book"
    ADD CONSTRAINT "Book_PubID_fkey" FOREIGN KEY ("PubID") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2012 (class 2606 OID 25024)
-- Name: Incollection_Crossref_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Incollection"
    ADD CONSTRAINT "Incollection_Crossref_fkey" FOREIGN KEY ("Crossref") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2013 (class 2606 OID 25037)
-- Name: Inproceedings_Crossref_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Inproceedings"
    ADD CONSTRAINT "Inproceedings_Crossref_fkey" FOREIGN KEY ("Crossref") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2005 (class 2606 OID 25011)
-- Name: InstAuthPub_Author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "InstAuthPub"
    ADD CONSTRAINT "InstAuthPub_Author_fkey" FOREIGN KEY ("Author") REFERENCES "Author"("Name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2004 (class 2606 OID 24949)
-- Name: InstAuthPub_InstID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "InstAuthPub"
    ADD CONSTRAINT "InstAuthPub_InstID_fkey" FOREIGN KEY ("InstID") REFERENCES "Institution"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2003 (class 2606 OID 24944)
-- Name: InstAuthPub_PubID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "InstAuthPub"
    ADD CONSTRAINT "InstAuthPub_PubID_fkey" FOREIGN KEY ("PubID") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2014 (class 2606 OID 25048)
-- Name: Proceedings_ConferenceID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Proceedings"
    ADD CONSTRAINT "Proceedings_ConferenceID_fkey" FOREIGN KEY ("ConferenceID") REFERENCES "Conference"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2006 (class 2606 OID 24959)
-- Name: PubArea_AreaID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "PubArea"
    ADD CONSTRAINT "PubArea_AreaID_fkey" FOREIGN KEY ("AreaID") REFERENCES "Area"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2007 (class 2606 OID 24964)
-- Name: PubArea_PubID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "PubArea"
    ADD CONSTRAINT "PubArea_PubID_fkey" FOREIGN KEY ("PubID") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2009 (class 2606 OID 24979)
-- Name: PubKeyword_KeywordID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "PubKeyword"
    ADD CONSTRAINT "PubKeyword_KeywordID_fkey" FOREIGN KEY ("KeywordID") REFERENCES "Keyword"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2008 (class 2606 OID 24974)
-- Name: PubKeyword_PubID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "PubKeyword"
    ADD CONSTRAINT "PubKeyword_PubID_fkey" FOREIGN KEY ("PubID") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2010 (class 2606 OID 24989)
-- Name: Published_PublicationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Published"
    ADD CONSTRAINT "Published_PublicationID_fkey" FOREIGN KEY ("PublicationID") REFERENCES "Publication"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2011 (class 2606 OID 24994)
-- Name: Published_PublisherID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kittn
--

ALTER TABLE ONLY "Published"
    ADD CONSTRAINT "Published_PublisherID_fkey" FOREIGN KEY ("PublisherID") REFERENCES "Publisher"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: kittn
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM kittn;
GRANT ALL ON SCHEMA public TO kittn;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-10-27 21:16:14

--
-- kittnQL database dump complete
--

