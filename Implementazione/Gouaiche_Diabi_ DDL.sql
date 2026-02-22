-- ENUM per le emozioni primarie di Plutchik
CREATE TYPE Emozione_Primaria_Plutchik AS ENUM (
    'Gioia', 
    'Fiducia', 
    'Paura', 
    'Sorpresa', 
    'Tristezza', 
    'Disgusto', 
    'Rabbia', 
    'Anticipazione'
);

-- Tabella per le combinazioni di emozioni primarie (emozioni secondarie)
CREATE TABLE Combinazione_Plutchik (
    id_combinazione SERIAL PRIMARY KEY,
    emozione_primaria_1 Emozione_Primaria_Plutchik NOT NULL,
    emozione_primaria_2 Emozione_Primaria_Plutchik NOT NULL,
    emozione_secondaria VARCHAR(50) NOT NULL,
    descrizione TEXT,
    UNIQUE (emozione_primaria_1, emozione_primaria_2)
);

CREATE TABLE Utente (
    id_utente SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    sesso CHAR(1) CHECK (sesso IN ('M', 'F')),
    data_nascita DATE NOT NULL,
    password VARCHAR(255) NOT NULL,
    lingua_preferita VARCHAR(30) DEFAULT 'Italiano',
    CONSTRAINT uk_utente_email UNIQUE (email),
    CONSTRAINT check_email_format CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')
);

CREATE TABLE Profilo_Utente (
    id_utente INTEGER PRIMARY KEY,
    data_creazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultima_modifica TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dati_demografici TEXT,
    interessi TEXT,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

-- Trigger per aggiornare ultima_modifica
CREATE OR REPLACE FUNCTION update_ultima_modifica()
RETURNS TRIGGER AS $$
BEGIN
    NEW.ultima_modifica = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_profilo_utente
BEFORE UPDATE ON Profilo_Utente
FOR EACH ROW
EXECUTE FUNCTION update_ultima_modifica();

CREATE TABLE Preferenze_Utente (
    id_utente INTEGER PRIMARY KEY,
    tema_interfaccia VARCHAR(50),
    notifiche_attive BOOLEAN DEFAULT TRUE,
    abitudini_utilizzo TEXT,
    scelte_benefiche TEXT,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

CREATE TABLE Sessione (
    id_sessione SERIAL PRIMARY KEY,
    data_inizio TIMESTAMP NOT NULL,
    data_fine TIMESTAMP,
    dispositivo VARCHAR(100),
    ip_address VARCHAR(45),
    durata INTEGER,
    CONSTRAINT check_date_order CHECK (data_fine IS NULL OR data_inizio <= data_fine)
);

-- Funzione per calcolare la durata sessione
CREATE OR REPLACE FUNCTION calcola_durata_sessione()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_fine IS NOT NULL THEN
        NEW.durata = EXTRACT(EPOCH FROM (NEW.data_fine - NEW.data_inizio))::INT;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger per aggiornare durata sessione
CREATE TRIGGER trigger_calcola_durata_sessione
BEFORE INSERT OR UPDATE ON Sessione
FOR EACH ROW
EXECUTE FUNCTION calcola_durata_sessione();

CREATE TABLE Interfaccia_Canale (
    id_interfaccia SERIAL PRIMARY KEY,
    tipo_canale VARCHAR(50) NOT NULL,
    versione VARCHAR(20),
    stato VARCHAR(20) NOT NULL CHECK (stato IN ('Attivo', 'Inattivo', 'Manutenzione', 'Obsoleto')),
    compatibilita TEXT,
    requisiti_tecnici TEXT
);

CREATE TABLE Accessibilita (
    id_utente INTEGER,
    id_interfaccia INTEGER,
    opzioni_visive TEXT,
    opzioni_uditive TEXT,
    opzioni_motorie TEXT,
    livello_semplificazione INTEGER CHECK (livello_semplificazione BETWEEN 0 AND 5),
    PRIMARY KEY (id_utente, id_interfaccia),
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_interfaccia) REFERENCES Interfaccia_Canale(id_interfaccia) ON DELETE CASCADE
);

CREATE TABLE Interazione (
    id_interazione SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    id_sessione INTEGER NOT NULL,
    numero_di_interazione INTEGER NOT NULL,
    tipo_interazione VARCHAR(50) NOT NULL,
    contesto_comunicativo TEXT,
    inizio_interazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fine_interazione TIMESTAMP,
    durata_interazione INTEGER,  
    contenuto TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_sessione) REFERENCES Sessione(id_sessione) ON DELETE CASCADE
);

-- Funzione CORRETTA per calcolare durata interazione in secondi
CREATE OR REPLACE FUNCTION calcola_durata_interazione()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fine_interazione IS NOT NULL THEN
        -- Calcolare la durata in secondi e assegnarla come INTEGER
        NEW.durata_interazione := EXTRACT(EPOCH FROM (NEW.fine_interazione - NEW.inizio_interazione))::INT;
    ELSE
        NEW.durata_interazione := NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calcola_durata_interazione
BEFORE INSERT OR UPDATE ON Interazione
FOR EACH ROW
EXECUTE FUNCTION calcola_durata_interazione();

CREATE TABLE Emozione (
    id_emozione SERIAL PRIMARY KEY,
    tipo_emozione VARCHAR(50) NOT NULL CHECK (tipo_emozione IN ('Base', 'Complessa', 'Culturale')),
    intensita INTEGER CHECK (intensita BETWEEN 1 AND 10),
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    emozione_plutchik_primaria Emozione_Primaria_Plutchik,
    id_combinazione_plutchik INTEGER REFERENCES Combinazione_Plutchik(id_combinazione),
    emozione_attenuata VARCHAR(50),
    intensita_base DECIMAL(3,1) CHECK (intensita_base BETWEEN 0 AND 10),
    tipo_combinazione VARCHAR(50),
    intensita_combinata DECIMAL(3,1) CHECK (intensita_combinata BETWEEN 0 AND 10),
    emozione_origine VARCHAR(50),
    grado_attenuazione DECIMAL(3,1) CHECK (grado_attenuazione BETWEEN 0 AND 10),
    contesto_attenuazione TEXT
);

CREATE TABLE Storico_Emotivo (
    id_storico SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    id_emozione INTEGER NOT NULL,
    pattern_emotivi TEXT,
    tendenze TEXT,
    ultima_rilevazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_emozione) REFERENCES Emozione(id_emozione) ON DELETE CASCADE
);

CREATE TABLE Risposta (
    id_risposta SERIAL PRIMARY KEY,
    id_interazione INTEGER NOT NULL,
    id_emozione INTEGER,
    formato_risposta VARCHAR(100),
    contenuto TEXT NOT NULL,
    tempo_elaborazione TIMESTAMP,
    strategia_empatica VARCHAR(100),
    intensita VARCHAR(100),
    tipo_media VARCHAR(100),
    sincronizzazione VARCHAR(100),
    tipo_contesto TEXT,
    livello_fomalita INTEGER,
    FOREIGN KEY (id_interazione) REFERENCES Interazione(id_interazione) ON DELETE CASCADE,
    FOREIGN KEY (id_emozione) REFERENCES Emozione(id_emozione) ON DELETE CASCADE
);

CREATE TABLE Traduzione (
    id_traduzione SERIAL PRIMARY KEY,
    id_risposta INTEGER,
    id_interazione INTEGER NOT NULL,
    qualita_traduzione INTEGER CHECK (qualita_traduzione BETWEEN 1 AND 10),
    testo_originale TEXT NOT NULL,
    testo_tradotto TEXT NOT NULL,
    cultura_origine VARCHAR(50) NOT NULL,
    cultura_destinazione VARCHAR(50),
    livello_formalita VARCHAR(20) CHECK (livello_formalita IN ('Informale', 'Neutro', 'Formale', 'Tecnico')),
    stile_linguistico VARCHAR(50),
    tipo_traduzione VARCHAR(20) NOT NULL CHECK (tipo_traduzione IN ('linguistica', 'culturale')),
    FOREIGN KEY (id_risposta) REFERENCES Risposta(id_risposta),
    FOREIGN KEY (id_interazione) REFERENCES Interazione(id_interazione)
);

CREATE TABLE Suggerimento (
    id_suggerimento SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    id_emozione INTEGER,
    contenuto_suggerimento TEXT NOT NULL,
    rilevanza DECIMAL(3,1) CHECK (rilevanza BETWEEN 0 AND 10),
    categoria VARCHAR(50),
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_emozione) REFERENCES Emozione(id_emozione) ON DELETE CASCADE
);

CREATE TABLE Feedback (
    id_feedback SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    id_risposta INTEGER,
    tipo_feedback VARCHAR(20) NOT NULL CHECK (tipo_feedback IN ('esplicito', 'implicito')),
    commento_testuale TEXT,
    valutazione INTEGER CHECK (valutazione BETWEEN 1 AND 10),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    azione_correttiva TEXT,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_risposta) REFERENCES Risposta(id_risposta) ON DELETE CASCADE,
    CONSTRAINT check_valutazione_required CHECK (
        (tipo_feedback = 'esplicito' AND valutazione IS NOT NULL) OR
        (tipo_feedback = 'implicito' AND valutazione IS NULL)
    )
);

CREATE TABLE Metrica (
    id_metrica SERIAL PRIMARY KEY,
    tipo_metrica VARCHAR(50),
    valore DECIMAL(10,2),
    benchmark DECIMAL(10,2),
    tempo_risposta INTEGER, 
    tasso_errore DECIMAL(5,2),
    periodo_riferimento VARCHAR(50),
    tasso_successo_emozione DECIMAL(5,2) CHECK (tasso_successo_emozione BETWEEN 0 AND 100)
);

CREATE TABLE Configurazione_Privacy (
    id_utente INTEGER PRIMARY KEY,
    livello_privacy VARCHAR(20) NOT NULL CHECK (livello_privacy IN ('Basso', 'Medio', 'Alto', 'Massimo')),
    consensi_marketing BOOLEAN DEFAULT FALSE,
    dati_condivisi TEXT,
    impostazioni_sicurezza TEXT,
    impostazioni_scalabilita TEXT,
    ultima_modifica TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

CREATE TABLE Log_Errori (
    id_log SERIAL PRIMARY KEY,
    id_sessione INTEGER NOT NULL,
    gravita VARCHAR(20) NOT NULL CHECK (gravita IN ('Basso', 'Medio', 'Alto', 'Critico')),
    risolto BOOLEAN DEFAULT FALSE,
    tipo_errore VARCHAR(100) NOT NULL,
    descrizione TEXT,
    FOREIGN KEY (id_sessione) REFERENCES Sessione(id_sessione) ON DELETE CASCADE
);

CREATE TABLE Politica_Moderazione (
    id_politica SERIAL PRIMARY KEY,
    regole TEXT NOT NULL,
    filtri_contenuto TEXT,
    versione VARCHAR(20) NOT NULL,
    data_aggiornamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    livello_restrizione VARCHAR(20) NOT NULL CHECK (livello_restrizione IN ('Basso', 'Medio', 'Alto', 'Massimo'))
);

CREATE TABLE Contenuto_Multimediale (
    id_contenuto SERIAL PRIMARY KEY,
    tipo_media VARCHAR(50) NOT NULL,
    dimensione INTEGER, 
    formato VARCHAR(20) NOT NULL,
    url_risorsa VARCHAR(255),
    durata INTEGER,
    qualita VARCHAR(20),
    CONSTRAINT check_tipo_media CHECK (tipo_media IN ('Immagine', 'Video', 'Audio', 'Documento', 'Altro'))
);

CREATE TABLE Notifica (
    id_notifica SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    titolo VARCHAR(100),
    messaggio TEXT,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('Informativa', 'Avviso', 'Errore', 'Successo', 'Aggiornamento')),
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

CREATE TABLE Analisi_Multimodale (
    id_analisi SERIAL PRIMARY KEY,
    fonte_input VARCHAR(50) NOT NULL,
    contenuto_grezzo TEXT,
    metodo_analisi VARCHAR(100) NOT NULL,
    livello_confidenza DECIMAL(5,2) CHECK (livello_confidenza BETWEEN 0 AND 100),
    timestamp_analisi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Memoria_Conversazionale (
    id_memoria SERIAL PRIMARY KEY,
    info_memorizzata TEXT NOT NULL,
    categoria_info VARCHAR(50) NOT NULL,
    data_acquisizione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    scadenza TIMESTAMP,
    livello_rilevanza INTEGER CHECK (livello_rilevanza BETWEEN 1 AND 10),
    CONSTRAINT check_scadenza CHECK (scadenza IS NULL OR scadenza > data_acquisizione)
);

CREATE TABLE Query_Ricerca (
    id_query SERIAL PRIMARY KEY,
    id_utente INTEGER NOT NULL,
    testo_query TEXT NOT NULL,
    tipo_query VARCHAR(50) NOT NULL,
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    risultati_trovati INTEGER DEFAULT 0,
    FOREIGN KEY (id_utente) REFERENCES Utente(id_utente) ON DELETE CASCADE
);

-- Relazione tra Memoria_Conversazionale e Interazione (utilizza_in/acquisisce_da)
CREATE TABLE Memoria_Interazione (
    id_memoria INTEGER NOT NULL,
    id_interazione INTEGER NOT NULL,
    tipo_relazione VARCHAR(20) NOT NULL CHECK (tipo_relazione IN ('utilizza_in', 'acquisisce_da')),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priorita INTEGER CHECK (priorita BETWEEN 1 AND 10),
    PRIMARY KEY (id_memoria, id_interazione, tipo_relazione),
    FOREIGN KEY (id_memoria) REFERENCES Memoria_Conversazionale(id_memoria) ON DELETE CASCADE,
    FOREIGN KEY (id_interazione) REFERENCES Interazione(id_interazione) ON DELETE CASCADE
);

-- Query di ricerca (cerca1, cerca2, cerca3)
CREATE TABLE Query_Interazione (
    id_query INTEGER NOT NULL,
    id_interazione INTEGER NOT NULL,
    tipo_ricerca VARCHAR(20) NOT NULL CHECK (tipo_ricerca IN ('cerca1', 'cerca2', 'cerca3')),
    rilevanza DECIMAL(3,1) CHECK (rilevanza BETWEEN 0 AND 10),
    timestamp_ricerca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_query, id_interazione, tipo_ricerca),
    FOREIGN KEY (id_query) REFERENCES Query_Ricerca(id_query) ON DELETE CASCADE,
    FOREIGN KEY (id_interazione) REFERENCES Interazione(id_interazione) ON DELETE CASCADE
);

CREATE TABLE Query_Emozione (
    id_query INTEGER NOT NULL,
    id_emozione INTEGER NOT NULL,
    rilevanza DECIMAL(3,1) CHECK (rilevanza BETWEEN 0 AND 10),
    PRIMARY KEY (id_query, id_emozione),
    FOREIGN KEY (id_query) REFERENCES Query_Ricerca(id_query) ON DELETE CASCADE,
    FOREIGN KEY (id_emozione) REFERENCES Emozione(id_emozione) ON DELETE CASCADE
);

CREATE TABLE Risposta_Politica (
    id_risposta INTEGER NOT NULL,
    id_politica INTEGER NOT NULL,
    conformita_verificata BOOLEAN DEFAULT FALSE,
    timestamp_verifica TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_risposta, id_politica),
    FOREIGN KEY (id_risposta) REFERENCES Risposta(id_risposta) ON DELETE CASCADE,
    FOREIGN KEY (id_politica) REFERENCES Politica_Moderazione(id_politica) ON DELETE CASCADE
);

CREATE TABLE Traduzione_Politica (
    id_traduzione INTEGER NOT NULL,
    id_politica INTEGER NOT NULL,
    timestamp_applicazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_traduzione, id_politica),
    FOREIGN KEY (id_traduzione) REFERENCES Traduzione(id_traduzione) ON DELETE CASCADE,
    FOREIGN KEY (id_politica) REFERENCES Politica_Moderazione(id_politica) ON DELETE CASCADE
);

-- Relazioni con Contenuto_Multimediale
CREATE TABLE Interazione_Contenuto (
    id_interazione INTEGER NOT NULL,
    id_contenuto INTEGER NOT NULL,
    ruolo VARCHAR(20) DEFAULT 'include',
    timestamp_associazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_interazione, id_contenuto),
    FOREIGN KEY (id_interazione) REFERENCES Interazione(id_interazione) ON DELETE CASCADE,
    FOREIGN KEY (id_contenuto) REFERENCES Contenuto_Multimediale(id_contenuto) ON DELETE CASCADE
);

CREATE TABLE Preferenze_Contenuto (
    id_utente INTEGER NOT NULL,
    id_contenuto INTEGER NOT NULL,
    tipo_influenza VARCHAR(50),
    PRIMARY KEY (id_utente, id_contenuto),
    FOREIGN KEY (id_utente) REFERENCES Preferenze_Utente(id_utente) ON DELETE CASCADE,
    FOREIGN KEY (id_contenuto) REFERENCES Contenuto_Multimediale(id_contenuto) ON DELETE CASCADE
);