const Blink = require('node-blink-security');

var blink = new Blink(process.env.BLINK_USERNAME, process.env.BLINK_PASSWORD);
blink.setupSystem().then(
  () => {
    blink.setArmed().then(() => {
      // see the object dump for details
      console.log(blink);
    });
  },
  error => {
    console.log(error);
  },
);
