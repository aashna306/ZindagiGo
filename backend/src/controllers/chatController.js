const { GoogleGenerativeAI } = require("@google/generative-ai");
require('dotenv').config();
const axios = require("axios");

const LIBRE_TRANSLATE_API = process.env.LIBRE_TRANSLATE_API;
GEMINI_API = process.env.GEMINI_API;
const genAI = new GoogleGenerativeAI(GEMINI_API);


const getChatResponse = async (req, res) => {
    const { message,targetLang } = req.body;
    if (!message) {
        return res.status(400).json({error: 'Message is required'});
    }
    try {
        const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash" });
        const result = await model.generateContent(message);
        let botReply = result.response.text() || "Sorry, I couldn't understand that.";
        if(targetLang){
            botReply = await translateText(botReply,targetLang);
        }
        res.json({reply: botReply});
    } 
    catch (error) {
        console.error('Error fetching chatbot response:', error.message);
        res.status(500).json({ error: 'Failed to get chatbot response' });
    }
};

const { translate } = require('@vitalets/google-translate-api');



const translateText = async (text, targetLang) => {
    try {
        const response = await translate(text, { to: targetLang });
        console.log("Translated Text:", response.text); 
        return response.text;
    } catch (error) {
        console.error("Error translating text:", error.message);
        return text;
    }
};



module.exports = { getChatResponse };
