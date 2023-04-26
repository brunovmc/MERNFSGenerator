#!/bin/bash

if [ -z "$1" ]
then
    read -p "Please provide a main file name: " main_file_name
    if [ -z "$main_file_name" ]
    then
        echo "Error: Must provide a directory name"
        exit 1
    fi
else
    main_file_name=$1
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

mkdir $main_file_name
cd $main_file_name

npm init -y

npm install -g create-react-app

mkdir client server
cd client
npm init -y
npx create-react-app $main_file_name"reactApp"
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

mongoose.connect('mongodb://localhost:27017/$main_file_name', { useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true });
const connection = mongoose.connection;
connection.once('open', () => {
  console.log('MongoDB database connection established successfully');
});

app.listen(port, () => {
  console.log('Server is running on port: ' + port);
});" >> index.js

echo "Basic MERN stack file structure created successfully!"
