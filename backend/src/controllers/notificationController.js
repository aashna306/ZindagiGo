const admin = require('firebase-admin');

const sendNotification = async (reminder) =>{
    const message = {
        notification: {
            title: 'Reminder',
            body: `${reminder.title} is due now!`,
        },
        topic: 'reminders',//fcm token
    };

    try{
        await admin.messaging().send(message);
        console.log('Notification sent successfully');
    } catch (error){
        console.log('Error sending notification: ',error);
    }
};

module.exports = sendNotification;
