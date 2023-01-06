import express from 'express'
import logger from 'morgan'
import { notFound, errorHandler } from './middleware/errorMiddleware.js'
const app = express()

app.use(express.json())

app.use(logger('dev')) // Log requests to API using morgan

app.get('/', (req, res) => {
  res.status(200).send('API is running....')
})

app.get('/foo', (req, res) => {
  res.json({ myFavouriteColor: 'Blue' })
})

app.use(notFound)
app.use(errorHandler)
const PORT = process.env.PORT || 4000

app.listen(
  PORT,
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`)
)
