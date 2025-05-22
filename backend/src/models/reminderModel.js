const mongoose=require('mongoose');

const reminderSchema = new mongoose.Schema ({ 
    title: { type: String, required: true }, 
    description: {type: String}, 
    category: {type: String, default: 'General'},
    dateTime: { type: Date, required: true }, 
    snoozeDuration: {type: Number, default: 5}, 
    notified: { type: Boolean, default: false }, 
    createdAt: { type: Date, default: Date.now}, 
}); 

module.exports = mongoose.model('Reminder', reminderSchema);
