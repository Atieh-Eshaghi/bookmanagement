const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// تنظیمات اتصال به MongoDB
const url = 'mongodb://localhost:27017';
const client = new MongoClient(url);
const dbName = 'bookstore';

async function connectDB() {
    await client.connect();
    console.log('Connected to MongoDB');
    return client.db(dbName);
}

const dbPromise = connectDB();

// ثبت‌نام کاربر
app.post('/register', async (req, res) => {
    try {
        const db = await dbPromise;
        const { name } = req.body;
        const result = await db.collection('users').insertOne({ name });
        res.json({ message: 'User registered successfully.', userId: result.insertedId });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// افزودن کتاب
app.post('/addBook', async (req, res) => {
    try {
        const db = await dbPromise;
        const { title, price, owner, Bby } = req.body;
        const result = await db.collection('books').insertOne({ title, price, owner, Bby });
        res.status(200).json({ message: 'Book added successfully', bookId: result.insertedId });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// دریافت همه کتاب‌ها
app.get('/books/all', async (req, res) => {
    try {
        const db = await dbPromise;
        const books = await db.collection('books').find({ Bby: -1 }).toArray();
        res.status(200).json(books);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// جستجوی کتاب‌ها
app.get('/books/search', async (req, res) => {
    try {
        const db = await dbPromise;
        const { title } = req.query;
        const books = await db.collection('books').find({ title: new RegExp(title, 'i') }).toArray();
        res.status(200).json(books);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
