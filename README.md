# Progetto Esame - Basi di dati: Sperimentazioni

progetto Database per il corso "Basi di dati - Sperimentazioni" (A.A. 2024-2025).

## Descrizione
- Modello relazionale e script SQL per la gestione di interazioni utente, emozioni, traduzioni, suggerimenti e metriche.
- Implementazione pensata per PostgreSQL (uso di `CREATE TYPE ... AS ENUM`, `plpgsql`, `SERIAL`, trigger e funzioni).

## Cosa è stato fatto
- Definito lo schema relazionale (tabelle principali: `Utente`, `Profilo_Utente`, `Sessione`, `Interazione`, `Emozione`, `Risposta`, `Traduzione`, `Suggerimento`, `Feedback`, `Metrica`, ecc.).
- Creati tipi enumerati e vincoli (es. tipo ENUM per emozioni, CHECK, UNIQUE, FK).
- Implementate funzioni e trigger in PL/pgSQL per aggiornamenti automatici (es. aggiornamento `ultima_modifica`, calcolo `durata` di sessioni/interazioni).
- Fornite popolazioni di esempio (script DMLPOP) con dati realistici per test e demo.
- Aggiunte query di analisi e operazioni di manutenzione/aggiornamento (script DMLUPD) per reportistica, pulizia e aggiornamenti batch.

## Attori
- `Utente`: persona che interagisce con il sistema (crea sessioni, interazioni, fornisce feedback).
- `Sistema` / Servizio backend: componente che registra eventi, calcola emozioni, genera risposte e mantiene la memoria conversazionale.
- `Moderatore` / Politica di moderazione: attore responsabile dell'applicazione delle regole e del filtro dei contenuti (rappresentato dalle tabelle di policy e dalle verifiche di conformità).
- `Amministratore DB`: gestisce il database, applica gli script DDL/DML, esegue backup e manutenzione.
- `Analista` / Data Analyst: esegue query di reporting e metriche (usa script in `Gouaiche_Diabi_DMLUPD.sql`).
- `Canale/Interfaccia`: web, mobile, voice assistant che fungono da punto di accesso per gli utenti (modellati tramite `Interfaccia_Canale`).
- `Servizi esterni`: sistemi di traduzione, riconoscimento vocale o ML integrati per analisi multimodale e NMT.

## Struttura del progetto
- Implementazione/: contiene gli script SQL
  - [Implementazione/Gouaiche_Diabi_ DDL.sql](Implementazione/Gouaiche_Diabi_%20DDL.sql)
  - [Implementazione/Gouaiche_Diabi_DMLPOP.sql](Implementazione/Gouaiche_Diabi_DMLPOP.sql)
  - [Implementazione/Gouaiche_Diabi_DMLUPD.sql](Implementazione/Gouaiche_Diabi_DMLUPD.sql)
- Progettazione/: diagrammi ER e ristrutturazione


## Requisiti
- PostgreSQL (consigliato) con supporto a `plpgsql`.

## Note 

- Gli script sono scritti per PostgreSQL (tipi ENUM, trigger plpgsql, SERIAL). Adattare se si usa altro DBMS.
- `Gouaiche_Diabi_DMLUPD.sql` contiene sia SELECT che UPDATE/DELETE; valutare esecuzione parziale se necessario.

## Autori
- Gouaiche Kamal
- Diabi Mohamed Zakaria

