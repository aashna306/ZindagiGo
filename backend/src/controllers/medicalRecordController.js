const MedicalRecord = require('../models/medicalRecordModel');
const { GoogleGenerativeAI } = require('@google/generative-ai');
const multer = require('multer');
const { v4: uuidv4 } = require('uuid');
const admin = require('firebase-admin');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

const storage = multer.memoryStorage();

const fileFilter = (req, file, cb) => {
  console.log('Received file with mimetype:', file.mimetype);
  if (
    file.mimetype.startsWith('image/') ||
    file.mimetype === 'application/pdf' ||
    file.mimetype === 'application/msword' ||
    file.mimetype === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'||
    file.mimetype === 'application/octet-stream' 
  ) {
    cb(null, true);
  } else {
    cb(new Error('Unsupported file type'), false);
  }
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: { fileSize: 10 * 1024 * 1024 },
});

async function categorizeText(text) {
  try {
    const prompt = `
    You are a medical assistant AI.

    Categorize the following medical record text into one of these categories:
    - Allergies
    - Prescriptions
    - Medical History
    - Hospitalizations
    - Vaccinations
    - Procedures
    - Test Reports
    - Dr s Contacts
    
    Respond with ONLY the category name, nothing else. Make sure to choose the best option out of these which fits.
    Only respond with the **category name**, in lowercase, and nothing else — no explanations.
    Medical record text:
    ${text}
    `;

    const result = await model.generateContent(prompt);
    const response = await result.response;
    const rawCategory = await response.text();

    const validCategories = [
      'Allergies',
        'Prescriptions',
        'Medical History',
        'Hospitalizations', 
        'Vaccinations',
        'Procedures',
        'Test Reports',
        'Dr s Contacts',
    ];

   const category = validCategories.find((cat) =>
  cat.toLowerCase() === rawCategory.trim().toLowerCase()
);


    return category || 'Medical History';
  } catch (error) {
    console.error('Error categorizing text:', error);
    return 'Medical History';
  }
}

const verifyToken = async (req, res, next) => {
  try {
    const idToken = req.headers.authorization?.split('Bearer ')[1];
    
    if (!idToken) {
      return res.status(401).json({ error: 'No token provided' });
    }
    
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    req.user = decodedToken;
    next();
  } catch (error) {
    console.error('Error verifying token:', error);
    res.status(401).json({ error: 'Invalid token' });
  }
};

exports.uploadMedicalRecord = [
  verifyToken,
  upload.single('file'),
  async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ success: false, message: 'No file uploaded' });
      }

      const { title, description, processedText } = req.body;
      // const firebaseUID = req.user.uid;
const firebaseUID = req.body.firebaseUID || req.user.uid;

      if (!title || !processedText) {
        return res.status(400).json({
          success: false,
          message: 'Missing required fields: title and processedText are required',
        });
      }

      let fileType;
      if (req.file.mimetype.startsWith('image/')) {
        fileType = 'image';
      } else if (req.file.mimetype === 'application/pdf') {
        fileType = 'pdf';
      } else {
        fileType = 'document';
      }

      const category = await categorizeText(processedText);

      const newMedicalRecord = new MedicalRecord({
        firebaseUID,
        title,
        description: description || '',
        category,
        processedText,
        fileData: {
          data: req.file.buffer,
          contentType: req.file.mimetype,
          originalFilename: req.file.originalname,
        },
        fileType,
      });

      await newMedicalRecord.save();

      res.status(201).json({
        success: true,
        message: 'Medical record uploaded successfully',
        data: newMedicalRecord,
      });
    } catch (error) {
      console.error('Error in uploadMedicalRecord:', error);
      res.status(500).json({
        success: false,
        message: 'Error uploading medical record',
        error: error.message,
      });
    }
  },
];

exports.getMedicalRecords = [
  verifyToken,
  async (req, res) => {
    try {
      // const firebaseUID = req.user.uid;
      const firebaseUID = req.query.firebaseUID || req.user.uid;

      const { category } = req.query;

      let query = { firebaseUID };

      if (category) {
        query.category = new RegExp('^' + category + '$', 'i'); //case-insensitive
      }
 
    console.log("==== Fetch Medical Records ====");
console.log("Logged-in UID from token:", req.user.uid);
console.log("Requested firebaseUID:", req.query.firebaseUID);
console.log("Category:", req.query.category);
      const records = await MedicalRecord.find(query).sort({ createdAt: -1 });
console.log("Total records fetched:", records.length);
console.log("Query used:", query);

      res.status(200).json({
        success: true,
        count: records.length,
        data: records,
      });




    } catch (error) {
      console.error('Error in getMedicalRecords:', error);
      res.status(500).json({
        success: false,
        message: 'Error retrieving medical records',
        error: error.message,
      });
    }
  },
];

exports.getMedicalRecordById = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;
      const record = await MedicalRecord.findOne({
        _id: req.params.id,
        firebaseUID: firebaseUID,
      });

      if (!record) {
        return res.status(404).json({
          success: false,
          message: 'Medical record not found',
        });
      }

      res.status(200).json({
        success: true,
        data: record,
      });
    } catch (error) {
      console.error('Error in getMedicalRecordById:', error);
      res.status(500).json({
        success: false,
        message: 'Error retrieving medical record',
        error: error.message,
      });
    }
  },
];

exports.updateMedicalRecord = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;
      const { title, description, category } = req.body;

      const updateData = {};
      if (title) updateData.title = title;
      if (description !== undefined) updateData.description = description;
      if (category) updateData.category = category;
      updateData.updatedAt = Date.now();

      const record = await MedicalRecord.findOneAndUpdate(
        { _id: req.params.id, firebaseUID: firebaseUID },
        updateData,
        { new: true, runValidators: true }
      );

      if (!record) {
        return res.status(404).json({
          success: false,
          message: 'Medical record not found or not authorized',
        });
      }

      res.status(200).json({
        success: true,
        message: 'Medical record updated successfully',
        data: record,
      });
    } catch (error) {
      console.error('Error in updateMedicalRecord:', error);
      res.status(500).json({
        success: false,
        message: 'Error updating medical record',
        error: error.message,
      });
    }
  },
];

exports.deleteMedicalRecord = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;
      const record = await MedicalRecord.findOne({
        _id: req.params.id,
        firebaseUID: firebaseUID,
      });

      if (!record) {
        return res.status(404).json({
          success: false,
          message: 'Medical record not found or not authorized',
        });
      }

      await MedicalRecord.findByIdAndDelete(record._id);

      res.status(200).json({
        success: true,
        message: 'Medical record deleted successfully',
      });
    } catch (error) {
      console.error('Error in deleteMedicalRecord:', error);
      res.status(500).json({
        success: false,
        message: 'Error deleting medical record',
        error: error.message,
      });
    }
  },
];

exports.getCategoryCounts = [
  verifyToken,
  async (req, res) => {
    try {
      const firebaseUID = req.user.uid;

      const categoryCounts = await MedicalRecord.aggregate([
        { $match: { firebaseUID: firebaseUID } },
        { $group: { _id: '$category', count: { $sum: 1 } } },
        { $sort: { _id: 1 } },
      ]);

      res.status(200).json({
        success: true,
        data: categoryCounts,
      });
    } catch (error) {
      console.error('Error in getCategoryCounts:', error);
      res.status(500).json({
        success: false,
        message: 'Error retrieving category counts',
        error: error.message,
      });
    }
  },
];
