PGDMP  8    &                |            SGH_-2    16.6    16.6 R              0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    20121    SGH_-2    DATABASE        CREATE DATABASE "SGH_-2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "SGH_-2";
                postgres    false                       1255    20766 !   atualiza_valor_reserva_item_pet()    FUNCTION     �  CREATE FUNCTION public.atualiza_valor_reserva_item_pet() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    valor_produto NUMERIC;
BEGIN
    -- Busca o valor do produto correspondente
    SELECT Preco_Unitario INTO valor_produto
    FROM ITEM_PET
    WHERE id = NEW.item_id;

    -- Atualiza o valor_total na tabela RESERVAS
    UPDATE RESERVA
    SET Preco_final = Preco_final + valor_produto
    WHERE id = NEW.reserva_id;

    RETURN NEW;
END;
$$;
 8   DROP FUNCTION public.atualiza_valor_reserva_item_pet();
       public          postgres    false                        1255    20768 &   atualiza_valor_reserva_pagametos_pet()    FUNCTION     �  CREATE FUNCTION public.atualiza_valor_reserva_pagametos_pet() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    valor_produto NUMERIC;
BEGIN
    -- Busca o valor do produto correspondente
    SELECT Preco INTO valor_produto
    FROM servico_de_banho_e_tosa
    WHERE id = NEW.ServicoPet_ID;

    -- Atualiza o valor_total na tabela RESERVAS
    UPDATE RESERVA
    SET Preco_final = Preco_final + valor_produto
    WHERE id = NEW.reserva_id;

    RETURN NEW;
END;
$$;
 =   DROP FUNCTION public.atualiza_valor_reserva_pagametos_pet();
       public          postgres    false                       1255    20764     atualiza_valor_reserva_produto()    FUNCTION     �  CREATE FUNCTION public.atualiza_valor_reserva_produto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    valor_produto NUMERIC;
BEGIN
    -- Busca o valor do produto correspondente
    SELECT Preco_Unitario INTO valor_produto
    FROM ITEM_FRIGOBAR
    WHERE Nome = NEW.Nome_Item;

    -- Atualiza o valor_total na tabela RESERVAS
    UPDATE RESERVA
    SET Preco_final = Preco_final + valor_produto
    WHERE id = NEW.id_reserva;

    RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.atualiza_valor_reserva_produto();
       public          postgres    false            !           1255    20770    reduz_quantidade_estoque()    FUNCTION     �  CREATE FUNCTION public.reduz_quantidade_estoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE ESTOQUE
    SET quantidade = ESTOQUE.quantidade - SERVICO_QUARTO.quantidade
    FROM SERVICO_QUARTO
    WHERE ESTOQUE.Nome = NEW.Item_nome;

    UPDATE RESERVA
    SET preco_final = preco_final + SERVICO_QUARTO.preco_unitario
    FROM SERVICO_QUARTO
    WHERE RESERVA.id = SERVICO_QUARTO.reserva_id;

    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.reduz_quantidade_estoque();
       public          postgres    false            �            1259    20122    academia    TABLE     F   CREATE TABLE public.academia (
    dependencia_id integer NOT NULL
);
    DROP TABLE public.academia;
       public         heap    postgres    false            �            1259    20127 
   acomodacao    TABLE     �   CREATE TABLE public.acomodacao (
    numero character(11) NOT NULL,
    dependencia_id integer NOT NULL,
    status_de_ocupacao character varying(15) NOT NULL,
    tipo character varying(15) NOT NULL
);
    DROP TABLE public.acomodacao;
       public         heap    postgres    false            �            1259    20134    acompanhante    TABLE     �   CREATE TABLE public.acompanhante (
    cpf character(11) NOT NULL,
    nome character varying(60) NOT NULL,
    genero character varying(20) NOT NULL,
    menor_de_idade boolean NOT NULL
);
     DROP TABLE public.acompanhante;
       public         heap    postgres    false            �            1259    20139    alergias_pet    TABLE     r   CREATE TABLE public.alergias_pet (
    animal_id integer NOT NULL,
    alergias character varying(30) NOT NULL
);
     DROP TABLE public.alergias_pet;
       public         heap    postgres    false            �            1259    20144 
   amenidades    TABLE        CREATE TABLE public.amenidades (
    numero_acomodacao character(11) NOT NULL,
    amenidade character varying(20) NOT NULL
);
    DROP TABLE public.amenidades;
       public         heap    postgres    false            �            1259    20150    animal    TABLE     �   CREATE TABLE public.animal (
    id integer NOT NULL,
    nome character varying(50) NOT NULL,
    especie character varying(30) NOT NULL,
    raca character varying(30) NOT NULL,
    cliente_cpf character(11) NOT NULL
);
    DROP TABLE public.animal;
       public         heap    postgres    false            �            1259    20149    animal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.animal_id_seq;
       public          postgres    false    221                       0    0    animal_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.animal_id_seq OWNED BY public.animal.id;
          public          postgres    false    220            �            1259    20156 	   atendente    TABLE     B   CREATE TABLE public.atendente (
    cpf character(11) NOT NULL
);
    DROP TABLE public.atendente;
       public         heap    postgres    false            �            1259    20161 	   beneficio    TABLE     |   CREATE TABLE public.beneficio (
    funcionario_cpf character(11) NOT NULL,
    beneficio character varying(30) NOT NULL
);
    DROP TABLE public.beneficio;
       public         heap    postgres    false            �            1259    20166    beneficio_dep    TABLE        CREATE TABLE public.beneficio_dep (
    dependente_cpf character(11) NOT NULL,
    beneficio character varying(30) NOT NULL
);
 !   DROP TABLE public.beneficio_dep;
       public         heap    postgres    false            �            1259    20172    caixa_de_entrada    TABLE     �   CREATE TABLE public.caixa_de_entrada (
    id integer NOT NULL,
    reserva_id integer,
    devedor character varying(30) NOT NULL,
    data date NOT NULL,
    valor real NOT NULL,
    condomino_cnpj character(14)
);
 $   DROP TABLE public.caixa_de_entrada;
       public         heap    postgres    false            �            1259    20171    caixa_de_entrada_id_seq    SEQUENCE     �   CREATE SEQUENCE public.caixa_de_entrada_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.caixa_de_entrada_id_seq;
       public          postgres    false    226                        0    0    caixa_de_entrada_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.caixa_de_entrada_id_seq OWNED BY public.caixa_de_entrada.id;
          public          postgres    false    225            �            1259    20181    caixa_de_saida    TABLE     �   CREATE TABLE public.caixa_de_saida (
    id integer NOT NULL,
    credor character varying(60) NOT NULL,
    data date NOT NULL,
    valor real NOT NULL,
    funcionario_cpf character(11) NOT NULL
);
 "   DROP TABLE public.caixa_de_saida;
       public         heap    postgres    false            �            1259    20180    caixa_de_saida_id_seq    SEQUENCE     �   CREATE SEQUENCE public.caixa_de_saida_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.caixa_de_saida_id_seq;
       public          postgres    false    228            !           0    0    caixa_de_saida_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.caixa_de_saida_id_seq OWNED BY public.caixa_de_saida.id;
          public          postgres    false    227            �            1259    20187    cliente    TABLE     �   CREATE TABLE public.cliente (
    cpf character(11) NOT NULL,
    nome character varying(60) NOT NULL,
    genero character varying(15) NOT NULL,
    data_de_nascimento date NOT NULL,
    pontos_de_bonificacao integer NOT NULL
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    20192    clinica_vet    TABLE     r   CREATE TABLE public.clinica_vet (
    dependencia_id integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.clinica_vet;
       public         heap    postgres    false            �            1259    20197 	   condomino    TABLE     �   CREATE TABLE public.condomino (
    cnpj character(14) NOT NULL,
    razao_social character varying(40) NOT NULL,
    tipo character varying(20) NOT NULL,
    aluguel real NOT NULL,
    hotel_id integer NOT NULL
);
    DROP TABLE public.condomino;
       public         heap    postgres    false            �            1259    20202    cons_realizada    TABLE     u   CREATE TABLE public.cons_realizada (
    veterinario_cpf character(11) NOT NULL,
    consulta_id integer NOT NULL
);
 "   DROP TABLE public.cons_realizada;
       public         heap    postgres    false            �            1259    20208    consulta    TABLE     �   CREATE TABLE public.consulta (
    id integer NOT NULL,
    tipo character varying(20) NOT NULL,
    data date NOT NULL,
    animal_id integer NOT NULL,
    clinica_id integer NOT NULL
);
    DROP TABLE public.consulta;
       public         heap    postgres    false            �            1259    20207    consulta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.consulta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.consulta_id_seq;
       public          postgres    false    234            "           0    0    consulta_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.consulta_id_seq OWNED BY public.consulta.id;
          public          postgres    false    233            �            1259    20215    consumo_reserva    TABLE     �   CREATE TABLE public.consumo_reserva (
    id integer NOT NULL,
    nome_item character varying(15) NOT NULL,
    id_reserva integer NOT NULL
);
 #   DROP TABLE public.consumo_reserva;
       public         heap    postgres    false            �            1259    20214    consumo_reserva_id_seq    SEQUENCE     �   CREATE SEQUENCE public.consumo_reserva_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.consumo_reserva_id_seq;
       public          postgres    false    236            #           0    0    consumo_reserva_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.consumo_reserva_id_seq OWNED BY public.consumo_reserva.id;
          public          postgres    false    235            �            1259    20222    dependencias    TABLE     )  CREATE TABLE public.dependencias (
    id integer NOT NULL,
    status_de_limpeza character varying(30) NOT NULL,
    capacidade_maxima integer NOT NULL,
    horario_de_funcionamento character varying(30) NOT NULL,
    data_da_ultima_limpeza date NOT NULL,
    hotel_id integer NOT NULL,
    restaurante boolean,
    piscina boolean,
    pet_shop boolean,
    espaco_de_evento boolean,
    clinica_veterinaria boolean,
    acomodacao boolean,
    academia boolean,
    CONSTRAINT extone_dependencias CHECK ((((pet_shop IS NOT NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NULL) AND (restaurante IS NULL) AND (piscina IS NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NOT NULL) AND (academia IS NULL) AND (restaurante IS NULL) AND (piscina IS NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NOT NULL) AND (restaurante IS NULL) AND (piscina IS NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NULL) AND (restaurante IS NOT NULL) AND (piscina IS NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NULL) AND (restaurante IS NULL) AND (piscina IS NOT NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NULL) AND (restaurante IS NULL) AND (piscina IS NULL) AND (acomodacao IS NOT NULL) AND (espaco_de_evento IS NULL)) OR ((pet_shop IS NULL) AND (clinica_veterinaria IS NULL) AND (academia IS NULL) AND (restaurante IS NULL) AND (piscina IS NULL) AND (acomodacao IS NULL) AND (espaco_de_evento IS NOT NULL))))
);
     DROP TABLE public.dependencias;
       public         heap    postgres    false            �            1259    20221    dependencias_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dependencias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.dependencias_id_seq;
       public          postgres    false    238            $           0    0    dependencias_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.dependencias_id_seq OWNED BY public.dependencias.id;
          public          postgres    false    237            �            1259    20228 
   dependente    TABLE     �   CREATE TABLE public.dependente (
    cpf character(11) NOT NULL,
    nome character varying(60) NOT NULL,
    genero character varying(10) NOT NULL
);
    DROP TABLE public.dependente;
       public         heap    postgres    false            �            1259    20234    entregas_robo    TABLE       CREATE TABLE public.entregas_robo (
    id integer NOT NULL,
    item character varying(15) NOT NULL,
    status character varying(10) NOT NULL,
    remetente character varying(60) NOT NULL,
    data date NOT NULL,
    numero_acomodacao character(11) NOT NULL
);
 !   DROP TABLE public.entregas_robo;
       public         heap    postgres    false            �            1259    20233    entregas_robo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.entregas_robo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.entregas_robo_id_seq;
       public          postgres    false    241            %           0    0    entregas_robo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.entregas_robo_id_seq OWNED BY public.entregas_robo.id;
          public          postgres    false    240            �            1259    20240    equipamento_acad    TABLE     |   CREATE TABLE public.equipamento_acad (
    academia_id integer NOT NULL,
    equipamentos character varying(20) NOT NULL
);
 $   DROP TABLE public.equipamento_acad;
       public         heap    postgres    false            �            1259    20245    equipamento_clin    TABLE     {   CREATE TABLE public.equipamento_clin (
    clinica_id integer NOT NULL,
    equipamentos character varying(20) NOT NULL
);
 $   DROP TABLE public.equipamento_clin;
       public         heap    postgres    false            �            1259    20250    espaco_de_evento    TABLE     N   CREATE TABLE public.espaco_de_evento (
    dependencia_id integer NOT NULL
);
 $   DROP TABLE public.espaco_de_evento;
       public         heap    postgres    false            �            1259    20256    estacionamento    TABLE     $  CREATE TABLE public.estacionamento (
    id integer NOT NULL,
    status character varying(10) NOT NULL,
    tipo character varying(20) NOT NULL,
    setor character varying(20),
    valor_diario real NOT NULL,
    placa_do_automovel character(8) NOT NULL,
    reserva_id integer NOT NULL
);
 "   DROP TABLE public.estacionamento;
       public         heap    postgres    false            �            1259    20255    estacionamento_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estacionamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.estacionamento_id_seq;
       public          postgres    false    246            &           0    0    estacionamento_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.estacionamento_id_seq OWNED BY public.estacionamento.id;
          public          postgres    false    245            �            1259    20262    estoque    TABLE     �   CREATE TABLE public.estoque (
    nome character varying(15) NOT NULL,
    preco_unitario real NOT NULL,
    quantidade integer NOT NULL
);
    DROP TABLE public.estoque;
       public         heap    postgres    false            �            1259    20267    funcionario    TABLE     t  CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    nome character varying(60) NOT NULL,
    genero character varying(10) NOT NULL,
    data_de_nascimento date NOT NULL,
    tipo_de_contrato character varying(30) NOT NULL,
    salario real NOT NULL,
    seguranca boolean,
    passeador boolean,
    medico_veterinario boolean,
    atendente boolean,
    hotel_id integer NOT NULL,
    CONSTRAINT extone_funcionario CHECK ((((passeador IS NOT NULL) AND (seguranca IS NULL) AND (medico_veterinario IS NULL) AND (atendente IS NULL)) OR ((passeador IS NULL) AND (seguranca IS NOT NULL) AND (medico_veterinario IS NULL) AND (atendente IS NULL)) OR ((passeador IS NULL) AND (seguranca IS NULL) AND (medico_veterinario IS NOT NULL) AND (atendente IS NULL)) OR ((passeador IS NULL) AND (seguranca IS NULL) AND (medico_veterinario IS NULL) AND (atendente IS NOT NULL))))
);
    DROP TABLE public.funcionario;
       public         heap    postgres    false            �            1259    20272    funcionario_dep    TABLE        CREATE TABLE public.funcionario_dep (
    dependente_cpf character(11) NOT NULL,
    funcionario_cpf character(11) NOT NULL
);
 #   DROP TABLE public.funcionario_dep;
       public         heap    postgres    false            �            1259    20278    hotel    TABLE     $  CREATE TABLE public.hotel (
    id integer NOT NULL,
    nome_fantasia character varying(40) NOT NULL,
    tamanho character varying(15) NOT NULL,
    categoria character varying(15) NOT NULL,
    localizacao character varying(40) NOT NULL,
    registro_imobiliario character(16) NOT NULL
);
    DROP TABLE public.hotel;
       public         heap    postgres    false            �            1259    20277    hotel_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.hotel_id_seq;
       public          postgres    false    251            '           0    0    hotel_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.hotel_id_seq OWNED BY public.hotel.id;
          public          postgres    false    250            �            1259    20284    infraestrutura    TABLE     y   CREATE TABLE public.infraestrutura (
    espev_id integer NOT NULL,
    infraestrutura character varying(50) NOT NULL
);
 "   DROP TABLE public.infraestrutura;
       public         heap    postgres    false            �            1259    20289    item_frigobar    TABLE     �   CREATE TABLE public.item_frigobar (
    nome character varying(15) NOT NULL,
    preco_unitario real NOT NULL,
    quantidade integer NOT NULL,
    numero_acomodacao character(11) NOT NULL
);
 !   DROP TABLE public.item_frigobar;
       public         heap    postgres    false            �            1259    20295    item_pet    TABLE     �   CREATE TABLE public.item_pet (
    id integer NOT NULL,
    nome character varying(30) NOT NULL,
    preco_unitario real NOT NULL,
    quantidade integer NOT NULL,
    precisa_de_receita boolean NOT NULL,
    petshop_id integer NOT NULL
);
    DROP TABLE public.item_pet;
       public         heap    postgres    false                       1259    20302    item_pet_compra    TABLE     �   CREATE TABLE public.item_pet_compra (
    id integer NOT NULL,
    item_id integer NOT NULL,
    reserva_id integer NOT NULL
);
 #   DROP TABLE public.item_pet_compra;
       public         heap    postgres    false                        1259    20301    item_pet_compra_id_seq    SEQUENCE     �   CREATE SEQUENCE public.item_pet_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.item_pet_compra_id_seq;
       public          postgres    false    257            (           0    0    item_pet_compra_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.item_pet_compra_id_seq OWNED BY public.item_pet_compra.id;
          public          postgres    false    256            �            1259    20294    item_pet_id_seq    SEQUENCE     �   CREATE SEQUENCE public.item_pet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.item_pet_id_seq;
       public          postgres    false    255            )           0    0    item_pet_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.item_pet_id_seq OWNED BY public.item_pet.id;
          public          postgres    false    254                       1259    20308 
   medico_vet    TABLE     c   CREATE TABLE public.medico_vet (
    cpf character(11) NOT NULL,
    crmv character(8) NOT NULL
);
    DROP TABLE public.medico_vet;
       public         heap    postgres    false                       1259    20316    pagamentos_pet    TABLE     �   CREATE TABLE public.pagamentos_pet (
    id integer NOT NULL,
    reserva_id integer NOT NULL,
    servicopet_id integer NOT NULL
);
 "   DROP TABLE public.pagamentos_pet;
       public         heap    postgres    false                       1259    20315    pagamentos_pet_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagamentos_pet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.pagamentos_pet_id_seq;
       public          postgres    false    260            *           0    0    pagamentos_pet_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.pagamentos_pet_id_seq OWNED BY public.pagamentos_pet.id;
          public          postgres    false    259                       1259    20322    pas_percorridos    TABLE     i   CREATE TABLE public.pas_percorridos (
    animal_id integer NOT NULL,
    passeio_id integer NOT NULL
);
 #   DROP TABLE public.pas_percorridos;
       public         heap    postgres    false                       1259    20327 	   passeador    TABLE     B   CREATE TABLE public.passeador (
    cpf character(11) NOT NULL
);
    DROP TABLE public.passeador;
       public         heap    postgres    false                       1259    20333    passeio    TABLE     �   CREATE TABLE public.passeio (
    id integer NOT NULL,
    trajeto character varying(30) NOT NULL,
    data date NOT NULL,
    passeador_cpf character(11) NOT NULL
);
    DROP TABLE public.passeio;
       public         heap    postgres    false                       1259    20332    passeio_id_seq    SEQUENCE     �   CREATE SEQUENCE public.passeio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.passeio_id_seq;
       public          postgres    false    264            +           0    0    passeio_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.passeio_id_seq OWNED BY public.passeio.id;
          public          postgres    false    263            	           1259    20339    pet_shop    TABLE     o   CREATE TABLE public.pet_shop (
    dependencia_id integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.pet_shop;
       public         heap    postgres    false            
           1259    20344    piscina    TABLE     h   CREATE TABLE public.piscina (
    dependencia_id integer NOT NULL,
    profundidade integer NOT NULL
);
    DROP TABLE public.piscina;
       public         heap    postgres    false                       1259    20349    politicas_de_uso    TABLE     �   CREATE TABLE public.politicas_de_uso (
    dependencia_id integer NOT NULL,
    politicas_de_uso character varying(200) NOT NULL
);
 $   DROP TABLE public.politicas_de_uso;
       public         heap    postgres    false                       1259    20354    precos_praticados    TABLE     �   CREATE TABLE public.precos_praticados (
    numero_acomodacao character(11) NOT NULL,
    periodo character varying(15) NOT NULL,
    diaria real NOT NULL
);
 %   DROP TABLE public.precos_praticados;
       public         heap    postgres    false                       1259    20360    receita_vet    TABLE     �   CREATE TABLE public.receita_vet (
    id integer NOT NULL,
    remedio character varying(50) NOT NULL,
    data date NOT NULL,
    prazo date NOT NULL,
    veterinario_cpf character(11) NOT NULL
);
    DROP TABLE public.receita_vet;
       public         heap    postgres    false                       1259    20359    receita_vet_id_seq    SEQUENCE     �   CREATE SEQUENCE public.receita_vet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.receita_vet_id_seq;
       public          postgres    false    270            ,           0    0    receita_vet_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.receita_vet_id_seq OWNED BY public.receita_vet.id;
          public          postgres    false    269                       1259    20367    remocao_estoque    TABLE     �   CREATE TABLE public.remocao_estoque (
    id integer NOT NULL,
    item_nome character varying(15) NOT NULL,
    servicoquarto_id integer NOT NULL
);
 #   DROP TABLE public.remocao_estoque;
       public         heap    postgres    false                       1259    20366    remocao_estoque_id_seq    SEQUENCE     �   CREATE SEQUENCE public.remocao_estoque_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.remocao_estoque_id_seq;
       public          postgres    false    272            -           0    0    remocao_estoque_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.remocao_estoque_id_seq OWNED BY public.remocao_estoque.id;
          public          postgres    false    271                       1259    20374 
   requisicao    TABLE     w  CREATE TABLE public.requisicao (
    id integer NOT NULL,
    status character varying(10) NOT NULL,
    data_de_abertura date NOT NULL,
    data_de_encerramento date NOT NULL,
    tipo character varying(20) NOT NULL,
    texto character varying(250) NOT NULL,
    requisicao_geral boolean NOT NULL,
    cliente_cpf character(11),
    atendente_cpf character(11) NOT NULL
);
    DROP TABLE public.requisicao;
       public         heap    postgres    false                       1259    20373    requisicao_id_seq    SEQUENCE     �   CREATE SEQUENCE public.requisicao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.requisicao_id_seq;
       public          postgres    false    274            .           0    0    requisicao_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.requisicao_id_seq OWNED BY public.requisicao.id;
          public          postgres    false    273                       1259    20381    reserva    TABLE     A  CREATE TABLE public.reserva (
    id integer NOT NULL,
    data_do_check_in date NOT NULL,
    data_do_check_out date NOT NULL,
    preco_final real NOT NULL,
    inclui_cafe_da_manha boolean NOT NULL,
    numero_acomodacao character(11) NOT NULL,
    cliente_cpf character(11) NOT NULL,
    hotel_id integer NOT NULL
);
    DROP TABLE public.reserva;
       public         heap    postgres    false                       1259    20387    reserva_acomp    TABLE     t   CREATE TABLE public.reserva_acomp (
    acompanhante_cpf character(11) NOT NULL,
    reserva_id integer NOT NULL
);
 !   DROP TABLE public.reserva_acomp;
       public         heap    postgres    false                       1259    20380    reserva_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reserva_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.reserva_id_seq;
       public          postgres    false    276            /           0    0    reserva_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.reserva_id_seq OWNED BY public.reserva.id;
          public          postgres    false    275                       1259    20392    restaurante    TABLE     �   CREATE TABLE public.restaurante (
    dependencia_id integer NOT NULL,
    nome character varying(30) NOT NULL,
    aceita_vr boolean NOT NULL
);
    DROP TABLE public.restaurante;
       public         heap    postgres    false                       1259    20397 	   seguranca    TABLE     l   CREATE TABLE public.seguranca (
    cpf character(11) NOT NULL,
    turno character varying(20) NOT NULL
);
    DROP TABLE public.seguranca;
       public         heap    postgres    false                       1259    20403    servico_de_banho_e_tosa    TABLE     �   CREATE TABLE public.servico_de_banho_e_tosa (
    id integer NOT NULL,
    tipo character varying(20) NOT NULL,
    data date NOT NULL,
    preco real NOT NULL,
    animal_id integer NOT NULL,
    petshop_id integer NOT NULL
);
 +   DROP TABLE public.servico_de_banho_e_tosa;
       public         heap    postgres    false                       1259    20402    servico_de_banho_e_tosa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servico_de_banho_e_tosa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.servico_de_banho_e_tosa_id_seq;
       public          postgres    false    281            0           0    0    servico_de_banho_e_tosa_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.servico_de_banho_e_tosa_id_seq OWNED BY public.servico_de_banho_e_tosa.id;
          public          postgres    false    280                       1259    20410    servico_quarto    TABLE     �   CREATE TABLE public.servico_quarto (
    id integer NOT NULL,
    nome character(15) NOT NULL,
    preco_unitario real NOT NULL,
    quantidade integer NOT NULL,
    reserva_id integer NOT NULL
);
 "   DROP TABLE public.servico_quarto;
       public         heap    postgres    false                       1259    20409    servico_quarto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.servico_quarto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.servico_quarto_id_seq;
       public          postgres    false    283            1           0    0    servico_quarto_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.servico_quarto_id_seq OWNED BY public.servico_quarto.id;
          public          postgres    false    282                       1259    20416    setor    TABLE     g   CREATE TABLE public.setor (
    id_hotel integer NOT NULL,
    setor character varying(20) NOT NULL
);
    DROP TABLE public.setor;
       public         heap    postgres    false                       1259    20421 	   tipos_uso    TABLE     r   CREATE TABLE public.tipos_uso (
    espev_id integer NOT NULL,
    tipos_de_uso character varying(30) NOT NULL
);
    DROP TABLE public.tipos_uso;
       public         heap    postgres    false            a           2604    20153 	   animal id    DEFAULT     f   ALTER TABLE ONLY public.animal ALTER COLUMN id SET DEFAULT nextval('public.animal_id_seq'::regclass);
 8   ALTER TABLE public.animal ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            b           2604    20175    caixa_de_entrada id    DEFAULT     z   ALTER TABLE ONLY public.caixa_de_entrada ALTER COLUMN id SET DEFAULT nextval('public.caixa_de_entrada_id_seq'::regclass);
 B   ALTER TABLE public.caixa_de_entrada ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            c           2604    20184    caixa_de_saida id    DEFAULT     v   ALTER TABLE ONLY public.caixa_de_saida ALTER COLUMN id SET DEFAULT nextval('public.caixa_de_saida_id_seq'::regclass);
 @   ALTER TABLE public.caixa_de_saida ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            d           2604    20211    consulta id    DEFAULT     j   ALTER TABLE ONLY public.consulta ALTER COLUMN id SET DEFAULT nextval('public.consulta_id_seq'::regclass);
 :   ALTER TABLE public.consulta ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            e           2604    20218    consumo_reserva id    DEFAULT     x   ALTER TABLE ONLY public.consumo_reserva ALTER COLUMN id SET DEFAULT nextval('public.consumo_reserva_id_seq'::regclass);
 A   ALTER TABLE public.consumo_reserva ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            f           2604    20225    dependencias id    DEFAULT     r   ALTER TABLE ONLY public.dependencias ALTER COLUMN id SET DEFAULT nextval('public.dependencias_id_seq'::regclass);
 >   ALTER TABLE public.dependencias ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237    238            g           2604    20237    entregas_robo id    DEFAULT     t   ALTER TABLE ONLY public.entregas_robo ALTER COLUMN id SET DEFAULT nextval('public.entregas_robo_id_seq'::regclass);
 ?   ALTER TABLE public.entregas_robo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241            h           2604    20259    estacionamento id    DEFAULT     v   ALTER TABLE ONLY public.estacionamento ALTER COLUMN id SET DEFAULT nextval('public.estacionamento_id_seq'::regclass);
 @   ALTER TABLE public.estacionamento ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    245    246    246            i           2604    20281    hotel id    DEFAULT     d   ALTER TABLE ONLY public.hotel ALTER COLUMN id SET DEFAULT nextval('public.hotel_id_seq'::regclass);
 7   ALTER TABLE public.hotel ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    250    251    251            j           2604    20298    item_pet id    DEFAULT     j   ALTER TABLE ONLY public.item_pet ALTER COLUMN id SET DEFAULT nextval('public.item_pet_id_seq'::regclass);
 :   ALTER TABLE public.item_pet ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    254    255    255            k           2604    20305    item_pet_compra id    DEFAULT     x   ALTER TABLE ONLY public.item_pet_compra ALTER COLUMN id SET DEFAULT nextval('public.item_pet_compra_id_seq'::regclass);
 A   ALTER TABLE public.item_pet_compra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    256    257    257            l           2604    20319    pagamentos_pet id    DEFAULT     v   ALTER TABLE ONLY public.pagamentos_pet ALTER COLUMN id SET DEFAULT nextval('public.pagamentos_pet_id_seq'::regclass);
 @   ALTER TABLE public.pagamentos_pet ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    259    260    260            m           2604    20336 
   passeio id    DEFAULT     h   ALTER TABLE ONLY public.passeio ALTER COLUMN id SET DEFAULT nextval('public.passeio_id_seq'::regclass);
 9   ALTER TABLE public.passeio ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    264    263    264            n           2604    20363    receita_vet id    DEFAULT     p   ALTER TABLE ONLY public.receita_vet ALTER COLUMN id SET DEFAULT nextval('public.receita_vet_id_seq'::regclass);
 =   ALTER TABLE public.receita_vet ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    270    269    270            o           2604    20370    remocao_estoque id    DEFAULT     x   ALTER TABLE ONLY public.remocao_estoque ALTER COLUMN id SET DEFAULT nextval('public.remocao_estoque_id_seq'::regclass);
 A   ALTER TABLE public.remocao_estoque ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    271    272    272            p           2604    20377    requisicao id    DEFAULT     n   ALTER TABLE ONLY public.requisicao ALTER COLUMN id SET DEFAULT nextval('public.requisicao_id_seq'::regclass);
 <   ALTER TABLE public.requisicao ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    274    273    274            q           2604    20384 
   reserva id    DEFAULT     h   ALTER TABLE ONLY public.reserva ALTER COLUMN id SET DEFAULT nextval('public.reserva_id_seq'::regclass);
 9   ALTER TABLE public.reserva ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    276    275    276            r           2604    20406    servico_de_banho_e_tosa id    DEFAULT     �   ALTER TABLE ONLY public.servico_de_banho_e_tosa ALTER COLUMN id SET DEFAULT nextval('public.servico_de_banho_e_tosa_id_seq'::regclass);
 I   ALTER TABLE public.servico_de_banho_e_tosa ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    281    280    281            s           2604    20413    servico_quarto id    DEFAULT     v   ALTER TABLE ONLY public.servico_quarto ALTER COLUMN id SET DEFAULT nextval('public.servico_quarto_id_seq'::regclass);
 @   ALTER TABLE public.servico_quarto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    282    283    283            �          0    20122    academia 
   TABLE DATA           2   COPY public.academia (dependencia_id) FROM stdin;
    public          postgres    false    215   �      �          0    20127 
   acomodacao 
   TABLE DATA           V   COPY public.acomodacao (numero, dependencia_id, status_de_ocupacao, tipo) FROM stdin;
    public          postgres    false    216   7�      �          0    20134    acompanhante 
   TABLE DATA           I   COPY public.acompanhante (cpf, nome, genero, menor_de_idade) FROM stdin;
    public          postgres    false    217   Ơ      �          0    20139    alergias_pet 
   TABLE DATA           ;   COPY public.alergias_pet (animal_id, alergias) FROM stdin;
    public          postgres    false    218   q�      �          0    20144 
   amenidades 
   TABLE DATA           B   COPY public.amenidades (numero_acomodacao, amenidade) FROM stdin;
    public          postgres    false    219   ��      �          0    20150    animal 
   TABLE DATA           F   COPY public.animal (id, nome, especie, raca, cliente_cpf) FROM stdin;
    public          postgres    false    221   :�      �          0    20156 	   atendente 
   TABLE DATA           (   COPY public.atendente (cpf) FROM stdin;
    public          postgres    false    222   Ǣ      �          0    20161 	   beneficio 
   TABLE DATA           ?   COPY public.beneficio (funcionario_cpf, beneficio) FROM stdin;
    public          postgres    false    223   &�      �          0    20166    beneficio_dep 
   TABLE DATA           B   COPY public.beneficio_dep (dependente_cpf, beneficio) FROM stdin;
    public          postgres    false    224   ��      �          0    20172    caixa_de_entrada 
   TABLE DATA           `   COPY public.caixa_de_entrada (id, reserva_id, devedor, data, valor, condomino_cnpj) FROM stdin;
    public          postgres    false    226   �      �          0    20181    caixa_de_saida 
   TABLE DATA           R   COPY public.caixa_de_saida (id, credor, data, valor, funcionario_cpf) FROM stdin;
    public          postgres    false    228   ��      �          0    20187    cliente 
   TABLE DATA           _   COPY public.cliente (cpf, nome, genero, data_de_nascimento, pontos_de_bonificacao) FROM stdin;
    public          postgres    false    229   n�      �          0    20192    clinica_vet 
   TABLE DATA           ;   COPY public.clinica_vet (dependencia_id, nome) FROM stdin;
    public          postgres    false    230   ��      �          0    20197 	   condomino 
   TABLE DATA           P   COPY public.condomino (cnpj, razao_social, tipo, aluguel, hotel_id) FROM stdin;
    public          postgres    false    231   �      �          0    20202    cons_realizada 
   TABLE DATA           F   COPY public.cons_realizada (veterinario_cpf, consulta_id) FROM stdin;
    public          postgres    false    232   ��      �          0    20208    consulta 
   TABLE DATA           I   COPY public.consulta (id, tipo, data, animal_id, clinica_id) FROM stdin;
    public          postgres    false    234   ��      �          0    20215    consumo_reserva 
   TABLE DATA           D   COPY public.consumo_reserva (id, nome_item, id_reserva) FROM stdin;
    public          postgres    false    236   8�      �          0    20222    dependencias 
   TABLE DATA           �   COPY public.dependencias (id, status_de_limpeza, capacidade_maxima, horario_de_funcionamento, data_da_ultima_limpeza, hotel_id, restaurante, piscina, pet_shop, espaco_de_evento, clinica_veterinaria, acomodacao, academia) FROM stdin;
    public          postgres    false    238   ��      �          0    20228 
   dependente 
   TABLE DATA           7   COPY public.dependente (cpf, nome, genero) FROM stdin;
    public          postgres    false    239   u�      �          0    20234    entregas_robo 
   TABLE DATA           ]   COPY public.entregas_robo (id, item, status, remetente, data, numero_acomodacao) FROM stdin;
    public          postgres    false    241   �      �          0    20240    equipamento_acad 
   TABLE DATA           E   COPY public.equipamento_acad (academia_id, equipamentos) FROM stdin;
    public          postgres    false    242   �      �          0    20245    equipamento_clin 
   TABLE DATA           D   COPY public.equipamento_clin (clinica_id, equipamentos) FROM stdin;
    public          postgres    false    243   ��      �          0    20250    espaco_de_evento 
   TABLE DATA           :   COPY public.espaco_de_evento (dependencia_id) FROM stdin;
    public          postgres    false    244   0�      �          0    20256    estacionamento 
   TABLE DATA           o   COPY public.estacionamento (id, status, tipo, setor, valor_diario, placa_do_automovel, reserva_id) FROM stdin;
    public          postgres    false    246   [�      �          0    20262    estoque 
   TABLE DATA           C   COPY public.estoque (nome, preco_unitario, quantidade) FROM stdin;
    public          postgres    false    247   �      �          0    20267    funcionario 
   TABLE DATA           �   COPY public.funcionario (cpf, nome, genero, data_de_nascimento, tipo_de_contrato, salario, seguranca, passeador, medico_veterinario, atendente, hotel_id) FROM stdin;
    public          postgres    false    248   ��      �          0    20272    funcionario_dep 
   TABLE DATA           J   COPY public.funcionario_dep (dependente_cpf, funcionario_cpf) FROM stdin;
    public          postgres    false    249   v�      �          0    20278    hotel 
   TABLE DATA           i   COPY public.hotel (id, nome_fantasia, tamanho, categoria, localizacao, registro_imobiliario) FROM stdin;
    public          postgres    false    251   ߳      �          0    20284    infraestrutura 
   TABLE DATA           B   COPY public.infraestrutura (espev_id, infraestrutura) FROM stdin;
    public          postgres    false    252   ʹ      �          0    20289    item_frigobar 
   TABLE DATA           \   COPY public.item_frigobar (nome, preco_unitario, quantidade, numero_acomodacao) FROM stdin;
    public          postgres    false    253   k�      �          0    20295    item_pet 
   TABLE DATA           h   COPY public.item_pet (id, nome, preco_unitario, quantidade, precisa_de_receita, petshop_id) FROM stdin;
    public          postgres    false    255   �      �          0    20302    item_pet_compra 
   TABLE DATA           B   COPY public.item_pet_compra (id, item_id, reserva_id) FROM stdin;
    public          postgres    false    257   ��      �          0    20308 
   medico_vet 
   TABLE DATA           /   COPY public.medico_vet (cpf, crmv) FROM stdin;
    public          postgres    false    258   ��      �          0    20316    pagamentos_pet 
   TABLE DATA           G   COPY public.pagamentos_pet (id, reserva_id, servicopet_id) FROM stdin;
    public          postgres    false    260   u�                 0    20322    pas_percorridos 
   TABLE DATA           @   COPY public.pas_percorridos (animal_id, passeio_id) FROM stdin;
    public          postgres    false    261   ��                0    20327 	   passeador 
   TABLE DATA           (   COPY public.passeador (cpf) FROM stdin;
    public          postgres    false    262   �                0    20333    passeio 
   TABLE DATA           C   COPY public.passeio (id, trajeto, data, passeador_cpf) FROM stdin;
    public          postgres    false    264   Q�                0    20339    pet_shop 
   TABLE DATA           8   COPY public.pet_shop (dependencia_id, nome) FROM stdin;
    public          postgres    false    265   %�                0    20344    piscina 
   TABLE DATA           ?   COPY public.piscina (dependencia_id, profundidade) FROM stdin;
    public          postgres    false    266   ��                0    20349    politicas_de_uso 
   TABLE DATA           L   COPY public.politicas_de_uso (dependencia_id, politicas_de_uso) FROM stdin;
    public          postgres    false    267   ǹ                0    20354    precos_praticados 
   TABLE DATA           O   COPY public.precos_praticados (numero_acomodacao, periodo, diaria) FROM stdin;
    public          postgres    false    268   �      	          0    20360    receita_vet 
   TABLE DATA           P   COPY public.receita_vet (id, remedio, data, prazo, veterinario_cpf) FROM stdin;
    public          postgres    false    270   ��                0    20367    remocao_estoque 
   TABLE DATA           J   COPY public.remocao_estoque (id, item_nome, servicoquarto_id) FROM stdin;
    public          postgres    false    272   -�                0    20374 
   requisicao 
   TABLE DATA           �   COPY public.requisicao (id, status, data_de_abertura, data_de_encerramento, tipo, texto, requisicao_geral, cliente_cpf, atendente_cpf) FROM stdin;
    public          postgres    false    274   �                0    20381    reserva 
   TABLE DATA           �   COPY public.reserva (id, data_do_check_in, data_do_check_out, preco_final, inclui_cafe_da_manha, numero_acomodacao, cliente_cpf, hotel_id) FROM stdin;
    public          postgres    false    276   7�                0    20387    reserva_acomp 
   TABLE DATA           E   COPY public.reserva_acomp (acompanhante_cpf, reserva_id) FROM stdin;
    public          postgres    false    277   &�                0    20392    restaurante 
   TABLE DATA           F   COPY public.restaurante (dependencia_id, nome, aceita_vr) FROM stdin;
    public          postgres    false    278   w�                0    20397 	   seguranca 
   TABLE DATA           /   COPY public.seguranca (cpf, turno) FROM stdin;
    public          postgres    false    279   ̿                0    20403    servico_de_banho_e_tosa 
   TABLE DATA           _   COPY public.servico_de_banho_e_tosa (id, tipo, data, preco, animal_id, petshop_id) FROM stdin;
    public          postgres    false    281   /�                0    20410    servico_quarto 
   TABLE DATA           Z   COPY public.servico_quarto (id, nome, preco_unitario, quantidade, reserva_id) FROM stdin;
    public          postgres    false    283   ��                0    20416    setor 
   TABLE DATA           0   COPY public.setor (id_hotel, setor) FROM stdin;
    public          postgres    false    284   �                0    20421 	   tipos_uso 
   TABLE DATA           ;   COPY public.tipos_uso (espev_id, tipos_de_uso) FROM stdin;
    public          postgres    false    285   `�      2           0    0    animal_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.animal_id_seq', 1, false);
          public          postgres    false    220            3           0    0    caixa_de_entrada_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.caixa_de_entrada_id_seq', 1, false);
          public          postgres    false    225            4           0    0    caixa_de_saida_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.caixa_de_saida_id_seq', 1, false);
          public          postgres    false    227            5           0    0    consulta_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.consulta_id_seq', 1, false);
          public          postgres    false    233            6           0    0    consumo_reserva_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.consumo_reserva_id_seq', 1, false);
          public          postgres    false    235            7           0    0    dependencias_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.dependencias_id_seq', 1, false);
          public          postgres    false    237            8           0    0    entregas_robo_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.entregas_robo_id_seq', 1, false);
          public          postgres    false    240            9           0    0    estacionamento_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.estacionamento_id_seq', 1, false);
          public          postgres    false    245            :           0    0    hotel_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.hotel_id_seq', 1, false);
          public          postgres    false    250            ;           0    0    item_pet_compra_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.item_pet_compra_id_seq', 1, false);
          public          postgres    false    256            <           0    0    item_pet_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.item_pet_id_seq', 1, false);
          public          postgres    false    254            =           0    0    pagamentos_pet_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.pagamentos_pet_id_seq', 1, false);
          public          postgres    false    259            >           0    0    passeio_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.passeio_id_seq', 1, false);
          public          postgres    false    263            ?           0    0    receita_vet_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.receita_vet_id_seq', 1, false);
          public          postgres    false    269            @           0    0    remocao_estoque_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.remocao_estoque_id_seq', 1, false);
          public          postgres    false    271            A           0    0    requisicao_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.requisicao_id_seq', 1, false);
          public          postgres    false    273            B           0    0    reserva_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.reserva_id_seq', 1, false);
          public          postgres    false    275            C           0    0    servico_de_banho_e_tosa_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.servico_de_banho_e_tosa_id_seq', 1, false);
          public          postgres    false    280            D           0    0    servico_quarto_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.servico_quarto_id_seq', 1, false);
          public          postgres    false    282            w           2606    20126    academia fkdep_aca_id 
   CONSTRAINT     _   ALTER TABLE ONLY public.academia
    ADD CONSTRAINT fkdep_aca_id PRIMARY KEY (dependencia_id);
 ?   ALTER TABLE ONLY public.academia DROP CONSTRAINT fkdep_aca_id;
       public            postgres    false    215            y           2606    20133    acomodacao fkdep_aco_id 
   CONSTRAINT     \   ALTER TABLE ONLY public.acomodacao
    ADD CONSTRAINT fkdep_aco_id UNIQUE (dependencia_id);
 A   ALTER TABLE ONLY public.acomodacao DROP CONSTRAINT fkdep_aco_id;
       public            postgres    false    216            �           2606    20196    clinica_vet fkdep_cli_id 
   CONSTRAINT     b   ALTER TABLE ONLY public.clinica_vet
    ADD CONSTRAINT fkdep_cli_id PRIMARY KEY (dependencia_id);
 B   ALTER TABLE ONLY public.clinica_vet DROP CONSTRAINT fkdep_cli_id;
       public            postgres    false    230            �           2606    20276    funcionario_dep fkdep_dep_id 
   CONSTRAINT     f   ALTER TABLE ONLY public.funcionario_dep
    ADD CONSTRAINT fkdep_dep_id PRIMARY KEY (dependente_cpf);
 F   ALTER TABLE ONLY public.funcionario_dep DROP CONSTRAINT fkdep_dep_id;
       public            postgres    false    249            �           2606    20254    espaco_de_evento fkdep_esp_id 
   CONSTRAINT     g   ALTER TABLE ONLY public.espaco_de_evento
    ADD CONSTRAINT fkdep_esp_id PRIMARY KEY (dependencia_id);
 G   ALTER TABLE ONLY public.espaco_de_evento DROP CONSTRAINT fkdep_esp_id;
       public            postgres    false    244            �           2606    20343    pet_shop fkdep_pet_id 
   CONSTRAINT     _   ALTER TABLE ONLY public.pet_shop
    ADD CONSTRAINT fkdep_pet_id PRIMARY KEY (dependencia_id);
 ?   ALTER TABLE ONLY public.pet_shop DROP CONSTRAINT fkdep_pet_id;
       public            postgres    false    265            �           2606    20348    piscina fkdep_pis_id 
   CONSTRAINT     ^   ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT fkdep_pis_id PRIMARY KEY (dependencia_id);
 >   ALTER TABLE ONLY public.piscina DROP CONSTRAINT fkdep_pis_id;
       public            postgres    false    266            �           2606    20396    restaurante fkdep_res_id 
   CONSTRAINT     b   ALTER TABLE ONLY public.restaurante
    ADD CONSTRAINT fkdep_res_id PRIMARY KEY (dependencia_id);
 B   ALTER TABLE ONLY public.restaurante DROP CONSTRAINT fkdep_res_id;
       public            postgres    false    278            �           2606    20179 %   caixa_de_entrada fkentrada_reserva_id 
   CONSTRAINT     f   ALTER TABLE ONLY public.caixa_de_entrada
    ADD CONSTRAINT fkentrada_reserva_id UNIQUE (reserva_id);
 O   ALTER TABLE ONLY public.caixa_de_entrada DROP CONSTRAINT fkentrada_reserva_id;
       public            postgres    false    226            �           2606    20160    atendente fkfun_ate_id 
   CONSTRAINT     U   ALTER TABLE ONLY public.atendente
    ADD CONSTRAINT fkfun_ate_id PRIMARY KEY (cpf);
 @   ALTER TABLE ONLY public.atendente DROP CONSTRAINT fkfun_ate_id;
       public            postgres    false    222            �           2606    20312    medico_vet fkfun_med_id 
   CONSTRAINT     V   ALTER TABLE ONLY public.medico_vet
    ADD CONSTRAINT fkfun_med_id PRIMARY KEY (cpf);
 A   ALTER TABLE ONLY public.medico_vet DROP CONSTRAINT fkfun_med_id;
       public            postgres    false    258            �           2606    20331    passeador fkfun_pas_id 
   CONSTRAINT     U   ALTER TABLE ONLY public.passeador
    ADD CONSTRAINT fkfun_pas_id PRIMARY KEY (cpf);
 @   ALTER TABLE ONLY public.passeador DROP CONSTRAINT fkfun_pas_id;
       public            postgres    false    262            �           2606    20401    seguranca fkfun_seg_id 
   CONSTRAINT     U   ALTER TABLE ONLY public.seguranca
    ADD CONSTRAINT fkfun_seg_id PRIMARY KEY (cpf);
 @   ALTER TABLE ONLY public.seguranca DROP CONSTRAINT fkfun_seg_id;
       public            postgres    false    279            {           2606    20131    acomodacao id_acomodacao_id 
   CONSTRAINT     ]   ALTER TABLE ONLY public.acomodacao
    ADD CONSTRAINT id_acomodacao_id PRIMARY KEY (numero);
 E   ALTER TABLE ONLY public.acomodacao DROP CONSTRAINT id_acomodacao_id;
       public            postgres    false    216            �           2606    20391    reserva_acomp id_acompanha 
   CONSTRAINT     r   ALTER TABLE ONLY public.reserva_acomp
    ADD CONSTRAINT id_acompanha PRIMARY KEY (acompanhante_cpf, reserva_id);
 D   ALTER TABLE ONLY public.reserva_acomp DROP CONSTRAINT id_acompanha;
       public            postgres    false    277    277            }           2606    20138    acompanhante id_acompanhante_id 
   CONSTRAINT     ^   ALTER TABLE ONLY public.acompanhante
    ADD CONSTRAINT id_acompanhante_id PRIMARY KEY (cpf);
 I   ALTER TABLE ONLY public.acompanhante DROP CONSTRAINT id_acompanhante_id;
       public            postgres    false    217                       2606    20143    alergias_pet id_alergias 
   CONSTRAINT     g   ALTER TABLE ONLY public.alergias_pet
    ADD CONSTRAINT id_alergias PRIMARY KEY (animal_id, alergias);
 B   ALTER TABLE ONLY public.alergias_pet DROP CONSTRAINT id_alergias;
       public            postgres    false    218    218            �           2606    20148    amenidades id_amenidade 
   CONSTRAINT     o   ALTER TABLE ONLY public.amenidades
    ADD CONSTRAINT id_amenidade PRIMARY KEY (numero_acomodacao, amenidade);
 A   ALTER TABLE ONLY public.amenidades DROP CONSTRAINT id_amenidade;
       public            postgres    false    219    219            �           2606    20155    animal id_animal 
   CONSTRAINT     N   ALTER TABLE ONLY public.animal
    ADD CONSTRAINT id_animal PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.animal DROP CONSTRAINT id_animal;
       public            postgres    false    221            �           2606    20165    beneficio id_beneficio 
   CONSTRAINT     l   ALTER TABLE ONLY public.beneficio
    ADD CONSTRAINT id_beneficio PRIMARY KEY (funcionario_cpf, beneficio);
 @   ALTER TABLE ONLY public.beneficio DROP CONSTRAINT id_beneficio;
       public            postgres    false    223    223            �           2606    20170    beneficio_dep id_beneficios 
   CONSTRAINT     p   ALTER TABLE ONLY public.beneficio_dep
    ADD CONSTRAINT id_beneficios PRIMARY KEY (dependente_cpf, beneficio);
 E   ALTER TABLE ONLY public.beneficio_dep DROP CONSTRAINT id_beneficios;
       public            postgres    false    224    224            �           2606    20177 $   caixa_de_entrada id_caixa_de_entrada 
   CONSTRAINT     b   ALTER TABLE ONLY public.caixa_de_entrada
    ADD CONSTRAINT id_caixa_de_entrada PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.caixa_de_entrada DROP CONSTRAINT id_caixa_de_entrada;
       public            postgres    false    226            �           2606    20186    caixa_de_saida id_caxa_de_saida 
   CONSTRAINT     ]   ALTER TABLE ONLY public.caixa_de_saida
    ADD CONSTRAINT id_caxa_de_saida PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.caixa_de_saida DROP CONSTRAINT id_caxa_de_saida;
       public            postgres    false    228            �           2606    20191    cliente id_cliente 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT id_cliente PRIMARY KEY (cpf);
 <   ALTER TABLE ONLY public.cliente DROP CONSTRAINT id_cliente;
       public            postgres    false    229            �           2606    20201    condomino id_condomino 
   CONSTRAINT     V   ALTER TABLE ONLY public.condomino
    ADD CONSTRAINT id_condomino PRIMARY KEY (cnpj);
 @   ALTER TABLE ONLY public.condomino DROP CONSTRAINT id_condomino;
       public            postgres    false    231            �           2606    20213    consulta id_consulta_id 
   CONSTRAINT     U   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT id_consulta_id PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.consulta DROP CONSTRAINT id_consulta_id;
       public            postgres    false    234            �           2606    20227    dependencias id_dependencias 
   CONSTRAINT     Z   ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT id_dependencias PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.dependencias DROP CONSTRAINT id_dependencias;
       public            postgres    false    238            �           2606    20232    dependente id_dependente_id 
   CONSTRAINT     Z   ALTER TABLE ONLY public.dependente
    ADD CONSTRAINT id_dependente_id PRIMARY KEY (cpf);
 E   ALTER TABLE ONLY public.dependente DROP CONSTRAINT id_dependente_id;
       public            postgres    false    239            �           2606    20239    entregas_robo id_entregas_robo 
   CONSTRAINT     \   ALTER TABLE ONLY public.entregas_robo
    ADD CONSTRAINT id_entregas_robo PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.entregas_robo DROP CONSTRAINT id_entregas_robo;
       public            postgres    false    241            �           2606    20249     equipamento_clin id_equipamentos 
   CONSTRAINT     t   ALTER TABLE ONLY public.equipamento_clin
    ADD CONSTRAINT id_equipamentos PRIMARY KEY (clinica_id, equipamentos);
 J   ALTER TABLE ONLY public.equipamento_clin DROP CONSTRAINT id_equipamentos;
       public            postgres    false    243    243            �           2606    20244 "   equipamento_acad id_equipamentos_1 
   CONSTRAINT     w   ALTER TABLE ONLY public.equipamento_acad
    ADD CONSTRAINT id_equipamentos_1 PRIMARY KEY (academia_id, equipamentos);
 L   ALTER TABLE ONLY public.equipamento_acad DROP CONSTRAINT id_equipamentos_1;
       public            postgres    false    242    242            �           2606    20266    estoque id_estoque 
   CONSTRAINT     R   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT id_estoque PRIMARY KEY (nome);
 <   ALTER TABLE ONLY public.estoque DROP CONSTRAINT id_estoque;
       public            postgres    false    247            �           2606    20271    funcionario id_funcionario 
   CONSTRAINT     Y   ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT id_funcionario PRIMARY KEY (cpf);
 D   ALTER TABLE ONLY public.funcionario DROP CONSTRAINT id_funcionario;
       public            postgres    false    248            �           2606    20283    hotel id_hotel_id 
   CONSTRAINT     O   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT id_hotel_id PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public.hotel DROP CONSTRAINT id_hotel_id;
       public            postgres    false    251            �           2606    20288     infraestrutura id_infraestrutura 
   CONSTRAINT     t   ALTER TABLE ONLY public.infraestrutura
    ADD CONSTRAINT id_infraestrutura PRIMARY KEY (espev_id, infraestrutura);
 J   ALTER TABLE ONLY public.infraestrutura DROP CONSTRAINT id_infraestrutura;
       public            postgres    false    252    252            �           2606    20300    item_pet id_itens_de_pet 
   CONSTRAINT     V   ALTER TABLE ONLY public.item_pet
    ADD CONSTRAINT id_itens_de_pet PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.item_pet DROP CONSTRAINT id_itens_de_pet;
       public            postgres    false    255            �           2606    20293 "   item_frigobar id_itens_do_frigobar 
   CONSTRAINT     b   ALTER TABLE ONLY public.item_frigobar
    ADD CONSTRAINT id_itens_do_frigobar PRIMARY KEY (nome);
 L   ALTER TABLE ONLY public.item_frigobar DROP CONSTRAINT id_itens_do_frigobar;
       public            postgres    false    253            �           2606    20338    passeio id_passeio_id 
   CONSTRAINT     S   ALTER TABLE ONLY public.passeio
    ADD CONSTRAINT id_passeio_id PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.passeio DROP CONSTRAINT id_passeio_id;
       public            postgres    false    264            �           2606    20326    pas_percorridos id_percorre 
   CONSTRAINT     l   ALTER TABLE ONLY public.pas_percorridos
    ADD CONSTRAINT id_percorre PRIMARY KEY (animal_id, passeio_id);
 E   ALTER TABLE ONLY public.pas_percorridos DROP CONSTRAINT id_percorre;
       public            postgres    false    261    261            �           2606    20353 $   politicas_de_uso id_politicas_de_uso 
   CONSTRAINT     �   ALTER TABLE ONLY public.politicas_de_uso
    ADD CONSTRAINT id_politicas_de_uso PRIMARY KEY (dependencia_id, politicas_de_uso);
 N   ALTER TABLE ONLY public.politicas_de_uso DROP CONSTRAINT id_politicas_de_uso;
       public            postgres    false    267    267            �           2606    20358 &   precos_praticados id_precos_praticados 
   CONSTRAINT     |   ALTER TABLE ONLY public.precos_praticados
    ADD CONSTRAINT id_precos_praticados PRIMARY KEY (numero_acomodacao, periodo);
 P   ALTER TABLE ONLY public.precos_praticados DROP CONSTRAINT id_precos_praticados;
       public            postgres    false    268    268            �           2606    20206    cons_realizada id_realiza 
   CONSTRAINT     q   ALTER TABLE ONLY public.cons_realizada
    ADD CONSTRAINT id_realiza PRIMARY KEY (consulta_id, veterinario_cpf);
 C   ALTER TABLE ONLY public.cons_realizada DROP CONSTRAINT id_realiza;
       public            postgres    false    232    232            �           2606    20365 "   receita_vet id_receita_veterinaria 
   CONSTRAINT     `   ALTER TABLE ONLY public.receita_vet
    ADD CONSTRAINT id_receita_veterinaria PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.receita_vet DROP CONSTRAINT id_receita_veterinaria;
       public            postgres    false    270            �           2606    20379    requisicao id_requisicao 
   CONSTRAINT     V   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT id_requisicao PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT id_requisicao;
       public            postgres    false    274            �           2606    20386    reserva id_reserva_id 
   CONSTRAINT     S   ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT id_reserva_id PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.reserva DROP CONSTRAINT id_reserva_id;
       public            postgres    false    276            �           2606    20408 2   servico_de_banho_e_tosa id_servico_de_banho_e_tosa 
   CONSTRAINT     p   ALTER TABLE ONLY public.servico_de_banho_e_tosa
    ADD CONSTRAINT id_servico_de_banho_e_tosa PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.servico_de_banho_e_tosa DROP CONSTRAINT id_servico_de_banho_e_tosa;
       public            postgres    false    281            �           2606    20415 #   servico_quarto id_servico_de_quarto 
   CONSTRAINT     a   ALTER TABLE ONLY public.servico_quarto
    ADD CONSTRAINT id_servico_de_quarto PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.servico_quarto DROP CONSTRAINT id_servico_de_quarto;
       public            postgres    false    283            �           2606    20420    setor id_setor 
   CONSTRAINT     Y   ALTER TABLE ONLY public.setor
    ADD CONSTRAINT id_setor PRIMARY KEY (id_hotel, setor);
 8   ALTER TABLE ONLY public.setor DROP CONSTRAINT id_setor;
       public            postgres    false    284    284                       2606    20425    tipos_uso id_tipos_de_uso 
   CONSTRAINT     k   ALTER TABLE ONLY public.tipos_uso
    ADD CONSTRAINT id_tipos_de_uso PRIMARY KEY (espev_id, tipos_de_uso);
 C   ALTER TABLE ONLY public.tipos_uso DROP CONSTRAINT id_tipos_de_uso;
       public            postgres    false    285    285            �           2606    20261 (   estacionamento id_vaga_do_estacionamento 
   CONSTRAINT     f   ALTER TABLE ONLY public.estacionamento
    ADD CONSTRAINT id_vaga_do_estacionamento PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.estacionamento DROP CONSTRAINT id_vaga_do_estacionamento;
       public            postgres    false    246            �           2606    20220 !   consumo_reserva idconsumo_reserva 
   CONSTRAINT     k   ALTER TABLE ONLY public.consumo_reserva
    ADD CONSTRAINT idconsumo_reserva PRIMARY KEY (id, id_reserva);
 K   ALTER TABLE ONLY public.consumo_reserva DROP CONSTRAINT idconsumo_reserva;
       public            postgres    false    236    236            �           2606    20307 !   item_pet_compra iditem_pet_compra 
   CONSTRAINT     k   ALTER TABLE ONLY public.item_pet_compra
    ADD CONSTRAINT iditem_pet_compra PRIMARY KEY (id, reserva_id);
 K   ALTER TABLE ONLY public.item_pet_compra DROP CONSTRAINT iditem_pet_compra;
       public            postgres    false    257    257            �           2606    20321    pagamentos_pet idpagamentos_pet 
   CONSTRAINT     i   ALTER TABLE ONLY public.pagamentos_pet
    ADD CONSTRAINT idpagamentos_pet PRIMARY KEY (id, reserva_id);
 I   ALTER TABLE ONLY public.pagamentos_pet DROP CONSTRAINT idpagamentos_pet;
       public            postgres    false    260    260            �           2606    20372 !   remocao_estoque idremocao_estoque 
   CONSTRAINT     q   ALTER TABLE ONLY public.remocao_estoque
    ADD CONSTRAINT idremocao_estoque PRIMARY KEY (id, servicoquarto_id);
 K   ALTER TABLE ONLY public.remocao_estoque DROP CONSTRAINT idremocao_estoque;
       public            postgres    false    272    272            �           2606    20314 !   medico_vet sid_medico_veterinario 
   CONSTRAINT     \   ALTER TABLE ONLY public.medico_vet
    ADD CONSTRAINT sid_medico_veterinario UNIQUE (crmv);
 K   ALTER TABLE ONLY public.medico_vet DROP CONSTRAINT sid_medico_veterinario;
       public            postgres    false    258            �           1259    20759    fkaco_res_ind    INDEX     M   CREATE INDEX fkaco_res_ind ON public.reserva_acomp USING btree (reserva_id);
 !   DROP INDEX public.fkaco_res_ind;
       public            postgres    false    277            �           1259    20736    fkaluga_para_ind    INDEX     J   CREATE INDEX fkaluga_para_ind ON public.condomino USING btree (hotel_id);
 $   DROP INDEX public.fkaluga_para_ind;
       public            postgres    false    231            �           1259    20755    fkatende_ind    INDEX     L   CREATE INDEX fkatende_ind ON public.requisicao USING btree (atendente_cpf);
     DROP INDEX public.fkatende_ind;
       public            postgres    false    274            �           1259    20748    fkcom_res_ind    INDEX     O   CREATE INDEX fkcom_res_ind ON public.item_pet_compra USING btree (reserva_id);
 !   DROP INDEX public.fkcom_res_ind;
       public            postgres    false    257            �           1259    20740    fkcon_ite_ind    INDEX     N   CREATE INDEX fkcon_ite_ind ON public.consumo_reserva USING btree (nome_item);
 !   DROP INDEX public.fkcon_ite_ind;
       public            postgres    false    236            �           1259    20744    fkcontrata_ind    INDEX     J   CREATE INDEX fkcontrata_ind ON public.funcionario USING btree (hotel_id);
 "   DROP INDEX public.fkcontrata_ind;
       public            postgres    false    248            �           1259    20754 
   fkcria_ind    INDEX     H   CREATE INDEX fkcria_ind ON public.requisicao USING btree (cliente_cpf);
    DROP INDEX public.fkcria_ind;
       public            postgres    false    274            �           1259    20760    fkcuida_do_ind    INDEX     W   CREATE INDEX fkcuida_do_ind ON public.servico_de_banho_e_tosa USING btree (animal_id);
 "   DROP INDEX public.fkcuida_do_ind;
       public            postgres    false    281            �           1259    20745    fkdep_fun_ind    INDEX     T   CREATE INDEX fkdep_fun_ind ON public.funcionario_dep USING btree (funcionario_cpf);
 !   DROP INDEX public.fkdep_fun_ind;
       public            postgres    false    249            �           1259    20741    fkdispoe_de_ind    INDEX     L   CREATE INDEX fkdispoe_de_ind ON public.dependencias USING btree (hotel_id);
 #   DROP INDEX public.fkdispoe_de_ind;
       public            postgres    false    238            �           1259    20758    fkdisponibiliza_ind    INDEX     K   CREATE INDEX fkdisponibiliza_ind ON public.reserva USING btree (hotel_id);
 '   DROP INDEX public.fkdisponibiliza_ind;
       public            postgres    false    276            �           1259    20752    fkemite_ind    INDEX     N   CREATE INDEX fkemite_ind ON public.receita_vet USING btree (veterinario_cpf);
    DROP INDEX public.fkemite_ind;
       public            postgres    false    270            �           1259    20734    fkentrada_aluguel_ind    INDEX     \   CREATE INDEX fkentrada_aluguel_ind ON public.caixa_de_entrada USING btree (condomino_cnpj);
 )   DROP INDEX public.fkentrada_aluguel_ind;
       public            postgres    false    226            �           1259    20742    fkentrega_ind    INDEX     T   CREATE INDEX fkentrega_ind ON public.entregas_robo USING btree (numero_acomodacao);
 !   DROP INDEX public.fkentrega_ind;
       public            postgres    false    241            �           1259    20738    fkexamina_ind    INDEX     G   CREATE INDEX fkexamina_ind ON public.consulta USING btree (animal_id);
 !   DROP INDEX public.fkexamina_ind;
       public            postgres    false    234            �           1259    20757 	   fkfaz_ind    INDEX     D   CREATE INDEX fkfaz_ind ON public.reserva USING btree (cliente_cpf);
    DROP INDEX public.fkfaz_ind;
       public            postgres    false    276            �           1259    20761    fkfornece_ind    INDEX     W   CREATE INDEX fkfornece_ind ON public.servico_de_banho_e_tosa USING btree (petshop_id);
 !   DROP INDEX public.fkfornece_ind;
       public            postgres    false    281            �           1259    20743    fkguarda_ind    INDEX     M   CREATE INDEX fkguarda_ind ON public.estacionamento USING btree (reserva_id);
     DROP INDEX public.fkguarda_ind;
       public            postgres    false    246            �           1259    20751 
   fkguia_ind    INDEX     G   CREATE INDEX fkguia_ind ON public.passeio USING btree (passeador_cpf);
    DROP INDEX public.fkguia_ind;
       public            postgres    false    264            �           1259    20746    fkinclui_ind    INDEX     S   CREATE INDEX fkinclui_ind ON public.item_frigobar USING btree (numero_acomodacao);
     DROP INDEX public.fkinclui_ind;
       public            postgres    false    253            �           1259    20739    fkoferece_ind    INDEX     H   CREATE INDEX fkoferece_ind ON public.consulta USING btree (clinica_id);
 !   DROP INDEX public.fkoferece_ind;
       public            postgres    false    234            �           1259    20749    fkpag_ser_ind    INDEX     Q   CREATE INDEX fkpag_ser_ind ON public.pagamentos_pet USING btree (servicopet_id);
 !   DROP INDEX public.fkpag_ser_ind;
       public            postgres    false    260            �           1259    20750    fkper_pas_ind    INDEX     O   CREATE INDEX fkper_pas_ind ON public.pas_percorridos USING btree (passeio_id);
 !   DROP INDEX public.fkper_pas_ind;
       public            postgres    false    261            �           1259    20733    fkpossui_ind    INDEX     F   CREATE INDEX fkpossui_ind ON public.animal USING btree (cliente_cpf);
     DROP INDEX public.fkpossui_ind;
       public            postgres    false    221            �           1259    20737    fkrea_med_ind    INDEX     S   CREATE INDEX fkrea_med_ind ON public.cons_realizada USING btree (veterinario_cpf);
 !   DROP INDEX public.fkrea_med_ind;
       public            postgres    false    232            �           1259    20753    fkrem_ser_ind    INDEX     U   CREATE INDEX fkrem_ser_ind ON public.remocao_estoque USING btree (servicoquarto_id);
 !   DROP INDEX public.fkrem_ser_ind;
       public            postgres    false    272            �           1259    20756    fkreserva_ind    INDEX     N   CREATE INDEX fkreserva_ind ON public.reserva USING btree (numero_acomodacao);
 !   DROP INDEX public.fkreserva_ind;
       public            postgres    false    276            �           1259    20735    fksaida_salario_ind    INDEX     Y   CREATE INDEX fksaida_salario_ind ON public.caixa_de_saida USING btree (funcionario_cpf);
 '   DROP INDEX public.fksaida_salario_ind;
       public            postgres    false    228            �           1259    20762    fksolicita_ind    INDEX     O   CREATE INDEX fksolicita_ind ON public.servico_quarto USING btree (reserva_id);
 "   DROP INDEX public.fksolicita_ind;
       public            postgres    false    283            �           1259    20747    fkvende_ind    INDEX     F   CREATE INDEX fkvende_ind ON public.item_pet USING btree (petshop_id);
    DROP INDEX public.fkvende_ind;
       public            postgres    false    255            @           2620    20767 7   item_pet_compra trigger_atualiza_valor_reserva_item_pet    TRIGGER     �   CREATE TRIGGER trigger_atualiza_valor_reserva_item_pet AFTER INSERT ON public.item_pet_compra FOR EACH ROW EXECUTE FUNCTION public.atualiza_valor_reserva_item_pet();
 P   DROP TRIGGER trigger_atualiza_valor_reserva_item_pet ON public.item_pet_compra;
       public          postgres    false    257    287            A           2620    20769 ;   pagamentos_pet trigger_atualiza_valor_reserva_pagametos_pet    TRIGGER     �   CREATE TRIGGER trigger_atualiza_valor_reserva_pagametos_pet AFTER INSERT ON public.pagamentos_pet FOR EACH ROW EXECUTE FUNCTION public.atualiza_valor_reserva_pagametos_pet();
 T   DROP TRIGGER trigger_atualiza_valor_reserva_pagametos_pet ON public.pagamentos_pet;
       public          postgres    false    288    260            ?           2620    20765 6   consumo_reserva trigger_atualiza_valor_reserva_produto    TRIGGER     �   CREATE TRIGGER trigger_atualiza_valor_reserva_produto AFTER INSERT ON public.consumo_reserva FOR EACH ROW EXECUTE FUNCTION public.atualiza_valor_reserva_produto();
 O   DROP TRIGGER trigger_atualiza_valor_reserva_produto ON public.consumo_reserva;
       public          postgres    false    286    236            B           2620    20771 0   remocao_estoque trigger_reduz_quantidade_estoque    TRIGGER     �   CREATE TRIGGER trigger_reduz_quantidade_estoque AFTER INSERT ON public.remocao_estoque FOR EACH ROW EXECUTE FUNCTION public.reduz_quantidade_estoque();
 I   DROP TRIGGER trigger_reduz_quantidade_estoque ON public.remocao_estoque;
       public          postgres    false    272    289                       2606    20532    equipamento_acad fkaca_equ    FK CONSTRAINT     �   ALTER TABLE ONLY public.equipamento_acad
    ADD CONSTRAINT fkaca_equ FOREIGN KEY (academia_id) REFERENCES public.academia(dependencia_id);
 D   ALTER TABLE ONLY public.equipamento_acad DROP CONSTRAINT fkaca_equ;
       public          postgres    false    242    4983    215            6           2606    20693    reserva_acomp fkaco_aco    FK CONSTRAINT     �   ALTER TABLE ONLY public.reserva_acomp
    ADD CONSTRAINT fkaco_aco FOREIGN KEY (acompanhante_cpf) REFERENCES public.acompanhante(cpf);
 A   ALTER TABLE ONLY public.reserva_acomp DROP CONSTRAINT fkaco_aco;
       public          postgres    false    217    4989    277                       2606    20441    amenidades fkaco_ame    FK CONSTRAINT     �   ALTER TABLE ONLY public.amenidades
    ADD CONSTRAINT fkaco_ame FOREIGN KEY (numero_acomodacao) REFERENCES public.acomodacao(numero);
 >   ALTER TABLE ONLY public.amenidades DROP CONSTRAINT fkaco_ame;
       public          postgres    false    219    4987    216            7           2606    20688    reserva_acomp fkaco_res_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.reserva_acomp
    ADD CONSTRAINT fkaco_res_fk FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 D   ALTER TABLE ONLY public.reserva_acomp DROP CONSTRAINT fkaco_res_fk;
       public          postgres    false    277    276    5103                       2606    20486    condomino fkaluga_para_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.condomino
    ADD CONSTRAINT fkaluga_para_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);
 C   ALTER TABLE ONLY public.condomino DROP CONSTRAINT fkaluga_para_fk;
       public          postgres    false    231    5054    251                       2606    20436    alergias_pet fkani_ale    FK CONSTRAINT     x   ALTER TABLE ONLY public.alergias_pet
    ADD CONSTRAINT fkani_ale FOREIGN KEY (animal_id) REFERENCES public.animal(id);
 @   ALTER TABLE ONLY public.alergias_pet DROP CONSTRAINT fkani_ale;
       public          postgres    false    221    4996    218            1           2606    20668    requisicao fkatende_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT fkatende_fk FOREIGN KEY (atendente_cpf) REFERENCES public.atendente(cpf);
 @   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT fkatende_fk;
       public          postgres    false    222    4998    274                       2606    20537    equipamento_clin fkcli_equ    FK CONSTRAINT     �   ALTER TABLE ONLY public.equipamento_clin
    ADD CONSTRAINT fkcli_equ FOREIGN KEY (clinica_id) REFERENCES public.clinica_vet(dependencia_id);
 D   ALTER TABLE ONLY public.equipamento_clin DROP CONSTRAINT fkcli_equ;
       public          postgres    false    230    243    5014            !           2606    20588    item_pet_compra fkcom_ite    FK CONSTRAINT     {   ALTER TABLE ONLY public.item_pet_compra
    ADD CONSTRAINT fkcom_ite FOREIGN KEY (item_id) REFERENCES public.item_pet(id);
 C   ALTER TABLE ONLY public.item_pet_compra DROP CONSTRAINT fkcom_ite;
       public          postgres    false    5062    255    257            "           2606    20583    item_pet_compra fkcom_res_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.item_pet_compra
    ADD CONSTRAINT fkcom_res_fk FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 F   ALTER TABLE ONLY public.item_pet_compra DROP CONSTRAINT fkcom_res_fk;
       public          postgres    false    276    257    5103                       2606    20516    consumo_reserva fkcon_ite_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.consumo_reserva
    ADD CONSTRAINT fkcon_ite_fk FOREIGN KEY (nome_item) REFERENCES public.item_frigobar(nome);
 F   ALTER TABLE ONLY public.consumo_reserva DROP CONSTRAINT fkcon_ite_fk;
       public          postgres    false    236    253    5059                       2606    20511    consumo_reserva fkcon_res    FK CONSTRAINT     }   ALTER TABLE ONLY public.consumo_reserva
    ADD CONSTRAINT fkcon_res FOREIGN KEY (id_reserva) REFERENCES public.reserva(id);
 C   ALTER TABLE ONLY public.consumo_reserva DROP CONSTRAINT fkcon_res;
       public          postgres    false    276    5103    236                       2606    20553    funcionario fkcontrata_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fkcontrata_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);
 C   ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fkcontrata_fk;
       public          postgres    false    251    5054    248            2           2606    20663    requisicao fkcria_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.requisicao
    ADD CONSTRAINT fkcria_fk FOREIGN KEY (cliente_cpf) REFERENCES public.cliente(cpf);
 >   ALTER TABLE ONLY public.requisicao DROP CONSTRAINT fkcria_fk;
       public          postgres    false    229    5012    274            :           2606    20708 %   servico_de_banho_e_tosa fkcuida_do_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.servico_de_banho_e_tosa
    ADD CONSTRAINT fkcuida_do_fk FOREIGN KEY (animal_id) REFERENCES public.animal(id);
 O   ALTER TABLE ONLY public.servico_de_banho_e_tosa DROP CONSTRAINT fkcuida_do_fk;
       public          postgres    false    4996    281    221            -           2606    20643    precos_praticados fkcusta    FK CONSTRAINT     �   ALTER TABLE ONLY public.precos_praticados
    ADD CONSTRAINT fkcusta FOREIGN KEY (numero_acomodacao) REFERENCES public.acomodacao(numero);
 C   ALTER TABLE ONLY public.precos_praticados DROP CONSTRAINT fkcusta;
       public          postgres    false    4987    268    216                       2606    20426    academia fkdep_aca_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.academia
    ADD CONSTRAINT fkdep_aca_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 ?   ALTER TABLE ONLY public.academia DROP CONSTRAINT fkdep_aca_fk;
       public          postgres    false    238    215    5030                       2606    20431    acomodacao fkdep_aco_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.acomodacao
    ADD CONSTRAINT fkdep_aco_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 A   ALTER TABLE ONLY public.acomodacao DROP CONSTRAINT fkdep_aco_fk;
       public          postgres    false    216    5030    238            	           2606    20461    beneficio_dep fkdep_ben    FK CONSTRAINT     �   ALTER TABLE ONLY public.beneficio_dep
    ADD CONSTRAINT fkdep_ben FOREIGN KEY (dependente_cpf) REFERENCES public.funcionario_dep(dependente_cpf);
 A   ALTER TABLE ONLY public.beneficio_dep DROP CONSTRAINT fkdep_ben;
       public          postgres    false    224    5051    249                       2606    20481    clinica_vet fkdep_cli_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.clinica_vet
    ADD CONSTRAINT fkdep_cli_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 B   ALTER TABLE ONLY public.clinica_vet DROP CONSTRAINT fkdep_cli_fk;
       public          postgres    false    5030    230    238                       2606    20563    funcionario_dep fkdep_dep_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.funcionario_dep
    ADD CONSTRAINT fkdep_dep_fk FOREIGN KEY (dependente_cpf) REFERENCES public.dependente(cpf);
 F   ALTER TABLE ONLY public.funcionario_dep DROP CONSTRAINT fkdep_dep_fk;
       public          postgres    false    5032    249    239                       2606    20542    espaco_de_evento fkdep_esp_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.espaco_de_evento
    ADD CONSTRAINT fkdep_esp_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 G   ALTER TABLE ONLY public.espaco_de_evento DROP CONSTRAINT fkdep_esp_fk;
       public          postgres    false    244    5030    238                       2606    20558    funcionario_dep fkdep_fun_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.funcionario_dep
    ADD CONSTRAINT fkdep_fun_fk FOREIGN KEY (funcionario_cpf) REFERENCES public.funcionario(cpf);
 F   ALTER TABLE ONLY public.funcionario_dep DROP CONSTRAINT fkdep_fun_fk;
       public          postgres    false    249    248    5049            *           2606    20628    pet_shop fkdep_pet_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.pet_shop
    ADD CONSTRAINT fkdep_pet_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 ?   ALTER TABLE ONLY public.pet_shop DROP CONSTRAINT fkdep_pet_fk;
       public          postgres    false    265    5030    238            +           2606    20633    piscina fkdep_pis_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT fkdep_pis_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 >   ALTER TABLE ONLY public.piscina DROP CONSTRAINT fkdep_pis_fk;
       public          postgres    false    266    5030    238            ,           2606    20638    politicas_de_uso fkdep_pol    FK CONSTRAINT     �   ALTER TABLE ONLY public.politicas_de_uso
    ADD CONSTRAINT fkdep_pol FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 D   ALTER TABLE ONLY public.politicas_de_uso DROP CONSTRAINT fkdep_pol;
       public          postgres    false    5030    238    267            8           2606    20698    restaurante fkdep_res_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.restaurante
    ADD CONSTRAINT fkdep_res_fk FOREIGN KEY (dependencia_id) REFERENCES public.dependencias(id);
 B   ALTER TABLE ONLY public.restaurante DROP CONSTRAINT fkdep_res_fk;
       public          postgres    false    278    238    5030                       2606    20522    dependencias fkdispoe_de_fk    FK CONSTRAINT     {   ALTER TABLE ONLY public.dependencias
    ADD CONSTRAINT fkdispoe_de_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);
 E   ALTER TABLE ONLY public.dependencias DROP CONSTRAINT fkdispoe_de_fk;
       public          postgres    false    238    251    5054            3           2606    20683    reserva fkdisponibiliza_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT fkdisponibiliza_fk FOREIGN KEY (hotel_id) REFERENCES public.hotel(id);
 D   ALTER TABLE ONLY public.reserva DROP CONSTRAINT fkdisponibiliza_fk;
       public          postgres    false    251    276    5054            .           2606    20648    receita_vet fkemite_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.receita_vet
    ADD CONSTRAINT fkemite_fk FOREIGN KEY (veterinario_cpf) REFERENCES public.medico_vet(cpf);
 @   ALTER TABLE ONLY public.receita_vet DROP CONSTRAINT fkemite_fk;
       public          postgres    false    258    270    5067            
           2606    20471 %   caixa_de_entrada fkentrada_aluguel_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.caixa_de_entrada
    ADD CONSTRAINT fkentrada_aluguel_fk FOREIGN KEY (condomino_cnpj) REFERENCES public.condomino(cnpj);
 O   ALTER TABLE ONLY public.caixa_de_entrada DROP CONSTRAINT fkentrada_aluguel_fk;
       public          postgres    false    5017    226    231                       2606    20466 %   caixa_de_entrada fkentrada_reserva_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.caixa_de_entrada
    ADD CONSTRAINT fkentrada_reserva_fk FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 O   ALTER TABLE ONLY public.caixa_de_entrada DROP CONSTRAINT fkentrada_reserva_fk;
       public          postgres    false    5103    276    226                       2606    20527    entregas_robo fkentrega_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.entregas_robo
    ADD CONSTRAINT fkentrega_fk FOREIGN KEY (numero_acomodacao) REFERENCES public.acomodacao(numero);
 D   ALTER TABLE ONLY public.entregas_robo DROP CONSTRAINT fkentrega_fk;
       public          postgres    false    216    241    4987                       2606    20568    infraestrutura fkesp_inf    FK CONSTRAINT     �   ALTER TABLE ONLY public.infraestrutura
    ADD CONSTRAINT fkesp_inf FOREIGN KEY (espev_id) REFERENCES public.espaco_de_evento(dependencia_id);
 B   ALTER TABLE ONLY public.infraestrutura DROP CONSTRAINT fkesp_inf;
       public          postgres    false    244    5041    252            >           2606    20728    tipos_uso fkesp_tip    FK CONSTRAINT     �   ALTER TABLE ONLY public.tipos_uso
    ADD CONSTRAINT fkesp_tip FOREIGN KEY (espev_id) REFERENCES public.espaco_de_evento(dependencia_id);
 =   ALTER TABLE ONLY public.tipos_uso DROP CONSTRAINT fkesp_tip;
       public          postgres    false    285    5041    244                       2606    20501    consulta fkexamina_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkexamina_fk FOREIGN KEY (animal_id) REFERENCES public.animal(id);
 ?   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkexamina_fk;
       public          postgres    false    221    4996    234            4           2606    20678    reserva fkfaz_fk    FK CONSTRAINT     v   ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT fkfaz_fk FOREIGN KEY (cliente_cpf) REFERENCES public.cliente(cpf);
 :   ALTER TABLE ONLY public.reserva DROP CONSTRAINT fkfaz_fk;
       public          postgres    false    276    5012    229            ;           2606    20713 $   servico_de_banho_e_tosa fkfornece_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.servico_de_banho_e_tosa
    ADD CONSTRAINT fkfornece_fk FOREIGN KEY (petshop_id) REFERENCES public.pet_shop(dependencia_id);
 N   ALTER TABLE ONLY public.servico_de_banho_e_tosa DROP CONSTRAINT fkfornece_fk;
       public          postgres    false    5082    265    281                       2606    20451    atendente fkfun_ate_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.atendente
    ADD CONSTRAINT fkfun_ate_fk FOREIGN KEY (cpf) REFERENCES public.funcionario(cpf);
 @   ALTER TABLE ONLY public.atendente DROP CONSTRAINT fkfun_ate_fk;
       public          postgres    false    248    222    5049                       2606    20456    beneficio fkfun_ben    FK CONSTRAINT     �   ALTER TABLE ONLY public.beneficio
    ADD CONSTRAINT fkfun_ben FOREIGN KEY (funcionario_cpf) REFERENCES public.funcionario(cpf);
 =   ALTER TABLE ONLY public.beneficio DROP CONSTRAINT fkfun_ben;
       public          postgres    false    223    248    5049            #           2606    20593    medico_vet fkfun_med_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.medico_vet
    ADD CONSTRAINT fkfun_med_fk FOREIGN KEY (cpf) REFERENCES public.funcionario(cpf);
 A   ALTER TABLE ONLY public.medico_vet DROP CONSTRAINT fkfun_med_fk;
       public          postgres    false    258    5049    248            (           2606    20618    passeador fkfun_pas_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.passeador
    ADD CONSTRAINT fkfun_pas_fk FOREIGN KEY (cpf) REFERENCES public.funcionario(cpf);
 @   ALTER TABLE ONLY public.passeador DROP CONSTRAINT fkfun_pas_fk;
       public          postgres    false    5049    248    262            9           2606    20703    seguranca fkfun_seg_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.seguranca
    ADD CONSTRAINT fkfun_seg_fk FOREIGN KEY (cpf) REFERENCES public.funcionario(cpf);
 @   ALTER TABLE ONLY public.seguranca DROP CONSTRAINT fkfun_seg_fk;
       public          postgres    false    279    248    5049                       2606    20547    estacionamento fkguarda_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.estacionamento
    ADD CONSTRAINT fkguarda_fk FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 D   ALTER TABLE ONLY public.estacionamento DROP CONSTRAINT fkguarda_fk;
       public          postgres    false    5103    276    246            )           2606    20623    passeio fkguia_fk    FK CONSTRAINT     {   ALTER TABLE ONLY public.passeio
    ADD CONSTRAINT fkguia_fk FOREIGN KEY (passeador_cpf) REFERENCES public.passeador(cpf);
 ;   ALTER TABLE ONLY public.passeio DROP CONSTRAINT fkguia_fk;
       public          postgres    false    262    264    5077            =           2606    20723    setor fkhot_set    FK CONSTRAINT     o   ALTER TABLE ONLY public.setor
    ADD CONSTRAINT fkhot_set FOREIGN KEY (id_hotel) REFERENCES public.hotel(id);
 9   ALTER TABLE ONLY public.setor DROP CONSTRAINT fkhot_set;
       public          postgres    false    251    284    5054                       2606    20573    item_frigobar fkinclui_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.item_frigobar
    ADD CONSTRAINT fkinclui_fk FOREIGN KEY (numero_acomodacao) REFERENCES public.acomodacao(numero);
 C   ALTER TABLE ONLY public.item_frigobar DROP CONSTRAINT fkinclui_fk;
       public          postgres    false    253    4987    216                       2606    20506    consulta fkoferece_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT fkoferece_fk FOREIGN KEY (clinica_id) REFERENCES public.clinica_vet(dependencia_id);
 ?   ALTER TABLE ONLY public.consulta DROP CONSTRAINT fkoferece_fk;
       public          postgres    false    230    234    5014            $           2606    20603    pagamentos_pet fkpag_res    FK CONSTRAINT     |   ALTER TABLE ONLY public.pagamentos_pet
    ADD CONSTRAINT fkpag_res FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 B   ALTER TABLE ONLY public.pagamentos_pet DROP CONSTRAINT fkpag_res;
       public          postgres    false    5103    276    260            %           2606    20598    pagamentos_pet fkpag_ser_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagamentos_pet
    ADD CONSTRAINT fkpag_ser_fk FOREIGN KEY (servicopet_id) REFERENCES public.servico_de_banho_e_tosa(id);
 E   ALTER TABLE ONLY public.pagamentos_pet DROP CONSTRAINT fkpag_ser_fk;
       public          postgres    false    5114    260    281            &           2606    20613    pas_percorridos fkper_ani    FK CONSTRAINT     {   ALTER TABLE ONLY public.pas_percorridos
    ADD CONSTRAINT fkper_ani FOREIGN KEY (animal_id) REFERENCES public.animal(id);
 C   ALTER TABLE ONLY public.pas_percorridos DROP CONSTRAINT fkper_ani;
       public          postgres    false    221    4996    261            '           2606    20608    pas_percorridos fkper_pas_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.pas_percorridos
    ADD CONSTRAINT fkper_pas_fk FOREIGN KEY (passeio_id) REFERENCES public.passeio(id);
 F   ALTER TABLE ONLY public.pas_percorridos DROP CONSTRAINT fkper_pas_fk;
       public          postgres    false    5080    261    264                       2606    20446    animal fkpossui_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.animal
    ADD CONSTRAINT fkpossui_fk FOREIGN KEY (cliente_cpf) REFERENCES public.cliente(cpf);
 <   ALTER TABLE ONLY public.animal DROP CONSTRAINT fkpossui_fk;
       public          postgres    false    221    229    5012                       2606    20491    cons_realizada fkrea_con    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cons_realizada
    ADD CONSTRAINT fkrea_con FOREIGN KEY (consulta_id) REFERENCES public.consulta(id);
 B   ALTER TABLE ONLY public.cons_realizada DROP CONSTRAINT fkrea_con;
       public          postgres    false    234    5024    232                       2606    20496    cons_realizada fkrea_med_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cons_realizada
    ADD CONSTRAINT fkrea_med_fk FOREIGN KEY (veterinario_cpf) REFERENCES public.medico_vet(cpf);
 E   ALTER TABLE ONLY public.cons_realizada DROP CONSTRAINT fkrea_med_fk;
       public          postgres    false    232    5067    258            /           2606    20658    remocao_estoque fkrem_est    FK CONSTRAINT     ~   ALTER TABLE ONLY public.remocao_estoque
    ADD CONSTRAINT fkrem_est FOREIGN KEY (item_nome) REFERENCES public.estoque(nome);
 C   ALTER TABLE ONLY public.remocao_estoque DROP CONSTRAINT fkrem_est;
       public          postgres    false    247    272    5046            0           2606    20653    remocao_estoque fkrem_ser_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.remocao_estoque
    ADD CONSTRAINT fkrem_ser_fk FOREIGN KEY (servicoquarto_id) REFERENCES public.servico_quarto(id);
 F   ALTER TABLE ONLY public.remocao_estoque DROP CONSTRAINT fkrem_ser_fk;
       public          postgres    false    5117    272    283            5           2606    20673    reserva fkreserva_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT fkreserva_fk FOREIGN KEY (numero_acomodacao) REFERENCES public.acomodacao(numero);
 >   ALTER TABLE ONLY public.reserva DROP CONSTRAINT fkreserva_fk;
       public          postgres    false    276    4987    216                       2606    20476 !   caixa_de_saida fksaida_salario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.caixa_de_saida
    ADD CONSTRAINT fksaida_salario_fk FOREIGN KEY (funcionario_cpf) REFERENCES public.funcionario(cpf);
 K   ALTER TABLE ONLY public.caixa_de_saida DROP CONSTRAINT fksaida_salario_fk;
       public          postgres    false    5049    228    248            <           2606    20718    servico_quarto fksolicita_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.servico_quarto
    ADD CONSTRAINT fksolicita_fk FOREIGN KEY (reserva_id) REFERENCES public.reserva(id);
 F   ALTER TABLE ONLY public.servico_quarto DROP CONSTRAINT fksolicita_fk;
       public          postgres    false    276    283    5103                        2606    20578    item_pet fkvende_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.item_pet
    ADD CONSTRAINT fkvende_fk FOREIGN KEY (petshop_id) REFERENCES public.pet_shop(dependencia_id);
 =   ALTER TABLE ONLY public.item_pet DROP CONSTRAINT fkvende_fk;
       public          postgres    false    5082    265    255            �      x���26�26�26�26����� ��      �      x�m��
�0���W��M*M���C�^��Ѕ�i��["�s�1>�w� ��6m�[2��i�Ql��k���$��i��ch��QgY
O�?��ɉ;K�ib�f�ϗ�*Z�����K�D|H2�      �   �   x�M�K�0 ׯ��	L�����\�yԢMJ�0���J���ѕE�E���'oCr9&8�1��2LI�h��JA������:����*Y��B�p,��Kp�ok��ߴaM����R�%����S.#��n`�(#E���p9����RZ�[�c���8�      �   )   x�3���w�2�tN��/-J�2�tLJ��H�2K��qqq �gQ      �   �   x�m�A
�0��9�'&u����[7�F�F���`ij����3��yEO#z0"vt�T:��N��֍�f���H�Ѩ�o�2*#ٿm~��Z�T����k07dTF�1Zn�f�x�� F�]C      �   }   x�E̽
�0������&͝�tAp	i����|{������p�e��Om�w�[;1�">&
��:�ϛ�1�|Z�a�u!	[�1T=�^ױ~��H�{���e9�m�E�G1�:�Ď'A      �   O   x��I@�?bR�sx�I�$��B����sx}r^�	�h�	�;E�%J�pTt�y����!}Fz��3j|? ~�	*      �   [  x�U�=NA�kr�� ���"Q�D��?)���xg��x�g?�=�SP�#����C0� :�q���uܤ���<̨�p�irub��SCf2c5
�� ����e��Y�a� E��%B`�P�M���|���F(cyX�h3�yqOȃٷKǢ�HS�Ns>�I�eH��5R)w6U�-wp�{Y��mJiLp�4(��_f��Jέ�M3DKC;��-=��Y&�Y�pVd�"�Y��zE�+�^����Wd�"�Y��zE�+�^��������|.�kmE{��|���m�Fz�-��������>���gP����������[�+���2,��Z�?��%�P      �   P   x�Uʻ	�P��L����������h���i'��ӧ�>�wގ�H�����5R=�ٴ�
��@��0Z,�|_��  s      �   �   x�]�;��@D�S��t���CGb3��M�"�!�e)��=Ɗ6�W�
�e��t���G�=ã3�*���esB���յ��i>8؋��f���`()�MB����i���\�4̌��f�0���"A�V˽;͏mףa��ܔ�I!�
��D��oS��>>�?�IBL�~��s/��4�      �   �   x�5�1�0��+��۳��[���J(,P,9��c����hF:�w�vW�%����0��	�	)��û��\^�;	��9r'��D��n��cm�e�v����hR
}>�^�N�-u�����9O�Crt=b�3+����=�>�{��8~)BH!�F��uc����3t      �   C  x�U��j�0����)�*3���1	dK�BiKO�Ȏb7�ބ��wL.1���H��H)>f�_��=�ah3|��x�����H�␋��u]�غU���P��Aft�L9�
r��G�vY���e�����$�ޱ"I&������<�m��k}?Ev�GEd4,�S�Mpwi�d�����?���e(�(��2���׹ڟ�v��29$ �

�'�����d��2�[=䗰3�@A�E�棦��~/�����ط�����@Ld8JT&� <_?F�u�w.��{�Ʉ!�t�u��ai����e������/Ƙ��}��      �   :   x�34�t.�LIL�p�26D�p��(�䗥r��s��)��fs��qqq �c�      �   �   x�]��
�0Eg�+�E�[��S��]D�K��!���[�w8�CD��R����n*ݰ��щ4�=rB�
Cy�m���=��F꼲D��%�Z}ۘ.�<�Z{���EL�{Q�zݻ�9�T�_20�&��Č�%�@�����s_�01      �   )   x�32645711043�4�25345�0�02��4����� g��      �   ;   x�3�t�H�M�4202�54"NNC.#N��Ԣ�Լ��D�����1���!W� ��G      �   E   x�3����+.I-��2�JMq*���44�2�tL/MTHVpO,�44�2�9�L9���j,�b���� B��      �   �  x���In�0E��)r$eYr�Pt�m6�E��"�4[c&  O_�$���~�������3����{��	��P��;ۯ�É���`L�%υ�>�~�J`����Мa��s��b�*��HKw��A--�ݵ��$�7����/7m�ƹ`[]<W^�������~ж��5�G�!L(�m�8;sy�曶�\�F|ܸ��t�s]�щkO���������ΫwOi�IX�z�c��<��z<�D���u�v۹-��fYqM���p�O������>�N�3�m;���3q�:�a�5����]�F����e�՘6��q��%W]l[V�,�-K9
1'�7�C1�9�M��T��U��8o����ŗ����W�u�Ġ3u��^�L�)hG�H7!�hqMuF%:�Ue�Q�mM��� d
��k՞Ν��x�8��w�����q����������
�W      �   �   x�M�;�0k�>��gנ�hHK��(���7�� 
�>�M�C� �Wy-y�j��)�����%�F��;@���3�~�2U�O�������Yu��T66��7�L��G$k3r�� q��&���y�j�R7>��OZ��@6�      �   �   x�M��j�0���~K�hr��J{�E̢��-p�<3ڴ�M��GB�j���]f��\8ɠ�P$Ś������ܦ���Yr��>�T�\���&�9j�K�-)#�[Ƒ%���GI�>�\/M���\ǻ��!l6ί�]o�]�*�T�K��ޢD�V�
�I�9����e3��b���H�u@iU�/M�\cP9      �   �   x�m�1�0��9EN���$$z�,���҄�cM����'�k���#Ϧm���.H��n��÷�!���e{�O��s��\�7��1��G9N��h��E�Zh�l˱�eQ����!�y(y�xPy�xL<fK+U5�O�����'�'��l�10{�u      �   �   x�U̱
�0�9��~A�t_Ю�رKH5�:�J��$dMwp��q��j{I����ӑ�%͓�Q�.��m��s�j5�鼽��yU+���w����ps���Gܑ�;�	�As����AＯD��n�      �      x�3�22�22�2��2������ ��      �   }   x�3��O.-HLI�t,R��,+J�t�4426�
v�05�T�44�2��r�OJ-*I��(
t354*2�2�4*�* 40��d�!��*w�*?�@gCs3�*.KLU.U�>�Q� �b���� :0�      �   �   x��1�0Eg�� (	*#�P����BU�XJ��8=I�o���'qtp.�����7��h���.Թn�=�6���Vp��`?�ڥ�¹P�H0��X����	���M��%�O�*�+\6	`a�I|T~)�'�o��yD�?
�*�      �   �  x�eU�n�8]K_�]W6���2I�ff�t��c1	Y
$����Џ�T�?�ν�A�5�T]o�Ⱦ��G�n¸ڴ��+�/�ĩ.��+���L�M��K��{�)��n�tq�.�:u�~�݂�����w���k!��ϜS���!��~��)����R���
/�q�2�U��M?�i�O��C���8K��Є��Ə8w\����c�C����@{����)��J�ӎ������.���%��@fA���~��{1��#+���4�M���
@i������֧@`�9#�!ϫ��4N)t���o�X 0����Pގ���R`��&F�w�S��
��n;�,��3���9c���m�B��
��5�|�D_��^�D�����7#�΁]ط<]_�P�L�������s�9��ݴ1o&z}-�cw�!U���k��8�Q�H�I�4.�zzڲ��{KmqB��B��y���dk��$Uw��1���klKR9�:n۩��� �"L�[�6�-]��!}UK��I/���8{H��q�+�O��c�`V�Z���%�W` ��t9!���i@R�)u�mS9���suD�d��$>S��2=&�G���:&^x��F��*l�iͮ�C�c�E���a��%^t�$������E�v�ݩ��vZfZrM�2���Dƪ�<Ć��2,�cg���NK�d��jMp�5^k�+mܲ�ش�k
2;�Z�E�A)���Dk��ـ�7����[x)v�rU�Z*�q2t�m3b�4�ġ��*"Az���~�?e%���ڴ�+L�q(��-�T9�z�S�d1����}Z�S��s[�b��dR�X4ϼ2N��֒�>n���8�g׆��#z�h�ye��`��U�i�ܷ#����3��e�)ZҪ��[�k��']��gzb�=p��."�r����V\�N�*�?�"���sF\�e��}p��,�-�o��˺��d%�      �   Y   x��I� C�3�����/����<���9tH"��2���c��u� ��e[$nB���	*7�������n�Dy�^X����^U��E      �   �   x�5�MN�0�דS�b�q�$˂� R���d3ţbɲ��l���b8�Y���u�+�_���o�"y��v����zJ8q$�@k-�(�R]�!b�z�C\ȡ!<:�GK0���>deMd�`)�8�b�l��� �����l�����>sT��P[�nj��ŀ��Dv�O.��4�/��� M�
5H!�R��r����v�JgZ]�C�
�qR��ƽ���� %�Vh      �   �   x���1�0E��>@�С�:r��k$Ki%i��Az1R!11�X��ϣ���i��T�g Ƃ��o(Ėfe����0�i�Ԍ`Gu+h��hA���eD�@]�ʺT�ͪ�����f�/����C<$�S�ҭ���O��7��MZ      �   �   x�]���0���S��E)�8��"�K��!4�imL|z��۾���N�U��j%���8�L��� _%�GPY���C���:O�{�|��
Z�����)�@FEQ��īн���b�*Jv�[J��X�_�:	�A3X	�+ۍʼ��e��=c�߶��/��;�      �   �   x�E�K�0�χA��!ٶ�lBUD�B�~8?Ea���+��zd�1�CHpY�k�� �E_�qZ2�C�?B����C�O`�ВG���8l��H�Qh��4_��hx��
�D�;��U8�]�#U�G�5�C�} Li.z      �   ,   x�3�4�44�2�4Q&���F\��朆�\f�F��\1z\\\ fT      �   p   x���@�^� �(����:r�dg:=v��iۉ��`V]��֕��0��i���3k�s�
kE���v��h=��W�TO_r��2ԮY؛a\Hcb�k�I�������"      �   /   x���  �wR������_>bkD)���ϯL�T����          /   x�ƹ  ������������&��i�R�f����;�|��         N   x����@���H��zI�u��H+�HS�� S�3ݕH�":����(��s5c&u�Y���x����V�{���         �   x�u�KNC1E��*�� �xLQ�IT*1h��e��!R���\������.=�/�c�O $��ff�0�F�P6�C?.�Qj������[O�?�d
`��'�-�̴�>���SU�Q�YE���D+���u=>8˝W���m����ح��ܟ��U�h1�f8�s����ZFk�1:�k�2�eܪ⮆�D�ѻe�         R   x�3��M,�I�KU(H-��t�OW(��/O-�22�tJ���WHIT�)�)�22�t,JMT �42�R
9�e�\F�v� H�i         0   x�3�447�2�443�2��4�0�2��445�22 Jp�y1z\\\ ���         :  x���Mn� ��p
NP�W/���.���f�G	Qܨʅz�^�C-�V̂�����1~��38qt{�ct��7�ِvC���F�f�:��5���f��,��X��� ���X��s%�[�#F��`d!�L�Z�j5�r�f5K��#����	�.
��M�<����=�̈́i�`�q�79�پls2��h�v���h3B�W-�R{Ep��G�.v�B�Y�,��雝�B� i�1U����)��#ƹ��ʞ���m�fg47�Z���I��؅4K#�B5�P�
�}�#{�t���ǩ�X����s��v{O         o   x�U�1�0��y�`JV,��K�,���(l'��;��9l﷡����lVB*��G�(f>�����R �6
����Yq���Z�;m<�)c�{�\&�n��/�"�B[,;      	   �   x�]�A
1��us
/PIҴM�z���"�(H�2x~�PF��?��s/��>#���&�Ð��fU��N}��f1.��bPaw]�V3yR7��,-#P��A�	'q�o�ܥ�V{i{��}]Ĉd6�3܎ ��0�         B   x�3����+.I-�4�2�JMq*���4�2�tL/MTHVpO,�4�2s9��L9���s8M�b���� (         �  x�e�M��0���)� ���x�Fh@�@#���j�i%��N��9'�Q��i���G~�߳�1�8�BKm[�Ze�ҊO��5�����Ǻ�B-p.t��p�g�1�rJx�[1�J0F�3%�LPqF❔C:�,Va���zo�AX��n0�����dZ�[ٽ"�r�c�q��$� ���(��V��-��e^dX( ����L��ǆe%�(��P�1�PNi7x�����X�:#s����r�<QY�����H�Q�N���~3PNǭ�9���!`��Zh�׾�R���t�k�9"�X�������(���k�h��*.�����Ƹ.���m�����:gl����F����U�n�F~ٓ�<�?O����)l���ׂ�N�ܳ'�i�R}������k��7M��c��         �   x�u��m�0гTEp�៽�9�,��XX#�I��0�ذ�ĺQl��27�]-?#����#Q3u�	?)x�>#��;*T�5�}�����J�em�g�+e���RrPY�>Ra�T���Z��2���,+}a�ˬ\D ��Yk��G�u(���j�x��QӺPز���]zӾ^��4��������\Q�!��[��������G�^�||�9�Ӫe�         A   x����0�7���a��?G��j�Kvn�BL��Lo�Rn�����XA�[�\sO��} |C�         E   x�3�t/��I-)��,�2�tN,J�M�q�9}����9Ӹ�9�K�3+��f�N�I�@�=... ���         S   x�5˫�0P�~�n�><��,ab����A�95U- R�k>��9#��Q�٩1̤����*�\�~���9�b�9"z��O         g   x�Uͱ�0D��<�N�fJ�HTP����.ah���2��T�#`������v�r�2*9�W���
B�0��Je-pA�%*��`���(���	��y         [   x�3����+.I-R�NCSNNK.#ΠԔ�ҜT	C.cN���D�4�4�44�2�H$+�'C$L@F\�����9�:L��Ђ+F��� ��$         ?   x�34�tK����L,�24�tL)�)���3S��-8�J�3�R��l�JK�� �5!F��� �[�         a   x�3�tK-.I���/�wJ�KM�LN�+I�22��8''����9�ʂK�RJ��J��RK��,8�4�;e��Zr�5�CrLN�-����� �(�     