const Blink = require('node-blink-security');

const blink = new Blink(process.env.BLINK_USERNAME, process.env.BLINK_PASSWORD);
blink.setupSystem().then(
  () => {
    blink.getSummary().then((response) => {
      // see the object dump for details
//console.log('response', response);
      console.log(blink);
    });
  },
  error => {
    console.log(error);
  },
);
