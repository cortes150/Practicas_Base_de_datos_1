--
-- PostgreSQL database dump
--

\restrict aB34CquTSkgWVBtNc1ygoJMmloq5hpPtEU5i00Ue9BEL8ZYp9xzcT56aqeTWwCn

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-13 09:02:14

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16388)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nombre character varying(50) NOT NULL,
    ap_paterno character varying(50),
    ap_materno character varying(50),
    fecha_nacimiento date,
    edad integer,
    calle character varying(100),
    avenida character varying(100)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16387)
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- TOC entry 228 (class 1259 OID 16434)
-- Name: detalle_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_pedido (
    id_detalle_pedido integer NOT NULL,
    notas_especiales text,
    subtotal numeric(10,2),
    id_pedido integer,
    id_plato integer
);


ALTER TABLE public.detalle_pedido OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16433)
-- Name: detalle_pedido_id_detalle_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_pedido_id_detalle_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_pedido_id_detalle_pedido_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 227
-- Name: detalle_pedido_id_detalle_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_pedido_id_detalle_pedido_seq OWNED BY public.detalle_pedido.id_detalle_pedido;


--
-- TOC entry 230 (class 1259 OID 16454)
-- Name: pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago (
    id_pago integer NOT NULL,
    metodo_pago character varying(50) NOT NULL,
    monto numeric(10,2) NOT NULL,
    id_pedido integer NOT NULL,
    fecha_pago timestamp without time zone
);


ALTER TABLE public.pago OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16453)
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_id_pago_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 229
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_id_pago_seq OWNED BY public.pago.id_pago;


--
-- TOC entry 226 (class 1259 OID 16421)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    id_pedido integer NOT NULL,
    estado character varying(50),
    fecha_hora timestamp without time zone,
    monto_total_final numeric(10,2),
    id_cliente integer
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16420)
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_id_pedido_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 225
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_id_pedido_seq OWNED BY public.pedido.id_pedido;


--
-- TOC entry 224 (class 1259 OID 16410)
-- Name: plato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plato (
    id_plato integer NOT NULL,
    nombre character varying(100) NOT NULL,
    precio numeric(10,2),
    descripcion text
);


ALTER TABLE public.plato OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16409)
-- Name: plato_id_plato_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plato_id_plato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plato_id_plato_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 223
-- Name: plato_id_plato_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plato_id_plato_seq OWNED BY public.plato.id_plato;


--
-- TOC entry 222 (class 1259 OID 16397)
-- Name: telefono_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_cliente (
    id_telefono_cliente integer NOT NULL,
    numero character varying(50),
    id_cliente integer
);


ALTER TABLE public.telefono_cliente OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16396)
-- Name: telefono_cliente_id_telefono_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.telefono_cliente_id_telefono_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telefono_cliente_id_telefono_cliente_seq OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 221
-- Name: telefono_cliente_id_telefono_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.telefono_cliente_id_telefono_cliente_seq OWNED BY public.telefono_cliente.id_telefono_cliente;


--
-- TOC entry 4834 (class 2604 OID 16391)
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 16437)
-- Name: detalle_pedido id_detalle_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido ALTER COLUMN id_detalle_pedido SET DEFAULT nextval('public.detalle_pedido_id_detalle_pedido_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 16457)
-- Name: pago id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_id_pago_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 16424)
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id_pedido SET DEFAULT nextval('public.pedido_id_pedido_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 16413)
-- Name: plato id_plato; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plato ALTER COLUMN id_plato SET DEFAULT nextval('public.plato_id_plato_seq'::regclass);


--
-- TOC entry 4835 (class 2604 OID 16400)
-- Name: telefono_cliente id_telefono_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente ALTER COLUMN id_telefono_cliente SET DEFAULT nextval('public.telefono_cliente_id_telefono_cliente_seq'::regclass);


--
-- TOC entry 5005 (class 0 OID 16388)
-- Dependencies: 220
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id_cliente, nombre, ap_paterno, ap_materno, fecha_nacimiento, edad, calle, avenida) FROM stdin;
\.


--
-- TOC entry 5013 (class 0 OID 16434)
-- Dependencies: 228
-- Data for Name: detalle_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_pedido (id_detalle_pedido, notas_especiales, subtotal, id_pedido, id_plato) FROM stdin;
\.


--
-- TOC entry 5015 (class 0 OID 16454)
-- Dependencies: 230
-- Data for Name: pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pago (id_pago, metodo_pago, monto, id_pedido, fecha_pago) FROM stdin;
\.


--
-- TOC entry 5011 (class 0 OID 16421)
-- Dependencies: 226
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (id_pedido, estado, fecha_hora, monto_total_final, id_cliente) FROM stdin;
\.


--
-- TOC entry 5009 (class 0 OID 16410)
-- Dependencies: 224
-- Data for Name: plato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plato (id_plato, nombre, precio, descripcion) FROM stdin;
\.


--
-- TOC entry 5007 (class 0 OID 16397)
-- Dependencies: 222
-- Data for Name: telefono_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefono_cliente (id_telefono_cliente, numero, id_cliente) FROM stdin;
\.


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 227
-- Name: detalle_pedido_id_detalle_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_pedido_id_detalle_pedido_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 229
-- Name: pago_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_id_pago_seq', 1, false);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 225
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_id_pedido_seq', 1, false);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 223
-- Name: plato_id_plato_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plato_id_plato_seq', 1, false);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 221
-- Name: telefono_cliente_id_telefono_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.telefono_cliente_id_telefono_cliente_seq', 1, false);


--
-- TOC entry 4841 (class 2606 OID 16395)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4849 (class 2606 OID 16442)
-- Name: detalle_pedido detalle_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id_detalle_pedido);


--
-- TOC entry 4851 (class 2606 OID 16463)
-- Name: pago pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4847 (class 2606 OID 16427)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 4845 (class 2606 OID 16419)
-- Name: plato plato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plato
    ADD CONSTRAINT plato_pkey PRIMARY KEY (id_plato);


--
-- TOC entry 4843 (class 2606 OID 16403)
-- Name: telefono_cliente telefono_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT telefono_cliente_pkey PRIMARY KEY (id_telefono_cliente);


--
-- TOC entry 4854 (class 2606 OID 16443)
-- Name: detalle_pedido detalle_pedido_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 4855 (class 2606 OID 16448)
-- Name: detalle_pedido detalle_pedido_id_plato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_id_plato_fkey FOREIGN KEY (id_plato) REFERENCES public.plato(id_plato);


--
-- TOC entry 4856 (class 2606 OID 16464)
-- Name: pago pago_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 4853 (class 2606 OID 16428)
-- Name: pedido pedido_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 4852 (class 2606 OID 16404)
-- Name: telefono_cliente telefono_cliente_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT telefono_cliente_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


-- Completed on 2026-04-13 09:02:14

--
-- PostgreSQL database dump complete
--

\unrestrict aB34CquTSkgWVBtNc1ygoJMmloq5hpPtEU5i00Ue9BEL8ZYp9xzcT56aqeTWwCn

