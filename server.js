const express = require('express')
const { MongoClient, ObjectId } = require('mongodb')
const cors = require('cors')

const app = express()
app.use(cors())
app.use(express.json())

// تنظیمات اتصال به MongoDB
const url = 'mongodb://localhost:27017'
const client = new MongoClient(url)
const dbName = 'bookstore'

async function connectDB() {
    await client.connect()
    console.log('Connected to MongoDB')
    return client.db(dbName)
}

const dbPromise = connectDB()

// ثبت‌نام کاربر
app.post('/register', async (req, res) => {
    try {
        const db = await dbPromise
        const { name, username, password } = req.body
        if (!name || !username || !password) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }
        const user = await db.collection('users').findOne({ username })
        if (user) {
            return res.status(400).json({ error: 'Username already exists.' })
        }
        const result = await db.collection('users').insertOne({ name, username, password })

        return res.json({ userId: result.insertedId })
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// ورود کاربر
app.post('/login', async (req, res) => {
    try {
        const db = await dbPromise
        const { username, password } = req.body
        if (!username || !password) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }
        const user = await db.collection('users').findOne({ username, password })
        if (!user) {
            return res.status(401).json({ error: 'Invalid username or password.' })
        }
        return res.json({ userId: user._id })
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// پروفایل کاربر
app.get('/profile/:userId', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
        console.log(userId)
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        return res.json(user)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// ویرایش پروفایل کاربر
app.put('/profile/:userId', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
        const { name, password } = req.body
        if (!name || !password) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        result = await db.collection('users').updateOne({ _id: new ObjectId(userId) }, { $set: { name, password } })
        if (result.modifiedCount === 0) {
            return res.status(500).json({ error: 'Failed to update user.' })
        }
        return res.json({ message: 'User updated successfully.' })        
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

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
