/*Creare database*/
CREATE DATABASE compito_esame_sql;

/*1-Includere nel database tutte le tabelle necessarie + 2-Definire le colonne necessarie per ciascuna tabella e assicurarsi di includere chiavi primarie e
chiavi esterne per stabilire le relazioni tra le tabelle */
CREATE TABLE Evento (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    data_inizio DATETIME,
    descrizione TEXT,
    costo FLOAT
);

CREATE TABLE Luogo (
    luogo_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    indirizzo TEXT,
    capacita INT
);

CREATE TABLE Partecipante (
    partecipante_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(15) NOT NULL,
    cognome VARCHAR(15) NOT NULL,
    email VARCHAR(30),
    telefono INT, 
    data_nascita DATE
);

CREATE TABLE EventoPartecipante (  
    EventoPartecipante_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT,
    partecipante_id INT,
    luogo_id INT,
    FOREIGN KEY (evento_id) REFERENCES Evento(evento_id),
    FOREIGN KEY (partecipante_id) REFERENCES Partecipante(partecipante_id),
    FOREIGN KEY (luogo_id) REFERENCES Luogo(luogo_id)
);

/*3-Popolare il database con dati di esempio. È consigliato inserire circa 10 record per ognuna di
esse*/
INSERT INTO Evento (nome, data_inizio, descrizione, costo) 
VALUES 
    ("Conferenza IT 2023", "2023-10-27 10:00:00", "Una conferenza sugli ultimi sviluppi in IT", 100.50),
    ("Festival Musicale", "2023-11-15 15:30:00", "Un festival musicale di tre giorni", 50.00),
    ("Corso di Cucina Italiana", "2023-11-05 18:00:00", "Impara a cucinare autentici piatti italiani", 75.99),
    ("Fiera del Libro", "2023-12-01 09:45:00", "Una fiera del libro con autori famosi", 25.00),
    ("Seminario di Marketing", "2023-10-28 14:15:00", "Strategie di marketing moderne", 80.00),
    ("Mostra d'Arte Contemporanea", "2023-11-10 11:30:00", "Opere d'arte moderne in esposizione", 30.00),
    ("Concerto Jazz", "2023-11-20 20:00:00", "Una serata di musica jazz dal vivo", 45.00),
    ("Festa di Compleanno", "2023-12-10 19:00:00", "Celebrazione del compleanno di Alice", 20.00),
    ("Conferenza Medica", "2023-10-30 08:00:00", "Aggiornamenti in medicina e salute", 60.00),
    ("Fiera del Fitness", "2023-11-08 16:45:00", "Prodotti e servizi per il fitness", 15.00);

INSERT INTO Luogo (nome, indirizzo, capacita) 
VALUES 
    ("Centro Congressi", "Via Roma, Città", 500),
    ("Piazza Principale", "Piazza Italia, Città", 1000),
    ("Scuola di Cucina", "Via delle Stelle, Città", 50),
    ("Centro Esposizioni", "Via dei Libri, Città", 300),
    ("Sala Conferenze", "Via del Marketing, Città", 200),
    ("Galleria d'Arte", "Via dell'Arte, Città", 100),
    ("Teatro Jazz", "Via della Musica, Città", 400),
    ("Ristorante Locale", "Via dei Sapori, Città", 80),
    ("Ospedale Cittadino", "Via della Salute, Città", 1000),
    ("Palestra Fitness", "Via del Fitness, Città", 150);

INSERT INTO Partecipante (nome, cognome, email, telefono, data_nascita) 
VALUES 
    ("Mario", "Rossi", "mario.rossi@email.com", 123456789, "1980-05-15"),
    ("Anna", "Bianchi", "anna.bianchi@email.com", 234567890, "1985-03-20"),
    ("Luca", "Verdi", "luca.verdi@email.com", 345678901, "1990-08-10"),
    ("Giulia", "Gallo", "giulia.gallo@email.com", 456790123, "1982-12-02"),
    ("Laura", "Ferrari", "laura.ferrari@email.com", 578901234, "1975-10-01"),
    ("Antonio", "Neri", "antonio.neri@email.com", 679012345, "1988-07-08"),
    ("Elena", "Mancini", "elena.mancini@email.com", 890123456, "1977-06-12"),
    ("Roberto", "Russo", "roberto.russo@email.com", 901234567, "1991-04-23"),
    ("Giovanna", "Greco", "giovanna.greco@email.com", 912345678, "1989-11-30"),
    ("Francesco", "Conti", "francesco.conti@email.com", 134567890, "1987-09-25");

INSERT INTO EventoPartecipante (evento_id, partecipante_id, luogo_id) 
VALUES 
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);

/*1-Elenca tutti gli eventi in programma.*/
SELECT * FROM Evento;

/*2-Trova il nome completo di tutti i partecipanti registrati per un evento specifico (tramite id).*/
SELECT CONCAT(Partecipante.nome, " ", Partecipante.cognome) AS Nome_Completo
FROM EventoPartecipante
INNER JOIN Partecipante ON EventoPartecipante.partecipante_id = Partecipante.partecipante_id
WHERE EventoPartecipante.evento_id = 6;

/*3-Visualizza tutti i nomi e le date degli eventi ai quali un partecipante specifico è registrato
(tramite id).*/
SELECT Evento.nome AS Nome_Evento, Evento.data_inizio AS Data_Inizio
FROM Evento
INNER JOIN EventoPartecipante ON Evento.evento_id = EventoPartecipante.evento_id
WHERE EventoPartecipante.partecipante_id = 4;

/*4-Trova il numero totale di partecipanti registrati per ciascun evento (visualizzare solo il nome
dell'evento).*/
SELECT Evento.nome AS Nome_Evento, COUNT(EventoPartecipante.partecipante_id) AS Numero_Partecipanti
FROM Evento
LEFT JOIN EventoPartecipante ON Evento.evento_id = EventoPartecipante.evento_id
GROUP BY Evento.nome;

/*5-Elenca, ordinati per cognome e nome, il nome, cognome e data di nascita (formattata come
giorno, mese ed anno) di tutti i partecipanti che si sono registrati per almeno un evento.*/
SELECT Partecipante.nome, Partecipante.cognome, DATE_FORMAT(Partecipante.data_nascita, "%d/%m/%Y") AS Data_Nascita
FROM Partecipante
INNER JOIN EventoPartecipante ON Partecipante.partecipante_id = EventoPartecipante.partecipante_id
ORDER BY Partecipante.cognome, Partecipante.nome;

/*6-Trova il luogo in cui si svolgerà un evento specifico (tramite id).*/
SELECT Luogo.luogo_id, Luogo.nome, Luogo.indirizzo, Luogo.capacita
FROM Luogo
JOIN EventoPartecipante ON Luogo.luogo_id = EventoPartecipante.luogo_id
WHERE EventoPartecipante.evento_id = 1;

/*7-Visualizza il nome e l'ora di inizio degli eventi previsti per una data specifica.*/
SELECT Evento.nome AS Nome_Evento, TIME(Evento.data_inizio) AS Ora_Inizio
FROM Evento
WHERE DATE(Evento.data_inizio) = "2023-11-15";

/*8-Elenca tutti i partecipanti che si sono registrati per un numero minimo di eventi (ad esempio 3).*/
SELECT Partecipante.nome, Partecipante.cognome, COUNT(EventoPartecipante.evento_id) AS Numero_Eventi_Registrati
FROM Partecipante
LEFT JOIN EventoPartecipante ON Partecipante.partecipante_id = EventoPartecipante.partecipante_id
GROUP BY Partecipante.partecipante_id
HAVING COUNT(EventoPartecipante.evento_id) = 3;

/*9-Trova l'evento con il maggior numero di partecipanti registrati (utilizzare LIMIT 1).*/
SELECT Evento.evento_id, Evento.nome AS Nome_Evento, COUNT(EventoPartecipante.partecipante_id) AS Numero_Partecipanti_Registrati
FROM Evento
LEFT JOIN EventoPartecipante ON Evento.evento_id = EventoPartecipante.evento_id
GROUP BY Evento.evento_id, Evento.nome
ORDER BY Numero_Partecipanti_Registrati DESC
LIMIT 1;

/*10-Visualizza nome, data, descrizione e costo di tutti gli eventi che si terranno in un determinato
luogo (tramite id).*/
SELECT Evento.nome, Evento.data_inizio, Evento.descrizione, Evento.costo
FROM Evento
JOIN EventoPartecipante ON Evento.evento_id = EventoPartecipante.evento_id
WHERE EventoPartecipante.luogo_id = 10;