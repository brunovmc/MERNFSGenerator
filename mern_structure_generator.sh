#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Please provide a main file name"
    exit 1
fi

if [ $# -gt 1 ]
  then
    if ! [ -d "$2" ]
      then
        echo "Invalid path, creating in current directory"
      else
        cd $2
    fi
fi

mkdir $1
cd $1

mkdir client server
cd client
npx create-react-app .
cd ..
cd server
npm init -y
npm install express cors mongoose

touch index.js

echo "const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/$1', { useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true });
const connection = mongoose.connection;
connection.once('open', () => {
  console.log('MongoDB database connection established successfully');
});

app.listen(port, () => {
  console.log('Server is running on port: ' + port);
});" >> index.js

cd ../client

echo "Adding a React app using create-react-app..."
npx create-react-app .

cd ../..

echo "Basic MERN stack file structure created successfully!"