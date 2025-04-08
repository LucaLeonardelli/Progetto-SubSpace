import express from 'express';
import dotenv from 'dotenv';

// Carica le variabili d'ambiente dal file .env
dotenv.config();

const app = express();
app.use(express.json());

// Rotta di test
app.get('/', (req, res) => {
  res.send('Il backend è attivo e funzionante!');
});

// Esporta l'app per il server
export default app;