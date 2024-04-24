const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Storage } = require('@google-cloud/storage');
const os = require('os');
const path = require('path');
const Busboy = require('busboy');

admin.initializeApp();

// Initialize Cloud Storage
const storage = new Storage();
const bucket = storage.bucket('your-bucket-name');

// Function to handle file upload
// exports.uploadFile = functions.https.onRequest((req, res) => {ls

//   if (req.method !== 'POST') {
//     return res.status(405).send('Method Not Allowed');
//   }

//   const busboy = new Busboy({ headers: req.headers });

//   const fields = {};
//   const uploads = {};

//   busboy.on('field', (fieldname, val) => {
//     fields[fieldname] = val;
//   });

//   busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
//     const filepath = path.join(os.tmpdir(), filename);
//     uploads[fieldname] = { file: filepath, type: mimetype };
//     file.pipe(fs.createWriteStream(filepath));
//   });

//   busboy.on('finish', () => {
//     for (const file in uploads) {
//       const upload = uploads[file];
//       const destination = `uploads/${Date.now()}-${path.basename(upload.file)}`;
//       bucket.upload(upload.file, {
//         destination: destination,
//         metadata: {
//           contentType: upload.type,
//         },
//       });
//     }
//     res.send('File uploaded successfully!');
//   });

//   busboy.end(req.rawBody);
// });



// Function to handle file upload
exports.uploadFile = functions.https.onRequest((req, res) => {
  if (req.method !== 'GET') {
    return res.status(405).send('Method Not Allowed');
  }
  return res.send("HELLO WORLD")
});

