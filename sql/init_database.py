import psycopg2
from products import products


conn = psycopg2.connect(user="postgres",password="P35Bxzz6K",host="127.0.0.1",port="5432",database="ecomdb")
cur = conn.cursor()


cur.execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";')

# Create User Table
cur.execute("""

CREATE TABLE IF NOT EXISTS public.users
(
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    phone character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT email UNIQUE (email),
    CONSTRAINT phone UNIQUE (phone)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
""")

cur.execute(
    """
    CREATE TABLE IF NOT EXISTS public.products
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default" NOT NULL,
    price integer NOT NULL,
    image character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Products_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;
    """
)

cur.execute(
    """
    CREATE TABLE IF NOT EXISTS public.address
(
    state character varying COLLATE pg_catalog."default" NOT NULL,
    city character varying COLLATE pg_catalog."default" NOT NULL,
    pincode character varying COLLATE pg_catalog."default" NOT NULL,
    home character varying COLLATE pg_catalog."default" NOT NULL,
    id uuid NOT NULL,
    "addressID" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    CONSTRAINT "Address_pkey" PRIMARY KEY ("addressID"),
    CONSTRAINT id FOREIGN KEY (id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to postgres;
    """
)

cur.execute(

    """
    CREATE TABLE IF NOT EXISTS public."order"
(
    "OrderID" bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Address" bigint NOT NULL,
    "Date" character varying COLLATE pg_catalog."default" NOT NULL,
    status smallint NOT NULL,
    CONSTRAINT "Order_pkey" PRIMARY KEY ("OrderID"),
    CONSTRAINT "Address" FOREIGN KEY ("Address")
        REFERENCES public.address ("addressID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."order"
    OWNER to postgres;
    """
)

cur.execute(
    """
    CREATE TABLE IF NOT EXISTS public."orderDetails"
(
    id bigint NOT NULL,
    quantity smallint NOT NULL,
    orderid bigint NOT NULL,
    CONSTRAINT id FOREIGN KEY (id)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT,
    CONSTRAINT "order" FOREIGN KEY (orderid)
        REFERENCES public."order" ("OrderID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."orderDetails"
    OWNER to postgres;
    """
)





for product in products:
    product.toInsertQuery(cur=cur)


# Uncomment the below code to see inserted products
# cur.execute("select * from products")
# row = cur.fetchall()

# for i in row:
#     print(i)


cur.close()
conn.commit() # saving all the changes to database