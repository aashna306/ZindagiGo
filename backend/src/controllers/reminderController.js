const Reminder = require('../models/reminderModel');
const schedule = require('node-schedule');
const sendNotification = require('./notificationController');

exports.saveReminder = async (req,res) =>{
    const {title,description,category,dateTime,snoozeDuration} = req.body;
    try{
        const reminder = new Reminder({
            title,
            description,
            category,
            dateTime,
            snoozeDuration,
        });

        await reminder.save();

        schedule.scheduleJob(new Date(reminder.dateTime), async () => {
            await sendNotification(reminder);
            reminder.notified = true;
            await reminder.save();
        });
        
        res.status(200).json(reminder);
    } catch (error){
        res.status(500).json({ error: 'Failed to save the reminder'});
    }
};

exports.scheduleReminders = async() =>{
    const reminders = await Reminder.find({notified:false});

    reminders.forEach((reminder) => {
        const job = schedule.scheduleJob(new Date(reminder.dateTime), async()=>{
            await sendNotification(reminder);
            reminder.notified = true;
            await reminder.save();
        });
    });
};
