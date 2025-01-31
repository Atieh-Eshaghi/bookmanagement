const express = require('express')
const multer = require('multer')
const cors = require('cors')
const fs = require('fs')
const path = require('path')
const { MongoClient, ObjectId } = require('mongodb')

const app = express()
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Create uploads/images directory if not exists
const uploadsDir = path.join(__dirname, 'uploads', 'images')
if (!fs.existsSync(uploadsDir)) {
    fs.mkdirSync(uploadsDir, { recursive: true })
}

// Configure multer
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/images')
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
        cb(null, uniqueSuffix + '-' + file.originalname)
    }
})
const upload = multer({ storage })

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
app.post('/register/', async (req, res) => {
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
app.post('/login/', async (req, res) => {
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
app.get('/profile/:userId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
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
app.put('/profile/:userId/', async (req, res) => {
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

// دریافت همه کتاب‌ها
app.get('/books/', async (req, res) => {
    try {
        const db = await dbPromise
        const books = await db.collection('books').find({ buyer: null }).toArray()
        if (books.length === 0) {
            return res.status(404).json({ error: 'Books not found.' })
        }
        for (let book of books) {
            const owner = await db.collection('users').findOne({ _id: book.owner })
            book.owner = owner
        }
        res.status(200).json(books)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// دریافت یک کتاب
app.get('/books/:bookId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { bookId } = req.params
        const book = await db.collection('books').findOne({ _id: new ObjectId(bookId) })
        if (!book) {
            return res.status(404).json({ error: 'Book not found.' })
        }
        book.owner = await db.collection('users').findOne({ _id: book.owner })
        book.buyer = book.buyer ? await db.collection('users').findOne({ _id: book.buyer }) : null
        return res.json(book)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// دریافت کتاب های من
app.get('/books/my-books/:userId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        const books = await db.collection('books').find({ owner: user._id }).toArray()
        if (books.length === 0) {
            return res.status(404).json({ error: 'Books not found.' })
        }
        for (let book of books) {
            book.owner = user
            book.buyer = book.buyer ? await db.collection('users').findOne({ _id: book.buyer }) : null
        }
        res.status(200).json(books)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// دریافت کتاب‌های خریداری شده
app.get('/books/bought-books/:userId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        const books = await db.collection('books').find({ buyer: user._id }).toArray()
        if (books.length === 0) {
            return res.status(404).json({ error: 'Books not found.' })
        }
        for (let book of books) {
            book.owner = await db.collection('users').findOne({ _id: book.owner })
            book.buyer = user
        }
        res.status(200).json(books)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// افزودن کتاب
app.post('/books/', upload.single('image'), async (req, res) => {
    try {
        const db = await dbPromise
        const { title, price, genre, pageCount, author, userId } = req.body
        if (!title || !price || !genre || !pageCount || !author || !userId) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }

        if (!req.file) {
            return res.status(400).json({ error: 'Image is required.' })
        }
        const imagePath = `/uploads/images/${req.file.filename}`

        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        const result = await db.collection('books').insertOne({ title, price, genre, pageCount, author, image: imagePath, owner: user._id, buyer: null })
        return res.json({ bookId: result.insertedId })

    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// ویرایش کتاب
app.put('/books/:bookId/', upload.single('image'), async (req, res) => {
    try {
        const db = await dbPromise
        const { bookId } = req.params
        const { title, price, genre, pageCount, author, userId } = req.body
        if (!title || !price || !genre || !pageCount || !author || !userId) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }

        const book = await db.collection('books').findOne({ _id: new ObjectId(bookId) })
        if (!book) {
            return res.status(404).json({ error: 'Book not found.' })
        }
        if (book.owner.toString() !== userId) {
            return res.status(401).json({ error: 'You are not authorized to edit this book.' })
        }

        let imagePath = book.image
        if (req.file) {
            imagePath = `/uploads/images/${req.file.filename}`
        }

        result = await db.collection('books').updateOne({ _id: new ObjectId(bookId) }, { $set: { title, price, genre, pageCount, author, image: imagePath } })
        if (result.modifiedCount === 0) {
            return res.status(500).json({ error: 'Failed to update book.' })
        }
        return res.json({ message: 'Book updated successfully.' })
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// حذف کتاب
app.delete('/books/:bookId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { bookId } = req.params
        const book = await db.collection('books').findOne({ _id: new ObjectId(bookId) })
        if (!book) {
            return res.status(404).json({ error: 'Book not found.' })
        }
        result = await db.collection('books').deleteOne({ _id: new ObjectId(bookId) })
        if (result.deletedCount === 0) {
            return res.status(500).json({ error: 'Failed to delete book.' })
        }
        return res.json({ message: 'Book deleted successfully.' })
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// خرید کتاب
app.put('/books/buy/:userId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.params
        const { booksId } = req.body
        if (!booksId || booksId.length === 0) {
            return res.status(400).json({ error: 'Please fill all fields.' })
        }
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        const books = await db.collection('books').find({ _id: { $in: booksId.map(id => new ObjectId(id)) } }).toArray()
        if (books.length === 0) {
            return res.status(404).json({ error: 'Books not found.' })
        }
        if (books.some(book => book.owner.toString() === userId || book.buyer)) {
            return res.status(400).json({ error: 'You can not buy your own books or books that have been sold.' })
        }
        const result = await db.collection('books').updateMany({ _id: { $in: booksId.map(id => new ObjectId(id)) } }, { $set: { buyer: user._id } })
        if (result.modifiedCount === 0) {
            return res.status(500).json({ error: 'Failed to buy books.' })
        }
        const order = await db.collection('orders').insertOne({ buyer: user._id, books: books.map(book => book._id), createdAt: Date.now() })
        if (order.insertedCount === 0) {
            return res.status(500).json({ error: 'Failed to create order.' })
        }
        return res.json({ orderId: order.insertedId })
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// دریافت سفارشات
app.get('/orders/', async (req, res) => {
    try {
        const db = await dbPromise
        const { userId } = req.body
        const user = await db.collection('users').findOne({ _id: new ObjectId(userId) })
        if (!user) {
            return res.status(404).json({ error: 'User not found.' })
        }
        const orders = await db.collection('orders').find({ buyer: user._id }).toArray()

        for (let order of orders) {
            order.books = await db.collection('books').find({ _id: { $in: order.books } }).toArray()
        }
        res.status(200).json(orders)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// دریافت جزئیات سفارش
app.get('/orders/:orderId/', async (req, res) => {
    try {
        const db = await dbPromise
        const { orderId } = req.params
        const order = await db.collection('orders').findOne({ _id: new ObjectId(orderId) })
        if (!order) {
            return res.status(404).json({ error: 'Order not found.' })
        }
        order.books = await db.collection('books').find({ _id: { $in: order.books } }).toArray()
        return res.json(order)
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

const PORT = 3000
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`)
})
