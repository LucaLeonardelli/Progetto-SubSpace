import app from './app';

// Imposta la porta dal file .env o usa 3000 di default
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server avviato su http://localhost:${PORT}`);
});
