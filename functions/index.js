const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const quotes = [
  "The Great Pyramids of Giza: Built over 4,500 years ago.",
  "Abu Simbel: Built by Ramses II in the 13th century BCE.",
  "The Sphinx: Carved out of limestone",
  "The Temple of Edfu: Dedicated to the falcon god Horus",
  "The Mosque of Ibn Tulun: Built in the 9th century",
];
exports.scheduleNotification=functions.pubsub.schedule("0 21 * * *")
    .timeZone("Etc/GMT")
    .onRun((context) => {
      const randomQuote=quotes[Math.floor(Math.random()*quotes.length)];
      const payload={
        notification: {
          title: "Visit Egypt",
          body: randomQuote,
        },
      };
      const options = {
        priority: "high",
        timeToLive: 60*60*24,
      };

      // Send the notification to the topic
      return admin.messaging()
          .sendToTopic("egypt-history-topic", payload, options)
          .then(() => console.log("Notification sent successfully"))
          .catch((error) => console.error("Error sending", error));
    },
    )
;
