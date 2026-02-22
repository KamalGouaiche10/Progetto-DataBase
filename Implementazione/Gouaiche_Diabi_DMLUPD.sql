-- 1. Informazioni complete utenti con profilo
SELECT u.nome, u.cognome, u.email, u.lingua_preferita,
       p.dati_demografici, p.interessi, p.data_creazione
FROM Utente u
JOIN Profilo_Utente p ON u.id_utente = p.id_utente
ORDER BY u.cognome;

-- 2. Sessioni attive (senza data_fine)
SELECT s.id_sessione, s.data_inizio, s.dispositivo, s.ip_address,
       EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - s.data_inizio))/60 as minuti_attivi
FROM Sessione s
WHERE s.data_fine IS NULL;

-- 3. Interazioni con emozioni e risposte dell'ultima settimana
SELECT i.id_interazione, u.nome, u.cognome, i.tipo_interazione,
       e.emozione_plutchik_primaria, e.intensita,
       r.contenuto as risposta, r.strategia_empatica
FROM Interazione i
JOIN Utente u ON i.id_utente = u.id_utente
LEFT JOIN Risposta r ON i.id_interazione = r.id_interazione
LEFT JOIN Emozione e ON r.id_emozione = e.id_emozione
WHERE i.inizio_interazione >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY i.inizio_interazione DESC;

-- 4. Feedback per utente con valutazione media
SELECT u.nome, u.cognome,
       COUNT(f.id_feedback) as numero_feedback,
       AVG(f.valutazione) as valutazione_media,
       COUNT(CASE WHEN f.valutazione >= 8 THEN 1 END) as feedback_positivi
FROM Utente u
JOIN Feedback f ON u.id_utente = f.id_utente
WHERE f.tipo_feedback = 'esplicito'
GROUP BY u.id_utente, u.nome, u.cognome
HAVING COUNT(f.id_feedback) > 0
ORDER BY valutazione_media DESC;

-- 5. Traduzioni di alta qualità con dettagli
SELECT t.id_traduzione, t.testo_originale, t.testo_tradotto,
       t.cultura_origine, t.cultura_destinazione, t.qualita_traduzione,
       u.nome, u.cognome
FROM Traduzione t
JOIN Interazione i ON t.id_interazione = i.id_interazione
JOIN Utente u ON i.id_utente = u.id_utente
WHERE t.qualita_traduzione >= 9
ORDER BY t.qualita_traduzione DESC;

-- 6. Metriche di sistema con confronto benchmark
SELECT tipo_metrica, valore, benchmark,
       CASE 
           WHEN valore > benchmark THEN 'Sopra benchmark'
           WHEN valore = benchmark THEN 'Al benchmark'
           ELSE 'Sotto benchmark'
       END as performance,
       periodo_riferimento
FROM Metrica
WHERE benchmark IS NOT NULL;

-- 7. Utenti con errori critici nelle loro sessioni
SELECT DISTINCT u.nome, u.cognome, u.email,
       COUNT(l.id_log) as errori_critici
FROM Utente u
JOIN Interazione i ON u.id_utente = i.id_utente
JOIN Sessione s ON i.id_sessione = s.id_sessione
JOIN Log_Errori l ON s.id_sessione = l.id_sessione
WHERE l.gravita = 'Critico'
GROUP BY u.id_utente, u.nome, u.cognome, u.email
ORDER BY errori_critici DESC;

-- 1. Aggiornare lingua preferita per utenti senza impostazione
UPDATE Utente 
SET lingua_preferita = 'Italiano'
WHERE lingua_preferita IS NULL OR lingua_preferita = '';

-- 2. Chiudere sessioni rimaste aperte da più di 24 ore
UPDATE Sessione 
SET data_fine = CURRENT_TIMESTAMP,
    durata = EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - data_inizio))::INT
WHERE data_fine IS NULL 
  AND data_inizio < CURRENT_TIMESTAMP - INTERVAL '24 hours';

-- 3. Aggiornare livello privacy per utenti con molti feedback positivi
UPDATE Configurazione_Privacy cp
SET livello_privacy = 'Medio'
FROM (
    SELECT f.id_utente
    FROM Feedback f
    WHERE f.tipo_feedback = 'esplicito' AND f.valutazione >= 8
    GROUP BY f.id_utente
    HAVING COUNT(*) >= 3
) buoni_utenti
WHERE cp.id_utente = buoni_utenti.id_utente
  AND cp.livello_privacy = 'Alto';

-- 4. Marcare errori come risolti se più vecchi di 48 ore
UPDATE Log_Errori 
SET risolto = TRUE
FROM Sessione s
WHERE Log_Errori.id_sessione = s.id_sessione
  AND s.data_inizio < CURRENT_TIMESTAMP - INTERVAL '48 hours'
  AND Log_Errori.risolto = FALSE
  AND Log_Errori.gravita IN ('Basso', 'Medio');

-- 5. Aggiornare intensità emozioni obsolete
UPDATE Emozione 
SET intensita = intensita - 1
WHERE intensita > 1 
  AND timestamp < CURRENT_DATE - INTERVAL '30 days'
  AND tipo_emozione = 'Base';

-- 6. Incrementare rilevanza suggerimenti utilizzati spesso
UPDATE Suggerimento s
SET rilevanza = LEAST(rilevanza + 0.5, 10.0)
FROM (
    SELECT DISTINCT r.id_emozione
    FROM Risposta r
    WHERE r.tempo_elaborazione > CURRENT_DATE - INTERVAL '7 days'
) emozioni_recenti
WHERE s.id_emozione = emozioni_recenti.id_emozione;

-- 1. Eliminare notifiche vecchie di tipo "Informativa"
DELETE FROM Notifica 
WHERE tipo = 'Informativa' 
  AND id_notifica IN (
      SELECT n.id_notifica 
      FROM Notifica n
      JOIN Utente u ON n.id_utente = u.id_utente
      WHERE n.tipo = 'Informativa'
      AND n.id_notifica < (SELECT MAX(id_notifica) - 100 FROM Notifica)
  );

-- 2. Rimuovere query di ricerca senza risultati e vecchie di 30 giorni
DELETE FROM Query_Ricerca 
WHERE risultati_trovati = 0 
  AND data_creazione < CURRENT_DATE - INTERVAL '30 days';

-- 3. Eliminare analisi multimodali con bassa confidenza
DELETE FROM Analisi_Multimodale 
WHERE livello_confidenza < 70.0 
  AND timestamp_analisi < CURRENT_DATE - INTERVAL '7 days';

-- 4. Rimuovere memorie conversazionali scadute
DELETE FROM Memoria_Conversazionale 
WHERE scadenza IS NOT NULL 
  AND scadenza < CURRENT_TIMESTAMP;

-- 5. Eliminare log errori risolti e vecchi di 90 giorni
DELETE FROM Log_Errori l
USING Sessione s
WHERE l.id_sessione = s.id_sessione
  AND l.risolto = TRUE
  AND s.data_inizio < CURRENT_DATE - INTERVAL '90 days';

-- 6. Rimuovere traduzioni di bassa qualità non referenziate
DELETE FROM Traduzione 
WHERE qualita_traduzione < 5
  AND id_traduzione NOT IN (
      SELECT DISTINCT id_traduzione 
      FROM Traduzione_Politica 
      WHERE id_traduzione IS NOT NULL
  );


-- Statistiche utenti più attivi con emozioni prevalenti
SELECT u.nome, u.cognome,
       COUNT(DISTINCT i.id_interazione) as interazioni_totali,
       e.emozione_plutchik_primaria as emozione_prevalente,
       COUNT(e.id_emozione) as occorrenze_emozione
FROM Utente u
JOIN Interazione i ON u.id_utente = i.id_utente
JOIN Risposta r ON i.id_interazione = r.id_interazione
JOIN Emozione e ON r.id_emozione = e.id_emozione
GROUP BY u.id_utente, u.nome, u.cognome, e.emozione_plutchik_primaria
HAVING COUNT(DISTINCT i.id_interazione) > 5
ORDER BY interazioni_totali DESC, occorrenze_emozione DESC;