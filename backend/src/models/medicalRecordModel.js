const mongoose = require('mongoose');

const medicalRecordSchema = new mongoose.Schema(
  {
    firebaseUID: {
      type: String,
      required: true,
      index: true,
    },
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      default: '',
    },
    category: {
      type: String,
      required: true,
      enum: [
        allergies,
        prescription,
        medical_history,
        hospitalzations,
        vaccinations,
        procedure,
        test_reports,
        doctor_Contact
      ],
    },
    processedText: {
      type: String,
      required: true,
    },
    fileData: {
      data: Buffer,
      contentType: String,
      originalFilename: String,
    },
    fileType: {
      type: String,
      required: true,
      enum: ['image', 'pdf', 'document'],
    },
  },
  { timestamps: true }
);

medicalRecordSchema.index({ firebaseUID: 1, category: 1 });

const MedicalRecord = mongoose.model(
  'MedicalRecord', medicalRecordSchema, 'medicalRecords'
);

module.exports = MedicalRecord;