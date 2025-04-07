-- Tabella utenti
CREATE TABLE utenti (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nome VARCHAR(100),
    cognome VARCHAR(100),
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_aggiornamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabella abbonamenti
CREATE TABLE abbonamenti (
    id SERIAL PRIMARY KEY,
    utente_id INT REFERENCES utenti(id) ON DELETE CASCADE,  -- Riferimento all'utente
    nome_servizio VARCHAR(255) NOT NULL,  -- Nome del servizio (es. Netflix, Spotify)
    prezzo DECIMAL(10, 2),  -- Prezzo dell'abbonamento
    data_inizio DATE NOT NULL,  -- Data di inizio
    data_fine DATE,  -- Data di fine (opzionale)
    ricorrente BOOLEAN DEFAULT TRUE,  -- Se è un abbonamento ricorrente
    stato VARCHAR(50) DEFAULT 'attivo',  -- Stato dell'abbonamento (attivo, scaduto, ecc.)
    data_promemoria DATE,  -- Data del promemoria
    pubblico BOOLEAN DEFAULT FALSE,  -- Se l'abbonamento è pubblico o privato
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_aggiornamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabella abbonamenti condivisi
CREATE TABLE abbonamenti_condivisi (
    abbonamento_id INT REFERENCES abbonamenti(id) ON DELETE CASCADE,  -- Riferimento all'abbonamento
    utente_id INT REFERENCES utenti(id) ON DELETE CASCADE,  -- Riferimento all'utente con cui è condiviso
    PRIMARY KEY (abbonamento_id, utente_id)
);

-- Tabella notifiche
CREATE TABLE notifiche (
    id SERIAL PRIMARY KEY,
    utente_id INT REFERENCES utenti(id) ON DELETE CASCADE,  -- Riferimento all'utente
    messaggio TEXT NOT NULL,  -- Testo della notifica
    tipo_notifica VARCHAR(50) NOT NULL,  -- Tipo di notifica (es. 'scadenza', 'rinnovo')
    data_notifica TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data della notifica
    letta BOOLEAN DEFAULT FALSE  -- Se la notifica è stata letta
);

-- Tabella categorie
CREATE TABLE categorie (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE  -- Nome della categoria (es. "Musica", "Video", ecc.)
);

-- Tabella abbonamenti_categorie
CREATE TABLE abbonamenti_categorie (
    abbonamento_id INT REFERENCES abbonamenti(id) ON DELETE CASCADE,  -- Riferimento all'abbonamento
    categoria_id INT REFERENCES categorie(id) ON DELETE CASCADE,  -- Riferimento alla categoria
    PRIMARY KEY (abbonamento_id, categoria_id)
);

-- Tabella statistiche_spesa
CREATE TABLE statistiche_spesa (
    id SERIAL PRIMARY KEY,
    utente_id INT REFERENCES utenti(id) ON DELETE CASCADE,  -- Riferimento all'utente
    mese INT NOT NULL,  -- Mese della statistica (1 = gennaio, 12 = dicembre)
    anno INT NOT NULL,  -- Anno della statistica
    totale_speso DECIMAL(10, 2),  -- Totale speso in quel mese
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Scopo:
-- Definizione dello schema: Questo script descrive in dettaglio la struttura del database PostgreSQL.
-- Relazioni tra le tabelle: Collega utenti, abbonamenti, notifiche e categorie per creare un sistema interconnesso e scalabile.
-- Persistenza dei dati: Garantisce che i dati siano organizzati e strutturati per future query e analisi.