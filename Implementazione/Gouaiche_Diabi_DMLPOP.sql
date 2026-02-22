-- Combinazioni di emozioni primarie (emozioni secondarie)
INSERT INTO Combinazione_Plutchik (emozione_primaria_1, emozione_primaria_2, emozione_secondaria, descrizione) VALUES
('Gioia', 'Fiducia', 'Amore', 'Sentimento di attaccamento profondo e positivo'),
('Fiducia', 'Paura', 'Sottomissione', 'Emozione di cedimento di fronte all autorità'),
('Paura', 'Sorpresa', 'Spavento', 'Reazione improvvisa di timore intenso'),
('Sorpresa', 'Tristezza', 'Delusione', 'Sentimento di aspettativa non soddisfatta'),
('Tristezza', 'Disgusto', 'Rimorso', 'Pentimento profondo per azioni passate'),
('Disgusto', 'Rabbia', 'Disprezzo', 'Sentimento di superiorità e rifiuto'),
('Rabbia', 'Anticipazione', 'Aggressività', 'Tendenza all azione violenta o assertiva');

INSERT INTO Utente (nome, cognome, email, sesso, data_nascita, password, lingua_preferita) VALUES
('Mario', 'Rossi', 'mario.rossi@email.com', 'M', '1985-03-15', 'Password1', 'Italiano'),
('Anna', 'Bianchi', 'anna.bianchi@email.com', 'F', '1990-07-22','Password2', 'Tesdesco'),
('Marco', 'Verdi', 'marco.verdi@email.com', 'M', '1988-11-30', 'Password3', 'Inglese'),
('Sofia', 'Neri', 'sofia.neri@email.com', 'F', '1992-01-08', 'Password4', 'Spagnolo'),
('Luca', 'Ferrari', 'luca.ferrari@email.com', 'M', '1987-09-14', 'Password5', 'Francese'),
('Elena', 'Romano', 'elena.romano@email.com', 'F', '1991-05-03', 'Password6', 'Italiano'),
('Alessandro', 'Ricci', 'alessandro.ricci@email.com', 'M', '1989-12-17', 'Password7', 'Arabo');

INSERT INTO Profilo_Utente (id_utente, dati_demografici, interessi) VALUES
(1, 'Ingegnere informatico, Milano, single', 'Tecnologia, videogiochi, programmazione, lettura'),
(2, 'Psicologa clinica, Roma, sposata con 2 figli', 'Psicologia, mindfulness, yoga, arte'),
(3, 'Marketing manager, Torino, in coppia', 'Marketing digitale, viaggi, fotografia, cinema'),
(4, 'Studentessa universitaria, Napoli, single', 'Medicina, ricerca scientifica, sport, musica'),
(5, 'Consulente finanziario, Bologna, sposato', 'Finanza, economia, tennis, cucina'),
(6, 'Designer grafica, Firenze, in coppia', 'Design, arte contemporanea, moda, architettura'),
(7, 'Professore di lingue, Venezia, single', 'Linguistica, letteratura, viaggi, teatro');

INSERT INTO Preferenze_Utente (id_utente, tema_interfaccia, notifiche_attive, abitudini_utilizzo, scelte_benefiche) VALUES
(1, 'Scuro', TRUE, 'Utilizzo serale intensivo, preferenza per risposte tecniche dettagliate', 'Riduzione stress da lavoro, miglioramento focus'),
(2, 'Chiaro', TRUE, 'Utilizzo durante pausa pranzo e sera, preferenza per supporto emotivo', 'Gestione ansia pazienti, equilibrio vita-lavoro'),
(3, 'Automatico', FALSE, 'Utilizzo sporadico per brainstorming creativo', 'Stimolo creatività, networking professionale'),
(4, 'Chiaro', TRUE, 'Utilizzo studio intensivo, ricerca informazioni mediche', 'Supporto studio, gestione stress esami'),
(5, 'Scuro', TRUE, 'Utilizzo professionale per analisi finanziarie', 'Decisioni investimenti, aggiornamento mercati'),
(6, 'Colorato', TRUE, 'Utilizzo creativo per ispirazione progetti', 'Stimolo artistico, tendenze design'),
(7, 'Classico', TRUE, 'Utilizzo didattico e traduzione testi', 'Miglioramento insegnamento, preparazione lezioni');

-- Sessioni di utilizzo
INSERT INTO Sessione (data_inizio, data_fine, dispositivo, ip_address) VALUES
('2025-06-25 09:00:00', '2025-06-25 09:45:00', 'Desktop Windows', '192.168.1.100'),
('2025-06-25 12:30:00', '2025-06-25 13:15:00', 'iPhone 16', '10.0.0.50'),
('2025-06-25 14:20:00', '2025-06-25 15:10:00', 'MacBook Pro', '192.168.1.105'),
('2025-06-25 16:45:00', '2025-06-25 17:30:00', 'Android Xiaomi', '192.168.1.110'),
('2025-06-25 19:00:00', '2025-06-25 20:15:00', 'iPad Air', '10.0.0.75'),
('2025-06-25 21:30:00', '2025-06-25 22:45:00', 'Desktop Linux', '192.168.1.120'),
('2025-06-26 08:15:00', NULL, 'Surface Pro', '192.168.1.125');

INSERT INTO Interfaccia_Canale (tipo_canale, versione, stato, compatibilita, requisiti_tecnici) VALUES
('Web Browser', '2.4.1', 'Attivo', 'Chrome 90+, Firefox 88+, Safari 14+', 'JavaScript ES6, WebGL 2.0'),
('Mobile App iOS', '1.8.2', 'Attivo', 'iOS 18.04', 'ARKit 4.0, Core ML 3.0'),
('Mobile App Android', '1.8.0', 'Attivo', 'Android 8.0+', 'TensorFlow Lite, Camera2 API'),
('Desktop Application', '3.1.5', 'Attivo', 'Windows 10+, macOS 11+, Ubuntu 20.04+', '.NET 6.0, OpenGL 4.5'),
('API REST', '4.2.0', 'Attivo', 'HTTP/2, JSON, OAuth 2.0', 'TLS 1.3, Rate Limiting'),
('Voice Assistant', '1.2.3', 'Manutenzione', 'Alexa, Google Assistant, Siri', 'Wake Word Detection, NLU'),
('Chatbot Widget', '2.0.1', 'Attivo', 'Embed JavaScript', 'Minimal CSS, CORS support');

INSERT INTO Accessibilita (id_utente, id_interfaccia, opzioni_visive, opzioni_uditive, opzioni_motorie, livello_semplificazione) VALUES
(1, 1, 'Alto contrasto, font grande 16px', 'Nessuna', 'Nessuna', 1),
(2, 2, 'Tema chiaro, riduzione animazioni', 'Volume notifiche alto', 'Gesture semplificate', 2),
(3, 3, 'Standard', 'Sottotitoli automatici', 'Controlli vocali', 1),
(4, 1, 'Modalità scura, zoom 120%', 'Feedback audio', 'Nessuna', 2),
(5, 4, 'Standard', 'Nessuna', 'Shortcuts tastiera', 0),
(6, 1, 'Profilo colori vivaci', 'Nessuna', 'Nessuna', 1),
(7, 2, 'Font serif, dimensione 18px', 'Lettura vocale', 'Touch assistito', 3);

INSERT INTO Interazione (id_utente, id_sessione, numero_di_interazione, tipo_interazione, contesto_comunicativo, inizio_interazione, fine_interazione, contenuto) VALUES
(1, 1, 10, 'Domanda tecnica', 'Risoluzione problema di codice', '2025-06-25 09:05:00', '2025-06-25 09:12:00', 'Come posso ottimizzare una query SQL complessa?'),
(2, 2, 67, 'Supporto emotivo', 'Gestione stress lavorativo', '2025-06-25 12:35:00', '2025-06-25 12:50:00', 'Mi sento sopraffatta dai casi dei miei pazienti'),
(3, 3, 97, 'Brainstorming', 'Sviluppo campagna marketing', '2025-06-25 14:25:00', '2025-06-25 14:45:00', 'Idee creative per campagna prodotto eco-sostenibile'),
(4, 4, 24, 'Ricerca informazioni', 'Studio anatomia cardiaca', '2025-06-25 16:50:00', '2025-06-25 17:15:00', 'Spiegazione dettagliata sistema di conduzione cardiaca'),
(5, 5, 25, 'Analisi dati', 'Valutazione portfolio investimenti', '2025-06-25 19:10:00', '2025-06-25 19:45:00', 'Analisi rischio-rendimento portafoglio diversificato'),
(6, 6, 52, 'Ispirazione creativa', 'Progetto branding aziendale', '2025-06-25 21:35:00', '2025-06-25 22:20:00', 'Tendenze design logo per startup tecnologica'),
(7, 7, 7, 'Traduzione testo', 'Preparazione lezione lingue', '2025-06-26 08:20:00', NULL, 'Traduzione e analisi grammaticale testo shakespeariano');

INSERT INTO Emozione (tipo_emozione, intensita, emozione_plutchik_primaria, id_combinazione_plutchik, intensita_base, tipo_combinazione, intensita_combinata) VALUES
('Base', 6, 'Paura', NULL, 6.0, NULL, NULL),
('Complessa', 8, NULL, 2, 7.5, 'Dominanza-Sottomissione', 8.0),
('Base', 7, 'Gioia', NULL, 7.0, NULL, NULL),
('Base', 5, 'Anticipazione', NULL, 5.0, NULL, NULL),
('Complessa', 6, NULL, 1, 8.0, 'Gioia-Fiducia', 9.0),
('Base', 4, 'Fiducia', NULL, 4.0, NULL, NULL),
('Culturale', 7, 'Sorpresa', NULL, 6.5, NULL, NULL);

INSERT INTO Storico_Emotivo (id_utente, id_emozione, pattern_emotivi, tendenze) VALUES
(1, 1, 'Ansia da prestazione durante risoluzione problemi complessi', 'Miglioramento gestione stress tecnico'),
(2, 2, 'Empatia elevata verso problemi altrui, rischio burnout', 'Necessità equilibrio emotivo professionale'),
(3, 3, 'Entusiasmo per progetti creativi, energia alta', 'Mantenimento motivazione costante'),
(4, 4, 'Curiosità intellettuale, desiderio apprendimento', 'Crescita costante conoscenze mediche'),
(5, 5, 'Fiducia nelle decisioni finanziarie, approccio razionale', 'Equilibrio tra prudenza e opportunità'),
(6, 4, 'Ispirazione artistica ciclica, creatività a onde', 'Sfruttamento picchi creativi'),
(7, 7, 'Soddisfazione nell insegnamento, pazienza didattica', 'Miglioramento continuo metodi insegnamento');

INSERT INTO Risposta (id_interazione, id_emozione, formato_risposta, contenuto, tempo_elaborazione, strategia_empatica, intensita, tipo_media, sincronizzazione, tipo_contesto, livello_fomalita) VALUES
(1, 1, 'Testo con emoji', 'Ciao! Sono felice di sentirti oggi!😊 ', '2025-01-15 09:01:05', 'Rispecchiamento emotivo', 'Media', 'Testo', 'Sincrona', 'Informale', 1),
(2, 2, 'Audio guidato', 'Ti guiderò attraverso una tecnica di respirazione', '2025-01-15 14:05:10', 'Supporto rassicurante', 'Bassa', 'Audio', 'Asincrona', 'Terapeutico', 3),
(3, 3, 'Feedback visivo', 'Ottima scelta! Continua così', '2025-01-16 10:20:05', 'Rinforzo positivo', 'Alta', 'Visivo', 'Sincrona', 'Interfaccia', 2),
(4, 4, 'Risposta multimodale', 'Comprendo la tua situazione complessa', '2025-01-16 16:35:15', 'Validazione emotiva', 'Media', 'Multimodale', 'Sincrona', 'Terapeutico', 4),
(5, 5, 'Lista strutturata', 'Ecco 5 tecniche di meditazione efficaci', '2025-01-17 08:50:10', 'Approccio educativo', 'Neutra', 'Testo', 'Asincrona', 'Informativo', 3),
(6, 6, 'Risposta empatica', 'È normale sentirsi così, parliamone', '2025-01-17 20:10:15', 'Accoglienza emotiva', 'Bassa', 'Testo', 'Sincrona', 'Supportivo', 2),
(7, 7, 'Consiglio strutturato', 'Considera queste opzioni per la tua decisione', '2025-01-18 12:05:20', 'Guida cognitiva', 'Media', 'Testo', 'Sincrona', 'Consulenza', 4);

INSERT INTO Traduzione (id_risposta, id_interazione, qualita_traduzione, testo_originale, testo_tradotto, cultura_origine, cultura_destinazione, livello_formalita, tipo_traduzione) VALUES
(2, 2, 9, 'I feel overwhelmed by my patients cases', 'Mi sento sopraffatta dai casi dei miei pazienti', 'Inglese', 'Italiano', 'Neutro', 'linguistica'),
(3, 3, 8, 'Idées créatives pour une campagne écologique', 'Idee creative per campagna eco-sostenibile', 'Francese', 'Italiano', 'Neutro', 'linguistica'),
(4, 4, 10, 'Explicação detalhada da condução cardíaca', 'Spiegazione dettagliata conduzione cardiaca', 'Portguese', 'Italiano', 'Tecnico', 'linguistica'),
(5, 5, 9, 'Risk-return portfolio analysis', 'Analisi rischio-rendimento portafoglio', 'Inglese', 'Italiano', 'Formale', 'linguistica'),
(6, 6, 8, 'Logo design trends for tech startup', 'Tendenze design logo per startup tecnologica', 'Inglese', 'Italiano', 'Neutro', 'linguistica'),
(7, 7, 10, 'To be or not to be, that is the question', 'Essere o non essere, questo è il dilemma', 'Inglese', 'Italiano', 'Formale', 'culturale'),
(1, 1, 9, 'SQL query optimization techniques', 'Tecniche di ottimizzazione query SQL', 'Inglese', 'Italiano', 'Tecnico', 'linguistica');


INSERT INTO Suggerimento (id_utente, id_emozione, contenuto_suggerimento, rilevanza, categoria) VALUES
(1, 1, 'Continua a coltivare questa energia positiva con attività creative', 8.5, 'Benessere'),
(2, 2, 'Prova a esprimere i tuoi sentimenti attraverso la scrittura', 7.8, 'Espressione'),
(3, 3, 'Considera tecniche di rilassamento quando senti ansia', 9.2, 'Gestione Stress'),
(4, 4, 'Organizza meglio il tuo tempo per ridurre le preoccupazioni', 8.0, 'Produttività'),
(5, 5, 'Cerca supporto sociale durante i momenti difficili', 8.7, 'Relazioni'),
(6, 6, 'Pratica la gratitudine per contrastare la malinconia', 7.5, 'Mindfulness'),
(7, 7, 'Identifica i trigger della rabbia per gestirla meglio', 9.0, 'Autocontrollo');

INSERT INTO Feedback (id_utente, id_risposta, tipo_feedback, commento_testuale, valutazione, timestamp, azione_correttiva) VALUES
(1, 1, 'esplicito', 'Spiegazione molto chiara e applicabile immediatamente', 9, '2025-06-15 14:23:45', NULL),
(2, 2, 'esplicito', 'Mi è stata davvero di aiuto, mi sono sentita compresa', 10, '2025-06-16 09:12:30', NULL),
(3, 3, 'esplicito', 'Idee originali che non avevo considerato', 8, '2025-06-17 16:45:12', 'Personalizzare maggiormente le risposte'),
(4, 4, 'esplicito', 'Perfetta per il mio livello di studio', 9, '2025-06-18 11:28:03', NULL),
(5, 5, 'esplicito', 'Analisi professionale e dettagliata', 9, '2025-06-19 13:15:27', NULL),
(6, 6, 'implicito', 'Tempo di lettura prolungato sulla risposta', NULL, '2025-06-20 10:07:18', 'Monitorare engagement futuro'),
(7, 7, 'esplicito', 'Traduzione accurata con ottimo contesto storico', 10, '2025-06-21 15:52:41', 'Fornire opzioni più concrete');

INSERT INTO Metrica (tipo_metrica, valore, benchmark, tempo_risposta, tasso_errore, periodo_riferimento, tasso_successo_emozione) VALUES
('Accuratezza riconoscimento emotivo', 87.50, 85.00, 450, 2.30, 'Settimana 25-2024', 89.20),
('Soddisfazione utente media', 8.80, 8.50, NULL, NULL, 'Settimana 25-2024', NULL),
('Velocità elaborazione query', 1250.00, 1500.00, 1250, 1.80, 'Settimana 25-2024', NULL),
('Precisione traduzione automatica', 92.30, 90.00, 800, 0.50, 'Settimana 25-2024', NULL),
('Engagement conversazionale', 76.40, 75.00, NULL, NULL, 'Settimana 25-2024', 78.50),
('Qualità suggerimenti personalizzati', 85.60, 82.00, 600, 1.20, 'Settimana 25-2024', 87.30),
('Uptime sistema', 99.80, 99.50, NULL, 0.20, 'Settimana 25-2024', NULL);

INSERT INTO Configurazione_Privacy (id_utente, livello_privacy, consensi_marketing, dati_condivisi, impostazioni_sicurezza, impostazioni_scalabilita) VALUES
(1, 'Alto', FALSE, 'Solo dati anonimi per miglioramento servizio', 'Autenticazione 2FA, crittografia end-to-end', 'Elaborazione locale quando possibile'),
(2, 'Massimo', FALSE, 'Nessun dato condiviso', 'Cancellazione automatica cronologia', 'Priorità privacy su performance'),
(3, 'Medio', TRUE, 'Preferenze interesse, dati demografici base', 'Password complessa, logout automatico', 'Bilanciamento privacy-funzionalità'),
(4, 'Alto', FALSE, 'Solo metadati utilizzo anonimi', 'Crittografia avanzata, VPN consigliata', 'Elaborazione distribuita sicura'),
(5, 'Medio', TRUE, 'Dati finanziari aggregati anonimi', 'Backup crittografato, audit regolari', 'Cache locale per dati sensibili'),
(6, 'Basso', TRUE, 'Portfolio creativo, preferenze design', 'Protezione base, sync cloud', 'Ottimizzazione performance'),
(7, 'Alto', FALSE, 'Contenuti didattici anonimi', 'Separazione dati personali-professionali', 'Archiviazione educativa sicura');

INSERT INTO Log_Errori (id_sessione, gravita, risolto, tipo_errore, descrizione) VALUES
(1, 'Basso', TRUE, 'Timeout connessione', 'Timeout minore durante caricamento suggerimenti personalizzati'),
(2, 'Medio', TRUE, 'Errore riconoscimento vocale', 'Difficoltà nell interpretazione comando vocale con rumore di fondo'),
(3, 'Basso', TRUE, 'Cache invalidation', 'Cache browser non aggiornata per nuove preferenze utente'),
(4, 'Alto', TRUE, 'Fallimento analisi emotiva', 'Algoritmo ML non è riuscito a classificare emozione complessa'),
(5, 'Medio', FALSE, 'Sincronizzazione multidevice', 'Dati non sincronizzati correttamente tra iPad e iPhone'),
(6, 'Basso', TRUE, 'Formattazione risposta', 'Errore minore nella formattazione HTML della risposta'),
(7, 'Critico', TRUE, 'Perdita connessione database', 'Interruzione temporanea connessione durante salvataggio interazione');

INSERT INTO Politica_Moderazione (regole, filtri_contenuto, versione, livello_restrizione) VALUES
('Divieto contenuti offensivi, hate speech, informazioni mediche non verificate', 'Filtro linguaggio inappropriato, controllo fact-checking medico', 'v2.1.0', 'Alto'),
('Protezione dati sensibili, rispetto privacy utenti minorenni', 'Rilevamento informazioni personali, protezione minori', 'v2.1.0', 'Massimo'),
('Controllo qualità traduzioni, accuratezza informazioni tecniche', 'Validazione terminologia tecnica, controllo coerenza', 'v2.0.5', 'Medio'),
('Moderazione interazioni commerciali, trasparenza sponsorizzazioni', 'Identificazione contenuti promozionali nascosti', 'v2.1.0', 'Alto'),
('Prevenzione manipolazione emotiva, protezione utenti vulnerabili', 'Rilevamento tecniche persuasive dannose', 'v2.1.1', 'Massimo'),
('Controllo accuratezza informazioni finanziarie e investimenti', 'Verifica fonti finanziarie, disclaimer rischi', 'v2.0.8', 'Alto'),
('Moderazione contenuti educativi, verificazione fonti accademiche', 'Controllo qualità fonti, peer review automatico', 'v2.1.0', 'Medio');


INSERT INTO Contenuto_Multimediale (tipo_media, dimensione, formato, url_risorsa, durata, qualita) VALUES
('Immagine', 2048576, 'PNG', 'https://cdn.emotiveai.com/diagrams/sql_optimization.png', NULL, 'Alta'),
('Audio', 5242880, 'MP3', 'https://cdn.emotiveai.com/audio/mindfulness_guide.mp3', 600, 'Alta'),
('Video', 15728640, 'MP4', 'https://cdn.emotiveai.com/videos/design_thinking_intro.mp4', 240, 'HD'),
('Immagine', 1572864, 'JPEG', 'https://cdn.emotiveai.com/anatomy/heart_conduction.jpg', NULL, 'Media'),
('Documento', 524288, 'PDF', 'https://cdn.emotiveai.com/reports/portfolio_analysis.pdf', NULL, 'Alta'),
('Immagine', 3145728, 'SVG', 'https://cdn.emotiveai.com/design/logo_trends_2024.svg', NULL, 'Vettoriale'),
('Audio', 4194304, 'WAV', 'https://cdn.emotiveai.com/pronunciation/shakespeare_reading.wav', 180, 'Studio');

INSERT INTO Notifica (id_utente, titolo, messaggio, tipo) VALUES
(1, 'Nuovo suggerimento disponibile', 'Abbiamo un nuovo consiglio per ottimizzare il tuo workflow di sviluppo', 'Informativa'),
(2, 'Sessione mindfulness consigliata', 'È il momento perfetto per una pausa mindfulness di 10 minuti', 'Avviso'),
(3, 'Ispirazione creativa aggiornata', 'Nuove tendenze design aggiunte alla tua collezione personale', 'Aggiornamento'),
(4, 'Nuovo materiale di studio', 'Aggiunto nuovo diagramma interattivo per anatomia cardiaca', 'Informativa'),
(5, 'Aggiornamento mercati', 'Report settimanale portfolio e raccomandazioni rebalancing', 'Aggiornamento'),
(6, 'Collezione ispirazione aggiornata', 'Aggiunte 15 nuove ispirazioni per il tuo progetto startup', 'Informativa'),
(7, 'Nuovi strumenti didattici', 'Disponibili nuovi template interattivi per le tue lezioni', 'Aggiornamento');

INSERT INTO Analisi_Multimodale (fonte_input, contenuto_grezzo, metodo_analisi, livello_confidenza) VALUES
('Testo + Tono vocale', 'Come posso ottimizzare...', 'NLP + Analisi prosodia', 87.50),
('Testo + Espressioni facciali', 'Mi sento sopraffatta...', 'Sentiment Analysis + Computer Vision', 92.30),
('Testo + Gestualità', 'Idee creative per...', 'NLU + Gesture Recognition', 78.90),
('Testo + Context', 'Spiegazione sistema conduzione...', 'Knowledge Graph + Entity Recognition', 95.20),
('Testo + Dati storici', 'Analisi portfolio...', 'Time Series Analysis + NLP', 89.70),
('Immagini + Testo', 'Tendenze design logo...', 'Computer Vision + Semantic Analysis', 85.40),
('Audio + Testo', 'Traduzione shakespeariana...', 'Speech Recognition + NMT', 91.80);

INSERT INTO Memoria_Conversazionale (info_memorizzata, categoria_info, scadenza, livello_rilevanza) VALUES
('Utente preferisce spiegazioni tecniche dettagliate con esempi pratici', 'Stile comunicazione', '2026-12-25 00:00:00', 9),
('Psicologa con tendenza al burnout, necessita supporto emotivo bilanciato', 'Profilo professionale', '2026-12-25 00:00:00', 10),
('Manager creativo, risponde bene a stimoli visivi e brainstorming strutturato', 'Modalità apprendimento', '2026-09-25 00:00:00', 8),
('Studentessa medicina, fase preparazione esami, alta motivazione', 'Contesto accademico', '2026-09-30 00:00:00', 9),
('Consulente esperto, preferisce analisi quantitative e dati verificabili', 'Stile decisionale', '2026-12-25 00:00:00', 8),
('Designer con approccio emotivo-estetico, sensibile a tendenze contemporanee', 'Profilo creativo', '2026-09-25 00:00:00', 7),
('Professore linguista, apprezza accuratezza filologica e contesto culturale', 'Competenza accademica', '2026-12-25 00:00:00', 9);

INSERT INTO Query_Ricerca (id_utente, testo_query, tipo_query, risultati_trovati) VALUES
(1, 'ottimizzazione performance database SQL indici composti', 'tecnica', 156),
(2, 'tecniche gestione stress burnout operatori sanitari', 'benessere', 89),
(3, 'tendenze marketing sostenibile 2024 campagne green', 'creativa', 234),
(4, 'anatomia sistema cardiovascolare conduzione elettrica', 'accademica', 67),
(5, 'strategie diversificazione portfolio rischio moderato', 'finanziaria', 123),
(6, 'design trends logo startup tech minimalismo', 'design', 178),
(7, 'traduzione Inglese italiano problemi linguistici', 'linguistica', 45);

-- Relazioni Memoria-Interazione
INSERT INTO Memoria_Interazione (id_memoria, id_interazione, tipo_relazione, priorita) VALUES
(1, 1, 'utilizza_in', 9),
(2, 2, 'acquisisce_da', 10),
(3, 3, 'utilizza_in', 8),
(4, 4, 'acquisisce_da', 9),
(5, 5, 'utilizza_in', 8),
(6, 6, 'acquisisce_da', 7),
(7, 7, 'utilizza_in', 9);

-- Relazioni Query-Interazione
INSERT INTO Query_Interazione (id_query, id_interazione, tipo_ricerca, rilevanza, timestamp_ricerca) VALUES
(1, 1, 'cerca1', 9.5, '2025-06-25 09:03:00'),
(2, 2, 'cerca2', 8.8, '2025-06-25 12:33:00'),
(3, 3, 'cerca1', 7.9, '2025-06-25 14:23:00'),
(4, 4, 'cerca3', 9.2, '2025-06-25 16:48:00'),
(5, 5, 'cerca1', 8.7, '2025-06-25 19:08:00'),
(6, 6, 'cerca2', 7.5, '2025-06-25 21:33:00'),
(7, 7, 'cerca3', 9.1, '2025-06-26 08:18:00');

-- Relazioni Query-Emozione
INSERT INTO Query_Emozione (id_query, id_emozione, rilevanza) VALUES
(1, 1, 8.5),
(2, 2, 9.0),
(3, 3, 7.8),
(4, 4, 8.2),
(5, 5, 8.9),
(6, 4, 7.3),
(7, 7, 8.7);

-- Relazioni Risposta-Politica
INSERT INTO Risposta_Politica (id_risposta, id_politica, conformita_verificata) VALUES
(1, 3, TRUE),
(2, 1, TRUE),
(3, 4, TRUE),
(4, 1, TRUE),
(5, 6, TRUE),
(6, 7, TRUE),
(7, 7, TRUE);

-- Relazioni Traduzione-Politica
INSERT INTO Traduzione_Politica (id_traduzione, id_politica) VALUES
(1, 1),
(2, 4),
(3, 3),
(4, 1),
(5, 6),
(6, 7),
(7, 7);

-- Relazioni Interazione-Contenuto
INSERT INTO Interazione_Contenuto (id_interazione, id_contenuto, ruolo) VALUES
(1, 1, 'include'),
(2, 2, 'include'),
(3, 3, 'include'),
(4, 4, 'include'),
(5, 5, 'include'),
(6, 6, 'include'),
(7, 7, 'include');

-- Relazioni Preferenze-Contenuto
INSERT INTO Preferenze_Contenuto (id_utente, id_contenuto, tipo_influenza) VALUES
(1, 1, 'Preferenza contenuti tecnici visuali'),
(2, 2, 'Supporto audio per rilassamento'),
(3, 3, 'Stimolo creativo attraverso video dinamici'),
(4, 4, 'Ausilio didattico per memorizzazione'),
(5, 5, 'Documentazione professionale dettagliata'),
(6, 6, 'Ispirazione estetica e trend awareness'),
(7, 7, 'Riferimento pronuncia e fonetica accurata');